
CREATE TABLE IF NOT EXISTS public.alerts (
    id INTEGER GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ), 
    check_in_id INTEGER,
    flag_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT alerts_pk PRIMARY KEY (id),
    CONSTRAINT alerts_check_in_id_fk FOREIGN KEY (check_in_id) REFERENCES public.check_ins(id),
    CONSTRAINT alerts_flag_id_fk FOREIGN KEY (flag_id) REFERENCES public.patron_flags(id),
    CONSTRAINT alerts_check_in_id_flag_id_uq UNIQUE (check_in_id, flag_id)

);