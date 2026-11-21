--id = primary key
--key, unique and not null
--label, not null
--type, not null
--is_required, not null and default false
--sort_order, not null

CREATE TYPE field_type as eNUM (
    'single_select',
    'multi_select',
    'date',
    'text',
    'boolean'
);

CREATE TABLE demographic_fields (
    id SERIAL PRIMARY KEY,
    key TEXT UNIQUE NOT NULL,
    label TEXT NOT NULL,
    type field_type NOT NULL,
    is_required BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order INT NOT NULL
)