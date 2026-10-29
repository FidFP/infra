# Installation réseau Dr.Tax

## Objectif

Mettre en place une installation Dr.Tax centralisée :

- **PC1** héberge le serveur applicatif Dr.Tax et la base de données ;
- **PC2** lance le client Dr.Tax et utilise les mêmes données ;
- il n'existe qu'un seul jeu de données de production.

## État actuel

- **Confirmé** : l'objectif est une utilisation depuis deux PC avec des données
  communes.
- **Confirmé** : F&P a la main sur les deux PC.
- **Déclaré** : Silicom administre probablement le routeur et le DHCP.
- **Inconnu** : caractéristiques de PC1 et PC2, versions Windows, RAM et espace
  libre.
- **Inconnu** : présence d'une installation SQL Server ou Dr.Tax existante.
- **Inconnu** : droits exacts de la licence pour le nombre d'accès simultanés.
- **À décider** : MS SQL Server ou PostgreSQL. La documentation Dr.Tax actuelle
  recommande PostgreSQL lorsqu'aucune autre application ne nécessite MS SQL,
  car il est plus léger et plus simple à configurer.

## Documents de travail

- [Préparation et points bloquants](preparation-pc1.md)
- [Runbook d'installation réseau](runbook-installation-reseau.md)
- [Prompt de reprise sur PC1](prompt-pc1.md)
- [Demande à Silicom](../communications/demande-silicom-drtax-reseau.md)

## Script d'audit

Le script `scripts/windows/audit-drtax-prereqs.ps1` effectue uniquement des
lectures système. Son résultat ne doit pas être commité.

Exécution depuis PowerShell :

```powershell
Set-ExecutionPolicy -Scope Process RemoteSigned
.\scripts\windows\audit-drtax-prereqs.ps1
```

Pour enregistrer localement le résultat :

```powershell
.\scripts\windows\audit-drtax-prereqs.ps1 -OutputPath .\local-audit\pc1-drtax-audit.json
```

## Sources officielles

- [Téléchargement et configuration requise Dr.Tax](https://www.drtax.ch/web/ch/fr/telechargements/drtax_office_3.0.aspx)
- [Installation réseau avec MS SQL](https://helpdesk.drtax.ch/hc/de/articles/360002837579-Netzwerk-Installation-mit-MS-SQL)
- [Conditions de licence](https://www.drtax.ch/web/ch/fr/aspect-juridique/licence-logicielle.aspx)

Les sources doivent être revérifiées au début de l'intervention, car les
versions et recommandations peuvent changer.

