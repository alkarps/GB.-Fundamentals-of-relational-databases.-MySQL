-- Таблица аттачмента. Выносим из медиа для возможности переиспользования приаттаченных файлов в сообщениях
-- + так же позволяет приаттачить несколько файлов к медиа или сообщению
drop table if exists attachments;
create table attachments(
	id SERIAL,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);
-- Таблица связки аттачмента к сообщению
drop table if exists message_attachments;
create table message_attachments(
	message_id SERIAL,
    attachment_id VARCHAR(255),

    PRIMARY KEY (message_id, attachment_id),
	FOREIGN KEY (message_id) REFERENCES messages(id),
    FOREIGN KEY (attachment_id) REFERENCES attachments(id)
);
-- Таблица связки аттачмента к медиа
drop table if exists media_attachments;
create table media_attachments(
	media_id SERIAL,
    attachment_id VARCHAR(255),

    PRIMARY KEY (media_id, attachment_id),
	FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (attachment_id) REFERENCES attachments(id)
);
-- Дропаем теперь ненужные столбцы. Метаданные придется чистить ручками на случай хранения данных,
-- относящиеся чисто к медиа
alter table media drop column filename;
alter table media drop column size;