-- Сначала удалить старую базу данных, если она была создана
DROP TABLE IF EXISTS villains, minions, contracts;


CREATE TABLE villains (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    nickname varchar(100) UNIQUE,
    
    CONSTRAINT villains_check_name_not_empty CHECK (name IS NOT NULL AND trim(name) <> ''),
    CONSTRAINT villains_check_nickname_not_empty CHECK (nickname IS NOT NULL AND trim(nickname) <> '')
);


CREATE TABLE minions (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name varchar(100),
	eyes smallint NOT NULL DEFAULT 2,
	
	--Проверка, что количество глаз не отрицательное
	CONSTRAINT minions_check_eyes_positive_or_zero CHECK (eyes >= 0),
	--Проверка, что имя не пустое
	CONSTRAINT minions_check_name_not_empty CHECK (name IS NOT NULL AND (trim(name)) <> '')
);


CREATE TABLE contracts (
	id_villain int NOT NULL,    
	id_minion int NOT NULL,        
    payment varchar(100),
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    
    CONSTRAINT contracts_check_payment_not_empty CHECK (payment IS NOT NULL AND trim(payment) <> ''),
    
    --Составной идентификатор (первичный ключ)
    CONSTRAINT contracts_pk PRIMARY KEY (id_villain, id_minion),    
    
    CONSTRAINT contracts_villains_fk FOREIGN KEY (id_villain) REFERENCES villains(id) ON DELETE RESTRICT,
    CONSTRAINT contracts_minions_fk FOREIGN KEY (id_minion) REFERENCES minions(id) ON DELETE RESTRICT	--Нельзя удалить злодея, пока на него работают пособника, и пособника, пока он кому-то служит
);