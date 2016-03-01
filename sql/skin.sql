DROP SCHEMA IF EXISTS skin CASCADE;
CREATE SCHEMA IF NOT EXISTS skin;

DROP TABLE IF EXISTS skin.skins;
CREATE TABLE IF NOT EXISTS skin.skins
(
	skin_id bigint DEFAULT id_generator(),
	skin_creation_timestamp timestamp DEFAULT now(),
	skin_title character varying NOT NULL DEFAULT '',
	is_skin_editable boolean NOT NULL DEFAULT false,
	skin_url character varying NOT NULL DEFAULT '',
	skin_selector character varying NOT NULL DEFAULT '',
	skin_css_overrides character varying NOT NULL DEFAULT '',
	skin_html character varying NOT NULL DEFAULT '',
	skin_calendar_css character varying NOT NULL DEFAULT '',
	skin_form_css character varying NOT NULL DEFAULT '',
	is_skin_deleted boolean NOT NULL DEFAULT false,
	fk_user_id bigint NOT NULL,
	PRIMARY KEY (skin_id),
	FOREIGN KEY (fk_user_id) REFERENCES public.users (user_id)
);

DROP TABLE IF EXISTS skin.roles CASCADE;
CREATE TABLE IF NOT EXISTS skin.roles
(
	role_id bigint DEFAULT id_generator(),
	role_type character varying NOT NULL,
	role_email character varying NOT NULL,
	fk_skin_id bigint NOT NULL,
	UNIQUE (role_type, role_email, fk_skin_id),
	PRIMARY KEY (role_id),
	FOREIGN KEY (fk_skin_id) REFERENCES skin.skins (skin_id)
);

ALTER TABLE skin.skins ADD COLUMN skin_form_css character varying NOT NULL DEFAULT ''