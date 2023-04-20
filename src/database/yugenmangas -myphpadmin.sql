-- -----------------------------------------------------
-- create database yugenmangas;
-- -----------------------------------------------------
-- table mangas
-- -----------------------------------------------------
create table mangas (
  man_id tinyint(10) not null auto_increment primary key,
  man_description varchar(100) null,
  man_date date null,
  man_ar_id int(10) not null,
  man_author_id int(10) not null,
  man_comment_id int(10) not null,
  man_production_id int(10) not null,
  man_scan_id int(10) not null,
  man_title_id int(10) not null unique
);

-- -----------------------------------------------------
-- table agerestriction
-- -----------------------------------------------------
create table agerestriction (
  ar_id int(10) not null auto_increment primary key,
  ar_type varchar(10) not null
);

-- -----------------------------------------------------
-- table authors
-- -----------------------------------------------------
create table authors (
  author_id int(10) not null auto_increment primary key,
  author_nombre varchar(30) not null
);

-- -----------------------------------------------------
-- table titles
-- -----------------------------------------------------
create table titles (
  title_id int(10) not null auto_increment primary key,
  title_en varchar(100) not null unique,
  title_es varchar(100) null,
  title_ja varchar(100) null,
  title_ko varchar(100) null,
  title_zh varchar(100) null
);

-- -----------------------------------------------------
-- table tags
-- -----------------------------------------------------
create table tags (
  tag_id int(10) not null auto_increment primary key,
  tag_description varchar(20) not null
);
-- -----------------------------------------------------
-- table titles_tags
-- -----------------------------------------------------
create table titles_tags (
    tt_title_id int(10) NOT NULL,
    tt_tag_id int(10) NOT NULL,
    PRIMARY KEY (tt_title_id, tt_tag_id),
    FOREIGN KEY (tt_title_id) REFERENCES titles(title_id),
    FOREIGN KEY (tt_tag_id) REFERENCES tags(tag_id)
);

-- -----------------------------------------------------
-- table productions
-- -----------------------------------------------------
create table productions (
  prod_id int(10) not null auto_increment primary key,
  prod_team varchar(20) not null
);

-- -----------------------------------------------------
-- table scans
-- -----------------------------------------------------
create table scans (
  scan_id int(10) not null auto_increment primary key,
  scan_name varchar(20) not null,
  scan_bio varchar(100) null DEFAULT 'No contiene redes'
);


-- -----------------------------------------------------
-- table chapters
-- -----------------------------------------------------
create table chapters (
  chap_title_id int(10) not null, -- FK
  chap_number int not null,
  chap_date date not null,
  chap_comment_id int(10) not null, -- FK
  chap_img_title_id int(10) not null, -- FK
  primary key(chap_title_id, chap_number)
);
    
-- -----------------------------------------------------
-- table comments
-- -----------------------------------------------------
create table comments (
  com_id int(10) not null auto_increment primary key,
  com_description varchar(200) not null,
  com_user_id int(10) not null, -- FK
  com_tp_id int(10) not null   -- FK
);

create table types (
  tp_id int(10) not null auto_increment primary key,
  tp_type varchar(20) not null unique
);

-- -----------------------------------------------------
-- table images
-- -----------------------------------------------------
create table images (
  img_title_id int(10) not null, -- FK -- PK
  img_name varchar(100) not null, -- -- PK
  img_image varchar(100) not null,
  img_tp_id int(10) not null, -- FK
  PRIMARY KEY (img_title_id, img_name)
);

-- -----------------------------------------------------
-- table users
-- -----------------------------------------------------
create table users (
  user_id int(10) not null auto_increment primary key,
  user_name varchar(20) null,
  user_email varchar(40) not null unique,
  user_password varchar(40) not null,
  user_created_at timestamp default current_timestamp,
  user_state tinyint(1) not null default 1,
  user_last_login timestamp null,
  user_country varchar(50) null,
  user_phone varchar(11) null,
  user_date_of_birth date default '2000-01-01',
  user_gender varchar(10) null,
  user_address varchar(100) null,
  user_security_code varchar(10) not null,
  user_img_title_id int(10) not null,  -- FK
  user_ucla_id int(10) not null, -- FK
  user_ur_id int(10) not null -- FK
);

