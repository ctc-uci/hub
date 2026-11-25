CREATE TABLE time_slots (
  id INTEGER PRIMARY KEY,
  service_id INTEGER REFERENCES services(id) NOT NULL,
  slot_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_enabled BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE(id, service_id),
  UNIQUE(service_id, slot_date, start_time),
  CHECK (end_time > start_time)
);
