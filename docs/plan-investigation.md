# Plan d'investigation

Le plan est volontairement séquentiel. Chaque étape produit des preuves qui
conditionnent la suivante.

## Phase 1 — Domaines, DNS et accès

### Actions

1. Recenser pour chaque domaine le titulaire, le registrar, le compte client, la
   date de renouvellement et les contacts de récupération.
2. Obtenir un export complet des zones actives de `caf-ems.ch`, `cafcis.ch` et
   `fiduciairefp.ch` auprès des serveurs réellement autoritaires.
3. Exporter aussi les zones visibles dans Plesk, puis comparer les deux versions.
4. Recenser les usages des sous-domaines, certificats, enregistrements Microsoft
   365 et validations de services tiers.
5. Vérifier qui peut modifier la délégation DNS et si le compte est protégé par
   MFA.

### Critères de sortie

- chaque domaine a un titulaire et un responsable identifiés ;
- les zones actives sont sauvegardées hors des serveurs concernés ;
- chaque enregistrement a un usage connu ou est explicitement marqué inconnu ;
- la procédure de modification et de récupération d'accès est connue.

## Phase 2 — Audit de Komodo

### Actions

1. Demander à Silicom l'inventaire des rôles, logiciels, services Windows,
   bases, partages, tâches planifiées, certificats et sauvegardes.
2. Relever les ports en écoute et les connexions utiles pendant une période
   représentative, avec l'accord de Silicom.
3. Identifier les comptes de service, les lecteurs réseau, scripts et raccourcis
   clients qui référencent le nom ou l'adresse du serveur.
4. Vérifier les fonctions DNS, Dr. Tax et toute autre fonction encore active.
5. Définir pour chaque dépendance une cible, un test de migration et un retour
   arrière.

### Critères de sortie

- aucun service actif n'est sans propriétaire ;
- chaque dépendance possède une stratégie de retrait ;
- une date d'arrêt ne peut être fixée qu'après une période d'observation et une
  validation métier.

## Phase 3 — Dr. Tax

Obtenir par écrit : version, composants serveur/client, moteur et taille de base,
protocoles/ports, compatibilité OS, licence, nombre de sessions simultanées,
méthode de sauvegarde cohérente, restauration, mises à jour, latence tolérée,
accès distant supporté et architecture recommandée par l'éditeur.

Comparer ensuite au minimum :

- poste/mini-serveur Windows dédié dans le bureau ;
- serveur Windows local administré ;
- hébergement Windows distant officiellement supporté.

Un PC utilisateur ordinaire ne devrait être retenu comme « serveur » que si les
contraintes d'alimentation, de disponibilité, de sauvegarde, de chiffrement et de
maintenance sont acceptables.

## Phase 4 — CAFAPP et fpreminder

Pour chaque application, documenter :

- dépôt et processus de déploiement ;
- framework et versions Python ;
- tâches de fond et planifiées ;
- utilisateurs, authentification et exposition Internet ;
- données traitées et niveau de sensibilité ;
- volumétrie, croissance et objectif de disponibilité ;
- dépendances externes, courrier et intégration SharePoint ;
- schéma PostgreSQL, migrations, sauvegarde et restauration ;
- journaux, alertes et responsable d'astreinte.

## Phase 5 — Architecture cible

La comparaison devra porter sur le coût total, la surface d'attaque, le domaine
de panne, l'effort de maintenance, la restauration et la réversibilité. Les
sites concernés sont statiques (HTML/CSS/JS, sans PHP ni base), ce qui rend
raisonnables aussi bien un hébergement statique géré qu'un service web minimal
sur le VPS applicatif. Les options minimales à comparer seront : hébergement
statique/mutualisé conservé, VPS unique avec sites servis en lecture seule,
séparation sites publics/applications internes, et services managés lorsque leur
gain opérationnel est démontré.

