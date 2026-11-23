-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

DO $$ BEGIN
    CREATE TYPE public.user_role AS ENUM ('volunteer', 'staff', 'admin');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    email character varying(256) NOT NULL,
    firebase_uid character varying(128) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    role public.user_role NOT NULL DEFAULT 'volunteer',
    created_at timestamp NOT NULL DEFAULT NOW(),
    
    CONSTRAINT user_pkey PRIMARY KEY (id),
    CONSTRAINT email UNIQUE (email),
    CONSTRAINT firebase_uid UNIQUE (firebase_uid)
)

TABLESPACE pg_default;
