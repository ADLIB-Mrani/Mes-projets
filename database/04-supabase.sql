-- Exposition en lecture seule du portfolio à travers une vue publique.
-- À appliquer après 01-schema.sql, 02-reference.sql et 03-statistiques.sql.
-- Les données et preuves privées restent exclues par RLS.
GRANT USAGE ON SCHEMA portfolio TO anon, authenticated;
REVOKE ALL ON ALL TABLES IN SCHEMA portfolio FROM PUBLIC, anon, authenticated;
GRANT SELECT ON ALL TABLES IN SCHEMA portfolio TO anon, authenticated;

ALTER TABLE portfolio.semestre ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.competence ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.apprentissage_critique ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.module_formation ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.segment_formation ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.alternance ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.technologie ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.projet ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.projet_competence ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.projet_technologie ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio.preuve_ac ENABLE ROW LEVEL SECURITY;

CREATE POLICY lire_semestres ON portfolio.semestre FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY lire_competences ON portfolio.competence FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY lire_referentiel ON portfolio.apprentissage_critique FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY lire_modules ON portfolio.module_formation FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY lire_volumes ON portfolio.segment_formation FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY lire_projets_publies ON portfolio.projet FOR SELECT TO anon, authenticated USING (est_public);
CREATE POLICY lire_competences_projets_publies ON portfolio.projet_competence FOR SELECT TO anon, authenticated
  USING (EXISTS (SELECT 1 FROM portfolio.projet p WHERE p.id = projet_id AND p.est_public));
CREATE POLICY lire_outils_projets_publies ON portfolio.projet_technologie FOR SELECT TO anon, authenticated
  USING (EXISTS (SELECT 1 FROM portfolio.projet p WHERE p.id = projet_id AND p.est_public));
CREATE POLICY lire_preuves_projets_publies ON portfolio.preuve_ac FOR SELECT TO anon, authenticated
  USING (EXISTS (SELECT 1 FROM portfolio.projet p WHERE p.id = projet_id AND p.est_public));
CREATE POLICY lire_alternances_publiees ON portfolio.alternance FOR SELECT TO anon, authenticated
  USING (EXISTS (SELECT 1 FROM portfolio.projet p WHERE p.alternance_id = alternance.id AND p.est_public));
CREATE POLICY lire_technologies_publiees ON portfolio.technologie FOR SELECT TO anon, authenticated
  USING (EXISTS (SELECT 1 FROM portfolio.projet_technologie pt JOIN portfolio.projet p ON p.id = pt.projet_id WHERE pt.technologie_id = technologie.id AND p.est_public));

ALTER VIEW portfolio.v_stats_globales SET (security_invoker = true);
ALTER VIEW portfolio.v_heures_par_competence SET (security_invoker = true);
ALTER VIEW portfolio.v_heures_par_semestre SET (security_invoker = true);
ALTER VIEW portfolio.v_projets_par_annee SET (security_invoker = true);

CREATE VIEW public.portfolio_snapshot WITH (security_invoker = true, security_barrier = true) AS
SELECT jsonb_build_object(
  'projects', COALESCE((SELECT jsonb_agg(jsonb_build_object(
    'slug',p.slug,'title',p.titre,'summary',p.resume,'semester',p.semestre_numero,
    'origin',p.origine,'status',p.statut,'published',p.est_public,
    'context',COALESCE(p.contexte,''),'contribution',COALESCE(p.contribution_personnelle,''),
    'result',COALESCE(p.resultat,''),'dataSource',COALESCE(p.source_donnees,''),
    'startedAt',p.debut,'repositoryUrl',p.lien_code,'deliverableUrl',p.lien_livrable,
    'competences',COALESCE((SELECT jsonb_agg(pc.competence_code ORDER BY pc.competence_code) FROM portfolio.projet_competence pc WHERE pc.projet_id = p.id),'[]'::jsonb),
    'technologies',COALESCE((SELECT jsonb_agg(t.nom ORDER BY t.nom) FROM portfolio.projet_technologie pt JOIN portfolio.technologie t ON t.id = pt.technologie_id WHERE pt.projet_id = p.id),'[]'::jsonb)
  ) ORDER BY p.id DESC) FROM portfolio.projet p WHERE p.est_public),'[]'::jsonb),
  'formationMinutes',(SELECT sum(minutes) FROM portfolio.segment_formation),
  'hoursByCompetence',(SELECT jsonb_object_agg(code,heures_renseignees) FROM portfolio.v_heures_par_competence),
  'validatedAc',CASE WHEN EXISTS (SELECT 1 FROM portfolio.apprentissage_critique)
    THEN (SELECT count(DISTINCT pa.apprentissage_id) FROM portfolio.preuve_ac pa JOIN portfolio.projet p ON p.id = pa.projet_id
      WHERE p.est_public AND pa.statut = 'valide' AND pa.type_validation = 'evaluation_pedagogique') ELSE NULL END,
  'updatedAt','2026-11-23'
) AS payload;
REVOKE ALL ON public.portfolio_snapshot FROM PUBLIC, anon, authenticated;
GRANT SELECT ON public.portfolio_snapshot TO anon, authenticated;
NOTIFY pgrst, 'reload schema';
