CREATE SEQUENCE global_id_sequence;


CREATE OR REPLACE FUNCTION id_generator(OUT result bigint) AS $$
DECLARE
    our_epoch bigint := 1314220021721;
    seq_id bigint;
    now_millis bigint;
    -- the id of this DB shard, must be set for each
    -- schema shard you have - you could pass this as a parameter too
    shard_id int := 1;
BEGIN
    SELECT nextval('global_id_sequence') % 1024 INTO seq_id;

SELECT FLOOR(EXTRACT(EPOCH FROM clock_timestamp()) * 1000) INTO now_millis;
    result := (now_millis - our_epoch) << 23;
    result := result | (shard_id << 10);
    result := result | (seq_id);
END;
$$ LANGUAGE PLPGSQL;



DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users
(
	user_id bigint DEFAULT id_generator(),
	user_email character varying NOT NULL,
	user_first_name character varying NOT NULL DEFAULT '',
	user_last_name character varying NOT NULL DEFAULT '',
	user_profile_image character varying NOT NULL DEFAULT '',
	is_user_active boolean NOT NULL DEFAULT false,
	is_user_admin boolean NOT NULL DEFAULT false,
	CONSTRAINT users_pkey PRIMARY KEY (user_id)
);

INSERT INTO users(user_id, user_email, user_first_name, user_last_name) VALUES (1, 'minja.gaso@bswhealth.org', 'Minja', 'Gaso');
INSERT INTO users(user_id, user_email, user_first_name, user_last_name) VALUES (2, 'zachary.beggs@bswhealth.org', 'Zachary', 'Beggs');
