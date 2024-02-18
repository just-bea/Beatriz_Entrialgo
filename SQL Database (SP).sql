CREATE DATABASE Modelo_Distribucion;
USE Modelo_Distribucion;

CREATE TABLE Categoria (
    categoria_id CHAR(10),
    descuento FLOAT,
    descripcion varchar(50),
    minimo INT,
    maximo INT,
    PRIMARY KEY (categoria_id)
);

INSERT INTO Categoria (categoria_id, descuento, descripcion, minimo)
VALUES ('A', '0.20', 'Excelente', '25000' );
INSERT INTO Categoria (categoria_id, descuento, descripcion, minimo,maximo)
VALUES ('B', '0.15', 'Bueno',  '15001', '25000' );
INSERT INTO Categoria (categoria_id, descuento, descripcion, minimo,maximo)
VALUES ('C', '0.10', 'Regular', '5001', '15000' );
INSERT INTO Categoria (categoria_id, descuento, descripcion, minimo,maximo)
VALUES ('D', '0.05', 'Malo', '1001', '5000' );
INSERT INTO Categoria (categoria_id, descuento, descripcion, minimo,maximo)
VALUES ('E', '0', 'Insuficiente para conceder descuento','0', '1000' );

CREATE TABLE Tienda (
  tienda_id int AUTO_INCREMENT,
  categoria_id char(10),
  limite_credito float,
  nombre varchar(50),
  PRIMARY KEY (tienda_id),
  FOREIGN KEY (categoria_id) REFERENCES Categoria (categoria_id)
);

INSERT INTO Tienda (tienda_id, categoria_id, limite_credito, nombre)
VALUES ('0001','A','30000','Bea');
INSERT INTO Tienda (categoria_id, limite_credito, nombre)
VALUES ('B', '20000', 'Mango');


CREATE TABLE Direccion_Tienda (
 direccion_id int AUTO_INCREMENT,
  tienda_id int,
  calle_tienda varchar(50),
  num_tienda int,
  poblacion_tienda varchar(50),
  ciudad_tienda varchar(50),
  telefono_tienda varchar(50),
  email_tienda varchar(50),
  PRIMARY KEY (direccion_id),
  FOREIGN KEY (tienda_id) REFERENCES Tienda(tienda_id)
);

INSERT INTO Direccion_Tienda (direccion_id, tienda_id, calle_tienda, num_tienda, poblacion_tienda, ciudad_tienda, telefono_tienda, email_tienda)
VALUES ('0001', '0001', 'Arenal', '1', 'Madrid', 'Madrid', '+34 612 34 56 78', 'primeratienda@gmail.com');
INSERT INTO Direccion_Tienda (tienda_id, calle_tienda, num_tienda, poblacion_tienda, ciudad_tienda, telefono_tienda, email_tienda)
VALUES ( '0002', 'Carretas', '3', 'Madrid', 'Madrid', '+34 678 34 56 78', 'segundatienda@gmail.com');


CREATE TABLE Pedido (
  tienda_id int,
  pedido_id int AUTO_INCREMENT,
  fecha_compra datetime,
  direccion_id int,
  fecha_entrega_final datetime,
  importe_total float,
  PRIMARY KEY (pedido_id),
  FOREIGN KEY (tienda_id) REFERENCES Tienda(tienda_id),
  FOREIGN KEY (direccion_id) REFERENCES Direccion_Tienda(direccion_id)
);

INSERT INTO Pedido (tienda_id, pedido_id, fecha_compra, direccion_id, fecha_entrega_final)
VALUES ('0001', '0001','22-02-21 12:00:00', '0001', '22-01-22 12:00:00');
INSERT INTO Pedido (tienda_id, fecha_compra, direccion_id, fecha_entrega_final)
VALUES ('0002','23-02-21 12:00:00', '0002', '23-01-22 12:00:00');



CREATE TABLE Articulos (
  articulo_id int AUTO_INCREMENT,
  descripcion varchar(150),
  coste float,
  PVP float,
  PRIMARY KEY (articulo_id)
);

