-- Chaque agrégat est calculé indépendamment : pas de multiplication des heures
-- par le nombre d'outils, de compétences ou de preuves liés aux projets.
BEGIN;

CREATE OR REPLACE VIEW portfolio.v_stats_globales AS
SELECT
    (SELECT sum(minutes)::numeric / 60
        FROM portfolio.segment_formation) AS heures_formation_renseignees,
    (SELECT sum(minutes)::numeric / 60
        FROM portfolio.segment_formation
        WHERE competence_code IS NULL) AS heures_non_affectees_renseignees,
    (SELECT count(*) FROM portfolio.module_formation) AS nb_modules_renseignes,
    (SELECT count(DISTINCT module_id)
        FROM portfolio.segment_formation) AS nb_modules_avec_volume,
    (SELECT count(*) FROM portfolio.projet
        WHERE est_public) AS nb_projets_publies,
    (SELECT count(*) FROM portfolio.projet
        WHERE est_public AND statut = 'termine') AS nb_projets_termines_publies,
    (SELECT count(DISTINCT pt.technologie_id)
        FROM portfolio.projet_technologie pt
        JOIN portfolio.projet p ON p.id = pt.projet_id
        WHERE p.est_public) AS nb_outils_utilises_sur_projets_publies,
    (SELECT count(DISTINCT pa.apprentissage_id)
        FROM portfolio.preuve_ac pa
        JOIN portfolio.projet p ON p.id = pa.projet_id
        WHERE p.est_public AND pa.statut = 'valide'
          AND pa.type_validation = 'evaluation_pedagogique') AS nb_ac_valides_pedagogiquement,
    (SELECT count(DISTINCT pa.apprentissage_id)
        FROM portfolio.preuve_ac pa
        JOIN portfolio.projet p ON p.id = pa.projet_id
        WHERE p.est_public AND pa.statut = 'valide'
          AND pa.type_validation = 'auto_evaluation') AS nb_ac_autoevalues_avec_preuve;

-- NULL signifie aucune donnée connue pour une compétence, pas forcément zéro.
CREATE OR REPLACE VIEW portfolio.v_heures_par_competence AS
SELECT c.code, c.intitule,
       sum(sf.minutes)::numeric / 60 AS heures_renseignees,
       count(sf.id) AS nb_segments_renseignes
FROM portfolio.competence c
LEFT JOIN portfolio.segment_formation sf ON sf.competence_code = c.code
GROUP BY c.code, c.intitule;

CREATE OR REPLACE VIEW portfolio.v_heures_par_semestre AS
SELECT s.numero, s.libelle,
       sum(sf.minutes)::numeric / 60 AS heures_renseignees,
       count(DISTINCT m.id) AS nb_modules_renseignes,
       count(DISTINCT sf.module_id) AS nb_modules_avec_volume
FROM portfolio.semestre s
LEFT JOIN portfolio.module_formation m ON m.semestre_numero = s.numero
LEFT JOIN portfolio.segment_formation sf ON sf.module_id = m.id
GROUP BY s.numero, s.libelle;

CREATE OR REPLACE VIEW portfolio.v_projets_par_annee AS
SELECT ((semestre_numero + 1) / 2)::smallint AS annee_but,
       count(*) AS nb_projets_publies,
       count(*) FILTER (WHERE statut = 'termine') AS nb_projets_termines_publies
FROM portfolio.projet
WHERE est_public AND semestre_numero IS NOT NULL
GROUP BY ((semestre_numero + 1) / 2)::smallint;

COMMIT;
