CREATE TABLE IF NOT EXISTS classes (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name varchar(256) UNIQUE NOT NULL,
  description text,
  is_active boolean NOT NULL DEFAULT true,
  created_by integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT created_by_fk FOREIGN KEY (created_by) REFERENCES users(id)
);