INSERT INTO Articulos (articulo_id, descripcion, coste, PVP)
VALUES ('1', 'portátil gris', '800', '1000');
INSERT INTO Articulos (descripcion, coste, PVP)
VALUES ('portátil negro', '700', '900');

CREATE TABLE Proveedor (
  prov_id int AUTO_INCREMENT,
  nombre_prov varchar(50),
  calle_prov varchar(50),
  poblacion_prov varchar(50),
  ciudad_prov varchar(50),
  telefono_prov varchar(50),
  email_prov varchar(50),
  num_prov int,
  PRIMARY KEY (prov_id)
);

INSERT INTO Proveedor(prov_id, nombre_prov, calle_prov, poblacion_prov, ciudad_prov, telefono_prov, email_prov, num_prov)
VALUES ('0001', 'SEUR', 'Ferraz','Madrid','Madrid','+34 654 12 34 56','primerproveedor@gmail.com','1');
INSERT INTO Proveedor(nombre_prov, calle_prov, poblacion_prov, ciudad_prov, telefono_prov, email_prov, num_prov)
VALUES ('DHL', 'Castellana','Madrid','Madrid','+34 612 12 34 56','segundoproveedor@gmail.com','40');

CREATE TABLE Lineas (
  linea_id int AUTO_INCREMENT,
  pedido_id int,
  articulo_id int,
  cantidad int,
  importe_total_linea float,
  prov_id int,
  fecha_entrega datetime,
  descripcion varchar(150),
  PRIMARY KEY (linea_id),
  FOREIGN KEY (articulo_id) REFERENCES Articulos(articulo_id),
  FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
  FOREIGN KEY (prov_id) REFERENCES Proveedor(prov_id)
);

INSERT INTO Lineas (linea_id, pedido_id, articulo_id, cantidad, importe_total_linea, prov_id, fecha_entrega, descripcion)
VALUES ('0001','0001','1','2','2000','0001','22-02-21 12:00:00','portátil gris');
INSERT INTO Lineas (pedido_id, articulo_id, cantidad, importe_total_linea, prov_id, fecha_entrega, descripcion)
VALUES ('0001','2','1','900','0002','22-02-21 12:00:00','portátil negro');
INSERT INTO Lineas (pedido_id, articulo_id, cantidad, importe_total_linea, prov_id, fecha_entrega, descripcion)
VALUES ('0002','1','3','3000','0001','23-01-22 12:00:00','portátil gris');
INSERT INTO Lineas (pedido_id, articulo_id, cantidad, importe_total_linea, prov_id, fecha_entrega, descripcion)
VALUES ('0002','2','2','1800','0002','23-01-22 12:00:00','portátil negro');


##Pregunta 3
SELECT t.categoria_id
,t.nombre
,t.limite_credito
,c.descuento
,d.*

FROM (Direccion_Tienda AS d RIGHT JOIN Tienda AS t ON
d.tienda_id = t.tienda_id)
INNER JOIN Categoria AS c ON t.categoria_id = c.categoria_id;

##Pregunta 4
SELECT p.pedido_id
,p.fecha_entrega_final
,l.articulo_id
,a.descripcion
,l.cantidad
,c.descuento
,a.PVP
, l.cantidad *a.PVP AS importe_total
, l.cantidad *a.PVP * c.descuento AS importe_total_con_descuento
,YEAR(p.fecha_entrega_final) AS año
,d.*

FROM (Pedido AS p INNER JOIN Direccion_Tienda AS d ON
p.direccion_id = d.direccion_id)
INNER JOIN Tienda AS t ON t.tienda_id = d.direccion_id
INNER JOIN Categoria AS c ON c.categoria_id = t.categoria_id
INNER JOIN Lineas AS l ON l.pedido_id = p.pedido_id
INNER JOIN Articulos AS a ON a.articulo_id = l.articulo_id

WHERE YEAR(p.fecha_entrega_final) = '2022';



##Pregunta 5
SELECT l.linea_id
, p.*
,a.articulo_id
FROM (Lineas AS l INNER JOIN Proveedor AS p ON
l.prov_id = p.prov_id)
INNER JOIN Articulos as a ON
l.articulo_id = a.articulo_id;

