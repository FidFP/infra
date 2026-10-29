# Questions ouvertes

Les questions sont classées dans l'ordre où leurs réponses influencent les
décisions. Elles doivent être traitées par petits lots.

## Lot 1 — Contrôle des domaines et DNS

1. Qui dispose actuellement des accès aux comptes registrar de `caf-ems.ch`,
   `cafcis.ch` et `fiduciairefp.ch` ? Le titulaire affiché dans chaque compte
   correspond-il bien à l'organisation concernée ?
2. Silicom peut-elle fournir l'export complet des zones DNS actives de
   `caf-ems.ch` et `fiduciairefp.ch`, ainsi que la confirmation écrite que ses
   serveurs Komodo sont autoritaires ?
3. KreativMedia peut-elle exporter les zones visibles dans Plesk et expliquer si
   elles sont seulement locales à l'hébergement ou utilisées comme DNS
   secondaires ?
4. L'absence de `www.caf-ems.ch` est-elle voulue ? Quelle URL est communiquée aux
   utilisateurs ?

## Lot 2 — Komodo

1. Avons-nous un accès administrateur en lecture ou devons-nous passer
   exclusivement par Silicom ?
2. Silicom possède-t-elle un inventaire des services et une sauvegarde dont la
   restauration a été testée ?
3. Quelle est la date contractuelle de renouvellement/résiliation du serveur ?

## Lot 3 — Dr. Tax

1. Quelle version exacte et quel module multi-utilisateur sont installés ?
2. Quel moteur de base de données est utilisé et quelle méthode de sauvegarde est
   supportée par l'éditeur ?
3. Les deux utilisateurs travaillent-ils simultanément et ont-ils besoin d'un
   accès hors du bureau ?

## Lot 4 — Applications internes

1. Où se trouvent les dépôts de CAFAPP et fpreminder, et existe-t-il une
   documentation de déploiement ?
2. Les applications sont-elles réservées au réseau interne/VPN ou accessibles
   depuis Internet ?
3. Quelles catégories de données personnelles ou fiscales traitent-elles ?

## Première demande concrète

Commencer par rassembler, sans aucun secret :

- une capture ou un export de la page registrar de chaque domaine montrant le
  titulaire, les serveurs DNS et l'échéance ;
- un export des zones DNS Plesk ;
- la réponse de Silicom demandant les exports des zones Komodo.

Ces éléments permettront de préparer une migration DNS sans toucher aux services.

