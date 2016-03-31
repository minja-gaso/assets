DROP TABLE IF EXISTS blog.blogs CASCADE;
CREATE TABLE IF NOT EXISTS blog.blogs
(
	blog_id bigint NOT NULL DEFAULT id_generator(),
	blog_creation_timestamp timestamp with time zone NOT NULL DEFAULT now(),
	blog_title character varying NOT NULL DEFAULT '',
	blog_pretty_url character varying UNIQUE NOT NULL DEFAULT '',
	blog_screen_public_intro character varying NOT NULL DEFAULT '',
	blog_screen_public_closing character varying NOT NULL DEFAULT '',
	is_blog_deleted boolean NOT NULL DEFAULT false,
	fk_user_id bigint NOT NULL,
	fk_skin_id bigint,
	PRIMARY KEY (blog_id),
	FOREIGN KEY (fk_user_id) REFERENCES public.users (user_id)
);

CREATE OR REPLACE FUNCTION blog_insert_pretty_url() RETURNS trigger AS $blog_insert_pretty_url$
    BEGIN
        NEW.blog_pretty_url := 'calendar-' || NEW.blog_id;
        RETURN NEW;
    END;
$blog_insert_pretty_url$ LANGUAGE plpgsql;

CREATE TRIGGER trig_blog_insert BEFORE INSERT ON blog.blogs
    FOR EACH ROW EXECUTE PROCEDURE blog_insert_pretty_url();

DROP TABLE IF EXISTS blog.categories CASCADE;
CREATE TABLE IF NOT EXISTS blog.categories
(
	category_id bigint DEFAULT id_generator(),
	category_label character varying NOT NULL DEFAULT '',
	fk_blog_id bigint NOT NULL,
	PRIMARY KEY (category_id),
	FOREIGN KEY (fk_blog_id) REFERENCES blog.blogs (blog_id)
);

DROP TABLE IF EXISTS blog.roles CASCADE;
CREATE TABLE IF NOT EXISTS blog.roles
(
	role_id bigint DEFAULT id_generator(),
	role_type character varying NOT NULL,
	role_email character varying NOT NULL,
	fk_blog_id bigint NOT NULL,
	UNIQUE (role_type, role_email, fk_blog_id),
	PRIMARY KEY (role_id),
	FOREIGN KEY (fk_blog_id) REFERENCES blog.blogs (blog_id)
);

DROP TABLE IF EXISTS blog.topics CASCADE;
CREATE TABLE IF NOT EXISTS blog.topics
(
	topic_id bigint DEFAULT id_generator(),
	is_topic_published boolean NOT NULL DEFAULT false,
	topic_publish_date date NOT NULL DEFAULT current_date,
	topic_publish_time time without time zone NOT NULL DEFAULT '08:00:00',
	topic_title character varying NOT NULL DEFAULT '',
	topic_summary character varying NOT NULL DEFAULT '',
	topic_article character varying NOT NULL DEFAULT '',
	fk_blog_id bigint NOT NULL,
	PRIMARY KEY (topic_id),
	FOREIGN KEY (fk_blog_id) REFERENCES blog.blogs (blog_id)
);

DROP TABLE IF EXISTS blog.topic_files CASCADE;
CREATE TABLE IF NOT EXISTS blog.topic_files
(
	topic_file_id bigint DEFAULT id_generator(),
	topic_file_type character varying NOT NULL DEFAULT '',
	topic_file_name character varying NOT NULL DEFAULT '',
	topic_file_description character varying NOT NULL DEFAULT '',
	fk_topic_id bigint NOT NULL,
	PRIMARY KEY (topic_file_id),
	FOREIGN KEY (fk_topic_id) REFERENCES blog.topics (topic_id)
);

DROP TABLE IF EXISTS blog.tags CASCADE;
CREATE TABLE IF NOT EXISTS blog.tags
(
	topic_tag_id bigint DEFAULT id_generator(),
	topic_tag_name character varying NOT NULL,
	fk_topic_id bigint NOT NULL,
	fk_blog_id bigint NOT NULL,
	PRIMARY KEY (topic_tag_id),
	FOREIGN KEY (fk_topic_id) REFERENCES blog.topics (topic_id)
		ON DELETE CASCADE,
	FOREIGN KEY (fk_blog_id) REFERENCES blog.blogs (blog_id)
		ON DELETE CASCADE
);