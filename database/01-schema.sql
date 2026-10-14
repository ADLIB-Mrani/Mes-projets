-- Modèle initial proposé pour PostgreSQL.
-- À exécuter une seule fois dans une base neuve ; aucune donnée personnelle.
-- Les migrations suivantes devront être distinctes et versionnées.
BEGIN;

CREATE SCHEMA portfolio;
SET LOCAL search_path TO portfolio, pg_catalog;

CREATE TABLE semestre (
    numero smallint PRIMARY KEY CHECK (numero BETWEEN 1 AND 6),
    libelle text NOT NULL CHECK (btrim(libelle) <> '')
);

CREATE TABLE competence (
    code text PRIMARY KEY CHECK (code IN ('C1', 'C2', 'C3', 'C4')),
    intitule text NOT NULL CHECK (btrim(intitule) <> '')
);

CREATE TABLE apprentissage_critique (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code text NOT NULL UNIQUE CHECK (btrim(code) <> ''),
    competence_code text NOT NULL REFERENCES competence(code),
    intitule text NOT NULL CHECK (btrim(intitule) <> ''),
    niveau smallint CHECK (niveau BETWEEN 1 AND 3),
    source_referentiel text NOT NULL CHECK (btrim(source_referentiel) <> ''),
    UNIQUE (id, competence_code)
);

CREATE TABLE module_formation (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    semestre_numero smallint NOT NULL REFERENCES semestre(numero),
    code text NOT NULL CHECK (btrim(code) <> ''),
    intitule text NOT NULL CHECK (btrim(intitule) <> ''),
    UNIQUE (semestre_numero, code)
);

-- Une ligne représente un segment de formation NON CHEVAUCHANT.
-- Une minute n'est attribuée qu'à une seule compétence, ou reste non affectée.
-- Exemple de méthode uniquement : un cours multi-compétences doit être découpé,
-- pas dupliqué. Les données réelles seront saisies après collecte des sources.
CREATE TABLE segment_formation (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    module_id bigint NOT NULL REFERENCES module_formation(id) ON DELETE CASCADE,
    libelle text NOT NULL CHECK (btrim(libelle) <> ''),
    minutes integer NOT NULL CHECK (minutes > 0),
    competence_code text REFERENCES competence(code),
    source_volume text NOT NULL CHECK (btrim(source_volume) <> ''),
    regle_affectation text,
    UNIQUE (module_id, libelle)
);

CREATE TABLE alternance (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    entreprise text NOT NULL CHECK (btrim(entreprise) <> ''),
    poste text NOT NULL CHECK (btrim(poste) <> ''),
    debut date NOT NULL,
    fin date,
    missions text NOT NULL CHECK (btrim(missions) <> ''),
    bilan text,
    CHECK (fin IS NULL OR fin >= debut)
);

CREATE TABLE technologie (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom text NOT NULL CHECK (btrim(nom) <> ''),
    categorie text NOT NULL CHECK (
        categorie IN ('langage', 'base_de_donnees', 'visualisation', 'outil', 'autre')
    )
);
CREATE UNIQUE INDEX technologie_nom_unique ON technologie (lower(nom));

CREATE TABLE projet (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
    titre text NOT NULL CHECK (btrim(titre) <> ''),
    resume text NOT NULL CHECK (btrim(resume) <> ''),
    contexte text,
    contribution_personnelle text,
    resultat text,
    source_donnees text,
    semestre_numero smallint REFERENCES semestre(numero),
    origine text NOT NULL CHECK (origine IN ('but', 'alternance', 'personnel')),
    alternance_id bigint REFERENCES alternance(id),
    statut text NOT NULL DEFAULT 'en_cours' CHECK (statut IN ('en_cours', 'termine')),
    est_public boolean NOT NULL DEFAULT false,
    debut date,
    fin date,
    lien_code text,
    lien_livrable text,
    CHECK (fin IS NULL OR debut IS NULL OR fin >= debut),
    CHECK (origine <> 'but' OR semestre_numero IS NOT NULL),
    CHECK (
        (origine = 'alternance' AND alternance_id IS NOT NULL)
        OR (origine <> 'alternance' AND alternance_id IS NULL)
    )
);

CREATE TABLE projet_competence (
    projet_id bigint NOT NULL REFERENCES projet(id) ON DELETE CASCADE,
    competence_code text NOT NULL REFERENCES competence(code),
    PRIMARY KEY (projet_id, competence_code)
);

CREATE TABLE projet_technologie (
    projet_id bigint NOT NULL REFERENCES projet(id) ON DELETE CASCADE,
    technologie_id bigint NOT NULL REFERENCES technologie(id),
    usage_decrit text NOT NULL CHECK (btrim(usage_decrit) <> ''),
    PRIMARY KEY (projet_id, technologie_id)
);

-- La preuve référence à la fois l'AC et la compétence mobilisée sur le projet.
-- Les clés composites garantissent que les deux compétences correspondent.
CREATE TABLE preuve_ac (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    projet_id bigint NOT NULL,
    apprentissage_id bigint NOT NULL,
    competence_code text NOT NULL,
    description text NOT NULL CHECK (btrim(description) <> ''),
    lien_preuve text,
    statut text NOT NULL DEFAULT 'mobilise'
        CHECK (statut IN ('mobilise', 'en_cours', 'valide')),
    type_validation text
        CHECK (type_validation IN ('auto_evaluation', 'evaluation_pedagogique')),
    justification_validation text,
    date_validation date,
    UNIQUE (projet_id, apprentissage_id),
    FOREIGN KEY (projet_id, competence_code)
        REFERENCES projet_competence(projet_id, competence_code) ON DELETE CASCADE,
    FOREIGN KEY (apprentissage_id, competence_code)
        REFERENCES apprentissage_critique(id, competence_code),
    CHECK (
        statut <> 'valide'
        OR (
            type_validation IS NOT NULL
            AND date_validation IS NOT NULL
            AND coalesce(btrim(justification_validation), '') <> ''
        )
    )
);

CREATE INDEX module_semestre_idx ON module_formation(semestre_numero);
CREATE INDEX segment_competence_idx ON segment_formation(competence_code);
CREATE INDEX segment_module_idx ON segment_formation(module_id);
CREATE INDEX projet_semestre_idx ON projet(semestre_numero);
CREATE INDEX projet_alternance_idx ON projet(alternance_id);
CREATE INDEX projet_competence_code_idx ON projet_competence(competence_code);
CREATE INDEX projet_technologie_id_idx ON projet_technologie(technologie_id);
CREATE INDEX preuve_apprentissage_idx ON preuve_ac(apprentissage_id);

COMMIT;
