CREATE TABLE patron_demographic_answers(
    id INT PRIMARY KEY,

    patron_id INT NOT NULL REFERENCES 
        patrons(id),

    field_id INT NOT NULL REFERENCES 
        demographic_fields(id)
        ON DELETE RESTRICT,

    option_id INT REFERENCES 
        demographic_field_options(id),

    value_text VARCHAR(250),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT UQ1_patron_demo UNIQUE (patron_id, option_id),

    CONSTRAINT FK1
        FOREIGN KEY (option_id, field_id)
        REFERENCES demographic_field_options(id, field_id)
        ON DELETE RESTRICT,
    
    CONSTRAINT CK1_patron CHECK (
        (option_id IS NULL AND value_text IS NOT NULL)
        OR 
        (option_id IS NOT NULL AND value_text IS NULL)
    )
);
