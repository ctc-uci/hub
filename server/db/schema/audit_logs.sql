DO $$ BEGIN
    CREATE TYPE audit_action AS ENUM ('create', 'update', 'delete');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE TABLE IF NOT EXISTS audit_logs (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id integer REFERENCES users(id),
    patron_id integer REFERENCES patrons(id) ON DELETE SET NULL,
    action AUDIT_ACTION,
    entity TEXT,
    entity_id integer,
    changes JSONB,
    created_at TIMESTAMP DEFAULT now()
);