# Publier le portfolio sur Render

## État au 24 novembre 2026

La version Node.js est compilée et vérifiée localement avec la base Supabase existante. Aucun service Render n’a encore été créé : l’espace de travail de destination doit être identifié. Aucune adresse publique Render n’est annoncée avant confirmation du déploiement.

## Configuration du service

Créer un seul **Web Service** à partir du dépôt GitHub. Le serveur est nécessaire pour lire les données Supabase et répondre aux routes `/api/portfolio` et `/api/health`.

| Paramètre | Valeur |
| --- | --- |
| Source | `https://github.com/ADLIB-Mrani/Mes-projets` |
| Branche | `main` |
| Nom proposé | `portfolio-mohamed-mrani` (selon disponibilité) |
| Runtime | Node.js |
| Région | Frankfurt |
| Compute plan | Free |
| Build command | `npm ci --include=dev && npm test && npm run build:render` |
| Start command | `npm run start:render` |
| Déploiement automatique | Activé si le dépôt est lié au fournisseur GitHub |

Le programme écoute sur `0.0.0.0` et lit `PORT` via le serveur Next.js. Les commandes initiales `npm run build` et `npm start` restent dédiées à Vinext/Cloudflare.

## Variables d’environnement

Renseigner uniquement dans la configuration du service :

| Variable | Usage |
| --- | --- |
| `SUPABASE_URL` | URL API du projet existant `portfolio-but-sd` |
| `SUPABASE_PUBLISHABLE_KEY` | Clé publiable active, avec les politiques RLS existantes |
| `NEXT_TELEMETRY_DISABLED` | `1` |

Le serveur lit ces variables à l’exécution. Elles ne portent pas le préfixe `NEXT_PUBLIC_` et ne sont pas renvoyées par l’API du portfolio. Ne pas créer une nouvelle base et ne pas utiliser de clé `service_role`.

Sans ces deux variables Supabase, l’application affiche son contenu de référence : une page visible ne prouve donc pas à elle seule que la connexion à la base est active.

## Vérifier la publication

1. Attendre que le déploiement Render passe à l’état `live`.
2. Ouvrir l’adresse HTTPS fournie par Render.
3. Vérifier `/api/health` : `status` doit valoir `ok` et `storage` doit valoir `supabase`.
4. Vérifier les pages, le détail du portfolio, les filtres et les médias. Un projet inconnu doit renvoyer 404.
5. Ajouter l’adresse réellement obtenue au README.

Les contrôles de préparation ont réussi : quatre tests, TypeScript, construction Next.js, construction Vinext, douze routes HTTP et feuille de style. La connexion Supabase a été vérifiée depuis le serveur Node.js de production local. Ces vérifications ne remplacent pas le contrôle du futur service Render.

L’offre Free peut mettre le serveur en veille après 15 minutes sans trafic ; une nouvelle visite peut alors nécessiter environ une minute de démarrage. Les données restent dans Supabase et ne dépendent pas du disque local du serveur.

Documentation officielle : [Next.js sur Render](https://render.com/docs/deploy-nextjs-app), [offre gratuite](https://render.com/docs/free), [variables d’environnement](https://render.com/docs/configure-environment-variables).
