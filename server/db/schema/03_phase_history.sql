-- Table: public.phase_history

-- DROP TABLE IF EXISTS public.phase_history;

CREATE TABLE IF NOT EXISTS public.phase_history
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    patron_id integer NOT NULL,
    phase public.patron_phases NOT NULL,
    changed_at timestamp NOT NULL DEFAULT NOW(),
    changed_by integer NOT NULL,
    
    CONSTRAINT id PRIMARY KEY (id),
    CONSTRAINT phase_history_patron_id_fkey FOREIGN KEY (patron_id)
        REFERENCES public.patrons (id),
    CONSTRAINT phase_history_changed_by_id_fkey FOREIGN KEY (changed_by)
        REFERENCES public.users (id)
)

TABLESPACE pg_default;
