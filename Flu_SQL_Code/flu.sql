--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: _yoyo_migration; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE _yoyo_migration (
    id character varying(255) NOT NULL,
    ctime timestamp without time zone
);


ALTER TABLE _yoyo_migration OWNER TO vicspin;

--
-- Name: auth_cas; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_cas (
    id integer NOT NULL,
    user_id integer,
    created_on timestamp without time zone,
    service character varying(512),
    ticket character varying(512),
    renew character(1)
);


ALTER TABLE auth_cas OWNER TO vicspin;

--
-- Name: auth_cas_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_cas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_cas_id_seq OWNER TO vicspin;

--
-- Name: auth_cas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_cas_id_seq OWNED BY auth_cas.id;


--
-- Name: auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_code_id_seq OWNER TO postgres;

--
-- Name: auth_event; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_event (
    id integer NOT NULL,
    time_stamp timestamp without time zone,
    client_ip character varying(512),
    user_id integer,
    origin character varying(512),
    description text
);


ALTER TABLE auth_event OWNER TO vicspin;

--
-- Name: auth_event_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_event_id_seq OWNER TO vicspin;

--
-- Name: auth_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_event_id_seq OWNED BY auth_event.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    role character varying(512),
    description text
);


ALTER TABLE auth_group OWNER TO vicspin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO vicspin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_membership; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_membership (
    id integer NOT NULL,
    user_id integer,
    group_id integer
);


ALTER TABLE auth_membership OWNER TO vicspin;

--
-- Name: auth_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_membership_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_membership_id_seq OWNER TO vicspin;

--
-- Name: auth_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_membership_id_seq OWNED BY auth_membership.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    group_id integer,
    name character varying(512),
    table_name character varying(512),
    record_id integer
);


ALTER TABLE auth_permission OWNER TO vicspin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO vicspin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    first_name character varying(128),
    last_name character varying(128),
    email character varying(512),
    username character varying(128),
    password character varying(512),
    registration_key character varying(512),
    reset_password_key character varying(512),
    registration_id character varying(512),
    title character varying(5)
);


ALTER TABLE auth_user OWNER TO vicspin;

--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO vicspin;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: code; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE code (
    code character varying(16),
    auth_user integer,
    status smallint,
    id integer DEFAULT nextval('auth_code_id_seq'::regclass) NOT NULL,
    mac character varying,
    mac_status smallint
);


ALTER TABLE code OWNER TO vicspin;

