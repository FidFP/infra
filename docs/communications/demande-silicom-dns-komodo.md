# Demande à Silicom — DNS et dépendances Komodo

Date de préparation : 26 octobre 2026

## Message prêt à envoyer

**Objet : Inventaire et export des DNS actifs sur Komodo — aucune modification demandée**

Bonjour,

Dans le cadre de la documentation et de la sécurisation de notre infrastructure,
nous préparons la sortie progressive des services encore dépendants de
`whs05.komodo.ch` et `whns.komodo.ch`.

À ce stade, nous vous demandons uniquement des informations et des exports.
Merci de ne modifier aucun DNS, service, certificat ou serveur, et de ne lancer
aucune migration sans notre validation écrite.

Les serveurs DNS publics suivants apparaissent actuellement comme autoritaires
pour `caf-ems.ch` et `fiduciairefp.ch` :

- `whns.komodo.ch`
- `whs05.komodo.ch`

Pour chacun de ces deux domaines, pourriez-vous nous fournir :

1. un export complet de la zone DNS actuellement active sur les serveurs
   autoritaires, de préférence au format BIND ou dans un autre format texte
   réimportable ;
2. la totalité des enregistrements et de leurs TTL, y compris SOA, NS, A, AAAA,
   CNAME, MX, TXT, SRV, CAA, DKIM, SPF, DMARC et Autodiscover ;
3. le numéro de série SOA actuel et la date de l'export ;
4. la confirmation du rôle de chaque serveur : primaire, secondaire ou autre,
   ainsi que l'emplacement éventuel d'un serveur maître caché ;
5. le statut DNSSEC de chaque zone et, s'il est actif, les informations utiles
   à une migration coordonnée des DNSKEY et enregistrements DS ;
6. l'identité du registrar, du titulaire contractuel et du compte depuis lequel
   la délégation NS peut être modifiée, dans la mesure où ces éléments sont
   gérés par Silicom ;
7. la liste des certificats TLS, validations de services ou tâches automatiques
   qui dépendent de ces zones DNS.

Afin de préparer l'arrêt futur de Komodo sans oublier de dépendance, merci
également de nous communiquer :

8. la liste exhaustive des domaines et zones DNS de notre organisation encore
   publiés par `whns.komodo.ch` ou `whs05.komodo.ch` ;
9. la liste des services encore actifs sur `whs05.komodo.ch` pour notre
   organisation : DNS, web, messagerie, relais SMTP, IMAP/POP, bases de données,
   partages, applications, tâches planifiées, certificats, sauvegardes ou autres ;
10. si les journaux le permettent, la confirmation de l'utilisation récente des
    noms `imap.cafcis.ch`, `pop.cafcis.ch`, `smtp.cafcis.ch`, `mail.cafcis.ch` et
    `webmail.cafcis.ch`, qui pointent encore vers `whs05.komodo.ch` ;
11. les adresses IP, noms DNS, lecteurs réseau, scripts, raccourcis ou comptes de
    service connus qui référencent encore directement Komodo ;
12. la date de renouvellement, le délai de résiliation et les conditions de
    maintien temporaire du serveur et des DNS pendant une migration.

Nous souhaitons que les DNS Komodo restent actifs et inchangés pendant toute la
préparation, puis pendant au moins sept jours après une éventuelle modification
de délégation. La date et la procédure seront convenues séparément.

Merci de ne transmettre aucun mot de passe ou clé privée par e-mail. Si des
accès doivent nous être remis, merci de proposer un canal sécurisé et des
comptes nominatifs avec MFA lorsque cela est possible.

Pourriez-vous également identifier une personne technique avec laquelle nous
pourrons valider l'exhaustivité des exports et organiser le retour arrière ?

Merci d'avance et meilleures salutations,

Michaël Stadelmann

## Critères d'une réponse exploitable

La réponse est suffisante seulement si elle contient :

- deux exports issus des DNS autoritaires actifs, et non des zones Plesk
  KreativMedia ;
- les TTL et le SOA ;
- une réponse claire sur DNSSEC et le contrôle de la délégation ;
- un inventaire des autres dépendances Komodo ;
- une confirmation qu'aucune modification n'a été effectuée ;
- un contact technique et les contraintes contractuelles d'arrêt.

Une capture d'écran seule n'est pas un export réimportable. Une liste partielle
des enregistrements n'est pas suffisante pour préparer une migration sûre.
