DROP TABLE IF EXISTS check_ins CASCADE;
DROP TYPE IF EXISTS check_ins_status;
CREATE TYPE check_ins_status AS ENUM ('checked_in', 'waitlisted');

CREATE TABLE check_ins (
    id SERIAL PRIMARY KEY,
    patron_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    unit_id INTEGER,
    time_slot_id INTEGER,
    status check_ins_status NOT NULL,
    checked_in_at TIMESTAMPTZ NOT NULL,
    started_at TIMESTAMPTZ,
    ended_at TIMESTAMPTZ,
    checked_in_by INTEGER NOT NULL,
    ticket_given_at TIMESTAMPTZ,
    ticket_given_by INTEGER,
    
    CONSTRAINT ck_started_ended CHECK (
        (started_at IS NULL AND ended_at IS NULL)
        OR
        (started_at IS NOT NULL AND (ended_at IS NULL OR ended_at >= started_at))
    ),
    CONSTRAINT ck_ticket_given_at_and_by CHECK (
        (ticket_given_at IS NOT NULL AND ticket_given_by IS NOT NULL)
        OR
        (ticket_given_at IS NULL AND ticket_given_by IS NULL)
    ),

    CONSTRAINT fk_patron_id FOREIGN KEY (patron_id) REFERENCES patrons(id),
    CONSTRAINT fk_service_id FOREIGN KEY (service_id) REFERENCES services(id),
    CONSTRAINT fk_unit_id FOREIGN KEY (unit_id) REFERENCES service_units(id),
    CONSTRAINT fk_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES time_slots(id),
    CONSTRAINT fk_checked_in_by FOREIGN KEY (checked_in_by) REFERENCES users(id),
    CONSTRAINT fk_ticket_given_by FOREIGN KEY (ticket_given_by) REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_checks_ins_patron_id ON check_ins (patron_id);
CREATE INDEX IF NOT EXISTS idx_checks_ins_service_id ON check_ins (service_id);