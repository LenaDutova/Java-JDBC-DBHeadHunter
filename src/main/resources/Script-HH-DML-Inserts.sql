-- Добавление злодеев (идентификатор будет создан автоматически)
INSERT 
INTO villains (name, nickname)
VALUES 
('Грю Фелониус Мексон', 'Злодей года'),
('Влад III Цепеш', 'Граф Дракула'),
('Артур Флек', 'Джокер'),
('Фрекен Бок', 'Домомучительница'),
('Баба Яга', 'Костяная нога'),
('Кощей', 'Бессмертный'),
('Том Реддл', 'Волан-де-Морт');

-- Добавление пособников (идентификатор будет создан автоматически)
INSERT 
INTO minions (name, eyes) 
VALUES 
('Стюарт', 1),
('Норберт', 1),
('Кевин', 2),
('Боб', 2);

-- Если поле не передается, то при наличии ограничения DEFAULT будет задано его значение
INSERT 
INTO minions (name) 
VALUES 
('Бартемиус Крауч Младший'),
('Беллатриса Лестрейндж'),
('Доктор Нефарио'),
('Кот Баюн'),
('Питер Питегрю'),
('Профессор Квирелл'),
('Харли Квинн');

-- Заключение контрактов
INSERT 
INTO contracts (id_villain, id_minion, payment) 
VALUES 
(1, 1, '4 банана в год'),
(1, 2, '3 банана в год'),
(1, 3, '2 банана в год'),
(1, 4, '1 банан в год'),
(1, 7, '100$'),
(7, 5, 'Похвала'),
(7, 6, 'Нежный взгляд'),
(7, 9, 'Возврат утраченного'),
(7, 10, 'Компания'),
(3, 11, 'Обещание жениться'),
(5, 8, 'Плошка сметаны');