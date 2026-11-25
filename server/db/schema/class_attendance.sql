CREATE TABLE IF NOT EXISTS class_attendance (
    session_id integer NOT NULL REFERENCES class_sessions(id),
    patron_id integer NOT NULL REFERENCES patrons(id),
    signed_in_by integer NOT NULL REFERENCES users(id),
    signed_in_at TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (session_id, patron_id)
);