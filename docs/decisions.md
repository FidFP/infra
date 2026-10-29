# Registre des décisions

Ce registre conserve les décisions, leur justification et les conditions qui
pourraient conduire à les réexaminer.

| ID | Date | Décision | Statut | Justification / condition de réexamen |
|---|---|---|---|---|
| DEC-001 | 2026-10-26 | Ne pas migrer le site Cité-Joie | Adoptée | L'hébergement actuel répond au besoin et une agence de design y intervient. Réexaminer uniquement en cas d'incident, de fin de contrat ou de demande explicite. |
| DEC-002 | 2026-10-26 | Ne pas acheter de VPS avant l'inventaire | Remplacée par DEC-007 | Le dimensionnement minimal a ensuite été établi et le VPS commandé. |
| DEC-003 | 2026-10-26 | Traiter Dr. Tax comme un chantier séparé | Adoptée | Ses contraintes Windows, licence et base ne doivent pas bloquer l'inventaire DNS et les applications web. |
| DEC-004 | 2026-10-26 | Interdire l'arrêt de Komodo avant migration DNS et audit des dépendances | Adoptée | Deux domaines utilisent encore ses serveurs DNS autoritaires et d'autres dépendances peuvent exister. |
| DEC-005 | 2026-10-26 | Héberger les sites vitrines concernés sur le VPS applicatif | Adoptée | Leur caractère entièrement statique a été confirmé. Le domaine de panne commun est accepté avec un RTO provisoire de 24 heures et exige sauvegarde et procédure de reconstruction. |
| DEC-006 | 2026-10-26 | Ne pas déléguer CAF-EMS ou fiduciairefp.ch aux zones Plesk actuelles | Adoptée | Leurs MX, SPF, DKIM, DMARC et autres entrées diffèrent des zones publiques actives Microsoft 365. |
| DEC-007 | 2026-10-26 | Retenir le VPS Lite 4 vCPU, 4 Go RAM et 80 Go à CHF 10/mois | Recommandée | Une synchronisation nocturne d'un fichier d'environ 3 000 lignes, quelques écritures quotidiennes en base et des sites statiques constituent une charge faible. Le Lite peut être augmenté plus tard si les mesures le justifient. Les sauvegardes externes et la procédure de reconstruction restent obligatoires. |
| DEC-008 | 2026-10-26 | Migrer séparément hébergement web et délégation DNS | Adoptée | Une seule variable est modifiée par fenêtre, ce qui simplifie la validation et le retour arrière et protège Microsoft 365. |
| DEC-009 | 2026-10-26 | Conserver pour l'instant le DNS autoritaire de CAFCIS chez KreativMedia | Adoptée | Le web CAFCIS a été migré sans changer NS, DNSSEC ni Microsoft 365. La migration de cette zone n'apporte aucun bénéfice urgent. |
| DEC-010 | 2026-10-26 | Ne pas publier immédiatement l'IPv6 du VPS pour CAFCIS | Adoptée | Le VPS possède une IPv6 globale, mais aucun chemin de test IPv6 externe n'était disponible. L'ancien AAAA a été retiré afin d'éviter un chemin IPv6 vers l'ancien hébergement ou non validé. |
| DEC-011 | 2026-10-27 | Maintenir l'administration opérationnelle de Microsoft 365 chez Silicom après migration DNS | Adoptée | Le déplacement des zones DNS vers Infomaniak ne doit pas transférer la création des boîtes, les licences, le support Outlook, les réinitialisations ou les incidents de messagerie à l'équipe interne. L'organisation conserve toutefois la propriété du tenant et un accès d'urgence. |

## Décisions à prendre plus tard

- emplacement et niveau d'isolation de CAFAPP et fpreminder ;
- migration des sites CAF-EMS et fiduciairefp.ch ;
- fournisseur DNS indépendant de l'hébergement web ;
- architecture Dr. Tax ;
- objectifs de sauvegarde (RPO), de restauration (RTO) et de disponibilité ;
- perte de données acceptable (RPO), le RTO provisoire étant fixé à 24 heures
  pour les sites, CAFAPP et fpreminder ;
- date et conditions de retrait de Komodo.

