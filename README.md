# Portfolio — Mohamed Mrani Alaoui

Application du portfolio de BUT Science des données à l’Université Marie et Louis Pasteur. Elle présente les projets documentés, les compétences C1 à C4, le parcours et un espace pour l’alternance.

Site public : [https://portfolio-mohamed-mrani.onrender.com](https://portfolio-mohamed-mrani.onrender.com).

Le portfolio est hébergé sur Render et connecté à la base Supabase existante. L’accès ne nécessite pas de compte ChatGPT. Voir [la procédure Render](docs/DEPLOIEMENT_RENDER.md).

## Version du 24 novembre 2026

- Pages d’accueil, projets, détail de projet, compétences, alternance, parcours et documentation.
- Filtres combinables par recherche, année, semestre, compétence et outil, conservés dans l’URL.
- PostgreSQL hébergé sur Supabase : les 11 tables du modèle initial, les vues et la lecture des seuls projets publiés.
- Les valeurs inconnues restent « À renseigner ». Les heures ne sont pas multipliées par les associations entre projets, outils et compétences.
- Une seule réalisation est actuellement documentée : le portfolio lui-même, à partir du dépôt réel. Les autres projets, l’employeur, les volumes de formation et les preuves pédagogiques restent à compléter.

## Technologies

React, TypeScript, CSS et PostgreSQL/Supabase. Le même code fonctionne avec Next.js sur un serveur Node.js pour Render et avec Vinext sur Cloudflare Workers pour l’hébergement initial. Le serveur interroge une vue Supabase en lecture seule ; aucune clé secrète de service n’est utilisée dans le navigateur.

## Exécuter localement

Prérequis : Node.js 22.13 ou version plus récente et npm.

```bash
npm ci
npm run dev
```

Sans configuration Supabase, l’application présente le contenu de référence versionné. Pour connecter une base, renseigner les variables serveur `SUPABASE_URL` et `SUPABASE_PUBLISHABLE_KEY` dans la configuration locale du runtime. En production, les enregistrer dans les variables d’environnement de l’hébergeur. Ne jamais ajouter les valeurs réelles au dépôt.

```bash
npm test
npx tsc --noEmit
npm run build
```

Pour construire et démarrer la version Node.js, avec les mêmes variables serveur :

```bash
npm run build:render
npm run start:render
```

Le serveur écoute sur `0.0.0.0` et utilise la variable `PORT` fournie par l’hébergeur (3000 par défaut en local). La version Node.js pour Render est fixée dans `.node-version`.

## Données PostgreSQL

Dans une base neuve, exécuter dans l’ordre les scripts de `database/`. Les trois premiers fichiers conservent le modèle initial. `04-supabase.sql` ajoute RLS et une vue publique avec `security_invoker`, puis `05-projet-portfolio.sql` documente le projet réel du portfolio. Les identifiants générés sont retrouvés par leurs clés métier.

L’accès visiteur est limité à la lecture. Les projets non publiés et leurs relations sont exclus ; les écritures anonymes sont interdites. Les apprentissages validés restent inconnus tant que le référentiel et les preuves ne sont pas renseignés.

## Routes utiles

| Route | Usage |
| --- | --- |
| `/` | Accueil |
| `/projets` | Recherche et filtres |
| `/projets/portfolio-but-sd` | Projet réel du portfolio |
| `/competences` | Compétences et projets associés |
| `/alternance` | Espace à compléter avec les contenus diffusables |
| `/parcours` | Semestres et indicateurs sourcés |
| `/documents` | Documents et preuves de conception |
| `/api/portfolio` | Données publiées, sans identifiants de connexion |
| `/api/health` | État du service et de la connexion de données |

## Documentation et limites

La conception d’origine reste dans `docs/` et les étapes réelles dans `AVANCEMENT.md`. La première proposition de serveur Flask est conservée dans les documents historiques ; cette version utilise le runtime TypeScript compatible avec l’hébergement.

Les tests vérifient les filtres, le masquage des projets privés, les valeurs inconnues et les liens externes. Des contrôles PostgreSQL exécutés avec le rôle `anon` vérifient la confidentialité, les privilèges d’écriture et les sommes horaires, avec des données de test annulées par transaction.

Le relais d’aperçu de l’environnement de préparation n’était pas disponible : la vérification visuelle locale n’a pas pu être effectuée. Le résultat du déploiement et les contrôles HTTP sont suivis séparément.

Les documents et le code ont été préparés avec l’aide de ChatGPT. Les contenus pédagogiques et les contributions doivent être relus et adaptés par l’étudiant.