-- -----------------------------------------------------
-- table users classes
-- -----------------------------------------------------
create table user_classes (
  ucla_id int(10) not null auto_increment primary key,
  ucla_race varchar(50) not null unique,
  ucla_description varchar(200) null
);
-- -----------------------------------------------------
-- table users roles
-- -----------------------------------------------------
create table user_roles (
  ur_id int(10) not null auto_increment primary key,
  ur_role varchar(50) not null unique,
  ur_description varchar(100) null
);

-- -----------------------------------------------------
-- table views
-- -----------------------------------------------------
create table views (
  view_title_id int(10) not null, -- FK
  view_user_id int(10) not null, -- FK
  view_count INT NOT NULL DEFAULT 1,
  PRIMARY KEY (view_title_id, view_user_id),
  FOREIGN KEY (view_title_id) REFERENCES titles(title_id),
  FOREIGN KEY (view_user_id) REFERENCES users(user_id)
);

-- -----------------------------
-- llaves foraneas de images
-- -----------------------------
alter table images add foreign key(img_title_id)
references titles(title_id)
on delete restrict
on update cascade;

alter table images add foreign key(img_tp_id)
references types(tp_id)
on delete restrict
on update cascade;

-- -----------------------------
-- llaves foraneas de users
-- -----------------------------
alter table users add foreign key(user_ucla_id)
references user_classes(ucla_id)
on delete restrict
on update cascade;

alter table users add foreign key(user_ur_id)
references user_roles(ur_id)
on delete restrict
on update cascade;

alter table users add foreign key(user_img_title_id)
references images(img_title_id)
on delete restrict
on update cascade;

-- -----------------------------
-- llaves foraneas de comments
-- -----------------------------
alter table comments add foreign key(com_user_id)
references users(user_id)
on delete restrict
on update cascade;

alter table comments add foreign key(com_tp_id)
references types (tp_id)
on delete restrict
on update cascade;

-- -----------------------------
-- llaves foraneas de chapters
-- -----------------------------
alter table chapters add foreign key(chap_comment_id)
references comments(com_id)
on delete restrict
on update cascade;

alter table chapters add foreign key(chap_img_title_id)
references images(img_title_id)
on delete restrict
on update cascade;

alter table chapters add foreign key(chap_title_id) 
references titles(title_id)
on delete restrict
on update cascade;

-- -----------------------------
-- llaves foraneas de mangas
-- -----------------------------

alter table mangas add foreign key(man_ar_id)
references agerestriction (ar_id)
on delete restrict
on update cascade;

alter table mangas add foreign key(man_author_id)
references authors (author_id)
on delete restrict
on update cascade;

alter table mangas add foreign key(man_comment_id)
references comments (com_id)
on delete restrict
on update cascade;

alter table mangas add foreign key(man_scan_id)
references scans (scan_id)
on delete restrict
on update cascade;

alter table mangas add foreign key(man_production_id)
references productions (prod_id)
on delete restrict
on update cascade;

alter table mangas add foreign key(man_title_id)
references titles (title_id)
on delete restrict
on update cascade;
 
-- -----------------------------
-- DATA INPUT 
-- -----------------------------
-- agerestriction
-- -----------------------------
/*
	CREATE PROCEDURE insert_agerestriction(

	) AS 
	BEGIN 
		BEGIN TRANSACTION;
		SAVE TRANSACTION puntoDeSalvado;
		
		BEGIN TRY
			insert into agerestriction (ar_type) values ("mayor"),("menor");
		END TRY
		BEGIN CATCH
		
		END CATCH
	END;
*/

insert into agerestriction (ar_type) values ("mayor"),("menor");

-- -----------------------------
-- authors
-- -----------------------------
insert into authors (author_nombre) values 
("Seolcha"),("Him"),("PYO & 오람비")
,("Kim Soong-nyeon"),("Komagome");

-- -----------------------------
-- tags
-- -----------------------------
insert into tags (tag_description) values 
("fantasia"),("romance"),("drama")
,("horror"),("adulto");

