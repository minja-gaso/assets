DROP SCHEMA IF EXISTS sitebuilder CASCADE;
CREATE SCHEMA IF NOT EXISTS sitebuilder;

DROP TABLE IF EXISTS sitebuilder.site;
CREATE TABLE IF NOT EXISTS sitebuilder.site
(
	site_id bigint DEFAULT id_generator(),
	site_creation_timestamp timestamp DEFAULT now(),
	site_title character varying NOT NULL DEFAULT '',
	is_site_deleted boolean NOT NULL DEFAULT false,
	site_url character varying NOT NULL DEFAULT '',
	site_css character varying NOT NULL DEFAULT '',
	is_site_deleted boolean NOT NULL DEFAULT false,
	PRIMARY KEY (site_id)
);

ALTER TABLE sitebuilder.site RENAME COLUMN is_site_editable TO is_site_deleted;

SELECT * FROM sitebuilder.site;

DROP TABLE IF EXISTS sitebuilder.template;
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
);

DROP TABLE IF EXISTS sitebuilder.page;
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
	PRIMARY KEY (page_id),
	FOREIGN KEY (fk_template_id) REFERENCES sitebuilder.template (template_id)
);

