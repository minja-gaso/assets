DROP SCHEMA IF EXISTS skin CASCADE;
CREATE SCHEMA IF NOT EXISTS skin;

CREATE TABLE skin.skins
(
	skin_id bigint DEFAULT id_generator(),
	skin_title character varying NOT NULL DEFAULT '',
	is_skin_editable boolean NOT NULL DEFAULT false,
	skin_url character varying NOT NULL DEFAULT '',
	skin_selector character varying NOT NULL DEFAULT '',
	fk_user_id bigint NOT NULL,
	PRIMARY KEY (skin_id),
	FOREIGN KEY (fk_user_id) REFERENCES public.users (user_id)
);