# 02-Import-Users.ps1
# Cree les OU, les groupes et les utilisateurs depuis users.csv

Import-Module ActiveDirectory

$CsvPath  = "C:\Scripts\users.csv"
$Domain   = "laplateforme.io"
$DomainDN = (Get-ADDomain).DistinguishedName
$Password = ConvertTo-SecureString "Azerty_2025!" -AsPlainText -Force

# --- 1. Creation des OU : LaPlateforme > Utilisateurs / Groupes ---
$OuRoot   = "OU=LaPlateforme,$DomainDN"
$OuUsers  = "OU=Utilisateurs,$OuRoot"
$OuGroups = "OU=Groupes,$OuRoot"

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'LaPlateforme'" -SearchBase $DomainDN -SearchScope OneLevel)) {
    New-ADOrganizationalUnit -Name "LaPlateforme" -Path $DomainDN
}
foreach ($ou in "Utilisateurs", "Groupes") {
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ou'" -SearchBase $OuRoot -SearchScope OneLevel)) {
        New-ADOrganizationalUnit -Name $ou -Path $OuRoot
    }
}

# --- 2. Lecture du CSV (UTF-8 pour les accents) ---
$users = Import-Csv -Path $CsvPath -Encoding UTF8 -Header nom,prenom,g1,g2,g3,g4,g5,g6 |
         Select-Object -Skip 1

# --- 3. Creation des groupes (liste unique) ---
$groups = $users | ForEach-Object { $_.g1, $_.g2, $_.g3, $_.g4, $_.g5, $_.g6 } |
          Where-Object { $_ -and $_.Trim() } |
          ForEach-Object { $_.Trim() } |
          Sort-Object -Unique

foreach ($g in $groups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$g'")) {
        New-ADGroup -Name $g -SamAccountName $g -GroupScope Global -GroupCategory Security -Path $OuGroups
        Write-Host "Groupe cree : $g" -ForegroundColor Green
    }
}

# --- 4. Creation des utilisateurs + ajout dans leurs groupes ---
foreach ($u in $users) {
    $prenom = $u.prenom.Trim()
    $nom    = $u.nom.Trim()
    $sam    = ("$prenom.$nom").ToLower()
    if ($sam.Length -gt 20) { $sam = $sam.Substring(0, 20) }
    $fullName = "$prenom $nom"

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$sam'")) {
        New-ADUser -Name $fullName `
                   -GivenName $prenom `
                   -Surname $nom `
                   -DisplayName $fullName `
                   -SamAccountName $sam `
                   -UserPrincipalName "$sam@$Domain" `
                   -Path $OuUsers `
                   -AccountPassword $Password `
                   -ChangePasswordAtLogon $true `
                   -Enabled $true
        Write-Host "Utilisateur cree : $sam" -ForegroundColor Green
    }

    foreach ($g in @($u.g1, $u.g2, $u.g3, $u.g4, $u.g5, $u.g6)) {
        if ($g -and $g.Trim()) {
            Add-ADGroupMember -Identity $g.Trim() -Members $sam
        }
    }
}

Write-Host "Termine : $($users.Count) utilisateurs traites." -ForegroundColor Cyan
