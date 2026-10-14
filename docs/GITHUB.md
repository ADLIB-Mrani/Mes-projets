# Organisation du dépôt et du suivi

Le dépôt retenu est [ADLIB-Mrani/Mes-projets](https://github.com/ADLIB-Mrani/Mes-projets), avec `main` comme branche de publication. Le dépôt choisi par l’étudiant était vide lors de la préparation de l’import.

## Dépôt

Cloner le dépôt existant pour récupérer les documents et leur historique :

```bash
git clone https://github.com/ADLIB-Mrani/Mes-projets.git
cd Mes-projets
git status
```

Pour chaque nouvelle étape, après configuration de son identité de commit :

```bash
git switch -c docs/actualiser-planning
```

Modifier les fichiers concernés, puis contrôler les changements avant de les versionner :

```bash
git add docs/PLANNING.md AVANCEMENT.md
git diff --cached
git diff --cached --stat
git commit -m "docs: actualiser le planning et le journal d’avancement"
git push -u origin docs/actualiser-planning
```

Ouvrir une pull request vers `main`, vérifier le résultat et l’intégrer. Adapter le nom de branche et les fichiers à la tâche réelle. L’authentification GitHub dépend de la configuration locale ; GitHub Desktop ou GitKraken peuvent gérer cette étape avec leur connexion intégrée.

## GitHub Projects

Créer un Project lié au dépôt, puis y ajouter les issues préparées dans `ISSUES.md`. Configurer :

| Champ | Type | Valeurs/usage |
| --- | --- | --- |
| Status | Sélection | À faire, En cours, À vérifier, Terminé |
| Priorité | Sélection | P1, P2, P3 |
| Début prévu | Date | Début de la fenêtre de réalisation |
| Fin prévue | Date | Échéance de la tâche |
| Charge estimée (h) | Nombre | Temps de travail, distinct de la durée calendaire |
| Temps passé (h) | Nombre | Temps réellement consacré |
| Dépendance | Texte | Lien vers l’issue qui doit être terminée avant |

Vues : **Kanban** groupé par Status ; **Tableau** pour les charges et commentaires ; **Roadmap** avec Début prévu/Fin prévue. Des dépendances d’issues peuvent aussi être renseignées lorsqu’elles sont disponibles ; le champ texte proposé suffit pour conserver une trace simple.

Labels à créer au besoin : `documentation`, `design`, `frontend`, `backend`, `database`, `bug`. Jalons proposés : conception, première version, livraison et oral. Ne pas marquer « Terminé » une tâche dont seul le document préparatoire existe.

## Cycle de travail

1. Choisir une petite tâche et préciser son résultat attendu.
2. Créer une branche, par exemple `feat/filtres-projets`.
3. Développer et contrôler le résultat.
4. Faire un commit explicite, pousser la branche et ouvrir une pull request si cette étape facilite la relecture.
5. Mettre à jour le README, le planning et le journal selon le changement.
6. Intégrer seulement la version vérifiée, puis fermer l’issue correspondante.

Exemples de commits à utiliser lorsqu’ils décrivent un travail réel :

- `feat: afficher les projets depuis PostgreSQL`
- `feat: filtrer les projets par semestre et compétence`
- `fix: éviter le double comptage des heures de formation`
- `style: adapter les cartes et le menu aux petits écrans`
- `docs: expliquer le report du jalon serveur`

Un commit initial pour le kit est honnête. La régularité sera démontrée par les étapes suivantes réalisées dans le temps. Ne pas créer de dates fictives ni des dizaines de commits artificiels pour simuler plusieurs semaines de travail.

## Ce que GitHub héberge

GitHub conserve le code, le schéma, les scripts et la documentation. GitHub Pages seul ne peut pas exécuter un serveur Flask ni PostgreSQL. La démonstration peut rester locale ; documenter alors l’installation et le lancement avant la livraison.

Sources : [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow), [Issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-an-issue), [Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects), [GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages).
