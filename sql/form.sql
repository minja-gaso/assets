﻿DROP SCHEMA IF EXISTS form CASCADE;
CREATE SCHEMA IF NOT EXISTS form;

DROP TABLE IF EXISTS form.forms CASCADE;
CREATE TABLE IF NOT EXISTS form.forms
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
	form_start_date date NOT NULL DEFAULT current_date,
	form_end_date date NOT NULL DEFAULT '2099-12-31',
	is_form_deleted boolean NOT NULL DEFAULT false,
	fk_user_id bigint NOT NULL,
	fk_skin_id bigint,
	PRIMARY KEY (form_id),
	FOREIGN KEY (fk_user_id) REFERENCES users (user_id)
);

CREATE OR REPLACE FUNCTION form_insert_pretty_url() RETURNS trigger AS $form_insert_pretty_url$
    BEGIN
        NEW.form_pretty_url := 'form-' || NEW.form_id;
        RETURN NEW;
    END;
$form_insert_pretty_url$ LANGUAGE plpgsql;

CREATE TRIGGER trig_form_insert BEFORE INSERT ON form.forms
    FOR EACH ROW EXECUTE PROCEDURE form_insert_pretty_url();

DROP TABLE IF EXISTS form.roles CASCADE;
CREATE TABLE IF NOT EXISTS form.roles
(
	role_id bigint DEFAULT id_generator(),
	role_type character varying NOT NULL,
	role_email character varying NOT NULL,
	fk_form_id bigint NOT NULL,
	UNIQUE (role_type, role_email, fk_form_id),
	PRIMARY KEY (role_id),
	FOREIGN KEY (fk_form_id) REFERENCES form.forms (form_id)
);

DROP TABLE IF EXISTS form.questions CASCADE;
CREATE TABLE IF NOT EXISTS form.questions
(
	question_id bigint DEFAULT id_generator(),
	question_number integer NOT NULL DEFAULT 1,
	question_type character varying NOT NULL DEFAULT 'text',
	question_header character varying NOT NULL DEFAULT '',
	question_label character varying NOT NULL DEFAULT '',
	question_page integer NOT NULL DEFAULT 1,
	question_default_value character varying NOT NULL DEFAULT '',
	question_filter character varying NOT NULL DEFAULT 'none',
	question_max_character_limit integer NOT NULL DEFAULT 0,
	question_max_word_limit integer NOT NULL DEFAULT 0,
	is_question_required boolean NOT NULL DEFAULT false,
	fk_form_id bigint,
	PRIMARY KEY (question_id),
	FOREIGN KEY (fk_form_id) REFERENCES form.forms (form_id)
);