##Pregunta 6
SELECT p.prov_id
,COUNT(l.linea_id) AS repartos_totales
,YEAR(l.fecha_entrega) AS año
FROM Lineas AS l INNER JOIN Proveedor AS p ON
l.prov_id = p.prov_id 
GROUP BY 
prov_id
,año;

##Pregunta 7
CREATE TABLE Categoria_Proveedor (
  categoria_prov char(10),
  porcentaje_descuento int,
  minimo int,
  maximo int,
  PRIMARY KEY (categoria_prov)
);

ALTER TABLE Proveedor 
ADD categoria_prov char(10);
ALTER TABLE Proveedor 
ADD FOREIGN KEY (categoria_prov) REFERENCES Categoria_Proveedor(categoria_prov);

##Pregunta 8
CREATE TABLE Fabrica (
  fabrica_id int AUTO_INCREMENT,
  descripcion_fabrica varchar(50),
  PRIMARY KEY (fabrica_id)
);
ALTER TABLE Articulos
ADD fabrica_id int;
ALTER TABLE Articulos 
ADD FOREIGN KEY (fabrica_id) REFERENCES Fabrica(fabrica_id);

##Pregunta 9

CREATE TABLE Region (
  codigo_region int AUTO_INCREMENT,
  nombre_region varchar(50),
  PRIMARY KEY (codigo_region) 
);

CREATE TABLE Pais (
  codigo_pais int AUTO_INCREMENT,
  nombre_pais varchar(50),
  PRIMARY KEY (codigo_pais)
);  

ALTER TABLE Region 
ADD codigo_pais int;
ALTER TABLE Region
ADD FOREIGN KEY (codigo_pais) REFERENCES Pais(codigo_pais);

CREATE TABLE Prov_Pais (
  prov_id int ,
  codigo_pais int,
  PRIMARY KEY (prov_id, codigo_pais),
  FOREIGN KEY (prov_id) REFERENCES Proveedor(prov_id),
  FOREIGN KEY (codigo_pais) REFERENCES Pais(codigo_pais)
);


##Pregunta 10
CREATE DATABASE Backup_Pedidos_Lineas;
USE Backup_Pedidos_Lineas;

CREATE TABLE Backup_Pedido (
  backup_pedido_id int AUTO_INCREMENT,
  p_tienda_id int,
  p_pedido_id int ,
  p_fecha_compra datetime,
  p_direccion_id int,
  p_fecha_entrega_final datetime,
  p_importe_total float,
  PRIMARY KEY (backup_pedido_id)
);

CREATE TABLE Backup_Lineas (
  backup_linea_id int AUTO_INCREMENT,
  backup_pedido_id int,
  l_linea_id int,
  l_pedido_id int,
  l_articulo_id int,
  l_cantidad int,
  l_importe_total_linea float,
  l_prov_id int,
  l_fecha_entrega datetime,
  l_descripcion varchar(150),
  PRIMARY KEY (backup_linea_id),
  FOREIGN KEY (backup_pedido_id) REFERENCES Backup_Pedido (backup_pedido_id)
  )
  
 
DELIMITER //
CREATE TRIGGER Backup_Trigger AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
    INSERT INTO Backup_Pedido (p_tienda_id ,p_pedido_id ,p_fecha_compra ,p_direccion_id, p_fecha_entrega_final, p_importe_total) 
    VALUES ( NEW.p_tienda_id ,NEW.p_pedido_id,NEW.p_fecha_compra, NEW.p_direccion_id, NEW.p_fecha_entrega_final, NEW.p_importe_total);
    
    INSERT INTO Backup_Lineas ( backup_pedido_id , l_linea_id ,l_pedido_id ,l_articulo_id ,l_cantidad ,l_importe_total_linea ,l_prov_id ,l_fecha_entrega ,l_descripcion)
    VALUES( NEW.backup_pedido_id , NEW.l_linea_id ,NEW.l_pedido_id ,NEW.l_articulo_id ,NEW.l_cantidad ,NEW.l_importe_total_linea ,NEW.l_prov_id ,NEW.l_fecha_entrega ,NEW.l_descripcion); 
END //

