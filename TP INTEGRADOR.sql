DROP DATABASE IF EXISTS los_mas_vendidos;
CREATE DATABASE IF NOT EXISTS los_mas_vendidos;

USE los_mas_vendidos;

DROP TABLE IF EXISTS libros;
CREATE TABLE libros (
            id INT NOT NULL AUTO_INCREMENT,
            ranking int ,
            titulo VARCHAR(200),
            url VARCHAR(130),
            precio double,
            precio_usd double,
            precio_usd_blue double,
            fecha_ingreso DATE,
            PRIMARY KEY(id)
            );
            

DROP TABLE IF EXISTS errores;
CREATE TABLE IF NOT EXISTS errores (
idError int not null,
titulo VARCHAR(70),
url VARCHAR(40),
fecha DATE,
PRIMARY KEY(idError)
);


-- funcion para convertir el precio:

drop function if exists precio_tipo_dolar;
DELIMITER $$
CREATE FUNCTION precio_tipo_dolar(dolar DECIMAL(10,2), precio decimal(10,2)) RETURNS DOUBLE(10,2)
BEGIN
	DECLARE precio_dolar DECIMAL(10,2);
    SET precio_dolar = precio/dolar;
    RETURN precio_dolar;
END$$

DELIMITER ;

/**
-- select precio_tipo_dolar(360.00, (select precio from libros where id_libro = 1));

UPDATE `libros` SET precio_usd = precio_tipo_dolar(367.00,precio);
UPDATE `libros` SET precio_usd_blue = precio_tipo_dolar(785,precio);
UPDATE `libros` set fecha_ingreso = date('2023-09-28');
**/


ALTER TABLE libros MODIFY COLUMN titulo VARCHAR(255);



use los_mas_vendidos;
select * from libros;
SHOW CREATE TABLE libros;

select* from libros where fecha_ingreso = '2023-11-12';

select distinct fecha_ingreso from libros order by fecha_ingreso desc;

-- CARAGAR DATOS DESDE TABLA LIBROS2

select id,titulo, url, precio, fecha_ingreso  from libros2 where fecha_ingreso = '2023-09-30';

insert into libros (ranking, titulo, url, precio, fecha_ingreso)
select id,titulo, url, precio, fecha_ingreso  from libros2 where fecha_ingreso = '2023-09-30';

INSERT INTO libros (ranking, titulo, url, precio, fecha_ingreso)
SELECT 
    ROW_NUMBER() OVER (ORDER BY id) AS ranking,
    titulo,
    url,
    precio,
    fecha_ingreso
FROM libros2
WHERE fecha_ingreso = '2023-11-08';


-- alter table libros change `titulo`  `titulo` varchar(200);

select * from libros order by fecha_ingreso;
select * from errores;

SELECT DISTINCT url FROM libros where Categoria is null;

SET SQL_SAFE_UPDATES = 0;

UPDATE `libros` SET precio_usd = precio_tipo_dolar(	368.05,precio) where fecha_ingreso ='2023-11-08' ;
UPDATE `libros` SET precio_usd_blue = precio_tipo_dolar(890 ,precio) where fecha_ingreso = '2023-11-08';


select distinct titulo from libros where Autor = 'Sin Datos' and fecha_ingreso = curdate();

UPDATE `libros` SET Autor = 'GABRIELA EXILART' where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';
select * from libros where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';

UPDATE `libros` SET Autor = 'PEREZ-REVERTE, ARTURO' where url = 'https://cuspide.com/producto/el-problema-final/';
select * from libros where url = 'https://cuspide.com/producto/el-problema-final/';

UPDATE `libros` SET Autor = 'KAWAGUCHI, TOSHIKAZU' where url = 'https://cuspide.com/producto/antes-de-que-se-enfrie-el-cafe/';
select * from libros where url = 'https://cuspide.com/producto/antes-de-que-se-enfrie-el-cafe/'; 

UPDATE `libros` SET Autor = "O'DONNELL, MARIA" where url = 'https://cuspide.com/producto/born-y-quieto/';
select * from libros where url = 'https://cuspide.com/producto/born-y-quieto/'; 

UPDATE `libros` SET Autor = "AURELIO, MARCO" where url = 'https://cuspide.com/producto/meditaciones-2/';
select * from libros where url = 'https://cuspide.com/producto/meditaciones-2/'; 


UPDATE `libros` SET Autor = "HAN, BYUNG-CHUL" where url = 'https://cuspide.com/producto/vida-contemplativa/';
select * from libros where url = 'https://cuspide.com/producto/vida-contemplativa/'; 


UPDATE `libros` SET Autor = "INCHAUSPE, JESSIE" where url = 'https://cuspide.com/producto/la-revolucion-de-la-glucosa-2/';
select * from libros where url = 'https://cuspide.com/producto/la-revolucion-de-la-glucosa-2/'; 


UPDATE `libros` SET Autor = "DELEVIGNE, EMILY" where url = 'https://cuspide.com/producto/siempre-fuiste-tu/';
select * from libros where url = 'https://cuspide.com/producto/siempre-fuiste-tu/'; 


