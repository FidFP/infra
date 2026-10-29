# Confirmation du mandat Microsoft 365 de Silicom

Date de préparation : 27 octobre 2026

## Message prêt à envoyer

**Objet : Confirmation du maintien de votre gestion Microsoft 365 après migration DNS**

Bonjour,

Nous prévoyons de déplacer à terme l'hébergement DNS autoritaire de certains de
nos domaines vers Infomaniak. Cette opération concerne uniquement la publication
des zones DNS et ne doit pas modifier l'hébergement de la messagerie Microsoft
365 ni votre mandat de gestion de celle-ci.

Nous souhaitons que Silicom continue à assurer l'exploitation courante de notre
environnement Microsoft 365, notamment :

- création, modification et suppression des utilisateurs et boîtes aux lettres ;
- gestion des licences Microsoft 365 et de leur renouvellement ;
- création et gestion des alias, boîtes partagées, listes et groupes ;
- réinitialisation des mots de passe et assistance MFA ;
- assistance Outlook et accès aux boîtes ;
- suivi des messages, quarantaine et incidents de flux de courrier ;
- administration des politiques de sécurité et de messagerie relevant de votre
  mandat ;
- support utilisateur et escalade auprès de Microsoft lorsque nécessaire.

Pouvez-vous nous confirmer par écrit :

1. que le déplacement des DNS autoritaires vers Infomaniak n'affectera pas
   votre capacité à administrer notre tenant Microsoft 365 ;
2. que vous continuerez à assurer les prestations ci-dessus après cette
   migration ;
3. le périmètre exact de votre mandat, les délais de prise en charge, les coûts
   et la procédure de demande d'intervention ;
4. votre mode d'accès administratif au tenant Microsoft 365, notamment les
   rôles délégués utilisés, sans nous transmettre de secret ;
5. qui facture et renouvelle actuellement les licences Microsoft 365 ;
6. que le tenant `fiduciairefp.onmicrosoft.com` et les domaines associés sont
   bien détenus pour le compte de notre organisation et peuvent être récupérés
   sans dépendance contractuelle à Silicom ;
7. la procédure de restitution complète des accès, de la documentation et de
   l'administration du tenant en cas de changement futur de prestataire.

Après la migration DNS, toute modification d'un enregistrement lié à Microsoft
365 devra nous être communiquée précisément afin que nous puissions l'appliquer
chez l'hébergeur DNS. Merci de ne modifier ni la délégation DNS ni les
enregistrements publics sans notre validation écrite.

Nous ne souhaitons pas reprendre l'administration opérationnelle quotidienne
des boîtes aux lettres. Nous devons néanmoins conserver la propriété du tenant,
une capacité de récupération d'urgence et une documentation à jour.

Merci d'avance pour votre confirmation écrite.

Meilleures salutations,

Michaël Stadelmann

## Séparation des responsabilités visée

| Responsabilité | Responsable cible |
|---|---|
| Propriété des domaines et du tenant Microsoft 365 | Organisation cliente |
| DNS autoritaire | Infomaniak |
| Administration quotidienne Microsoft 365 | Silicom |
| Validation des changements DNS | Responsable IT interne |
| Application des changements DNS | Responsable IT interne ou délégation explicitement convenue |
| Accès d'urgence et contrôle fournisseur | Organisation cliente |

Le maintien d'un accès d'urgence interne ne signifie pas que l'organisation
reprend le support quotidien. Il protège uniquement la continuité en cas
d'indisponibilité ou de changement du prestataire.
