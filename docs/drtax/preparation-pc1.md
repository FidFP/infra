# Préparation de PC1 avant l'installation Dr.Tax

## Règle de départ

La première session sur PC1 est un audit en lecture seule. Aucun installateur,
service, port, partage, compte SQL ou donnée Dr.Tax ne doit être modifié avant la
validation de cet audit.

## Vérifications bloquantes

### Matériel et Windows

- [ ] Windows pris en charge par la version actuelle de Dr.Tax.
- [ ] Architecture 64 bits.
- [ ] Au moins 16 Go de RAM selon la configuration Dr.Tax publiée en octobre
      2026.
- [ ] Espace libre suffisant pour le programme, la base, les documents et au
      moins une sauvegarde locale temporaire.
- [ ] Toutes les mises à jour Windows installées.
- [ ] Compte administrateur disponible pour l'intervention.
- [ ] PC1 ne se met pas en veille pendant l'utilisation de PC2.

### Réseau

- [ ] PC1 et PC2 peuvent communiquer sur le réseau local.
- [ ] Le nom de PC1 est stable et résolu depuis PC2.
- [ ] Le profil réseau Windows est adapté au partage interne.
- [ ] Silicom a confirmé le VLAN et les flux autorisés.
- [ ] Une réservation DHCP existe ou sera créée pour l'interface réellement
      utilisée par PC1.
- [ ] Aucun port SQL ou Dr.Tax ne sera publié sur Internet.

### Dr.Tax et données

- [ ] Inventaire des installations Dr.Tax existantes réalisé.
- [ ] Décision de migration documentée.
- [ ] Sauvegarde complète existante vérifiée avant toute restauration.
- [ ] Numéro de licence disponible hors du dépôt Git.
- [ ] Nombre d'accès simultanés autorisé confirmé par Ringler.
- [ ] Si Snap.Share est utilisé, la conservation de `SnapShare.dat` est prévue.

### Base de données

- [ ] Inventaire des instances SQL/PostgreSQL existantes réalisé.
- [ ] Choix MS SQL ou PostgreSQL validé et justifié.
- [ ] Version supportée confirmée dans la documentation officielle du jour.
- [ ] Noms de l'instance et de la base arrêtés avant l'installation.
- [ ] Mot de passe de service prévu dans un gestionnaire de mots de passe, pas
      dans Git.

## Critères de choix de PC1

PC1 devrait être le poste le plus stable, disposer du meilleur stockage et
rester allumé lorsque PC2 utilise Dr.Tax. Une liaison Ethernet est préférable.
Un ordinateur portable qui quitte régulièrement le site ou se met en veille est
un mauvais candidat.

## Livrable de l'audit

L'audit doit produire un rapport comprenant :

1. prérequis satisfaits ;
2. blocages ;
3. décisions requises ;
4. changements proposés ;
5. plan de sauvegarde et de retour arrière ;
6. séquence d'installation recommandée.

