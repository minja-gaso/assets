﻿DROP SCHEMA IF EXISTS calendar CASCADE;
CREATE SCHEMA IF NOT EXISTS calendar;

DROP TABLE IF EXISTS calendar.calendars CASCADE;
CREATE TABLE IF NOT EXISTS calendar.calendars
(
	calendar_id bigint DEFAULT id_generator(),
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
	FOREIGN KEY (fk_user_id) REFERENCES users (user_id)
);

CREATE OR REPLACE FUNCTION calendar_insert_pretty_url() RETURNS trigger AS $calendar_insert_pretty_url$
    BEGIN
        NEW.calendar_pretty_url := 'calendar-' || NEW.calendar_id;
        RETURN NEW;
    END;
$calendar_insert_pretty_url$ LANGUAGE plpgsql;

CREATE TRIGGER trig_calendar_insert BEFORE INSERT ON calendar.calendars
    FOR EACH ROW EXECUTE PROCEDURE calendar_insert_pretty_url();