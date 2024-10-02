-- MySQL dump 10.13  Distrib 9.0.1, for Linux (x86_64)
--
-- Host: localhost    Database: db_keycloak
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Current Database: `db_keycloak`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_keycloak` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_keycloak`;

--
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

DROP TABLE IF EXISTS `ADMIN_EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` text,
  `REPRESENTATION` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ADMIN_EVENT_TIME` (`REALM_ID`,`ADMIN_EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN_EVENT_ENTITY`
--

LOCK TABLES `ADMIN_EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSOCIATED_POLICY`
--

DROP TABLE IF EXISTS `ASSOCIATED_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`),
  CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSOCIATED_POLICY`
--

LOCK TABLES `ASSOCIATED_POLICY` WRITE;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` DISABLE KEYS */;
INSERT INTO `ASSOCIATED_POLICY` VALUES ('4d34da98-a7f0-441c-89f7-8db12340d69b','a88d9095-4c8a-4e96-8161-46543351172a');
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

DROP TABLE IF EXISTS `AUTHENTICATION_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `AUTHENTICATOR_FLOW` tinyint NOT NULL DEFAULT '0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`),
  CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

LOCK TABLES `AUTHENTICATION_EXECUTION` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_EXECUTION` VALUES ('022d5a9e-5209-44d3-a579-89cee1ce4f0e',NULL,'reset-otp','3c25345a-35d9-4d22-8a17-4e83429890aa','fa4facf5-ddf4-45af-99bf-5c424c8797e9',0,20,0,NULL,NULL),('07c9a7cb-29b4-4e5c-b1ec-67bddb6ee34d',NULL,'idp-review-profile','19363c62-1a5c-4117-9fae-ba3b727d853b','73c6e9ca-2864-47b3-8685-67006386d235',0,10,0,NULL,'c3bdcd1f-50a6-425d-92cd-95a2c6c94538'),('084d321b-e85e-4f66-be62-e5ddcaed53c1',NULL,'conditional-user-configured','3c25345a-35d9-4d22-8a17-4e83429890aa','82ab5267-c31c-4ff3-9bbd-998b7219444e',0,10,0,NULL,NULL),('08e853de-1ce3-4a66-9563-3ff673da4953',NULL,'reset-credential-email','3c25345a-35d9-4d22-8a17-4e83429890aa','b2112fa4-e185-414b-bb29-b2bac46acc29',0,20,0,NULL,NULL),('11b96a8c-3913-4481-9132-ee1a8094b9c3',NULL,'idp-username-password-form','19363c62-1a5c-4117-9fae-ba3b727d853b','b35f6ae4-e895-4ffe-be96-269d775b6443',0,10,0,NULL,NULL),('12a63352-cdcd-4ec2-9574-876907df9387',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','73c6e9ca-2864-47b3-8685-67006386d235',0,20,1,'2666b736-290d-44e7-bafe-c19cd602a6d8',NULL),('12b7d2cd-d601-477b-bf79-43229088bac2',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','cd5677c2-5222-4a06-9e8f-90ba568826ff',2,30,1,'bfeb8f32-67bf-4fec-8bde-a956d68d80fa',NULL),('14118294-c0c4-4950-8bc7-4267dceca7ab',NULL,'registration-password-action','3c25345a-35d9-4d22-8a17-4e83429890aa','4b4747ac-b7ad-4457-863c-2d7018015937',0,50,0,NULL,NULL),('15d8b170-0dca-4bd3-8335-239761b76917',NULL,'direct-grant-validate-password','3c25345a-35d9-4d22-8a17-4e83429890aa','cc69b542-1314-46ac-a3bf-88f8c756ed60',0,20,0,NULL,NULL),('18aa477d-5a62-4218-a06f-90d79cdde8cf',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','2666b736-290d-44e7-bafe-c19cd602a6d8',2,20,1,'1599e169-1082-414d-8d2c-b3d76121683c',NULL),('206102e2-2168-4572-9867-c4d2958364ba',NULL,'idp-create-user-if-unique','19363c62-1a5c-4117-9fae-ba3b727d853b','2666b736-290d-44e7-bafe-c19cd602a6d8',2,10,0,NULL,'00d07cfe-c7a4-4701-aef2-9d3f48a5d438'),('21560c63-def3-4abb-aecf-672440ca26d4',NULL,'auth-cookie','3c25345a-35d9-4d22-8a17-4e83429890aa','cd5677c2-5222-4a06-9e8f-90ba568826ff',2,10,0,NULL,NULL),('2180897c-074b-4352-abc8-493eeeaffa99',NULL,'auth-otp-form','19363c62-1a5c-4117-9fae-ba3b727d853b','d56f0c97-976b-4db4-8c0b-4037cf92f9d9',0,20,0,NULL,NULL),('24b86292-22e8-45a5-9436-3e8e4fc40660',NULL,'auth-cookie','19363c62-1a5c-4117-9fae-ba3b727d853b','8d3c24a8-b0b8-442f-a32e-e60482ae70e4',2,10,0,NULL,NULL),('276d081e-bdbf-49c4-8d32-c870c6004f6a',NULL,'identity-provider-redirector','3c25345a-35d9-4d22-8a17-4e83429890aa','cd5677c2-5222-4a06-9e8f-90ba568826ff',2,25,0,NULL,NULL),('28a6702f-37bc-470d-be3f-bd614a938d26',NULL,'reset-password','19363c62-1a5c-4117-9fae-ba3b727d853b','6bf61775-0c3f-4ea4-8f2b-ca41ddaba449',0,30,0,NULL,NULL),('2e7e3ab1-d4f8-4f7c-b88b-e23c61560929',NULL,'client-secret-jwt','19363c62-1a5c-4117-9fae-ba3b727d853b','057c7974-ce7e-41cf-98b2-0e10131c2e7d',2,30,0,NULL,NULL),('32522987-4806-44f6-b730-f1bd38e19645',NULL,'conditional-user-configured','19363c62-1a5c-4117-9fae-ba3b727d853b','d56f0c97-976b-4db4-8c0b-4037cf92f9d9',0,10,0,NULL,NULL),('33b61fc2-c062-41e7-8ea6-4ad9019effe0',NULL,'registration-page-form','19363c62-1a5c-4117-9fae-ba3b727d853b','091b0038-6fdc-45a4-b3a2-e3b76ccf44bf',0,10,1,'916e0a47-ff13-46aa-b71f-72933ce63378',NULL),('34910aa6-8c7e-44f3-ad03-2e75fca95534',NULL,'auth-username-password-form','19363c62-1a5c-4117-9fae-ba3b727d853b','c6a003b1-f422-48a9-93f1-3380cf7db41d',0,10,0,NULL,NULL),('359da1ae-da92-4206-8ce7-5e7c23231838',NULL,'reset-otp','19363c62-1a5c-4117-9fae-ba3b727d853b','706ad454-f1fb-4cfe-9473-dca7a6d324f4',0,20,0,NULL,NULL),('380494e3-d6e9-4905-9352-4b3f92ea5d20',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','b2112fa4-e185-414b-bb29-b2bac46acc29',1,40,1,'fa4facf5-ddf4-45af-99bf-5c424c8797e9',NULL),('3a66956d-fae9-4157-8a0e-06e5bb39dcba',NULL,'conditional-user-configured','19363c62-1a5c-4117-9fae-ba3b727d853b','988a06d9-35b7-4466-81b9-7d1054eb41b6',0,10,0,NULL,NULL),('3ec26130-03a6-465f-a2b7-b4e7c7a1132b',NULL,'direct-grant-validate-otp','19363c62-1a5c-4117-9fae-ba3b727d853b','988a06d9-35b7-4466-81b9-7d1054eb41b6',0,20,0,NULL,NULL),('405edbc1-7817-4e08-b26d-849510767cc9',NULL,'registration-terms-and-conditions','3c25345a-35d9-4d22-8a17-4e83429890aa','4b4747ac-b7ad-4457-863c-2d7018015937',3,70,0,NULL,NULL),('477a826b-18bc-48d7-bef3-2ed1cf192fe2',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','266b9259-85ba-4c99-9f92-bae913011e29',2,20,1,'33325d7e-fe64-40d6-8a19-96b0fae893e5',NULL),('4bdaf6a1-1f28-4913-9b8c-5f7beab376d9',NULL,'client-secret-jwt','3c25345a-35d9-4d22-8a17-4e83429890aa','0b1f63e9-cbd6-4233-9833-4625dd907272',2,30,0,NULL,NULL),('4ca4b56c-f56e-431e-a54c-cf5ea066fc5a',NULL,'reset-credentials-choose-user','3c25345a-35d9-4d22-8a17-4e83429890aa','b2112fa4-e185-414b-bb29-b2bac46acc29',0,10,0,NULL,NULL),('4cbd51ae-416c-4c08-9d53-0c820471e43a',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','1599e169-1082-414d-8d2c-b3d76121683c',0,20,1,'ed402fbc-11c8-4dc0-8a61-34a80b2f5519',NULL),('4ee3143a-d0f2-49df-acb2-531b2af115fa',NULL,'conditional-user-configured','19363c62-1a5c-4117-9fae-ba3b727d853b','ff2f5536-b3de-4b6c-acec-2e27e97a0469',0,10,0,NULL,NULL),('50626799-85fa-46f1-973a-70cc818a26d6',NULL,'registration-page-form','3c25345a-35d9-4d22-8a17-4e83429890aa','a5ba4f80-e2d8-44a3-9633-e18a57b4d419',0,10,1,'4b4747ac-b7ad-4457-863c-2d7018015937',NULL),('5210ac0e-0a03-45bc-bcb8-e375b38fe939',NULL,'client-x509','19363c62-1a5c-4117-9fae-ba3b727d853b','057c7974-ce7e-41cf-98b2-0e10131c2e7d',2,40,0,NULL,NULL),('58872da2-4595-488a-a42c-50ec4601112c',NULL,'registration-terms-and-conditions','19363c62-1a5c-4117-9fae-ba3b727d853b','916e0a47-ff13-46aa-b71f-72933ce63378',3,70,0,NULL,NULL),('590aac30-aecd-4b1a-a4fe-ddfa4831adfa',NULL,'idp-username-password-form','3c25345a-35d9-4d22-8a17-4e83429890aa','3848abf3-b13b-4a05-ae51-ed0aa51a7a2e',0,10,0,NULL,NULL),('62b1d89d-bbfb-49e6-aee4-15b7dff4e4fc',NULL,'auth-spnego','19363c62-1a5c-4117-9fae-ba3b727d853b','8d3c24a8-b0b8-442f-a32e-e60482ae70e4',3,20,0,NULL,NULL),('62e7f8bb-67db-48c9-8d2b-abaac476dfc5',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','ed402fbc-11c8-4dc0-8a61-34a80b2f5519',2,20,1,'b35f6ae4-e895-4ffe-be96-269d775b6443',NULL),('638a29e4-cfee-4d58-be15-5329a5a43425',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','cc69b542-1314-46ac-a3bf-88f8c756ed60',1,30,1,'5f8442d6-8460-45a4-a755-dade84813afc',NULL),('67fe4b9a-5990-4275-a676-c7a5e977ef02',NULL,'http-basic-authenticator','19363c62-1a5c-4117-9fae-ba3b727d853b','c981e235-457d-41e9-9443-268eda52d81f',0,10,0,NULL,NULL),('71cb665e-cf38-42cb-98db-17be842c61c2',NULL,'client-secret','19363c62-1a5c-4117-9fae-ba3b727d853b','057c7974-ce7e-41cf-98b2-0e10131c2e7d',2,10,0,NULL,NULL),('76a97fd8-4d70-47bb-9c26-3078778b6341',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','e1b09e8e-2462-4aa4-8295-46b94d58e285',2,20,1,'3848abf3-b13b-4a05-ae51-ed0aa51a7a2e',NULL),('850bd099-fd50-4fdb-9fca-4dbba78f8396',NULL,'auth-otp-form','3c25345a-35d9-4d22-8a17-4e83429890aa','82ab5267-c31c-4ff3-9bbd-998b7219444e',0,20,0,NULL,NULL),('8abe2a4b-6e02-4ec1-8c05-8beb852c18e7',NULL,'conditional-user-configured','3c25345a-35d9-4d22-8a17-4e83429890aa','fa4facf5-ddf4-45af-99bf-5c424c8797e9',0,10,0,NULL,NULL),('8e3f5e35-c71d-4aec-b069-c3d5f9d8ba81',NULL,'direct-grant-validate-username','3c25345a-35d9-4d22-8a17-4e83429890aa','cc69b542-1314-46ac-a3bf-88f8c756ed60',0,10,0,NULL,NULL),('8f6a399d-762e-4be2-9a54-981fd2761582',NULL,'idp-confirm-link','3c25345a-35d9-4d22-8a17-4e83429890aa','33325d7e-fe64-40d6-8a19-96b0fae893e5',0,10,0,NULL,NULL),('91642f42-00f5-4fe7-9f69-f5546afb06a7',NULL,'client-jwt','3c25345a-35d9-4d22-8a17-4e83429890aa','0b1f63e9-cbd6-4233-9833-4625dd907272',2,20,0,NULL,NULL),('94df9101-af68-4332-888f-9c4872dfdf66',NULL,'conditional-user-configured','19363c62-1a5c-4117-9fae-ba3b727d853b','706ad454-f1fb-4cfe-9473-dca7a6d324f4',0,10,0,NULL,NULL),('981eeff5-b9f3-4173-a7a2-71c4bbf1eb9a',NULL,'docker-http-basic-authenticator','3c25345a-35d9-4d22-8a17-4e83429890aa','34438d87-7229-4555-a1ad-27b9ac46285d',0,10,0,NULL,NULL),('9be04f58-9cf4-45ec-9c9f-39ae463bcb6b',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','c0395c4b-8f02-4b58-b005-814346d92f82',1,30,1,'988a06d9-35b7-4466-81b9-7d1054eb41b6',NULL),('9da51f20-de88-48cd-b17e-de25d9c322bc',NULL,'idp-email-verification','19363c62-1a5c-4117-9fae-ba3b727d853b','ed402fbc-11c8-4dc0-8a61-34a80b2f5519',2,10,0,NULL,NULL),('9f8c77d5-3760-4e8d-bb0d-cd04384320c2',NULL,'idp-confirm-link','19363c62-1a5c-4117-9fae-ba3b727d853b','1599e169-1082-414d-8d2c-b3d76121683c',0,10,0,NULL,NULL),('a3601ac1-2915-4d8d-a29b-a891f0d3b624',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','b35f6ae4-e895-4ffe-be96-269d775b6443',1,20,1,'d56f0c97-976b-4db4-8c0b-4037cf92f9d9',NULL),('a4036d33-179e-4881-9710-1fcc1bc87554',NULL,'docker-http-basic-authenticator','19363c62-1a5c-4117-9fae-ba3b727d853b','fd7c142d-e3f5-4b4a-a34e-08ff7a7eef87',0,10,0,NULL,NULL),('a40baca8-69b6-4559-8861-d0cfbfe262a2',NULL,'auth-otp-form','19363c62-1a5c-4117-9fae-ba3b727d853b','ff2f5536-b3de-4b6c-acec-2e27e97a0469',0,20,0,NULL,NULL),('a459b4bc-8bd3-4f3b-9183-ab38196b57d4',NULL,'registration-password-action','19363c62-1a5c-4117-9fae-ba3b727d853b','916e0a47-ff13-46aa-b71f-72933ce63378',0,50,0,NULL,NULL),('a53243a0-8268-45ed-bef7-7f597219e840',NULL,'reset-password','3c25345a-35d9-4d22-8a17-4e83429890aa','b2112fa4-e185-414b-bb29-b2bac46acc29',0,30,0,NULL,NULL),('a8466b57-0e28-44f1-8c3a-bc7a1354f5a1',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','3848abf3-b13b-4a05-ae51-ed0aa51a7a2e',1,20,1,'a96b434c-45c0-4a1a-bfd1-70be4290762f',NULL),('ab87ae67-d0a6-4e60-a102-3e8f464df99f',NULL,'idp-create-user-if-unique','3c25345a-35d9-4d22-8a17-4e83429890aa','266b9259-85ba-4c99-9f92-bae913011e29',2,10,0,NULL,'956582c3-2e4d-4918-9d13-896ea33037d8'),('ab87fa56-5e1a-48a8-acff-3a7a38bcaf9e',NULL,'direct-grant-validate-password','19363c62-1a5c-4117-9fae-ba3b727d853b','c0395c4b-8f02-4b58-b005-814346d92f82',0,20,0,NULL,NULL),('afbca731-0d98-4d31-8cb6-5fc832b96b6a',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','c6a003b1-f422-48a9-93f1-3380cf7db41d',1,20,1,'ff2f5536-b3de-4b6c-acec-2e27e97a0469',NULL),('b132f001-4906-40f7-8fee-af12b65cbdf5',NULL,'auth-spnego','3c25345a-35d9-4d22-8a17-4e83429890aa','cd5677c2-5222-4a06-9e8f-90ba568826ff',3,20,0,NULL,NULL),('b3cc810f-7c70-4ed5-bb68-b240bd71e9db',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','bfeb8f32-67bf-4fec-8bde-a956d68d80fa',1,20,1,'82ab5267-c31c-4ff3-9bbd-998b7219444e',NULL),('b7e0ac61-8254-4b20-861a-63a49e564c93',NULL,'direct-grant-validate-otp','3c25345a-35d9-4d22-8a17-4e83429890aa','5f8442d6-8460-45a4-a755-dade84813afc',0,20,0,NULL,NULL),('b807d48d-f2e0-44c3-8478-9a39f3a596c6',NULL,'reset-credential-email','19363c62-1a5c-4117-9fae-ba3b727d853b','6bf61775-0c3f-4ea4-8f2b-ca41ddaba449',0,20,0,NULL,NULL),('b9140ac6-d91a-4abb-a75d-656c9f36742f',NULL,'registration-recaptcha-action','19363c62-1a5c-4117-9fae-ba3b727d853b','916e0a47-ff13-46aa-b71f-72933ce63378',3,60,0,NULL,NULL),('bb66ca1a-0bf6-48c1-a008-0d931133f75a',NULL,'client-secret','3c25345a-35d9-4d22-8a17-4e83429890aa','0b1f63e9-cbd6-4233-9833-4625dd907272',2,10,0,NULL,NULL),('beff11fc-755b-4f6b-9bf5-262a1660a9d1',NULL,'idp-email-verification','3c25345a-35d9-4d22-8a17-4e83429890aa','e1b09e8e-2462-4aa4-8295-46b94d58e285',2,10,0,NULL,NULL),('bfa1190e-44b1-4086-9bd0-303fe016d58c',NULL,'conditional-user-configured','3c25345a-35d9-4d22-8a17-4e83429890aa','a96b434c-45c0-4a1a-bfd1-70be4290762f',0,10,0,NULL,NULL),('c4d7266f-7bbf-4e30-9cab-c0e597defdbb',NULL,'registration-recaptcha-action','3c25345a-35d9-4d22-8a17-4e83429890aa','4b4747ac-b7ad-4457-863c-2d7018015937',3,60,0,NULL,NULL),('cc4fc9e0-320a-4edb-bfa7-264791f617fc',NULL,'conditional-user-configured','3c25345a-35d9-4d22-8a17-4e83429890aa','5f8442d6-8460-45a4-a755-dade84813afc',0,10,0,NULL,NULL),('d0295d2a-8784-4ff0-9fa7-545802507a59',NULL,'client-jwt','19363c62-1a5c-4117-9fae-ba3b727d853b','057c7974-ce7e-41cf-98b2-0e10131c2e7d',2,20,0,NULL,NULL),('d7d366d1-9e9e-4d91-95c0-4b8ca29d3ebd',NULL,'registration-user-creation','3c25345a-35d9-4d22-8a17-4e83429890aa','4b4747ac-b7ad-4457-863c-2d7018015937',0,20,0,NULL,NULL),('d8804edd-ba97-4397-b6fb-c9f67d0a7db9',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','4c4e14b5-79c9-4b8c-9cea-93f89c7e8a95',0,20,1,'266b9259-85ba-4c99-9f92-bae913011e29',NULL),('db70fe5f-a4bf-4492-a129-873dddfdc2fb',NULL,'idp-review-profile','3c25345a-35d9-4d22-8a17-4e83429890aa','4c4e14b5-79c9-4b8c-9cea-93f89c7e8a95',0,10,0,NULL,'08c60671-8297-4016-9ef4-34e13b88dde7'),('deb1054b-ea0a-4406-a019-55d4bc8a8264',NULL,'auth-username-password-form','3c25345a-35d9-4d22-8a17-4e83429890aa','bfeb8f32-67bf-4fec-8bde-a956d68d80fa',0,10,0,NULL,NULL),('dfabded4-29eb-4d75-a933-526bd5386186',NULL,'reset-credentials-choose-user','19363c62-1a5c-4117-9fae-ba3b727d853b','6bf61775-0c3f-4ea4-8f2b-ca41ddaba449',0,10,0,NULL,NULL),('e332a0b1-d2d6-451d-bbaa-fdbac52d364c',NULL,'direct-grant-validate-username','19363c62-1a5c-4117-9fae-ba3b727d853b','c0395c4b-8f02-4b58-b005-814346d92f82',0,10,0,NULL,NULL),('e35ff7ec-60a6-4b97-b661-481357231966',NULL,'identity-provider-redirector','19363c62-1a5c-4117-9fae-ba3b727d853b','8d3c24a8-b0b8-442f-a32e-e60482ae70e4',2,25,0,NULL,NULL),('e599042d-e3a5-4c72-b454-1943c7c4c59f',NULL,'registration-user-creation','19363c62-1a5c-4117-9fae-ba3b727d853b','916e0a47-ff13-46aa-b71f-72933ce63378',0,20,0,NULL,NULL),('ea214376-5676-4de6-b321-644820e6f7a0',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','6bf61775-0c3f-4ea4-8f2b-ca41ddaba449',1,40,1,'706ad454-f1fb-4cfe-9473-dca7a6d324f4',NULL),('eeb8905e-de83-4aa1-a11b-1e5fa61f00dd',NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','33325d7e-fe64-40d6-8a19-96b0fae893e5',0,20,1,'e1b09e8e-2462-4aa4-8295-46b94d58e285',NULL),('f8038641-8852-49bc-bfa6-2a9fe6ef7407',NULL,'http-basic-authenticator','3c25345a-35d9-4d22-8a17-4e83429890aa','cc22f1e9-7392-40c4-bf83-af162aca0f7b',0,10,0,NULL,NULL),('fbb748d4-64cd-4a7c-b5b4-326c939152e3',NULL,'auth-otp-form','3c25345a-35d9-4d22-8a17-4e83429890aa','a96b434c-45c0-4a1a-bfd1-70be4290762f',0,20,0,NULL,NULL),('fc4adaa4-178c-4e13-bb5a-4706d7ac7ddd',NULL,NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','8d3c24a8-b0b8-442f-a32e-e60482ae70e4',2,30,1,'c6a003b1-f422-48a9-93f1-3380cf7db41d',NULL),('ff011835-dc31-47ee-9b7c-1b40ba584d9d',NULL,'client-x509','3c25345a-35d9-4d22-8a17-4e83429890aa','0b1f63e9-cbd6-4233-9833-4625dd907272',2,40,0,NULL,NULL);
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

DROP TABLE IF EXISTS `AUTHENTICATION_FLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` tinyint NOT NULL DEFAULT '0',
  `BUILT_IN` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

LOCK TABLES `AUTHENTICATION_FLOW` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_FLOW` VALUES ('057c7974-ce7e-41cf-98b2-0e10131c2e7d','clients','Base authentication for clients','19363c62-1a5c-4117-9fae-ba3b727d853b','client-flow',1,1),('091b0038-6fdc-45a4-b3a2-e3b76ccf44bf','registration','registration flow','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('0b1f63e9-cbd6-4233-9833-4625dd907272','clients','Base authentication for clients','3c25345a-35d9-4d22-8a17-4e83429890aa','client-flow',1,1),('1599e169-1082-414d-8d2c-b3d76121683c','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('2666b736-290d-44e7-bafe-c19cd602a6d8','User creation or linking','Flow for the existing/non-existing user alternatives','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('266b9259-85ba-4c99-9f92-bae913011e29','User creation or linking','Flow for the existing/non-existing user alternatives','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('33325d7e-fe64-40d6-8a19-96b0fae893e5','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('34438d87-7229-4555-a1ad-27b9ac46285d','docker auth','Used by Docker clients to authenticate against the IDP','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('3848abf3-b13b-4a05-ae51-ed0aa51a7a2e','Verify Existing Account by Re-authentication','Reauthentication of existing account','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('4b4747ac-b7ad-4457-863c-2d7018015937','registration form','registration form','3c25345a-35d9-4d22-8a17-4e83429890aa','form-flow',0,1),('4c4e14b5-79c9-4b8c-9cea-93f89c7e8a95','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('5f8442d6-8460-45a4-a755-dade84813afc','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('6bf61775-0c3f-4ea4-8f2b-ca41ddaba449','reset credentials','Reset credentials for a user if they forgot their password or something','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('706ad454-f1fb-4cfe-9473-dca7a6d324f4','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('73c6e9ca-2864-47b3-8685-67006386d235','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('82ab5267-c31c-4ff3-9bbd-998b7219444e','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('8d3c24a8-b0b8-442f-a32e-e60482ae70e4','browser','browser based authentication','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('916e0a47-ff13-46aa-b71f-72933ce63378','registration form','registration form','19363c62-1a5c-4117-9fae-ba3b727d853b','form-flow',0,1),('988a06d9-35b7-4466-81b9-7d1054eb41b6','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('a5ba4f80-e2d8-44a3-9633-e18a57b4d419','registration','registration flow','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('a96b434c-45c0-4a1a-bfd1-70be4290762f','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('b2112fa4-e185-414b-bb29-b2bac46acc29','reset credentials','Reset credentials for a user if they forgot their password or something','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('b35f6ae4-e895-4ffe-be96-269d775b6443','Verify Existing Account by Re-authentication','Reauthentication of existing account','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('bfeb8f32-67bf-4fec-8bde-a956d68d80fa','forms','Username, password, otp and other auth forms.','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('c0395c4b-8f02-4b58-b005-814346d92f82','direct grant','OpenID Connect Resource Owner Grant','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('c6a003b1-f422-48a9-93f1-3380cf7db41d','forms','Username, password, otp and other auth forms.','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('c981e235-457d-41e9-9443-268eda52d81f','saml ecp','SAML ECP Profile Authentication Flow','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('cc22f1e9-7392-40c4-bf83-af162aca0f7b','saml ecp','SAML ECP Profile Authentication Flow','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('cc69b542-1314-46ac-a3bf-88f8c756ed60','direct grant','OpenID Connect Resource Owner Grant','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('cd5677c2-5222-4a06-9e8f-90ba568826ff','browser','browser based authentication','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',1,1),('d56f0c97-976b-4db4-8c0b-4037cf92f9d9','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('e1b09e8e-2462-4aa4-8295-46b94d58e285','Account verification options','Method with which to verity the existing account','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('ed402fbc-11c8-4dc0-8a61-34a80b2f5519','Account verification options','Method with which to verity the existing account','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1),('fa4facf5-ddf4-45af-99bf-5c424c8797e9','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','3c25345a-35d9-4d22-8a17-4e83429890aa','basic-flow',0,1),('fd7c142d-e3f5-4b4a-a34e-08ff7a7eef87','docker auth','Used by Docker clients to authenticate against the IDP','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',1,1),('ff2f5536-b3de-4b6c-acec-2e27e97a0469','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','19363c62-1a5c-4117-9fae-ba3b727d853b','basic-flow',0,1);
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

LOCK TABLES `AUTHENTICATOR_CONFIG` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG` VALUES ('00d07cfe-c7a4-4701-aef2-9d3f48a5d438','create unique user config','19363c62-1a5c-4117-9fae-ba3b727d853b'),('08c60671-8297-4016-9ef4-34e13b88dde7','review profile config','3c25345a-35d9-4d22-8a17-4e83429890aa'),('956582c3-2e4d-4918-9d13-896ea33037d8','create unique user config','3c25345a-35d9-4d22-8a17-4e83429890aa'),('c3bdcd1f-50a6-425d-92cd-95a2c6c94538','review profile config','19363c62-1a5c-4117-9fae-ba3b727d853b');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

LOCK TABLES `AUTHENTICATOR_CONFIG_ENTRY` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` VALUES ('00d07cfe-c7a4-4701-aef2-9d3f48a5d438','false','require.password.update.after.registration'),('08c60671-8297-4016-9ef4-34e13b88dde7','missing','update.profile.on.first.login'),('956582c3-2e4d-4918-9d13-896ea33037d8','false','require.password.update.after.registration'),('c3bdcd1f-50a6-425d-92cd-95a2c6c94538','missing','update.profile.on.first.login');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BROKER_LINK`
--

DROP TABLE IF EXISTS `BROKER_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROKER_LINK`
--

LOCK TABLES `BROKER_LINK` WRITE;
/*!40000 ALTER TABLE `BROKER_LINK` DISABLE KEYS */;
/*!40000 ALTER TABLE `BROKER_LINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `FULL_SCOPE_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PUBLIC_CLIENT` tinyint NOT NULL DEFAULT '0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` tinyint NOT NULL DEFAULT '0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int DEFAULT '0',
  `FRONTCHANNEL_LOGOUT` tinyint NOT NULL DEFAULT '0',
  `CONSENT_REQUIRED` tinyint NOT NULL DEFAULT '0',
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` tinyint NOT NULL DEFAULT '1',
  `IMPLICIT_FLOW_ENABLED` tinyint NOT NULL DEFAULT '0',
  `DIRECT_ACCESS_GRANTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `ALWAYS_DISPLAY_IN_CONSOLE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  KEY `IDX_CLIENT_ID` (`CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES ('5267d120-9a8a-41a3-9ca4-a06cad22f8cf',1,0,'security-admin-console',0,1,NULL,'/admin/microservices-motorsport-predictor-realm/console/',0,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_security-admin-console}',0,'client-secret','${authAdminUrl}',NULL,NULL,1,0,0,0),('5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,0,'realm-management',0,0,NULL,NULL,1,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_realm-management}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('58f0a2c6-bc80-4405-814a-e273716d5334',1,0,'account',0,1,NULL,'/realms/microservices-motorsport-predictor-realm/account/',0,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_account}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('63c8239e-920a-4bb8-a9d6-27f33e3afade',1,0,'admin-cli',0,1,NULL,NULL,0,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b','openid-connect',0,0,0,'${client_admin-cli}',0,'client-secret',NULL,NULL,NULL,0,0,1,0),('65b238e3-9746-4498-bced-01961287cd82',1,0,'security-admin-console',0,1,NULL,'/admin/master/console/',0,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b','openid-connect',0,0,0,'${client_security-admin-console}',0,'client-secret','${authAdminUrl}',NULL,NULL,1,0,0,0),('67541cb5-6a82-4ee3-9bea-83351b68ba07',1,0,'account-console',0,1,NULL,'/realms/microservices-motorsport-predictor-realm/account/',0,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_account-console}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('8af70cb8-c413-45df-ad9e-f245b5138256',1,0,'broker',0,0,NULL,NULL,1,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b','openid-connect',0,0,0,'${client_broker}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3',1,1,'microservices-motorsport-client',0,0,'**********','',0,'',0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',-1,1,0,'microservices-motorsport-client',1,'client-secret','http://localhost:9090/','',NULL,1,0,1,0),('a510f613-6c4d-424e-b7dc-1f101e1834c8',1,0,'account-console',0,1,NULL,'/realms/master/account/',0,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b','openid-connect',0,0,0,'${client_account-console}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,0,'account',0,1,NULL,'/realms/master/account/',0,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b','openid-connect',0,0,0,'${client_account}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('a828b895-022f-4654-91d4-aa5301e19e5c',1,0,'broker',0,0,NULL,NULL,1,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_broker}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('bd062e34-a45a-4a44-82d5-0558aec87a90',1,0,'admin-cli',0,1,NULL,NULL,0,NULL,0,'3c25345a-35d9-4d22-8a17-4e83429890aa','openid-connect',0,0,0,'${client_admin-cli}',0,'client-secret',NULL,NULL,NULL,0,0,1,0),('c327f9c6-48eb-4f34-88cc-937e511bee44',1,0,'microservices-motorsport-predictor-realm-realm',0,0,NULL,NULL,1,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,0,0,0,'microservices-motorsport-predictor-realm Realm',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,0,'master-realm',0,0,NULL,NULL,1,NULL,0,'19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,0,0,0,'master Realm',0,'client-secret',NULL,NULL,NULL,1,0,0,0);
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  KEY `IDX_CLIENT_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`(255)),
  CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

LOCK TABLES `CLIENT_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_ATTRIBUTES` VALUES ('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','pkce.code.challenge.method','S256'),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','post.logout.redirect.uris','+'),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','post.logout.redirect.uris','+'),('58f0a2c6-bc80-4405-814a-e273716d5334','post.logout.redirect.uris','+'),('65b238e3-9746-4498-bced-01961287cd82','pkce.code.challenge.method','S256'),('65b238e3-9746-4498-bced-01961287cd82','post.logout.redirect.uris','+'),('67541cb5-6a82-4ee3-9bea-83351b68ba07','pkce.code.challenge.method','S256'),('67541cb5-6a82-4ee3-9bea-83351b68ba07','post.logout.redirect.uris','+'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','backchannel.logout.revoke.offline.tokens','false'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','backchannel.logout.session.required','true'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','client.secret.creation.time','1722863366'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','display.on.consent.screen','false'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','login_theme','keycloak'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','oauth2.device.authorization.grant.enabled','true'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','oidc.ciba.grant.enabled','true'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','post.logout.redirect.uris','+'),('a510f613-6c4d-424e-b7dc-1f101e1834c8','pkce.code.challenge.method','S256'),('a510f613-6c4d-424e-b7dc-1f101e1834c8','post.logout.redirect.uris','+'),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','post.logout.redirect.uris','+'),('a828b895-022f-4654-91d4-aa5301e19e5c','post.logout.redirect.uris','+'),('bd062e34-a45a-4a44-82d5-0558aec87a90','post.logout.redirect.uris','+');
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

DROP TABLE IF EXISTS `CLIENT_AUTH_FLOW_BINDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_AUTH_FLOW_BINDINGS`
--

LOCK TABLES `CLIENT_AUTH_FLOW_BINDINGS` WRITE;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

DROP TABLE IF EXISTS `CLIENT_INITIAL_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `EXPIRATION` int DEFAULT NULL,
  `COUNT` int DEFAULT NULL,
  `REMAINING_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`),
  CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_INITIAL_ACCESS`
--

LOCK TABLES `CLIENT_INITIAL_ACCESS` WRITE;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

DROP TABLE IF EXISTS `CLIENT_NODE_REGISTRATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_NODE_REGISTRATIONS`
--

LOCK TABLES `CLIENT_NODE_REGISTRATIONS` WRITE;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  KEY `IDX_REALM_CLSCOPE` (`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE`
--

LOCK TABLES `CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE` VALUES ('06a134bd-f48c-4f12-9862-a373ffc01b8d','phone','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect built-in scope: phone','openid-connect'),('0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af','profile','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect built-in scope: profile','openid-connect'),('0f3e68d6-1283-4372-b94d-b298d57a9d71','roles','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect scope for add user roles to the access token','openid-connect'),('1bc6cbd0-b494-427c-829f-3f3453414fc1','address','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect built-in scope: address','openid-connect'),('1e6d9026-f424-498e-8cfa-ebffd7bfe8cd','acr','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('2f8ecb94-51cc-4aba-a499-9980e36a0eee','roles','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect scope for add user roles to the access token','openid-connect'),('33221937-d60d-4dbf-8e8e-24ee511d1cf5','role_list','19363c62-1a5c-4117-9fae-ba3b727d853b','SAML role list','saml'),('3ab6aa0f-a306-43a5-b851-73dcc6f32d19','web-origins','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('3f8487a3-18f6-4083-b97c-6ba4bdfb733e','web-origins','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc','profile','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect built-in scope: profile','openid-connect'),('568ce12a-5da9-4133-a449-5739b248f2c3','microprofile-jwt','19363c62-1a5c-4117-9fae-ba3b727d853b','Microprofile - JWT built-in scope','openid-connect'),('581b235a-1436-42f6-859c-1c46a4d9d0e5','acr','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('61899695-a74e-4fed-8f55-3eebe172ccae','email','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect built-in scope: email','openid-connect'),('77f6aab1-618b-4d04-b313-72589b56f29a','phone','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect built-in scope: phone','openid-connect'),('7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60','address','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect built-in scope: address','openid-connect'),('9a96049d-d83d-4869-bcd4-a151f65fc834','offline_access','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect built-in scope: offline_access','openid-connect'),('a6e6271f-06dc-4139-abab-47aafdfb1b62','role_list','3c25345a-35d9-4d22-8a17-4e83429890aa','SAML role list','saml'),('a9189396-32e8-4d5d-8a71-ada6b0d50b6d','microprofile-jwt','3c25345a-35d9-4d22-8a17-4e83429890aa','Microprofile - JWT built-in scope','openid-connect'),('b140af73-cb59-4d5a-91f9-c636860fa833','email','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect built-in scope: email','openid-connect'),('d2574f87-b99e-4063-9e4e-61dc402d29bd','basic','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect scope for add all basic claims to the token','openid-connect'),('def7cea9-d336-4ab9-a072-627894ded673','basic','3c25345a-35d9-4d22-8a17-4e83429890aa','OpenID Connect scope for add all basic claims to the token','openid-connect'),('fde87468-6b6a-44bf-8bfe-a50307d48503','offline_access','19363c62-1a5c-4117-9fae-ba3b727d853b','OpenID Connect built-in scope: offline_access','openid-connect');
/*!40000 ALTER TABLE `CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` text,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`NAME`),
  KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`),
  CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

LOCK TABLES `CLIENT_SCOPE_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` VALUES ('06a134bd-f48c-4f12-9862-a373ffc01b8d','${phoneScopeConsentText}','consent.screen.text'),('06a134bd-f48c-4f12-9862-a373ffc01b8d','true','display.on.consent.screen'),('06a134bd-f48c-4f12-9862-a373ffc01b8d','true','include.in.token.scope'),('0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af','${profileScopeConsentText}','consent.screen.text'),('0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af','true','display.on.consent.screen'),('0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af','true','include.in.token.scope'),('0f3e68d6-1283-4372-b94d-b298d57a9d71','${rolesScopeConsentText}','consent.screen.text'),('0f3e68d6-1283-4372-b94d-b298d57a9d71','true','display.on.consent.screen'),('0f3e68d6-1283-4372-b94d-b298d57a9d71','false','include.in.token.scope'),('1bc6cbd0-b494-427c-829f-3f3453414fc1','${addressScopeConsentText}','consent.screen.text'),('1bc6cbd0-b494-427c-829f-3f3453414fc1','true','display.on.consent.screen'),('1bc6cbd0-b494-427c-829f-3f3453414fc1','true','include.in.token.scope'),('1e6d9026-f424-498e-8cfa-ebffd7bfe8cd','false','display.on.consent.screen'),('1e6d9026-f424-498e-8cfa-ebffd7bfe8cd','false','include.in.token.scope'),('2f8ecb94-51cc-4aba-a499-9980e36a0eee','${rolesScopeConsentText}','consent.screen.text'),('2f8ecb94-51cc-4aba-a499-9980e36a0eee','true','display.on.consent.screen'),('2f8ecb94-51cc-4aba-a499-9980e36a0eee','false','include.in.token.scope'),('33221937-d60d-4dbf-8e8e-24ee511d1cf5','${samlRoleListScopeConsentText}','consent.screen.text'),('33221937-d60d-4dbf-8e8e-24ee511d1cf5','true','display.on.consent.screen'),('3ab6aa0f-a306-43a5-b851-73dcc6f32d19','','consent.screen.text'),('3ab6aa0f-a306-43a5-b851-73dcc6f32d19','false','display.on.consent.screen'),('3ab6aa0f-a306-43a5-b851-73dcc6f32d19','false','include.in.token.scope'),('3f8487a3-18f6-4083-b97c-6ba4bdfb733e','','consent.screen.text'),('3f8487a3-18f6-4083-b97c-6ba4bdfb733e','false','display.on.consent.screen'),('3f8487a3-18f6-4083-b97c-6ba4bdfb733e','false','include.in.token.scope'),('4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc','${profileScopeConsentText}','consent.screen.text'),('4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc','true','display.on.consent.screen'),('4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc','true','include.in.token.scope'),('568ce12a-5da9-4133-a449-5739b248f2c3','false','display.on.consent.screen'),('568ce12a-5da9-4133-a449-5739b248f2c3','true','include.in.token.scope'),('581b235a-1436-42f6-859c-1c46a4d9d0e5','false','display.on.consent.screen'),('581b235a-1436-42f6-859c-1c46a4d9d0e5','false','include.in.token.scope'),('61899695-a74e-4fed-8f55-3eebe172ccae','${emailScopeConsentText}','consent.screen.text'),('61899695-a74e-4fed-8f55-3eebe172ccae','true','display.on.consent.screen'),('61899695-a74e-4fed-8f55-3eebe172ccae','true','include.in.token.scope'),('77f6aab1-618b-4d04-b313-72589b56f29a','${phoneScopeConsentText}','consent.screen.text'),('77f6aab1-618b-4d04-b313-72589b56f29a','true','display.on.consent.screen'),('77f6aab1-618b-4d04-b313-72589b56f29a','true','include.in.token.scope'),('7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60','${addressScopeConsentText}','consent.screen.text'),('7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60','true','display.on.consent.screen'),('7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60','true','include.in.token.scope'),('9a96049d-d83d-4869-bcd4-a151f65fc834','${offlineAccessScopeConsentText}','consent.screen.text'),('9a96049d-d83d-4869-bcd4-a151f65fc834','true','display.on.consent.screen'),('a6e6271f-06dc-4139-abab-47aafdfb1b62','${samlRoleListScopeConsentText}','consent.screen.text'),('a6e6271f-06dc-4139-abab-47aafdfb1b62','true','display.on.consent.screen'),('a9189396-32e8-4d5d-8a71-ada6b0d50b6d','false','display.on.consent.screen'),('a9189396-32e8-4d5d-8a71-ada6b0d50b6d','true','include.in.token.scope'),('b140af73-cb59-4d5a-91f9-c636860fa833','${emailScopeConsentText}','consent.screen.text'),('b140af73-cb59-4d5a-91f9-c636860fa833','true','display.on.consent.screen'),('b140af73-cb59-4d5a-91f9-c636860fa833','true','include.in.token.scope'),('d2574f87-b99e-4063-9e4e-61dc402d29bd','false','display.on.consent.screen'),('d2574f87-b99e-4063-9e4e-61dc402d29bd','false','include.in.token.scope'),('def7cea9-d336-4ab9-a072-627894ded673','false','display.on.consent.screen'),('def7cea9-d336-4ab9-a072-627894ded673','false','include.in.token.scope'),('fde87468-6b6a-44bf-8bfe-a50307d48503','${offlineAccessScopeConsentText}','consent.screen.text'),('fde87468-6b6a-44bf-8bfe-a50307d48503','true','display.on.consent.screen');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `SCOPE_ID` varchar(255) NOT NULL,
  `DEFAULT_SCOPE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

LOCK TABLES `CLIENT_SCOPE_CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_CLIENT` VALUES ('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','77f6aab1-618b-4d04-b313-72589b56f29a',0),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','b140af73-cb59-4d5a-91f9-c636860fa833',1),('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','def7cea9-d336-4ab9-a072-627894ded673',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','77f6aab1-618b-4d04-b313-72589b56f29a',0),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','b140af73-cb59-4d5a-91f9-c636860fa833',1),('5552bdfa-1799-4e2b-84d7-98d39e4d2681','def7cea9-d336-4ab9-a072-627894ded673',1),('58f0a2c6-bc80-4405-814a-e273716d5334','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('58f0a2c6-bc80-4405-814a-e273716d5334','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('58f0a2c6-bc80-4405-814a-e273716d5334','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('58f0a2c6-bc80-4405-814a-e273716d5334','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('58f0a2c6-bc80-4405-814a-e273716d5334','77f6aab1-618b-4d04-b313-72589b56f29a',0),('58f0a2c6-bc80-4405-814a-e273716d5334','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('58f0a2c6-bc80-4405-814a-e273716d5334','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('58f0a2c6-bc80-4405-814a-e273716d5334','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('58f0a2c6-bc80-4405-814a-e273716d5334','b140af73-cb59-4d5a-91f9-c636860fa833',1),('58f0a2c6-bc80-4405-814a-e273716d5334','def7cea9-d336-4ab9-a072-627894ded673',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('63c8239e-920a-4bb8-a9d6-27f33e3afade','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('63c8239e-920a-4bb8-a9d6-27f33e3afade','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','568ce12a-5da9-4133-a449-5739b248f2c3',0),('63c8239e-920a-4bb8-a9d6-27f33e3afade','61899695-a74e-4fed-8f55-3eebe172ccae',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('63c8239e-920a-4bb8-a9d6-27f33e3afade','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('65b238e3-9746-4498-bced-01961287cd82','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('65b238e3-9746-4498-bced-01961287cd82','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('65b238e3-9746-4498-bced-01961287cd82','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('65b238e3-9746-4498-bced-01961287cd82','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('65b238e3-9746-4498-bced-01961287cd82','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('65b238e3-9746-4498-bced-01961287cd82','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('65b238e3-9746-4498-bced-01961287cd82','568ce12a-5da9-4133-a449-5739b248f2c3',0),('65b238e3-9746-4498-bced-01961287cd82','61899695-a74e-4fed-8f55-3eebe172ccae',1),('65b238e3-9746-4498-bced-01961287cd82','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('65b238e3-9746-4498-bced-01961287cd82','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('67541cb5-6a82-4ee3-9bea-83351b68ba07','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('67541cb5-6a82-4ee3-9bea-83351b68ba07','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('67541cb5-6a82-4ee3-9bea-83351b68ba07','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('67541cb5-6a82-4ee3-9bea-83351b68ba07','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('67541cb5-6a82-4ee3-9bea-83351b68ba07','77f6aab1-618b-4d04-b313-72589b56f29a',0),('67541cb5-6a82-4ee3-9bea-83351b68ba07','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('67541cb5-6a82-4ee3-9bea-83351b68ba07','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('67541cb5-6a82-4ee3-9bea-83351b68ba07','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('67541cb5-6a82-4ee3-9bea-83351b68ba07','b140af73-cb59-4d5a-91f9-c636860fa833',1),('67541cb5-6a82-4ee3-9bea-83351b68ba07','def7cea9-d336-4ab9-a072-627894ded673',1),('8af70cb8-c413-45df-ad9e-f245b5138256','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('8af70cb8-c413-45df-ad9e-f245b5138256','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('8af70cb8-c413-45df-ad9e-f245b5138256','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('8af70cb8-c413-45df-ad9e-f245b5138256','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('8af70cb8-c413-45df-ad9e-f245b5138256','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('8af70cb8-c413-45df-ad9e-f245b5138256','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('8af70cb8-c413-45df-ad9e-f245b5138256','568ce12a-5da9-4133-a449-5739b248f2c3',0),('8af70cb8-c413-45df-ad9e-f245b5138256','61899695-a74e-4fed-8f55-3eebe172ccae',1),('8af70cb8-c413-45df-ad9e-f245b5138256','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('8af70cb8-c413-45df-ad9e-f245b5138256','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','77f6aab1-618b-4d04-b313-72589b56f29a',0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','b140af73-cb59-4d5a-91f9-c636860fa833',1),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','def7cea9-d336-4ab9-a072-627894ded673',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('a510f613-6c4d-424e-b7dc-1f101e1834c8','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('a510f613-6c4d-424e-b7dc-1f101e1834c8','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','568ce12a-5da9-4133-a449-5739b248f2c3',0),('a510f613-6c4d-424e-b7dc-1f101e1834c8','61899695-a74e-4fed-8f55-3eebe172ccae',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('a510f613-6c4d-424e-b7dc-1f101e1834c8','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','568ce12a-5da9-4133-a449-5739b248f2c3',0),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','61899695-a74e-4fed-8f55-3eebe172ccae',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('a828b895-022f-4654-91d4-aa5301e19e5c','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('a828b895-022f-4654-91d4-aa5301e19e5c','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('a828b895-022f-4654-91d4-aa5301e19e5c','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('a828b895-022f-4654-91d4-aa5301e19e5c','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('a828b895-022f-4654-91d4-aa5301e19e5c','77f6aab1-618b-4d04-b313-72589b56f29a',0),('a828b895-022f-4654-91d4-aa5301e19e5c','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('a828b895-022f-4654-91d4-aa5301e19e5c','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('a828b895-022f-4654-91d4-aa5301e19e5c','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('a828b895-022f-4654-91d4-aa5301e19e5c','b140af73-cb59-4d5a-91f9-c636860fa833',1),('a828b895-022f-4654-91d4-aa5301e19e5c','def7cea9-d336-4ab9-a072-627894ded673',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','77f6aab1-618b-4d04-b313-72589b56f29a',0),('bd062e34-a45a-4a44-82d5-0558aec87a90','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('bd062e34-a45a-4a44-82d5-0558aec87a90','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('bd062e34-a45a-4a44-82d5-0558aec87a90','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('bd062e34-a45a-4a44-82d5-0558aec87a90','b140af73-cb59-4d5a-91f9-c636860fa833',1),('bd062e34-a45a-4a44-82d5-0558aec87a90','def7cea9-d336-4ab9-a072-627894ded673',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','568ce12a-5da9-4133-a449-5739b248f2c3',0),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','61899695-a74e-4fed-8f55-3eebe172ccae',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('f50f6f25-d0d1-41e8-9d55-a664f3721a2a','fde87468-6b6a-44bf-8bfe-a50307d48503',0);
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`),
  CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

LOCK TABLES `CLIENT_SCOPE_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` VALUES ('9a96049d-d83d-4869-bcd4-a151f65fc834','0525e272-7c4e-409e-86a4-dff0689c5a89'),('fde87468-6b6a-44bf-8bfe-a50307d48503','28239c06-a659-4e14-ac20-c1f72cb76406');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION`
--

DROP TABLE IF EXISTS `CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`),
  CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION`
--

LOCK TABLES `CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_AUTH_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`),
  CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_AUTH_STATUS`
--

LOCK TABLES `CLIENT_SESSION_AUTH_STATUS` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_NOTE`
--

LOCK TABLES `CLIENT_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_PROT_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`),
  CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_PROT_MAPPER`
--

LOCK TABLES `CLIENT_SESSION_PROT_MAPPER` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`),
  CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_ROLE`
--

LOCK TABLES `CLIENT_SESSION_ROLE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_USER_SESSION_NOTE`
--

LOCK TABLES `CLIENT_USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT`
--

DROP TABLE IF EXISTS `COMPONENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`),
  CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT`
--

LOCK TABLES `COMPONENT` WRITE;
/*!40000 ALTER TABLE `COMPONENT` DISABLE KEYS */;
INSERT INTO `COMPONENT` VALUES ('018789ac-73e2-425c-98b7-d6a8a8780575','Allowed Protocol Mapper Types','3c25345a-35d9-4d22-8a17-4e83429890aa','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','authenticated'),('053f5dcd-85f7-40cb-b980-7b066cf3829f','rsa-generated','19363c62-1a5c-4117-9fae-ba3b727d853b','rsa-generated','org.keycloak.keys.KeyProvider','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL),('0638dc9d-b00b-4783-b81c-58df4a8b53f1','Full Scope Disabled','19363c62-1a5c-4117-9fae-ba3b727d853b','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('0b4980de-19b6-4e87-9426-aa6b131a64af','Max Clients Limit','3c25345a-35d9-4d22-8a17-4e83429890aa','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous'),('1337415d-bf0b-480f-903f-f8a7f20fde1e','Trusted Hosts','19363c62-1a5c-4117-9fae-ba3b727d853b','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('16c8c467-a3d7-4a48-9469-de8eba1af099','Full Scope Disabled','3c25345a-35d9-4d22-8a17-4e83429890aa','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous'),('1d7d6cc5-270d-4be2-a651-7e40867c72d8','rsa-generated','3c25345a-35d9-4d22-8a17-4e83429890aa','rsa-generated','org.keycloak.keys.KeyProvider','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL),('3177e5bf-55e0-4f17-a051-25aab47f4a96','Allowed Protocol Mapper Types','19363c62-1a5c-4117-9fae-ba3b727d853b','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','authenticated'),('500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','Allowed Protocol Mapper Types','3c25345a-35d9-4d22-8a17-4e83429890aa','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous'),('542864f0-f8d2-4a24-ac2e-d640e5a932ef','Max Clients Limit','19363c62-1a5c-4117-9fae-ba3b727d853b','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('598f623d-d33a-4ec3-8032-4fb3eac72492','aes-generated','3c25345a-35d9-4d22-8a17-4e83429890aa','aes-generated','org.keycloak.keys.KeyProvider','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL),('6503c38f-b515-4ee6-abc2-493cdc4886a3','Allowed Protocol Mapper Types','19363c62-1a5c-4117-9fae-ba3b727d853b','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('71f0a52d-69d4-4b98-a7eb-0598169eb90b','hmac-generated-hs512','3c25345a-35d9-4d22-8a17-4e83429890aa','hmac-generated','org.keycloak.keys.KeyProvider','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL),('90eaef4c-4da5-4012-8ee1-61421842d11a','Allowed Client Scopes','3c25345a-35d9-4d22-8a17-4e83429890aa','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous'),('910a3763-52bb-4e45-9743-d6675f1d8e0c','Consent Required','19363c62-1a5c-4117-9fae-ba3b727d853b','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('977d9828-9d18-49a3-90e9-eb87cce7c70c','rsa-enc-generated','19363c62-1a5c-4117-9fae-ba3b727d853b','rsa-enc-generated','org.keycloak.keys.KeyProvider','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL),('9838ffb5-ebd2-4d97-afeb-5c72613a7547','Allowed Client Scopes','19363c62-1a5c-4117-9fae-ba3b727d853b','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','authenticated'),('9b4fcd94-7515-4cda-b1b1-58c9f3d4fc1f','Allowed Client Scopes','3c25345a-35d9-4d22-8a17-4e83429890aa','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','authenticated'),('9e18b3ab-58bb-4bba-9b3f-abb4e400a34f','Allowed Client Scopes','19363c62-1a5c-4117-9fae-ba3b727d853b','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','anonymous'),('a9766ab7-63df-44d2-b7fc-668a15027b61','Consent Required','3c25345a-35d9-4d22-8a17-4e83429890aa','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous'),('af250799-079b-4d82-8c26-5f4b1ad1ff34','aes-generated','19363c62-1a5c-4117-9fae-ba3b727d853b','aes-generated','org.keycloak.keys.KeyProvider','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL),('c6a27179-32a8-4c03-a8c2-8b3bf7bb5e95','hmac-generated-hs512','19363c62-1a5c-4117-9fae-ba3b727d853b','hmac-generated','org.keycloak.keys.KeyProvider','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL),('c90e69e3-20c8-421b-98be-76d1727303c4',NULL,'19363c62-1a5c-4117-9fae-ba3b727d853b','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL),('d527d483-fbab-4641-999d-d094fe415e6f',NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL),('e251833b-8538-4f69-a5d8-160376c7c968','rsa-enc-generated','3c25345a-35d9-4d22-8a17-4e83429890aa','rsa-enc-generated','org.keycloak.keys.KeyProvider','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL),('f567320c-303a-4e2d-8010-51e23a58aa96','Trusted Hosts','3c25345a-35d9-4d22-8a17-4e83429890aa','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','anonymous');
/*!40000 ALTER TABLE `COMPONENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT_CONFIG`
--

DROP TABLE IF EXISTS `COMPONENT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`),
  CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

LOCK TABLES `COMPONENT_CONFIG` WRITE;
/*!40000 ALTER TABLE `COMPONENT_CONFIG` DISABLE KEYS */;
INSERT INTO `COMPONENT_CONFIG` VALUES ('00e1adda-607e-460c-b149-211d1b20e9ac','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('011d8b5b-59ad-4417-ac68-d1027ed7f50f','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','saml-user-property-mapper'),('049af9fe-1a53-45d7-bd35-8c7c90d284e7','1d7d6cc5-270d-4be2-a651-7e40867c72d8','privateKey','MIIEowIBAAKCAQEA1bdVn1KSNlCOa9LSKIAn+CeXFXoV3V3YPMHuk3oFeJMpJ10mOZU0wrjleaUsMMu5B6KYq8bfR3+TZFAls4B7JBVO4pq76R3Lb3qb9Y0/SdcbDiqdPw1CaBiAZpA7iFc5w4503uTjgrFPn1ewC0wP/1fMhJ2+ORiDp1u4hsMHnFGGvlCXxfuFez7LElg1K48St+WvWKLAQU+LodftBHpo3uhR+nrGIT+48bxmopOqxZ4RQOid+JZZrhBr58TX+deoU+JmzGu54RKIDb9zuDyz2MtZVTnyUywQrWj1CPSIF9i0MA0j2pdpXETiADxXvOwJb/8Diq6z50C1BB+VFqJMrQIDAQABAoIBACUGSrdcFPgDazULVDzPfP0tEKvYF3cfBbH68APNKSr7Ja9L4C4sJvSQFzNElfwLIy5LMTNbM/3dQHHpv6pSGSNGbMDtyR2o+4A/58p50qvOcAG7iLvuZmGF0yLRnHqxj9CM+rrNwQt4f+CNTrKaVhAozAXylQyrrk09YuG34nbmSH8CeknsPHoXtEDH/jlmdBLRPdnoiJEHDRToWQq9HfjqpWlgF4u1Eq2l3HRrfrwRn9D4cjGFtjEWi9ZJZ2X4ajabph25NoBS2ATzpYXThJl7d1xLNAQVjzQsxQ3CSqMAdo+U/MJyNavO4arKfVFMVrilIULmNM2qhcVJkEWHArECgYEA/uoj74ed2O4K8KM4ijUle08lkjXLfZQbRgi+9k6tpjhVRSY0Zd9ZmDzf6ZuJRV8/vUIUhR2++i+0/M72CDHp2KwT7vp8IgZT4R66hN3Umt2/2aOMfO0+FWN3iTIBEn/8mDicRvb1lH5RIl0JnZOhLIZeH0xeiGdMgxm3nezLWTECgYEA1qBJjnfiYsvqJ3rH6ZGDdbSmXzVgqovjLrrkcK9nbTYcIGfax9K5qSpSe79KIn0GwAe6mQFDu2b1adAxhs2E8wbMDlheYDY2byfNPD+a5LWqF0xhhzRM9PnSGPLFyp/69ti2iG1kpVpnC99rV4Dbs+eNRBe5QRBY3DjaXuoLzD0CgYAYLov0KBBQSNye0U0Gx13j4bE1uoawRgGEVkYPRY1xjDyCj8o+s75jE7tGBOwzuYJpaMBblGPOhgIMTXHHezyswj4t2HM4IxOH8otNGWIWwtx1P++O1k6iZsorKKQzZhLHOe+RR9IqIQV/VgYYfa23dJOvMmZxWCNI+IKTp6fusQKBgEC3ChbkPSXPGKaY1giucLYgJ35TyPcDwRfJELKNoSEEDM0Uo5pXBtZkRYS8tCzcCBoE+pXCFNs/+0XRme1ssObaqNK2gJaAIj+3/6FoCFtoD4aA6HNtKLtBTMFrCorDXFfsFnXijlNxg9rHnkU/PH/tlOHwSVK+DB0zI101MyN9AoGBAKrjOfrOao7geVV7WxdHqUCu4brlPkDRdP3sRk6nGUYLprTh+fAyz/wALTo6AZq2hA6BpTOuXCnYAXDb7drTuSy69fJ3M5xi6IwFPzytaYCQH2vizdyH0wk9cxuQ7LWvwb58JVGtw6FjRwaEAZ/p/mRGwHs8Av19WIlXzwSaWp1O'),('06b30c8c-a72d-4520-9412-905d46d66031','9e18b3ab-58bb-4bba-9b3f-abb4e400a34f','allow-default-scopes','true'),('0d59bf5e-3452-448b-9bc3-2ddb5b9b5d30','e251833b-8538-4f69-a5d8-160376c7c968','privateKey','MIIEpQIBAAKCAQEAuhw7jZGOKhfztyNkuawOjy1kvrCup/4FkTel5m+OUoSsj2kgiiCA98WR0cKx7QwB2X0abqTwE7iMwIAMJdU6kYGOlrNdCSoKuWO7Dxyoy+bURkDH5ullQCDeW8uiAMYBZNgYt2BA2cOD9peRU30U+tMggl+sZducu6/MBUjLYi9ECVT0JMq1wycVXt5U5VHITEeuEwy08+Z/6PD1wQX8jKOWbhr/n8b/CLy/hl1Au+nCt/xu9oBgnjVwzj93TgVxNNMGYcRB9tFWo6rJdEgJb3+MmuPN9UKurMI7nSJYfewCyD6vBVCWnDtd61QtNuD/HBgZOuubAmRVfahKiWBAEwIDAQABAoIBAAkO3wy0tQ8HiC/ZE98cdtvUxrXEmDjt78FRzG+SCZ9VUhlrqkfwidSas85aKwTf1AL+stQkj4NuNMFR/bAJCdHFRqgw8IobJTrPQKdPByvt2463kBwTSzhwa8Ppb9K1QjA4ezMJMae5bTP7k05VVqtYIAtvgPl+KMmoNJSVe+yk+DR0rfxmxi6JlpbBddYDrbm4s+fsTV6W99IShbvKFcdeEgLNTHjCLgW42FerbvBYpa5z71abACTwJ5vIq3LqLqI+DwybhWv2qyxX1Rw092wP7QMoRWAx3Wo1E/vnVhqnPV0XqJZWM0VUvoqEmhPV7YPdWITN8CWMK//fLuJBRuECgYEA6cDGfY0Q3Wn/YwXiyj/+JF52DOb/jUPKHASo1Yy1+fHy5nhwI2Z7Ljcwk2eLcQdCJfTxW3sazM49syC8z8P6DSIH/lwM7nZ+GlJoNdYigvhXMjyvYrWGavNHdvjJh1R8IdTKwbQzS3E16kso4xi7e6ODoEkqejM7NPZmXFq38bMCgYEAy9KtDzyIQcgu8ynvKB0UPWBhFIKek5OQx7PQbrUEFvrsJVQ8Os2Rs78RVAQoBG9U9T85UkM8+mZtVATV0qzrWvGGL9f1hgrnvLhRyy8nIQRv1+OQ5B2Ot+e9ZLsflEmEWh0S2YigEcpHO7ES/ZH6+b0T6KocJz+zeWx3zrQxiCECgYEAr6pKwKGZkfuNjHoo5DtRHz3J04ppdF0EbyflRY7YVvzHwQGzrDbgzWt2WuBOv2NoB6RbGZebHVzEq3An1K9/pAz2GuZMZYyw2dEiNYs2JlzBEqTeXPz0Bj3LcBIpSUVpf/ctZIKqpcBvdyKCmJ/GjXTlfzhc7ra/gN7HMBKQ99cCgYEAvL0+0gAcsMV9bGClfIDI8DjiTMrTqxaXl8WTuiBXRCxhJgQFrfIT/N1uX11l7Q1nH57HJrzqp3jXvlin4+mKG3HR71XMnq5UfvYzj7H/Sty/8KtizUntkbC/OZrpmDgnngaUIOoaR78HDWhgjHx0anRDDk0PuuyK9mKR4tALmeECgYEAtNAsF/6HsNplZWjvu0J8GhfIq3Cv0W0NjNmgjivNRB++ic/6XTB2U1chJc4zmGuf2/y+1KJ93yof3KgkA6/CgEIhxESuZGSQtMUKrNwkT7d3on0vDfIqT+fvvIrK+k0YdLSigKm6aReRm0KmnOem0yUsd7s6ysM+MopqWGAN2TY='),('1231a997-6cde-48fd-9f89-21fd942f24a3','e251833b-8538-4f69-a5d8-160376c7c968','algorithm','RSA-OAEP'),('128869a0-608a-457b-8a16-14d065b223fa','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','saml-role-list-mapper'),('13a0935c-7818-4423-9773-c03920cfc532','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','oidc-address-mapper'),('14b3a585-b9af-45b7-9d2f-428748a6460d','f567320c-303a-4e2d-8010-51e23a58aa96','host-sending-registration-request-must-match','true'),('2a73bd02-8c61-4b83-ad4f-4e914f605ae1','542864f0-f8d2-4a24-ac2e-d640e5a932ef','max-clients','200'),('35041b53-e5f0-48e1-bf94-abe634bb91cd','053f5dcd-85f7-40cb-b980-7b066cf3829f','priority','100'),('3795bc8f-c2a6-4354-96e3-0b942062c576','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('3a017f27-b7a8-40b2-be0d-f25483f4297f','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','oidc-full-name-mapper'),('4a2c6025-4e22-4a9b-becc-7b16f0870a47','053f5dcd-85f7-40cb-b980-7b066cf3829f','keyUse','SIG'),('4af417ec-1737-4e28-850d-7b533711fb72','71f0a52d-69d4-4b98-a7eb-0598169eb90b','algorithm','HS512'),('4b42a45b-8104-483b-b5fb-9d30757ad635','c90e69e3-20c8-421b-98be-76d1727303c4','kc.user.profile.config','{\"attributes\":[{\"name\":\"username\",\"displayName\":\"${username}\",\"validations\":{\"length\":{\"min\":3,\"max\":255},\"username-prohibited-characters\":{},\"up-username-not-idn-homograph\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"email\",\"displayName\":\"${email}\",\"validations\":{\"email\":{},\"length\":{\"max\":255}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"firstName\",\"displayName\":\"${firstName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"lastName\",\"displayName\":\"${lastName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false}],\"groups\":[{\"name\":\"user-metadata\",\"displayHeader\":\"User metadata\",\"displayDescription\":\"Attributes, which refer to user metadata\"}]}'),('4d73982c-d26a-420a-a869-08bb4151403b','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('4d9a10b5-92dd-46a8-a399-8451545917de','053f5dcd-85f7-40cb-b980-7b066cf3829f','privateKey','MIIEpAIBAAKCAQEAzS2di/qcX5rUAjwPFZPdN+47ZY2mzCmnHadolYQw/oPgSRtFxBfwq7apEkacmmh8Ca/zO5a3nPGYzUx5Jzlu91X4jt1PZ4idKweag7gBaAk9DFdIWcTzJMbHpCfmWDuyYZKz/+nuUqUrYeHC5Vn1o0+eDquzSiZqKR8/4d+QtNTE+ztTeFO4ZQ6GY1i2Mo9vRW3FtKmfO9PdsIG0llbC0K4hvZGsoigTMbVknOZd5uqOeYk28UisYqZomqVVB3K4JIxv+775zH/nZ/p+B5U9p0i0J8BOxyvRdJd9WzCGWVC3wAUHSxXnso6pvQiWaRUu1UuLJIV/CckRaWch75xLMQIDAQABAoIBABlCWokZ6bgQDgtWYdRaDJvESECuKdDW9zwR2NtrV5gbG84Jkv2wpXrmSmCLG+AbKTC3c2jXGwoHE4osC3rrjwCDxM1bFoRG+nO1LxhfMKEiXgclFFhPhFAh6VW0FHSxU2UVaUksqfU3tfm0uvMpr4a9mFZIXL1YsazCrEZ+PkjcniI2428yGMcJJl74HmhgdXxf5YLyuN+lJej3dsh13jNIJ0hoeCGjc9otNrFKE94cI8BQwXfif1Z5ZG/cwu3268/Rv0boIotyPomu7vLRbgbCyLXjdgZDZnQ8Cye3Oarvc/IVK/ITlThEQkQa6Ekbsak1+RBGgy+WtkKkFpUUiRcCgYEA/PpAqBGFl0jbiu2F19TCFr+5iuUyIFQCbwXIAfxcUBApS881ie8IjLRxYYbIinVERNTX6oDtUctdx+DAoX5Y8jfOfQ58nyCeJw2jEKdMA1Y5ZkcQ+W3Z1ZpsuN27CmZ1BsvFx8G+g9vwnbhbDTLGIEhfxPJ88IxriGM0A38X3hcCgYEAz6EqYYLbxiBibSNy18A8qxUxyEANTr0m0KObJ76RgK6PLBSUsT85AoQw87U/eGJvWipSXBvfW6OQ/BwotxD0suk9QXlSZ9eIW+IfxkpaqbKOG3mXATtX6mbks5CNqnWPLdHVIf+37F18IH5VmcuxTe2bhsqwBYUt7KeXjU7f9fcCgYBcsCQ4cBMOVvd5c4VyitWCGEUXCtrO1Xj+zJN3hssb2pAG4qivHRF43DQek4+ui0C0J3fkx9AsA+McdNCfWvej56aUU1Z9xymrDWgNlf5XyqPFQYyKlyEVDjt/kF4TdW6zSr3wbqArF86VOxLBRzUoZtwQAPid+hT8J7zK+yn3iQKBgQCTiii9hel6DoUinK/81CPIRpVLgQhzzUGJvNiCE479bA1c+3r1wMFYImtOoprphrktzykbPssnKUHbhH8CJ1Ba2hanMfj2xVemQzblBu0J7VHCAFLnky3T6S3W0393g3YszxCuyjH+CigsRtm5Id9qSs/bpqgSJCMQKb8tsMDA3QKBgQC2hz3QzPnijNIegsHOic5Vi3Xu+/o7tGBffcXFf3809Cy4PsyA7gWFEnCmfC3Qe1tgy09yTJaV7LKJ6Ynnq/XcMdOvk+b+Ogoeijkko5AOtzG5TJ0G/VwajgrIc56ZqTjgeJ2Am01pwKfzTdf73PV2V5/uadrxLX7j35BKUhj33g=='),('53a6efd6-0d86-4054-b195-1e9bab1abae0','af250799-079b-4d82-8c26-5f4b1ad1ff34','kid','e1465daf-dc5a-450a-b57a-afca217abeea'),('5d824293-7c8d-4bb4-b9d8-dfef5c7c833c','d527d483-fbab-4641-999d-d094fe415e6f','kc.user.profile.config','{\"attributes\":[{\"name\":\"username\",\"displayName\":\"${username}\",\"validations\":{\"length\":{\"min\":3,\"max\":255},\"username-prohibited-characters\":{},\"up-username-not-idn-homograph\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"email\",\"displayName\":\"${email}\",\"validations\":{\"email\":{},\"length\":{\"max\":255}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"firstName\",\"displayName\":\"${firstName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"lastName\",\"displayName\":\"${lastName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"nationality\",\"displayName\":\"${nationality}\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false}],\"groups\":[{\"name\":\"user-metadata\",\"displayHeader\":\"User metadata\",\"displayDescription\":\"Attributes, which refer to user metadata\"}],\"unmanagedAttributePolicy\":\"ENABLED\"}'),('5d93f99b-46a7-4303-bdaf-21f0c1089308','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('600d4711-5fea-48db-973f-99d7430e3459','598f623d-d33a-4ec3-8032-4fb3eac72492','kid','f843d222-5b71-431c-9a6e-083372b3741a'),('618c2392-401b-4a58-ac8e-b787f4a32c34','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('63c0143b-1f2a-4156-a926-289afb23d6cc','053f5dcd-85f7-40cb-b980-7b066cf3829f','certificate','MIICmzCCAYMCBgGSEoaTSjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwOTIxMDI1OTIyWhcNMzQwOTIxMDMwMTAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNLZ2L+pxfmtQCPA8Vk9037jtljabMKacdp2iVhDD+g+BJG0XEF/CrtqkSRpyaaHwJr/M7lrec8ZjNTHknOW73VfiO3U9niJ0rB5qDuAFoCT0MV0hZxPMkxsekJ+ZYO7JhkrP/6e5SpSth4cLlWfWjT54Oq7NKJmopHz/h35C01MT7O1N4U7hlDoZjWLYyj29FbcW0qZ87092wgbSWVsLQriG9kayiKBMxtWSc5l3m6o55iTbxSKxipmiapVUHcrgkjG/7vvnMf+dn+n4HlT2nSLQnwE7HK9F0l31bMIZZULfABQdLFeeyjqm9CJZpFS7VS4skhX8JyRFpZyHvnEsxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFWNHmpKhJ5MmB2fRxSoLN/nI2mnGtO86pLzd7pjo5DCNtP4JdAaLWegNjO5GT0kJ/MQux+AmhoJZBOnkYIneeRpuzKy0hM+s+UH4MRClZVnr/cHf/y08/zRuwnCK8u0+dbW12pMwIhpXhu9iz0EuWU7L6zXDXfacWU8tROWQudt1JKUcDttvXadZSET+P6BzygOoKcKNM/EZGrHB74Y2BDymPCMk0EnG0Jvm90vmjGWjowZmwSBfjEH/NZVYpO7GDcHIttze66EdPOIWEli1iDFQPcrMg9L39nPtHYNY3rKCrSUnQV7X9YoaVrn3XQzjqReNrKU2PzCb6/DxEPIINU='),('6737fdb5-8718-4ea3-b6a4-8e1e11c97193','9838ffb5-ebd2-4d97-afeb-5c72613a7547','allow-default-scopes','true'),('67c62c21-2ddc-4ef8-afe1-4411b6df515c','598f623d-d33a-4ec3-8032-4fb3eac72492','priority','100'),('684e0670-887d-48fe-8b20-65d3468959b8','1337415d-bf0b-480f-903f-f8a7f20fde1e','host-sending-registration-request-must-match','true'),('688f816f-8d9d-4b62-a6cf-395a1b1721c2','977d9828-9d18-49a3-90e9-eb87cce7c70c','priority','100'),('6bfce980-f4b4-442d-bb53-21f247dbcdce','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','saml-user-property-mapper'),('74d43692-fc0c-48f0-9e34-0816f357b8c3','1d7d6cc5-270d-4be2-a651-7e40867c72d8','priority','100'),('774dbca0-60b6-41cb-9847-36e41e86560f','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','oidc-full-name-mapper'),('77e2aea1-2852-4058-909d-ec74b56faadd','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('7d4ff010-c26d-46c3-af89-ec9583442da9','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('7da5631b-7d16-4e36-8796-3f47be8c0b40','e251833b-8538-4f69-a5d8-160376c7c968','certificate','MIIC3zCCAccCBgGSEoaayjANBgkqhkiG9w0BAQsFADAzMTEwLwYDVQQDDChtaWNyb3NlcnZpY2VzLW1vdG9yc3BvcnQtcHJlZGljdG9yLXJlYWxtMB4XDTI0MDkyMTAyNTkyNFoXDTM0MDkyMTAzMDEwNFowMzExMC8GA1UEAwwobWljcm9zZXJ2aWNlcy1tb3RvcnNwb3J0LXByZWRpY3Rvci1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALocO42RjioX87cjZLmsDo8tZL6wrqf+BZE3peZvjlKErI9pIIoggPfFkdHCse0MAdl9Gm6k8BO4jMCADCXVOpGBjpazXQkqCrljuw8cqMvm1EZAx+bpZUAg3lvLogDGAWTYGLdgQNnDg/aXkVN9FPrTIIJfrGXbnLuvzAVIy2IvRAlU9CTKtcMnFV7eVOVRyExHrhMMtPPmf+jw9cEF/Iyjlm4a/5/G/wi8v4ZdQLvpwrf8bvaAYJ41cM4/d04FcTTTBmHEQfbRVqOqyXRICW9/jJrjzfVCrqzCO50iWH3sAsg+rwVQlpw7XetULTbg/xwYGTrrmwJkVX2oSolgQBMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAjuyP5QmLqDqqwnvUrYqLTgYmXocpxa6slgcVx+U18cbiFfG5aDfmTkj9TTT9TyjWgDajciTPGrlDU95nGdS6vcJamYM66hsv6qcWnRU06vr/+IjCpxq2OA/7GtMg29nfk5IaK2JDY+Jsy7DhfO8hZJUiUlmgU9u8+mgdY6xopr2gbmtkALukxIE3GRYMZ4OM+XtHP6JNLx0Pfn8b7C6v9gHePhg752cGM7QgoRrA+bGbARAhosJTzs94TuAo7d9Wy5Yn4jcGXquzQF+muVsJnedebMcaroUbeYPlpjWNJFTn0tdfsPo0I2/FlEc9NrdBV7kX/gK2cC+L7X3P1z7xdg=='),('811cf250-56cf-470f-8d71-d825c34ec4a4','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('82adb26f-dec1-49cd-a960-596d0bd7b129','c6a27179-32a8-4c03-a8c2-8b3bf7bb5e95','priority','100'),('83513011-575b-44c8-b57f-b4c35f146190','9b4fcd94-7515-4cda-b1b1-58c9f3d4fc1f','allow-default-scopes','true'),('84d817b7-a0e8-4150-a1bf-f4a466e3ecb3','977d9828-9d18-49a3-90e9-eb87cce7c70c','certificate','MIICmzCCAYMCBgGSEoaUIjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwOTIxMDI1OTIyWhcNMzQwOTIxMDMwMTAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCor+lPQX9/fu13NnaFY0G9NbnT4HTJ8FZ7fRkRYAQNzs/oS4nFM/fRd89OmzyP0wBEfpsxIlD2L2FDXhxhkWKskNiagjtSf7q8a1tB+F2Ab9Et1GB2Xsu55J5EC8HJ7RtlgJyVMVWOL3/Vqk+NuvJJstmA887IFjcrRpj/0sw8Ke5eI15j8q7NS1irJBT1S/wurjV7Z783wGtIpIDL2W6lMty52iIAVxMRoGOUdRkRbu8p1EflOraX+HWvqBs9F0YtQb3jMMLoqv1Fxcf2ralhTn41QHeAeK703BGbdxjXBEDlvwvI99E+6vtaMH7efIWTo7Z2rYW0PwaRL5MDH7LtAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFRF1z78DlPpmcLDsreXGDxxvIkQ1782vVUjUU8dgxbMsfzg0arAJ3UP5/gcP0N/Iz5LhQ2COXr5v7b7U9ryM36VK5Q9PmJ1t2wzzVFdmR2SeUicS4hZnpl8le0ucoWL++T38kAg0Z4FSPrDFSTtYPo+D3kKfbz4ZQt26IOCMxRmJyjZPSzj1g3DTMnQujq9rINxyjn51B7cYSGDr3qmJg8otwkE+fLN3jkjSmBrRg+TTzh+22VbeCyr7EMD1ahARWYaT/ALxJ7jjqx4YEjyya8e6d0/dVLqOj7Gk8sf4frFadSH5tlQPPK/nQ5mS2PPfYlwTGOSV+fS9v9DBMMBTZ0='),('86c286ff-4608-42ad-812e-3f1468f6d08e','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','saml-user-property-mapper'),('8a0b2693-e1d6-4ec3-aa50-5cefd8f7341a','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','oidc-address-mapper'),('8a13291b-2dab-4995-bb8a-8b5dddccec09','c6a27179-32a8-4c03-a8c2-8b3bf7bb5e95','secret','_Q0EeuxPy5nGj-YMZoUFTdDyONDKlZ2f_wj7qoTCWjNKMzzXmB_nyU7aeyzxwGrfNlfh0gEzk3FbLSf52vFkvG-ccx-0QgZ3RVxh90LIAgGkpvbMHSBuog-vRS9UzJS04lEx_pLtON4wXsRK_VHz_ybUz4W4FKNtxWKEYOaZKCA'),('8b558137-88ff-4df3-a426-a5e5ef656637','e251833b-8538-4f69-a5d8-160376c7c968','priority','100'),('8e2b616f-ef9d-482a-9b27-c0f625df7f69','90eaef4c-4da5-4012-8ee1-61421842d11a','allow-default-scopes','true'),('91b2a293-2c12-4de9-bac5-4c929e1a96a7','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('9272cb21-9f72-49f6-ac84-2760f5e22292','c6a27179-32a8-4c03-a8c2-8b3bf7bb5e95','kid','82df5498-0a2d-4128-84f5-d692b0a3b5eb'),('9467a14b-d0f1-4c90-b25f-129da6cc0e8c','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('95ec339c-e1d6-4651-b558-2f4fa06454ef','1d7d6cc5-270d-4be2-a651-7e40867c72d8','certificate','MIIC3zCCAccCBgGSEoabpzANBgkqhkiG9w0BAQsFADAzMTEwLwYDVQQDDChtaWNyb3NlcnZpY2VzLW1vdG9yc3BvcnQtcHJlZGljdG9yLXJlYWxtMB4XDTI0MDkyMTAyNTkyNFoXDTM0MDkyMTAzMDEwNFowMzExMC8GA1UEAwwobWljcm9zZXJ2aWNlcy1tb3RvcnNwb3J0LXByZWRpY3Rvci1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANW3VZ9SkjZQjmvS0iiAJ/gnlxV6Fd1d2DzB7pN6BXiTKSddJjmVNMK45XmlLDDLuQeimKvG30d/k2RQJbOAeyQVTuKau+kdy296m/WNP0nXGw4qnT8NQmgYgGaQO4hXOcOOdN7k44KxT59XsAtMD/9XzISdvjkYg6dbuIbDB5xRhr5Ql8X7hXs+yxJYNSuPErflr1iiwEFPi6HX7QR6aN7oUfp6xiE/uPG8ZqKTqsWeEUDonfiWWa4Qa+fE1/nXqFPiZsxrueESiA2/c7g8s9jLWVU58lMsEK1o9Qj0iBfYtDANI9qXaVxE4gA8V7zsCW//A4qus+dAtQQflRaiTK0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA006UkQ2y5PYrHy3Kxwl/QN7jLDwH39HYNkVTGHRL9O4i0g+MCObjaSjwFQ17/8jJ2smTzVN6xrozjss7zoIieXeHO/6nX6CavOPaQY5IXwjXlYvTzPUXxmfh5Rp8NWC3pG6Mk267DWleR1Tg6q5+qTDkbwqxQvz2VsvNDDCgwL8w/KeUowbs1DRdeseBrbJi2FTM1lZrvNsoDAgp2LHtT5twmkoVcd5R5VkyiusnWMkJ4ip2syT6aJCrTe5Idr7hciqr/9Xsep4Zn/AUlwL3sUT4ifcaqCajV37WPEmfWz5DDnlnD4c7SmFmFGryMgHdZW8leqsBqkfBLLM4UwHJvA=='),('9806d873-b1d2-4934-973f-fc2486cf46f1','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('9d5e3b24-6b87-456b-98d6-d0999e7bbb1e','1337415d-bf0b-480f-903f-f8a7f20fde1e','client-uris-must-match','true'),('9e317cc5-1b83-4f2a-b29a-02c44c7f98ac','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','oidc-full-name-mapper'),('a5314bdb-c526-4265-bb7a-d05ccb35674f','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','saml-role-list-mapper'),('a66313d9-faaa-4c06-a752-69e39ca0584e','c6a27179-32a8-4c03-a8c2-8b3bf7bb5e95','algorithm','HS512'),('a6cd86ed-2430-46ec-bc7e-35aeb32eea25','71f0a52d-69d4-4b98-a7eb-0598169eb90b','secret','GhTQvx-Nh0jrGOIy_Y81blJKRWfODHIGhJ9fLCuAf51MR8GHiJkY87-KqFg4qyIGuhu7TBeV2ghQdGhoapO2HPVCvHXZ4WcqwRR8XRORBabd4XNKswHMG1ydoc00BW3aXGjv1iO0-qpRDYwFojLfyPr-gkUb2f6vCK2hopmPk7s'),('ab87fe9a-81d6-4e25-9c48-3164d276a803','977d9828-9d18-49a3-90e9-eb87cce7c70c','keyUse','ENC'),('af8c508c-e491-486d-b748-10c9c4e2870f','500929b7-eb34-4c3b-9bdd-2ce32e74fd3b','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('b1b1fcfa-5a7d-4215-9001-0ad514805068','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','oidc-full-name-mapper'),('b27115de-8b93-453c-a9c9-2c57093fe716','af250799-079b-4d82-8c26-5f4b1ad1ff34','secret','mNFcnUAd_xq2n2CTU0SerQ'),('b2b50ffa-60e9-4bfc-8d43-11e9868255b5','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','oidc-address-mapper'),('b5f6405d-d39a-4cbf-aa4c-7313d216c04f','f567320c-303a-4e2d-8010-51e23a58aa96','client-uris-must-match','true'),('b8c9f150-945b-4725-befe-5ca8939368e7','71f0a52d-69d4-4b98-a7eb-0598169eb90b','priority','100'),('bb8d38db-47fe-400e-973f-54bc575c2f1e','71f0a52d-69d4-4b98-a7eb-0598169eb90b','kid','10802f7c-ebba-4099-95f9-b97b44f62531'),('bb9989e1-ec4b-4ce0-99f1-65b072372b10','af250799-079b-4d82-8c26-5f4b1ad1ff34','priority','100'),('c705e3ee-7ab8-4e17-88e6-306bdab21a91','598f623d-d33a-4ec3-8032-4fb3eac72492','secret','jFKgaujCfzQohsYtFpIq0g'),('c90ee579-643f-486f-8d2c-b18a0b481568','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('ce860844-8772-4ff9-8dbc-7570df5d2109','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','saml-role-list-mapper'),('d444c57f-9ab4-4467-bd58-83eab431e105','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','saml-role-list-mapper'),('ee37fcc7-e714-4f29-9882-bc9f6cd34eb7','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','oidc-address-mapper'),('f0415c5d-3f57-43b1-afae-34568894c9c3','977d9828-9d18-49a3-90e9-eb87cce7c70c','privateKey','MIIEpAIBAAKCAQEAqK/pT0F/f37tdzZ2hWNBvTW50+B0yfBWe30ZEWAEDc7P6EuJxTP30XfPTps8j9MARH6bMSJQ9i9hQ14cYZFirJDYmoI7Un+6vGtbQfhdgG/RLdRgdl7LueSeRAvBye0bZYCclTFVji9/1apPjbrySbLZgPPOyBY3K0aY/9LMPCnuXiNeY/KuzUtYqyQU9Uv8Lq41e2e/N8BrSKSAy9lupTLcudoiAFcTEaBjlHUZEW7vKdRH5Tq2l/h1r6gbPRdGLUG94zDC6Kr9RcXH9q2pYU5+NUB3gHiu9NwRm3cY1wRA5b8LyPfRPur7WjB+3nyFk6O2dq2FtD8GkS+TAx+y7QIDAQABAoIBACHOzckBZMr59qBVpUfjBn4kKif1fJqrZT3PKurBTlaxHBifqQ9BtNmBtGX59VeS76MKp9JfYRASG2F7117Tm03gItVGpBqK+HNCZfIRE7ZF0svnXGTk51pMoE6dd5uffoXnkppRHqdGTE3XmiWa8evE4VQ3qPoPf8OX3Nqq1h15a46Mszsox8BPKXvYX3M1riwNCYGfE26FhcNi1d5ARK30Ta+RKWn9cTtqokQ4G+DpihSEAqVd3oFQL+oL1c9F4EBwBsx5nB/nnAwbWcWUuv5y7xbpZQuhmzSBxDP6zDbFAGbFqPntqnpGX+1gptht5EwHDOAr8gRcNnZh2T9IqKkCgYEA16f66pDK+I4f2I4e7Qgo6zfkzq5iO3Dzry1eQmwRSSexobcz2dvPTo7TEn3ZEWr82q28RZzfZqkiPyB+q464Bm89YNz5wADEoUPwSpSTfjvKPmeiQh/geMMKAfbDzc4o3jvt15fYHvxiQcGwAZ49ceAHT2ywF3Wb9sO3CBR4OFkCgYEAyD6ICX0TeRWiCN3mFmrlPtH0rHr8Pv+SKnKbwdbcI9RJHsCAov5iwtAr2w2bfzLDPNpY1xb2kIjp2Fuu45e2A66ET/63wKI8rE2LwqmqZmm6p9XpUywup8+ei1BsoxXkS0PKC80qRYoUtwIiAXnxWGWM61qu583zDGZTvNbjPLUCgYEAuu0JmuQiasuWYvjdaYuXHDt4goW489j2ADOM7noJiaV0XL4VnZLf4DIAVpjq3CQmQ84v0Q8mvS+BVcJuyXmNnVYyl5EykfCYf0gKMjsSlWpx5SGjDTngMgys0gL4uZ0m42qCwEsHs+QDrweZ7e0hSWFsNLX69Hqm03/VWJWVlxECgYA1uUkoOo1x7BLoDBjCJPXSb+QULn7krA7cIpmVXP79AeSIQp+Am32FxPIvOCxi6Qymk/JH6tpGFuWebaKzXy2vOTA4gh9sqFpc5AU+OeUEyxMQGn0aGn19+l8QA4jSDHqOkuZvWiEgPRanrwPOn5fX3o77Sf4pJQEzb3TB8mlPDQKBgQDKFaTpj2hLd1dq/17L1/xw4O1ezPPXj5LPQ9wOQ2ZtEYeBjEYUXjl4fojTvt/7pNq02gR8DSKagqg8/vbFzw7VqUe3i4nC/i9BcFzoTJ2MUC2NQMW6Y9BWB2o1E1xM4T3M5I9oRfW3rYhVLIc6qsclRaO1kGyTBFCVXrBIWXA/ZA=='),('f138e258-a243-47e9-89c8-26d5b4c9bb28','0b4980de-19b6-4e87-9426-aa6b131a64af','max-clients','200'),('f1e6f134-f18e-4e69-935a-bcf051fdf2e6','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('fc3a0473-fa06-4b61-8566-3004cda69952','018789ac-73e2-425c-98b7-d6a8a8780575','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('fd041719-159c-4b3a-aa87-7bd28b32d80b','3177e5bf-55e0-4f17-a051-25aab47f4a96','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('fda723d9-210a-4ac0-b908-9f75cf6b4ebe','977d9828-9d18-49a3-90e9-eb87cce7c70c','algorithm','RSA-OAEP'),('feb17fbd-d4ad-4b57-949f-1172813123b2','6503c38f-b515-4ee6-abc2-493cdc4886a3','allowed-protocol-mapper-types','saml-user-property-mapper');
/*!40000 ALTER TABLE `COMPONENT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPOSITE_ROLE`
--

DROP TABLE IF EXISTS `COMPOSITE_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL,
  PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  KEY `IDX_COMPOSITE` (`COMPOSITE`),
  KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`),
  CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

LOCK TABLES `COMPOSITE_ROLE` WRITE;
/*!40000 ALTER TABLE `COMPOSITE_ROLE` DISABLE KEYS */;
INSERT INTO `COMPOSITE_ROLE` VALUES ('13b81f2d-f9d9-4d79-ba28-cb73604e33be','05f7f5c9-c89c-44fb-92b2-c72020f00838'),('13b81f2d-f9d9-4d79-ba28-cb73604e33be','28239c06-a659-4e14-ac20-c1f72cb76406'),('13b81f2d-f9d9-4d79-ba28-cb73604e33be','425879f8-bf1e-4028-a143-b80308791715'),('13b81f2d-f9d9-4d79-ba28-cb73604e33be','a89f9516-c318-4ee2-add6-f8c2a77d61d5'),('1573733c-b0a6-493a-8fcc-9f1ba2849091','ccd52767-5784-4ae8-b140-d6ca958170ee'),('1c5f2efe-565e-4e3c-ae19-e7136b4d35bb','03fc3703-b8fb-4d62-ad8b-04c22f250284'),('425879f8-bf1e-4028-a143-b80308791715','7b59bf65-77ab-4580-9258-10a341b0703a'),('4911142d-4e12-4558-be5c-1d0acad7040d','d8035c1b-ddd7-47f3-bede-7e656e5b3d02'),('5c063bd7-7d55-431c-a056-976835c1e27e','03fc3703-b8fb-4d62-ad8b-04c22f250284'),('5c063bd7-7d55-431c-a056-976835c1e27e','0423dac2-5001-4f7d-933c-f61c90eb0896'),('5c063bd7-7d55-431c-a056-976835c1e27e','066d5aca-cb39-472b-baaa-8e57879280ed'),('5c063bd7-7d55-431c-a056-976835c1e27e','0b091e89-197c-49a8-ac92-69814f5c9da8'),('5c063bd7-7d55-431c-a056-976835c1e27e','10b38fec-37a6-4492-b430-8a9fb3a87654'),('5c063bd7-7d55-431c-a056-976835c1e27e','1c5f2efe-565e-4e3c-ae19-e7136b4d35bb'),('5c063bd7-7d55-431c-a056-976835c1e27e','5b548dfa-c0cf-46f3-98e2-1edc8ab99683'),('5c063bd7-7d55-431c-a056-976835c1e27e','67f29e75-d90d-4e3a-93c9-2be20410f07c'),('5c063bd7-7d55-431c-a056-976835c1e27e','7e0604e8-b3ef-415f-9071-c7b20ff69529'),('5c063bd7-7d55-431c-a056-976835c1e27e','99e7633d-edc9-414a-9bb1-f800082b4fe1'),('5c063bd7-7d55-431c-a056-976835c1e27e','b3ab3907-77d0-4e6c-9800-90cba094c4cd'),('5c063bd7-7d55-431c-a056-976835c1e27e','b767b2aa-e387-4929-8658-27ad703a025c'),('5c063bd7-7d55-431c-a056-976835c1e27e','c2727717-c3bd-4615-831e-b99ff015787b'),('5c063bd7-7d55-431c-a056-976835c1e27e','c9e91a92-a2ab-4d61-91af-17b4dd2506f5'),('5c063bd7-7d55-431c-a056-976835c1e27e','cfec7e47-0c74-4362-8268-edc6693a08a5'),('5c063bd7-7d55-431c-a056-976835c1e27e','e40a7d59-22a8-47ca-a18b-dc1b94768f4d'),('5c063bd7-7d55-431c-a056-976835c1e27e','f139478e-cd35-4c54-8663-0d5048475149'),('5c063bd7-7d55-431c-a056-976835c1e27e','f67a838e-73dc-4fa5-9abe-dc68290df335'),('61dc0308-2944-41c7-aa7c-7947eb4a3378','6f3b19fb-58d2-4599-a5a6-f9f8ae4615ae'),('61dc0308-2944-41c7-aa7c-7947eb4a3378','bdfea3da-368a-406d-940d-3d28b8effd4f'),('67f29e75-d90d-4e3a-93c9-2be20410f07c','c9e91a92-a2ab-4d61-91af-17b4dd2506f5'),('67f29e75-d90d-4e3a-93c9-2be20410f07c','e40a7d59-22a8-47ca-a18b-dc1b94768f4d'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','11b9568f-ec8c-46b3-b60d-fa9d08f48526'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','27a740b9-3d18-48c3-856a-93ea4794bd20'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','2e5b4686-2994-408c-9f83-5253a9f6b519'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','3617d1bf-003a-43ad-a326-106dac84f35b'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','3d9de2ca-6b6d-4a69-9c98-ac9e2f9a09a7'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','3db3eb61-2697-4e99-be2e-0d3c02280623'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','4911142d-4e12-4558-be5c-1d0acad7040d'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','495c0d43-cbbf-4d4b-b3c2-90700573ee82'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','4af56b6f-4c1f-4c5e-9177-79319031c165'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','4e5a2152-a238-4f6e-b3e9-99dc4f2a75ad'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','60679a05-fc5c-421e-8a93-cd1b486a7339'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','61dc0308-2944-41c7-aa7c-7947eb4a3378'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','67f222aa-09d3-41c7-b98e-dbf759ca12b0'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','6f3b19fb-58d2-4599-a5a6-f9f8ae4615ae'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','6ffc3252-52f2-4e42-95bb-0cf1099b483a'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','876f4c8d-7529-4dbb-9a76-50f809c3f051'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','88bd57f3-ba01-42ca-ba23-19a8d17859b0'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','88ec0067-0894-4b2a-8977-7d959df251b4'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','90f08915-fc94-494d-83a0-0001fb7d9f68'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','926a5fc8-bebe-41fd-ab19-36de50795aee'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','930c2545-bc41-496f-b029-3e119558d575'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','9c56c98b-db31-49d7-ab7b-ad71c25a4f0f'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','bdfea3da-368a-406d-940d-3d28b8effd4f'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','be613d02-5c89-4238-927e-a5b21c10f378'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','c1a6bbe3-3dd2-42f9-a5d4-b61f2dfa689a'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','c7d9abc0-d78a-45ba-9701-1ea390686a45'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','cdc77c06-8e2e-440c-9e2f-3280c9217b11'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','ce8ad27e-b605-471a-a97e-8ecc8abdc099'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','d6dfc4b4-8350-402c-81be-9aaa60f78a34'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','d8035c1b-ddd7-47f3-bede-7e656e5b3d02'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','d902477a-a855-4da3-8fa7-c1f87e440ca1'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','dddce5a0-04af-47b1-bb23-2a6174d2a9e4'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','ea4aed00-f222-4370-a8dc-704d805caded'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','ebcd850f-1565-4a76-a897-b8cf71dedf8a'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','ec9e2ddd-46fe-4295-8df5-8da181a7d306'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','f9992fcf-91f7-44ee-94cc-b7eb8cf4846d'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','fc6e2d0f-ad84-4a92-a00c-943a157ee101'),('930c2545-bc41-496f-b029-3e119558d575','11b9568f-ec8c-46b3-b60d-fa9d08f48526'),('930c2545-bc41-496f-b029-3e119558d575','6ffc3252-52f2-4e42-95bb-0cf1099b483a'),('93cbc3ab-eca0-4b66-b485-d51437da17e1','3600e588-edd7-46d5-ac1b-31611c6200ec'),('c49c5591-735e-404d-981d-3397fe86a285','0380bac2-9334-4974-b7ed-443c6a30f846'),('c49c5591-735e-404d-981d-3397fe86a285','0525e272-7c4e-409e-86a4-dff0689c5a89'),('c49c5591-735e-404d-981d-3397fe86a285','1573733c-b0a6-493a-8fcc-9f1ba2849091'),('c49c5591-735e-404d-981d-3397fe86a285','bfa6f46b-8eb5-4ff6-affb-cf3d0ef92362'),('ea4aed00-f222-4370-a8dc-704d805caded','d6dfc4b4-8350-402c-81be-9aaa60f78a34'),('fb053e21-a771-46e1-b25b-0042f5833cb7','4d0268db-a217-4c51-bcbc-d1b565dd4809');
/*!40000 ALTER TABLE `COMPOSITE_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREDENTIAL`
--

DROP TABLE IF EXISTS `CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_CREDENTIAL` (`USER_ID`),
  CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREDENTIAL`
--

LOCK TABLES `CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `CREDENTIAL` DISABLE KEYS */;
INSERT INTO `CREDENTIAL` VALUES ('29669c7f-ff07-4cb0-891c-d219f2e593f5',NULL,'password','7381f5c8-6fff-4c06-9e75-e1d18093df53',1726968670730,'My password','{\"value\":\"gckMbnU4+rvoecHnxF6KyjIpitZWn3YL2NnqYiBc7jY=\",\"salt\":\"KGycbq9I73pfozA+Rb3diA==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('81eb06a6-5b4e-43ce-a449-14c161803696',NULL,'password','087a0609-1a9b-46b8-90b2-3c217eee4db0',1726887664976,NULL,'{\"value\":\"25iANjNCAWiDdqE3376pU8EWO+l7Yi0YPoTF9hE1dW4=\",\"salt\":\"mgqWkNZgVDNIxdup/LuI5A==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('97800dfe-7dab-4fbe-9d3f-b13b1ccaae3b',NULL,'password','1e20e920-5043-468f-89f7-6e508bff1a38',1726968414560,'My password','{\"value\":\"WsCnzp484wjY3IK27rG+5lkiQUKuE2rVAUWs2U67ZZM=\",\"salt\":\"PTZvHJvinqLlHRUH/KsV4w==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('ea9b8590-b8e8-4be7-945e-b12b03fe610b',NULL,'password','66020b55-5ab8-4ba7-b1ad-27a9ed238a63',1726968590780,'My password','{\"value\":\"4Tdaewe6cABdntWa0UY9PIuyCOtOX2a+5wS2FDZuvNE=\",\"salt\":\"6h2DjwOr4r/xfPROxZTUig==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10);
/*!40000 ALTER TABLE `CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOG`
--

LOCK TABLES `DATABASECHANGELOG` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOG` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOG` VALUES ('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/jpa-changelog-1.0.0.Final.xml','2024-09-21 03:00:47',1,'EXECUTED','9:6f1016664e21e16d26517a4418f5e3df','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/db2-jpa-changelog-1.0.0.Final.xml','2024-09-21 03:00:47',2,'MARK_RAN','9:828775b1596a07d1200ba1d49e5e3941','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.1.0.Beta1','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Beta1.xml','2024-09-21 03:00:47',3,'EXECUTED','9:5f090e44a7d595883c1fb61f4b41fd38','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.1.0.Final','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Final.xml','2024-09-21 03:00:47',4,'EXECUTED','9:c07e577387a3d2c04d1adc9aaad8730e','renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.2.0.Beta1','psilva@redhat.com','META-INF/jpa-changelog-1.2.0.Beta1.xml','2024-09-21 03:00:48',5,'EXECUTED','9:b68ce996c655922dbcd2fe6b6ae72686','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.2.0.Beta1','psilva@redhat.com','META-INF/db2-jpa-changelog-1.2.0.Beta1.xml','2024-09-21 03:00:48',6,'MARK_RAN','9:543b5c9989f024fe35c6f6c5a97de88e','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.2.0.RC1','bburke@redhat.com','META-INF/jpa-changelog-1.2.0.CR1.xml','2024-09-21 03:00:49',7,'EXECUTED','9:765afebbe21cf5bbca048e632df38336','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.2.0.RC1','bburke@redhat.com','META-INF/db2-jpa-changelog-1.2.0.CR1.xml','2024-09-21 03:00:49',8,'MARK_RAN','9:db4a145ba11a6fdaefb397f6dbf829a1','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.2.0.Final','keycloak','META-INF/jpa-changelog-1.2.0.Final.xml','2024-09-21 03:00:49',9,'EXECUTED','9:9d05c7be10cdb873f8bcb41bc3a8ab23','update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.3.0','bburke@redhat.com','META-INF/jpa-changelog-1.3.0.xml','2024-09-21 03:00:50',10,'EXECUTED','9:18593702353128d53111f9b1ff0b82b8','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.4.0','bburke@redhat.com','META-INF/jpa-changelog-1.4.0.xml','2024-09-21 03:00:50',11,'EXECUTED','9:6122efe5f090e41a85c0f1c9e52cbb62','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.4.0','bburke@redhat.com','META-INF/db2-jpa-changelog-1.4.0.xml','2024-09-21 03:00:50',12,'MARK_RAN','9:e1ff28bf7568451453f844c5d54bb0b5','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.5.0','bburke@redhat.com','META-INF/jpa-changelog-1.5.0.xml','2024-09-21 03:00:50',13,'EXECUTED','9:7af32cd8957fbc069f796b61217483fd','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.6.1_from15','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-09-21 03:00:51',14,'EXECUTED','9:6005e15e84714cd83226bf7879f54190','addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.6.1_from16-pre','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-09-21 03:00:51',15,'MARK_RAN','9:bf656f5a2b055d07f314431cae76f06c','delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.6.1_from16','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-09-21 03:00:51',16,'MARK_RAN','9:f8dadc9284440469dcf71e25ca6ab99b','dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.6.1','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-09-21 03:00:51',17,'EXECUTED','9:d41d8cd98f00b204e9800998ecf8427e','empty','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.7.0','bburke@redhat.com','META-INF/jpa-changelog-1.7.0.xml','2024-09-21 03:00:51',18,'EXECUTED','9:3368ff0be4c2855ee2dd9ca813b38d8e','createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.8.0','mposolda@redhat.com','META-INF/jpa-changelog-1.8.0.xml','2024-09-21 03:00:52',19,'EXECUTED','9:8ac2fb5dd030b24c0570a763ed75ed20','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.8.0-2','keycloak','META-INF/jpa-changelog-1.8.0.xml','2024-09-21 03:00:52',20,'EXECUTED','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.8.0','mposolda@redhat.com','META-INF/db2-jpa-changelog-1.8.0.xml','2024-09-21 03:00:52',21,'MARK_RAN','9:831e82914316dc8a57dc09d755f23c51','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.8.0-2','keycloak','META-INF/db2-jpa-changelog-1.8.0.xml','2024-09-21 03:00:52',22,'MARK_RAN','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.9.0','mposolda@redhat.com','META-INF/jpa-changelog-1.9.0.xml','2024-09-21 03:00:52',23,'EXECUTED','9:bc3d0f9e823a69dc21e23e94c7a94bb1','update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.9.1','keycloak','META-INF/jpa-changelog-1.9.1.xml','2024-09-21 03:00:52',24,'EXECUTED','9:c9999da42f543575ab790e76439a2679','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.9.1','keycloak','META-INF/db2-jpa-changelog-1.9.1.xml','2024-09-21 03:00:52',25,'MARK_RAN','9:0d6c65c6f58732d81569e77b10ba301d','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('1.9.2','keycloak','META-INF/jpa-changelog-1.9.2.xml','2024-09-21 03:00:52',26,'EXECUTED','9:fc576660fc016ae53d2d4778d84d86d0','createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-2.0.0','psilva@redhat.com','META-INF/jpa-changelog-authz-2.0.0.xml','2024-09-21 03:00:53',27,'EXECUTED','9:43ed6b0da89ff77206289e87eaa9c024','createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-2.5.1','psilva@redhat.com','META-INF/jpa-changelog-authz-2.5.1.xml','2024-09-21 03:00:53',28,'EXECUTED','9:44bae577f551b3738740281eceb4ea70','update tableName=RESOURCE_SERVER_POLICY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.1.0-KEYCLOAK-5461','bburke@redhat.com','META-INF/jpa-changelog-2.1.0.xml','2024-09-21 03:00:53',29,'EXECUTED','9:bd88e1f833df0420b01e114533aee5e8','createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.2.0','bburke@redhat.com','META-INF/jpa-changelog-2.2.0.xml','2024-09-21 03:00:53',30,'EXECUTED','9:a7022af5267f019d020edfe316ef4371','addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.3.0','bburke@redhat.com','META-INF/jpa-changelog-2.3.0.xml','2024-09-21 03:00:54',31,'EXECUTED','9:fc155c394040654d6a79227e56f5e25a','createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.4.0','bburke@redhat.com','META-INF/jpa-changelog-2.4.0.xml','2024-09-21 03:00:54',32,'EXECUTED','9:eac4ffb2a14795e5dc7b426063e54d88','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.0','bburke@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-09-21 03:00:54',33,'EXECUTED','9:54937c05672568c4c64fc9524c1e9462','customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.0-unicode-oracle','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-09-21 03:00:54',34,'MARK_RAN','9:3a32bace77c84d7678d035a7f5a8084e','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.0-unicode-other-dbs','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-09-21 03:00:54',35,'EXECUTED','9:33d72168746f81f98ae3a1e8e0ca3554','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.0-duplicate-email-support','slawomir@dabek.name','META-INF/jpa-changelog-2.5.0.xml','2024-09-21 03:00:54',36,'EXECUTED','9:61b6d3d7a4c0e0024b0c839da283da0c','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.0-unique-group-names','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-09-21 03:00:54',37,'EXECUTED','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'6887645071'),('2.5.1','bburke@redhat.com','META-INF/jpa-changelog-2.5.1.xml','2024-09-21 03:00:54',38,'EXECUTED','9:a2b870802540cb3faa72098db5388af3','addColumn tableName=FED_USER_CONSENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.0.0','bburke@redhat.com','META-INF/jpa-changelog-3.0.0.xml','2024-09-21 03:00:54',39,'EXECUTED','9:132a67499ba24bcc54fb5cbdcfe7e4c0','addColumn tableName=IDENTITY_PROVIDER','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.2.0-fix','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-09-21 03:00:54',40,'MARK_RAN','9:938f894c032f5430f2b0fafb1a243462','addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.2.0-fix-with-keycloak-5416','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-09-21 03:00:54',41,'MARK_RAN','9:845c332ff1874dc5d35974b0babf3006','dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.2.0-fix-offline-sessions','hmlnarik','META-INF/jpa-changelog-3.2.0.xml','2024-09-21 03:00:54',42,'EXECUTED','9:fc86359c079781adc577c5a217e4d04c','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.2.0-fixed','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-09-21 03:00:55',43,'EXECUTED','9:59a64800e3c0d09b825f8a3b444fa8f4','addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.3.0','keycloak','META-INF/jpa-changelog-3.3.0.xml','2024-09-21 03:00:55',44,'EXECUTED','9:d48d6da5c6ccf667807f633fe489ce88','addColumn tableName=USER_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-3.4.0.CR1-resource-server-pk-change-part1','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-09-21 03:00:55',45,'EXECUTED','9:dde36f7973e80d71fceee683bc5d2951','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-09-21 03:00:55',46,'EXECUTED','9:b855e9b0a406b34fa323235a0cf4f640','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-09-21 03:00:55',47,'MARK_RAN','9:51abbacd7b416c50c4421a8cabf7927e','dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-09-21 03:00:56',48,'EXECUTED','9:bdc99e567b3398bac83263d375aad143','addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authn-3.4.0.CR1-refresh-token-max-reuse','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-09-21 03:00:56',49,'EXECUTED','9:d198654156881c46bfba39abd7769e69','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.4.0','keycloak','META-INF/jpa-changelog-3.4.0.xml','2024-09-21 03:00:56',50,'EXECUTED','9:cfdd8736332ccdd72c5256ccb42335db','addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.4.0-KEYCLOAK-5230','hmlnarik@redhat.com','META-INF/jpa-changelog-3.4.0.xml','2024-09-21 03:00:57',51,'EXECUTED','9:7c84de3d9bd84d7f077607c1a4dcb714','createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.4.1','psilva@redhat.com','META-INF/jpa-changelog-3.4.1.xml','2024-09-21 03:00:57',52,'EXECUTED','9:5a6bb36cbefb6a9d6928452c0852af2d','modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.4.2','keycloak','META-INF/jpa-changelog-3.4.2.xml','2024-09-21 03:00:57',53,'EXECUTED','9:8f23e334dbc59f82e0a328373ca6ced0','update tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('3.4.2-KEYCLOAK-5172','mkanis@redhat.com','META-INF/jpa-changelog-3.4.2.xml','2024-09-21 03:00:57',54,'EXECUTED','9:9156214268f09d970cdf0e1564d866af','update tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.0.0-KEYCLOAK-6335','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-09-21 03:00:57',55,'EXECUTED','9:db806613b1ed154826c02610b7dbdf74','createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.0.0-CLEANUP-UNUSED-TABLE','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-09-21 03:00:57',56,'EXECUTED','9:229a041fb72d5beac76bb94a5fa709de','dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.0.0-KEYCLOAK-6228','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-09-21 03:00:57',57,'EXECUTED','9:079899dade9c1e683f26b2aa9ca6ff04','dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.0.0-KEYCLOAK-5579-fixed','mposolda@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-09-21 03:00:58',58,'EXECUTED','9:139b79bcbbfe903bb1c2d2a4dbf001d9','dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-4.0.0.CR1','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.CR1.xml','2024-09-21 03:00:58',59,'EXECUTED','9:b55738ad889860c625ba2bf483495a04','createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-4.0.0.Beta3','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.Beta3.xml','2024-09-21 03:00:58',60,'EXECUTED','9:e0057eac39aa8fc8e09ac6cfa4ae15fe','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-4.2.0.Final','mhajas@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2024-09-21 03:00:58',61,'EXECUTED','9:42a33806f3a0443fe0e7feeec821326c','createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-4.2.0.Final-KEYCLOAK-9944','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2024-09-21 03:00:58',62,'EXECUTED','9:9968206fca46eecc1f51db9c024bfe56','addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.2.0-KEYCLOAK-6313','wadahiro@gmail.com','META-INF/jpa-changelog-4.2.0.xml','2024-09-21 03:00:58',63,'EXECUTED','9:92143a6daea0a3f3b8f598c97ce55c3d','addColumn tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.3.0-KEYCLOAK-7984','wadahiro@gmail.com','META-INF/jpa-changelog-4.3.0.xml','2024-09-21 03:00:58',64,'EXECUTED','9:82bab26a27195d889fb0429003b18f40','update tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.6.0-KEYCLOAK-7950','psilva@redhat.com','META-INF/jpa-changelog-4.6.0.xml','2024-09-21 03:00:58',65,'EXECUTED','9:e590c88ddc0b38b0ae4249bbfcb5abc3','update tableName=RESOURCE_SERVER_RESOURCE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.6.0-KEYCLOAK-8377','keycloak','META-INF/jpa-changelog-4.6.0.xml','2024-09-21 03:00:58',66,'EXECUTED','9:5c1f475536118dbdc38d5d7977950cc0','createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.6.0-KEYCLOAK-8555','gideonray@gmail.com','META-INF/jpa-changelog-4.6.0.xml','2024-09-21 03:00:58',67,'EXECUTED','9:e7c9f5f9c4d67ccbbcc215440c718a17','createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.7.0-KEYCLOAK-1267','sguilhen@redhat.com','META-INF/jpa-changelog-4.7.0.xml','2024-09-21 03:00:58',68,'EXECUTED','9:88e0bfdda924690d6f4e430c53447dd5','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.7.0-KEYCLOAK-7275','keycloak','META-INF/jpa-changelog-4.7.0.xml','2024-09-21 03:00:59',69,'EXECUTED','9:f53177f137e1c46b6a88c59ec1cb5218','renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('4.8.0-KEYCLOAK-8835','sguilhen@redhat.com','META-INF/jpa-changelog-4.8.0.xml','2024-09-21 03:00:59',70,'EXECUTED','9:a74d33da4dc42a37ec27121580d1459f','addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'6887645071'),('authz-7.0.0-KEYCLOAK-10443','psilva@redhat.com','META-INF/jpa-changelog-authz-7.0.0.xml','2024-09-21 03:00:59',71,'EXECUTED','9:fd4ade7b90c3b67fae0bfcfcb42dfb5f','addColumn tableName=RESOURCE_SERVER','',NULL,'4.25.1',NULL,NULL,'6887645071'),('8.0.0-adding-credential-columns','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-09-21 03:00:59',72,'EXECUTED','9:aa072ad090bbba210d8f18781b8cebf4','addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('8.0.0-updating-credential-data-not-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-09-21 03:00:59',73,'EXECUTED','9:1ae6be29bab7c2aa376f6983b932be37','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('8.0.0-updating-credential-data-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-09-21 03:00:59',74,'MARK_RAN','9:14706f286953fc9a25286dbd8fb30d97','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('8.0.0-credential-cleanup-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-09-21 03:00:59',75,'EXECUTED','9:2b9cc12779be32c5b40e2e67711a218b','dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('8.0.0-resource-tag-support','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-09-21 03:00:59',76,'EXECUTED','9:91fa186ce7a5af127a2d7a91ee083cc5','addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.0-always-display-client','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-09-21 03:00:59',77,'EXECUTED','9:6335e5c94e83a2639ccd68dd24e2e5ad','addColumn tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.0-drop-constraints-for-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-09-21 03:00:59',78,'MARK_RAN','9:6bdb5658951e028bfe16fa0a8228b530','dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.0-increase-column-size-federated-fk','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-09-21 03:00:59',79,'EXECUTED','9:d5bc15a64117ccad481ce8792d4c608f','modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.0-recreate-constraints-after-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-09-21 03:00:59',80,'MARK_RAN','9:077cba51999515f4d3e7ad5619ab592c','addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.1-add-index-to-client.client_id','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-09-21 03:00:59',81,'EXECUTED','9:be969f08a163bf47c6b9e9ead8ac2afb','createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.1-KEYCLOAK-12579-drop-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-09-21 03:00:59',82,'MARK_RAN','9:6d3bb4408ba5a72f39bd8a0b301ec6e3','dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.1-KEYCLOAK-12579-add-not-null-constraint','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-09-21 03:00:59',83,'EXECUTED','9:966bda61e46bebf3cc39518fbed52fa7','addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.1-KEYCLOAK-12579-recreate-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-09-21 03:00:59',84,'MARK_RAN','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'6887645071'),('9.0.1-add-index-to-events','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-09-21 03:00:59',85,'EXECUTED','9:7d93d602352a30c0c317e6a609b56599','createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('map-remove-ri','keycloak','META-INF/jpa-changelog-11.0.0.xml','2024-09-21 03:00:59',86,'EXECUTED','9:71c5969e6cdd8d7b6f47cebc86d37627','dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9','',NULL,'4.25.1',NULL,NULL,'6887645071'),('map-remove-ri','keycloak','META-INF/jpa-changelog-12.0.0.xml','2024-09-21 03:01:00',87,'EXECUTED','9:a9ba7d47f065f041b7da856a81762021','dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('12.1.0-add-realm-localization-table','keycloak','META-INF/jpa-changelog-12.0.0.xml','2024-09-21 03:01:00',88,'EXECUTED','9:fffabce2bc01e1a8f5110d5278500065','createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS','',NULL,'4.25.1',NULL,NULL,'6887645071'),('default-roles','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',89,'EXECUTED','9:fa8a5b5445e3857f4b010bafb5009957','addColumn tableName=REALM; customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('default-roles-cleanup','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',90,'EXECUTED','9:67ac3241df9a8582d591c5ed87125f39','dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('13.0.0-KEYCLOAK-16844','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',91,'EXECUTED','9:ad1194d66c937e3ffc82386c050ba089','createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('map-remove-ri-13.0.0','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',92,'EXECUTED','9:d9be619d94af5a2f5d07b9f003543b91','dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('13.0.0-KEYCLOAK-17992-drop-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',93,'MARK_RAN','9:544d201116a0fcc5a5da0925fbbc3bde','dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('13.0.0-increase-column-size-federated','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',94,'EXECUTED','9:43c0c1055b6761b4b3e89de76d612ccf','modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.25.1',NULL,NULL,'6887645071'),('13.0.0-KEYCLOAK-17992-recreate-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',95,'MARK_RAN','9:8bd711fd0330f4fe980494ca43ab1139','addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('json-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-09-21 03:01:00',96,'EXECUTED','9:e07d2bc0970c348bb06fb63b1f82ddbf','addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('14.0.0-KEYCLOAK-11019','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',97,'EXECUTED','9:24fb8611e97f29989bea412aa38d12b7','createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('14.0.0-KEYCLOAK-18286','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',98,'MARK_RAN','9:259f89014ce2506ee84740cbf7163aa7','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('14.0.0-KEYCLOAK-18286-revert','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',99,'MARK_RAN','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('14.0.0-KEYCLOAK-18286-supported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',100,'EXECUTED','9:bd2bd0fc7768cf0845ac96a8786fa735','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('14.0.0-KEYCLOAK-18286-unsupported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',101,'MARK_RAN','9:d3d977031d431db16e2c181ce49d73e9','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('KEYCLOAK-17267-add-index-to-user-attributes','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',102,'EXECUTED','9:0b305d8d1277f3a89a0a53a659ad274c','createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('KEYCLOAK-18146-add-saml-art-binding-identifier','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-09-21 03:01:00',103,'EXECUTED','9:2c374ad2cdfe20e2905a84c8fac48460','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('15.0.0-KEYCLOAK-18467','keycloak','META-INF/jpa-changelog-15.0.0.xml','2024-09-21 03:01:00',104,'EXECUTED','9:47a760639ac597360a8219f5b768b4de','addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('17.0.0-9562','keycloak','META-INF/jpa-changelog-17.0.0.xml','2024-09-21 03:01:00',105,'EXECUTED','9:a6272f0576727dd8cad2522335f5d99e','createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('18.0.0-10625-IDX_ADMIN_EVENT_TIME','keycloak','META-INF/jpa-changelog-18.0.0.xml','2024-09-21 03:01:00',106,'EXECUTED','9:015479dbd691d9cc8669282f4828c41d','createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('19.0.0-10135','keycloak','META-INF/jpa-changelog-19.0.0.xml','2024-09-21 03:01:00',107,'EXECUTED','9:9518e495fdd22f78ad6425cc30630221','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('20.0.0-12964-supported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-09-21 03:01:00',108,'EXECUTED','9:f2e1331a71e0aa85e5608fe42f7f681c','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('20.0.0-12964-unsupported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-09-21 03:01:00',109,'MARK_RAN','9:1a6fcaa85e20bdeae0a9ce49b41946a5','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'6887645071'),('client-attributes-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-09-21 03:01:00',110,'EXECUTED','9:3f332e13e90739ed0c35b0b25b7822ca','addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('21.0.2-17277','keycloak','META-INF/jpa-changelog-21.0.2.xml','2024-09-21 03:01:00',111,'EXECUTED','9:7ee1f7a3fb8f5588f171fb9a6ab623c0','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('21.1.0-19404','keycloak','META-INF/jpa-changelog-21.1.0.xml','2024-09-21 03:01:00',112,'EXECUTED','9:3d7e830b52f33676b9d64f7f2b2ea634','modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER','',NULL,'4.25.1',NULL,NULL,'6887645071'),('21.1.0-19404-2','keycloak','META-INF/jpa-changelog-21.1.0.xml','2024-09-21 03:01:00',113,'MARK_RAN','9:627d032e3ef2c06c0e1f73d2ae25c26c','addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('22.0.0-17484-updated','keycloak','META-INF/jpa-changelog-22.0.0.xml','2024-09-21 03:01:00',114,'EXECUTED','9:90af0bfd30cafc17b9f4d6eccd92b8b3','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('22.0.5-24031','keycloak','META-INF/jpa-changelog-22.0.0.xml','2024-09-21 03:01:00',115,'MARK_RAN','9:a60d2d7b315ec2d3eba9e2f145f9df28','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('23.0.0-12062','keycloak','META-INF/jpa-changelog-23.0.0.xml','2024-09-21 03:01:00',116,'EXECUTED','9:2168fbe728fec46ae9baf15bf80927b8','addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG','',NULL,'4.25.1',NULL,NULL,'6887645071'),('23.0.0-17258','keycloak','META-INF/jpa-changelog-23.0.0.xml','2024-09-21 03:01:00',117,'EXECUTED','9:36506d679a83bbfda85a27ea1864dca8','addColumn tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.0-9758','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-09-21 03:01:00',118,'EXECUTED','9:502c557a5189f600f0f445a9b49ebbce','addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.0-9758-2','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-09-21 03:01:00',119,'EXECUTED','9:bf0fdee10afdf597a987adbf291db7b2','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.0-26618-drop-index-if-present','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-09-21 03:01:00',120,'EXECUTED','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.0-26618-reindex','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-09-21 03:01:00',121,'EXECUTED','9:bd2bd0fc7768cf0845ac96a8786fa735','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.2-27228','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-09-21 03:01:00',122,'EXECUTED','9:eaee11f6b8aa25d2cc6a84fb86fc6238','customChange','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.2-27967-drop-index-if-present','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-09-21 03:01:00',123,'MARK_RAN','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('24.0.2-27967-reindex','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-09-21 03:01:00',124,'MARK_RAN','9:d3d977031d431db16e2c181ce49d73e9','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28265-tables','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',125,'EXECUTED','9:deda2df035df23388af95bbd36c17cef','addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28265-index-creation','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',126,'EXECUTED','9:3e96709818458ae49f3c679ae58d263a','createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28265-index-cleanup','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',127,'EXECUTED','9:8c0cfa341a0474385b324f5c4b2dfcc1','dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28265-index-2-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',128,'EXECUTED','9:b7ef76036d3126bb83c2423bf4d449d6','createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28265-index-2-not-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',129,'MARK_RAN','9:23396cf51ab8bc1ae6f0cac7f9f6fcf7','createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-org','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:00',130,'EXECUTED','9:5c859965c2c9b9c72136c360649af157','createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN','',NULL,'4.25.1',NULL,NULL,'6887645071'),('unique-consentuser','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:01',131,'MARK_RAN','9:5857626a2ea8767e9a6c66bf3a2cb32f','customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('unique-consentuser-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:01',132,'EXECUTED','9:b79478aad5adaa1bc428e31563f55e8e','customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...','',NULL,'4.25.1',NULL,NULL,'6887645071'),('25.0.0-28861-index-creation','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-09-21 03:01:01',133,'EXECUTED','9:b9acb58ac958d9ada0fe12a5d4794ab1','createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET','',NULL,'4.25.1',NULL,NULL,'6887645071');
/*!40000 ALTER TABLE `DATABASECHANGELOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

LOCK TABLES `DATABASECHANGELOGLOCK` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOGLOCK` VALUES (1,0,NULL,NULL),(1000,0,NULL,NULL);
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `DEFAULT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

LOCK TABLES `DEFAULT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `DEFAULT_CLIENT_SCOPE` VALUES ('19363c62-1a5c-4117-9fae-ba3b727d853b','06a134bd-f48c-4f12-9862-a373ffc01b8d',0),('19363c62-1a5c-4117-9fae-ba3b727d853b','0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','0f3e68d6-1283-4372-b94d-b298d57a9d71',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','1bc6cbd0-b494-427c-829f-3f3453414fc1',0),('19363c62-1a5c-4117-9fae-ba3b727d853b','1e6d9026-f424-498e-8cfa-ebffd7bfe8cd',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','33221937-d60d-4dbf-8e8e-24ee511d1cf5',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','3f8487a3-18f6-4083-b97c-6ba4bdfb733e',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','568ce12a-5da9-4133-a449-5739b248f2c3',0),('19363c62-1a5c-4117-9fae-ba3b727d853b','61899695-a74e-4fed-8f55-3eebe172ccae',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','d2574f87-b99e-4063-9e4e-61dc402d29bd',1),('19363c62-1a5c-4117-9fae-ba3b727d853b','fde87468-6b6a-44bf-8bfe-a50307d48503',0),('3c25345a-35d9-4d22-8a17-4e83429890aa','2f8ecb94-51cc-4aba-a499-9980e36a0eee',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','3ab6aa0f-a306-43a5-b851-73dcc6f32d19',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','581b235a-1436-42f6-859c-1c46a4d9d0e5',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','77f6aab1-618b-4d04-b313-72589b56f29a',0),('3c25345a-35d9-4d22-8a17-4e83429890aa','7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60',0),('3c25345a-35d9-4d22-8a17-4e83429890aa','9a96049d-d83d-4869-bcd4-a151f65fc834',0),('3c25345a-35d9-4d22-8a17-4e83429890aa','a6e6271f-06dc-4139-abab-47aafdfb1b62',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','a9189396-32e8-4d5d-8a71-ada6b0d50b6d',0),('3c25345a-35d9-4d22-8a17-4e83429890aa','b140af73-cb59-4d5a-91f9-c636860fa833',1),('3c25345a-35d9-4d22-8a17-4e83429890aa','def7cea9-d336-4ab9-a072-627894ded673',1);
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENT_ENTITY`
--

DROP TABLE IF EXISTS `EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON_LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENT_ENTITY`
--

LOCK TABLES `EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_IDENTITY`
--

DROP TABLE IF EXISTS `FEDERATED_IDENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`),
  CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_IDENTITY`
--

LOCK TABLES `FEDERATED_IDENTITY` WRITE;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_USER`
--

DROP TABLE IF EXISTS `FEDERATED_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_USER`
--

LOCK TABLES `FEDERATED_USER` WRITE;
/*!40000 ALTER TABLE `FEDERATED_USER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `FED_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` text,
  `LONG_VALUE_HASH` binary(64) DEFAULT NULL,
  `LONG_VALUE_HASH_LOWER_CASE` binary(64) DEFAULT NULL,
  `LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`),
  KEY `FED_USER_ATTR_LONG_VALUES` (`LONG_VALUE_HASH`,`NAME`),
  KEY `FED_USER_ATTR_LONG_VALUES_LOWER_CASE` (`LONG_VALUE_HASH_LOWER_CASE`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ATTRIBUTE`
--

LOCK TABLES `FED_USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT`
--

LOCK TABLES `FED_USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT_CL_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT_CL_SCOPE`
--

LOCK TABLES `FED_USER_CONSENT_CL_SCOPE` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

DROP TABLE IF EXISTS `FED_USER_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CREDENTIAL`
--

LOCK TABLES `FED_USER_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `FED_USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `FED_USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `FED_USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_REQUIRED_ACTION`
--

LOCK TABLES `FED_USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `FED_USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ROLE_MAPPING`
--

LOCK TABLES `FED_USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

DROP TABLE IF EXISTS `GROUP_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`),
  KEY `IDX_GROUP_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`),
  CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

LOCK TABLES `GROUP_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `GROUP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

LOCK TABLES `GROUP_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` tinyint NOT NULL DEFAULT '0',
  `AUTHENTICATE_BY_DEFAULT` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` tinyint NOT NULL DEFAULT '1',
  `TRUST_EMAIL` tinyint NOT NULL DEFAULT '0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`INTERNAL_ID`),
  UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

LOCK TABLES `IDENTITY_PROVIDER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

LOCK TABLES `IDENTITY_PROVIDER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_MAPPER`
--

LOCK TABLES `IDENTITY_PROVIDER_MAPPER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `IDP_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDP_MAPPER_CONFIG`
--

LOCK TABLES `IDP_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_GROUP`
--

DROP TABLE IF EXISTS `KEYCLOAK_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

LOCK TABLES `KEYCLOAK_GROUP` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` DISABLE KEYS */;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_ROLE`
--

DROP TABLE IF EXISTS `KEYCLOAK_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` tinyint DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`),
  CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

LOCK TABLES `KEYCLOAK_ROLE` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_ROLE` VALUES ('0380bac2-9334-4974-b7ed-443c6a30f846','3c25345a-35d9-4d22-8a17-4e83429890aa',0,'${role_uma_authorization}','uma_authorization','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL,NULL),('03fc3703-b8fb-4d62-ad8b-04c22f250284','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_query-clients}','query-clients','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('0423dac2-5001-4f7d-933c-f61c90eb0896','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-events}','manage-events','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('0525e272-7c4e-409e-86a4-dff0689c5a89','3c25345a-35d9-4d22-8a17-4e83429890aa',0,'${role_offline-access}','offline_access','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL,NULL),('05f7f5c9-c89c-44fb-92b2-c72020f00838','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_view-profile}','view-profile','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('066d5aca-cb39-472b-baaa-8e57879280ed','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-identity-providers}','view-identity-providers','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('0b091e89-197c-49a8-ac92-69814f5c9da8','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-authorization}','view-authorization','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('10b38fec-37a6-4492-b430-8a9fb3a87654','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-realm}','manage-realm','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('11b9568f-ec8c-46b3-b60d-fa9d08f48526','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_query-users}','query-users','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('13b81f2d-f9d9-4d79-ba28-cb73604e33be','19363c62-1a5c-4117-9fae-ba3b727d853b',0,'${role_default-roles}','default-roles-master','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,NULL),('15449178-4824-40d6-aac9-8e7cbcffb357','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_delete-account}','delete-account','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('1573733c-b0a6-493a-8fcc-9f1ba2849091','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_manage-account}','manage-account','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('1c5f2efe-565e-4e3c-ae19-e7136b4d35bb','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-clients}','view-clients','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('24cfe5e5-bf8b-41d7-92f4-7b948dc777b9','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_view-groups}','view-groups','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('27a740b9-3d18-48c3-856a-93ea4794bd20','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_create-client}','create-client','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('28239c06-a659-4e14-ac20-c1f72cb76406','19363c62-1a5c-4117-9fae-ba3b727d853b',0,'${role_offline-access}','offline_access','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,NULL),('2e5b4686-2994-408c-9f83-5253a9f6b519','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_create-client}','create-client','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('3600e588-edd7-46d5-ac1b-31611c6200ec','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_view-consent}','view-consent','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('3617d1bf-003a-43ad-a326-106dac84f35b','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-events}','manage-events','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('3d9de2ca-6b6d-4a69-9c98-ac9e2f9a09a7','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-clients}','manage-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('3db3eb61-2697-4e99-be2e-0d3c02280623','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-identity-providers}','manage-identity-providers','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('425879f8-bf1e-4028-a143-b80308791715','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_manage-account}','manage-account','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('4911142d-4e12-4558-be5c-1d0acad7040d','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-clients}','view-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('495c0d43-cbbf-4d4b-b3c2-90700573ee82','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-identity-providers}','manage-identity-providers','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('4af56b6f-4c1f-4c5e-9177-79319031c165','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-identity-providers}','view-identity-providers','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('4c9fd84a-ed41-4051-a971-e0b13153c5a4','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_delete-account}','delete-account','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('4d0268db-a217-4c51-bcbc-d1b565dd4809','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_view-consent}','view-consent','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('4e5a2152-a238-4f6e-b3e9-99dc4f2a75ad','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_query-realms}','query-realms','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('50158605-9a40-42b2-b9db-357a93e7b281','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_view-applications}','view-applications','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('5b548dfa-c0cf-46f3-98e2-1edc8ab99683','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-clients}','manage-clients','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('5c063bd7-7d55-431c-a056-976835c1e27e','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_realm-admin}','realm-admin','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('60679a05-fc5c-421e-8a93-cd1b486a7339','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-events}','manage-events','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('61dc0308-2944-41c7-aa7c-7947eb4a3378','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-users}','view-users','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('67618e6f-560f-4c1b-9dc5-724122eb7bd0','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_view-groups}','view-groups','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('67f222aa-09d3-41c7-b98e-dbf759ca12b0','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-authorization}','view-authorization','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('67f29e75-d90d-4e3a-93c9-2be20410f07c','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-users}','view-users','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('6f3b19fb-58d2-4599-a5a6-f9f8ae4615ae','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_query-users}','query-users','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('6ffc3252-52f2-4e42-95bb-0cf1099b483a','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_query-groups}','query-groups','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('7b59bf65-77ab-4580-9258-10a341b0703a','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_manage-account-links}','manage-account-links','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('7e0604e8-b3ef-415f-9071-c7b20ff69529','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-identity-providers}','manage-identity-providers','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('7e25b9d4-6ba0-4abb-abc7-50ae35133e75','a828b895-022f-4654-91d4-aa5301e19e5c',1,'${role_read-token}','read-token','3c25345a-35d9-4d22-8a17-4e83429890aa','a828b895-022f-4654-91d4-aa5301e19e5c',NULL),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','19363c62-1a5c-4117-9fae-ba3b727d853b',0,'${role_admin}','admin','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,NULL),('876f4c8d-7529-4dbb-9a76-50f809c3f051','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_impersonation}','impersonation','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('88bd57f3-ba01-42ca-ba23-19a8d17859b0','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-authorization}','view-authorization','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('88ec0067-0894-4b2a-8977-7d959df251b4','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-authorization}','manage-authorization','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('89d566a2-ba8b-4816-8a56-6a77d0bb626e','3c25345a-35d9-4d22-8a17-4e83429890aa',0,'','ADMIN','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL,NULL),('90f08915-fc94-494d-83a0-0001fb7d9f68','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-realm}','manage-realm','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('91ab80f5-9231-4f8e-84d9-67d38da20041','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_view-applications}','view-applications','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('926a5fc8-bebe-41fd-ab19-36de50795aee','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-events}','view-events','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('930c2545-bc41-496f-b029-3e119558d575','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-users}','view-users','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('93cbc3ab-eca0-4b66-b485-d51437da17e1','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',1,'${role_manage-consent}','manage-consent','19363c62-1a5c-4117-9fae-ba3b727d853b','a6b398ae-b0b0-4b78-adf0-fc237f24d7ae',NULL),('99e7633d-edc9-414a-9bb1-f800082b4fe1','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_create-client}','create-client','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('9af2d538-b680-446d-8414-0369451e4168','8af70cb8-c413-45df-ad9e-f245b5138256',1,'${role_read-token}','read-token','19363c62-1a5c-4117-9fae-ba3b727d853b','8af70cb8-c413-45df-ad9e-f245b5138256',NULL),('9c56c98b-db31-49d7-ab7b-ad71c25a4f0f','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-users}','manage-users','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('a2c6ec86-213e-4040-aa06-8e64cbab07a8','3c25345a-35d9-4d22-8a17-4e83429890aa',0,'','USER','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL,NULL),('a89f9516-c318-4ee2-add6-f8c2a77d61d5','19363c62-1a5c-4117-9fae-ba3b727d853b',0,'${role_uma_authorization}','uma_authorization','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,NULL),('b3ab3907-77d0-4e6c-9800-90cba094c4cd','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_query-realms}','query-realms','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('b767b2aa-e387-4929-8658-27ad703a025c','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-realm}','view-realm','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('bdfea3da-368a-406d-940d-3d28b8effd4f','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_query-groups}','query-groups','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('be613d02-5c89-4238-927e-a5b21c10f378','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-realm}','manage-realm','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('bfa6f46b-8eb5-4ff6-affb-cf3d0ef92362','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_view-profile}','view-profile','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('c1a6bbe3-3dd2-42f9-a5d4-b61f2dfa689a','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_query-realms}','query-realms','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('c2727717-c3bd-4615-831e-b99ff015787b','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_impersonation}','impersonation','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('c49c5591-735e-404d-981d-3397fe86a285','3c25345a-35d9-4d22-8a17-4e83429890aa',0,'${role_default-roles}','default-roles-microservices-motorsport-predictor-realm','3c25345a-35d9-4d22-8a17-4e83429890aa',NULL,NULL),('c7d9abc0-d78a-45ba-9701-1ea390686a45','19363c62-1a5c-4117-9fae-ba3b727d853b',0,'${role_create-realm}','create-realm','19363c62-1a5c-4117-9fae-ba3b727d853b',NULL,NULL),('c9e91a92-a2ab-4d61-91af-17b4dd2506f5','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_query-users}','query-users','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('ccd52767-5784-4ae8-b140-d6ca958170ee','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_manage-account-links}','manage-account-links','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('cdc77c06-8e2e-440c-9e2f-3280c9217b11','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_impersonation}','impersonation','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('ce8ad27e-b605-471a-a97e-8ecc8abdc099','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-realm}','view-realm','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('cfec7e47-0c74-4362-8268-edc6693a08a5','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-users}','manage-users','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('d6dfc4b4-8350-402c-81be-9aaa60f78a34','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_query-clients}','query-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('d8035c1b-ddd7-47f3-bede-7e656e5b3d02','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_query-clients}','query-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('d902477a-a855-4da3-8fa7-c1f87e440ca1','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-users}','manage-users','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('dddce5a0-04af-47b1-bb23-2a6174d2a9e4','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-identity-providers}','view-identity-providers','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('e40a7d59-22a8-47ca-a18b-dc1b94768f4d','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_query-groups}','query-groups','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('ea4aed00-f222-4370-a8dc-704d805caded','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-clients}','view-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('ebcd850f-1565-4a76-a897-b8cf71dedf8a','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_view-realm}','view-realm','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('ec9e2ddd-46fe-4295-8df5-8da181a7d306','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_view-events}','view-events','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL),('f139478e-cd35-4c54-8663-0d5048475149','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_view-events}','view-events','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('f67a838e-73dc-4fa5-9abe-dc68290df335','5552bdfa-1799-4e2b-84d7-98d39e4d2681',1,'${role_manage-authorization}','manage-authorization','3c25345a-35d9-4d22-8a17-4e83429890aa','5552bdfa-1799-4e2b-84d7-98d39e4d2681',NULL),('f91ae09c-64cf-4f44-8eb6-e59b46b5fa37','a15827b2-d57e-4a4c-8a7d-275070cf48e3',1,NULL,'uma_protection','3c25345a-35d9-4d22-8a17-4e83429890aa','a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL),('f9992fcf-91f7-44ee-94cc-b7eb8cf4846d','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1,'${role_manage-authorization}','manage-authorization','19363c62-1a5c-4117-9fae-ba3b727d853b','f50f6f25-d0d1-41e8-9d55-a664f3721a2a',NULL),('fb053e21-a771-46e1-b25b-0042f5833cb7','58f0a2c6-bc80-4405-814a-e273716d5334',1,'${role_manage-consent}','manage-consent','3c25345a-35d9-4d22-8a17-4e83429890aa','58f0a2c6-bc80-4405-814a-e273716d5334',NULL),('fc6e2d0f-ad84-4a92-a00c-943a157ee101','c327f9c6-48eb-4f34-88cc-937e511bee44',1,'${role_manage-clients}','manage-clients','19363c62-1a5c-4117-9fae-ba3b727d853b','c327f9c6-48eb-4f34-88cc-937e511bee44',NULL);
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIGRATION_MODEL`
--

DROP TABLE IF EXISTS `MIGRATION_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIGRATION_MODEL`
--

LOCK TABLES `MIGRATION_MODEL` WRITE;
/*!40000 ALTER TABLE `MIGRATION_MODEL` DISABLE KEYS */;
INSERT INTO `MIGRATION_MODEL` VALUES ('qdsv6','25.0.1',1726887661);
/*!40000 ALTER TABLE `MIGRATION_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `DATA` longtext,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local',
  `VERSION` int DEFAULT '0',
  PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_CLIENT_SESSION`
--

LOCK TABLES `OFFLINE_CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext,
  `LAST_SESSION_REFRESH` int NOT NULL DEFAULT '0',
  `BROKER_SESSION_ID` text,
  `VERSION` int DEFAULT '0',
  PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_USER` (`USER_ID`,`REALM_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH` (`REALM_ID`,`OFFLINE_FLAG`,`LAST_SESSION_REFRESH`),
  KEY `IDX_OFFLINE_USS_BY_BROKER_SESSION_ID` (`BROKER_SESSION_ID`(255),`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_USER_SESSION`
--

LOCK TABLES `OFFLINE_USER_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORG`
--

DROP TABLE IF EXISTS `ORG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORG` (
  `ID` varchar(255) NOT NULL,
  `ENABLED` tinyint NOT NULL,
  `REALM_ID` varchar(255) NOT NULL,
  `GROUP_ID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORG_NAME` (`REALM_ID`,`NAME`),
  UNIQUE KEY `UK_ORG_GROUP` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORG`
--

LOCK TABLES `ORG` WRITE;
/*!40000 ALTER TABLE `ORG` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORG_DOMAIN`
--

DROP TABLE IF EXISTS `ORG_DOMAIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORG_DOMAIN` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VERIFIED` tinyint NOT NULL,
  `ORG_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORG_DOMAIN`
--

LOCK TABLES `ORG_DOMAIN` WRITE;
/*!40000 ALTER TABLE `ORG_DOMAIN` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORG_DOMAIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLICY_CONFIG`
--

DROP TABLE IF EXISTS `POLICY_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`POLICY_ID`,`NAME`),
  CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLICY_CONFIG`
--

LOCK TABLES `POLICY_CONFIG` WRITE;
/*!40000 ALTER TABLE `POLICY_CONFIG` DISABLE KEYS */;
INSERT INTO `POLICY_CONFIG` VALUES ('4d34da98-a7f0-441c-89f7-8db12340d69b','defaultResourceType','urn:microservices-motorsport-client:resources:default'),('a88d9095-4c8a-4e96-8161-46543351172a','code','// by default, grants any permission associated with this policy\n$evaluation.grant();\n');
/*!40000 ALTER TABLE `POLICY_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`),
  CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

LOCK TABLES `PROTOCOL_MAPPER` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER` VALUES ('050d83a2-b1e4-4564-a086-aff826eb8447','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('076b640a-f962-4fa8-b5b1-7b0e1743c7d5','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'0f3e68d6-1283-4372-b94d-b298d57a9d71'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('11c454e2-e357-4447-a32c-55a9e661e80d','full name','openid-connect','oidc-full-name-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('164b1a15-a6de-4fd9-b011-09e1656a7b1d','acr loa level','openid-connect','oidc-acr-mapper',NULL,'1e6d9026-f424-498e-8cfa-ebffd7bfe8cd'),('18b20790-d846-474c-93fd-960d026b41be','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('201b7f43-71dd-4920-a202-783cf1b3f683','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','auth_time','openid-connect','oidc-usersessionmodel-note-mapper',NULL,'def7cea9-d336-4ab9-a072-627894ded673'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','Client Host','openid-connect','oidc-usersessionmodel-note-mapper','a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL),('30b52349-131a-480b-add7-754b8c98dc35','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('3f0cf495-783a-441e-884b-902a7a382622','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'a9189396-32e8-4d5d-8a71-ada6b0d50b6d'),('40e331fa-3112-497b-8259-0ff22dd5ed5f','sub','openid-connect','oidc-sub-mapper',NULL,'d2574f87-b99e-4063-9e4e-61dc402d29bd'),('45094cfc-5fd6-4062-a8d0-4612402847ee','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('46f7f2e4-67b9-4e93-8471-136861beee67','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'2f8ecb94-51cc-4aba-a499-9980e36a0eee'),('4760b22e-013b-4c23-8162-aa1724649fa9','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'77f6aab1-618b-4d04-b313-72589b56f29a'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('5778736c-a261-4a08-8b4e-fa9d4511a228','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('6c9ed80a-f143-40fc-abc5-75330e47612c','locale','openid-connect','oidc-usermodel-attribute-mapper','65b238e3-9746-4498-bced-01961287cd82',NULL),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('7699689e-cd66-42bb-bd14-3c65ce4de211','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('769add77-424f-46b0-b9eb-96216eadd59b','full name','openid-connect','oidc-full-name-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'06a134bd-f48c-4f12-9862-a373ffc01b8d'),('82506748-f210-4ce0-8d4e-17374d617b6e','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'2f8ecb94-51cc-4aba-a499-9980e36a0eee'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','Client ID','openid-connect','oidc-usersessionmodel-note-mapper','a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'b140af73-cb59-4d5a-91f9-c636860fa833'),('8b0e13dc-4a5c-4169-8bd5-00cd99317f6c','audience resolve','openid-connect','oidc-audience-resolve-mapper','67541cb5-6a82-4ee3-9bea-83351b68ba07',NULL),('8e34d301-47dd-489a-bb46-4913e5da219f','address','openid-connect','oidc-address-mapper',NULL,'7f6a17f8-f3fc-46c1-8b3d-5def1c15fc60'),('968f70a8-0298-4eaf-94f2-6ba47c2eb62b','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'3f8487a3-18f6-4083-b97c-6ba4bdfb733e'),('97147ffd-4973-4ad7-b15f-35aebc4a6f8e','acr loa level','openid-connect','oidc-acr-mapper',NULL,'581b235a-1436-42f6-859c-1c46a4d9d0e5'),('9854c2bb-9381-4320-b663-067db244ce6b','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'3ab6aa0f-a306-43a5-b851-73dcc6f32d19'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('a8a4254a-4191-4675-be33-1b8f9cd889b2','role list','saml','saml-role-list-mapper',NULL,'33221937-d60d-4dbf-8e8e-24ee511d1cf5'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','address','openid-connect','oidc-address-mapper',NULL,'1bc6cbd0-b494-427c-829f-3f3453414fc1'),('b27b770d-5df0-4e6b-aac0-ad9187309898','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('b488d41e-3494-4765-aaff-35156be6f0e7','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'0f3e68d6-1283-4372-b94d-b298d57a9d71'),('b4e507bb-4293-4ca3-bf72-5d42cfe710f3','sub','openid-connect','oidc-sub-mapper',NULL,'def7cea9-d336-4ab9-a072-627894ded673'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'568ce12a-5da9-4133-a449-5739b248f2c3'),('c8946084-85bf-4679-9511-7426362cf7a5','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'b140af73-cb59-4d5a-91f9-c636860fa833'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('d4f855a5-2a94-4757-85db-0726915266b3','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'61899695-a74e-4fed-8f55-3eebe172ccae'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'2f8ecb94-51cc-4aba-a499-9980e36a0eee'),('d8075e7d-cb5f-43eb-a142-bc9110920c34','role list','saml','saml-role-list-mapper',NULL,'a6e6271f-06dc-4139-abab-47aafdfb1b62'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'77f6aab1-618b-4d04-b313-72589b56f29a'),('dc45c929-18d9-4e1c-b758-26beb46e692d','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'61899695-a74e-4fed-8f55-3eebe172ccae'),('dd215781-a8cf-42b3-9266-737a9727d6d7','locale','openid-connect','oidc-usermodel-attribute-mapper','5267d120-9a8a-41a3-9ca4-a06cad22f8cf',NULL),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','auth_time','openid-connect','oidc-usersessionmodel-note-mapper',NULL,'d2574f87-b99e-4063-9e4e-61dc402d29bd'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a9189396-32e8-4d5d-8a71-ada6b0d50b6d'),('f35f7619-9155-4639-a6a4-e0409d32c426','Client IP Address','openid-connect','oidc-usersessionmodel-note-mapper','a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL),('f3c1d192-e1a8-45bf-8c41-1959c4073595','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'0cfc61ec-1d45-4b41-a3b0-1d35b4c5d5af'),('f3d8f849-a605-4342-a0ef-1b8df20fe16c','audience resolve','openid-connect','oidc-audience-resolve-mapper','a510f613-6c4d-424e-b7dc-1f101e1834c8',NULL),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'06a134bd-f48c-4f12-9862-a373ffc01b8d'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'568ce12a-5da9-4133-a449-5739b248f2c3'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'0f3e68d6-1283-4372-b94d-b298d57a9d71'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'4543dad5-1335-4ce1-bc45-e6ad8cd4cfdc');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

LOCK TABLES `PROTOCOL_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER_CONFIG` VALUES ('050d83a2-b1e4-4564-a086-aff826eb8447','true','access.token.claim'),('050d83a2-b1e4-4564-a086-aff826eb8447','preferred_username','claim.name'),('050d83a2-b1e4-4564-a086-aff826eb8447','true','id.token.claim'),('050d83a2-b1e4-4564-a086-aff826eb8447','true','introspection.token.claim'),('050d83a2-b1e4-4564-a086-aff826eb8447','String','jsonType.label'),('050d83a2-b1e4-4564-a086-aff826eb8447','username','user.attribute'),('050d83a2-b1e4-4564-a086-aff826eb8447','true','userinfo.token.claim'),('076b640a-f962-4fa8-b5b1-7b0e1743c7d5','true','access.token.claim'),('076b640a-f962-4fa8-b5b1-7b0e1743c7d5','true','introspection.token.claim'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','true','access.token.claim'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','birthdate','claim.name'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','true','id.token.claim'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','true','introspection.token.claim'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','String','jsonType.label'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','birthdate','user.attribute'),('0a5c2c16-30d1-4ae1-b378-734fa8040e7c','true','userinfo.token.claim'),('11c454e2-e357-4447-a32c-55a9e661e80d','true','access.token.claim'),('11c454e2-e357-4447-a32c-55a9e661e80d','true','id.token.claim'),('11c454e2-e357-4447-a32c-55a9e661e80d','true','introspection.token.claim'),('11c454e2-e357-4447-a32c-55a9e661e80d','true','userinfo.token.claim'),('164b1a15-a6de-4fd9-b011-09e1656a7b1d','true','access.token.claim'),('164b1a15-a6de-4fd9-b011-09e1656a7b1d','true','id.token.claim'),('164b1a15-a6de-4fd9-b011-09e1656a7b1d','true','introspection.token.claim'),('18b20790-d846-474c-93fd-960d026b41be','true','access.token.claim'),('18b20790-d846-474c-93fd-960d026b41be','website','claim.name'),('18b20790-d846-474c-93fd-960d026b41be','true','id.token.claim'),('18b20790-d846-474c-93fd-960d026b41be','true','introspection.token.claim'),('18b20790-d846-474c-93fd-960d026b41be','String','jsonType.label'),('18b20790-d846-474c-93fd-960d026b41be','website','user.attribute'),('18b20790-d846-474c-93fd-960d026b41be','true','userinfo.token.claim'),('201b7f43-71dd-4920-a202-783cf1b3f683','true','access.token.claim'),('201b7f43-71dd-4920-a202-783cf1b3f683','locale','claim.name'),('201b7f43-71dd-4920-a202-783cf1b3f683','true','id.token.claim'),('201b7f43-71dd-4920-a202-783cf1b3f683','true','introspection.token.claim'),('201b7f43-71dd-4920-a202-783cf1b3f683','String','jsonType.label'),('201b7f43-71dd-4920-a202-783cf1b3f683','locale','user.attribute'),('201b7f43-71dd-4920-a202-783cf1b3f683','true','userinfo.token.claim'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','true','access.token.claim'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','auth_time','claim.name'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','true','id.token.claim'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','true','introspection.token.claim'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','long','jsonType.label'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','AUTH_TIME','user.session.note'),('24053746-dc1a-44ee-b4e6-3708ca204c0e','true','userinfo.token.claim'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','true','access.token.claim'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','clientHost','claim.name'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','true','id.token.claim'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','true','introspection.token.claim'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','String','jsonType.label'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','clientHost','user.session.note'),('300a0a0a-f857-4c82-bb2f-a892b59563ee','true','userinfo.token.claim'),('30b52349-131a-480b-add7-754b8c98dc35','true','access.token.claim'),('30b52349-131a-480b-add7-754b8c98dc35','nickname','claim.name'),('30b52349-131a-480b-add7-754b8c98dc35','true','id.token.claim'),('30b52349-131a-480b-add7-754b8c98dc35','true','introspection.token.claim'),('30b52349-131a-480b-add7-754b8c98dc35','String','jsonType.label'),('30b52349-131a-480b-add7-754b8c98dc35','nickname','user.attribute'),('30b52349-131a-480b-add7-754b8c98dc35','true','userinfo.token.claim'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','true','access.token.claim'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','preferred_username','claim.name'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','true','id.token.claim'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','true','introspection.token.claim'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','String','jsonType.label'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','username','user.attribute'),('33157840-ecef-4594-8c21-b2bcd23a1fbf','true','userinfo.token.claim'),('3f0cf495-783a-441e-884b-902a7a382622','true','access.token.claim'),('3f0cf495-783a-441e-884b-902a7a382622','groups','claim.name'),('3f0cf495-783a-441e-884b-902a7a382622','true','id.token.claim'),('3f0cf495-783a-441e-884b-902a7a382622','true','introspection.token.claim'),('3f0cf495-783a-441e-884b-902a7a382622','String','jsonType.label'),('3f0cf495-783a-441e-884b-902a7a382622','true','multivalued'),('3f0cf495-783a-441e-884b-902a7a382622','foo','user.attribute'),('3f0cf495-783a-441e-884b-902a7a382622','true','userinfo.token.claim'),('40e331fa-3112-497b-8259-0ff22dd5ed5f','true','access.token.claim'),('40e331fa-3112-497b-8259-0ff22dd5ed5f','true','introspection.token.claim'),('45094cfc-5fd6-4062-a8d0-4612402847ee','true','access.token.claim'),('45094cfc-5fd6-4062-a8d0-4612402847ee','family_name','claim.name'),('45094cfc-5fd6-4062-a8d0-4612402847ee','true','id.token.claim'),('45094cfc-5fd6-4062-a8d0-4612402847ee','true','introspection.token.claim'),('45094cfc-5fd6-4062-a8d0-4612402847ee','String','jsonType.label'),('45094cfc-5fd6-4062-a8d0-4612402847ee','lastName','user.attribute'),('45094cfc-5fd6-4062-a8d0-4612402847ee','true','userinfo.token.claim'),('46f7f2e4-67b9-4e93-8471-136861beee67','true','access.token.claim'),('46f7f2e4-67b9-4e93-8471-136861beee67','realm_access.roles','claim.name'),('46f7f2e4-67b9-4e93-8471-136861beee67','true','introspection.token.claim'),('46f7f2e4-67b9-4e93-8471-136861beee67','String','jsonType.label'),('46f7f2e4-67b9-4e93-8471-136861beee67','true','multivalued'),('46f7f2e4-67b9-4e93-8471-136861beee67','foo','user.attribute'),('4760b22e-013b-4c23-8162-aa1724649fa9','true','access.token.claim'),('4760b22e-013b-4c23-8162-aa1724649fa9','phone_number','claim.name'),('4760b22e-013b-4c23-8162-aa1724649fa9','true','id.token.claim'),('4760b22e-013b-4c23-8162-aa1724649fa9','true','introspection.token.claim'),('4760b22e-013b-4c23-8162-aa1724649fa9','String','jsonType.label'),('4760b22e-013b-4c23-8162-aa1724649fa9','phoneNumber','user.attribute'),('4760b22e-013b-4c23-8162-aa1724649fa9','true','userinfo.token.claim'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','true','access.token.claim'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','given_name','claim.name'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','true','id.token.claim'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','true','introspection.token.claim'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','String','jsonType.label'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','firstName','user.attribute'),('4dac752a-639b-4a9b-8e35-fa481bc4a170','true','userinfo.token.claim'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','true','access.token.claim'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','profile','claim.name'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','true','id.token.claim'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','true','introspection.token.claim'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','String','jsonType.label'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','profile','user.attribute'),('52f3e058-c1a2-4aeb-8948-ad2b66cbb760','true','userinfo.token.claim'),('5778736c-a261-4a08-8b4e-fa9d4511a228','true','access.token.claim'),('5778736c-a261-4a08-8b4e-fa9d4511a228','website','claim.name'),('5778736c-a261-4a08-8b4e-fa9d4511a228','true','id.token.claim'),('5778736c-a261-4a08-8b4e-fa9d4511a228','true','introspection.token.claim'),('5778736c-a261-4a08-8b4e-fa9d4511a228','String','jsonType.label'),('5778736c-a261-4a08-8b4e-fa9d4511a228','website','user.attribute'),('5778736c-a261-4a08-8b4e-fa9d4511a228','true','userinfo.token.claim'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','true','access.token.claim'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','gender','claim.name'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','true','id.token.claim'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','true','introspection.token.claim'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','String','jsonType.label'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','gender','user.attribute'),('5c6e3b04-e09d-4d85-94b3-66da6ba3e5ae','true','userinfo.token.claim'),('6c9ed80a-f143-40fc-abc5-75330e47612c','true','access.token.claim'),('6c9ed80a-f143-40fc-abc5-75330e47612c','locale','claim.name'),('6c9ed80a-f143-40fc-abc5-75330e47612c','true','id.token.claim'),('6c9ed80a-f143-40fc-abc5-75330e47612c','true','introspection.token.claim'),('6c9ed80a-f143-40fc-abc5-75330e47612c','String','jsonType.label'),('6c9ed80a-f143-40fc-abc5-75330e47612c','locale','user.attribute'),('6c9ed80a-f143-40fc-abc5-75330e47612c','true','userinfo.token.claim'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','true','access.token.claim'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','updated_at','claim.name'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','true','id.token.claim'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','true','introspection.token.claim'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','long','jsonType.label'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','updatedAt','user.attribute'),('7270e9c8-7891-4299-a952-00a2f0dc4ed6','true','userinfo.token.claim'),('7699689e-cd66-42bb-bd14-3c65ce4de211','true','access.token.claim'),('7699689e-cd66-42bb-bd14-3c65ce4de211','picture','claim.name'),('7699689e-cd66-42bb-bd14-3c65ce4de211','true','id.token.claim'),('7699689e-cd66-42bb-bd14-3c65ce4de211','true','introspection.token.claim'),('7699689e-cd66-42bb-bd14-3c65ce4de211','String','jsonType.label'),('7699689e-cd66-42bb-bd14-3c65ce4de211','picture','user.attribute'),('7699689e-cd66-42bb-bd14-3c65ce4de211','true','userinfo.token.claim'),('769add77-424f-46b0-b9eb-96216eadd59b','true','access.token.claim'),('769add77-424f-46b0-b9eb-96216eadd59b','true','id.token.claim'),('769add77-424f-46b0-b9eb-96216eadd59b','true','introspection.token.claim'),('769add77-424f-46b0-b9eb-96216eadd59b','true','userinfo.token.claim'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','true','access.token.claim'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','phone_number','claim.name'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','true','id.token.claim'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','true','introspection.token.claim'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','String','jsonType.label'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','phoneNumber','user.attribute'),('82286811-72dc-451a-9fd6-d2a8d093f3c8','true','userinfo.token.claim'),('82506748-f210-4ce0-8d4e-17374d617b6e','true','access.token.claim'),('82506748-f210-4ce0-8d4e-17374d617b6e','true','introspection.token.claim'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','true','access.token.claim'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','client_id','claim.name'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','true','id.token.claim'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','true','introspection.token.claim'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','String','jsonType.label'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','client_id','user.session.note'),('8430cd19-e205-47fc-9e11-a6cf9a63c3cf','true','userinfo.token.claim'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','true','access.token.claim'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','gender','claim.name'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','true','id.token.claim'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','true','introspection.token.claim'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','String','jsonType.label'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','gender','user.attribute'),('88b0006a-2bfd-44b2-a7aa-5e75d6a345c5','true','userinfo.token.claim'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','true','access.token.claim'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','email','claim.name'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','true','id.token.claim'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','true','introspection.token.claim'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','String','jsonType.label'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','email','user.attribute'),('8ab2aefc-d5e0-43bd-bc16-c443d8828c99','true','userinfo.token.claim'),('8e34d301-47dd-489a-bb46-4913e5da219f','true','access.token.claim'),('8e34d301-47dd-489a-bb46-4913e5da219f','true','id.token.claim'),('8e34d301-47dd-489a-bb46-4913e5da219f','true','introspection.token.claim'),('8e34d301-47dd-489a-bb46-4913e5da219f','country','user.attribute.country'),('8e34d301-47dd-489a-bb46-4913e5da219f','formatted','user.attribute.formatted'),('8e34d301-47dd-489a-bb46-4913e5da219f','locality','user.attribute.locality'),('8e34d301-47dd-489a-bb46-4913e5da219f','postal_code','user.attribute.postal_code'),('8e34d301-47dd-489a-bb46-4913e5da219f','region','user.attribute.region'),('8e34d301-47dd-489a-bb46-4913e5da219f','street','user.attribute.street'),('8e34d301-47dd-489a-bb46-4913e5da219f','true','userinfo.token.claim'),('968f70a8-0298-4eaf-94f2-6ba47c2eb62b','true','access.token.claim'),('968f70a8-0298-4eaf-94f2-6ba47c2eb62b','true','introspection.token.claim'),('97147ffd-4973-4ad7-b15f-35aebc4a6f8e','true','access.token.claim'),('97147ffd-4973-4ad7-b15f-35aebc4a6f8e','true','id.token.claim'),('97147ffd-4973-4ad7-b15f-35aebc4a6f8e','true','introspection.token.claim'),('97147ffd-4973-4ad7-b15f-35aebc4a6f8e','true','userinfo.token.claim'),('9854c2bb-9381-4320-b663-067db244ce6b','true','access.token.claim'),('9854c2bb-9381-4320-b663-067db244ce6b','true','introspection.token.claim'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','true','access.token.claim'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','updated_at','claim.name'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','true','id.token.claim'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','true','introspection.token.claim'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','long','jsonType.label'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','updatedAt','user.attribute'),('9972a68b-4edf-4d33-aed3-41da0784a4a1','true','userinfo.token.claim'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','true','access.token.claim'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','profile','claim.name'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','true','id.token.claim'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','true','introspection.token.claim'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','String','jsonType.label'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','profile','user.attribute'),('9a486b25-eb2a-478f-a6b9-ae8ad6571145','true','userinfo.token.claim'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','true','access.token.claim'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','family_name','claim.name'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','true','id.token.claim'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','true','introspection.token.claim'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','String','jsonType.label'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','lastName','user.attribute'),('a2fcc1e0-3e79-41c5-8a5f-93aeb65a26cb','true','userinfo.token.claim'),('a8a4254a-4191-4675-be33-1b8f9cd889b2','Role','attribute.name'),('a8a4254a-4191-4675-be33-1b8f9cd889b2','Basic','attribute.nameformat'),('a8a4254a-4191-4675-be33-1b8f9cd889b2','false','single'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','true','access.token.claim'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','true','id.token.claim'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','true','introspection.token.claim'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','country','user.attribute.country'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','formatted','user.attribute.formatted'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','locality','user.attribute.locality'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','postal_code','user.attribute.postal_code'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','region','user.attribute.region'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','street','user.attribute.street'),('b0e0b4f3-9711-422e-b3a1-a2468c28aaff','true','userinfo.token.claim'),('b27b770d-5df0-4e6b-aac0-ad9187309898','true','access.token.claim'),('b27b770d-5df0-4e6b-aac0-ad9187309898','birthdate','claim.name'),('b27b770d-5df0-4e6b-aac0-ad9187309898','true','id.token.claim'),('b27b770d-5df0-4e6b-aac0-ad9187309898','true','introspection.token.claim'),('b27b770d-5df0-4e6b-aac0-ad9187309898','String','jsonType.label'),('b27b770d-5df0-4e6b-aac0-ad9187309898','birthdate','user.attribute'),('b27b770d-5df0-4e6b-aac0-ad9187309898','true','userinfo.token.claim'),('b488d41e-3494-4765-aaff-35156be6f0e7','true','access.token.claim'),('b488d41e-3494-4765-aaff-35156be6f0e7','realm_access.roles','claim.name'),('b488d41e-3494-4765-aaff-35156be6f0e7','true','introspection.token.claim'),('b488d41e-3494-4765-aaff-35156be6f0e7','String','jsonType.label'),('b488d41e-3494-4765-aaff-35156be6f0e7','true','multivalued'),('b488d41e-3494-4765-aaff-35156be6f0e7','foo','user.attribute'),('b4e507bb-4293-4ca3-bf72-5d42cfe710f3','true','access.token.claim'),('b4e507bb-4293-4ca3-bf72-5d42cfe710f3','true','introspection.token.claim'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','true','access.token.claim'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','upn','claim.name'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','true','id.token.claim'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','true','introspection.token.claim'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','String','jsonType.label'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','username','user.attribute'),('b8ba8875-2449-4fd0-80e4-5ac93f31883c','true','userinfo.token.claim'),('c8946084-85bf-4679-9511-7426362cf7a5','true','access.token.claim'),('c8946084-85bf-4679-9511-7426362cf7a5','middle_name','claim.name'),('c8946084-85bf-4679-9511-7426362cf7a5','true','id.token.claim'),('c8946084-85bf-4679-9511-7426362cf7a5','true','introspection.token.claim'),('c8946084-85bf-4679-9511-7426362cf7a5','String','jsonType.label'),('c8946084-85bf-4679-9511-7426362cf7a5','middleName','user.attribute'),('c8946084-85bf-4679-9511-7426362cf7a5','true','userinfo.token.claim'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','true','access.token.claim'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','email_verified','claim.name'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','true','id.token.claim'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','true','introspection.token.claim'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','boolean','jsonType.label'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','emailVerified','user.attribute'),('caa306a6-9015-40a2-91cd-9a8da732c6bd','true','userinfo.token.claim'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','true','access.token.claim'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','zoneinfo','claim.name'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','true','id.token.claim'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','true','introspection.token.claim'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','String','jsonType.label'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','zoneinfo','user.attribute'),('d37ee9d4-d512-4533-83dd-2cf1967bd6c8','true','userinfo.token.claim'),('d4f855a5-2a94-4757-85db-0726915266b3','true','access.token.claim'),('d4f855a5-2a94-4757-85db-0726915266b3','picture','claim.name'),('d4f855a5-2a94-4757-85db-0726915266b3','true','id.token.claim'),('d4f855a5-2a94-4757-85db-0726915266b3','true','introspection.token.claim'),('d4f855a5-2a94-4757-85db-0726915266b3','String','jsonType.label'),('d4f855a5-2a94-4757-85db-0726915266b3','picture','user.attribute'),('d4f855a5-2a94-4757-85db-0726915266b3','true','userinfo.token.claim'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','true','access.token.claim'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','email_verified','claim.name'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','true','id.token.claim'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','true','introspection.token.claim'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','boolean','jsonType.label'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','emailVerified','user.attribute'),('d7d8c7be-c87c-46c2-9a78-4ae73a3a4e2f','true','userinfo.token.claim'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','true','access.token.claim'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','resource_access.${client_id}.roles','claim.name'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','true','introspection.token.claim'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','String','jsonType.label'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','true','multivalued'),('d7e65ca4-76ac-4f00-813a-bd1ad587f59c','foo','user.attribute'),('d8075e7d-cb5f-43eb-a142-bc9110920c34','Role','attribute.name'),('d8075e7d-cb5f-43eb-a142-bc9110920c34','Basic','attribute.nameformat'),('d8075e7d-cb5f-43eb-a142-bc9110920c34','false','single'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','true','access.token.claim'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','phone_number_verified','claim.name'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','true','id.token.claim'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','true','introspection.token.claim'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','boolean','jsonType.label'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','phoneNumberVerified','user.attribute'),('d9860672-2e59-4d55-b143-d2c0e6988ecf','true','userinfo.token.claim'),('dc45c929-18d9-4e1c-b758-26beb46e692d','true','access.token.claim'),('dc45c929-18d9-4e1c-b758-26beb46e692d','email','claim.name'),('dc45c929-18d9-4e1c-b758-26beb46e692d','true','id.token.claim'),('dc45c929-18d9-4e1c-b758-26beb46e692d','true','introspection.token.claim'),('dc45c929-18d9-4e1c-b758-26beb46e692d','String','jsonType.label'),('dc45c929-18d9-4e1c-b758-26beb46e692d','email','user.attribute'),('dc45c929-18d9-4e1c-b758-26beb46e692d','true','userinfo.token.claim'),('dd215781-a8cf-42b3-9266-737a9727d6d7','true','access.token.claim'),('dd215781-a8cf-42b3-9266-737a9727d6d7','locale','claim.name'),('dd215781-a8cf-42b3-9266-737a9727d6d7','true','id.token.claim'),('dd215781-a8cf-42b3-9266-737a9727d6d7','true','introspection.token.claim'),('dd215781-a8cf-42b3-9266-737a9727d6d7','String','jsonType.label'),('dd215781-a8cf-42b3-9266-737a9727d6d7','locale','user.attribute'),('dd215781-a8cf-42b3-9266-737a9727d6d7','true','userinfo.token.claim'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','true','access.token.claim'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','given_name','claim.name'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','true','id.token.claim'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','true','introspection.token.claim'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','String','jsonType.label'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','firstName','user.attribute'),('e5b34e04-c6ab-4746-9e28-3b1662ba4394','true','userinfo.token.claim'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','true','access.token.claim'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','auth_time','claim.name'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','true','id.token.claim'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','true','introspection.token.claim'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','long','jsonType.label'),('eb40a83e-b75a-440e-9c4c-e60e382cb59b','AUTH_TIME','user.session.note'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','true','access.token.claim'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','middle_name','claim.name'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','true','id.token.claim'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','true','introspection.token.claim'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','String','jsonType.label'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','middleName','user.attribute'),('ec23f0f4-526a-40f0-ba88-7b7938c584ff','true','userinfo.token.claim'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','true','access.token.claim'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','upn','claim.name'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','true','id.token.claim'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','true','introspection.token.claim'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','String','jsonType.label'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','username','user.attribute'),('ed8c15df-8c3e-40e0-927d-c29193f24b2b','true','userinfo.token.claim'),('f35f7619-9155-4639-a6a4-e0409d32c426','true','access.token.claim'),('f35f7619-9155-4639-a6a4-e0409d32c426','clientAddress','claim.name'),('f35f7619-9155-4639-a6a4-e0409d32c426','true','id.token.claim'),('f35f7619-9155-4639-a6a4-e0409d32c426','true','introspection.token.claim'),('f35f7619-9155-4639-a6a4-e0409d32c426','String','jsonType.label'),('f35f7619-9155-4639-a6a4-e0409d32c426','clientAddress','user.session.note'),('f35f7619-9155-4639-a6a4-e0409d32c426','true','userinfo.token.claim'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','true','access.token.claim'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','nickname','claim.name'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','true','id.token.claim'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','true','introspection.token.claim'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','String','jsonType.label'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','nickname','user.attribute'),('f3c1d192-e1a8-45bf-8c41-1959c4073595','true','userinfo.token.claim'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','true','access.token.claim'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','locale','claim.name'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','true','id.token.claim'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','true','introspection.token.claim'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','String','jsonType.label'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','locale','user.attribute'),('f84ac703-babc-4bbb-aed1-3d45c0c1e950','true','userinfo.token.claim'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','true','access.token.claim'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','phone_number_verified','claim.name'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','true','id.token.claim'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','true','introspection.token.claim'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','boolean','jsonType.label'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','phoneNumberVerified','user.attribute'),('f8d64b8e-bcd6-40f9-ba05-5071ea511221','true','userinfo.token.claim'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','true','access.token.claim'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','groups','claim.name'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','true','id.token.claim'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','true','introspection.token.claim'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','String','jsonType.label'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','true','multivalued'),('f907b579-bc84-4439-b9f1-2c11e2dcb80f','foo','user.attribute'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','true','access.token.claim'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','resource_access.${client_id}.roles','claim.name'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','true','introspection.token.claim'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','String','jsonType.label'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','true','multivalued'),('fa8d6112-a181-4a40-ab13-0df8adcf910a','foo','user.attribute'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','true','access.token.claim'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','zoneinfo','claim.name'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','true','id.token.claim'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','true','introspection.token.claim'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','String','jsonType.label'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','zoneinfo','user.attribute'),('fcc2593c-3f43-43f2-ac9b-a26aa31993c0','true','userinfo.token.claim');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM`
--

DROP TABLE IF EXISTS `REALM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `EVENTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `EVENTS_EXPIRATION` bigint DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PASSWORD_POLICY` text,
  `REGISTRATION_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `REMEMBER_ME` tinyint NOT NULL DEFAULT '0',
  `RESET_PASSWORD_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `SOCIAL` tinyint NOT NULL DEFAULT '0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` tinyint NOT NULL DEFAULT '0',
  `VERIFY_EMAIL` tinyint NOT NULL DEFAULT '0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` tinyint NOT NULL DEFAULT '0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` tinyint NOT NULL DEFAULT '0',
  `ADMIN_EVENTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `ADMIN_EVENTS_DETAILS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `EDIT_USERNAME_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `OTP_POLICY_COUNTER` int DEFAULT '0',
  `OTP_POLICY_WINDOW` int DEFAULT '1',
  `OTP_POLICY_PERIOD` int DEFAULT '30',
  `OTP_POLICY_DIGITS` int DEFAULT '6',
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int DEFAULT '0',
  `REVOKE_REFRESH_TOKEN` tinyint NOT NULL DEFAULT '0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int DEFAULT '0',
  `LOGIN_WITH_EMAIL_ALLOWED` tinyint NOT NULL DEFAULT '1',
  `DUPLICATE_EMAILS_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int DEFAULT '0',
  `ALLOW_USER_MANAGED_ACCESS` tinyint NOT NULL DEFAULT '0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int NOT NULL,
  `DEFAULT_ROLE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM`
--

LOCK TABLES `REALM` WRITE;
/*!40000 ALTER TABLE `REALM` DISABLE KEYS */;
INSERT INTO `REALM` VALUES ('19363c62-1a5c-4117-9fae-ba3b727d853b',60,300,60,NULL,NULL,NULL,1,0,0,NULL,'master',0,NULL,0,0,0,0,'EXTERNAL',1800,36000,0,0,'f50f6f25-d0d1-41e8-9d55-a664f3721a2a',1800,0,NULL,0,0,0,0,0,1,30,6,'HmacSHA1','totp','8d3c24a8-b0b8-442f-a32e-e60482ae70e4','091b0038-6fdc-45a4-b3a2-e3b76ccf44bf','c0395c4b-8f02-4b58-b005-814346d92f82','6bf61775-0c3f-4ea4-8f2b-ca41ddaba449','057c7974-ce7e-41cf-98b2-0e10131c2e7d',2592000,0,900,1,0,'fd7c142d-e3f5-4b4a-a34e-08ff7a7eef87',0,0,0,0,'13b81f2d-f9d9-4d79-ba28-cb73604e33be'),('3c25345a-35d9-4d22-8a17-4e83429890aa',60,300,300,'','','keycloak',1,0,0,'','microservices-motorsport-predictor-realm',0,NULL,1,0,0,0,'EXTERNAL',1800,36000,0,0,'c327f9c6-48eb-4f34-88cc-937e511bee44',1800,0,NULL,0,0,0,0,0,1,30,6,'HmacSHA1','totp','cd5677c2-5222-4a06-9e8f-90ba568826ff','a5ba4f80-e2d8-44a3-9633-e18a57b4d419','cc69b542-1314-46ac-a3bf-88f8c756ed60','b2112fa4-e185-414b-bb29-b2bac46acc29','0b1f63e9-cbd6-4233-9833-4625dd907272',2592000,0,900,1,0,'34438d87-7229-4555-a1ad-27b9ac46285d',0,0,0,0,'c49c5591-735e-404d-981d-3397fe86a285');
/*!40000 ALTER TABLE `REALM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ATTRIBUTE`
--

DROP TABLE IF EXISTS `REALM_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`NAME`,`REALM_ID`),
  KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`),
  CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

LOCK TABLES `REALM_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `REALM_ATTRIBUTE` VALUES ('_browser_header.contentSecurityPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicyReportOnly','19363c62-1a5c-4117-9fae-ba3b727d853b',''),('_browser_header.contentSecurityPolicyReportOnly','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('_browser_header.referrerPolicy','19363c62-1a5c-4117-9fae-ba3b727d853b','no-referrer'),('_browser_header.referrerPolicy','3c25345a-35d9-4d22-8a17-4e83429890aa','no-referrer'),('_browser_header.strictTransportSecurity','19363c62-1a5c-4117-9fae-ba3b727d853b','max-age=31536000; includeSubDomains'),('_browser_header.strictTransportSecurity','3c25345a-35d9-4d22-8a17-4e83429890aa','max-age=31536000; includeSubDomains'),('_browser_header.xContentTypeOptions','19363c62-1a5c-4117-9fae-ba3b727d853b','nosniff'),('_browser_header.xContentTypeOptions','3c25345a-35d9-4d22-8a17-4e83429890aa','nosniff'),('_browser_header.xFrameOptions','19363c62-1a5c-4117-9fae-ba3b727d853b','SAMEORIGIN'),('_browser_header.xFrameOptions','3c25345a-35d9-4d22-8a17-4e83429890aa','SAMEORIGIN'),('_browser_header.xRobotsTag','19363c62-1a5c-4117-9fae-ba3b727d853b','none'),('_browser_header.xRobotsTag','3c25345a-35d9-4d22-8a17-4e83429890aa','none'),('_browser_header.xXSSProtection','19363c62-1a5c-4117-9fae-ba3b727d853b','1; mode=block'),('_browser_header.xXSSProtection','3c25345a-35d9-4d22-8a17-4e83429890aa','1; mode=block'),('acr.loa.map','3c25345a-35d9-4d22-8a17-4e83429890aa','{}'),('actionTokenGeneratedByAdminLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','43200'),('actionTokenGeneratedByUserLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','300'),('bruteForceProtected','19363c62-1a5c-4117-9fae-ba3b727d853b','false'),('bruteForceProtected','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('cibaAuthRequestedUserHint','3c25345a-35d9-4d22-8a17-4e83429890aa','login_hint'),('cibaBackchannelTokenDeliveryMode','3c25345a-35d9-4d22-8a17-4e83429890aa','poll'),('cibaExpiresIn','3c25345a-35d9-4d22-8a17-4e83429890aa','120'),('cibaInterval','3c25345a-35d9-4d22-8a17-4e83429890aa','5'),('client-policies.policies','3c25345a-35d9-4d22-8a17-4e83429890aa','{\"policies\":[]}'),('client-policies.profiles','3c25345a-35d9-4d22-8a17-4e83429890aa','{\"profiles\":[]}'),('clientOfflineSessionIdleTimeout','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('clientOfflineSessionMaxLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('clientSessionIdleTimeout','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('clientSessionMaxLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('defaultSignatureAlgorithm','19363c62-1a5c-4117-9fae-ba3b727d853b','RS256'),('defaultSignatureAlgorithm','3c25345a-35d9-4d22-8a17-4e83429890aa','RS256'),('displayName','19363c62-1a5c-4117-9fae-ba3b727d853b','Keycloak'),('displayName','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('displayNameHtml','19363c62-1a5c-4117-9fae-ba3b727d853b','<div class=\"kc-logo-text\"><span>Keycloak</span></div>'),('displayNameHtml','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('failureFactor','19363c62-1a5c-4117-9fae-ba3b727d853b','30'),('failureFactor','3c25345a-35d9-4d22-8a17-4e83429890aa','30'),('firstBrokerLoginFlowId','19363c62-1a5c-4117-9fae-ba3b727d853b','73c6e9ca-2864-47b3-8685-67006386d235'),('firstBrokerLoginFlowId','3c25345a-35d9-4d22-8a17-4e83429890aa','4c4e14b5-79c9-4b8c-9cea-93f89c7e8a95'),('frontendUrl','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('maxDeltaTimeSeconds','19363c62-1a5c-4117-9fae-ba3b727d853b','43200'),('maxDeltaTimeSeconds','3c25345a-35d9-4d22-8a17-4e83429890aa','43200'),('maxFailureWaitSeconds','19363c62-1a5c-4117-9fae-ba3b727d853b','900'),('maxFailureWaitSeconds','3c25345a-35d9-4d22-8a17-4e83429890aa','900'),('maxTemporaryLockouts','19363c62-1a5c-4117-9fae-ba3b727d853b','0'),('maxTemporaryLockouts','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('minimumQuickLoginWaitSeconds','19363c62-1a5c-4117-9fae-ba3b727d853b','60'),('minimumQuickLoginWaitSeconds','3c25345a-35d9-4d22-8a17-4e83429890aa','60'),('oauth2DeviceCodeLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','600'),('oauth2DevicePollingInterval','3c25345a-35d9-4d22-8a17-4e83429890aa','5'),('offlineSessionMaxLifespan','19363c62-1a5c-4117-9fae-ba3b727d853b','5184000'),('offlineSessionMaxLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','5184000'),('offlineSessionMaxLifespanEnabled','19363c62-1a5c-4117-9fae-ba3b727d853b','false'),('offlineSessionMaxLifespanEnabled','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('organizationsEnabled','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('parRequestUriLifespan','3c25345a-35d9-4d22-8a17-4e83429890aa','60'),('permanentLockout','19363c62-1a5c-4117-9fae-ba3b727d853b','false'),('permanentLockout','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('quickLoginCheckMilliSeconds','19363c62-1a5c-4117-9fae-ba3b727d853b','1000'),('quickLoginCheckMilliSeconds','3c25345a-35d9-4d22-8a17-4e83429890aa','1000'),('realmReusableOtpCode','19363c62-1a5c-4117-9fae-ba3b727d853b','false'),('realmReusableOtpCode','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('waitIncrementSeconds','19363c62-1a5c-4117-9fae-ba3b727d853b','60'),('waitIncrementSeconds','3c25345a-35d9-4d22-8a17-4e83429890aa','60'),('webAuthnPolicyAttestationConveyancePreference','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyAuthenticatorAttachment','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyAvoidSameAuthenticatorRegister','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','false'),('webAuthnPolicyCreateTimeout','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('webAuthnPolicyCreateTimeoutPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','0'),('webAuthnPolicyRequireResidentKey','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyRequireResidentKeyPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyRpEntityName','3c25345a-35d9-4d22-8a17-4e83429890aa','keycloak'),('webAuthnPolicyRpEntityNamePasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','keycloak'),('webAuthnPolicyRpId','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('webAuthnPolicyRpIdPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa',''),('webAuthnPolicySignatureAlgorithms','3c25345a-35d9-4d22-8a17-4e83429890aa','ES256'),('webAuthnPolicySignatureAlgorithmsPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','ES256'),('webAuthnPolicyUserVerificationRequirement','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified'),('webAuthnPolicyUserVerificationRequirementPasswordless','3c25345a-35d9-4d22-8a17-4e83429890aa','not specified');
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_GROUPS`
--

LOCK TABLES `REALM_DEFAULT_GROUPS` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

DROP TABLE IF EXISTS `REALM_ENABLED_EVENT_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ENABLED_EVENT_TYPES`
--

LOCK TABLES `REALM_ENABLED_EVENT_TYPES` WRITE;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

DROP TABLE IF EXISTS `REALM_EVENTS_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

LOCK TABLES `REALM_EVENTS_LISTENERS` WRITE;
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` DISABLE KEYS */;
INSERT INTO `REALM_EVENTS_LISTENERS` VALUES ('19363c62-1a5c-4117-9fae-ba3b727d853b','jboss-logging'),('3c25345a-35d9-4d22-8a17-4e83429890aa','jboss-logging');
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

DROP TABLE IF EXISTS `REALM_LOCALIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`REALM_ID`,`LOCALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_LOCALIZATIONS`
--

LOCK TABLES `REALM_LOCALIZATIONS` WRITE;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

DROP TABLE IF EXISTS `REALM_REQUIRED_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` tinyint NOT NULL DEFAULT '0',
  `SECRET` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`TYPE`),
  CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

LOCK TABLES `REALM_REQUIRED_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` DISABLE KEYS */;
INSERT INTO `REALM_REQUIRED_CREDENTIAL` VALUES ('password','password',1,1,'19363c62-1a5c-4117-9fae-ba3b727d853b'),('password','password',1,1,'3c25345a-35d9-4d22-8a17-4e83429890aa');
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

DROP TABLE IF EXISTS `REALM_SMTP_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`NAME`),
  CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

LOCK TABLES `REALM_SMTP_CONFIG` WRITE;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` DISABLE KEYS */;
INSERT INTO `REALM_SMTP_CONFIG` VALUES ('3c25345a-35d9-4d22-8a17-4e83429890aa','true','auth'),('3c25345a-35d9-4d22-8a17-4e83429890aa','','envelopeFrom'),('3c25345a-35d9-4d22-8a17-4e83429890aa','ferreirafreddy39@gmail.com','from'),('3c25345a-35d9-4d22-8a17-4e83429890aa','CONFIRMATION EMAIL','fromDisplayName'),('3c25345a-35d9-4d22-8a17-4e83429890aa','smtp.gmail.com','host'),('3c25345a-35d9-4d22-8a17-4e83429890aa','**********','password'),('3c25345a-35d9-4d22-8a17-4e83429890aa','587','port'),('3c25345a-35d9-4d22-8a17-4e83429890aa','','replyTo'),('3c25345a-35d9-4d22-8a17-4e83429890aa','','replyToDisplayName'),('3c25345a-35d9-4d22-8a17-4e83429890aa','false','ssl'),('3c25345a-35d9-4d22-8a17-4e83429890aa','true','starttls'),('3c25345a-35d9-4d22-8a17-4e83429890aa','ferreirafreddy39@gmail.com','user');
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

DROP TABLE IF EXISTS `REALM_SUPPORTED_LOCALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`),
  CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SUPPORTED_LOCALES`
--

LOCK TABLES `REALM_SUPPORTED_LOCALES` WRITE;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REDIRECT_URIS`
--

DROP TABLE IF EXISTS `REDIRECT_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REDIRECT_URIS`
--

LOCK TABLES `REDIRECT_URIS` WRITE;
/*!40000 ALTER TABLE `REDIRECT_URIS` DISABLE KEYS */;
INSERT INTO `REDIRECT_URIS` VALUES ('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','/admin/microservices-motorsport-predictor-realm/console/*'),('58f0a2c6-bc80-4405-814a-e273716d5334','/realms/microservices-motorsport-predictor-realm/account/*'),('65b238e3-9746-4498-bced-01961287cd82','/admin/master/console/*'),('67541cb5-6a82-4ee3-9bea-83351b68ba07','/realms/microservices-motorsport-predictor-realm/account/*'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','http://lcoalhost:9090/*'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','http://localhost'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','http://localhost:9090/login/oauth2/code/keycloak'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','https://oauth.pstmn.io/v1/browser-callback'),('a510f613-6c4d-424e-b7dc-1f101e1834c8','/realms/master/account/*'),('a6b398ae-b0b0-4b78-adf0-fc237f24d7ae','/realms/master/account/*');
/*!40000 ALTER TABLE `REDIRECT_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_CONFIG`
--

LOCK TABLES `REQUIRED_ACTION_CONFIG` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `DEFAULT_ACTION` tinyint NOT NULL DEFAULT '0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

LOCK TABLES `REQUIRED_ACTION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` DISABLE KEYS */;
INSERT INTO `REQUIRED_ACTION_PROVIDER` VALUES ('244a5739-dd91-4180-9171-0bac1d583970','UPDATE_PASSWORD','Update Password','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'UPDATE_PASSWORD',30),('25d424b6-85f8-4eb9-bd83-2fc98dc85aa2','delete_credential','Delete Credential','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'delete_credential',100),('356a7c6c-39f7-4642-870b-ad419130df58','webauthn-register-passwordless','Webauthn Register Passwordless','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'webauthn-register-passwordless',80),('3a79eae1-de7f-436a-b12c-6030c4ccdf36','VERIFY_PROFILE','Verify Profile','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'VERIFY_PROFILE',90),('54fd7982-634e-434a-918d-cc238c5cf807','CONFIGURE_TOTP','Configure OTP','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'CONFIGURE_TOTP',10),('5e982dd2-0cca-429f-b66e-302c1a2defab','VERIFY_EMAIL','Verify Email','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'VERIFY_EMAIL',50),('635a9827-b96b-45c8-bafe-98d9fed8d966','webauthn-register','Webauthn Register','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'webauthn-register',70),('718b6f2c-eb80-48f7-b477-ff20ab0b4b68','update_user_locale','Update User Locale','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'update_user_locale',1000),('778ac4d6-ca08-4bfd-a117-bcd05ad34f59','delete_credential','Delete Credential','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'delete_credential',100),('7c74e682-8a52-45ad-9567-cec1602d771f','update_user_locale','Update User Locale','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'update_user_locale',1000),('899eabdf-9948-4a08-a671-a283fef40798','TERMS_AND_CONDITIONS','Terms and Conditions','3c25345a-35d9-4d22-8a17-4e83429890aa',0,0,'TERMS_AND_CONDITIONS',20),('8d59f007-c970-4330-82de-ef97360fcf05','delete_account','Delete Account','19363c62-1a5c-4117-9fae-ba3b727d853b',0,0,'delete_account',60),('96d4547d-d6e4-4b06-80e6-6e8149bc9503','webauthn-register','Webauthn Register','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'webauthn-register',70),('97b258f2-29e8-44d1-8efe-641e7946210d','CONFIGURE_TOTP','Configure OTP','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'CONFIGURE_TOTP',10),('9c02e2bf-bfcf-41b8-ac1c-724d0d02d1d2','webauthn-register-passwordless','Webauthn Register Passwordless','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'webauthn-register-passwordless',80),('a3a024ba-db71-48b5-b015-3105c807beb5','UPDATE_PASSWORD','Update Password','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'UPDATE_PASSWORD',30),('b02439eb-1575-419e-8363-1457255beb8e','UPDATE_PROFILE','Update Profile','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'UPDATE_PROFILE',40),('bcc74f7f-4c60-416c-a17b-62bae983942e','TERMS_AND_CONDITIONS','Terms and Conditions','19363c62-1a5c-4117-9fae-ba3b727d853b',0,0,'TERMS_AND_CONDITIONS',20),('dbd41aca-7ae0-4ff1-bea9-0a230f5d90d0','VERIFY_PROFILE','Verify Profile','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'VERIFY_PROFILE',90),('e531b14c-5a85-4ae3-9d4e-69d00233d49b','VERIFY_EMAIL','Verify Email','3c25345a-35d9-4d22-8a17-4e83429890aa',1,0,'VERIFY_EMAIL',50),('e88c7def-6c88-477d-b001-71205b3cd0e2','delete_account','Delete Account','3c25345a-35d9-4d22-8a17-4e83429890aa',0,0,'delete_account',60),('f6e84637-0698-4611-b4ca-f7508229bc48','UPDATE_PROFILE','Update Profile','19363c62-1a5c-4117-9fae-ba3b727d853b',1,0,'UPDATE_PROFILE',40);
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `RESOURCE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_ATTRIBUTE`
--

LOCK TABLES `RESOURCE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_POLICY`
--

LOCK TABLES `RESOURCE_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

LOCK TABLES `RESOURCE_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` tinyint NOT NULL DEFAULT '0',
  `POLICY_ENFORCE_MODE` tinyint DEFAULT NULL,
  `DECISION_STRATEGY` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER`
--

LOCK TABLES `RESOURCE_SERVER` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER` VALUES ('a15827b2-d57e-4a4c-8a7d-275070cf48e3',1,0,1);
/*!40000 ALTER TABLE `RESOURCE_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_PERM_TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint NOT NULL,
  `GRANTED_TIMESTAMP` bigint DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`),
  KEY `IDX_PERM_TICKET_REQUESTER` (`REQUESTER`),
  KEY `IDX_PERM_TICKET_OWNER` (`OWNER`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_PERM_TICKET`
--

LOCK TABLES `RESOURCE_SERVER_PERM_TICKET` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` tinyint DEFAULT NULL,
  `LOGIC` tinyint DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

LOCK TABLES `RESOURCE_SERVER_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER_POLICY` VALUES ('4d34da98-a7f0-441c-89f7-8db12340d69b','Default Permission','A permission that applies to the default resource type','resource',1,0,'a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL),('a88d9095-4c8a-4e96-8161-46543351172a','Default Policy','A policy that grants access only for users within this realm','regex',0,0,'a15827b2-d57e-4a4c-8a7d-275070cf48e3',NULL);
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` tinyint NOT NULL DEFAULT '0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

LOCK TABLES `RESOURCE_SERVER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER_RESOURCE` VALUES ('57192cd3-c191-4ce3-9653-991f6ef32dca','Default Resource','urn:microservices-motorsport-client:resources:default',NULL,'a15827b2-d57e-4a4c-8a7d-275070cf48e3','a15827b2-d57e-4a4c-8a7d-275070cf48e3',0,NULL);
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

LOCK TABLES `RESOURCE_SERVER_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_URIS`
--

DROP TABLE IF EXISTS `RESOURCE_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`VALUE`),
  CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_URIS`
--

LOCK TABLES `RESOURCE_URIS` WRITE;
/*!40000 ALTER TABLE `RESOURCE_URIS` DISABLE KEYS */;
INSERT INTO `RESOURCE_URIS` VALUES ('57192cd3-c191-4ce3-9653-991f6ef32dca','/*');
/*!40000 ALTER TABLE `RESOURCE_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ROLE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`),
  CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_ATTRIBUTE`
--

LOCK TABLES `ROLE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_MAPPING`
--

DROP TABLE IF EXISTS `SCOPE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_MAPPING`
--

LOCK TABLES `SCOPE_MAPPING` WRITE;
/*!40000 ALTER TABLE `SCOPE_MAPPING` DISABLE KEYS */;
INSERT INTO `SCOPE_MAPPING` VALUES ('67541cb5-6a82-4ee3-9bea-83351b68ba07','1573733c-b0a6-493a-8fcc-9f1ba2849091'),('67541cb5-6a82-4ee3-9bea-83351b68ba07','24cfe5e5-bf8b-41d7-92f4-7b948dc777b9'),('a510f613-6c4d-424e-b7dc-1f101e1834c8','425879f8-bf1e-4028-a143-b80308791715'),('a510f613-6c4d-424e-b7dc-1f101e1834c8','67618e6f-560f-4c1b-9dc5-724122eb7bd0');
/*!40000 ALTER TABLE `SCOPE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_POLICY`
--

DROP TABLE IF EXISTS `SCOPE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_POLICY`
--

LOCK TABLES `SCOPE_POLICY` WRITE;
/*!40000 ALTER TABLE `SCOPE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCOPE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

DROP TABLE IF EXISTS `USERNAME_LOGIN_FAILURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int DEFAULT NULL,
  `LAST_FAILURE` bigint DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int DEFAULT NULL,
  PRIMARY KEY (`REALM_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERNAME_LOGIN_FAILURE`
--

LOCK TABLES `USERNAME_LOGIN_FAILURE` WRITE;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `LONG_VALUE_HASH` binary(64) DEFAULT NULL,
  `LONG_VALUE_HASH_LOWER_CASE` binary(64) DEFAULT NULL,
  `LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  KEY `IDX_USER_ATTRIBUTE_NAME` (`NAME`,`VALUE`),
  KEY `USER_ATTR_LONG_VALUES` (`LONG_VALUE_HASH`,`NAME`),
  KEY `USER_ATTR_LONG_VALUES_LOWER_CASE` (`LONG_VALUE_HASH_LOWER_CASE`,`NAME`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ATTRIBUTE`
--

LOCK TABLES `USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `USER_ATTRIBUTE` VALUES ('nationality','Argentina','1e20e920-5043-468f-89f7-6e508bff1a38','0d109331-a20e-42e1-9ad2-a3b2006ca753',NULL,NULL,NULL),('nationality','Brazilian','7381f5c8-6fff-4c06-9e75-e1d18093df53','615d324d-4a66-4a7b-903a-e01140dd554b',NULL,NULL,NULL),('nationality','American','66020b55-5ab8-4ba7-b1ad-27a9ed238a63','cc5c8330-6f64-484c-aab8-c527d7a0fdcd',NULL,NULL,NULL);
/*!40000 ALTER TABLE `USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT`
--

DROP TABLE IF EXISTS `USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_LOCAL_CONSENT` (`CLIENT_ID`,`USER_ID`),
  UNIQUE KEY `UK_EXTERNAL_CONSENT` (`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  KEY `IDX_USER_CONSENT` (`USER_ID`),
  CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT`
--

LOCK TABLES `USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `USER_CONSENT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`),
  CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT_CLIENT_SCOPE`
--

LOCK TABLES `USER_CONSENT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ENTITY`
--

DROP TABLE IF EXISTS `USER_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` tinyint NOT NULL DEFAULT '0',
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  KEY `IDX_USER_EMAIL` (`EMAIL`),
  KEY `IDX_USER_SERVICE_ACCOUNT` (`REALM_ID`,`SERVICE_ACCOUNT_CLIENT_LINK`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ENTITY`
--

LOCK TABLES `USER_ENTITY` WRITE;
/*!40000 ALTER TABLE `USER_ENTITY` DISABLE KEYS */;
INSERT INTO `USER_ENTITY` VALUES ('087a0609-1a9b-46b8-90b2-3c217eee4db0','ferreirafreddy39@gmail.com','ferreirafreddy39@gmail.com',0,1,NULL,'Freddy','Ferreira','19363c62-1a5c-4117-9fae-ba3b727d853b','admin',1726887664902,NULL,0),('1e20e920-5043-468f-89f7-6e508bff1a38','admin_user@gmail.com','admin_user@gmail.com',1,1,NULL,'Admin','User','3c25345a-35d9-4d22-8a17-4e83429890aa','admin_user',1726968390184,NULL,0),('472b764c-5c20-4637-8e8d-57f238a6b02c',NULL,'7b964b6e-8e91-4727-929e-7664e6ab8794',0,1,NULL,NULL,NULL,'3c25345a-35d9-4d22-8a17-4e83429890aa','service-account-microservices-motorsport-client',1726271119039,'a15827b2-d57e-4a4c-8a7d-275070cf48e3',0),('66020b55-5ab8-4ba7-b1ad-27a9ed238a63','usuario_prueba_1@gmail.com','usuario_prueba_1@gmail.com',1,1,NULL,'User Uno','Prueba Uno','3c25345a-35d9-4d22-8a17-4e83429890aa','usuario_prueba_1',1726968555760,NULL,0),('7381f5c8-6fff-4c06-9e75-e1d18093df53','usuario_prueba_2@gmail.com','usuario_prueba_2@gmail.com',1,1,NULL,'User Dos','Prueba Dos','3c25345a-35d9-4d22-8a17-4e83429890aa','usuario_prueba_2',1726968657010,NULL,0);
/*!40000 ALTER TABLE `USER_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_CONFIG`
--

LOCK TABLES `USER_FEDERATION_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER`
--

LOCK TABLES `USER_FEDERATION_MAPPER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER_CONFIG`
--

LOCK TABLES `USER_FEDERATION_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int DEFAULT NULL,
  `LAST_SYNC` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_PROVIDER`
--

LOCK TABLES `USER_FEDERATION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_USER_REQACTIONS` (`USER_ID`),
  CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_REQUIRED_ACTION`
--

LOCK TABLES `USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

LOCK TABLES `USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `USER_ROLE_MAPPING` VALUES ('13b81f2d-f9d9-4d79-ba28-cb73604e33be','087a0609-1a9b-46b8-90b2-3c217eee4db0'),('7e2cf3e6-c4cd-4cbf-9713-235250d2b5c8','087a0609-1a9b-46b8-90b2-3c217eee4db0'),('89d566a2-ba8b-4816-8a56-6a77d0bb626e','1e20e920-5043-468f-89f7-6e508bff1a38'),('a2c6ec86-213e-4040-aa06-8e64cbab07a8','1e20e920-5043-468f-89f7-6e508bff1a38'),('c49c5591-735e-404d-981d-3397fe86a285','1e20e920-5043-468f-89f7-6e508bff1a38'),('c49c5591-735e-404d-981d-3397fe86a285','472b764c-5c20-4637-8e8d-57f238a6b02c'),('f91ae09c-64cf-4f44-8eb6-e59b46b5fa37','472b764c-5c20-4637-8e8d-57f238a6b02c'),('a2c6ec86-213e-4040-aa06-8e64cbab07a8','66020b55-5ab8-4ba7-b1ad-27a9ed238a63'),('c49c5591-735e-404d-981d-3397fe86a285','66020b55-5ab8-4ba7-b1ad-27a9ed238a63'),('a2c6ec86-213e-4040-aa06-8e64cbab07a8','7381f5c8-6fff-4c06-9e75-e1d18093df53'),('c49c5591-735e-404d-981d-3397fe86a285','7381f5c8-6fff-4c06-9e75-e1d18093df53');
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION`
--

DROP TABLE IF EXISTS `USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` tinyint NOT NULL DEFAULT '0',
  `STARTED` int DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION`
--

LOCK TABLES `USER_SESSION` WRITE;
/*!40000 ALTER TABLE `USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  PRIMARY KEY (`USER_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION_NOTE`
--

LOCK TABLES `USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WEB_ORIGINS`
--

DROP TABLE IF EXISTS `WEB_ORIGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WEB_ORIGINS`
--

LOCK TABLES `WEB_ORIGINS` WRITE;
/*!40000 ALTER TABLE `WEB_ORIGINS` DISABLE KEYS */;
INSERT INTO `WEB_ORIGINS` VALUES ('5267d120-9a8a-41a3-9ca4-a06cad22f8cf','+'),('65b238e3-9746-4498-bced-01961287cd82','+'),('a15827b2-d57e-4a4c-8a7d-275070cf48e3','/*');
/*!40000 ALTER TABLE `WEB_ORIGINS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-22  1:51:09
