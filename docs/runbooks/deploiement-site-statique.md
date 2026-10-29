# Déploiement d'un site statique

Dernière mise à jour : 26 octobre 2026

## Principe

Chaque domaine dispose :

- d'un répertoire `/srv/www/<domaine>/releases/<horodatage>` immuable ;
- d'un lien symbolique `/srv/www/<domaine>/current` vers la version active ;
- d'une configuration Nginx indépendante ;
- de journaux d'accès et d'erreur propres au domaine.

La bascule d'une version consiste uniquement à remplacer le lien `current`.
L'ancienne version est conservée pour permettre un retour arrière rapide.

## Contrôles avant déploiement

1. Vérifier que le contenu est uniquement statique.
2. Rechercher les secrets, formulaires, scripts serveur et dépendances à
   l'ancien hébergeur.
3. Vérifier que toutes les ressources locales référencées existent.
4. Conserver une empreinte SHA-256 des fichiers d'origine.

## Contrôles après déploiement

1. Exécuter `nginx -t` avant tout rechargement.
2. Tester le domaine sur l'adresse du VPS avec une résolution forcée locale.
3. Vérifier la page principale, les images et chaque document téléchargeable.
4. Vérifier les codes HTTP, les types MIME et les en-têtes de sécurité.
5. Ne modifier les DNS qu'après validation visuelle par le responsable.

## Retour arrière

1. Faire pointer `current` vers la version précédente.
2. Exécuter `nginx -t`.
3. Recharger Nginx.

Un retour arrière applicatif ne nécessite donc aucune modification DNS.
