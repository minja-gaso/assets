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

DROP TABLE IF EXISTS forms CASCADE;
CREATE TABLE IF NOT EXISTS forms
(
	form_id bigint DEFAULT id_generator(),
	form_creation_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	form_type character varying NOT NULL DEFAULT 'survey',
	form_status character varying NOT NULL DEFAULT 'draft',
	form_title character varying NOT NULL DEFAULT '',
	form_pretty_url character varying UNIQUE NOT NULL DEFAULT '',
	form_max_submissions integer NOT NULL DEFAULT 0,
	form_submission_count integer NOT NULL DEFAULT 0,
	form_return_url character varying NOT NULL DEFAULT '',
	form_skin_url character varying NOT NULL DEFAULT '',
	form_skin_selector character varying NOT NULL DEFAULT '',
	form_screen_ended character varying NOT NULL DEFAULT 'The form has ended.',
	form_screen_max_submitted character varying NOT NULL DEFAULT 'The maximum number of submissions has been reached.',
	form_screen_not_started character varying NOT NULL DEFAULT 'The form has not started yet.',
	form_screen_one_submission character varying NOT NULL DEFAULT 'You may only submit the form once.',
	form_screen_public_form_intro character varying NOT NULL DEFAULT '',
	form_screen_public_form_closing character varying NOT NULL DEFAULT '',	
	form_screen_thank_you character varying NOT NULL DEFAULT 'Thank you for your submission.',
	is_form_deleted boolean NOT NULL DEFAULT false,
	fk_user_id bigint NOT NULL,
	PRIMARY KEY (form_id),
	FOREIGN KEY (fk_user_id) REFERENCES users (user_id)
);

CREATE OR REPLACE FUNCTION form_insert_pretty_url() RETURNS trigger AS $form_insert_pretty_url$
    BEGIN
        NEW.form_pretty_url := 'form-' || NEW.form_id;
        RETURN NEW;
    END;
$form_insert_pretty_url$ LANGUAGE plpgsql;

CREATE TRIGGER trig_form_insert BEFORE INSERT ON forms
    FOR EACH ROW EXECUTE PROCEDURE form_insert_pretty_url();

DROP TABLE IF EXISTS questions CASCADE;
CREATE TABLE IF NOT EXISTS questions
(
	question_id bigint DEFAULT id_generator(),
	question_number integer NOT NULL DEFAULT 1,
	question_type character varying NOT NULL DEFAULT 'text',
	question_label character varying NOT NULL DEFAULT '',
	question_page integer NOT NULL DEFAULT 1,
	question_default_value character varying NOT NULL DEFAULT '',
	question_filter character varying NOT NULL DEFAULT 'none',
	question_max_character_limit integer NOT NULL DEFAULT 0,
	question_max_word_limit integer NOT NULL DEFAULT 0,
	is_question_required boolean NOT NULL DEFAULT false,
	fk_form_id bigint,
	PRIMARY KEY (question_id),
	FOREIGN KEY (fk_form_id) REFERENCES forms (form_id)
);

DROP TABLE IF EXISTS answers CASCADE;
CREATE TABLE IF NOT EXISTS answers
(
	answer_id bigint DEFAULT id_generator(),
	answer_number integer NOT NULL DEFAULT 1,
	answer_label character varying NOT NULL DEFAULT '',
	fk_question_id bigint,
	PRIMARY KEY (answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES questions (question_id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS answers CASCADE;
CREATE TABLE IF NOT EXISTS answers
(
	answer_id bigint DEFAULT id_generator(),
	answer_number integer NOT NULL DEFAULT 1,
	answer_label character varying NOT NULL DEFAULT '',
	fk_question_id bigint,
	PRIMARY KEY (answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES questions (question_id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS form_answers CASCADE;
CREATE TABLE IF NOT EXISTS form_answers
(
	answer_id bigint DEFAULT id_generator(),
	answer_label character varying NOT NULL DEFAULT '',
	answer_value integer NOT NULL DEFAULT 0,
	fk_form_id bigint,
	PRIMARY KEY (answer_id),
	FOREIGN KEY (fk_form_id) REFERENCES forms (form_id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS form_scores CASCADE;
CREATE TABLE IF NOT EXISTS form_scores
(
	score_id bigint NOT NULL DEFAULT id_generator(),
	score_range_begin integer NOT NULL DEFAULT 0,
	score_range_end integer NOT NULL DEFAULT 1,
	score_title character varying NOT NULL DEFAULT '',
	score_summary character varying NOT NULL DEFAULT '',
	score_redirect_url character varying NOT NULL DEFAULT '',
	score_redirect_timer int NOT NULL DEFAULT 5,
	fk_form_id bigint NOT NULL,
	PRIMARY KEY(score_id),
	FOREIGN KEY(fk_form_id) REFERENCES forms(form_id)
);

DROP TABLE IF EXISTS submissions CASCADE;
CREATE TABLE IF NOT EXISTS submissions
(
	submission_id bigint DEFAULT id_generator(),
	submission_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	fk_form_id bigint NOT NULL,
	PRIMARY KEY (submission_id),
	FOREIGN KEY (fk_form_id) REFERENCES forms (form_id)
);

DROP TABLE IF EXISTS submission_answers CASCADE;
CREATE TABLE IF NOT EXISTS submission_answers
(
	sub_answer_id bigint DEFAULT id_generator(),
	sub_answer_value character varying NOT NULL,
	is_sub_answer_multiple_choice boolean NOT NULL DEFAULT false,
	fk_question_id bigint NOT NULL,
	fk_submission_id bigint NOT NULL,
	PRIMARY KEY (sub_answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES questions (question_id),
	FOREIGN KEY (fk_submission_id) REFERENCES submissions (submission_id)
);

DROP TABLE IF EXISTS temp_submissions CASCADE;
CREATE TABLE IF NOT EXISTS temp_submissions
(
	submission_id bigint DEFAULT id_generator(),
	submission_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	session_id character varying NOT NULL,
	fk_form_id bigint NOT NULL,
	PRIMARY KEY (submission_id),
	FOREIGN KEY (fk_form_id) REFERENCES forms (form_id)
);

DROP TABLE IF EXISTS temp_submission_answers CASCADE;
CREATE TABLE IF NOT EXISTS temp_submission_answers
(
	sub_answer_id bigint DEFAULT id_generator(),
	sub_answer_value character varying NOT NULL DEFAULT 0,
	sub_page int NOT NULL,
	is_sub_answer_multiple_choice boolean NOT NULL DEFAULT false,
	fk_question_id bigint NOT NULL,
	fk_submission_id bigint NOT NULL,
	PRIMARY KEY (sub_answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES questions (question_id),
	FOREIGN KEY (fk_submission_id) REFERENCES temp_submissions (submission_id)
);

INSERT INTO users(user_email, user_first_name, user_last_name) VALUES ('gaso@illinois.edu', 'Minja', 'Gaso');
