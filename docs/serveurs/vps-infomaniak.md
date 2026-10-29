# VPS Infomaniak

Dernière vérification : 26 octobre 2026

## Identité et ressources

| Élément | Valeur |
|---|---|
| Produit | VPS Lite Infomaniak |
| Adresse IPv4 | `179.237.123.102` |
| Adresse IPv6 attribuée | `2001:1600:18:20d::2e5` — non publiée dans le DNS |
| Réseau | Infomaniak, AS29222 |
| Utilisateur initial | `ubuntu` |
| Système | Ubuntu 24.04.4 LTS |
| Noyau observé après mise à jour | `6.8.0-147-generic` |
| Ressources | 4 vCPU, 4 Go de RAM, 80 Go de disque |
| Virtualisation | KVM / OpenStack |
| Fuseau serveur | UTC |
| Empreinte SSH ED25519 | `SHA256:qFmoyAsvpbOx4Gxg4MLA4wY+C7nU9lyR0evXG+Guiu4` |

La clé privée d'administration n'est pas stockée dans ce dossier.

## État initial observé

- Authentification SSH par mot de passe désactivée.
- SSH seul service TCP exposé avant installation.
- UFW installé mais initialement inactif.
- Mises à jour automatiques activées.
- Aucun swap configuré initialement.
- Système marqué `degraded` parce que le script `cloud-init` Infomaniak
  attendait un second disque de données absent de l'offre Lite. Le système, le
  disque racine et SSH étaient néanmoins opérationnels.

## Socle appliqué le 26 octobre 2026

- Mises à jour Ubuntu complètes appliquées et nouveau noyau chargé.
- `cloud-init` terminé sans erreur après redémarrage.
- État `systemd` : `running`, aucun service en échec.
- Authentification SSH par clé uniquement.
- Connexion SSH directe de `root` interdite.
- X11 SSH désactivé et nombre de tentatives réduit.
- UFW actif, politique entrante par défaut `deny`.
- Seuls 22/TCP, 80/TCP et 443/TCP sont autorisés en entrée.
- Mises à jour automatiques de sécurité actives.
- Aucun serveur web, moteur de base ou application installé à cette étape.

## Ports autorisés

| Port | Usage |
|---|---|
| 22/TCP | Administration SSH par clé |
| 80/TCP | Redirection HTTP et validation ACME |
| 443/TCP | Sites et applications HTTPS |

PostgreSQL ne doit pas être exposé publiquement.

## Serveur web et premier site

Le 26 octobre 2026 :

- Nginx `1.24.0-2ubuntu7.18` a été installé depuis les dépôts Ubuntu ;
- le site CAFCIS a été audité comme site entièrement statique ;
- la version initiale `20261026-162102`, puis la version de publication
  `20261026-163423`, ont été déployées dans
  `/srv/www/cafcis.ch/releases/` ;
- le lien `/srv/www/cafcis.ch/current` permet une bascule et un retour arrière
  atomiques ;
- les empreintes SHA-256 des fichiers déployés correspondent aux originaux ;
- `nginx -t` réussit et le site répond correctement depuis le VPS avec l'hôte
  `cafcis.ch` ;
- l'adresse IP seule retourne volontairement une réponse 404 via un site par
  défaut neutre.

### Pare-feu réseau et validation externe

Les ports TCP 80 et 443 ont été autorisés dans le pare-feu réseau du Manager
Infomaniak le 26 octobre 2026. Le port 22 reste autorisé pour l'administration.

Après ouverture, les contrôles externes ont confirmé :

- réponse HTTP 200 pour la page CAFCIS, ses images et ses documents ;
- réponse HTTP 404 pour une ressource inexistante ;
- réponse HTTP 404 sur la racine de l'adresse IP ;
- présence des en-têtes `nosniff`, `SAMEORIGIN` et
  `strict-origin-when-cross-origin` ;
- enregistrement correct des requêtes dans les journaux Nginx.

L'URL HTTP temporaire a été supprimée après validation visuelle. Certbot et le
webroot ACME séparé ont ensuite été configurés. Le certificat ECDSA couvre
`cafcis.ch` et `www.cafcis.ch`, expire le 24 janvier 2027 et son renouvellement
simulé a réussi. HTTP redirige désormais vers HTTPS.

## Fichiers de configuration suivis

- [`infra/vps/sshd-hardening.conf`](../../infra/vps/sshd-hardening.conf)
- [`infra/vps/bootstrap-base.sh`](../../infra/vps/bootstrap-base.sh)
- [`infra/vps/deploy-cafcis-initial.sh`](../../infra/vps/deploy-cafcis-initial.sh)
- [`infra/vps/prepare-cafcis-tls.sh`](../../infra/vps/prepare-cafcis-tls.sh)
- [`infra/vps/letsencrypt-reload-nginx.sh`](../../infra/vps/letsencrypt-reload-nginx.sh)
- [`infra/nginx/sites-available/00-default-deny.conf`](../../infra/nginx/sites-available/00-default-deny.conf)
- [`infra/nginx/sites-available/cafcis.ch.conf`](../../infra/nginx/sites-available/cafcis.ch.conf)
- [`infra/nginx/sites-available/cafcis.ch-tls.conf`](../../infra/nginx/sites-available/cafcis.ch-tls.conf)

