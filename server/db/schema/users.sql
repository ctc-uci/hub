-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

DO $$ BEGIN
  CREATE TYPE public.user_role AS ENUM ('volunteer', 'staff', 'admin');
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS public.users (
  id INT GENERATED ALWAYS AS IDENTITY,
  email VARCHAR(256) NOT NULL,
  firebase_uid VARCHAR(128) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  role public.user_role NOT NULL DEFAULT 'volunteer',
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),

  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT users_email_key UNIQUE (email),
  CONSTRAINT users_firebase_uid_key UNIQUE (firebase_uid)
)

TABLESPACE pg_default;
