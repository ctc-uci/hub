-- Table: public.phase_history

-- DROP TABLE IF EXISTS public.phase_history;

CREATE TABLE IF NOT EXISTS public.phase_history (
  id INT GENERATED ALWAYS AS IDENTITY,
  patron_id INT NOT NULL,
  phase public.patron_phases NOT NULL,
  changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  changed_by INT NOT NULL,

  CONSTRAINT phase_history_pkey PRIMARY KEY (id),
  CONSTRAINT phase_history_patron_id_fkey
    FOREIGN KEY (patron_id)
    REFERENCES public.patrons (id),
  CONSTRAINT phase_history_changed_by_fkey
    FOREIGN KEY (changed_by)
    REFERENCES public.users (id)
)

TABLESPACE pg_default;
