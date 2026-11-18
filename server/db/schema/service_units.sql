CREATE TABLE service_units (
  id INTEGER PRIMARY KEY,
  service_id INTEGER REFERENCES services(id) NOT NULL,
  label TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE(id, service_id),
  UNIQUE(service_id, label)
);
