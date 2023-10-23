CREATE DATABASE  IF NOT EXISTS `unidb`;
use unidb;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: unidb
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
INSERT INTO `building` VALUES (1,'Ingkarni Wardli','University of Adelaide'),(2,'Helen Mayo','University of Adelaide'),(3,'Central Hub','University of Adelaide'),(4,'Ligertwood','University of Adelaide'),(5,'Nexus','University of Adelaide'),(6,'Schulz','University of Adelaide'),(7,'Hughes','University of Adelaide');
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
  `Subject_code` varchar(10) DEFAULT NULL,
  `room_number` int DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  KEY `Subject_code` (`Subject_code`),
  KEY `fk_class_room` (`room_number`),
  CONSTRAINT `class_ibfk_2` FOREIGN KEY (`Subject_code`) REFERENCES `subject` (`Subject_code`),
  CONSTRAINT `fk_class_room` FOREIGN KEY (`room_number`) REFERENCES `room` (`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'monday 10.00 AM -11.00 AM','450','1001',322),(2,'monday 13.00 PM -15.00 PM','150','1001',16),(3,'tuesday 13.00 PM -15.00 PM','150','1001',16),(4,'wednesday 13.00 PM -15.00 PM','150','1001',16),(5,'thursday 13.00 PM -14.00 PM','200','1001',410),(6,'thursday 14.00 PM -15.00 PM','200','1001',410),(7,'thursday 14.00 PM -15.00 PM','50','1001',441),(8,'Monday 9.00 AM -10.00 AM','350','1002',128),(9,'Tuesday 9.00 AM -10.00 AM','100','1002',102),(10,'Tuesday 9.00 AM -10.00 AM','100','1002',109),(11,'Monday 10.00 AM -11.00 AM','75','1002',102),(12,'Tuesday 10.00 AM -11.00 AM','75','1002',109),(13,'Monday 11.00 AM -12.00 PM','150','1010',16),(14,'Monday 12.00 PM -13.00 PM','150','1010',16),(15,'Thursday 09.00 AM -17.00 PM','300','1020',50),(16,'Thursday 09.00 AM -11.00 AM','500','2000',119),(17,'Wednesday 10.00 AM -11.00 AM','150','2000',16),(18,'Monday 10.00 AM -11.00 AM','150','2000',16),(19,'Thursday 10.00 AM -11.00 AM','200','2000',211),(20,'Friday 10.00 AM -17.00 PM','200','2010',50),(21,'Monday 10.00 AM -12.00 PM','350','2103',119),(22,'Monday 16.00 PM -18.00 PM','100','2103',111),(23,'Monday 16.00 PM -18.00 PM','100','2103',111),(24,'Thursday 16.00 PM -18.00 PM','75','2103',111),(25,'Thursday 16.00 PM -18.00 PM','75','2103',119),(26,'Tuesday 7.00 AM -8.00 AM','150','3021',410),(27,'Friday 6.00 AM -7.00 AM','150','3000',410),(28,'Tuesday 7.00 AM -10.00 AM','720','3004',322);
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
INSERT INTO `major` VALUES (1,'COMP SCI'),(2,'ENGINEERING'),(3,'ENTREP'),(4,'Psychology'),(5,'Arts'),(6,'Biology'),(7,'Mathematics');
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
INSERT INTO `roles` VALUES (1,'course coordinator',1011243),(2,'course coordinator',10143127),(3,'tutor',10143127),(4,'student',13461697),(5,'course coordinator',1928374),(6,'course coordinator',3819292),(7,'course coordinator',5129347),(8,'course coordinator',7812345),(9,'tutor',9438210),(10,'student',1011243),(11,'student',13461697),(12,'student',10143127),(13,'student',10573241);
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
INSERT INTO `room` VALUES (16,'computer lab',150,'B',1),(19,'computer lab',50,'B',1),(50,'seminar',300,'5',2),(102,'workshop',100,'1',5),(109,'workshop',100,'1',5),(111,'workshop',100,'1',5),(119,'seminar',750,'1',6),(128,'seminar',700,'1',6),(188,'compter lab',30,'1',1),(211,'computer lab',200,'2',1),(222,'workshop',200,'2',1),(322,'Seminar',1000,'2',3),(410,'workshop',200,'4',7),(441,'workshop',50,'4',4),(442,'workshop',100,'4',7);
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
INSERT INTO `software` VALUES (1,'Java','Oracle',NULL,'1002'),(2,'Python','Python Software Foundation',NULL,'3021'),(3,'Python','Python Software Foundation',NULL,'2208'),(4,'MySQL','Oracle',NULL,'2208'),(5,'C++',NULL,NULL,'2208'),(6,'Rangeforce Labs','rangeforce',150.00,'2208'),(7,'c++',NULL,NULL,'3004'),(8,'c++',NULL,NULL,'2103'),(9,'Java',NULL,NULL,'2103'),(10,'Matlab',NULL,NULL,'1001');
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
INSERT INTO `softwareversion` VALUES ('Java 1.8',1),('python 3.8',2),('python 2.0',3),('MySQL2',4);
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
  `student_enrol` int DEFAULT NULL,
  `term` int DEFAULT NULL,
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
INSERT INTO `subject` VALUES ('1001','Intro to engineering',2,2345671,450,1),('1002','IT Project',1,1011243,350,1),('1010','Puzzle based learning',1,6347829,300,1),('1020','Design Thinking',3,10573241,300,1),('2000','Computer System',1,8237481,500,1),('2010','Digital Entrepreneur',3,10573241,100,1),('2103','Algorithm and data structures',1,8237481,350,2),('2208','Database and ethical data',1,1011243,400,1),('3000','Innovation and Creativity',3,10573241,150,1),('3004','Operating systems',1,6347829,720,2),('3006','Industry practice',2,1928374,250,1),('3021','Industry project',1,10143127,150,2),('3710','Internship',2,1011243,80,1);
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
INSERT INTO `users` VALUES (1011243,'Nick Falkner','nickfalkner@adelaide.edu.au','+614019281620'),(1928374,'Sarah Johnson','sarah.johnson@gmail.com','+123456789012'),(2345671,'Robert Miller','robert.miller@yahoo.com','+987654321098'),(3819292,'Emily Davis','emily.davis@gmail.com','+111223344555'),(4528193,'Michael Clark','michael.clark@gmail.com','+555444433322'),(5129347,'Olivia Lee','olivia.lee@yahoo.com','+777888999000'),(6347829,'Benjamin White','benjamin.white@gmail.com','+999888777666'),(7812345,'Sophia Brown','sophia.brown@yahoo.com','+111000222333'),(8237481,'Jackson Kim','jackson.kim@gmail.com','+444333222111'),(9438210,'Ava Wilson','ava.wilson@yahoo.com','+666777888999'),(10143127,'Diana Shah','diana.shah@adelaide.edu.au','+614908492420'),(10573241,'Ethan Thomas','ethan.thomas@gmail.com','+000999888777'),(13461697,'James Smith','jamessmith9918@adelaide.edu.au','+614962939172');
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

-- Dump completed on 2023-10-23 21:47:55
