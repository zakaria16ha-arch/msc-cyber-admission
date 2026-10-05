# Exercice 02 – Active Directory

## Environnement
Windows Server 2022 sur une VM Azure (Azure for Students), car un Mac M4 ne peut pas faire tourner Windows Server. Connexion en RDP avec Windows App.

## Scripts
- 01-Install-AD.ps1 : installe le rôle AD DS et crée le domaine laplateforme.io (le serveur redémarre).
- 02-Import-Users.ps1 : crée les OU, les groupes et les utilisateurs depuis users.csv.

## Exécution
Dans PowerShell en administrateur :
- Set-ExecutionPolicy -Scope Process Bypass -Force
- C:\Scripts\01-Install-AD.ps1
- C:\Scripts\02-Import-Users.ps1 (après le redémarrage)

## Résultat
- 17 utilisateurs (identifiant prenom.nom) et 16 groupes.
- Chaque utilisateur est ajouté à tous ses groupes.
- Mot de passe Azerty_2025! avec changement obligatoire à la première connexion.

## Choix
- Ligne THILLOT coupée dans le sujet : corrigée dans le CSV.
- Deux ISABELLE : l'identifiant prenom.nom évite les doublons.
- CSV lu en UTF-8 pour garder les accents.
