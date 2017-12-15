CREATE DATABASE IF NOT EXISTS `HOTELDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `HOTELDB`;
-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: cs336-1.c28ltethrrc0.us-east-1.rds.amazonaws.com    Database: HOTELDB
-- ------------------------------------------------------
-- Server version	5.6.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel` (
  `hotelID` int NOT NULL auto_increment,
  `hotel_name` varchar(50) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `zipcode` int DEFAULT 1,
  PRIMARY KEY (`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `HotelPhoneNumbers`
--
DROP TABLE IF EXISTS `HotelPhoneNumbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HotelPhoneNumbers` (
  `hotelID` int NOT NULL DEFAULT 1,
  `phone_no` varchar(30) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`hotelID`, `phone_no`),
  FOREIGN KEY (`hotelID`) REFERENCES `hotel`(`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `myroom`
--
DROP TABLE IF EXISTS `myroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myroom` (
  `room_num` INT NOT NULL DEFAULT 1,
  `hotelID` INT NOT NULL DEFAULT 1,
  `price` FLOAT DEFAULT NULL,
  `capacity` INT DEFAULT NULL,
  `floor_no` INT NOT NULL DEFAULT 1,
  `description` varchar(250) DEFAULT NULL,
  `room_type` ENUM('standard','double','deluxe','suite'),
  PRIMARY KEY (`room_num`, `hotelID`),
  FOREIGN KEY (`hotelID`) REFERENCES `hotel`(`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `room_discount`
--
DROP TABLE IF EXISTS `room_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_discount` (
  `room_no` INT NOT NULL DEFAULT 1,
  `hotelID` INT NOT NULL DEFAULT 1,
  `discount` FLOAT NOT NULL DEFAULT 1,
  `sdate` DATE NOT NULL DEFAULT '2008-7-04',
  `edate` DATE NOT NULL DEFAULT '2008-7-04',
  PRIMARY KEY (`hotelID`,`room_no`, `sdate`,`edate`,`discount`),
  FOREIGN KEY (`room_no`, `hotelID`) REFERENCES `myroom`(`room_num`, `hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `customer`
--
DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT ' ',
  `password` varchar (100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `PHONE_NUM` int DEFAULT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `reservation`
--
DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `invoiceNo` INT NOT NULL auto_increment,
  `CID` INT NOT NULL DEFAULT 1,
  `totalAmt` FLOAT DEFAULT NULL,
  `resDate` DATE NOT NULL DEFAULT '2008-7-04',
  PRIMARY KEY (`invoiceNO`),
  FOREIGN KEY (`CID`) REFERENCES `customer`(`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `reserves`
--
DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserves` (
  `invoiceNo` INT NOT NULL DEFAULT 1,
  `room_num` INT NOT NULL DEFAULT 1,
  `hotelID` INT NOT NULL DEFAULT 1,
  `noOfDays` INT DEFAULT NULL,
  `inDate` DATE NOT NULL DEFAULT '2008-7-04',
  `outDate` DATE NOT NULL DEFAULT '2008-7-04',
  PRIMARY KEY (`invoiceNo`,`room_num`,`hotelID`),
  FOREIGN KEY (`invoiceNo`) REFERENCES `reservation`(`invoiceNo`),
  FOREIGN KEY (`room_num`,`hotelID`) REFERENCES `myroom`(`room_num`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `breakfast`
--
DROP TABLE IF EXISTS `breakfast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `breakfast` (
  `bType` varchar(20) NOT NULL DEFAULT ' ',
  `hotelID` INT NOT NULL DEFAULT 1,
  `description` varchar(256) DEFAULT NULL,
  `bPrice` float DEFAULT NULL,
  PRIMARY KEY (`bType`,`hotelID`),
  FOREIGN KEY (`hotelID`) REFERENCES `hotel`(`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `services`
--
DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `stype` varchar(20) NOT NULL DEFAULT ' ',
  `hotelID` INT NOT NULL DEFAULT 1,
  `sCost` float DEFAULT NULL,
  PRIMARY KEY (`sType`,`hotelID`),
  FOREIGN KEY (`hotelID`) REFERENCES `hotel`(`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `review`
--
DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `reviewID` int NOT NULL auto_increment,
  `CID` int NOT NULL DEFAULT 1,
  `rating` int DEFAULT NULL,
  `title` varchar (100) DEFAULT NULL,
  `textcomment` varchar(1028) DEFAULT NULL,
  `review_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  FOREIGN KEY (`CID`) REFERENCES `customer`(`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `room_review`
--
DROP TABLE IF EXISTS `room_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_review` (
  `reviewID` int NOT NULL DEFAULT 1,
  `room_num` int DEFAULT NULL,
  `hotelID` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  FOREIGN KEY (`reviewID`) REFERENCES `review`(`reviewID`),
  FOREIGN KEY (`room_num`,`hotelID`) REFERENCES `myroom`(`room_num`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `breakfast_review`
--
DROP TABLE IF EXISTS `breakfast_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `breakfast_review` (
  `reviewID` int NOT NULL DEFAULT 1,
  `bType` varchar(20) DEFAULT NULL,
  `hotelID` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  FOREIGN KEY (`reviewID`) REFERENCES `review`(`reviewID`),
  FOREIGN KEY (`bType`,`hotelID`) REFERENCES `breakfast`(`bType`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `service_review`
--
DROP TABLE IF EXISTS `service_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_review` (
  `reviewID` int NOT NULL DEFAULT 1,
  `sType` varchar(20) DEFAULT NULL,
  `hotelID` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  FOREIGN KEY (`reviewID`) REFERENCES `review`(`reviewID`),
  FOREIGN KEY (`sType`,`hotelID`) REFERENCES `services`(`sType`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `includes`
--
DROP TABLE IF EXISTS `includes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `includes` (
  `invoiceNo` INT NOT NULL DEFAULT 1,
  `num_of_breakfasts` INT NOT NULL DEFAULT 1,
  `hotelID` INT NOT NULL DEFAULT 1,
  `bType` varchar(20) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`invoiceNo`,`bType`,`hotelID`),
  FOREIGN KEY (`invoiceNo`) REFERENCES `reservation`(`invoiceNo`),
  FOREIGN KEY (`bType`,`hotelID`) REFERENCES `breakfast`(`bType`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `contains`
--
DROP TABLE IF EXISTS `contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contains` (
  `invoiceNo` INT NOT NULL DEFAULT 1,
  `num_of_services` INT NOT NULL DEFAULT 1,
  `hotelID` INT NOT NULL DEFAULT 1,
  `sType` varchar(20) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`invoiceNo`,`sType`,`hotelID`),
  FOREIGN KEY (`invoiceNo`) REFERENCES `reservation`(`invoiceNo`),
  FOREIGN KEY (`sType`,`hotelID`) REFERENCES `services`(`sType`,`hotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table creditcard
--
DROP TABLE IF EXISTS `creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditcard` (
  `CNumber` INT NOT NULL DEFAULT 1,
  `CID` INT NOT NULL DEFAULT 1,
  `InvoiceNo` INT NOT NULL DEFAULT 1,
  `Name` varchar(30) DEFAULT NULL,
  `ExpDate` DATE DEFAULT NULL,
  `Type` varchar (20) DEFAULT NULL,
  `SecCode` INT NOT NULL DEFAULT 1,
  `BillingAddr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CNumber`, `CID`, `InvoiceNo`),
  FOREIGN KEY (`CID`) REFERENCES `customer`(`CID`),
  FOREIGN KEY (`InvoiceNo`) REFERENCES `reservation`(`invoiceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-24 15:40:46