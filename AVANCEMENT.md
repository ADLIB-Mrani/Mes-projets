# Avancement du projet

## 14 octobre 2026 — Préparation du kit

### Réalisé

- Analyse du cahier des charges fourni et vérification des outils recommandés dans leur documentation officielle.
- Proposition d’architecture, de contenus et d’un modèle relationnel.
- Création d’une maquette statique ordinateur/mobile et d’une charte graphique.
- Rédaction d’un planning initial, d’un Gantt et de tâches avec critères d’acceptation.
- Préparation du README, des scripts SQL et des modèles GitHub.

### Restant à réaliser

- Confirmer les contraintes du cours, l’année du calendrier et les dates du semestre 6.
- Renseigner l’identité, les projets réels, l’alternance, les sources horaires et le référentiel d’apprentissages critiques.
- Tester le modèle dans une base PostgreSQL locale.
- Créer le tableau GitHub Projects et les issues à partir des tâches préparées.
- Développer le serveur, les pages et les interactions, puis les vérifier.

### Décisions

| Décision | Motif |
| --- | --- |
| GitHub Issues et Projects pour le suivi | Relier les tâches, le code et les preuves d’avancement |
| Mermaid pour le Gantt versionné | Conserver une source texte modifiable dans le dépôt |
| Penpot pour faire évoluer la maquette | Concevoir les écrans et les composants avant les pages |
| Flask/PostgreSQL proposés | Réutiliser Python et SQL dans un projet de Science des données |
| Un segment horaire rattaché à au plus une compétence | Prévenir le double comptage des heures |
| Preuves explicites pour les apprentissages critiques | Distinguer une compétence mobilisée d’une acquisition démontrée |

Les documents ont été préparés avec l’aide de ChatGPT. Ils doivent être compris, adaptés et vérifiés par l’étudiant avant de constituer les choix définitifs du projet.

## 14 octobre 2026 — Import dans GitHub

- Dépôt choisi par l’étudiant : [ADLIB-Mrani/Mes-projets](https://github.com/ADLIB-Mrani/Mes-projets).
- Import du kit à la racine du dépôt : documentation, maquettes, Gantt, trois scripts SQL et modèles GitHub, soit 19 fichiers.
- README complété avec les fonctionnalités prévues, l’aperçu de la maquette, l’organisation des fichiers et les commandes de récupération du dépôt.
- Procédure Git adaptée au dépôt existant et à la branche `main`.
- Contrôle des chemins des liens et de l’intégrité des fichiers. Les scripts PostgreSQL restent à exécuter dans une base locale.
- Difficulté rencontrée : l’écriture via la connexion GitHub a été refusée (erreur 403) ; le push Git direct a échoué faute d’authentification disponible. Solution : import depuis l’interface web de GitHub, autorisé par l’étudiant.
- Publication sur `main` par groupes de fichiers, avec des messages de commit décrivant chaque ajout. Ces commits constituent l’import initial du kit ; ils ne représentent pas plusieurs séances de développement.
- Prochaine étape : confirmer les données et le calendrier, puis vérifier le schéma PostgreSQL.

## Modèle à copier après chaque séance

### Date — étape réelle

- Objectif prévu :
- Travail réalisé :
- Commit(s) ou pull request(s) :
- Données/sources ajoutées :
- Contrôles effectués et résultat :
- Difficulté rencontrée :
- Modification du planning et raison :
- Prochaine action :

## 23 novembre 2026 — Application et déploiement

- Création des pages React/TypeScript et de la navigation responsive à partir de la charte et du cahier des charges.
- Ajout de la recherche et des filtres, du détail des projets, des compétences, de l’alternance et des indicateurs.
- Création du projet PostgreSQL gratuit `portfolio-but-sd` dans l’organisation choisie par l’étudiant, en région Paris.
- Installation des 11 tables, des références, des vues et des politiques de lecture des projets publiés.
- Premier projet renseigné : le portfolio réel, avec son dépôt et ses documents ; aucun autre projet ni volume de formation inventé.
- Contrôles PostgreSQL réussis : masquage d’un projet privé, refus des écritures anonymes, calcul des heures sans double comptage. Les données de test ont été annulées par transaction.
- Quatre tests fonctionnels réussis : confidentialité, filtres combinés, inconnues et liens externes. Contrôle TypeScript réalisé.
- Limite de l’environnement : relais d’aperçu indisponible. La vérification visuelle locale est restée non effectuée.

- Publication confirmée : https://portfolio-mohamed-mrani.animatedbraid256.chatgpt.site (accès privé).
- Contrôles HTTP après déploiement : pages et médias accessibles, API connectée à Supabase, projet inconnu en erreur 404. Les feuilles de style sont accessibles.

## 24 novembre 2026 — Préparation de l’hébergement indépendant

- Demande de l’étudiant : disposer d’une adresse hors de l’hébergement ChatGPT.
- Ajout de `build:render` et `start:render` pour exécuter le même portfolio avec Next.js sur Node.js, sans changer sa base Supabase.
- Lecture des variables de configuration via `process.env`, compatible avec Node.js et Cloudflare grâce au flag de compatibilité explicite.
- Version Node.js Render fixée dans `.node-version` ; documentation des paramètres du service et des variables à renseigner.
- Vérifications réussies : quatre tests, TypeScript, compilations Next.js et Vinext, douze routes HTTP et feuille de style sur le serveur Node.js de production local, API connectée à Supabase et projet inconnu en 404.
- Publication Render non effectuée : aucun espace de travail n’est sélectionné dans le connecteur. Le choix de la destination reste à identifier avant création du service gratuit et vérification de sa véritable URL.
