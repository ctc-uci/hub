CREATE TABLE class_attendance (
    session_id INT NOT NULL REFERENCES class_sessions(id),
    patron_id INT NOT NULL REFERENCES patrons(id),
    signed_in_by INT NOT NULL REFERENCES users(id),
    signed_in_at TIMESTAMP NOT NULL,
    PRIMARY KEY (session_id, patron_id)
);