UPDATE `libros` SET Autor = "GOPAR, SOLEDAD" where url = 'https://cuspide.com/producto/desarma-este-libro/';
select * from libros where url = 'https://cuspide.com/producto/desarma-este-libro/'; 


UPDATE `libros` SET Autor = "FONTANA, ELIZABETH" where url = 'https://cuspide.com/producto/minicuentos-de-primavera/';
select * from libros where url = 'https://cuspide.com/producto/minicuentos-de-primavera/'; 


UPDATE `libros` SET Autor = "KAMIYA, ALEJANDRA" where url = 'https://cuspide.com/producto/los-arboles-caidos-tambien-son-del-bosque/';
select * from libros where url = 'https://cuspide.com/producto/los-arboles-caidos-tambien-son-del-bosque/'; 


UPDATE `libros` SET Autor = "VARGAS LLOSA, MARIO" where url = 'https://cuspide.com/producto/le-dedico-mi-silencio/';
select * from libros where url = 'https://cuspide.com/producto/le-dedico-mi-silencio/'; 


UPDATE `libros` SET Autor = "BUHAJE, IVAN" where url = 'https://cuspide.com/producto/lo-mejor-y-lo-peor-de-internet/';
select * from libros where url = 'https://cuspide.com/producto/lo-mejor-y-lo-peor-de-internet/'; 


UPDATE `libros` SET Autor = "RIVERO, VIVIANA" where url = 'https://cuspide.com/producto/apia-de-roma/';
select * from libros where url = 'https://cuspide.com/producto/apia-de-roma/'; 


UPDATE `libros` SET Autor = "MARCHI, SERGIO" where url = 'https://cuspide.com/producto/algun-tiempo-atras-la-vida-de-gustavo-cerati/';
select * from libros where url = 'https://cuspide.com/producto/algun-tiempo-atras-la-vida-de-gustavo-cerati/'; 


UPDATE `libros` SET Autor = "QUINO" where url = 'https://cuspide.com/producto/mafalda-todas-las-tiras/';
select * from libros where url = 'https://cuspide.com/producto/mafalda-todas-las-tiras/'; 


UPDATE `libros` SET Autor = "HOROWICZ, ALEJANDRO" where url = 'https://cuspide.com/producto/el-kirchnerismo-desarmado/';
select * from libros where url = 'https://cuspide.com/producto/el-kirchnerismo-desarmado/'; 


UPDATE `libros` SET Autor = "DYER, WAYNE" where url = 'https://cuspide.com/producto/tus-zonas-erroneas/';
select * from libros where url = 'https://cuspide.com/producto/tus-zonas-erroneas/'; 

UPDATE `libros` SET Autor = "YARROS, REBECA" where url = 'https://cuspide.com/producto/alas-de-sangre/';
select * from libros where url = 'https://cuspide.com/producto/alas-de-sangre/'; 


UPDATE `libros` SET Autor = "MARTINEZ, MARIA" where url = 'https://cuspide.com/producto/cuando-no-queden-mas-estrellas-que-contar-2/';
select * from libros where url = 'https://cuspide.com/producto/cuando-no-queden-mas-estrellas-que-contar-2/'; 


UPDATE `libros` SET Autor = "QUINO" where url = 'https://cuspide.com/producto/la-filosofia-de-mafalda/';
select * from libros where url = 'https://cuspide.com/producto/la-filosofia-de-mafalda/'; 

UPDATE `libros` SET Autor = "CLEAR, JAMES" where url = 'https://cuspide.com/producto/habitos-atomicos-2/';
select * from libros where url = 'https://cuspide.com/producto/habitos-atomicos-2/'; 


UPDATE `libros` SET Autor = "LICHI" where url = 'https://cuspide.com/producto/como-se-llama-esta-cancion-de-amor/';
select * from libros where url = 'https://cuspide.com/producto/como-se-llama-esta-cancion-de-amor/'; 

UPDATE `libros` SET Autor = "BARRANTES, GUILLERMO" where url = 'https://cuspide.com/producto/cronicas-mundiales-las-mejores-anecdotas-de-la-copa-del-mundo-2023/';
select * from libros where url = 'https://cuspide.com/producto/cronicas-mundiales-las-mejores-anecdotas-de-la-copa-del-mundo-2023/'; 


update libros set Autor = 'Sin Datos' where Autor = 'None';
select distinct autor from libros order by autor;

select precio_usd_blue from  libros;
update libros set precio_usd_blue = round(precio_usd_blue, 2);

select precio_usd from  libros;
update libros set precio_usd = round(precio_usd, 2);

drop table if exists autores;
create table if not exists autores(
Id int not null auto_increment,
Autor varchar(200) not null default 'Nulo',
primary key (Id)
);

select distinct Autor from libros  where Autor is not null order by Autor; 
insert into Autores(Autor)
select distinct Autor from libros  where Autor is not null order by Autor;

SELECT * FROM autores;


select distinct categoria from libros where categoria is not null order by categoria;

