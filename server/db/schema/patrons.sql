-- Table: public.phase_history

-- DROP TABLE IF EXISTS public.phase_history;

DO $$ BEGIN
    CREATE TYPE public.phase_type AS ENUM ('volunteer', 'staff', 'admin');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS public.phase_history
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    patron_id integer NOT NULL,
    phase public.phase_type NOT NULL
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    role public.user_role NOT NULL DEFAULT 'volunteer',
    created_at timestamp NOT NULL DEFAULT NOW(),
    
    CONSTRAINT user_pkey PRIMARY KEY (id),
    CONSTRAINT email UNIQUE (email),
    CONSTRAINT firebase_uid UNIQUE (firebase_uid)
)

TABLESPACE pg_default;