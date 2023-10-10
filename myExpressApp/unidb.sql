-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: unidb
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `Building_id` int NOT NULL,
  `Building_name` varchar(255) DEFAULT NULL,
  `Campus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Ingkarni Wardli','University of Adelaide'),(2,'Helen Mayo','University of Adelaide'),(3,'Central Hub','University of Adelaide');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `class_id` int NOT NULL,
  `class_time` varchar(255) DEFAULT NULL,
  `class_number` varchar(20) DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  `Subject_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  KEY `building_id` (`building_id`),
  KEY `Subject_code` (`Subject_code`),
  CONSTRAINT `class_ibfk_2` FOREIGN KEY (`Subject_code`) REFERENCES `subject` (`Subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Thursday 11.00-12.00 AM','329',1,'1002'),(2,'Friday 13.00-14.00 PM','329',1,'1002'),(3,'Tuesday 16.00-17.00 PM','291',1,'3021'),(4,'Monday 11.00-13.00 PM','221',2,'2208'),(5,'Monday 13.00-15.00 PM','221',2,'2208'),(6,'Wednesday 11.00-13.00 PM','101',2,'2208'),(7,'Wednesday 13.00-15.00 PM','101',2,'2208');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `Major_id` int NOT NULL,
  `Major_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (1,'COMP SCI'),(2,'ENGINEERING'),(3,'ENTREP');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `os`
--

DROP TABLE IF EXISTS `os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os` (
  `OS_id` int NOT NULL,
  `OS_name` varchar(255) DEFAULT NULL,
  `Software_id` int DEFAULT NULL,
  PRIMARY KEY (`OS_id`),
  KEY `Software_id` (`Software_id`),
  CONSTRAINT `os_ibfk_1` FOREIGN KEY (`Software_id`) REFERENCES `software` (`software_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os`
--

LOCK TABLES `os` WRITE;
/*!40000 ALTER TABLE `os` DISABLE KEYS */;
INSERT INTO `os` VALUES (1,'linux',1),(2,'Windows',1),(3,'Mac OS',1);
/*!40000 ALTER TABLE `os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Role_id` int NOT NULL,
  `Role` varchar(255) DEFAULT NULL,
  `User_id` int DEFAULT NULL,
  PRIMARY KEY (`Role_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `users` (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'course coordinator',1011243),(2,'course coordinator',10143127),(3,'tutor',10143127),(4,'student',13461697);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_number` int NOT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  PRIMARY KEY (`room_number`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`Building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (16,'computer lab',35,'B',1),(50,'seminar',200,'5',2),(222,'workshop',60,'2',1);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software`
--

DROP TABLE IF EXISTS `software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software` (
  `software_id` int NOT NULL,
  `software_name` varchar(255) DEFAULT NULL,
  `software_supplier` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `subject_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`software_id`),
  KEY `subject_code` (`subject_code`),
  CONSTRAINT `software_ibfk_1` FOREIGN KEY (`subject_code`) REFERENCES `subject` (`Subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software`
--

LOCK TABLES `software` WRITE;
/*!40000 ALTER TABLE `software` DISABLE KEYS */;
INSERT INTO `software` VALUES (1,'Java','Oracle',NULL,'1002'),(2,'Python','Python Software Foundation',NULL,'3021'),(3,'Python','Python Software Foundation',NULL,'2208'),(4,'MySQL','Oracle',NULL,'2208'),(5,'C++',NULL,NULL,'2208'),(6,'Rangeforce Labs','rangeforce',150.00,'2208');
/*!40000 ALTER TABLE `software` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `softwarelicense`
--

DROP TABLE IF EXISTS `softwarelicense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `softwarelicense` (
  `license_id` int NOT NULL,
  `license_owned` int DEFAULT NULL,
  `install_by` varchar(50) DEFAULT NULL,
  `expiry_date` varchar(50) DEFAULT NULL,
  `software_id` int DEFAULT NULL,
  PRIMARY KEY (`license_id`),
  KEY `software_id` (`software_id`),
  CONSTRAINT `softwarelicense_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software` (`software_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `softwarelicense`
--

LOCK TABLES `softwarelicense` WRITE;
/*!40000 ALTER TABLE `softwarelicense` DISABLE KEYS */;
INSERT INTO `softwarelicense` VALUES (1,320,'2023-06-21','2025-06-30',6);
/*!40000 ALTER TABLE `softwarelicense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `softwareversion`
--

DROP TABLE IF EXISTS `softwareversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `softwareversion` (
  `version` varchar(20) NOT NULL,
  `software_id` int DEFAULT NULL,
  PRIMARY KEY (`version`),
  KEY `software_id` (`software_id`),
  CONSTRAINT `softwareversion_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software` (`software_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `softwareversion`
--

LOCK TABLES `softwareversion` WRITE;
/*!40000 ALTER TABLE `softwareversion` DISABLE KEYS */;
INSERT INTO `softwareversion` VALUES ('Java 1.8',1),('python 3.8',2),('python 2.0',3);
/*!40000 ALTER TABLE `softwareversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `Subject_code` varchar(10) NOT NULL,
  `Subject_name` varchar(255) DEFAULT NULL,
  `Major_id` int DEFAULT NULL,
  `coursecoordinator_id` int DEFAULT NULL,
  PRIMARY KEY (`Subject_code`),
  KEY `Major_id` (`Major_id`),
  KEY `coursecoordinator_id` (`coursecoordinator_id`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`Major_id`) REFERENCES `major` (`Major_id`),
  CONSTRAINT `subject_ibfk_2` FOREIGN KEY (`coursecoordinator_id`) REFERENCES `users` (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES ('1002','IT Project',1,1011243),('2208','Database and ethical data',1,1011243),('3021','Industry project',1,10143127);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `User_id` int NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `ContactNumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1011243,'Nick Falkner','nickfalkner@adelaide.edu.au','+614019281620'),(10143127,'Diana Shah','diana.shah@adelaide.edu.au','+614908492420'),(13461697,'James Smith','jamessmith9918@adelaide.edu.au','+614962939172');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-09 22:20:35
