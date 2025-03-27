-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: twitter
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
-- Table structure for table `likes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `idusuario` int(11) NOT NULL,
  `idtweet` int(11) NOT NULL,
  `fecha_like` date NOT NULL,
  PRIMARY KEY (`idusuario`,`idtweet`),
  KEY `fklikes` (`idtweet`),
  CONSTRAINT `fklikes` FOREIGN KEY (`idtweet`) REFERENCES `tweets` (`id`),
  CONSTRAINT `fkusario` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,'2024-03-12'),(1,2,'2024-06-08'),(2,2,'2024-03-13'),(2,3,'2024-03-12'),(2,4,'2024-01-30'),(4,1,'2024-03-12'),(4,5,'2024-03-12'),(5,1,'2024-03-13'),(8,4,'2024-01-03'),(8,8,'2024-03-12'),(9,5,'2024-03-12'),(11,1,'2024-03-01'),(11,2,'2024-03-12'),(12,3,'2024-03-12'),(13,4,'2024-03-12'),(14,5,'2024-02-28'),(16,2,'2024-03-12'),(17,3,'2024-03-12'),(19,5,'2024-02-01'),(20,1,'2024-03-13'),(21,2,'2024-01-17'),(24,4,'2024-03-13'),(24,5,'2024-03-01');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguidores`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguidores` (
  `idseguidor` int(11) NOT NULL,
  `idseguido` int(11) NOT NULL,
  PRIMARY KEY (`idseguidor`,`idseguido`),
  KEY `fkseguido` (`idseguido`),
  CONSTRAINT `fkseguido` FOREIGN KEY (`idseguido`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fkseguidor` FOREIGN KEY (`idseguidor`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguidores`
--

LOCK TABLES `seguidores` WRITE;
/*!40000 ALTER TABLE `seguidores` DISABLE KEYS */;
INSERT INTO `seguidores` VALUES (5,1),(15,1),(1,2),(6,2),(16,2),(21,2),(1,3),(7,3),(12,3),(17,3),(22,3),(13,4),(18,4),(23,4),(3,5),(4,5),(14,5),(19,5),(24,5),(1,9),(20,11),(25,11),(8,14),(9,15),(10,15),(2,16),(3,16),(3,20),(11,21),(2,23),(2,25);
/*!40000 ALTER TABLE `seguidores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweets` (
  `id` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `texto` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fktweets` (`idusuario`),
  CONSTRAINT `fktweets` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
INSERT INTO `tweets` VALUES (1,1,'2024-03-12 10:00:00','¡Buenos días!'),(2,2,'2024-01-11 11:00:00','¿Qué tal el día?'),(3,3,'2024-02-18 12:00:00','Compartiendo un artículo interesante: [enlace]'),(4,4,'2024-03-12 13:00:00','¿Alguien sabe de un buen restaurante italiano?'),(5,5,'2024-03-12 14:00:00','Estoy buscando un nuevo libro para leer, ¿alguna recomendación?'),(6,2,'2024-01-11 14:05:00','Me gustaría leer algo de ciencia ficción, ¿alguna sugerencia?'),(7,5,'2024-01-30 14:00:00','Estoy buscando un nuevo libro para leer, ¿alguna recomendación?'),(8,4,'2024-03-12 14:15:00','¿Alguien ha leído el último libro de Stephen King?'),(9,1,'2024-02-27 14:20:00','A mí me gustan las biografías de personajes históricos, ¿tienen alguna recomendación?'),(10,5,'2024-02-27 14:25:00','Gracias por las sugerencias, les echaré un vistazo'),(11,20,'2024-04-01 14:30:00','Yo también estoy buscando un nuevo libro, ¿me pueden recomendar algo?'),(12,13,'2024-03-12 14:35:00','Yo estoy leyendo un libro sobre la historia de España, muy interesante'),(13,13,'2024-02-12 14:40:00','¿A alguien le gustan los libros de misterio?'),(14,11,'2024-01-11 14:45:00','A mí me encantan, me mantienen en suspenso hasta el final'),(15,5,'2024-01-08 14:50:00','Yo he leído algunos de Agatha Christie y me parecen geniales'),(16,2,'2024-03-24 14:55:00','¿Alguien ha leído \"El juego de Ender\"?'),(17,8,'2024-03-28 15:00:00','Sí, lo leí hace tiempo y me gustó mucho'),(18,4,'2024-02-02 15:05:00','Yo estoy leyendo \"Cien años de soledad\", ¿qué les parece?'),(19,1,'2024-02-02 15:10:00','Es un clásico, a mí me encantó'),(20,7,'2024-01-01 15:15:00','Lo tengo en mi lista de pendientes, lo leeré pronto'),(21,2,'2024-03-02 15:20:00','¿Qué les parece leer un libro juntos y luego comentarlo?'),(22,7,'2024-03-02 15:25:00','Me parece una buena idea'),(23,4,'2024-03-08 15:30:00','¿Qué libro elegiríamos?'),(24,1,'2024-02-19 15:35:00','Podríamos votar por el que más nos guste'),(25,7,'2024-02-19 15:40:00','¡Me parece perfecto!');
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `nick` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(100) NOT NULL,
  `pais` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Ana García','anagarcia','ana.garcia@email.com','654321098','España','123456'),(2,'Juan López','juanlopez','juan.lopez@email.com','665432109','México','112234'),(3,'María Pérez','mariaperez','maria.perez@email.com','676543210','Argentina','111111'),(4,'Pedro Martínez','pedromartinez','pedro.martinez@email.com','687654321','Colombia','123456'),(5,'Laura González','lauragonzalez','laura.gonzalez@email.com','698765432','Chile','123456'),(6,'David Rodríguez','davidrodriguez','david.rodriguez@email.com','601234567','España','223341'),(7,'Cristina Fernández','cristinafernandez','cristina.fernandez@email.com','612345678','México','098211'),(8,'Miguel Sánchez','miguelsanchez','miguel.sanchez@email.com','623456789','Argentina','123456'),(9,'Ana Martín','anamartin','ana.martin@email.com','634567890','Colombia','334455'),(10,'José García','josegacia','jose.garcia@email.com','645678901','Chile','554422'),(11,'Isabel López','isabellopez','isabel.lopez@email.com','656789012','España','111112'),(12,'Francisco Pérez','franciscoperez','francisco.perez@email.com','667890123','México','333333'),(13,'Victoria Martínez','victoriamartinez','victoria.martinez@email.com','678901234','Argentina','666555'),(14,'Alejandro González','alejandrogonzalez','alejandro.gonzalez@email.com','689012345','Colombia','888999'),(15,'Elena Rodríguez','elenarodriguez','elena.rodriguez@email.com','690123456','Chile','555555'),(16,'Santiago Fernández','santiagofernandez','santiago.fernandez@email.com','701234567','España','777771'),(17,'Paula Sánchez','paulasanchez','paula.sanchez@email.com','712345678','México','432166'),(18,'Andrés Martín','andresmartin','andres.martin@email.com','723456789','Argentina','123456'),(19,'Laura García','lauragarcia','laura.garcia@email.com','734567890','Colombia','234981'),(20,'Carlos López','carloslopez','carlos.lopez@email.com','745678901','Chile','222222'),(21,'Marta Pérez','martaperez','marta.perez@email.com','756789012','España','555555'),(22,'Luis Martínez','luismartinez','luis.martinez@email.com','767890123','México','777777'),(23,'Sara González','saragonzalez','sara.gonzalez@email.com','778901234','Argentina','989898'),(24,'Pablo Rodríguez','pablorodriguez','pablo.rodriguez@email.com','789012345','Colombia','565656'),(25,'Ana Fernández','anafernandez','ana.fernandez@email.com','790123456','Chile','999996');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'twitter'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-24  8:36:42