-- -----------------------------
-- productions
-- -----------------------------
insert into productions (prod_team) values 
("Copin Webtoon"),("Toptoon"),("Lezhin")
,("Clappers"),("Naver");

-- -----------------------------
-- titles
-- -----------------------------
INSERT INTO titles (title_en, title_es, title_ja, title_ko, title_zh)
VALUES
('Attack on Titan', 'Ataque a los Titanes', '進撃の巨人', '진격의 거인', '进击的巨人'),
('Naruto', 'Naruto', 'ナルト', '나루토', '火影忍者'),
('One Piece', 'One Piece', 'ワンピース', '원피스', '航海王'),
('Bleach', 'Bleach', 'ブリーチ', '블리치', '死神'),
('Death Note', 'Death Note', 'デスノート', '데스노트', '死亡筆記'),
('Dragon Ball', 'Dragon Ball', 'ドラゴンボール', '드래곤볼', '龙珠'),
('Fullmetal Alchemist', 'Fullmetal Alchemist', '鋼の錬金術師', '강철의 연금술사', '钢之炼金术师'),
('Hunter x Hunter', 'Hunter x Hunter', 'ハンター×ハンター', '헌터 x 헌터', '猎人'),
("Jojo\'s Bizarre Adventure", 'Las extravagantes aventuras de Jojo', 'ジョジョの奇妙な冒険', '조조의 기묘한 모험', 'JOJO的奇妙冒险'),
('Fairy Tail', 'Fairy Tail', 'フェアリーテイル', '페어리 테일', '妖精的尾巴');
 
-- -----------------------------
-- scans
-- -----------------------------
insert into titles_tags (tt_title_id, tt_tag_id) 
values  (1,1),(1,2),(1,3),
        (2,3),(2,4),(2,5),
        (3,3),(3,5);

-- -----------------------------
-- scans
-- -----------------------------
insert into scans (scan_name, scan_bio) values 
("yugenmangas","https://discord-yugenmangas.com,https://facebook-yugenmangas.com,https://twitter-yugenmangas.com"),
("world project","https://discord-worldproject.com"),
("scans Mango","https://discord-scanMango.com"),
("olimpusScans","https://discord-olimpusScan.com"),
("scans tigres","https://discord-scan tigres.com");

-- -----------------------------
-- types
-- -----------------------------
insert into `types` (tp_type) 
values ("manga"),("capitulo"),("usuario");

-- -----------------------------
-- user_roles
-- -----------------------------
INSERT INTO user_roles (ur_role, ur_description)
VALUES ('admin', 'Administrator with full access'),
       ('scanner', 'scanner with limited access'),
       ('reader', 'reader with read-only access');
       
-- -----------------------------
-- user_classes
-- -----------------------------
INSERT INTO user_classes (ucla_race, ucla_description)
VALUES ('Guerrero', 'Un luchador especializado en el combate cuerpo a cuerpo y la defensa'),
       ('Mago', 'Un hechicero que utiliza la magia para controlar el entorno y atacar a sus enemigos'),
       ('Pícaro', 'Un aventurero astuto y escurridizo especializado en el sigilo y el engaño'),
       ('Clerigo', 'Un sanador y canalizador de energías divinas que puede proteger y curar a sus aliados'),
       ('Paladín', 'Un guerrero sagrado que combina habilidades de combate y magia divina para luchar contra el mal'),
       ('Bardo', 'Un artista ambulante que utiliza su talento para inspirar y motivar a sus aliados y confundir a sus enemigos');      

