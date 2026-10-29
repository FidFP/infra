# État des lieux

Dernière mise à jour : 26 octobre 2026

Ce document distingue les observations vérifiées des informations déclarées.
Il ne contient aucun secret ni détail d'accès.

## Synthèse des composants

| Composant | Situation connue | Statut de l'information | Responsable connu | Cible envisagée |
|---|---|---|---|---|
| Microsoft 365 / SharePoint Online | Utilisé pour les fichiers et les services Microsoft | Déclaré | Silicom, périmètre à clarifier | Conserver |
| Parc, imprimantes, pare-feu | Exploités par un prestataire | Déclaré | Silicom | Conserver le mandat, à clarifier |
| `whs05.komodo.ch` | Ancien serveur applicatif distant ; Dr. Tax y resterait actif | Déclaré | Silicom | Fermer après élimination de toutes les dépendances |
| Cité-Joie | Domaine, DNS et mutualisé chez Infomaniak ; accès d'une agence de design | Déclaré | À préciser | Ne pas modifier |
| `cafcis.ch` | Site vitrine statique HTML/CSS/JS, sans PHP ni base ; web sur `80.74.157.171`, DNS chez KreativMedia, courrier Microsoft 365 | Nature du site déclarée ; DNS confirmé publiquement | À préciser | Hébergement statique géré ou futur VPS |
| `caf-ems.ch` | Site vitrine statique HTML/CSS/JS, sans PHP ni base ; web sur `80.74.157.171`, DNS encore sur Komodo, courrier Microsoft 365 | Nature du site déclarée ; DNS confirmé publiquement | DNS : infrastructure Komodo/Silicom | Hébergement statique géré ou futur VPS ; DNS à sécuriser avant arrêt de Komodo |
| `fiduciairefp.ch` | Site vitrine statique HTML/CSS/JS, sans PHP ni base ; web sur `80.74.157.171`, DNS encore sur Komodo, courrier Microsoft 365 | Nature du site déclarée ; DNS confirmé publiquement | DNS : infrastructure Komodo/Silicom | Nouveau site statique ; hébergement géré ou futur VPS ; DNS à sécuriser |
| CAFAPP | Application Python avec PostgreSQL ; intégration SharePoint à concevoir | Déclaré | Interne, à préciser | Hébergement à définir |
| fpreminder | Application Python nécessitant une base de données | Déclaré | Interne, à préciser | Hébergement à définir |
| Dr. Tax | Application à sortir de Komodo ; usage par deux PC envisagé | Déclaré | Silicom / consultant Dr. Tax / interne | Projet distinct à instruire |

## Disponibilité déclarée

- Les trois sites vitrines peuvent tolérer jusqu'à environ 24 heures
  d'indisponibilité.
- CAFAPP et fpreminder sont des applications internes et peuvent également
  tolérer environ une journée d'indisponibilité.
- L'objectif de restauration provisoire (RTO) est donc de 24 heures pour ces
  cinq services.
- La perte de données acceptable (RPO) n'est pas encore définie. Elle doit être
  décidée séparément du temps d'indisponibilité.

## Charge applicative déclarée

- La synchronisation CAFAPP aura lieu une fois par nuit.
- Elle porte sur un fichier Excel BASECAF d'environ 3 000 lignes.
- CAFAPP sera utilisée une à deux fois par jour pour saisir une ou deux entrées
  en base.
- Les sites statiques devraient générer une charge très faible.
- Cette charge est compatible avec 4 Go de RAM ; l'usage réel sera surveillé
  avant toute augmentation.

## Constat DNS public du 26 octobre 2026

Les résultats ci-dessous proviennent de requêtes DNS publiques en lecture seule.
Ils décrivent la délégation visible sur Internet à cette date ; ils ne prouvent
ni la propriété contractuelle des domaines, ni l'accès aux panneaux de gestion.

| Domaine | DNS autoritaires | Adresse web racine | Messagerie |
|---|---|---|---|
| `cafcis.ch` | `ns89.kreativmedia.ch`, `ns90.kreativmedia.ch` | `80.74.157.171` | `cafcis-ch.mail.protection.outlook.com` |
| `caf-ems.ch` | `whns.komodo.ch`, `whs05.komodo.ch` | `80.74.157.171` | `cafems-ch0i.mail.protection.outlook.com` |
| `fiduciairefp.ch` | `whns.komodo.ch`, `whs05.komodo.ch` | `80.74.157.171` | `fiduciairefp-ch.mail.protection.outlook.com` |

Observations complémentaires :

- `whs05.komodo.ch` résout vers `185.62.168.35`.
- `whns.komodo.ch` résout vers `185.62.169.52`.
- Le SOA de `caf-ems.ch` et `fiduciairefp.ch` indique
  `support.silicomgroup.ch` comme contact technique encodé.
- `www.caf-ems.ch` ne résolvait pas lors du contrôle. Cela doit être confronté
  au comportement attendu du site avant d'être qualifié d'incident.
- Les domaines publient des enregistrements SPF Microsoft 365.
- Les zones Plesk fournies le 26 octobre 2026 ne correspondent pas aux zones
  publiques actives de `caf-ems.ch` et `fiduciairefp.ch`. Elles ne doivent pas
  être utilisées telles quelles lors d'une nouvelle délégation DNS.
- La zone publique de `cafcis.ch`, autoritaire chez KreativMedia, contient encore
  les alias `imap`, `pop`, `smtp`, `mail` et `webmail` vers
  `whs05.komodo.ch`. Leur utilisation doit être vérifiée avant le retrait du
  serveur.
- `cafcis.ch` publie des enregistrements DS au registre et utilise donc DNSSEC.
  Une éventuelle migration de ses DNS demanderait une coordination spécifique.

### Interprétation de la situation CAF-EMS

Les rôles sont distincts :

- le **registrar** gère l'enregistrement du nom de domaine auprès du registre ;
- les **serveurs DNS autoritaires** publient la zone utilisée par Internet ;
- le **panneau Plesk** peut contenir une copie de zone sans que cette copie soit
  déléguée publiquement ;
- l'**hébergeur web** sert le site pointé par les enregistrements `A`/`AAAA` ;
- l'**hébergeur de messagerie** reçoit les messages pointés par les
  enregistrements `MX`.

Pour `caf-ems.ch`, les faits publics sont compatibles avec le scénario suivant :
Infomaniak est le registrar déclaré, Komodo/Silicom publie la zone DNS,
KreativMedia héberge le site, et Microsoft 365 héberge la messagerie. La zone
visible dans Plesk n'est donc pas nécessairement celle consultée par Internet.
Ce scénario reste à confirmer par les panneaux d'administration et les contrats.

La comparaison détaillée est conservée dans
[dns-comparaison-plesk-public.md](dns-comparaison-plesk-public.md).

## Limites de l'inventaire actuel

Ne sont pas encore établis :

- le titulaire légal et le compte de facturation de chaque domaine ;
- les personnes disposant des accès d'administration et du MFA ;
- le contenu complet des zones DNS ;
- les services, tâches, partages, bases et sauvegardes encore présents sur
  Komodo ;
- les contrats, renouvellements, licences et délais de résiliation ;
- les objectifs de disponibilité et de restauration ;
- la classification des données de CAFAPP, fpreminder et Dr. Tax.

