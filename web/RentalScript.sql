CREATE DATABASE  IF NOT EXISTS `RentalDatabase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `RentalDatabase`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: RentalDatabase
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `phone` char(25) DEFAULT NULL,
  `email` char(25) NOT NULL,
  `name` char(50) DEFAULT NULL,
  `customer_id` char(10) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerContactRealtor`
--

DROP TABLE IF EXISTS `CustomerContactRealtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerContactRealtor` (
  `customer_id` char(10) NOT NULL,
  `realtor_id` char(10) NOT NULL,
  `date` datetime DEFAULT NULL,
  `contact_message` char(200) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`realtor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerContactRealtor`
--

LOCK TABLES `CustomerContactRealtor` WRITE;
/*!40000 ALTER TABLE `CustomerContactRealtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerContactRealtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feature`
--

DROP TABLE IF EXISTS `Feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Feature` (
  `feature_name` char(50) NOT NULL,
  `description` char(50) DEFAULT NULL,
  `property_id` char(10) NOT NULL,
  PRIMARY KEY (`feature_name`,`property_id`),
  KEY `propertyid_idx` (`property_id`),
  CONSTRAINT `propertyid` FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `Feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ForRent`
--

DROP TABLE IF EXISTS `ForRent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ForRent` (
  `property_id` int(11) NOT NULL,
  `rent` int(11) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  UNIQUE KEY `property_id_UNIQUE` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ForRent`
--

LOCK TABLES `ForRent` WRITE;
/*!40000 ALTER TABLE `ForRent` DISABLE KEYS */;
INSERT INTO `ForRent` VALUES (1,3000),(2,4000),(3,5000);
/*!40000 ALTER TABLE `ForRent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ForSale`
--

DROP TABLE IF EXISTS `ForSale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ForSale` (
  `property_id` char(10) NOT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  CONSTRAINT `ppid` FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ForSale`
--

LOCK TABLES `ForSale` WRITE;
/*!40000 ALTER TABLE `ForSale` DISABLE KEYS */;
/*!40000 ALTER TABLE `ForSale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PostalCode`
--

DROP TABLE IF EXISTS `PostalCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PostalCode` (
  `postal_code` char(7) NOT NULL,
  `city` char(50) DEFAULT NULL,
  `province` char(2) DEFAULT NULL,
  PRIMARY KEY (`postal_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PostalCode`
--

LOCK TABLES `PostalCode` WRITE;
/*!40000 ALTER TABLE `PostalCode` DISABLE KEYS */;
INSERT INTO `PostalCode` VALUES ('V5L 3X8','Vancouver','BC'),('V6E 1A3','Vancouver','BC'),('V6K 1N9','Vancouver','BC'),('V6S 1A5','Vancouver','BC'),('V6T 1W6','Vancouver','BC');
/*!40000 ALTER TABLE `PostalCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Property`
--

DROP TABLE IF EXISTS `Property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Property` (
  `property_id` char(10) NOT NULL,
  `realtor_id` char(10) NOT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `type` char(50) DEFAULT NULL,
  `date_built` date DEFAULT NULL,
  `sq_ft` float DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  `num_beds` int(11) DEFAULT NULL,
  `num_baths` float DEFAULT NULL,
  `address` char(50) NOT NULL,
  PRIMARY KEY (`property_id`),
  KEY `property1_idx` (`realtor_id`),
  KEY `property2_idx` (`postal_code`),
  CONSTRAINT `property1` FOREIGN KEY (`realtor_id`) REFERENCES `Realtor` (`realtor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `property2` FOREIGN KEY (`postal_code`) REFERENCES `PostalCode` (`postal_code`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Property`
--

LOCK TABLES `Property` WRITE;
/*!40000 ALTER TABLE `Property` DISABLE KEYS */;
INSERT INTO `Property` VALUES ('1','1','V6Z 2T7','Apt/Condo','1996-04-21',1100,'2016-05-01',2,2,'1A-139 Drake Street'),('2','1','V6L 3B4','Apt/Condo','1974-09-12',1316,'2013-12-13',2,2,'409-2101 Mcmullen Avenue'),('3','2','V5L 1K3','Townhouse','2018-05-29',1468,'2014-08-29',3,3,'2036 Franklin Street'),('4','3','V6N 1N3','House','2016-12-10',4132,'2018-01-03',6,6,'4928 Blenheim Street'),('5','4','V5L 1K3','Townhouse','1998-07-31',1445,'2015-07-29',3,3,'2034 Franklin Street');
/*!40000 ALTER TABLE `Property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Realtor`
--

DROP TABLE IF EXISTS `Realtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Realtor` (
  `phone` char(25) DEFAULT NULL,
  `email` char(50) NOT NULL,
  `name` char(50) DEFAULT NULL,
  `realtor_id` char(10) NOT NULL,
  `branch_id` char(10) NOT NULL,
  PRIMARY KEY (`realtor_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `branchid_idx` (`branch_id`),
  CONSTRAINT `branchid` FOREIGN KEY (`branch_id`) REFERENCES `RealtyOffice` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Realtor`
--

LOCK TABLES `Realtor` WRITE;
/*!40000 ALTER TABLE `Realtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Realtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RealtyOffice`
--

DROP TABLE IF EXISTS `RealtyOffice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RealtyOffice` (
  `branch_id` char(10) NOT NULL,
  `branch_name` char(50) DEFAULT NULL,
  `address` char(50) DEFAULT NULL,
  `postal_code` char(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `postalcode_idx` (`postal_code`),
  CONSTRAINT `office` FOREIGN KEY (`postal_code`) REFERENCES `PostalCode` (`postal_code`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RealtyOffice`
--

LOCK TABLES `RealtyOffice` WRITE;
/*!40000 ALTER TABLE `RealtyOffice` DISABLE KEYS */;
INSERT INTO `RealtyOffice` VALUES ('1','UBC','2166 Western Pkwy, Vancouver, BC','V6T 1W6'),('2','Kits','2201 W 4th Ave, Vancouver,BC','V6K 1N9'),('3','Dunbar','3320 Crown St, Vancouver, BC','V6S 1A5'),('4','Downtown','1032 Alberni Street, Vancouver, BC','V6E 1A3'),('5','UBC',NULL,'V6T 1W6');
/*!40000 ALTER TABLE `RealtyOffice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rented`
--

DROP TABLE IF EXISTS `Rented`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rented` (
  `property_id` char(10) NOT NULL,
  `final_rent` int(11) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `customer_id` char(10) NOT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rented`
--

LOCK TABLES `Rented` WRITE;
/*!40000 ALTER TABLE `Rented` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rented` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Room` (
  `room_name` char(50) NOT NULL,
  `property_id` char(10) NOT NULL,
  `image_url` text,
  PRIMARY KEY (`room_name`,`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sold`
--

DROP TABLE IF EXISTS `Sold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sold` (
  `property_id` char(10) NOT NULL,
  `final_price` int(11) DEFAULT NULL,
  `date_sold` datetime DEFAULT NULL,
  `customer_id` char(10) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  KEY `ccid_idx` (`customer_id`),
  CONSTRAINT `sold1` FOREIGN KEY (`property_id`) REFERENCES `Property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sold2` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sold`
--

LOCK TABLES `Sold` WRITE;
/*!40000 ALTER TABLE `Sold` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sold` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
