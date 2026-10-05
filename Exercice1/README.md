# Exercice 01 – Packet Tracer

## Réalisation
- 3 bureaux : 1 switch, 1 point d'accès Wi-Fi, 1 portable, 2 PC fixes et 1 téléphone IP chacun.
- Switches : VLAN 1 (VoIP), 10 (PC fixes), 20 (Wi-Fi), 30 (Admin), trunks sur les uplinks.
- Routeur 1941 : passerelle de chaque VLAN (router-on-a-stick), DHCP (plages .10 à .50) et NAT vers un Internet simulé (serveur 8.8.8.8).
- Wi-Fi : un SSID par bureau, sécurisé en WPA2-PSK / AES.

## Choix
- Le sujet inverse VLAN 10 et 20 entre ses deux tableaux : j'ai suivi le plan d'adressage (VLAN 10 = PC fixes, VLAN 20 = Wi-Fi).
- Ports utilisés : Fa0/1 et Fa1/1 (fibre) en trunk, Fa2/1-3/1 VoIP, Fa4/1-5/1 Wi-Fi, Fa6/1-7/1 PC fixes, Fa8/1 Admin.

## Tests
Ping inter-VLAN et accès web vers Internet : OK.

## Fichiers
- Fichier Packet Tracer (.pkt)
- R1.txt, SW1.txt, SW2.txt, SW3.txt : configurations exportées
