# 01-Install-AD.ps1
# Installe le role AD DS et cree la foret laplateforme.io

# 1. Installation du role Active Directory + outils d'administration
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# 2. Mot de passe de restauration (DSRM), demande a l'execution
$SafeModePwd = Read-Host "Mot de passe DSRM" -AsSecureString

# 3. Creation de la foret et du domaine (le serveur redemarre a la fin)
Install-ADDSForest `
    -DomainName "laplateforme.io" `
    -DomainNetbiosName "LAPLATEFORME" `
    -InstallDns `
    -SafeModeAdministratorPassword $SafeModePwd `
    -Force
