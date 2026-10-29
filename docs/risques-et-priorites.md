# Risques et priorités

Dernière mise à jour : 26 octobre 2026

## Risques principaux

| Priorité | Risque | Conséquence possible | Mesure immédiate |
|---|---|---|---|
| Critique | Arrêt de Komodo alors qu'il reste DNS autoritaire pour `caf-ems.ch` et `fiduciairefp.ch` | Sites, courrier et autres services dépendant du DNS injoignables | Interdire l'arrêt avant export et migration validée des zones |
| Haute | Dépendances Komodo non inventoriées | Interruption d'applications, scripts, partages ou authentifications oubliés | Inventaire technique et observation des usages avant décision |
| Haute | Responsabilités et accès administratifs dispersés | Impossibilité d'intervenir ou de restaurer en urgence | Créer une matrice propriétaire/prestataire/accès/MFA |
| Haute | Sauvegardes non démontrées par un test de restauration | Perte de données malgré l'existence supposée de copies | Obtenir les politiques, puis tester des restaurations ciblées |
| Haute | Sites publics et applications internes regroupés sans isolation suffisante | Compromission transversale et panne commune | Reporter le choix d'architecture après classification des données et besoins |
| Haute | Solution Dr. Tax choisie sans exigences éditeur ni licence | Architecture non supportée, lente ou impossible à sauvegarder correctement | Obtenir les prérequis écrits du consultant/éditeur |
| Haute | Activation directe des zones Plesk de CAF-EMS ou fiduciairefp.ch | Le courrier serait redirigé de Microsoft 365 vers d'anciennes cibles KreativMedia/Komodo | Reconstituer la zone à partir des données autoritaires actives et la tester avant délégation |
| Moyenne | Zone Plesk prise à tort pour la zone DNS active | Changement sans effet ou enregistrements oubliés lors d'une migration | Comparer export Plesk, export Komodo et réponses autoritaires |
| Moyenne | Alias mail de `cafcis.ch` pointant encore vers Komodo | Des clients configurés manuellement pourraient cesser de fonctionner à l'arrêt du serveur | Identifier leur usage, migrer les clients puis retirer les alias |
| Moyenne | Absence actuelle de `www.caf-ems.ch` | Échec d'accès pour certains utilisateurs ou liens historiques | Confirmer l'URL officielle avant correction |
| Moyenne | Utilisation future d'un compte personnel pour SharePoint | Rupture de synchronisation au départ d'un collaborateur | Concevoir une identité applicative avec droits minimaux |

## Position provisoire sur l'architecture

- Ne pas acheter de VPS tant que les besoins des applications, la sensibilité des
  données et les responsabilités d'exploitation ne sont pas établis.
- Ne pas placer Dr. Tax sur un VPS Windows par simple analogie avec l'ancien
  serveur. Il faut d'abord distinguer la base, le client et l'accès distant.
- Les sites concernés étant purement statiques, leur hébergement sur le VPS
  applicatif devient une option raisonnable : serveur web sans PHP, répertoires
  en lecture seule et déploiement contrôlé. Un hébergement statique géré reste
  l'option demandant le moins d'exploitation.
- Si les sites partagent le VPS applicatif, accepter explicitement le domaine de
  panne commun et maintenir l'isolation des applications, bases et secrets.
- Conserver Cité-Joie en l'état, sauf incident concret ou nouvelle décision.

## Ordre des priorités

1. Sécuriser la connaissance et le contrôle des domaines/DNS.
2. Inventorier toutes les dépendances de Komodo et geler sa date d'arrêt.
3. Obtenir les exigences et restrictions officielles de Dr. Tax.
4. Décrire CAFAPP et fpreminder : données, utilisateurs, flux, disponibilité et
   déploiement actuel.
5. Définir les exigences de sauvegarde, restauration et sécurité.
6. Comparer les architectures et leurs coûts complets.
7. Planifier les migrations avec tests et retour arrière.