--
-- Name: t_case; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_case (
    id integer NOT NULL,
    case_date date,
    age integer,
    gender character varying(512),
    vaccinated character varying(512),
    swabbed character varying(512),
    t_gp integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_case OWNER TO vicspin;

--
-- Name: t_case_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_case_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_case_id_seq OWNER TO vicspin;

--
-- Name: t_case_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_case_id_seq OWNED BY t_case.id;


--
-- Name: t_case_symptoms; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_case_symptoms (
    id integer NOT NULL,
    t_case integer,
    t_symptom integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_case_symptoms OWNER TO vicspin;

--
-- Name: t_case_symptoms_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_case_symptoms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_case_symptoms_id_seq OWNER TO vicspin;

--
-- Name: t_case_symptoms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_case_symptoms_id_seq OWNED BY t_case_symptoms.id;


--
-- Name: t_clinic; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_clinic (
    id integer NOT NULL,
    name character varying(512),
    address_1 character varying(512),
    address_2 character varying(512),
    suburb_name character varying(35),
    state_name character varying(3),
    postcode integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_clinic OWNER TO vicspin;

--
-- Name: t_clinic_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_clinic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_clinic_id_seq OWNER TO vicspin;

--
-- Name: t_clinic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_clinic_id_seq OWNED BY t_clinic.id;


--
-- Name: t_consultations; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_consultations (
    id integer NOT NULL,
    t_gp integer,
    non_ili_count integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    created_on timestamp without time zone,
    created_by integer,
    modified_on timestamp without time zone,
    modified_by integer
);


ALTER TABLE t_consultations OWNER TO vicspin;

--
-- Name: t_consultations_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_consultations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_consultations_id_seq OWNER TO vicspin;

--
-- Name: t_consultations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_consultations_id_seq OWNED BY t_consultations.id;


--
-- Name: t_csv; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_csv (
    id integer NOT NULL,
    csv_file character varying(512),
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_csv OWNER TO vicspin;

--
-- Name: t_csv_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_csv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_csv_id_seq OWNER TO vicspin;

--
-- Name: t_csv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_csv_id_seq OWNED BY t_csv.id;


--
-- Name: t_fluseason; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_fluseason (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    flu_year integer,
    is_active character(1),
    created_on timestamp without time zone,
    created_by integer,
    modified_on timestamp without time zone,
    modified_by integer
);


ALTER TABLE t_fluseason OWNER TO vicspin;

--
-- Name: t_fluseason_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_fluseason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_fluseason_id_seq OWNER TO vicspin;

--
-- Name: t_fluseason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_fluseason_id_seq OWNED BY t_fluseason.id;


--
-- Name: t_gp; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_gp (
    id integer NOT NULL,
    racgp_no character varying(512),
    auth_user integer,
    t_clinic integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_gp OWNER TO vicspin;

--
-- Name: t_gp_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_gp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_gp_id_seq OWNER TO vicspin;

--
-- Name: t_gp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_gp_id_seq OWNED BY t_gp.id;


--
-- Name: t_labresult; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_labresult (
    id integer NOT NULL,
    name character varying(512),
    subtype character varying(512),
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_labresult OWNER TO vicspin;

--
-- Name: t_labresult_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_labresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_labresult_id_seq OWNER TO vicspin;

--
-- Name: t_labresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_labresult_id_seq OWNED BY t_labresult.id;


--
-- Name: t_status; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_status (
    id integer NOT NULL,
    status character varying
);


ALTER TABLE t_status OWNER TO vicspin;

--
-- Name: t_status_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_status_id_seq OWNER TO vicspin;

--
-- Name: t_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_status_id_seq OWNED BY t_status.id;


--
-- Name: t_swab; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab (
    id integer NOT NULL,
    vidrl_id character varying(512),
    req_date date,
    test_date date,
    t_case integer,
    vaccinated character varying(512),
    vaccinated_on date,
    prev_vaccinated character varying(512),
    onset_date date,
    ili_patient character varying(512),
    healthcare_worker character varying(512),
    fever character varying(512),
    fever_temp double precision,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_swab OWNER TO vicspin;

--
-- Name: t_swab_doctor; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab_doctor (
    id integer NOT NULL,
    t_swab integer,
    last_name character varying(128),
    initials character varying(128),
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_swab_doctor OWNER TO vicspin;

--
-- Name: t_swab_doctor_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_doctor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_doctor_id_seq OWNER TO vicspin;

--
-- Name: t_swab_doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_doctor_id_seq OWNED BY t_swab_doctor.id;


--
-- Name: t_swab_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_id_seq OWNER TO vicspin;

--
-- Name: t_swab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_id_seq OWNED BY t_swab.id;


--
-- Name: t_swab_labresults; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab_labresults (
    id integer NOT NULL,
    t_swab integer,
    t_labresult integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_swab_labresults OWNER TO vicspin;

--
-- Name: t_swab_labresults_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_labresults_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_labresults_id_seq OWNER TO vicspin;

--
-- Name: t_swab_labresults_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_labresults_id_seq OWNED BY t_swab_labresults.id;


--
-- Name: t_swab_patient; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab_patient (
    id integer NOT NULL,
    t_swab integer,
    first_name character varying(128),
    last_name character varying(128),
    gender character varying(64),
    dob date,
    postcode integer,
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_swab_patient OWNER TO vicspin;

--
-- Name: t_swab_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_patient_id_seq OWNER TO vicspin;

--
-- Name: t_swab_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_patient_id_seq OWNED BY t_swab_patient.id;


--
-- Name: t_swab_sender; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab_sender (
    id integer NOT NULL,
    t_swab integer,
    last_name character varying(128),
    address character varying(512),
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone,
    initials character varying(128)
);


ALTER TABLE t_swab_sender OWNER TO vicspin;

--
-- Name: t_swab_sender_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_sender_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_sender_id_seq OWNER TO vicspin;

--
-- Name: t_swab_sender_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_sender_id_seq OWNED BY t_swab_sender.id;


--
-- Name: t_swab_status; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swab_status (
    id integer NOT NULL,
    status integer,
    created_on timestamp without time zone,
    t_swab integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_swab_status OWNER TO vicspin;

--
-- Name: t_swab_status_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swab_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swab_status_id_seq OWNER TO vicspin;

--
-- Name: t_swab_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swab_status_id_seq OWNED BY t_swab_status.id;


--
-- Name: t_swabsout; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_swabsout (
    id integer NOT NULL,
    t_gp integer,
    swab_count integer,
    date_sent date NOT NULL,
    created_on timestamp without time zone,
    created_by integer,
    modified_on timestamp without time zone,
    modified_by integer
);


ALTER TABLE t_swabsout OWNER TO vicspin;

--
-- Name: t_swabsout_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_swabsout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_swabsout_id_seq OWNER TO vicspin;

--
-- Name: t_swabsout_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_swabsout_id_seq OWNED BY t_swabsout.id;


--
-- Name: t_symptom; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE t_symptom (
    id integer NOT NULL,
    name character varying(512),
    created_by integer,
    created_on timestamp without time zone,
    modified_by integer,
    modified_on timestamp without time zone
);


ALTER TABLE t_symptom OWNER TO vicspin;

--
-- Name: t_symptom_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE t_symptom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_symptom_id_seq OWNER TO vicspin;

--
-- Name: t_symptom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE t_symptom_id_seq OWNED BY t_symptom.id;


--
-- Name: web2py_session_vicspin; Type: TABLE; Schema: public; Owner: vicspin
--

CREATE TABLE web2py_session_vicspin (
    id integer NOT NULL,
    locked character(1),
    client_ip character varying(64),
    created_datetime timestamp without time zone,
    modified_datetime timestamp without time zone,
    unique_key character varying(64),
    session_data bytea
);


ALTER TABLE web2py_session_vicspin OWNER TO vicspin;

--
-- Name: web2py_session_vicspin_id_seq; Type: SEQUENCE; Schema: public; Owner: vicspin
--

CREATE SEQUENCE web2py_session_vicspin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE web2py_session_vicspin_id_seq OWNER TO vicspin;

--
-- Name: web2py_session_vicspin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vicspin
--

ALTER SEQUENCE web2py_session_vicspin_id_seq OWNED BY web2py_session_vicspin.id;


--
-- Name: auth_cas id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_cas ALTER COLUMN id SET DEFAULT nextval('auth_cas_id_seq'::regclass);


--
-- Name: auth_event id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_event ALTER COLUMN id SET DEFAULT nextval('auth_event_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_membership id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_membership ALTER COLUMN id SET DEFAULT nextval('auth_membership_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: t_case id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case ALTER COLUMN id SET DEFAULT nextval('t_case_id_seq'::regclass);


--
-- Name: t_case_symptoms id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms ALTER COLUMN id SET DEFAULT nextval('t_case_symptoms_id_seq'::regclass);


--
-- Name: t_clinic id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_clinic ALTER COLUMN id SET DEFAULT nextval('t_clinic_id_seq'::regclass);


--
-- Name: t_consultations id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_consultations ALTER COLUMN id SET DEFAULT nextval('t_consultations_id_seq'::regclass);


--
-- Name: t_csv id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_csv ALTER COLUMN id SET DEFAULT nextval('t_csv_id_seq'::regclass);


--
-- Name: t_fluseason id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_fluseason ALTER COLUMN id SET DEFAULT nextval('t_fluseason_id_seq'::regclass);


--
-- Name: t_gp id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp ALTER COLUMN id SET DEFAULT nextval('t_gp_id_seq'::regclass);


--
-- Name: t_labresult id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_labresult ALTER COLUMN id SET DEFAULT nextval('t_labresult_id_seq'::regclass);


--
-- Name: t_status id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_status ALTER COLUMN id SET DEFAULT nextval('t_status_id_seq'::regclass);


--
-- Name: t_swab id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab ALTER COLUMN id SET DEFAULT nextval('t_swab_id_seq'::regclass);


--
-- Name: t_swab_doctor id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_doctor ALTER COLUMN id SET DEFAULT nextval('t_swab_doctor_id_seq'::regclass);


--
-- Name: t_swab_labresults id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults ALTER COLUMN id SET DEFAULT nextval('t_swab_labresults_id_seq'::regclass);


--
-- Name: t_swab_patient id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_patient ALTER COLUMN id SET DEFAULT nextval('t_swab_patient_id_seq'::regclass);


--
-- Name: t_swab_sender id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_sender ALTER COLUMN id SET DEFAULT nextval('t_swab_sender_id_seq'::regclass);


--
-- Name: t_swab_status id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_status ALTER COLUMN id SET DEFAULT nextval('t_swab_status_id_seq'::regclass);


--
-- Name: t_swabsout id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swabsout ALTER COLUMN id SET DEFAULT nextval('t_swabsout_id_seq'::regclass);


--
-- Name: t_symptom id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_symptom ALTER COLUMN id SET DEFAULT nextval('t_symptom_id_seq'::regclass);


--
-- Name: web2py_session_vicspin id; Type: DEFAULT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY web2py_session_vicspin ALTER COLUMN id SET DEFAULT nextval('web2py_session_vicspin_id_seq'::regclass);


--
-- Data for Name: _yoyo_migration; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY _yoyo_migration (id, ctime) FROM stdin;
\.


--
-- Data for Name: auth_cas; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_cas (id, user_id, created_on, service, ticket, renew) FROM stdin;
\.


--
-- Name: auth_cas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_cas_id_seq', 1, false);


--
-- Name: auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_code_id_seq', 88, true);


--
-- Data for Name: auth_event; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_event (id, time_stamp, client_ip, user_id, origin, description) FROM stdin;
\.


--
-- Name: auth_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_event_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_group (id, role, description) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_membership; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_membership (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_membership_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_permission (id, group_id, name, table_name, record_id) FROM stdin;
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_permission_id_seq', 1, false);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY auth_user (id, first_name, last_name, email, username, password, registration_key, reset_password_key, registration_id, title) FROM stdin;
3	yunze	li	dorine	9806600@qq.com	$2a$10$cf39e9e5c7ab4d09d731cODoCHyIc6Jmru/Q0e6g8OuhBA2zCiCoe	ce8dd893ef5b222de012e9bc27115d58	\N	\N	\N
4	Yunze	Li	dorine	222@qq.com	$2a$10$4b384bca840afcf4b993duc5j6mnYC1nWlD3LRnRlob4hR8bWsCrC	cb175049937a98a0d55fd681d5d19171	\N	\N	\N
5	Yunze	Li	dasdw@qq.com	dorine	$2a$10$0ec22f652f5353db63cf2u7K2SBxfc/.xwylJ9vUVs7lxZS4eeVbK	18d40938360d4499623e3138c9819ae2	\N	\N	\N
6	Yunze	Li	123@qq.com	dorine	$2a$10$c38ef7a7c9f304069945cOFcAGRymBuITyAIGl9Q6D87wHy7MQzc.	84caef1c00f210e7afbd0e178554153b	\N	\N	\N
8	xinrui	xu	1234@qq.com	xxr	$2a$10$8a676785e6c0d9da336c8u5lQd6yAvWHMjTMl1c9IOxJWt8JY4Aia	e6ab690f1db2294eef0163d068bfd9b4	\N	\N	\N
9	hanyao	tao	321@qq.com	fox	$2a$10$c055e2f1704ff7883cb80uO68lEKbNyAqPdiZoxrfCpgjOdKJ7Vji	38bea1cee25d61559a2468a83c85de9c	\N	\N	\N
10	hanyao	tao	hanyaot@gmail.com	hanyao.tao	$2a$10$5c52633630e56e8416231uhvq6bjc9WF/chzNEbyFsxosSg8UmW62	a577aa44a8a6081068d87a0833fee8c6	\N	\N	\N
11	hanyao	tao	hanyaotao@gmail.com	hanyao.tao	$2a$10$adf430ea5d45a0351d135uDV2u8My0AylBNBo/t0H4e4LU/G1XWXO	44f8d5a5c456b4fe393b7d8232dcc3a8	\N	\N	\N
12	hanyao	tao	test@gmail.com	test	$2a$10$6ce128c547710b5a6debbOaIZNrB/uSgAlwpv4PoZa02ArqNJTDSy	bde5ee0c09ecfc9c7aa56986dc73cdea	\N	\N	\N
\.


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('auth_user_id_seq', 12, true);


--
-- Data for Name: code; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY code (code, auth_user, status, id, mac, mac_status) FROM stdin;
4jwVNtVH6H	6	1	85	9CCBB97C-3F86-43A7-A7FF-5318800DBDD9	0
6zTKkt2mlM	6	1	88	9CCBB97C-3F86-43A7-A7FF-5318800DBDD9	1
fYiJ3RyWCt	6	1	86	50:a7:2b:ba:f4:8b	0
a	6	1	87	50:a7:2b:ba:f4:8b	1
\.


--
-- Data for Name: t_case; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_case (id, case_date, age, gender, vaccinated, swabbed, t_gp, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_case_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_case_id_seq', 1, false);


--
-- Data for Name: t_case_symptoms; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_case_symptoms (id, t_case, t_symptom, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_case_symptoms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_case_symptoms_id_seq', 1, false);


--
-- Data for Name: t_clinic; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_clinic (id, name, address_1, address_2, suburb_name, state_name, postcode, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_clinic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_clinic_id_seq', 1, false);


--
-- Data for Name: t_consultations; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_consultations (id, t_gp, non_ili_count, start_date, end_date, created_on, created_by, modified_on, modified_by) FROM stdin;
\.


--
-- Name: t_consultations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_consultations_id_seq', 1, false);


--
-- Data for Name: t_csv; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_csv (id, csv_file, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_csv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_csv_id_seq', 1, false);


--
-- Data for Name: t_fluseason; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_fluseason (id, start_date, end_date, flu_year, is_active, created_on, created_by, modified_on, modified_by) FROM stdin;
\.


--
-- Name: t_fluseason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_fluseason_id_seq', 1, false);


--
-- Data for Name: t_gp; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_gp (id, racgp_no, auth_user, t_clinic, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_gp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_gp_id_seq', 1, false);


--
-- Data for Name: t_labresult; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_labresult (id, name, subtype, created_by, created_on, modified_by, modified_on) FROM stdin;
2	H2N2	Influenzavirus A	\N	\N	\N	\N
3	H3N2	Influenzavirus A	\N	\N	\N	\N
4	H5N1	Influenzavirus A	\N	\N	\N	\N
5	H7N7	Influenzavirus A	\N	\N	\N	\N
6	H1N2	Influenzavirus A	\N	\N	\N	\N
8	B/Victoria	Influenzavirus B	\N	\N	\N	\N
1	No Flu	\N	\N	\N	\N	\N
7	H1N1	Influenzavirus A	\N	\N	\N	\N
9	termed B/Yamagata	Influenzavirus B	\N	\N	\N	\N
\.


--
-- Name: t_labresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_labresult_id_seq', 8, true);


--
-- Data for Name: t_status; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_status (id, status) FROM stdin;
1	sending
3	received
2	damaged
\.


--
-- Name: t_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_status_id_seq', 3, true);


--
-- Data for Name: t_swab; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab (id, vidrl_id, req_date, test_date, t_case, vaccinated, vaccinated_on, prev_vaccinated, onset_date, ili_patient, healthcare_worker, fever, fever_temp, created_by, created_on, modified_by, modified_on) FROM stdin;
1	false	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
3	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
4	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
5	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
6	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
7	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
8	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
9	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
10	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
11	\N	\N	\N	\N	False	2017-05-11	Unsure	2017-05-22	False	False	True	35	\N	\N	\N	\N
12	\N	\N	\N	\N	False	2017-05-11	Unsure	2017-05-22	False	False	True	35	\N	\N	\N	\N
13	\N	\N	\N	\N	False	2017-05-11	Unsure	2017-05-22	False	False	True	35	\N	\N	\N	\N
14	\N	\N	\N	\N	False	2017-05-03	Unsure	2017-05-18	True	True	True	35	\N	\N	\N	\N
15	\N	\N	\N	\N	False	2017-05-02	Never Vaccinated	2017-06-02	False	True	True	35	\N	\N	\N	\N
16	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	\N	\N	\N
17	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	30	\N	\N	\N	\N
18	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	\N	\N	\N	\N	\N
19	\N	\N	\N	\N	False	2017-05-02	Never Vaccinated	2017-06-02	False	True	True	25	\N	\N	\N	\N
20	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	\N	\N	\N	\N	\N
21	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	\N	\N	\N	\N	\N
22	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	\N	\N	\N	\N	\N
23	\N	\N	\N	\N	False	2017-05-03	Unsure	2017-05-18	True	True	True	35	\N	\N	\N	\N
24	\N	\N	\N	\N	False	2017-05-04	False	2017-05-19	False	True	False	\N	\N	\N	\N	\N
25	\N	\N	\N	\N	False	2017-05-04	False	2017-05-27	False	False	False	\N	\N	\N	\N	\N
26	\N	\N	\N	\N	False	2017-05-02	False	2017-05-25	False	True	True	123	\N	\N	\N	\N
27	\N	\N	\N	\N	False	2017-05-01	Unsure	2017-05-24	True	False	True	35	\N	\N	\N	\N
28	\N	\N	\N	\N	false	2001-02-10	false	2001-02-10	false	false	true	35	\N	2017-05-18 20:57:36	\N	\N
29	\N	\N	\N	\N	False	2017-05-03	False	2017-05-12	False	False	True	35	\N	2017-05-18 20:58:12	\N	\N
30	\N	\N	\N	\N	False	2017-05-02	False	2017-05-19	False	False	True	35	\N	2017-05-18 20:59:08	\N	\N
31	\N	\N	\N	\N	False	2017-05-05	False	2017-05-25	False	False	False	\N	\N	2017-05-18 20:59:27	\N	\N
32	\N	\N	\N	\N	False	2017-05-02	Unsure	2017-05-19	True	False	True	36	\N	2017-05-21 20:56:17	\N	\N
33	\N	\N	\N	\N	True	2017-05-06	Unsure	2017-05-20	False	False	True	36	\N	2017-05-21 21:07:09	\N	\N
34	\N	\N	\N	\N	False	2017-05-05	Unsure	2017-05-07	False	True	False	\N	\N	2017-05-21 21:24:31	\N	\N
35	\N	\N	\N	\N	False	2017-05-01	Unsure	2017-05-16	False	True	False	\N	\N	2017-05-21 22:22:45	\N	\N
36	\N	\N	\N	\N	False	2017-05-01	False	2017-05-09	False	True	True	30	\N	2017-05-21 22:30:00	\N	\N
37	\N	\N	\N	\N	False	2017-05-18	False	2017-05-25	False	False	False	\N	\N	2017-05-22 00:04:26	\N	\N
38	\N	\N	\N	\N	False	2017-05-03	False	2017-05-03	False	False	False	\N	\N	2017-05-22 23:34:05	\N	\N
\.


--
-- Data for Name: t_swab_doctor; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab_doctor (id, t_swab, last_name, initials, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_swab_doctor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_doctor_id_seq', 1, false);


--
-- Name: t_swab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_id_seq', 38, true);


--
-- Data for Name: t_swab_labresults; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab_labresults (id, t_swab, t_labresult, created_by, created_on, modified_by, modified_on) FROM stdin;
18	37	1	\N	2017-05-22 00:45:12	\N	2017-05-22 23:29:30
\.


--
-- Name: t_swab_labresults_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_labresults_id_seq', 18, true);


--
-- Data for Name: t_swab_patient; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab_patient (id, t_swab, first_name, last_name, gender, dob, postcode, created_by, created_on, modified_by, modified_on) FROM stdin;
333	27	\N	\N	male	2017-05-12	\N	\N	\N	\N	\N
2	\N	\N	\N	male	2001-02-10	\N	\N	\N	\N	\N
3	\N	\N	\N	male	2017-05-12	\N	\N	\N	\N	\N
4	\N	\N	\N	male	2017-05-01	\N	\N	\N	\N	\N
5	\N	\N	\N	male	2017-05-05	\N	\N	\N	\N	\N
6	\N	\N	\N	male	2017-05-13	\N	\N	\N	\N	\N
7	\N	\N	\N	male	2017-05-01	\N	\N	\N	\N	\N
8	\N	\N	\N	male	2001-02-10	\N	\N	\N	\N	\N
9	28	\N	\N	male	2001-02-10	\N	\N	\N	\N	\N
10	29	\N	\N	male	2017-05-03	\N	\N	\N	\N	\N
11	30	\N	\N	male	2017-05-06	\N	\N	\N	\N	\N
12	31	\N	\N	male	2017-05-02	\N	\N	\N	\N	\N
13	32	\N	\N	male	2017-05-04	\N	\N	2017-05-21 20:56:17	\N	\N
14	\N	\N	\N	male	2017-05-19	\N	\N	\N	\N	\N
15	33	\N	\N	male	2017-05-06	\N	\N	2017-05-21 21:07:09	\N	\N
16	\N	\N	\N	male	2017-05-03	\N	\N	\N	\N	\N
17	34	\N	\N	male	2017-04-30	\N	\N	2017-05-21 21:24:31	\N	\N
18	\N	\N	\N	male	2017-05-02	\N	\N	\N	\N	\N
19	35	\N	\N	male	2017-05-02	\N	\N	2017-05-21 22:22:45	\N	\N
20	36	\N	\N	Male	2017-05-19	\N	\N	2017-05-21 22:30:00	\N	\N
21	37	\N	\N	male	2017-05-03	\N	\N	2017-05-22 00:04:26	\N	\N
22	38	\N	\N	male	2017-05-05	\N	\N	2017-05-22 23:34:05	\N	\N
\.


--
-- Name: t_swab_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_patient_id_seq', 6, true);


--
-- Data for Name: t_swab_sender; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab_sender (id, t_swab, last_name, address, created_by, created_on, modified_by, modified_on, initials) FROM stdin;
\.


--
-- Name: t_swab_sender_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_sender_id_seq', 1, false);


--
-- Data for Name: t_swab_status; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swab_status (id, status, created_on, t_swab, modified_on) FROM stdin;
16	3	2017-05-22 00:04:26	37	2017-05-22 00:56:21
17	1	2017-05-22 23:34:05	38	\N
\.


--
-- Name: t_swab_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swab_status_id_seq', 17, true);


--
-- Data for Name: t_swabsout; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_swabsout (id, t_gp, swab_count, date_sent, created_on, created_by, modified_on, modified_by) FROM stdin;
\.


--
-- Name: t_swabsout_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_swabsout_id_seq', 1, false);


--
-- Data for Name: t_symptom; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY t_symptom (id, name, created_by, created_on, modified_by, modified_on) FROM stdin;
\.


--
-- Name: t_symptom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('t_symptom_id_seq', 1, false);


--
-- Data for Name: web2py_session_vicspin; Type: TABLE DATA; Schema: public; Owner: vicspin
--

COPY web2py_session_vicspin (id, locked, client_ip, created_datetime, modified_datetime, unique_key, session_data) FROM stdin;
\.


--
-- Name: web2py_session_vicspin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vicspin
--

SELECT pg_catalog.setval('web2py_session_vicspin_id_seq', 1, false);


--
-- Name: _yoyo_migration _yoyo_migration_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY _yoyo_migration
    ADD CONSTRAINT _yoyo_migration_pkey PRIMARY KEY (id);


--
-- Name: auth_cas auth_cas_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_cas
    ADD CONSTRAINT auth_cas_pkey PRIMARY KEY (id);


--
-- Name: auth_event auth_event_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_event
    ADD CONSTRAINT auth_event_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_membership auth_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_membership
    ADD CONSTRAINT auth_membership_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: code code_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY code
    ADD CONSTRAINT code_pkey PRIMARY KEY (id);


--
-- Name: t_case t_case_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case
    ADD CONSTRAINT t_case_pkey PRIMARY KEY (id);


--
-- Name: t_case_symptoms t_case_symptoms_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms
    ADD CONSTRAINT t_case_symptoms_pkey PRIMARY KEY (id);


--
-- Name: t_clinic t_clinic_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_clinic
    ADD CONSTRAINT t_clinic_pkey PRIMARY KEY (id);


--
-- Name: t_consultations t_consultations_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_consultations
    ADD CONSTRAINT t_consultations_pkey PRIMARY KEY (id);


--
-- Name: t_csv t_csv_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_csv
    ADD CONSTRAINT t_csv_pkey PRIMARY KEY (id);


--
-- Name: t_fluseason t_fluseason_flu_year_key; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_fluseason
    ADD CONSTRAINT t_fluseason_flu_year_key UNIQUE (flu_year);


--
-- Name: t_fluseason t_fluseason_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_fluseason
    ADD CONSTRAINT t_fluseason_pkey PRIMARY KEY (id);


--
-- Name: t_gp t_gp_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_pkey PRIMARY KEY (id);


--
-- Name: t_gp t_gp_racgp_no_key; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_racgp_no_key UNIQUE (racgp_no);


--
-- Name: t_labresult t_labresult_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_labresult
    ADD CONSTRAINT t_labresult_pkey PRIMARY KEY (id);


--
-- Name: t_status t_status_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_status
    ADD CONSTRAINT t_status_pkey PRIMARY KEY (id);


--
-- Name: t_swab_doctor t_swab_doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_doctor
    ADD CONSTRAINT t_swab_doctor_pkey PRIMARY KEY (id);


--
-- Name: t_swab_labresults t_swab_labresults_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults
    ADD CONSTRAINT t_swab_labresults_pkey PRIMARY KEY (id);


--
-- Name: t_swab_patient t_swab_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_patient
    ADD CONSTRAINT t_swab_patient_pkey PRIMARY KEY (id);


--
-- Name: t_swab t_swab_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_pkey PRIMARY KEY (id);


--
-- Name: t_swab_sender t_swab_sender_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_sender
    ADD CONSTRAINT t_swab_sender_pkey PRIMARY KEY (id);


--
-- Name: t_swab_status t_swab_status_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_status
    ADD CONSTRAINT t_swab_status_pkey PRIMARY KEY (id);


--
-- Name: t_swab t_swab_t_case_key; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_t_case_key UNIQUE (t_case);


--
-- Name: t_swab t_swab_vidrl_id_key; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_vidrl_id_key UNIQUE (vidrl_id);


--
-- Name: t_swabsout t_swabsout_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swabsout
    ADD CONSTRAINT t_swabsout_pkey PRIMARY KEY (id);


--
-- Name: t_symptom t_symptom_name_key; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_symptom
    ADD CONSTRAINT t_symptom_name_key UNIQUE (name);


--
-- Name: t_symptom t_symptom_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_symptom
    ADD CONSTRAINT t_symptom_pkey PRIMARY KEY (id);


--
-- Name: web2py_session_vicspin web2py_session_vicspin_pkey; Type: CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY web2py_session_vicspin
    ADD CONSTRAINT web2py_session_vicspin_pkey PRIMARY KEY (id);


--
-- Name: auth_cas auth_cas_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_cas
    ADD CONSTRAINT auth_cas_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_event auth_event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_event
    ADD CONSTRAINT auth_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_membership auth_membership_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_membership
    ADD CONSTRAINT auth_membership_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) ON DELETE CASCADE;


--
-- Name: auth_membership auth_membership_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_membership
    ADD CONSTRAINT auth_membership_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_permission auth_permission_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) ON DELETE CASCADE;


--
-- Name: code auth_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY code
    ADD CONSTRAINT auth_user_fk FOREIGN KEY (auth_user) REFERENCES auth_user(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: t_case t_case_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case
    ADD CONSTRAINT t_case_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_case t_case_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case
    ADD CONSTRAINT t_case_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_case_symptoms t_case_symptoms_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms
    ADD CONSTRAINT t_case_symptoms_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_case_symptoms t_case_symptoms_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms
    ADD CONSTRAINT t_case_symptoms_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_case_symptoms t_case_symptoms_t_case_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms
    ADD CONSTRAINT t_case_symptoms_t_case_fkey FOREIGN KEY (t_case) REFERENCES t_case(id) ON DELETE CASCADE;


--
-- Name: t_case_symptoms t_case_symptoms_t_symptom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case_symptoms
    ADD CONSTRAINT t_case_symptoms_t_symptom_fkey FOREIGN KEY (t_symptom) REFERENCES t_symptom(id) ON DELETE CASCADE;


--
-- Name: t_case t_case_t_gp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_case
    ADD CONSTRAINT t_case_t_gp_fkey FOREIGN KEY (t_gp) REFERENCES t_gp(id) ON DELETE CASCADE;


--
-- Name: t_clinic t_clinic_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_clinic
    ADD CONSTRAINT t_clinic_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_clinic t_clinic_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_clinic
    ADD CONSTRAINT t_clinic_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_consultations t_consultations_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_consultations
    ADD CONSTRAINT t_consultations_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_consultations t_consultations_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_consultations
    ADD CONSTRAINT t_consultations_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_consultations t_consultations_t_gp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_consultations
    ADD CONSTRAINT t_consultations_t_gp_fkey FOREIGN KEY (t_gp) REFERENCES t_gp(id) ON DELETE CASCADE;


--
-- Name: t_csv t_csv_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_csv
    ADD CONSTRAINT t_csv_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_csv t_csv_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_csv
    ADD CONSTRAINT t_csv_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_fluseason t_fluseason_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_fluseason
    ADD CONSTRAINT t_fluseason_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_fluseason t_fluseason_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_fluseason
    ADD CONSTRAINT t_fluseason_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_gp t_gp_auth_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_auth_user_fkey FOREIGN KEY (auth_user) REFERENCES auth_user(id);


--
-- Name: t_gp t_gp_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_gp t_gp_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_gp t_gp_t_clinic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_gp
    ADD CONSTRAINT t_gp_t_clinic_fkey FOREIGN KEY (t_clinic) REFERENCES t_clinic(id) ON DELETE SET NULL;


--
-- Name: t_labresult t_labresult_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_labresult
    ADD CONSTRAINT t_labresult_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_labresult t_labresult_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_labresult
    ADD CONSTRAINT t_labresult_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_status t_swab; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_status
    ADD CONSTRAINT t_swab FOREIGN KEY (t_swab) REFERENCES t_swab(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: t_swab t_swab_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_doctor t_swab_doctor_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_doctor
    ADD CONSTRAINT t_swab_doctor_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_doctor t_swab_doctor_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_doctor
    ADD CONSTRAINT t_swab_doctor_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_doctor t_swab_doctor_t_swab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_doctor
    ADD CONSTRAINT t_swab_doctor_t_swab_fkey FOREIGN KEY (t_swab) REFERENCES t_swab(id) ON DELETE CASCADE;


--
-- Name: t_swab_labresults t_swab_labresults_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults
    ADD CONSTRAINT t_swab_labresults_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_labresults t_swab_labresults_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults
    ADD CONSTRAINT t_swab_labresults_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_labresults t_swab_labresults_t_labresult_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults
    ADD CONSTRAINT t_swab_labresults_t_labresult_fkey FOREIGN KEY (t_labresult) REFERENCES t_labresult(id) ON DELETE CASCADE;


--
-- Name: t_swab_labresults t_swab_labresults_t_swab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_labresults
    ADD CONSTRAINT t_swab_labresults_t_swab_fkey FOREIGN KEY (t_swab) REFERENCES t_swab(id) ON DELETE CASCADE;


--
-- Name: t_swab t_swab_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_patient t_swab_patient_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_patient
    ADD CONSTRAINT t_swab_patient_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_patient t_swab_patient_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_patient
    ADD CONSTRAINT t_swab_patient_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_patient t_swab_patient_t_swab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_patient
    ADD CONSTRAINT t_swab_patient_t_swab_fkey FOREIGN KEY (t_swab) REFERENCES t_swab(id) ON DELETE CASCADE;


--
-- Name: t_swab_sender t_swab_sender_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_sender
    ADD CONSTRAINT t_swab_sender_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_sender t_swab_sender_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_sender
    ADD CONSTRAINT t_swab_sender_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swab_sender t_swab_sender_t_swab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_sender
    ADD CONSTRAINT t_swab_sender_t_swab_fkey FOREIGN KEY (t_swab) REFERENCES t_swab(id) ON DELETE CASCADE;


--
-- Name: t_swab_status t_swab_status; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab_status
    ADD CONSTRAINT t_swab_status FOREIGN KEY (status) REFERENCES t_status(id);


--
-- Name: t_swab t_swab_t_case_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swab
    ADD CONSTRAINT t_swab_t_case_fkey FOREIGN KEY (t_case) REFERENCES t_case(id) ON DELETE SET NULL;


--
-- Name: t_swabsout t_swabsout_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swabsout
    ADD CONSTRAINT t_swabsout_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swabsout t_swabsout_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swabsout
    ADD CONSTRAINT t_swabsout_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_swabsout t_swabsout_t_gp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_swabsout
    ADD CONSTRAINT t_swabsout_t_gp_fkey FOREIGN KEY (t_gp) REFERENCES t_gp(id) ON DELETE CASCADE;


--
-- Name: t_symptom t_symptom_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_symptom
    ADD CONSTRAINT t_symptom_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- Name: t_symptom t_symptom_modified_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vicspin
--

ALTER TABLE ONLY t_symptom
    ADD CONSTRAINT t_symptom_modified_by_fkey FOREIGN KEY (modified_by) REFERENCES auth_user(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

