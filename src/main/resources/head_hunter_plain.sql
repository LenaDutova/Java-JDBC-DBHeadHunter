--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2025-04-23 13:09:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16511)
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract (
    id integer NOT NULL,
    id_villain integer NOT NULL,
    id_minion integer NOT NULL,
    payment character varying(256) NOT NULL,
    start_date timestamp with time zone DEFAULT '2024-04-23 21:37:07.280883+03'::timestamp with time zone NOT NULL
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16515)
-- Name: contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_id_seq OWNER TO postgres;

--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 215
-- Name: contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_id_seq OWNED BY public.contract.id;


--
-- TOC entry 216 (class 1259 OID 16516)
-- Name: minion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.minion (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    eyes_count smallint DEFAULT 2 NOT NULL
);


ALTER TABLE public.minion OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16520)
-- Name: minion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.minion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minion_id_seq OWNER TO postgres;

--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 217
-- Name: minion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.minion_id_seq OWNED BY public.minion.id;


--
-- TOC entry 218 (class 1259 OID 16521)
-- Name: villain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.villain (
    id integer NOT NULL,
    name character varying(128),
    nickname character varying(128) NOT NULL
);


ALTER TABLE public.villain OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16524)
-- Name: villain_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.villain_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.villain_id_seq OWNER TO postgres;

--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 219
-- Name: villain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.villain_id_seq OWNED BY public.villain.id;


--
-- TOC entry 3183 (class 2604 OID 16525)
-- Name: contract id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract ALTER COLUMN id SET DEFAULT nextval('public.contract_id_seq'::regclass);


--
-- TOC entry 3185 (class 2604 OID 16526)
-- Name: minion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.minion ALTER COLUMN id SET DEFAULT nextval('public.minion_id_seq'::regclass);


--
-- TOC entry 3187 (class 2604 OID 16527)
-- Name: villain id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.villain ALTER COLUMN id SET DEFAULT nextval('public.villain_id_seq'::regclass);


--
-- TOC entry 3341 (class 0 OID 16511)
-- Dependencies: 214
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract (id, id_villain, id_minion, payment, start_date) FROM stdin;
1	1	1	4 банан в год	2024-04-23 22:09:18.569324+03
2	1	2	3 банан в год	2024-04-23 22:09:18.569324+03
3	1	3	2 банан в год	2024-04-23 22:09:18.569324+03
4	1	4	1 банан в год	2024-04-23 22:09:18.569324+03
5	1	7	100$	2024-04-23 21:37:07.280883+03
6	7	5	Похвала	2024-04-23 21:37:07.280883+03
7	7	6	Нежный взгляд	2024-04-23 21:37:07.280883+03
8	7	9	Возврат утраченного	2024-04-23 21:37:07.280883+03
9	7	10	Компания	2024-04-23 21:37:07.280883+03
10	3	11	Обещание жениться	2024-04-23 21:37:07.280883+03
11	5	8	Плошка сметаны	2024-04-23 21:37:07.280883+03
\.


--
-- TOC entry 3343 (class 0 OID 16516)
-- Dependencies: 216
-- Data for Name: minion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.minion (id, name, eyes_count) FROM stdin;
1	Стюарт	1
2	Норберт	1
3	Кевин	2
4	Боб	2
5	Бартемиус Крауч Младший	2
6	Беллатриса Лестрейндж	2
7	Доктор Нефарио	2
8	Кот Баюн	2
9	Питер Питегрю	2
10	Профессор Квирелл	2
11	Харли Квинн	2
\.


--
-- TOC entry 3345 (class 0 OID 16521)
-- Dependencies: 218
-- Data for Name: villain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.villain (id, name, nickname) FROM stdin;
1	Грю Фелониус Мексон	Злодей года
2	Влад III Цепеш	Граф Дракула
3	Артур Флек	Джокер
4	Фрекен Бок	Домомучительница
5	Баба Яга	Костяная нога
6	Кощей	Бессмертный
7	Том Реддл	Волан-де-Морт
\.


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 215
-- Name: contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_id_seq', 11, true);


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 217
-- Name: minion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.minion_id_seq', 11, true);


--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 219
-- Name: villain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.villain_id_seq', 7, true);


--
-- TOC entry 3190 (class 2606 OID 16529)
-- Name: contract contract_id_villain_id_minion_start_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_id_villain_id_minion_start_date_key UNIQUE (id_villain, id_minion, start_date);


--
-- TOC entry 3192 (class 2606 OID 16531)
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);


--
-- TOC entry 3188 (class 2606 OID 16532)
-- Name: minion minion_eyes_count_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.minion
    ADD CONSTRAINT minion_eyes_count_check CHECK ((eyes_count > 0)) NOT VALID;


--
-- TOC entry 3194 (class 2606 OID 16534)
-- Name: minion minion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.minion
    ADD CONSTRAINT minion_pkey PRIMARY KEY (id);


--
-- TOC entry 3196 (class 2606 OID 16536)
-- Name: villain villain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.villain
    ADD CONSTRAINT villain_pkey PRIMARY KEY (id);


--
-- TOC entry 3197 (class 2606 OID 16537)
-- Name: contract fk_contract_minion ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "fk_contract_minion " FOREIGN KEY (id_minion) REFERENCES public.minion(id);


--
-- TOC entry 3198 (class 2606 OID 16542)
-- Name: contract fk_contract_villain; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT fk_contract_villain FOREIGN KEY (id_villain) REFERENCES public.villain(id);


-- Completed on 2025-04-23 13:09:05

--
-- PostgreSQL database dump complete
--

