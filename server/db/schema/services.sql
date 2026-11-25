CREATE TYPE check_in_mode_type AS ENUM ('slotted', 'ticket_queue');

CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    check_in_mode check_in_mode_type NOT NULL,
    slot_minutes INTEGER,
    waitlist_limit INTEGER,
    CONSTRAINT slot_minutes_check
        CHECK (
            (check_in_mode = 'slotted' AND slot_minutes IS NOT NULL)
            OR
            (check_in_mode = 'ticket_queue' AND slot_minutes IS NULL)
        ),

    CONSTRAINT waitlist_limit_check
        CHECK (
            (check_in_mode = 'slotted' AND waitlist_limit IS NOT NULL)
            OR
            (check_in_mode = 'ticket_queue' AND waitlist_limit IS NULL)
        )
);