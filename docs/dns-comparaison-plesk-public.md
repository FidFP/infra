# Comparaison DNS public / Plesk

Date du contrôle : 26 octobre 2026

## Sources et portée

- **Plesk** : listes transmises par le responsable IT depuis KreativMedia.
- **Public** : requêtes DNS récursives en lecture seule effectuées le même jour.

Une zone affichée dans Plesk peut être stockée localement sans être celle que les
résolveurs Internet consultent. La délégation `NS` publiée par le registre et les
réponses des serveurs autoritaires déterminent la zone publique active.

## `caf-ems.ch`

La délégation publique pointe vers `whns.komodo.ch` et `whs05.komodo.ch`. La zone
Plesk annonce au contraire `ns89.kreativmedia.ch` et `ns90.kreativmedia.ch`.

| Fonction | Zone publique active | Zone visible dans Plesk | Risque si Plesk devient autoritaire telle quelle |
|---|---|---|---|
| Réception e-mail | MX `cafems-ch0i.mail.protection.outlook.com` | MX `mail.caf-ems.ch`, lui-même sur `80.74.157.171` | Le courrier quitte Microsoft 365 pour le serveur KreativMedia |
| SPF | `include:spf.protection.outlook.com -all` | `include:_spf.kreativmedia.ch +mx +a -all` | Des messages Microsoft 365 légitimes peuvent échouer SPF |
| DKIM | Sélecteurs Microsoft 365 `selector1` et `selector2` | Ancienne clé `default` | DKIM Microsoft 365 peut ne plus valider |
| Autodiscover | CNAME vers `autodiscover.outlook.com` | Absent de l'export | Reconfiguration automatique Outlook perturbée |
| DMARC | `p=none` | `p=quarantine; adkim=s; aspf=s` | Changement de politique non préparé et risque de classement en spam |
| `www` | Inexistant publiquement | CNAME vers le domaine racine | Changement fonctionnel, à valider séparément |
| IPv6 racine | Aucun AAAA observé | `2a00:1128:0:157::50` | Nouveau chemin réseau/TLS non testé |

Conclusion : la zone Plesk est une configuration parallèle ou historique, pas
une copie prête à remplacer la zone Komodo.

## `fiduciairefp.ch`

La délégation publique pointe également vers Komodo, malgré la présence d'une
zone dans Plesk.

| Fonction | Zone publique active | Zone visible dans Plesk | Risque si Plesk devient autoritaire telle quelle |
|---|---|---|---|
| Réception e-mail | MX `fiduciairefp-ch.mail.protection.outlook.com` | MX `mailgw01.komodo.ch` et `mailgw02.komodo.ch` | Retour vers d'anciennes passerelles au lieu de Microsoft 365 |
| SPF | `include:spf.protection.outlook.com -all` | `include:_spf.kreativmedia.ch +mx +a -all` | Échec SPF possible pour Microsoft 365 |
| DKIM | Sélecteurs Microsoft 365 `selector1` et `selector2` | Ancienne clé `default` | Perte de validation DKIM Microsoft 365 |
| Autodiscover | CNAME vers `autodiscover.outlook.com` | Absent de l'export | Découverte Outlook perturbée |
| DMARC | `p=none` | `p=quarantine; adkim=s; aspf=s` | Durcissement involontaire |
| IPv6 racine | `2a02:7e60:ec1c::35` | `2a00:1128:0:157::50` | Le trafic IPv6 serait envoyé vers une autre machine |
| Anciens services mail | Non contrôlés exhaustivement | `imap`, `pop`, `smtp` vers `mta2.krios.info` et MX Komodo | Réactivation de dépendances anciennes |

Conclusion : cette zone Plesk est manifestement historique et ne doit pas servir
de modèle de migration.

## `cafcis.ch`

La délégation publique pointe bien vers `ns89.kreativmedia.ch` et
`ns90.kreativmedia.ch`. Les entrées principales Plesk sont donc actives.

Points confirmés :

- MX, SPF, DKIM Microsoft 365 et Autodiscover sont cohérents avec Microsoft 365 ;
- DMARC est en mode `quarantine` avec alignement strict ;
- les alias `imap`, `pop`, `smtp`, `mail` et `webmail` pointent encore vers
  `whs05.komodo.ch` ;
- les enregistrements SRV IMAPS/POP3S/SMTPS pointent vers KreativMedia ;
- DNSSEC est actif au niveau de la délégation (`DS` publié).

Les alias vers Komodo ne contrôlent pas la réception normale, qui dépend du MX
Microsoft 365. Ils peuvent toutefois être utilisés par d'anciens profils de
messagerie ou outils. Leur suppression doit être précédée d'une vérification.

### Migration web du 26 octobre 2026

- l'enregistrement A de l'apex a été remplacé par `179.237.123.102` ;
- l'ancien AAAA `2a00:1128:0:157::50` a été supprimé ;
- le CNAME `www` vers l'apex a été conservé ;
- MX, SPF, DKIM, DMARC et Autodiscover ont été contrôlés après la modification
  et sont restés inchangés ;
- la délégation NS et les enregistrements DS n'ont pas été modifiés ;
- une réponse DNS validée par DNSSEC a été confirmée (`AD=true`).

Le DNS autoritaire de CAFCIS reste chez KreativMedia. Seul l'hébergement web a
été déplacé.

## Règle de migration

Pour CAF-EMS et fiduciairefp.ch, la nouvelle zone devra être reconstruite à
partir de la **zone publique autoritaire complète**, pas à partir de Plesk. Les
entrées Microsoft 365 devront être identiques des deux côtés pendant toute la
période de propagation.

