CREATE TYPE audit_action AS ENUM('create', 'update', 'delete');

CREATE TABLE IF NOT EXISTS audit_logs (
    id INT PRIMARY KEY,
    user_id INT REFERENCES users(id),
    patron_id INT REFERENCES patrons(id) ON DELETE SET NULL,
    action AUDIT_ACTION,
    entity TEXT,
    entity_id INT,
    changes JSONB,
    created_at TIMESTAMP
);