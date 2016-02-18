DROP TABLE IF EXISTS calendar.calendars CASCADE;
CREATE TABLE IF NOT EXISTS calendar.calendars
(
	calendar_id bigint NOT NULL DEFAULT id_generator(),
	calendar_creation_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	calendar_type character varying NOT NULL DEFAULT 'event',
	calendar_title character varying NOT NULL DEFAULT '',
	calendar_pretty_url character varying UNIQUE NOT NULL DEFAULT '',
	calendar_skin_url character varying NOT NULL DEFAULT '',
	calendar_skin_selector character varying NOT NULL DEFAULT '',
	calendar_screen_public_calendar_intro character varying NOT NULL DEFAULT '',
	calendar_screen_public_calendar_closing character varying NOT NULL DEFAULT '',
	is_calendar_deleted boolean NOT NULL DEFAULT false,
	fk_user_id bigint NOT NULL,
	PRIMARY KEY (calendar_id),
	FOREIGN KEY (fk_user_id) REFERENCES public.users (user_id)
);

CREATE OR REPLACE FUNCTION calendar_insert_pretty_url() RETURNS trigger AS $calendar_insert_pretty_url$
    BEGIN
        NEW.calendar_pretty_url := 'calendar-' || NEW.calendar_id;
        RETURN NEW;
    END;
$calendar_insert_pretty_url$ LANGUAGE plpgsql;

CREATE TRIGGER trig_calendar_insert BEFORE INSERT ON calendar.calendars
    FOR EACH ROW EXECUTE PROCEDURE calendar_insert_pretty_url();

DROP TABLE IF EXISTS calendar.categories CASCADE;
CREATE TABLE IF NOT EXISTS calendar.categories
(
	category_id bigint DEFAULT id_generator(),
	category_label character varying NOT NULL DEFAULT '',
	fk_calendar_id bigint NOT NULL,
	PRIMARY KEY (category_id),
	FOREIGN KEY (fk_calendar_id) REFERENCES calendar.calendars (calendar_id)
);

DROP TABLE IF EXISTS calendar.roles CASCADE;
CREATE TABLE IF NOT EXISTS calendar.roles
(
	role_id bigint DEFAULT id_generator(),
	role_type character varying NOT NULL,
	role_email character varying NOT NULL,
	fk_calendar_id bigint NOT NULL,
	UNIQUE (role_type, role_email, fk_calendar_id),
	PRIMARY KEY (role_id),
	FOREIGN KEY (fk_calendar_id) REFERENCES calendar.calendars (calendar_id)
);

DROP TABLE IF EXISTS calendar.events CASCADE;
CREATE TABLE IF NOT EXISTS calendar.events
(
	event_id bigint DEFAULT id_generator(),
	is_event_published boolean NOT NULL DEFAULT false,
	event_start_date date NOT NULL DEFAULT current_date,
	event_start_time time without time zone NOT NULL DEFAULT '08:00:00',
	event_end_date date NOT NULL DEFAULT current_date,
	event_end_time time without time zone NOT NULL DEFAULT '09:00:00',
	event_title character varying NOT NULL DEFAULT '',
	event_title_recurring_label character varying NOT NULL DEFAULT '',
	is_event_location_owned boolean NOT NULL DEFAULT true,
	event_location character varying NOT NULL DEFAULT '',
	event_location_additional_information character varying NOT NULL DEFAULT '',
	event_description character varying NOT NULL DEFAULT '',
	event_agenda character varying NOT NULL DEFAULT '',
	event_speaker character varying NOT NULL DEFAULT '',
	event_registration_label character varying NOT NULL DEFAULT '',
	event_registration_url character varying NOT NULL DEFAULT '',
	event_contact_name character varying NOT NULL DEFAULT '',
	event_contact_phone character varying NOT NULL DEFAULT '',
	event_contact_email character varying NOT NULL DEFAULT '',
	event_cost character varying NOT NULL DEFAULT '',
	event_image_file_name character varying NOT NULL DEFAULT '',
	event_image_file_description character varying NOT NULL DEFAULT '',
	is_event_recurring boolean NOT NULL DEFAULT false,
	is_event_recurring_visible_on_list_screen boolean NOT NULL DEFAULT true,
	is_event_recurring_monthly boolean NOT NULL DEFAULT false,
	event_recurring_type character varying NOT NULL DEFAULT 'date',
	-- can be date or interval
	event_recurring_limit int NOT NULL DEFAULT 10,
	event_recurring_interval int NOT NULL DEFAULT 1,
	event_recurring_interval_type character varying NOT NULL DEFAULT 'week',
	is_event_recurring_monday boolean NOT NULL DEFAULT false,
	is_event_recurring_tuesday boolean NOT NULL DEFAULT false,
	is_event_recurring_wednesday boolean NOT NULL DEFAULT false,
	is_event_recurring_thursday boolean NOT NULL DEFAULT false,
	is_event_recurring_friday boolean NOT NULL DEFAULT false,
	is_event_recurring_saturday boolean NOT NULL DEFAULT false,
	is_event_recurring_sunday boolean NOT NULL DEFAULT false,
	is_event_recurring_day_exact boolean NOT NULL DEFAULT false,
	event_parent_id bigint NOT NULL DEFAULT 0,
	fk_category_id bigint NOT NULL DEFAULT 0,
	fk_calendar_id bigint NOT NULL,
	PRIMARY KEY (event_id),
	--FOREIGN KEY (fk_category_id) REFERENCES calendar.categories (category_id),
	FOREIGN KEY (fk_calendar_id) REFERENCES calendar.calendars (calendar_id)
);

DROP TABLE IF EXISTS calendar.event_tags CASCADE;
CREATE TABLE IF NOT EXISTS calendar.event_tags
(
	event_tag_id bigint DEFAULT id_generator(),
	event_tag_name character varying NOT NULL,
	fk_event_id bigint NOT NULL,
	PRIMARY KEY (event_tag_id),
	FOREIGN KEY (fk_event_id) REFERENCES calendar.events (event_id)
);