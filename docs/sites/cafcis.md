# Site CAFCIS

Dernière mise à jour : 26 octobre 2026

## Audit de la source

- Type : HTML, CSS intégré et JavaScript local simple.
- Aucun PHP, CGI, moteur de base de données ou formulaire serveur.
- Aucun secret ou identifiant d'accès détecté.
- Aucune dépendance à Komodo ou KreativMedia détectée.
- Dépendances externes : Google Fonts et un lien vers `admin.ch`.
- Documents locaux : demande d'allocations en PDF et statuts en PNG.
- Le fichier Apache `.well-known/acme-challenge/.htaccess` n'a pas été copié
  dans la version publiée ; Nginx ne l'utilise pas.

## Déploiement préparé

| Élément | Valeur |
|---|---|
| Version | `20261026-163423` |
| Répertoire | `/srv/www/cafcis.ch/releases/20261026-163423` |
| Version active | `/srv/www/cafcis.ch/current` |
| Configuration Nginx | `/etc/nginx/sites-available/cafcis.ch.conf` |
| Journaux | `/var/log/nginx/cafcis.ch.*.log` |

Le site répond en HTTP lorsque l'en-tête d'hôte vaut `cafcis.ch` ou
`www.cafcis.ch`. Aucun DNS de production n'a été modifié et aucun certificat
TLS n'a encore été demandé.

La validation HTTP externe et la validation visuelle ont réussi le 26 octobre
2026 pour la page, le logo, le PDF de demande et l'image des statuts. La route
de prévisualisation temporaire a ensuite été supprimée et retourne désormais
une réponse 404.

La version de publication corrige également la langue du document HTML et
remplace l'ancien lien HTTP vers la législation fédérale par le lien HTTPS
Fedlex actuel.

## Préparation TLS

- Certbot 2.9.0 installé depuis les dépôts Ubuntu.
- Minuteur systemd de renouvellement installé.
- Webroot ACME indépendant : `/var/lib/letsencrypt`.
- Test externe du challenge HTTP : réponse 200.
- Certificat ECDSA émis pour `cafcis.ch` et `www.cafcis.ch`.
- Expiration actuelle : 24 janvier 2027.
- HTTPS activé et HTTP redirigé en 301 vers HTTPS.
- Hook de validation et rechargement Nginx installé pour les renouvellements.
- Simulation de renouvellement réussie le 26 octobre 2026.

## État de la migration

La migration web est terminée le 26 octobre 2026 :

- A public : `179.237.123.102` ;
- ancien AAAA retiré ;
- `www` conservé comme CNAME vers l'apex ;
- DNSSEC validé ;
- MX, SPF, DKIM, DMARC et Autodiscover Microsoft 365 inchangés ;
- tests fonctionnels de messagerie réussis dans les deux sens entre Gmail et
  `contact@cafcis.ch` ;
- DNS autoritaire toujours hébergé chez KreativMedia.

L'ancien hébergement ne doit pas encore être supprimé. Il constitue le retour
arrière pendant la période d'observation.

## Avant la bascule DNS

1. Surveiller le site et les journaux pendant au moins sept jours.
2. Conserver l'ancien hébergement pendant cette période.
3. Ne planifier sa suppression qu'après vérification des autres domaines et des
   anciens alias de messagerie.
