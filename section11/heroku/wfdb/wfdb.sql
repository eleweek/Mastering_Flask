--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE actor (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    birthday date,
    deathday date,
    hometown character varying,
    bio text,
    picture character varying
);


ALTER TABLE actor OWNER TO wfdbuser;

--
-- Name: actor_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE actor_id_seq OWNER TO wfdbuser;

--
-- Name: actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE actor_id_seq OWNED BY actor.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE comment (
    id integer NOT NULL,
    text text,
    date timestamp without time zone,
    post_id integer,
    user_id integer
);


ALTER TABLE comment OWNER TO wfdbuser;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_id_seq OWNER TO wfdbuser;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE comment_id_seq OWNED BY comment.id;


--
-- Name: movie; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE movie (
    id integer NOT NULL,
    name character varying,
    release_date date,
    director_id integer,
    summary text
);


ALTER TABLE movie OWNER TO wfdbuser;

--
-- Name: movie_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE movie_id_seq OWNER TO wfdbuser;

--
-- Name: movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE movie_id_seq OWNED BY movie.id;


--
-- Name: movie_role; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE movie_role (
    id integer NOT NULL,
    actor_id integer,
    movie_id integer,
    role_name character varying
);


ALTER TABLE movie_role OWNER TO wfdbuser;

--
-- Name: movie_role_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE movie_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE movie_role_id_seq OWNER TO wfdbuser;

--
-- Name: movie_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE movie_role_id_seq OWNED BY movie_role.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE post (
    id integer NOT NULL,
    title character varying,
    text text,
    publish_date timestamp without time zone,
    user_id integer
);


ALTER TABLE post OWNER TO wfdbuser;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_id_seq OWNER TO wfdbuser;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE post_id_seq OWNED BY post.id;


--
-- Name: post_tags; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE post_tags (
    post_id integer,
    tag_id integer
);


ALTER TABLE post_tags OWNER TO wfdbuser;

--
-- Name: role; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(40),
    description character varying(225)
);


ALTER TABLE role OWNER TO wfdbuser;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO wfdbuser;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_users; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE role_users (
    user_id integer,
    role_id integer
);


ALTER TABLE role_users OWNER TO wfdbuser;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE tag (
    id integer NOT NULL,
    title character varying
);


ALTER TABLE tag OWNER TO wfdbuser;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tag_id_seq OWNER TO wfdbuser;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE tag_id_seq OWNED BY tag.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: wfdbuser
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying,
    password character varying,
    active boolean
);


