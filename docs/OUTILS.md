# Outils adaptés au portfolio

Recommandations vérifiées le 14 octobre 2026. Le choix proposé privilégie un petit ensemble d’outils que l’étudiant peut expliquer pendant l’oral.

## Ensemble recommandé

| Besoin | Outil principal | Usage concret |
| --- | --- | --- |
| Historique et dépôt | Git + GitHub | Commits cohérents, branches, dépôt à remettre sur Moodle |
| Suivi des tâches | GitHub Issues + Projects | Une issue par livrable ; vues tableau, Kanban et Roadmap |
| Maquette | Penpot | Écrans ordinateur/mobile, composants, navigation du prototype |
| Gantt dans le dépôt | Mermaid | Diagramme texte dans `PLANNING.md`, modifié et versionné avec le projet |
| Gantt avec dépendances à manipuler | GanttProject, facultatif | Fichier local de planning ; utile si le cours demande un outil dédié |
| Schéma relationnel | Mermaid ; draw.io si dessin manuel préféré | Montrer les tables et les cardinalités, conserver la source du dessin |
| Développement | VS Code, ou PyCharm avec le pack étudiant | Écrire le serveur Python, le HTML, le CSS et le JavaScript |
| Données | PostgreSQL + pgAdmin | Créer les tables, inspecter les relations, exécuter et vérifier les requêtes |
| Documentation | Markdown dans GitHub | README, choix d’architecture, journal d’avancement, planning |

GitHub Projects propose bien des vues tableau, Kanban et Roadmap. La Roadmap positionne les éléments selon les champs de dates ou d’itération. Pour ce projet, utiliser cette vue pour le suivi courant et le Gantt Mermaid pour conserver une version lisible du planning dans le dépôt. Ne pas supposer une resynchronisation automatique entre les deux : après un report, les mettre à jour ensemble.

Penpot fournit des wireframes, prototypes interactifs et outils de conception d’interfaces responsive. Il n’est pas nécessaire d’utiliser une offre du Student Pack pour la maquette. Le SVG fourni constitue un premier support visuel ; reconstruire les composants dans Penpot si un prototype cliquable est demandé.

GanttProject est gratuit et fonctionne localement. Il peut remplacer Mermaid si l’enseignant préfère un fichier de planning dédié ; éviter de maintenir trois plannings complets en parallèle.

## Ce que le Student Developer Pack apporte réellement

| Offre vérifiée | Intérêt | Choix proposé |
| --- | --- | --- |
| JetBrains : abonnement étudiant gratuit, renouvellement annuel | IDE pour développer et déboguer | PyCharm si Python ; vérifier les outils inclus lors de l’activation |
| GitKraken Student Plan : 6 mois gratuits, puis jusqu’à 80 % de réduction du prix Pro pendant les études | Visualiser branches, commits et interactions GitHub | Optionnel ; vérifier la date d’expiration |
| GitHub Desktop : gratuit pour tout le monde | Interface graphique pour Git | Alternative simple sous Windows/macOS, sans avantage étudiant nécessaire |

Les offres ci-dessus sont celles publiées sur la page du Pack au moment de la vérification. Les conditions d’activation de chaque partenaire restent à vérifier sur le compte de l’étudiant.

Ne pas choisir un hébergement, un nom de domaine ou un outil payant uniquement parce qu’une promotion existe. Un dépôt bien documenté et une démonstration locale suffisent au besoin décrit.

## Mise en place

1. Installer Git, un éditeur, PostgreSQL et pgAdmin.
2. Créer le dépôt et un Project avec les champs détaillés dans `GITHUB.md`.
3. Utiliser la maquette fournie comme point de départ dans Penpot.
4. Adapter `PLANNING.md` aux dates réellement confirmées.
5. Collecter les données avant de développer les indicateurs.

## Sources officielles

- [GitHub Student Developer Pack](https://education.github.com/pack) : JetBrains, GitKraken et GitHub Desktop.
- [GitHub Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects) et [configuration de la Roadmap](https://docs.github.com/en/issues/planning-and-tracking-with-projects/customizing-views-in-your-project/customizing-the-roadmap-layout).
- [Diagrammes Mermaid dans GitHub](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams) et [syntaxe Gantt](https://mermaid.js.org/syntax/gantt.html).
- [Penpot](https://penpot.app/) : plateforme de conception et prototypage.
- [GanttProject](https://www.ganttproject.biz/) : planning local.
- [draw.io](https://app.diagrams.net/) : éditeur de diagrammes.
- [Flask](https://flask.palletsprojects.com/en/stable/), [pgAdmin](https://www.pgadmin.org/) et [contraintes PostgreSQL](https://www.postgresql.org/docs/current/ddl-constraints.html).
