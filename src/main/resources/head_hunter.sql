PGDMP         $                 |            rut_head_hunter    15.2    15.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16440    rut_head_hunter    DATABASE     �   CREATE DATABASE rut_head_hunter WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE rut_head_hunter;
                postgres    false            �            1259    16458    contract    TABLE       CREATE TABLE public.contract (
    id integer NOT NULL,
    id_villain integer NOT NULL,
    id_minion integer NOT NULL,
    payment character varying(256) NOT NULL,
    start_date timestamp with time zone DEFAULT '2024-04-23 21:37:07.280883+03'::timestamp with time zone NOT NULL
);
    DROP TABLE public.contract;
       public         heap    postgres    false            �            1259    16457    contract_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.contract_id_seq;
       public          postgres    false    219                       0    0    contract_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.contract_id_seq OWNED BY public.contract.id;
          public          postgres    false    218            �            1259    16443    minion    TABLE     �   CREATE TABLE public.minion (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    eyes_count smallint DEFAULT 2 NOT NULL
);
    DROP TABLE public.minion;
       public         heap    postgres    false            �            1259    16442    minion_id_seq    SEQUENCE     �   CREATE SEQUENCE public.minion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.minion_id_seq;
       public          postgres    false    215                       0    0    minion_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.minion_id_seq OWNED BY public.minion.id;
          public          postgres    false    214            �            1259    16451    villain    TABLE     �   CREATE TABLE public.villain (
    id integer NOT NULL,
    name character varying(128),
    nickname character varying(128) NOT NULL
);
    DROP TABLE public.villain;
       public         heap    postgres    false            �            1259    16450    villain_id_seq    SEQUENCE     �   CREATE SEQUENCE public.villain_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.villain_id_seq;
       public          postgres    false    217                       0    0    villain_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.villain_id_seq OWNED BY public.villain.id;
          public          postgres    false    216            r           2604    16461    contract id    DEFAULT     j   ALTER TABLE ONLY public.contract ALTER COLUMN id SET DEFAULT nextval('public.contract_id_seq'::regclass);
 :   ALTER TABLE public.contract ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            o           2604    16446 	   minion id    DEFAULT     f   ALTER TABLE ONLY public.minion ALTER COLUMN id SET DEFAULT nextval('public.minion_id_seq'::regclass);
 8   ALTER TABLE public.minion ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            q           2604    16454 
   villain id    DEFAULT     h   ALTER TABLE ONLY public.villain ALTER COLUMN id SET DEFAULT nextval('public.villain_id_seq'::regclass);
 9   ALTER TABLE public.villain ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217                      0    16458    contract 
   TABLE DATA           R   COPY public.contract (id, id_villain, id_minion, payment, start_date) FROM stdin;
    public          postgres    false    219   �                 0    16443    minion 
   TABLE DATA           6   COPY public.minion (id, name, eyes_count) FROM stdin;
    public          postgres    false    215   �                  0    16451    villain 
   TABLE DATA           5   COPY public.villain (id, name, nickname) FROM stdin;
    public          postgres    false    217   �!                  0    0    contract_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.contract_id_seq', 11, true);
          public          postgres    false    218                       0    0    minion_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.minion_id_seq', 11, true);
          public          postgres    false    214                       0    0    villain_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.villain_id_seq', 7, true);
          public          postgres    false    216            z           2606    16466 5   contract contract_id_villain_id_minion_start_date_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_id_villain_id_minion_start_date_key UNIQUE (id_villain, id_minion, start_date);
 _   ALTER TABLE ONLY public.contract DROP CONSTRAINT contract_id_villain_id_minion_start_date_key;
       public            postgres    false    219    219    219            |           2606    16464    contract contract_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contract DROP CONSTRAINT contract_pkey;
       public            postgres    false    219            t           2606    16477    minion minion_eyes_count_check    CHECK CONSTRAINT     i   ALTER TABLE public.minion
    ADD CONSTRAINT minion_eyes_count_check CHECK ((eyes_count > 0)) NOT VALID;
 C   ALTER TABLE public.minion DROP CONSTRAINT minion_eyes_count_check;
       public          postgres    false    215    215            v           2606    16449    minion minion_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.minion
    ADD CONSTRAINT minion_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.minion DROP CONSTRAINT minion_pkey;
       public            postgres    false    215            x           2606    16456    villain villain_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.villain
    ADD CONSTRAINT villain_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.villain DROP CONSTRAINT villain_pkey;
       public            postgres    false    217            }           2606    16472    contract fk_contract_minion     FK CONSTRAINT     �   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "fk_contract_minion " FOREIGN KEY (id_minion) REFERENCES public.minion(id);
 H   ALTER TABLE ONLY public.contract DROP CONSTRAINT "fk_contract_minion ";
       public          postgres    false    3190    219    215            ~           2606    16467    contract fk_contract_villain    FK CONSTRAINT     �   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT fk_contract_villain FOREIGN KEY (id_villain) REFERENCES public.villain(id);
 F   ALTER TABLE ONLY public.contract DROP CONSTRAINT fk_contract_villain;
       public          postgres    false    3192    217    219                 x���MJ�@�וS�L�$����8Qa��z�mG��Wxu#��J]B�Ћ��~�ڐ��
O�0���+<c�Ym�F��u��F׍	yQ���S�2+�%�u�:�kP��Y��Vd�>�%4��]�6�\�"+�����1�[@*AJ�="^1��G�5��O��t�&��G�|��[����+1e���S=oH8��_sGo�_���/1��5����d�8;�|��e#���� �]�����&O�-��Y�}n��         �   x�5�An�0D�ߧ�	*��]8L�"�*RW�b�>\B|��7b����g�9��
��ZJ�Ƃ?D��"�NA��:2v��-"Zʩɔ�G��Zx�L7�k�_�hp��Wf<��ٜ��ǎcE:\1�����p��zy�]��"���E-}���B�gki��-q&cE7�f>���gqm�K�$�g����zt/�Tֿ�p�= !"��         �   x�%P]J�@~�9�\����r�����S�"�WW̊m�z�on�7+!d3�����[�5l�1�`ķ/�3l8�{#�S�z�v��zLz$x�<���io��}YM��ܰ�}Aԩ��qs&�9D�`�/Z�)m�X��&�/F�} A)����KV�G]��u/�<2>��l��(�1kER��Sѓ�*�	Y&��{�j�;=�F�ᅴ��ۖ��8�����JH��@U� ��     