DROP SCHEMA IF EXISTS sitebuilder CASCADE;
CREATE SCHEMA IF NOT EXISTS sitebuilder;

DROP TABLE IF EXISTS sitebuilder.site CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.site
(
	site_id bigint DEFAULT id_generator(),
	site_creation_timestamp timestamp DEFAULT now(),
	site_title character varying NOT NULL DEFAULT '',
	site_url character varying NOT NULL DEFAULT '',
	site_footer character varying NOT NULL DEFAULT '',
	site_css character varying NOT NULL DEFAULT '',
	is_site_deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (site_id)
);

DROP TABLE IF EXISTS sitebuilder.template CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.template
(
	template_id bigint DEFAULT id_generator(),
	template_creation_timestamp timestamp DEFAULT now(),
	template_title character varying NOT NULL DEFAULT '',
	template_html character varying NOT NULL DEFAULT '',
	is_template_deleted boolean NOT NULL DEFAULT false,
	fk_site_id bigint NOT NULL,
	PRIMARY KEY (template_id),
	FOREIGN KEY (fk_site_id) REFERENCES sitebuilder.site (site_id)
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS sitebuilder.page CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.page
(
	page_id bigint DEFAULT id_generator(),
	page_creation_timestamp timestamp DEFAULT now(),
	page_title character varying NOT NULL DEFAULT '',
	page_subtitle character varying NOT NULL DEFAULT '',
	page_html character varying NOT NULL DEFAULT '',
	page_url character varying NOT NULL DEFAULT '',
	is_page_deleted boolean NOT NULL DEFAULT false,
	fk_template_id bigint,
	fk_site_id bigint NOT NULL,
	PRIMARY KEY (page_id),
	FOREIGN KEY (fk_site_id) REFERENCES sitebuilder.site (site_id)
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS sitebuilder.page_archive CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.page_archive
(
	page_archive_id bigint DEFAULT id_generator(),
	page_archive_creation_timestamp timestamp DEFAULT now(),
	page_archive_title character varying NOT NULL DEFAULT '',
	page_archive_subtitle character varying NOT NULL DEFAULT '',
	page_archive_html character varying NOT NULL DEFAULT '',
	fk_page_id bigint,
	PRIMARY KEY (page_archive_id),
	FOREIGN KEY (fk_page_id) REFERENCES sitebuilder.page (page_id)
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS sitebuilder.component CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.component
(
	component_id bigint DEFAULT id_generator(),
	component_order_number int NOT NULL DEFAULT 1,
	component_type character varying NOT NULL DEFAULT '',
	component_type_value character varying NOT NULL DEFAULT '',
	component_title character varying NOT NULL DEFAULT '',
	component_value character varying NOT NULL DEFAULT '',
	component_style character varying NOT NULL DEFAULT '',
	is_component_item_possible boolean NOT NULL DEFAULT false,
	fk_page_id bigint,
	PRIMARY KEY (component_id),
	FOREIGN KEY (fk_page_id) REFERENCES sitebuilder.page (page_id)
	ON DELETE CASCADE
);

DROP TABLE IF EXISTS sitebuilder.component_item CASCADE;
CREATE TABLE IF NOT EXISTS sitebuilder.component_item
(
	component_item_id bigint DEFAULT id_generator(),
	component_item_title character varying NOT NULL DEFAULT '',
	component_item_html character varying NOT NULL DEFAULT '',
	component_item_order_number int NOT NULL DEFAULT 1,
	fk_component_id bigint,
	PRIMARY KEY (component_item_id),
	FOREIGN KEY (fk_component_id) REFERENCES sitebuilder.component (component_id)
	ON DELETE CASCADE
);

DELETE FROM sitebuilder.component WHERE component_id = 1254479980499306064;