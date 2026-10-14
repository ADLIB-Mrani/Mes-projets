-- Uniquement les références présentes dans le cahier des charges.
-- Aucun projet, volume, employeur ou apprentissage acquis n'est inventé.
BEGIN;

INSERT INTO portfolio.semestre (numero, libelle) VALUES
    (1, 'Semestre 1 — BUT1'),
    (2, 'Semestre 2 — BUT1'),
    (3, 'Semestre 3 — BUT2'),
    (4, 'Semestre 4 — BUT2'),
    (5, 'Semestre 5 — BUT3'),
    (6, 'Semestre 6 — BUT3')
ON CONFLICT (numero) DO NOTHING;

INSERT INTO portfolio.competence (code, intitule) VALUES
    ('C1', 'Traiter des données à des fins décisionnelles'),
    ('C2', 'Analyser statistiquement les données'),
    ('C3', 'Valoriser une production dans un contexte professionnel'),
    ('C4', 'Développer un outil décisionnel')
ON CONFLICT (code) DO NOTHING;

COMMIT;