-- -----------------------------
-- images
-- -----------------------------
INSERT INTO `yugenmangas`.`images` VALUES
(6, 'Imagen 19', 'https://example.com/imagen9.jpg', 1),
(1, 'Imagen 1', 'https://example.com/imagen1.jpg', 1),
(2, 'Imagen 2', 'https://example.com/imagen2.jpg', 2),
(1, 'Imagen 3', 'https://example.com/imagen3.jpg', 1),
(3, 'Imagen 4', 'https://example.com/imagen4.jpg', 2),
(2, 'Imagen 5', 'https://example.com/imagen5.jpg', 3),
(4, 'Imagen 6', 'https://example.com/imagen6.jpg', 1),
(3, 'Imagen 7', 'https://example.com/imagen7.jpg', 2),
(5, 'Imagen 8', 'https://example.com/imagen8.jpg', 3),
(6, 'Imagen 9', 'https://example.com/imagen9.jpg', 1),
(4, 'Imagen 10', 'https://example.com/imagen10.jpg', 2);
-- -----------------------------
-- users 
-- -----------------------------
INSERT INTO users (user_name, user_email, user_password, user_created_at, user_state, user_last_login, user_country, user_phone, user_date_of_birth, user_gender, user_address, user_security_code, user_img_title_id, user_ucla_id, user_ur_id) VALUES
('Juan Perez', 'juanperez@example.com', 'mypassword123', '2022-03-13 10:00:00', 1, '2022-03-13 15:30:00', 'Mexico', '512345678', '1990-05-10', 'M', 'Av. Siempreviva 123', '1234', 1, 2, 1),
('Maria Gomez', 'mariagomez@example.com', 'securepassword321', '2022-03-12 08:30:00', 1, '2022-03-13 11:45:00', 'Colombia', '2345671248', '1995-11-20', 'F', 'Calle Falsa 123', '5678', 2, 1, 2),
('Pedro Hernandez', 'pedrohernandez@example.com', 'mysecurepassword', '2022-03-10 14:20:00', 0, '2022-03-13 11:45:00', 'Peru', '987654321', '1985-02-18', 'M', 'Av. Simón Bolívar 456', '4321', 3, 4, 2),
('Ana Lopez', 'anita_lopez@example.com', 'mypassword456', '2022-03-09 11:00:00', 1, '2022-03-13 18:00:00', 'Argentina', '512555678', '2000-08-14', 'F', 'Av. Corrientes 1234', '7890', 4, 3, 1),
('Luis Rodriguez', 'luisrodriguez@example.com', 'mysecretpassword', '2022-03-08 16:45:00', 0, '2022-03-13 11:45:00' , 'Chile', '512123678', '1998-03-25', 'M', 'Calle Falsa 456', '2468', 5, 1, 2);

-- -----------------------------
-- views
-- -----------------------------
INSERT INTO views (view_title_id, view_user_id, view_count) VALUES
(1, 1, 10),
(2, 3, 15),
(1, 2, 27),
(4, 5, 43),
(1, 4, 12);

-- -----------------------------
-- comments
-- -----------------------------
INSERT INTO comments (com_description, com_user_id, com_tp_id) VALUES
('Me encantó el artículo, muy interesante.', 1, 2),
('No estoy de acuerdo con lo que se dice aquí.', 3, 1),
('Gracias por compartir esta información.', 2, 1),
('Creo que podrían profundizar más en el tema.', 4, 2),
('Este artículo no me resultó útil en absoluto.', 1, 3);

-- -----------------------------
-- chapters
-- -----------------------------
INSERT INTO chapters (chap_title_id, chap_number, chap_date, chap_comment_id, chap_img_title_id)
VALUES
    (1, 1, '2022-01-01', 1, 1),
    (2, 2, '2022-01-02', 2, 2),
    (3, 3, '2022-01-03', 3, 3),
    (4, 4, '2022-01-04', 4, 4),
    (5, 5, '2022-01-05', 5, 5);

-- -----------------------------
-- mangas
-- -----------------------------
INSERT INTO mangas(
	man_description,
	man_date,
	man_ar_id,
	man_author_id,
	man_comment_id,
	man_production_id,
	man_scan_id,
	man_title_id
 )
VALUES 
('Descripción del manga 1', '2022-03-12', 1, 1, 1, 1, 1, 1),
('Descripción del manga 2', '2022-03-11', 2, 2, 2, 2, 2, 2),
('Descripción del manga 3', '2022-03-10', 1, 3, 3, 3, 3, 3),
('Descripción del manga 4', '2022-03-09', 2, 4, 4, 4, 4, 4),
('Descripción del manga 5', '2022-03-08', 1, 5, 5, 5, 5, 5);

-- -----------------------------
-- stores procedures - new
-- ------------------- 
 /*
 */


















