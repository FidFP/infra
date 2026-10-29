# Plan de migration des sites

Dernière mise à jour : 26 octobre 2026

## Architecture proposée

- VPS Lite Infomaniak retenu : 4 vCPU, 4 Go de RAM et 80 Go NVMe à
  CHF 10/mois. L'absence de SLA est compatible avec le RTO provisoire de
  24 heures accepté pour les sites et les applications internes.
- Le VPS Cloud minimal reste préférable si une garantie contractuelle de
  disponibilité est exigée ou si une reconstruction manuelle est inacceptable.
- Ubuntu Server 24.04 LTS minimal si cette image est proposée lors de la
  commande ; sinon, valider la liste des images avant de choisir.
- Pas de bureau graphique, de PHP, de serveur de messagerie ni de panneau Plesk.
- Sites statiques servis par un serveur web minimal.
- CAFAPP et fpreminder déployés ultérieurement avec des services et droits
  distincts.
- PostgreSQL non exposé à Internet.
- DNS hébergé par un service géré Infomaniak, jamais sur le VPS.

L'offre Lite ne fournit pas de snapshot. Une copie chiffrée et restaurable hors
du VPS devra être mise en place avant le déploiement des applications.

Le dimensionnement suppose une synchronisation nocturne d'un fichier BASECAF
d'environ 3 000 lignes, une à deux utilisations quotidiennes de CAFAPP et une
charge négligeable pour les sites statiques. L'usage de la RAM, du disque et des
CPU devra être observé après déploiement ; aucune augmentation ne sera faite sans
mesure.

## Ordre recommandé

### Phase 0 — Préparation avant commande

1. Activer le MFA sur le compte Infomaniak qui portera le serveur et les DNS.
2. Désigner au moins deux personnes pouvant récupérer le compte de
   l'organisation, sans partager un compte nominatif.
3. Générer une clé SSH dédiée à l'administration du VPS et prévoir sa
   conservation sécurisée.
4. Récupérer une copie locale complète des trois sites et vérifier qu'ils
   fonctionnent sans composant serveur.
5. Obtenir les exports DNS autoritaires Komodo pour CAF-EMS et fiduciairefp.ch.
6. Confirmer que les responsables métier acceptent un hébergement sans SLA
   contractuel, ou retenir le VPS Cloud dans le cas contraire.

Critère de sortie : comptes sécurisés, sources disponibles, zones sauvegardées
et budget validé.

### Phase 1 — Commander et sécuriser le VPS

1. Commander le VPS sans modifier aucun domaine.
2. Installer uniquement l'image serveur LTS retenue.
3. Installer les mises à jour, configurer le pare-feu et l'accès SSH par clé.
4. Créer un compte administrateur nominatif et interdire l'authentification SSH
   par mot de passe ainsi que la connexion directe de `root`.
5. Configurer les journaux, la surveillance minimale et une sauvegarde externe.
6. Installer et configurer le serveur web.

Critère de sortie : le serveur est administrable par clé, seuls les ports
nécessaires sont ouverts et une restauration de fichier a été testée.

### Phase 2 — Préparer les sites sans DNS public

1. Créer un répertoire et une configuration distincts par site.
2. Déployer les fichiers avec des droits de lecture seulement pour le serveur
   web.
3. Tester chaque site par une résolution locale ou un nom temporaire, sans
   modifier les domaines de production.
4. Vérifier les liens, formulaires externes, redirections, en-têtes HTTP et
   journaux.

Critère de sortie : les trois sites sont validés sur le VPS par le responsable,
mais le public utilise encore l'ancien hébergement.

### Phase 3 — Pilote : migrer uniquement le site CAFCIS

**Statut : terminée le 26 octobre 2026.**

CAFCIS est un bon pilote pour le **web** parce que la zone DNS active est
accessible chez KreativMedia. Il ne faut pas migrer sa délégation DNS pendant la
même fenêtre.

1. Réduire préalablement les TTL de `A`, `AAAA` et `www` si nécessaire.
2. Préparer le certificat et le test final.
3. Modifier uniquement les enregistrements web vers l'adresse du VPS.
4. Ne modifier ni MX, ni SPF, ni DKIM, ni DMARC, ni Autodiscover.
5. Tester IPv4, IPv6 si publié, HTTPS, redirections et e-mails.
6. Garder l'ancien hébergement intact pendant la période d'observation.

Retour arrière : restaurer les anciennes valeurs `A`/`AAAA`/`CNAME`.

Résultat : A dirigé vers le VPS, ancien AAAA retiré, HTTPS actif pour l'apex et
`www`, renouvellement Let’s Encrypt simulé avec succès, DNSSEC et
enregistrements Microsoft 365 inchangés. Les tests de messagerie Gmail vers
Microsoft 365 et Microsoft 365 vers Gmail ont réussi. L'ancien hébergement doit
rester en place pendant la période d'observation.

### Phase 4 — Sortir les DNS de CAF-EMS et fiduciairefp.ch de Komodo

Cette phase concerne uniquement le DNS, pas encore leur hébergement web.

1. Reconstituer chez Infomaniak une copie exacte de chaque zone autoritaire
   Komodo.
2. Tester directement les serveurs DNS Infomaniak.
3. Conserver strictement les enregistrements Microsoft 365 actuels.
4. Modifier la délégation chez le registrar.
5. Garder les DNS Komodo actifs au moins sept jours et surveiller le courrier.

Retour arrière : restaurer l'ancienne délégation Komodo tant que ses zones sont
encore actives.

### Phase 5 — Migrer les sites fiduciairefp.ch puis CAF-EMS

Pour chaque site, dans une fenêtre distincte :

1. modifier uniquement les enregistrements web ;
2. vérifier HTTP/HTTPS et le certificat ;
3. tester le courrier Microsoft 365 ;
4. conserver l'ancien hébergement pendant l'observation ;
5. documenter le résultat avant de passer au domaine suivant.

fiduciairefp.ch peut passer avant CAF-EMS, car son site actuel est déjà considéré
comme défaillant et le nouveau contenu pourra être validé avant la bascule.

### Phase 6 — DNS de CAFCIS, facultatif et en dernier

Le DNS de CAFCIS fonctionne actuellement et utilise DNSSEC. Sa migration n'est
pas urgente. Si la consolidation chez Infomaniak reste souhaitée :

1. préparer une zone identique ;
2. planifier explicitement la transition DNSSEC et des enregistrements `DS` ;
3. migrer la délégation sans modifier le web ni Microsoft 365 ;
4. vérifier DNSSEC avant et après la bascule.

## Ce qui ne doit pas être regroupé dans une même fenêtre

- commande/sécurisation du VPS et changement DNS ;
- migration du web et migration des serveurs DNS ;
- migration DNS et modification de Microsoft 365 ;
- migration d'un domaine et suppression immédiate de l'ancien hébergement ;
- migration DNSSEC de CAFCIS et nettoyage des alias Komodo.

