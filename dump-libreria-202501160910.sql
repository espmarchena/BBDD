-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: libreria
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `autores_mas_vendidos`
--

DROP TABLE IF EXISTS `autores_mas_vendidos`;
/*!50001 DROP VIEW IF EXISTS `autores_mas_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `autores_mas_vendidos` AS SELECT 
 1 AS `autores`,
 1 AS `libros_vendidos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `cod_postal` varchar(10) DEFAULT NULL,
  `ComAutonoma` varchar(50) DEFAULT NULL,
  `Pais` varchar(100) DEFAULT NULL,
  `contrasenya` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Juan Perez','123456789','juan.perez@example.com','Calle Falsa 123','28001','Madrid','España','password123'),(2,'Ana García','987654321','ana.garcia@example.com','Avenida Siempreviva 456','08002','Barcelona','España','securepass'),(3,'Luis Martínez','785512555','luis.martinez@example.com','Plaza Mayor 789','41003','Sevilla','España','mypassword'),(4,'María López','666886698','maria.lopez@example.com','Calle Luna 321','46004','Valencia','España','marialopez'),(5,'Carlos Sánchez','227777778','carlos.sanchez@example.com','Avenida Sol 654','30005','Murcia','España','carloss123'),(6,'Sofia Fernández','188493888','sofia.fernandez@example.com','Calle Flor 123','50001','Zaragoza','España','sofiapass'),(7,'Miguel Torres','999999999','miguel.torres@example.com','Avenida Mar 456','35002','Las Palmas','España','miguelpass'),(8,'Laura Gómez','111185311','laura.gomez@example.com','Plaza Sol 789','07003','Palma de Mallorca','España','laurapass'),(9,'Diego Rodríguez','222287622','diego.rodriguez@example.com','Calle Luna 321','26004','Logroño','España','diegopass'),(10,'Lucía Hernández','333312033','lucia.hernandez@example.com','Avenida Tierra 654','15005','A Coruña','España','luciapass'),(11,'Daniel Ruiz','443244444','daniel.ruiz@example.com','Calle Estrella 987','38001','Santa Cruz de Tenerife','España','danielpass'),(12,'Paula Martín','555500556','paula.martin@example.com','Avenida Luna 123','33002','Oviedo','España','paulapass'),(13,'Fernando Ortega','662366667','fernando.ortega@example.com','Plaza Luna 456','18003','Granada','España','fernandopass'),(14,'Elena Santos','127777780','elena.santos@example.com','Calle Mar 789','03004','Alicante','España','elenapass'),(15,'Hugo Moreno','888278889','hugo.moreno@example.com','Avenida Estrella 321','29005','Málaga','España','hugopass'),(16,'Lidia Gonzalez','123666689','lidia.gonzalez@example.com','Calle Base de datos 123','41002','Sevilla','España','password111');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER beforeInsertClientes
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    DECLARE cuenta_email INT;

    -- Comprobar si el email ya existe
    SELECT COUNT(*) INTO cuenta_email
    FROM clientes
    WHERE email = NEW.email;

    -- Lanzar un error si el email ya existe
    IF cuenta_email > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email ya está en uso.';
    END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle`
--

DROP TABLE IF EXISTS `detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle` (
  `idPedido` int(11) NOT NULL,
  `idLibro` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `precio` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idPedido`,`idLibro`),
  KEY `fklibro` (`idLibro`),
  CONSTRAINT `fklibro` FOREIGN KEY (`idLibro`) REFERENCES `libros` (`idLibro`),
  CONSTRAINT `fkpedido` FOREIGN KEY (`idPedido`) REFERENCES `pedidos` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle`
--

LOCK TABLES `detalle` WRITE;
/*!40000 ALTER TABLE `detalle` DISABLE KEYS */;
INSERT INTO `detalle` VALUES (1,1,2,29.95),(1,2,4,24.95),(2,3,3,19.95),(2,4,1,9.95),(2,5,3,14.95),(2,15,1,24.95),(2,24,2,18.95),(3,5,2,14.95),(3,6,1,29.95),(4,7,2,19.95),(4,8,1,24.95),(5,9,3,14.95),(5,10,2,29.95),(6,11,1,19.95),(6,12,2,9.95),(7,13,2,14.95),(7,14,1,19.95),(8,15,3,24.95),(8,16,1,12.95),(9,17,2,24.95),(9,18,1,14.95),(10,3,2,19.95),(10,10,2,29.95),(10,19,1,39.95),(10,20,2,29.95),(10,21,2,18.95),(11,21,2,18.95),(11,22,1,15.95),(12,23,1,22.95),(12,24,2,18.95),(13,25,3,14.95),(13,26,2,24.95),(14,27,1,22.95),(14,28,2,29.95),(15,29,1,12.95),(15,30,2,24.95);
/*!40000 ALTER TABLE `detalle` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_detalle
AFTER UPDATE ON detalle
FOR EACH ROW
BEGIN
    DECLARE nuevo_subtotal DECIMAL(10, 2);
    DECLARE nuevo_total DECIMAL(10, 2);
    DECLARE gastos_envio DECIMAL(10, 2);

    -- Calcular el nuevo subtotal sumando los precios de todos los detalles del pedido
    SELECT SUM(precio * Cantidad) INTO nuevo_subtotal
    FROM detalle
    WHERE idPedido = NEW.idPedido;

    -- Obtener los gastos de envío del pedido
    SELECT GatosEnvio INTO gastos_envio
    FROM pedidos
    WHERE idPedido = NEW.idPedido;

    -- Calcular el nuevo total sumando el subtotal y los gastos de envío
    SET nuevo_total = nuevo_subtotal + gastos_envio;

    -- Actualizar el subtotal y el total del pedido
    UPDATE pedidos
    SET SubTotal = nuevo_subtotal, Total = nuevo_total
    WHERE idPedido = NEW.idPedido;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER afterUpdateDetalle
AFTER UPDATE ON detalle
FOR EACH ROW
BEGIN
    DECLARE nuevo_subtotal decimal(10, 2);
    DECLARE nuevo_total decimal(10, 2);
    DECLARE gastos_envio decimal(10, 2);

    -- Calcular el nuevo subtotal sumando los precios de todos los detalles del pedido
    SELECT SUM(precio * Cantidad) INTO nuevo_subtotal
    FROM detalle
    WHERE idPedido = NEW.idPedido;

    -- Obtener los gastos de envío del pedido
    SELECT GatosEnvio INTO gastos_envio
    FROM pedidos
    WHERE idPedido = NEW.idPedido;

    -- Calcular el nuevo total sumando el subtotal y los gastos de envío
    SET nuevo_total = nuevo_subtotal + gastos_envio;

    -- Actualizar el subtotal y el total del pedido
    UPDATE pedidos
    SET SubTotal = nuevo_subtotal, Total = nuevo_total
    WHERE idPedido = NEW.idPedido;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger recalcular_Pedido
after update on detalle
for each row
begin 
    update pedidos
    set subTotal = (select sum(precio * Cantidad) from detalle where idPedido = new.idPedido),
        Total = (select subTotal + gastosEnvio from pedidos where idPedido = new.idPedido)
    where idPedido = new.idPedido;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `idLibro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(300) DEFAULT NULL,
  `autores` varchar(800) DEFAULT NULL,
  `puntuacion_media` decimal(4,2) DEFAULT NULL,
  `isbn` varchar(11) DEFAULT NULL,
  `isbn13` varchar(13) DEFAULT NULL,
  `idioma` varchar(10) DEFAULT NULL,
  `num_paginas` int(11) DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `Editor` varchar(100) DEFAULT NULL,
  `Color` bit(1) DEFAULT NULL,
  `precioVENTA` decimal(5,2) DEFAULT NULL,
  `idTamanyo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idLibro`),
  KEY `fktamaño` (`idTamanyo`),
  CONSTRAINT `fktamaño` FOREIGN KEY (`idTamanyo`) REFERENCES `tamanyo` (`idTamanyo`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'El Quijote','Miguel de Cervantes',4.80,'12345678901','9781234567897','Español',863,'1605-01-16','Alfaguara',_binary '\0',29.95,1),(2,'Cien Años de Soledad','Gabriel García Márquez',4.70,'23456789012','9782345678903','Español',471,'1967-05-30','Sudamericana',_binary '',29.38,2),(3,'Donde los Árboles Cantan','Laura Gallego',4.60,'34567890123','9783456789010','Español',477,'2011-10-14','SM',_binary '',29.73,3),(4,'El Principito','Antoine de Saint-Exupéry',4.90,'45678901234','9784567890127','Francés',96,'1943-04-06','Gallimard',_binary '',9.95,4),(5,'1984','George Orwell',4.80,'56789012345','9785678901234','Inglés',328,'1949-06-08','Secker & Warburg',_binary '\0',14.95,5),(6,'Fahrenheit 451','Ray Bradbury',4.70,'67890123456','9786789012341','Inglés',256,'1953-10-19','Ballantine Books',_binary '\0',12.95,1),(7,'El Nombre del Viento','Patrick Rothfuss',4.90,'78901234567','9787890123458','Inglés',662,'2007-03-27','DAW Books',_binary '',40.65,2),(8,'La Sombra del Viento','Carlos Ruiz Zafón',4.80,'89012345678','9788901234565','Español',576,'2001-04-17','Planeta',_binary '\0',19.95,3),(9,'Harry Potter y la Piedra Filosofal','J.K. Rowling',4.90,'90123456789','9789012345672','Inglés',223,'1997-06-26','Bloomsbury',_binary '',24.95,4),(10,'Juego de Tronos','George R.R. Martin',4.80,'11234567890','9781123456789','Inglés',694,'1996-08-06','Bantam Spectra',_binary '',42.54,5),(11,'Los Pilares de la Tierra','Ken Follett',4.70,'12345678912','9781234567896','Inglés',1008,'1989-10-16','Macmillan',_binary '\0',24.95,1),(12,'La Chica del Tren','Paula Hawkins',4.50,'23456789023','9782345678902','Inglés',395,'2015-01-13','Riverhead Books',_binary '',24.90,2),(13,'Orgullo y Prejuicio','Jane Austen',4.80,'34567890134','9783456789019','Inglés',432,'1813-01-28','T. Egerton',_binary '\0',9.95,3),(14,'El Alquimista','Paulo Coelho',4.70,'45678901245','9784567890126','Portugués',208,'1988-05-01','HarperTorch',_binary '',14.95,4),(15,'La Catedral del Mar','Ildefonso Falcones',4.60,'56789012356','9785678901233','Español',672,'2006-06-16','Grijalbo',_binary '\0',19.95,5),(16,'Crónica de una Muerte Anunciada','Gabriel García Márquez',4.70,'67890123467','9786789012340','Español',122,'1981-03-15','Editorial Oveja Negra',_binary '\0',12.95,1),(17,'El Juego de Ender','Orson Scott Card',4.80,'78901234578','9787890123457','Inglés',324,'1985-01-15','Tor Books',_binary '',20.71,2),(18,'La Metamorfosis','Franz Kafka',4.90,'89012345689','9788901234564','Alemán',201,'1915-12-17','Kurt Wolff Verlag',_binary '',13.45,3),(19,'Matar a un Ruiseñor','Harper Lee',4.80,'90123456790','9789012345671','Inglés',281,'1960-07-11','J.B. Lippincott & Co.',_binary '\0',14.95,4),(20,'El Señor de los Anillos','J.R.R. Tolkien',4.90,'11234567891','9781123456788','Inglés',1216,'1954-07-29','George Allen & Unwin',_binary '',73.33,5),(21,'El Hobbit','J.R.R. Tolkien',4.90,'22334455667','9782233445567','Inglés',310,'1937-09-21','George Allen & Unwin',_binary '',19.88,1),(22,'El Amor en los Tiempos del Cólera','Gabriel García Márquez',4.80,'33445566778','9783344556678','Español',368,'1985-03-05','Oveja Negra',_binary '',23.30,2),(23,'La Casa de los Espíritus','Isabel Allende',4.70,'44556677889','9784455667789','Español',433,'1982-10-12','Plaza & Janés',_binary '',27.14,3),(24,'Dune','Frank Herbert',4.90,'55667788990','9785566778890','Inglés',412,'1965-08-01','Chilton Books',_binary '\0',16.95,4),(25,'Memorias de una Geisha','Arthur Golden',4.80,'66778899001','9786677889901','Inglés',448,'1997-09-27','Alfred A. Knopf',_binary '\0',15.95,5),(26,'El Código Da Vinci','Dan Brown',4.70,'77889900112','9787788990012','Inglés',689,'2003-03-18','Doubleday',_binary '',42.24,1),(27,'Los Miserables','Victor Hugo',4.80,'88990011223','9788899001123','Francés',1488,'1862-04-03','A. Lacroix, Verboeckhoven & Cie.',_binary '\0',39.95,2),(28,'La Historia Interminable','Michael Ende',4.70,'99001122334','9789900112234','Alemán',428,'1979-09-01','Thienemann Verlag',_binary '',26.84,3),(29,'La Casa de los Espíritus','Isabel Allende',4.70,'22334455667','9782233445566','Español',433,'1982-10-15','Plaza & Janés',_binary '\0',18.95,1),(30,'La Divina Comedia','Dante Alighieri',4.80,'33445566778','9783344556677','Italiano',798,'1320-01-01','Mondadori',_binary '',48.67,2),(31,'El Retrato de Dorian Gray','Oscar Wilde',4.80,'55667788990','9785566778899','Inglés',254,'1890-06-20','Lippincott\'s Monthly Magazine',_binary '',16.58,3),(32,'Los Juegos del Hambre','Suzanne Collins',4.70,'66778899001','9786677889900','Inglés',374,'2008-09-14','Scholastic Press',_binary '',24.95,5),(33,'Anna Karenina','León Tolstói',4.60,'77889900112','9787788990011','Ruso',864,'1877-01-01','The Russian Messenger',_binary '\0',22.95,1);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `libros_ciencia_ficcion`
--

DROP TABLE IF EXISTS `libros_ciencia_ficcion`;
/*!50001 DROP VIEW IF EXISTS `libros_ciencia_ficcion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `libros_ciencia_ficcion` AS SELECT 
 1 AS `idLibro`,
 1 AS `titulo`,
 1 AS `autores`,
 1 AS `puntuacion_media`,
 1 AS `isbn`,
 1 AS `isbn13`,
 1 AS `idioma`,
 1 AS `num_paginas`,
 1 AS `fecha_publicacion`,
 1 AS `Editor`,
 1 AS `Color`,
 1 AS `precioVENTA`,
 1 AS `idTamanyo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `SubTotal` decimal(6,2) DEFAULT NULL,
  `GatosEnvio` decimal(6,2) DEFAULT NULL,
  `Total` decimal(6,2) DEFAULT NULL,
  `direccionEntrega` varchar(255) DEFAULT NULL,
  `telefonoEntrega` varchar(100) DEFAULT NULL,
  `cod_postalEntrega` varchar(10) DEFAULT NULL,
  `ComAutonoma` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `fkcliente` (`idCliente`),
  CONSTRAINT `fkcliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2024-06-11 08:00:00',1,159.70,5.00,164.70,'Calle Falsa 123','123456789','28001','Madrid'),(2,'2024-06-11 09:00:00',2,30.00,3.00,33.00,'Avenida Siempreviva 456','987654321','08002','Barcelona'),(3,'2024-06-11 10:00:00',3,45.00,4.50,49.50,'Plaza Mayor 789','785512555','41003','Sevilla'),(4,'2024-06-11 11:00:00',4,55.00,5.50,60.50,'Calle Luna 321','666886698','46004','Valencia'),(5,'2024-06-11 12:00:00',5,25.00,2.50,27.50,'Avenida Sol 654','227777778','30005','Murcia'),(6,'2024-06-11 13:00:00',6,40.00,4.00,44.00,'Calle Flor 123','188493888','50001','Zaragoza'),(7,'2024-06-11 14:00:00',7,60.00,6.00,66.00,'Avenida Mar 456','999999999','35002','Las Palmas'),(8,'2024-06-11 15:00:00',8,35.00,3.50,38.50,'Plaza Sol 789','111185311','07003','Palma de Mallorca'),(9,'2024-06-11 16:00:00',9,20.00,2.00,22.00,'Calle Luna 321','222287622','26004','Logroño'),(10,'2024-06-11 17:00:00',10,75.00,7.50,82.50,'Avenida Tierra 654','333312033','15005','A Coruña'),(11,'2024-06-11 18:00:00',11,65.00,6.50,71.50,'Calle Estrella 987','443244444','38001','Santa Cruz de Tenerife'),(12,'2024-06-11 19:00:00',12,50.00,5.00,55.00,'Avenida Luna 123','555500556','33002','Oviedo'),(13,'2024-06-11 20:00:00',13,70.00,7.00,77.00,'Plaza Luna 456','662366667','18003','Granada'),(14,'2024-06-11 21:00:00',14,45.00,4.50,49.50,'Calle Mar 789','127777780','03004','Alicante'),(15,'2024-06-11 22:00:00',15,55.00,5.50,60.50,'Avenida Estrella 321','888278889','29005','Málaga'),(16,'2024-06-12 08:00:00',1,60.00,6.00,66.00,'Calle Falsa 123','123456789','28001','Madrid'),(17,'2024-06-12 09:00:00',1,40.00,4.00,44.00,'Calle Falsa 123','123456789','28001','Madrid'),(18,'2024-06-12 10:00:00',2,35.00,3.50,38.50,'Avenida Siempreviva 456','987654321','08002','Barcelona'),(19,'2024-06-12 11:00:00',3,50.00,5.00,55.00,'Plaza Mayor 789','785512555','41003','Sevilla'),(20,'2024-06-12 12:00:00',3,45.00,4.50,49.50,'Plaza Mayor 789','785512555','41003','Sevilla'),(21,'2024-06-12 13:00:00',4,70.00,7.00,77.00,'Calle Luna 321','666886698','46004','Valencia'),(22,'2024-06-12 14:00:00',5,25.00,2.50,27.50,'Avenida Sol 654','227777778','30005','Murcia'),(23,'2024-06-12 15:00:00',6,55.00,5.50,60.50,'Calle Flor 123','188493888','50001','Zaragoza'),(24,'2024-06-12 16:00:00',7,30.00,3.00,33.00,'Avenida Mar 456','999999999','35002','Las Palmas'),(25,'2024-06-12 17:00:00',8,40.00,4.00,44.00,'Plaza Sol 789','111185311','07003','Palma de Mallorca'),(26,'2024-06-12 18:00:00',9,20.00,2.00,22.00,'Calle Luna 321','222287622','26004','Logroño'),(27,'2024-06-12 19:00:00',9,25.00,2.50,27.50,'Calle Luna 321','222287622','26004','Logroño'),(28,'2024-06-12 20:00:00',10,60.00,6.00,66.00,'Avenida Tierra 654','333312033','15005','A Coruña'),(29,'2024-06-12 21:00:00',11,65.00,6.50,71.50,'Calle Estrella 987','443244444','38001','Santa Cruz de Tenerife'),(30,'2024-06-12 22:00:00',12,55.00,5.50,60.50,'Avenida Luna 123','555500556','33002','Oviedo'),(31,'2024-06-13 08:00:00',13,70.00,7.00,77.00,'Plaza Luna 456','662366667','18003','Granada'),(32,'2024-06-13 09:00:00',14,45.00,4.50,49.50,'Calle Mar 789','127777780','03004','Alicante'),(33,'2024-06-13 10:00:00',15,55.00,5.50,60.50,'Avenida Estrella 321','888278889','29005','Málaga'),(34,'2024-06-13 11:00:00',1,60.00,6.00,66.00,'Calle Falsa 123','123456789','28001','Madrid'),(35,'2024-06-13 12:00:00',2,35.00,3.50,38.50,'Avenida Siempreviva 456','987654321','08002','Barcelona'),(36,'2024-06-13 13:00:00',3,50.00,5.00,55.00,'Plaza Mayor 789','785512555','41003','Sevilla'),(37,'2024-06-13 14:00:00',4,70.00,7.00,77.00,'Calle Luna 321','666886698','46004','Valencia'),(38,'2024-06-13 15:00:00',5,25.00,2.50,27.50,'Avenida Sol 654','227777778','30005','Murcia'),(39,'2024-06-13 16:00:00',6,55.00,5.50,60.50,'Calle Flor 123','188493888','50001','Zaragoza'),(40,'2024-06-13 17:00:00',7,30.00,3.00,33.00,'Avenida Mar 456','999999999','35002','Las Palmas'),(41,'2024-06-13 18:00:00',8,40.00,4.00,44.00,'Plaza Sol 789','111185311','07003','Palma de Mallorca'),(42,'2024-06-13 19:00:00',9,20.00,2.00,22.00,'Calle Luna 321','222287622','26004','Logroño'),(43,'2024-06-13 20:00:00',10,60.00,6.00,66.00,'Avenida Tierra 654','333312033','15005','A Coruña'),(44,'2024-06-13 21:00:00',11,65.00,6.50,71.50,'Calle Estrella 987','443244444','38001','Santa Cruz de Tenerife'),(45,'2024-06-13 22:00:00',12,55.00,5.50,60.50,'Avenida Luna 123','555500556','33002','Oviedo');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `pedidos_totales`
--

DROP TABLE IF EXISTS `pedidos_totales`;
/*!50001 DROP VIEW IF EXISTS `pedidos_totales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pedidos_totales` AS SELECT 
 1 AS `idPedido`,
 1 AS `fecha`,
 1 AS `idCliente`,
 1 AS `total_pedido`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `preciosimpresion`
--

DROP TABLE IF EXISTS `preciosimpresion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preciosimpresion` (
  `idPrecios` int(11) NOT NULL AUTO_INCREMENT,
  `IdTamanyo` int(11) DEFAULT NULL,
  `precioFijo` decimal(10,4) DEFAULT NULL,
  `PrecioPorPaginaColor` decimal(10,4) DEFAULT NULL,
  `PrecioPorPaginaBlancoNegro` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`idPrecios`),
  KEY `fktamañoImpre` (`IdTamanyo`),
  CONSTRAINT `fktamañoImpre` FOREIGN KEY (`IdTamanyo`) REFERENCES `tamanyo` (`idTamanyo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preciosimpresion`
--

LOCK TABLES `preciosimpresion` WRITE;
/*!40000 ALTER TABLE `preciosimpresion` DISABLE KEYS */;
INSERT INTO `preciosimpresion` VALUES (1,1,5.0000,0.1500,0.0500),(2,2,6.0000,0.2000,0.0600),(3,3,7.0000,0.2500,0.0700),(4,4,8.0000,0.3000,0.0800),(5,5,9.0000,0.3500,0.0900);
/*!40000 ALTER TABLE `preciosimpresion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tamanyo`
--

DROP TABLE IF EXISTS `tamanyo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tamanyo` (
  `idTamanyo` int(11) NOT NULL AUTO_INCREMENT,
  `alto` int(11) DEFAULT NULL,
  `ancho` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idTamanyo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tamanyo`
--

LOCK TABLES `tamanyo` WRITE;
/*!40000 ALTER TABLE `tamanyo` DISABLE KEYS */;
INSERT INTO `tamanyo` VALUES (1,210,148,'TipoA5'),(2,297,210,'TipoA4'),(3,420,297,'TipoA3'),(4,594,420,'TipoA2'),(5,841,594,'TipoA1');
/*!40000 ALTER TABLE `tamanyo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'libreria'
--
/*!50003 DROP FUNCTION IF EXISTS `calcularCosteImpresion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularCosteImpresion`(id_libro INT) RETURNS decimal(10,2)
begin
    declare numDePaginas int;
    declare es_color boolean;
    declare costeFijo decimal(10,2);
    declare costePorPagina decimal(10,3);
    declare coste_total decimal(10,2);

    -- Coste fijo por libro
    set costeFijo = 0.59;

    -- Obtener el número de páginas y si el libro es a color
    select num_paginas, color into numDePaginas , es_color
    from libros
    where idLibro = id_libro;

    -- Determinar el coste por página según si el libro es a color o en blanco y negro
    if es_color then
        set costePorPagina = 0.059;
    else
        set costePorPagina = 0.011;
    end if;

    -- Calcular el coste total de impresión
    set coste_total = costeFijo + (costePorPagina * numDePaginas);

    -- Devolver el resultado
    return coste_total;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcularGastosEnvio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularGastosEnvio`(id_libro INT, cod_postal VARCHAR(10)) RETURNS decimal(10,2)
BEGIN
    DECLARE pesoLibro DECIMAL(10,3);
    DECLARE costeFijo DECIMAL(10,2);
    DECLARE sobrecoste DECIMAL(10,2);
    DECLARE peso_extra DECIMAL(10,3);
    DECLARE gastos_de_envio DECIMAL(10,2);

    -- Obtener el peso del libro utilizando la función calcular_peso_libro
    SET pesoLibro = calcularPesoLibro(id_libro);

    -- Determinar el coste fijo según el código postal
    IF LEFT(cod_postal, 2) = '08' THEN
        SET costeFijo = 1.95;
    ELSE
        SET costeFijo = 3.95;
    END IF;

    -- Calcular el sobrecoste por peso adicional
 
    IF pesoLibro > 0 THEN
        SET sobrecoste = CEIL(pesoLibro  / 0.1) * 0.22;
    ELSE
        SET sobrecoste = 0;
    END IF;

    -- Calcular el total de los gastos de envío
    SET gastos_de_envio = costeFijo + sobrecoste;

    -- Devolver el resultado
    return gastos_de_envio;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcularPesoLibro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularPesoLibro`(id_libro int) RETURNS decimal(10,3)
BEGIN
    DECLARE numPaginas INT;
    DECLARE pesoPortadaContraportada DECIMAL(10,3);
    DECLARE pesoPaginas DECIMAL(10,3);
    DECLARE peso_total DECIMAL(10,3);
    
    -- Obtenemos el número de páginas impresas a doble cara del libro
    SELECT num_paginas  INTO numPaginas 
    FROM libros
    WHERE idLibro = id_libro;
    
    -- Peso de la portada y contraportada (0.25 kg cada una)
    SET pesoPortadaContraportada = 0.25 * 2;
    
    -- Peso de todas las páginas (0.016 kg por página)
    SET pesoPaginas = 0.016 * numPaginas;
    
    -- Peso total del libro
    SET peso_total = pesoPortadaContraportada + pesoPaginas;
    
    RETURN peso_total;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcular_coste_impresion_Pepe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_coste_impresion_Pepe`(id_libro int) RETURNS decimal(5,2)
begin
  declare coste_impresion decimal(5,2);
  select case when color = 1 then 0.059 else 0.011 end * (num_paginas / 2) + 0.59 into coste_impresion
  from libros
  where idlibro = id_libro;
  return coste_impresion;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizarPrecioVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarPrecioVenta`()
begin
    declare done int default 0;
    declare libro_id int;
    declare coste_impresion decimal(10,2);
    declare cur cursor for select idLibro from libros;
    declare continue handler for not found set done = 1;

    open cur;

    read_loop: loop
        fetch cur into libro_id;
        if done then
            leave read_loop;
        end if;

        -- Calcular el coste de impresión usando la función calcularCosteImpresion
        set coste_impresion = calcularCosteImpresion(libro_id);

        -- Actualizar el precio de venta para asegurar que sea al menos 1€ mayor que el coste de impresión
        update libros
        set precioVenta = greatest(precioVenta, coste_impresion + 1)
        where idLibro = libro_id;
    end loop;

    close cur;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePrecioVentaLuis` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePrecioVentaLuis`()
begin 
	declare done int default 0;
	declare vPrecioVenta type of libros.precioVENTA;
	declare vIdLibro type of libros.idLibro;
	declare vBeneficio decimal (10,2);
	declare cursorLibro cursor for 
		select idLibro, precioVENTA from libros;
		
	declare continue handler for not found set done = 1;
	open cursorLibro;
	read_loop: loop
		fetch cursorLibro into vIdLibro, vPrecioVenta;
		if done then
			leave read_loop;
		end if;
		set vBeneficio = vPrecioVenta - calcularCosteImpresion(vIdLibro);
		while vBeneficio < 1 do
		set vPrecioVenta = calcularCosteImpresion(vIdLibro) + 1;
		end while;
		
	end loop;
	close cursorLibro;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `autores_mas_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `autores_mas_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `autores_mas_vendidos` AS select `libros`.`autores` AS `autores`,count(0) AS `libros_vendidos` from (`libros` join `detalle` on(`libros`.`idLibro` = `detalle`.`idLibro`)) group by `libros`.`autores` order by count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `libros_ciencia_ficcion`
--

/*!50001 DROP VIEW IF EXISTS `libros_ciencia_ficcion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `libros_ciencia_ficcion` AS select `libros`.`idLibro` AS `idLibro`,`libros`.`titulo` AS `titulo`,`libros`.`autores` AS `autores`,`libros`.`puntuacion_media` AS `puntuacion_media`,`libros`.`isbn` AS `isbn`,`libros`.`isbn13` AS `isbn13`,`libros`.`idioma` AS `idioma`,`libros`.`num_paginas` AS `num_paginas`,`libros`.`fecha_publicacion` AS `fecha_publicacion`,`libros`.`Editor` AS `Editor`,`libros`.`Color` AS `Color`,`libros`.`precioVENTA` AS `precioVENTA`,`libros`.`idTamanyo` AS `idTamanyo` from `libros` where `libros`.`idioma` = 'inglés' and `libros`.`titulo` like '%ciencia ficción%' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pedidos_totales`
--

/*!50001 DROP VIEW IF EXISTS `pedidos_totales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pedidos_totales` AS select `pedidos`.`idPedido` AS `idPedido`,`pedidos`.`fecha` AS `fecha`,`pedidos`.`idCliente` AS `idCliente`,`pedidos`.`SubTotal` + `pedidos`.`GatosEnvio` AS `total_pedido` from `pedidos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-16  9:10:28