ALTER TABLE "user" OWNER TO wfdbuser;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: wfdbuser
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO wfdbuser;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wfdbuser
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY actor ALTER COLUMN id SET DEFAULT nextval('actor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY comment ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie ALTER COLUMN id SET DEFAULT nextval('movie_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie_role ALTER COLUMN id SET DEFAULT nextval('movie_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY post ALTER COLUMN id SET DEFAULT nextval('post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY tag ALTER COLUMN id SET DEFAULT nextval('tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY actor (id, first_name, last_name, birthday, deathday, hometown, bio, picture) FROM stdin;
1	Crystal	Riser	1975-06-30	\N	Syracuse, NY	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	/static/pictures/140px-Felixhead.gif
2	Michael	Arends	1936-05-06	2015-01-06	Kittanning, PA	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
3	Tommy	Brown	1975-06-10	\N	Westbury, NY	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
4	Erin	Hensen	1990-10-21	\N	Southfield, MI	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.\n\n	\N
5	Robert	Ward	1966-12-06	\N	Fredericksburg, VA	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
6	Deborah	Smith	1951-08-23	\N	Milwaukee, WI	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
7	Kay	Hoover	1973-03-01	\N	Springfield, IL	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
8	Richard	McBrayer	1963-05-01	\N	Providence Forge, VA	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
9	Charles	Elder	1995-05-13	\N	Columbus, OH	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
10	Gary	Root	1952-05-16	2014-09-08	Elkin, NC	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
11	Antonio	Miller	1978-08-03	\N	Trenton, MO	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
12	Susan	Bray	1968-04-28	\N	Abbyville, KS	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
13	John	Kimbal	1956-09-21	\N	Hollywood, CA	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus cursus dignissim nisi a euismod. Donec ullamcorper convallis eleifend. Quisque quis nulla eros. Etiam et arcu sapien. Praesent fringilla nisi rutrum rhoncus pulvinar. Donec facilisis tempor ex, quis vulputate odio euismod sed. Aenean sed accumsan massa. Vivamus vitae mauris eu lorem rutrum semper. Nam vel lacus id massa tincidunt venenatis nec quis metus. Mauris euismod porta ipsum ut finibus. Curabitur interdum odio eros, eget bibendum nulla lobortis vitae. Donec interdum mollis accumsan. Aliquam gravida, mauris a pretium semper, diam sapien tincidunt massa, ut eleifend leo mauris et ex. Phasellus volutpat cursus pretium. In a scelerisque neque.	\N
14	John	Test	1991-11-11	\N	\N	just test	\N
15	John	Test	1991-11-11	\N	Nowhere	just test	\N
16	John	Test	1991-11-11	\N	Nowhere	new bio	\N
17	John	Test	1991-11-11	\N	Nowhere	new bio	\N
18	John	Test	1991-11-11	\N	Nowhere	new bio	\N
\.


--
-- Name: actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('actor_id_seq', 18, true);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY comment (id, text, date, post_id, user_id) FROM stdin;
1	This is a comment on the post!	2015-05-28 00:00:00	4	1
2	This is another comment by the same user.	2015-05-28 05:00:00	4	1
3	Hello from WTForms	2015-05-28 22:54:31.028314	4	1
4	Hello from WTForms again	2015-05-28 22:54:52.141679	4	1
5	test	2016-06-01 03:12:18.400366	3	1
6	test1	2016-06-20 03:34:39.594124	1	1
7	hello world	2016-06-20 03:35:55.82623	2	1
8	hello world	2016-06-20 03:37:23.656019	3	1
9	hello world 2	2016-06-20 03:37:30.749631	3	1
10	hello world 3	2016-06-20 03:37:43.141204	3	1
11	test	2016-06-26 13:44:37.066031	4	1
12	test3	2016-06-27 04:38:20.815619	4	1
13	hey	2016-10-05 05:20:20.789612	4	2
14	hey2	2016-10-05 05:20:28.648686	4	2
15	hey hey	2016-10-05 05:21:03.442292	4	2
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('comment_id_seq', 15, true);


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY movie (id, name, release_date, director_id, summary) FROM stdin;
1	End Zone 2	2003-02-13	13	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
2	Kill and Kill	2013-10-03	13	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
3	New Gospel Evangelize	1995-10-04	4	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
4	John's Strange Adventure	1986-12-02	9	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
5	Blue Line	2009-08-14	4	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
6	Devils Never Cry	2005-02-17	11	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
7	Steel Cog: The Movie	1998-10-03	13	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
8	Shadow of the Titans	2005-10-18	11	Bacon ipsum dolor amet turducken in commodo hamburger. Cow esse tongue, ham hock ut aute nulla mollit turkey pancetta drumstick est labore tenderloin anim. Consectetur brisket sed qui ham. Filet mignon eu brisket, turkey ullamco ex est nostrud landjaeger meatball chuck incididunt pancetta strip steak.\n\nAliqua short ribs kevin, dolor turducken drumstick alcatra nisi excepteur ad leberkas ut. Turducken beef ribs in enim boudin filet mignon id tempor tail chicken short loin brisket. Prosciutto velit proident ullamco culpa eiusmod shank non turkey pork shankle nisi aliquip et. Pork loin ball tip leberkas, occaecat do esse chicken boudin pancetta shankle. Ut dolore do magna occaecat anim hamburger tail consequat.\n\nSausage non aliqua corned beef short loin. Ground round veniam ribeye flank boudin sed nostrud voluptate. Pork loin pig beef ribs quis ground round in aute sausage short ribs corned beef andouille dolore sed. Cillum esse prosciutto, ullamco ut aliqua brisket nostrud lorem culpa alcatra pork loin short ribs. Officia turducken irure sint jerky boudin tongue, laboris aliquip tenderloin aliqua duis swine.
9	test	2016-10-10	1	test_summary
10	test	2016-10-10	1	test_summary
11	test	2016-10-10	1	test_summary
\.


--
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('movie_id_seq', 11, true);


--
-- Data for Name: movie_role; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY movie_role (id, actor_id, movie_id, role_name) FROM stdin;
1	1	3	Brad B. Stoll
2	1	2	Hero Protagonist
3	1	2	Secondary Character
4	2	4	Leonard J. Holton
5	2	5	Hannah E. Harris
6	2	8	Ignacio A. Fenn
7	2	1	Nathan D. Wilson
8	2	2	Thomas S. Silva
9	3	8	Eleanor N. Holman
10	4	6	Mark P. Dossantos
11	4	7	Howard B. Williams
12	4	3	Barry R. Weaver
13	5	2	Mark R. Smith
14	5	1	John S. Powell
15	5	4	Dean C. Proulx
16	5	5	Philip C. Bradley
17	5	6	Kenneth J. Schutz
18	5	8	Clyde T. Collins
19	6	7	Steven D. Ingram
20	6	2	Korey L. Bottorff
21	7	3	William B. Davis
\.


--
-- Name: movie_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('movie_role_id_seq', 21, true);


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY post (id, title, text, publish_date, user_id) FROM stdin;
1	Blog Post One	Bacon ipsum dolor amet fatback adipisicing andouille pancetta. Incididunt kevin drumstick adipisicing quis andouille. Cupidatat chuck eu est laboris kielbasa proident adipisicing dolor labore. Ham hock cillum nostrud cow frankfurter eu adipisicing drumstick culpa quis picanha ut nulla leberkas. Ham hock salami consequat laboris cow ut, ipsum non bresaola. Sint porchetta dolore chuck, ullamco salami in minim capicola. Ribeye proident do mollit beef.\n\nExercitation shank magna elit tongue. Turkey in jerky veniam mollit ball tip hamburger in, pork ham hock pig eiusmod pork loin meatball elit. Minim occaecat labore sint kielbasa turducken. Irure pastrami commodo salami, do kielbasa jowl. Flank magna incididunt porchetta nisi chicken.\n\nIncididunt pig rump ut, occaecat sint turkey ut cupidatat flank shoulder in. Mollit in turkey chicken, hamburger proident pariatur doner ea cupim meatloaf corned beef. Eu alcatra labore, salami jowl pork porchetta do esse prosciutto turducken enim ex ribeye. Swine venison aute ground round consequat. Pork belly id et pig cow pancetta nisi non kielbasa salami picanha spare ribs voluptate consequat ea. Quis boudin ut shank spare ribs sirloin dolore id.\n\nIncididunt strip steak anim consectetur magna enim filet mignon. Pork chop eiusmod id ut tenderloin. Capicola kielbasa in irure rump. Commodo meatball ea non, est in filet mignon fugiat pork loin nostrud ex beef. Tail lorem venison aliqua pariatur corned beef. Duis prosciutto magna fugiat, minim doner shoulder ullamco eiusmod ground round est. Short ribs turducken anim ex t-bone.\n\nUt kevin turkey incididunt chuck pariatur prosciutto bacon magna kielbasa picanha hamburger anim. Esse id cow shankle consectetur, short ribs ex tenderloin dolor magna excepteur. Exercitation corned beef cillum, pariatur shoulder aliqua ground round consectetur. Salami pork belly cow nisi tempor, pork laboris. Dolore bacon laboris kevin, salami ad dolor et pork t-bone aliqua.\n\nEiusmod aliqua quis, pig doner biltong et irure ribeye. Drumstick flank venison, turkey ullamco reprehenderit voluptate hamburger chuck laborum dolor aute. Pork chop fatback in cupim, t-bone dolore tenderloin beef ribs anim spare ribs quis consectetur incididunt laboris. Pariatur ribeye bacon consequat pastrami, ad pancetta picanha nisi fatback meatball beef ribs quis ullamco est. Short loin cillum ut filet mignon ribeye salami, pariatur short ribs velit ex veniam in duis. Duis doner chicken filet mignon short loin veniam sunt, enim meatball chuck quis laboris.\n\nId et elit occaecat in cow ut fugiat dolore fatback shankle pariatur. Et shankle leberkas sausage tongue in. Pork loin quis ut aliquip biltong leberkas. Proident ground round pancetta ribeye deserunt porchetta short loin andouille do.\n\nSausage aute consequat veniam shoulder corned beef sint turducken meatball shank cupidatat. Short ribs id kevin quis enim consectetur. Pork loin do biltong short loin frankfurter et beef cillum dolor brisket rump enim proident filet mignon meatball. Officia porchetta pig non pariatur tongue rump aute alcatra. Tempor t-bone mollit, dolore venison shank ut andouille ea consequat ad lorem alcatra pariatur. Porchetta cillum chuck spare ribs, drumstick capicola adipisicing. Pig andouille doner exercitation brisket elit landjaeger sirloin.\n\nOccaecat officia deserunt prosciutto do dolore pariatur, pig cupim. Veniam consequat irure, pancetta laboris proident short ribs eu aute. Kevin id sint, ut minim in pork belly veniam. Boudin sunt lorem rump. Ipsum velit id short ribs nisi, eiusmod tail sed. Cillum reprehenderit sunt, sed short ribs shank fatback shoulder shankle exercitation kevin pariatur. Brisket shankle veniam, cow nostrud flank ham hock cupidatat pork landjaeger ball tip ex.\n\nBall tip ham est tenderloin sed. Hamburger aliqua ball tip ham hock laborum deserunt. Cupidatat adipisicing ball tip, ut velit id turkey aliquip. Ut pork consequat brisket prosciutto veniam, esse cillum dolor deserunt velit venison.	2015-04-10 23:37:10.756703	1
2	Blog Post Two	Bacon ipsum dolor amet fatback adipisicing andouille pancetta. Incididunt kevin drumstick adipisicing quis andouille. Cupidatat chuck eu est laboris kielbasa proident adipisicing dolor labore. Ham hock cillum nostrud cow frankfurter eu adipisicing drumstick culpa quis picanha ut nulla leberkas. Ham hock salami consequat laboris cow ut, ipsum non bresaola. Sint porchetta dolore chuck, ullamco salami in minim capicola. Ribeye proident do mollit beef.\n\nExercitation shank magna elit tongue. Turkey in jerky veniam mollit ball tip hamburger in, pork ham hock pig eiusmod pork loin meatball elit. Minim occaecat labore sint kielbasa turducken. Irure pastrami commodo salami, do kielbasa jowl. Flank magna incididunt porchetta nisi chicken.\n\nIncididunt pig rump ut, occaecat sint turkey ut cupidatat flank shoulder in. Mollit in turkey chicken, hamburger proident pariatur doner ea cupim meatloaf corned beef. Eu alcatra labore, salami jowl pork porchetta do esse prosciutto turducken enim ex ribeye. Swine venison aute ground round consequat. Pork belly id et pig cow pancetta nisi non kielbasa salami picanha spare ribs voluptate consequat ea. Quis boudin ut shank spare ribs sirloin dolore id.\n\nIncididunt strip steak anim consectetur magna enim filet mignon. Pork chop eiusmod id ut tenderloin. Capicola kielbasa in irure rump. Commodo meatball ea non, est in filet mignon fugiat pork loin nostrud ex beef. Tail lorem venison aliqua pariatur corned beef. Duis prosciutto magna fugiat, minim doner shoulder ullamco eiusmod ground round est. Short ribs turducken anim ex t-bone.\n\nUt kevin turkey incididunt chuck pariatur prosciutto bacon magna kielbasa picanha hamburger anim. Esse id cow shankle consectetur, short ribs ex tenderloin dolor magna excepteur. Exercitation corned beef cillum, pariatur shoulder aliqua ground round consectetur. Salami pork belly cow nisi tempor, pork laboris. Dolore bacon laboris kevin, salami ad dolor et pork t-bone aliqua.\n\nEiusmod aliqua quis, pig doner biltong et irure ribeye. Drumstick flank venison, turkey ullamco reprehenderit voluptate hamburger chuck laborum dolor aute. Pork chop fatback in cupim, t-bone dolore tenderloin beef ribs anim spare ribs quis consectetur incididunt laboris. Pariatur ribeye bacon consequat pastrami, ad pancetta picanha nisi fatback meatball beef ribs quis ullamco est. Short loin cillum ut filet mignon ribeye salami, pariatur short ribs velit ex veniam in duis. Duis doner chicken filet mignon short loin veniam sunt, enim meatball chuck quis laboris.\n\nId et elit occaecat in cow ut fugiat dolore fatback shankle pariatur. Et shankle leberkas sausage tongue in. Pork loin quis ut aliquip biltong leberkas. Proident ground round pancetta ribeye deserunt porchetta short loin andouille do.\n\nSausage aute consequat veniam shoulder corned beef sint turducken meatball shank cupidatat. Short ribs id kevin quis enim consectetur. Pork loin do biltong short loin frankfurter et beef cillum dolor brisket rump enim proident filet mignon meatball. Officia porchetta pig non pariatur tongue rump aute alcatra. Tempor t-bone mollit, dolore venison shank ut andouille ea consequat ad lorem alcatra pariatur. Porchetta cillum chuck spare ribs, drumstick capicola adipisicing. Pig andouille doner exercitation brisket elit landjaeger sirloin.\n\nOccaecat officia deserunt prosciutto do dolore pariatur, pig cupim. Veniam consequat irure, pancetta laboris proident short ribs eu aute. Kevin id sint, ut minim in pork belly veniam. Boudin sunt lorem rump. Ipsum velit id short ribs nisi, eiusmod tail sed. Cillum reprehenderit sunt, sed short ribs shank fatback shoulder shankle exercitation kevin pariatur. Brisket shankle veniam, cow nostrud flank ham hock cupidatat pork landjaeger ball tip ex.\n\nBall tip ham est tenderloin sed. Hamburger aliqua ball tip ham hock laborum deserunt. Cupidatat adipisicing ball tip, ut velit id turkey aliquip. Ut pork consequat brisket prosciutto veniam, esse cillum dolor deserunt velit venison.	2015-04-15 00:00:00	1
3	Blog Post Three	Bacon ipsum dolor amet fatback adipisicing andouille pancetta. Incididunt kevin drumstick adipisicing quis andouille. Cupidatat chuck eu est laboris kielbasa proident adipisicing dolor labore. Ham hock cillum nostrud cow frankfurter eu adipisicing drumstick culpa quis picanha ut nulla leberkas. Ham hock salami consequat laboris cow ut, ipsum non bresaola. Sint porchetta dolore chuck, ullamco salami in minim capicola. Ribeye proident do mollit beef.\n\nExercitation shank magna elit tongue. Turkey in jerky veniam mollit ball tip hamburger in, pork ham hock pig eiusmod pork loin meatball elit. Minim occaecat labore sint kielbasa turducken. Irure pastrami commodo salami, do kielbasa jowl. Flank magna incididunt porchetta nisi chicken.\n\nIncididunt pig rump ut, occaecat sint turkey ut cupidatat flank shoulder in. Mollit in turkey chicken, hamburger proident pariatur doner ea cupim meatloaf corned beef. Eu alcatra labore, salami jowl pork porchetta do esse prosciutto turducken enim ex ribeye. Swine venison aute ground round consequat. Pork belly id et pig cow pancetta nisi non kielbasa salami picanha spare ribs voluptate consequat ea. Quis boudin ut shank spare ribs sirloin dolore id.\n\nIncididunt strip steak anim consectetur magna enim filet mignon. Pork chop eiusmod id ut tenderloin. Capicola kielbasa in irure rump. Commodo meatball ea non, est in filet mignon fugiat pork loin nostrud ex beef. Tail lorem venison aliqua pariatur corned beef. Duis prosciutto magna fugiat, minim doner shoulder ullamco eiusmod ground round est. Short ribs turducken anim ex t-bone.\n\nUt kevin turkey incididunt chuck pariatur prosciutto bacon magna kielbasa picanha hamburger anim. Esse id cow shankle consectetur, short ribs ex tenderloin dolor magna excepteur. Exercitation corned beef cillum, pariatur shoulder aliqua ground round consectetur. Salami pork belly cow nisi tempor, pork laboris. Dolore bacon laboris kevin, salami ad dolor et pork t-bone aliqua.\n\nEiusmod aliqua quis, pig doner biltong et irure ribeye. Drumstick flank venison, turkey ullamco reprehenderit voluptate hamburger chuck laborum dolor aute. Pork chop fatback in cupim, t-bone dolore tenderloin beef ribs anim spare ribs quis consectetur incididunt laboris. Pariatur ribeye bacon consequat pastrami, ad pancetta picanha nisi fatback meatball beef ribs quis ullamco est. Short loin cillum ut filet mignon ribeye salami, pariatur short ribs velit ex veniam in duis. Duis doner chicken filet mignon short loin veniam sunt, enim meatball chuck quis laboris.\n\nId et elit occaecat in cow ut fugiat dolore fatback shankle pariatur. Et shankle leberkas sausage tongue in. Pork loin quis ut aliquip biltong leberkas. Proident ground round pancetta ribeye deserunt porchetta short loin andouille do.\n\nSausage aute consequat veniam shoulder corned beef sint turducken meatball shank cupidatat. Short ribs id kevin quis enim consectetur. Pork loin do biltong short loin frankfurter et beef cillum dolor brisket rump enim proident filet mignon meatball. Officia porchetta pig non pariatur tongue rump aute alcatra. Tempor t-bone mollit, dolore venison shank ut andouille ea consequat ad lorem alcatra pariatur. Porchetta cillum chuck spare ribs, drumstick capicola adipisicing. Pig andouille doner exercitation brisket elit landjaeger sirloin.\n\nOccaecat officia deserunt prosciutto do dolore pariatur, pig cupim. Veniam consequat irure, pancetta laboris proident short ribs eu aute. Kevin id sint, ut minim in pork belly veniam. Boudin sunt lorem rump. Ipsum velit id short ribs nisi, eiusmod tail sed. Cillum reprehenderit sunt, sed short ribs shank fatback shoulder shankle exercitation kevin pariatur. Brisket shankle veniam, cow nostrud flank ham hock cupidatat pork landjaeger ball tip ex.\n\nBall tip ham est tenderloin sed. Hamburger aliqua ball tip ham hock laborum deserunt. Cupidatat adipisicing ball tip, ut velit id turkey aliquip. Ut pork consequat brisket prosciutto veniam, esse cillum dolor deserunt velit venison.	2015-05-01 00:00:00	1
4	Blog Post Four	Bacon ipsum dolor amet fatback adipisicing andouille pancetta. Incididunt kevin drumstick adipisicing quis andouille. Cupidatat chuck eu est laboris kielbasa proident adipisicing dolor labore. Ham hock cillum nostrud cow frankfurter eu adipisicing drumstick culpa quis picanha ut nulla leberkas. Ham hock salami consequat laboris cow ut, ipsum non bresaola. Sint porchetta dolore chuck, ullamco salami in minim capicola. Ribeye proident do mollit beef.\n\nExercitation shank magna elit tongue. Turkey in jerky veniam mollit ball tip hamburger in, pork ham hock pig eiusmod pork loin meatball elit. Minim occaecat labore sint kielbasa turducken. Irure pastrami commodo salami, do kielbasa jowl. Flank magna incididunt porchetta nisi chicken.\n\nIncididunt pig rump ut, occaecat sint turkey ut cupidatat flank shoulder in. Mollit in turkey chicken, hamburger proident pariatur doner ea cupim meatloaf corned beef. Eu alcatra labore, salami jowl pork porchetta do esse prosciutto turducken enim ex ribeye. Swine venison aute ground round consequat. Pork belly id et pig cow pancetta nisi non kielbasa salami picanha spare ribs voluptate consequat ea. Quis boudin ut shank spare ribs sirloin dolore id.\n\nIncididunt strip steak anim consectetur magna enim filet mignon. Pork chop eiusmod id ut tenderloin. Capicola kielbasa in irure rump. Commodo meatball ea non, est in filet mignon fugiat pork loin nostrud ex beef. Tail lorem venison aliqua pariatur corned beef. Duis prosciutto magna fugiat, minim doner shoulder ullamco eiusmod ground round est. Short ribs turducken anim ex t-bone.\n\nUt kevin turkey incididunt chuck pariatur prosciutto bacon magna kielbasa picanha hamburger anim. Esse id cow shankle consectetur, short ribs ex tenderloin dolor magna excepteur. Exercitation corned beef cillum, pariatur shoulder aliqua ground round consectetur. Salami pork belly cow nisi tempor, pork laboris. Dolore bacon laboris kevin, salami ad dolor et pork t-bone aliqua.\n\nEiusmod aliqua quis, pig doner biltong et irure ribeye. Drumstick flank venison, turkey ullamco reprehenderit voluptate hamburger chuck laborum dolor aute. Pork chop fatback in cupim, t-bone dolore tenderloin beef ribs anim spare ribs quis consectetur incididunt laboris. Pariatur ribeye bacon consequat pastrami, ad pancetta picanha nisi fatback meatball beef ribs quis ullamco est. Short loin cillum ut filet mignon ribeye salami, pariatur short ribs velit ex veniam in duis. Duis doner chicken filet mignon short loin veniam sunt, enim meatball chuck quis laboris.\n\nId et elit occaecat in cow ut fugiat dolore fatback shankle pariatur. Et shankle leberkas sausage tongue in. Pork loin quis ut aliquip biltong leberkas. Proident ground round pancetta ribeye deserunt porchetta short loin andouille do.\n\nSausage aute consequat veniam shoulder corned beef sint turducken meatball shank cupidatat. Short ribs id kevin quis enim consectetur. Pork loin do biltong short loin frankfurter et beef cillum dolor brisket rump enim proident filet mignon meatball. Officia porchetta pig non pariatur tongue rump aute alcatra. Tempor t-bone mollit, dolore venison shank ut andouille ea consequat ad lorem alcatra pariatur. Porchetta cillum chuck spare ribs, drumstick capicola adipisicing. Pig andouille doner exercitation brisket elit landjaeger sirloin.\n\nOccaecat officia deserunt prosciutto do dolore pariatur, pig cupim. Veniam consequat irure, pancetta laboris proident short ribs eu aute. Kevin id sint, ut minim in pork belly veniam. Boudin sunt lorem rump. Ipsum velit id short ribs nisi, eiusmod tail sed. Cillum reprehenderit sunt, sed short ribs shank fatback shoulder shankle exercitation kevin pariatur. Brisket shankle veniam, cow nostrud flank ham hock cupidatat pork landjaeger ball tip ex.\n\nBall tip ham est tenderloin sed. Hamburger aliqua ball tip ham hock laborum deserunt. Cupidatat adipisicing ball tip, ut velit id turkey aliquip. Ut pork consequat brisket prosciutto veniam, esse cillum dolor deserunt velit venison.	2015-05-19 00:00:00	1
5	We have a weekly digest now!	Hey, we've just added a weekly digest. Tell us what do you think	2016-10-21 21:10:00	1
\.


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('post_id_seq', 5, true);


--
-- Data for Name: post_tags; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY post_tags (post_id, tag_id) FROM stdin;
1	1
1	2
2	1
3	1
3	2
4	2
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY role (id, name, description) FROM stdin;
1	admin	The administrator role
2	default	The normal role for a user
\.


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Data for Name: role_users; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY role_users (user_id, role_id) FROM stdin;
2	2
3	2
1	1
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY tag (id, title) FROM stdin;
1	Movie
2	Drama
\.


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('tag_id_seq', 2, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: wfdbuser
--

COPY "user" (id, username, password, active) FROM stdin;
1	Author	pbkdf2:sha1:1000$ceHjuj1j$d650d3b29114af04659171e9ded106d0d3507682	t
2	johndoe	pbkdf2:sha1:1000$ceHjuj1j$d650d3b29114af04659171e9ded106d0d3507682	\N
3	test3	pbkdf2:sha1:1000$7chNthZo$251db1a2361af053abecbb44c5621416b83a65e4	t
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wfdbuser
--

SELECT pg_catalog.setval('user_id_seq', 3, true);


--
-- Name: actor_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: movie_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: movie_role_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie_role
    ADD CONSTRAINT movie_role_pkey PRIMARY KEY (id);


--
-- Name: post_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: movie_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie
    ADD CONSTRAINT movie_director_id_fkey FOREIGN KEY (director_id) REFERENCES actor(id);


--
-- Name: movie_role_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie_role
    ADD CONSTRAINT movie_role_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES actor(id);


--
-- Name: movie_role_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY movie_role
    ADD CONSTRAINT movie_role_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movie(id);


--
-- Name: post_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT post_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: post_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT post_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tag(id);


--
-- Name: post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: role_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY role_users
    ADD CONSTRAINT role_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES role(id);


--
-- Name: role_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wfdbuser
--

ALTER TABLE ONLY role_users
    ADD CONSTRAINT role_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: wfdbuser
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM wfdbuser;
GRANT ALL ON SCHEMA public TO wfdbuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

