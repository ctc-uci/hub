DO $$ BEGIN
    CREATE TYPE audit_action AS ENUM ('create', 'update', 'delete');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS audit_logs (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id integer NOT NULL REFERENCES users(id),
    patron_id integer NOT NULL REFERENCES patrons(id),
    action AUDIT_ACTION NOT NULL,
    entity TEXT NOT NULL,
    entity_id integer NOT NULL,
    changes JSONB NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS audit_logs_patron_id_created_at_idx
    ON audit_logs (patron_id, created_at);
