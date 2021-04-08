-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project1
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `courseoffering`
--

DROP TABLE IF EXISTS `courseoffering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courseoffering` (
  `Course_Name` varchar(300) NOT NULL,
  `Course_Number` int NOT NULL,
  `Dept_Code` varchar(10) NOT NULL,
  `Description` text,
  `Notes` text,
  `NumberOfCredits` int DEFAULT NULL,
  `SemesterOffered` text,
  `prereq` varchar(30) DEFAULT NULL,
  `CrossListed` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Course_Number`,`Dept_Code`),
  KEY `Dept_Code` (`Dept_Code`),
  CONSTRAINT `courseoffering_ibfk_1` FOREIGN KEY (`Dept_Code`) REFERENCES `department` (`Dept_Code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseoffering`
--

LOCK TABLES `courseoffering` WRITE;
/*!40000 ALTER TABLE `courseoffering` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseoffering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coursestudent`
--

DROP TABLE IF EXISTS `coursestudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coursestudent` (
  `LetterGrade` char(2) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `semester` varchar(10) DEFAULT NULL,
  `Dept_Code` varchar(10) DEFAULT NULL,
  `Course_Number` int DEFAULT NULL,
  `AUC_ID` int DEFAULT NULL,
  KEY `AUC_ID` (`AUC_ID`),
  KEY `Course_Number` (`Course_Number`,`Dept_Code`),
  CONSTRAINT `coursestudent_ibfk_1` FOREIGN KEY (`AUC_ID`) REFERENCES `student` (`AUC_ID`) ON UPDATE CASCADE,
  CONSTRAINT `coursestudent_ibfk_2` FOREIGN KEY (`Course_Number`, `Dept_Code`) REFERENCES `courseoffering` (`Course_Number`, `Dept_Code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coursestudent`
--

LOCK TABLES `coursestudent` WRITE;
/*!40000 ALTER TABLE `coursestudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `coursestudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `Dept_Code` varchar(10) NOT NULL,
  PRIMARY KEY (`Dept_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmentstudent`
--

DROP TABLE IF EXISTS `departmentstudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departmentstudent` (
  `Dept_Code` varchar(10) DEFAULT NULL,
  `AUC_ID` int DEFAULT NULL,
  KEY `AUC_ID` (`AUC_ID`),
  KEY `Dept_Code` (`Dept_Code`),
  CONSTRAINT `departmentstudent_ibfk_1` FOREIGN KEY (`AUC_ID`) REFERENCES `student` (`AUC_ID`) ON UPDATE CASCADE,
  CONSTRAINT `departmentstudent_ibfk_2` FOREIGN KEY (`Dept_Code`) REFERENCES `department` (`Dept_Code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmentstudent`
--

LOCK TABLES `departmentstudent` WRITE;
/*!40000 ALTER TABLE `departmentstudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `departmentstudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `AUC_ID` int NOT NULL,
  `Grade` varchar(30) DEFAULT NULL,
  `Fname` varchar(30) NOT NULL,
  `Mname` varchar(30) DEFAULT NULL,
  `Lname` varchar(30) NOT NULL,
  PRIMARY KEY (`AUC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentreview`
--

DROP TABLE IF EXISTS `studentreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentreview` (
  `Rating` int DEFAULT NULL,
  `TextReview` text,
  `AUC_ID` int DEFAULT NULL,
  `Course_Number` int DEFAULT NULL,
  `Dept_Code` varchar(10) DEFAULT NULL,
  KEY `AUC_ID` (`AUC_ID`),
  KEY `Course_Number` (`Course_Number`,`Dept_Code`),
  CONSTRAINT `studentreview_ibfk_1` FOREIGN KEY (`AUC_ID`) REFERENCES `student` (`AUC_ID`) ON UPDATE CASCADE,
  CONSTRAINT `studentreview_ibfk_2` FOREIGN KEY (`Course_Number`, `Dept_Code`) REFERENCES `courseoffering` (`Course_Number`, `Dept_Code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentreview`
--

LOCK TABLES `studentreview` WRITE;
/*!40000 ALTER TABLE `studentreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'project1'
--

--
-- Dumping routines for database 'project1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-27 21:02:25
