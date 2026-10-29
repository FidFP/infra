# Runbook - installation réseau Dr.Tax

## Périmètre

Ce runbook décrit l'ordre de travail. Les noms exacts des menus, les versions et
les ports doivent être repris de la documentation officielle vérifiée le jour de
l'intervention.

## Phase 0 - décision et autorisations

1. Exécuter l'audit PC1 et PC2.
2. Confirmer que les deux PC communiquent et que Silicom peut intervenir sur le
   DHCP ou le réseau si nécessaire.
3. Confirmer la licence et le nombre d'utilisateurs simultanés.
4. Choisir le moteur de base de données :
   - PostgreSQL si aucune dépendance n'impose MS SQL et si la recommandation
     officielle reste inchangée ;
   - MS SQL si une contrainte ou une décision documentée le justifie.
5. Obtenir l'accord explicite avant tout téléchargement ou installation.

**Point d'arrêt** : ne pas poursuivre si un prérequis, une sauvegarde ou une
autorisation manque.

## Phase 1 - sauvegarde et retour arrière

1. Si une installation existe, la mettre au niveau requis pour l'export.
2. Créer une sauvegarde complète Dr.Tax.
3. Vérifier le journal de sauvegarde.
4. Copier la sauvegarde sur un support distinct de PC1.
5. Préserver les éléments spécifiques comme `SnapShare.dat` si applicable.
6. Documenter comment revenir à l'ancienne installation.

## Phase 2 - préparation de PC1

1. Installer les mises à jour Windows et redémarrer.
2. Fixer un nom de machine stable.
3. Désactiver la mise en veille pendant le service.
4. Vérifier le profil réseau, la résolution de nom et l'espace disque.
5. Faire confirmer la réservation DHCP par Silicom.

## Phase 3 - base de données

1. Télécharger l'installateur officiel du moteur choisi.
2. Installer la version supportée avec une instance dédiée ou clairement
   identifiée.
3. Installer les outils d'administration nécessaires.
4. Configurer le protocole réseau uniquement sur le réseau interne.
5. Créer la base et le compte applicatif selon le guide Dr.Tax.
6. Conserver les secrets dans un gestionnaire de mots de passe.
7. Tester localement la connexion à la base.

## Phase 4 - serveur Dr.Tax

1. Télécharger l'installateur Dr.Tax depuis la source officielle.
2. Choisir l'installation serveur/réseau.
3. Utiliser des chemins locaux sur PC1, jamais un NAS ou un dossier cloud.
4. Renseigner le nom de PC1, l'instance, la base et le compte applicatif.
5. Tester les ports et la connexion avant de valider.
6. Installer uniquement les composants nécessaires.
7. Tester Dr.Tax localement sur PC1.

## Phase 5 - migration et licence

1. Si une migration est nécessaire, rester en mode démo jusqu'à la restauration.
2. Restaurer la sauvegarde dans la base vide.
3. Vérifier plusieurs dossiers et exercices fiscaux.
4. Vérifier les documents et Snap.Share si applicable.
5. Activer la licence une seule fois selon la procédure réseau actuelle.

## Phase 6 - accès depuis PC2

1. Partager uniquement le dossier client demandé par la documentation actuelle.
2. Limiter les droits aux utilisateurs concernés.
3. Depuis PC2, ouvrir le partage par le nom de PC1.
4. Créer le raccourci client Dr.Tax.
5. Tester l'ouverture et l'accès au même jeu de données.
6. Vérifier les règles de pare-feu sur les profils internes uniquement.

## Phase 7 - validation

1. Vérifier que les services redémarrent automatiquement.
2. Redémarrer PC1 et retester PC2.
3. Vérifier la résolution de nom et l'adresse réservée.
4. Créer un enregistrement de test clairement identifié, le lire depuis les deux
   PC, puis le supprimer depuis l'application.
5. Vérifier le comportement lorsqu'un même dossier est ouvert sur les deux PC.
6. Consigner versions, chemins, ports, services et résultats des tests.

## Phase 8 - exploitation

1. Mettre en place une sauvegarde complète régulière.
2. Conserver au moins une copie hors de PC1.
3. Tester périodiquement une restauration.
4. Documenter les mises à jour et les incidents.
5. Ne jamais traiter une synchronisation OneDrive ou une copie du fichier de
   base comme une sauvegarde restaurable.