drop table if exists categorias;
create table if not exists categorias(
Id int not null auto_increment,
Categoria varchar(200) not null default 'Nulo',
primary key (Id)
);

insert into categorias (Categoria)
select distinct categoria from libros where categoria is not null order by categoria;

select * from categorias;

-- Reemplazo los nombre de autores y categorias por los Id
ALTER TABLE `libros` ADD `IdAutor` INT NOT NULL DEFAULT '0' AFTER `Autor`;

select* from libros;
select * from autores;
UPDATE libros l JOIN autores a
	ON (l.Autor = a.Autor)
SET l.IdAutor = a.Id;


ALTER TABLE `libros` ADD `IdCategoria` INT NOT NULL DEFAULT '0' AFTER `Categoria`;

UPDATE libros l JOIN categorias c
	ON (l.Categoria = c.Categoria)
SET l.IdCategoria = c.Id where l.Categoria != 'Sin Datos';

select* from libros;
select * from categorias;
select* from autores;

ALTER TABLE `libros`
  DROP `Autor`,
  DROP `Categoria`;
  
  
  select*from libros order by fecha_ingreso, ranking;
  
-- Crear una tabla temporal con los datos ordenados por fecha
CREATE TEMPORARY TABLE temp_libros AS
SELECT * FROM libros
ORDER BY fecha_ingreso, ranking;

-- Eliminar la tabla original
-- Recrear la tabla original con un nuevo ID autoincremental

DROP TABLE IF EXISTS libros;
CREATE TABLE libros (
            Id INT NOT NULL AUTO_INCREMENT,
            Ranking int ,
            Titulo VARCHAR(200),
            IdAutor INT NOT NULL DEFAULT '0',
            IdCategoria INT NOT NULL DEFAULT '0',
            URL VARCHAR(130),
            Precio double,
            Precio_dolar double,
            Precio_dolar_blue double,
            Fecha_ingreso DATE,
            PRIMARY KEY(Id)
            );
            


-- Insertar datos ordenados desde la tabla temporal
INSERT INTO libros (Ranking, Titulo, IdAutor, IdCategoria, URL, Precio, Precio_dolar, Precio_dolar_blue, Fecha_ingreso)
SELECT ranking, titulo, IdAutor, IdCategoria, url, precio, precio_usd, precio_usd_blue, fecha_ingreso FROM temp_libros;

select * from libros where fecha_ingreso = curdate();


-- Eliminar la tabla temporal
DROP TEMPORARY TABLE IF EXISTS temp_libros;
DROP TABLE IF EXISTS libros2;

/**
Agrego nuevamente columnas autores y categorias para la carga incremental**/



ALTER TABLE `libros` ADD `Autor` varchar (200)  AFTER `IdAutor`;


UPDATE libros l JOIN autores a
	ON (l.IdAutor = a.Id)
SET l.Autor = a.Autor;

delete from libros where Fecha_ingreso = curdate();


select * from categorias;
ALTER TABLE `libros` ADD `Categoria` varchar (200)  AFTER `IdCategoria`;


UPDATE libros l JOIN categorias c
	ON (l.IdCategoria = c.Id)
SET l.Categoria = c.Categoria;
select * from libros;

-- creo tabla nombre_libro con los id de cada libro

select distinct Titulo from libros where Titulo is not null order by Titulo;

drop table if exists nombre_libro;
create table if not exists nombre_libro(
IdLibro int not null auto_increment,
Titulo varchar(200) not null default 'Nulo',
URL varchar (100) ,
primary key (IdLibro)
);

insert into nombre_libro (Titulo)
select distinct Titulo from libros where Titulo is not null order by Titulo;

select * from LIBROS where titulo = 'EL VUELO DE LA LIBELULA';
select * from autores where Id = 56 OR ID = 62;

SELECT * FROM AUTORES;


select * from categorias;
UPDATE  libros SET IdAutor = 56 where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';
UPDATE  libros SET IdCategoria = 6 where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';
UPDATE  autores  SET IdCategoria = 6 where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';
delete from autores where Id = 62;

select * from libros where url = 'https://cuspide.com/producto/el-vuelo-de-la-libelula/';

select * from nombre_libro ;
select * from libros where categoria = 'Sin Datos';
update libros set IdCategoria = 15 where titulo = 'HABITOS ATOMICOS';
select * from libros;
select * from autores;

update libros set IdCategoria = 0 where Categoria = 'Sin Datos';
select * from libros where titulo like 'el informe%';

select * from categorias;
ALTER TABLE `libros` ADD `IdLibro` int not null default 0  AFTER `Titulo`;

UPDATE libros l JOIN nombre_libro n
	ON (l.Titulo = n.Titulo)
SET l.IdLibro = n.IdLibro where l.Titulo is not null;


SELECT DISTINCT URL FROM LIBROS;

UPDATE libros l JOIN nombre_libro n
	ON (l.IdLibro = n.IdLibro)
SET n.URL = l.URL;

select * from libros where categoria = 'Sin Datos';
