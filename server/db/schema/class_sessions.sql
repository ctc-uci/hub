CREATE TABLE IF NOT EXISTS class_sessions (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  class_id integer NOT NULL,
  session_at timestamptz NOT NULL,
  UNIQUE (class_id, session_at),
  CONSTRAINT class_id_fk FOREIGN KEY (class_id) REFERENCES classes(id)
);