DROP TABLE IF EXISTS public.patrons;

DO $$ BEGIN
        CREATE TYPE public.patron_phases AS ENUM (
            'basic',
            'basic_classes',
            'full',
            'housed'
        );
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE public.patrons (
  id INT GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(255) NOT NULL,
  middle_initial VARCHAR(1), 
  last_name VARCHAR(255) NOT NULL,
  current_phase public.patron_phases NOT NULL,
  notice TEXT,
  first_visit_date DATE,
  created_by INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMP,

  CONSTRAINT patrons_pkey PRIMARY KEY (id),
  CONSTRAINT patrons_unique_names
    UNIQUE NULLS NOT DISTINCT
    (first_name, middle_initial, last_name),
  CONSTRAINT patrons_created_fkey 
    FOREIGN KEY (created_by)
    REFERENCES public.users (id)
    
);

