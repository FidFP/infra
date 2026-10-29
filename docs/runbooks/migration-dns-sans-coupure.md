# Migration DNS sans coupure de messagerie

Cette procédure décrit la stratégie. Elle ne constitue pas encore une
autorisation de changement.

## Principe

La messagerie Microsoft 365 ne dépend pas de l'emplacement du site web. Elle
continue à fonctionner tant que les enregistrements MX, SPF, DKIM, Autodiscover,
DMARC et les éventuels enregistrements de validation restent corrects.

Pendant une migration de serveurs DNS, certains résolveurs utilisent encore
l'ancienne zone tandis que d'autres utilisent déjà la nouvelle. Si les deux
zones contiennent les mêmes enregistrements de messagerie, cette coexistence ne
doit pas interrompre le courrier.

## Préparation

1. Obtenir l'export complet des zones autoritaires Komodo.
2. Compléter l'inventaire par des requêtes publiques `A`, `AAAA`, `CNAME`, `MX`,
   `TXT`, `SRV`, `CAA`, `NS`, `SOA`, ainsi que les noms Microsoft 365 connus.
3. Identifier les entrées inconnues avec Silicom et les utilisateurs.
4. Créer la zone chez le futur fournisseur en reproduisant d'abord exactement
   l'état actif, sans « nettoyage » simultané.
5. Vérifier la nouvelle zone en interrogeant directement ses serveurs DNS avant
   de modifier la délégation.
6. Contrôler séparément les prérequis DNSSEC. Ne jamais changer des DNS avec un
   ancien `DS` encore publié au registre.

## Bascule recommandée

1. Demander la réduction des TTL dans la zone Komodo au moins 48 à 72 heures à
   l'avance, lorsque c'est pertinent.
2. Effectuer un test documenté de courrier entrant et sortant avant changement.
3. Modifier uniquement la délégation `NS` chez le registrar. Ne pas changer le
   site web le même jour.
4. Surveiller les réponses des anciens et nouveaux DNS, le flux Microsoft 365,
   SPF, DKIM et DMARC.
5. Maintenir les anciens DNS actifs au moins sept jours et jusqu'à disparition
   des réponses anciennes observées.
6. Une fois le DNS stabilisé, migrer éventuellement le site dans une opération
   distincte en ne changeant que `A`/`AAAA`/`CNAME`.

## Validations minimales

- messages entrants reçus depuis au moins deux fournisseurs externes ;
- messages sortants reçus avec SPF et DKIM valides ;
- Autodiscover fonctionnel ;
- absence d'erreur de résolution sur plusieurs résolveurs ;
- sites et certificats accessibles en IPv4 et, si publié, en IPv6 ;
- ancienne zone et procédure de retour arrière conservées.

## Interdictions pendant la première bascule

- ne pas activer directement les zones Plesk actuelles de CAF-EMS ou
  fiduciairefp.ch ;
- ne pas modifier simultanément les DNS, le site et la messagerie ;
- ne pas durcir DMARC au même moment ;
- ne pas supprimer les anciennes cibles avant d'avoir établi leur absence
  d'utilisation ;
- ne pas arrêter Komodo à la fin de la seule propagation DNS.