DROP TABLE IF EXISTS form.answers CASCADE;
CREATE TABLE IF NOT EXISTS form.answers
(
	answer_id bigint DEFAULT id_generator(),
	answer_number integer NOT NULL DEFAULT 1,
	answer_label character varying NOT NULL DEFAULT '',
	fk_question_id bigint,
	PRIMARY KEY (answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES form.questions (question_id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS form.form_answers CASCADE;
CREATE TABLE IF NOT EXISTS form.form_answers
(
	answer_id bigint DEFAULT id_generator(),
	answer_label character varying NOT NULL DEFAULT '',
	answer_value integer NOT NULL DEFAULT 0,
	fk_form_id bigint,
	PRIMARY KEY (answer_id),
	FOREIGN KEY (fk_form_id) REFERENCES form.forms (form_id)
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS form.form_scores CASCADE;
CREATE TABLE IF NOT EXISTS form.form_scores
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
	FOREIGN KEY(fk_form_id) REFERENCES form.forms(form_id)
);

DROP TABLE IF EXISTS form.submissions CASCADE;
CREATE TABLE IF NOT EXISTS form.submissions
(
	submission_id bigint DEFAULT id_generator(),
	submission_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	fk_form_id bigint NOT NULL,
	PRIMARY KEY (submission_id),
	FOREIGN KEY (fk_form_id) REFERENCES form.forms (form_id)
);

DROP TABLE IF EXISTS form.submission_answers CASCADE;
CREATE TABLE IF NOT EXISTS form.submission_answers
(
	sub_answer_id bigint DEFAULT id_generator(),
	sub_answer_value character varying NOT NULL,
	is_sub_answer_multiple_choice boolean NOT NULL DEFAULT false,
	fk_question_id bigint NOT NULL,
	fk_submission_id bigint NOT NULL,
	PRIMARY KEY (sub_answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES form.questions (question_id),
	FOREIGN KEY (fk_submission_id) REFERENCES form.submissions (submission_id)
);

DROP TABLE IF EXISTS form.temp_submissions CASCADE;
CREATE TABLE IF NOT EXISTS form.temp_submissions
(
	submission_id bigint DEFAULT id_generator(),
	submission_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	session_id character varying NOT NULL,
	ip_address inet NOT NULL,
	fk_form_id bigint NOT NULL,
	PRIMARY KEY (submission_id),
	FOREIGN KEY (fk_form_id) REFERENCES form.forms (form_id)
);

DROP TABLE IF EXISTS form.temp_submission_answers CASCADE;
CREATE TABLE IF NOT EXISTS form.temp_submission_answers
(
	sub_answer_id bigint DEFAULT id_generator(),
	sub_answer_value character varying NOT NULL DEFAULT 0,
	sub_page int NOT NULL,
	is_sub_answer_multiple_choice boolean NOT NULL DEFAULT false,
	fk_question_id bigint NOT NULL,
	fk_submission_id bigint NOT NULL,
	PRIMARY KEY (sub_answer_id),
	FOREIGN KEY (fk_question_id) REFERENCES form.questions (question_id)
		ON DELETE CASCADE,
	FOREIGN KEY (fk_submission_id) REFERENCES form.temp_submissions (submission_id)
);




INSERT INTO form.forms (
form_id,
form_title,
fk_user_id,
form_screen_public_form_intro,
form_screen_public_form_closing
)
VALUES (
1,
'Contact Us',
1,
'<strong>Our Mission & Vision</strong><br/>Baylor Health Care System, based in Dallas, and Scott & White Healthcare, based in Temple, Texas, have formed a new organization that combines the strengths of their two nationally recognized health systems. For an industry undergoing fundamental changes, Baylor Scott & White Health provides a new vision and more resources, offering patients continued exceptional care.',
'<strong>Privacy Policy</strong><br/>Baylor Scott & White respects the privacy of its users and is the sole owner of the information collected on this website (http://baylorscottandwhite.com) or through any of its software applications. Any information collected from our users will not be sold, shared, or rented to others in ways different from what is disclosed in this privacy statement.'
);
UPDATE form.forms SET form_pretty_url = 'contact-us' WHERE form_id = 1;

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, fk_form_id)
VALUES (1, 1, 'text', 'Name', 'none', false, 1);

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, question_default_value, fk_form_id)
VALUES (2, 2, 'text', 'Email', 'email', true, 'minja.gaso@outlook.com', 1);

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, fk_form_id)
VALUES (3, 3, 'pulldown', 'Which tool is this in regards to?', 'none', true, 1);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (1, 'Standard survey', 3);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (2, 'Self-assessment survey', 3);

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, question_default_value, fk_form_id)
VALUES (4, 4, 'textarea', 'Question or enhancement request', 'none', true, 'I would like to see the option to download PDF reports with answers displayed.', 1);

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, fk_form_id)
VALUES (5, 5, 'radio', 'Which department do you belong to?', 'none', false, 1);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (3, 'Clinical', 5);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (4, 'Marketing', 5);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (5, 'IS', 5);

INSERT INTO form.questions(question_id, question_number, question_type, question_label, question_filter, is_question_required, fk_form_id)
VALUES (6, 6, 'radio', 'Do you have a preference to discuss this matter with a specific person(s)?', 'none', false, 1);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (6, 'Zachary Beggs', 6);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (7, 'Quincy Franklin', 6);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (8, 'Emily Brown', 6);
INSERT INTO form.answers(answer_number, answer_label, fk_question_id) VALUES (9, 'Karen Ancheta', 6);