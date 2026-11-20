-- Wrapped type definition for idempotency
DO $$
BEGIN 
    CREATE TYPE public.patron_flag_type AS ENUM ('ban', 'bolo');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS public.patron_flags (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    patron_id integer NOT NULL,
    "type" public.patron_flag_type NOT NULL,
    reason TEXT NOT NULL,
    "start_date" DATE NOT NULL,
    end_date DATE,
    created_by INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lifted_by INT,
    lifted_at TIMESTAMP,
    -- TODO: Verify that TIMESTAMP is intentional for this table and not TIMESTAMPTZ

    CONSTRAINT patron_flags_pk PRIMARY KEY (id),
    CONSTRAINT patron_id_fk FOREIGN KEY (patron_id) REFERENCES public.patrons (id),
    CONSTRAINT end_after_start_ck CHECK (end_date >= start_date),
    -- TODO: Verify that end_date = start_date is acceptable
    CONSTRAINT created_by_fk FOREIGN KEY (created_by) REFERENCES public.users (id),
    CONSTRAINT lifted_by_fk FOREIGN KEY (lifted_by) REFERENCES public.users (id),
    CONSTRAINT lifted_exist_parity_ck CHECK (
        (lifted_by IS NOT NULL AND lifted_at IS NOT NULL)
        OR (lifted_by IS NULL AND lifted_at IS NULL)
    )
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.patron_flags
    OWNER to postgres;
