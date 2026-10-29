# Rationalisation de l'infrastructure IT

Ce dossier est la source de référence du projet de remise en ordre de
l'infrastructure informatique de la fiduciaire.

L'objectif est de construire une infrastructure simple, sûre, documentée et
maintenable, sans lancer de migration avant d'avoir compris les dépendances
existantes.

## Documents

- [Cadre de collaboration](docs/cadre-de-collaboration.md)
- [État des lieux](docs/etat-des-lieux.md)
- [Comparaison DNS public / Plesk](docs/dns-comparaison-plesk-public.md)
- [Risques et priorités](docs/risques-et-priorites.md)
- [Plan d'investigation](docs/plan-investigation.md)
- [Plan de migration des sites](docs/plan-migration-sites.md)
- [Questions ouvertes](docs/questions-ouvertes.md)
- [Registre des décisions](docs/decisions.md)
- [Procédure de migration DNS sans coupure](docs/runbooks/migration-dns-sans-coupure.md)
- [Inventaire du VPS Infomaniak](docs/serveurs/vps-infomaniak.md)
- [Installation réseau Dr.Tax](docs/drtax/README.md)

## Convention de preuve

Chaque information structurante doit être qualifiée :

- **Confirmé** : vérifié par une source technique, contractuelle ou par un accès
  direct.
- **Déclaré** : communiqué par une personne ou un prestataire, mais pas encore
  vérifié.
- **Hypothèse** : interprétation à tester.
- **Inconnu** : information nécessaire qui manque encore.

Les secrets (mots de passe, clés privées, jetons, codes de récupération) ne
doivent jamais être enregistrés dans ce dossier.

## Règles de changement

Avant une migration, un changement DNS ou l'arrêt d'un service, documenter :

1. le périmètre et les dépendances ;
2. une sauvegarde vérifiée ;
3. les tests de validation ;
4. la procédure de retour arrière ;
5. le responsable et la fenêtre d'intervention.


