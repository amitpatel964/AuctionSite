CREATE DATABASE IF NOT EXISTS `auctionSitedb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `auctionSitedb`;

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

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
	`username` varchar(50) NOT NULL DEFAULT '',
    `email` varchar(50) DEFAULT NULL,
    `firstName` varchar(50) DEFAULT NULL,
    `lastName` varchar(50) DEFAULT NULL,
	`password` varchar(50) DEFAULT NULL,
    `isCustRep` boolean DEFAULT 0,
	primary key (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
	`username` varchar(50) NOT NULL DEFAULT '',
	`password` varchar(50) DEFAULT NULL,
	primary key (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin','admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auction` (
	`auctionID` int NOT NULL DEFAULT 0,
    `creator` varchar(50) DEFAULT NULL,
    `auctionName` varchar(50) DEFAULT NULL,
    `initialPrice` float DEFAULT 0,
    `currentPrice` float DEFAULT 0,
    `minimumSellingPrice` float DEFAULT 0,
    `bidIncrement` float DEFAULT 0,
    `vehicleType` varchar(20) DEFAULT NULL,
    `startingDate` datetime DEFAULT NULL,
    `endingDate` datetime default NULL,
    `autoBidHighest` float default 0,
    `currentHighestBidder` varchar(50) default NULL,
    `winner` varchar(50) default NULL,
    `status` varchar(10) default NULL,
    primary key (`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `auctionBidHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auctionBidHistory` (
	`auctionID` int DEFAULT 0,
	`username` varchar(50) DEFAULT NULL,
    `bidAmount` float DEFAULT 0,
    `bidDateTime` datetime DEFAULT NULL,
    foreign key(`username`) references `user`(`username`),
    foreign key(`auctionID`) references `auction`(`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
	`vin` int NOT NULL DEFAULT 0,
    `numberOfDoors` int DEFAULT 0,
    `numberOfSeats` int DEFAULT 0,
    `mileage` int DEFAULT 0,
    `milesPerGallon` int DEFAULT 0,
    `fuelType` varchar(50) DEFAULT NULL,
    `newOrUsed` varchar(10) DEFAULT NULL,
    `manufacturer` varchar(50) DEFAULT NULL,
    `model` varchar(50) DEFAULT NULL,
    `year` int DEFAULT 0,
    `color` varchar(50) DEFAULT NULL,
    `transmissionType` varchar(50) DEFAULT NULL,
    `auctionID` int DEFAULT 0,
    primary key (`vin`),
    foreign key(`auctionID`) references `auction`(`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
	`typeOfCar` varchar(10) DEFAULT NULL,
    `isConvertible` varchar(5) DEFAULT NULL,
    `vin` int DEFAULT 0,
    foreign key(`vin`) references `vehicle`(`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `suv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suv` (
	`seatsExpandable` varchar(5) DEFAULT NULL,
    `vin` int DEFAULT 0,
    foreign key(`vin`) references `vehicle`(`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `van`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `van` (
	`vanMiniOrFull` varchar(10) DEFAULT NULL,
    `vin` int DEFAULT 0,
    foreign key(`vin`) references `vehicle`(`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `truck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `truck` (
	`isPickUpTruck` varchar(5) DEFAULT NULL,
    `numberOfWheels` int DEFAULT 0,
    `vin` int DEFAULT 0,
    foreign key(`vin`) references `vehicle`(`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `motorcycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motorcycle` (
	`hasStorage` varchar(5) DEFAULT NULL,
    `typeOfMotorCycle` varchar(50) DEFAULT NULL,
    `vin` int DEFAULT 0,
    foreign key(`vin`) references `vehicle`(`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `alertForBidOrWinner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alertForBidOrWinner` (
	`alertType` varchar(20) DEFAULT NULL,
    `username` varchar(50) DEFAULT NULL,
    `auctionID` int DEFAULT 0,
    `wasSeen` varchar(5) DEFAULT NULL,
    foreign key(`username`) references `user`(`username`),
    foreign key(`auctionID`) references `auction`(`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE If EXISTS `alertNotifyIfOutbid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alertNotifyIfOutbid` (
	`shouldNotify` varchar(5) DEFAULT NULL,
    `username` varchar(50) DEFAULT NULL,
    `auctionID` int DEFAULT 0,
    foreign key(`username`) references `user`(`username`),
    foreign key(`auctionID`) references `auction`(`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `alertForNewItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alertForNewItems` (
	`alertID` int NOT NULL DEFAULT 0,
    `username` varchar(50) DEFAULT NULL,
    `auctionID` int DEFAULT 0,
    `vehicleType` varchar(10) DEFAULT NULL,
    `manufacturer` varchar(50) DEFAULT NULL,
    `model` varchar(50) DEFAULT NULL,
    `year` int DEFAULT 0,
    `newOrUsed` varchar(10) DEFAULT NULL,
    `mileage` int DEFAULT 0,
    `wasSeen` varchar(5) DEFAULT NULL,
    primary key(`alertID`),
    foreign key(`username`) references `user`(`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;