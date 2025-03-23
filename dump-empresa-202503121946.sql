-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: empresa
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
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `cddep` varchar(2) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cddep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES ('D1','Desarrollo de software','Sevilla'),('D2','Marketing','Madrid'),('D3','Ventas','Málaga'),('D4','Marketing','Bilbao'),('D5','I+D','Valencia'),('D6','Calidad','Córdoba');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `cdemp` varchar(3) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `ciudad` varchar(20) NOT NULL,
  `salario` decimal(6,2) NOT NULL,
  `cdjefe` varchar(3) DEFAULT NULL,
  `cddep` varchar(2) NOT NULL,
  PRIMARY KEY (`cdemp`),
  KEY `fk_empleado_jefe` (`cdjefe`),
  KEY `fk_empleado_departamento` (`cddep`),
  CONSTRAINT `fk_empleado_departamento` FOREIGN KEY (`cddep`) REFERENCES `departamento` (`cddep`),
  CONSTRAINT `fk_empleado_jefe` FOREIGN KEY (`cdjefe`) REFERENCES `empleado` (`cdemp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES ('E01','Juan Pérez','2023-01-01','Sevilla',1500.00,NULL,'D1'),('E02','María García','2023-02-01','Madrid',2000.00,'E01','D1'),('E03','Antonio Rodríguez','2023-03-01','Barcelona',1800.00,'E02','D2'),('E04','Luisa López','2023-04-01','Valencia',1200.00,'E01','D1'),('E05','Pedro Sánchez','2023-05-01','Madrid',1500.00,'E02','D2'),('E06','Ana María García','2023-06-01','Sevilla',1700.00,'E03','D3'),('E07','Miguel González','2023-07-01','Barcelona',1900.00,'E02','D2'),('E08','Carmen Rodríguez','2023-08-01','Valencia',2100.00,'E01','D1'),('E09','José Pérez','2023-09-01','Madrid',2300.00,'E02','D5'),('E10','María López','2023-10-01','Sevilla',2500.00,'E03','D2');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `cdpro` varchar(3) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `cddep` varchar(2) NOT NULL,
  PRIMARY KEY (`cdpro`),
  KEY `fk_proyecto_departamento` (`cddep`),
  CONSTRAINT `fk_proyecto_departamento` FOREIGN KEY (`cddep`) REFERENCES `departamento` (`cddep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` VALUES ('P01','Nuevo producto','D1'),('P02','Mejora de rendimiento','D2'),('P03','Mantenimiento','D3'),('P04','Nuevo servicio','D4'),('P05','Actualización de software','D5'),('P06','Mejora de seguridad','D3'),('P07','Expansión de la red','D1'),('P08','Nuevo producto 2','D4'),('P09','Java','D1');
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabaja`
--

DROP TABLE IF EXISTS `trabaja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trabaja` (
  `cdemp` varchar(3) NOT NULL,
  `cdpro` varchar(3) NOT NULL,
  `nhoras` int(11) NOT NULL,
  PRIMARY KEY (`cdemp`,`cdpro`),
  KEY `fk_trabaja_proyecto` (`cdpro`),
  CONSTRAINT `fk_trabaja_empleado` FOREIGN KEY (`cdemp`) REFERENCES `empleado` (`cdemp`),
  CONSTRAINT `fk_trabaja_proyecto` FOREIGN KEY (`cdpro`) REFERENCES `proyecto` (`cdpro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabaja`
--

LOCK TABLES `trabaja` WRITE;
/*!40000 ALTER TABLE `trabaja` DISABLE KEYS */;
INSERT INTO `trabaja` VALUES ('E01','P01',20),('E02','P01',30),('E03','P02',40),('E04','P03',40),('E05','P04',50),('E06','P05',60),('E07','P06',70),('E08','P07',80),('E09','P08',90),('E10','P09',100);
/*!40000 ALTER TABLE `trabaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'empresa'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-12 19:46:20
