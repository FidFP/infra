# Prompt de reprise à utiliser sur PC1

Après installation de Codex sur PC1 et clonage de ce dépôt, ouvrir le projet
local puis envoyer le prompt suivant :

> Nous préparons une installation réseau de Dr.Tax avec PC1 comme serveur et PC2
> comme client. Lis entièrement `AGENTS.md` et les documents de `docs/drtax/`.
> Commence uniquement par un audit en lecture seule de PC1. Vérifie Windows, la
> RAM, les disques, le réseau, DHCP, la résolution du nom, les installations SQL,
> PostgreSQL ou Dr.Tax existantes, les services et les ports pertinents. Tu peux
> utiliser `scripts/windows/audit-drtax-prereqs.ps1`, mais n'enregistre pas son
> résultat dans Git. Ne télécharge, n'installe et ne modifie encore rien. Fournis
> d'abord un rapport distinguant faits confirmés, blocages, décisions et actions
> proposées. Attends mon accord explicite avant la phase d'installation.

## Pendant l'intervention

- Laisser la session Windows active et déverrouillée.
- Saisir soi-même les mots de passe administrateur, SQL et numéros de licence.
- Ne pas coller de secret dans le chat ou dans un fichier du dépôt.
- Prévenir Codex avant tout redémarrage planifié.
- Après un redémarrage, rouvrir le même projet et reprendre la conversation.

## Pour PC2

Codex installé uniquement sur PC1 ne contrôle pas automatiquement PC2. Pour une
prise en charge complète, installer Codex sur PC2 et ouvrir le même dépôt, ou
suivre les étapes client préparées depuis PC1.

