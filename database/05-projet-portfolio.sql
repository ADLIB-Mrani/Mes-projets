-- Unique réalisation issue du dépôt réel. Aucun autre projet étudiant n’est simulé.
BEGIN;
INSERT INTO portfolio.projet (slug,titre,resume,contexte,contribution_personnelle,resultat,source_donnees,semestre_numero,origine,statut,est_public,debut,lien_code) VALUES ('portfolio-but-sd','Un portfolio pour raconter trois années de data','Concevoir un portfolio qui relie les projets, les compétences et les preuves d’un parcours en BUT Science des données.','Le projet consiste à construire un portfolio des trois années de BUT Science des données. Il doit présenter les réalisations, les quatre compétences du diplôme, les outils utilisés et l’alternance, dans une interface responsive.','Structurer les contenus et les données du portfolio, définir une charte graphique, préparer une maquette ordinateur/mobile, organiser les relations PostgreSQL et construire une première application consultable. Le dépôt et le journal conservent les étapes, les décisions et les limites du projet.','Une première version du portfolio, avec une navigation par projets et compétences, des filtres et une structure prête à accueillir les réalisations de chaque semestre. Les informations personnelles et les volumes horaires restent à compléter à partir de sources vérifiées.','Cahier des charges du module portfolio, documents de conception et fichiers du dépôt Mes-projets. Aucun résultat de projet ni volume horaire des trois années n’est inventé.',5,'but','en_cours',true,'2026-10-14','https://github.com/ADLIB-Mrani/Mes-projets') ON CONFLICT (slug) DO NOTHING;
INSERT INTO portfolio.technologie (nom,categorie) VALUES ('TypeScript','langage'),
('React','outil'),
('HTML','langage'),
('CSS','langage'),
('PostgreSQL','base_de_donnees'),
('GitHub','outil') ON CONFLICT DO NOTHING;
INSERT INTO portfolio.projet_competence (projet_id,competence_code) SELECT p.id,c.code FROM portfolio.projet p CROSS JOIN portfolio.competence c WHERE p.slug='portfolio-but-sd' AND c.code IN ('C1','C3','C4') ON CONFLICT DO NOTHING;
INSERT INTO portfolio.projet_technologie (projet_id,technologie_id,usage_decrit) SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='TypeScript'
UNION ALL
SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='React'
UNION ALL
SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='HTML'
UNION ALL
SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='CSS'
UNION ALL
SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='PostgreSQL'
UNION ALL
SELECT p.id,t.id,'Utilisé dans la conception ou le développement du portfolio documenté.' FROM portfolio.projet p CROSS JOIN portfolio.technologie t WHERE p.slug='portfolio-but-sd' AND t.nom='GitHub' ON CONFLICT DO NOTHING;
COMMIT;
