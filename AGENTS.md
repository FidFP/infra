# Instructions pour les agents Codex

## Mission

Ce dépôt est la source de référence de l'infrastructure IT de F&P. Les agents
doivent privilégier les changements simples, réversibles, documentés et testés.

## Langue et qualité des informations

- Rédiger la documentation en français.
- Qualifier les informations importantes comme **Confirmé**, **Déclaré**,
  **Hypothèse** ou **Inconnu**.
- Utiliser les documentations officielles pour les compatibilités, licences,
  versions et procédures susceptibles d'évoluer.
- Ne pas transformer une hypothèse réseau ou système en fait établi.

## Secrets et données sensibles

- Ne jamais enregistrer dans Git de mot de passe, clé, jeton, numéro de licence,
  code d'activation ou donnée fiscale.
- Ne pas enregistrer les exports d'audit locaux : ils peuvent contenir des noms
  de machines, adresses IP et adresses MAC.
- Demander à l'utilisateur de saisir lui-même les secrets dans les interfaces
  prévues à cet effet.
- Avant chaque commit, rechercher les secrets et contrôler la liste exacte des
  fichiers suivis.

## Installation Dr.Tax

- Commencer par l'audit en lecture seule décrit dans `docs/drtax/`.
- Ne rien installer avant validation des prérequis, de la licence, de la
  sauvegarde et de la connectivité PC1/PC2.
- Ne pas suivre aveuglément le PDF SQL Server 2019 / Dr.Tax Office 3.0 de 2022.
  Comparer avec la documentation officielle Dr.Tax disponible au jour de
  l'intervention.
- Ne pas modifier le routeur, le DHCP, les VLAN ou les règles gérées par Silicom
  sans accord et accès explicitement autorisés.
- Ne pas exposer SQL Server ou Dr.Tax directement sur Internet.
- Préparer un retour arrière et vérifier une sauvegarde avant toute migration de
  données.
- Consigner les versions installées, les chemins, les noms de services, les
  ports et les résultats des tests, sans consigner les secrets.

## Changements Git

- Préserver les travaux existants et éviter les réécritures destructives.
- Séparer autant que possible documentation, scripts et changements de
  production.
- Tester les scripts dans un contexte non destructif avant de les utiliser pour
  une intervention.

