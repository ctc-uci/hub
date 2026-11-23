--id = primary key, uq1
--field_id, foreign key, uq1/2, not null, on delete restrict
--label, uq2, not null
--sort_order, not null

CREATE TABLE demographic_field_options (
    id SERIAL PRIMARY KEY,
    field_id INT NOT NULL REFERENCES demographic_fields(id) ON DELETE RESTRICT,
    label TEXT NOT NULL,
    sort_order INT NOT NULL,

    --UQ1: prevent storing an unrelated response under the wrong question
    CONSTRAINT uq_id_field_id UNIQUE (id, field_id),

    --UQ2: prevents duplicate options under the same question
    CONSTRAINT uq_field_id_label UNIQUE (field_id, label)
);