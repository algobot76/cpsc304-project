CREATE DATABASE  IF NOT EXISTS `RentalDatabase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `RentalDatabase`;

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

LOCK TABLES `CustomerContactRealtor` WRITE;
/*!40000 ALTER TABLE `CustomerContactRealtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerContactRealtor` ENABLE KEYS */;
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

LOCK TABLES `ForRent` WRITE;
/*!40000 ALTER TABLE `ForRent` DISABLE KEYS */;
/*!40000 ALTER TABLE `ForRent` ENABLE KEYS */;
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

LOCK TABLES `PostalCode` WRITE;
/*!40000 ALTER TABLE `PostalCode` DISABLE KEYS */;
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
  `address` char(50) NOT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `type` char(50) DEFAULT NULL,
  `sq_ft` float DEFAULT NULL,
  `date_built` datetime DEFAULT NULL,
  `data_added` datetime DEFAULT NULL,
  `num_beds` int(11) DEFAULT NULL,
  `num_baths` float DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Property` WRITE;
/*!40000 ALTER TABLE `Property` DISABLE KEYS */;
/*!40000 ALTER TABLE `Property` ENABLE KEYS */;
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
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `customer_id` char(10) NOT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

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

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
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
  PRIMARY KEY (`feature_name`,`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `Feature` ENABLE KEYS */;
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
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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

LOCK TABLES `PostalCode` WRITE;
/*!40000 ALTER TABLE `PostalCode` DISABLE KEYS */;
INSERT INTO `PostalCode` VALUES ('k1p 5m7','ottawa','on'),('t2e 6j8','calgary','ab');
/*!40000 ALTER TABLE `PostalCode` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Property` (
  `property_id` char(10) NOT NULL,
  `address` char(50) NOT NULL,
  `postal_code` char(7) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Property` WRITE;
/*!40000 ALTER TABLE `Property` DISABLE KEYS */;
INSERT INTO `Property` VALUES ('100','a','b');
/*!40000 ALTER TABLE `Property` ENABLE KEYS */;
UNLOCK TABLES;

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
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Realtor` WRITE;
/*!40000 ALTER TABLE `Realtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Realtor` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `RealtyOffice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RealtyOffice` (
  `branch_id` char(10) NOT NULL,
  `branch_name` char(50) DEFAULT NULL,
  `address` char(50) DEFAULT NULL,
  `postal_code` char(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `RealtyOffice` WRITE;
/*!40000 ALTER TABLE `RealtyOffice` DISABLE KEYS */;
/*!40000 ALTER TABLE `RealtyOffice` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Sold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sold` (
  `property_id` char(10) NOT NULL,
  `final_price` int(11) DEFAULT NULL,
  `date_sold` datetime DEFAULT NULL,
  `customer_id` char(10) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
