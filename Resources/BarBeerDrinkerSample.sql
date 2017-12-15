CREATE DATABASE  IF NOT EXISTS `BarBeerDrinkerSample` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `BarBeerDrinkerSample`;
-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: cs336-1.c28ltethrrc0.us-east-1.rds.amazonaws.com    Database: BarBeerDrinker
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
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bars`
--

DROP TABLE IF EXISTS `bars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bars` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `license` varchar(7) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bars`
--

LOCK TABLES `bars` WRITE;
/*!40000 ALTER TABLE `bars` DISABLE KEYS */;
INSERT INTO `bars` VALUES ('A.P. Stump\'s','MA12347','Boston',NULL,NULL),('Blue Angel','CA45678','San Francisco',NULL,NULL),('Blue Tattoo','CA45678','San Francisco','415-567-1289','1500 Market St.'),('Britannia Arms','MA12346','Boston','345-567-1289',NULL),('Cabana','CA45678','San Francisco',NULL,'1200 California Ave.'),('Caravan','IL12345','Chicago',NULL,NULL),('Club 175','CA45678','San Francisco','415-567-1289',NULL),('Coconut Willie\'s Cocktail Lounge','CA45678','San Francisco','415-567-1289',NULL),('Eulipia','IL12346','Chicago','123-456-7890','1060 West Addison'),('Gecko Grill','IL12348','Chicago',NULL,'1060 West Addison'),('Giza Hookah Lounge','IL12349','Chicago','345-678-9012',NULL),('Hedley Club','NY12345','New York',NULL,'161st St and River Ave'),('Il Fornaio','NY12346','New York',NULL,'161st St and River Ave'),('Seven Bamboo','NY12347','New York',NULL,'161st St and River Ave'),('The B-Hive','MA12348','Boston','345-567-1280',NULL),('The Backbeat','CA45678','San Francisco','415-567-1289',NULL),('The Blank Club','MA12349','Boston','345-567-1281',NULL),('The Shark and Rose','MA12345','Boston',NULL,NULL);
/*!40000 ALTER TABLE `bars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beers`
--

DROP TABLE IF EXISTS `beers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `manf` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beers`
--

LOCK TABLES `beers` WRITE;
/*!40000 ALTER TABLE `beers` DISABLE KEYS */;
INSERT INTO `beers` VALUES ('Blue Moon','Coors Brewing Company'),('Budweiser','Anheuser-Busch'),('Creamy Dark','Jacob Leinenkugel Brewing Company'),('Extra Gold','Coors Brewing Company'),('Hefeweizen','Jacob Leinenkugel Brewing Company'),('Hefeweizen Doppelbock','Jacob Leinenkugel Brewing Company'),('Heiniken','Heiniken Inernational'),('ICEHOUSE','Plank Road Brewery'),('Killian\'s','Coors Brewing Company'),('Michelob Amber Bock','Anheuser-Busch'),('Michelob Golden Draft','Anheuser-Busch'),('Michelob Golden Draft Light','Anheuser-Busch'),('Michelob ULTRA','Anheuser-Busch'),('Original Premium','Jacob Leinenkugel Brewing Company'),('Original Premium Lager','Jacob Leinenkugel Brewing Company'),('Original Premium Lager Dog','Plank Road Brewery'),('Sauza Diablo','Miller Brewing Company'),('Southpaw Light','Plank Road Brewery'),('Stolichnaya Citrona','Miller Brewing Company'),('Zima','Coors Brewing Company'),('Zima Citrus','Coors Brewing Company');
/*!40000 ALTER TABLE `beers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinkers`
--

DROP TABLE IF EXISTS `drinkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinkers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinkers`
--

LOCK TABLES `drinkers` WRITE;
/*!40000 ALTER TABLE `drinkers` DISABLE KEYS */;
INSERT INTO `drinkers` VALUES ('Bob','San Francisco','415-234-6789',NULL),('Erik','San Francisco','415-234-6789',NULL),('Herb','Boston',NULL,NULL),('Jesse','San Francisco','415-234-6789',NULL),('John','Chicago',NULL,'1060 West Addison'),('Justin','Boston',NULL,NULL),('Mike','Boston',NULL,NULL),('Rebecca','Chicago',NULL,'1060 West Addison'),('Thomas ','New York',NULL,'160 River Ave'),('Tom','Chicago',NULL,'1060 West Addison'),('Vince','New York','234-456-7890','161st St and River Ave');
/*!40000 ALTER TABLE `drinkers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frequents`
--

DROP TABLE IF EXISTS `frequents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frequents` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `bar` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`bar`),
  KEY `fk_frequents_bar` (`bar`),
  CONSTRAINT `fk_frequents_bar` FOREIGN KEY (`bar`) REFERENCES `bars` (`name`),
  CONSTRAINT `fk_frequents_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frequents`
--

LOCK TABLES `frequents` WRITE;
/*!40000 ALTER TABLE `frequents` DISABLE KEYS */;
INSERT INTO `frequents` VALUES ('Mike','A.P. Stump\'s'),('Bob','Blue Angel'),('Erik','Blue Angel'),('Herb','Blue Angel'),('Jesse','Blue Angel'),('John','Blue Angel'),('Justin','Blue Angel'),('Mike','Blue Angel'),('Rebecca','Blue Angel'),('Tom','Blue Angel'),('Vince','Blue Angel'),('Mike','Cabana'),('John','Caravan'),('Tom','Caravan'),('Bob','Coconut Willie\'s Cocktail Lounge'),('Rebecca','Coconut Willie\'s Cocktail Lounge'),('Justin','Gecko Grill'),('Rebecca','Gecko Grill'),('Herb','Seven Bamboo'),('Thomas','Seven Bamboo'),('Vince','Seven Bamboo'),('Mike','The Shark and Rose');
/*!40000 ALTER TABLE `frequents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `beer` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`beer`),
  KEY `fk_likes_beer` (`beer`),
  CONSTRAINT `fk_likes_beer` FOREIGN KEY (`beer`) REFERENCES `beers` (`name`),
  CONSTRAINT `fk_likes_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES ('John','Blue Moon'),('Mike','Blue Moon'),('John','Budweiser'),('Mike','Budweiser'),('John','Creamy Dark'),('Mike','Creamy Dark'),('Mike','Hefeweizen'),('John','Killian\'s'),('John','Michelob Golden Draft'),('Mike','Michelob Golden Draft Light'),('John','Original Premium'),('Mike','Original Premium Lager'),('Jesse','Original Premium Lager Dog'),('Mike','Original Premium Lager Dog'),('John','Stolichnaya Citrona');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myTable`
--

DROP TABLE IF EXISTS `myTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myTable` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` mediumint(9) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `Age` mediumint(9) DEFAULT NULL,
  `Weight` mediumint(9) DEFAULT NULL,
  `Height` mediumint(9) DEFAULT NULL,
  `Workout_Time` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myTable`
--

LOCK TABLES `myTable` WRITE;
/*!40000 ALTER TABLE `myTable` DISABLE KEYS */;
INSERT INTO `myTable` VALUES (1,1,'Alexander, Alyssa D.','Male',52,272,52,25),(2,2,'Marsh, Jocelyn M.','Male',32,275,74,10),(3,3,'Randall, Serina L.','Male',75,102,74,39),(4,4,'Townsend, Fiona U.','Female',45,159,71,7),(5,5,'Fitzgerald, Aspen Y.','Male',7,255,63,20),(6,6,'Eaton, Carla H.','Male',100,158,58,28),(7,7,'Bush, Finn M.','Female',7,88,69,16),(8,8,'Fletcher, Ezra L.','Female',39,226,84,32),(9,9,'Carver, Uma N.','Female',87,83,82,3),(10,10,'Rich, William R.','Male',88,130,82,30),(11,11,'Wyatt, Ralph C.','Female',70,84,65,2),(12,12,'Nunez, Joan N.','Female',96,106,65,31),(13,13,'Stanley, Daquan F.','Male',32,141,71,2),(14,14,'Odonnell, Melodie T.','Female',39,276,55,2),(15,15,'Booth, Deirdre K.','Male',74,113,72,32),(16,16,'Oconnor, Luke I.','Female',98,104,54,23),(17,17,'Jennings, Dean O.','Male',49,228,84,33),(18,18,'Byrd, Darryl D.','Male',62,274,82,33),(19,19,'Ross, Wanda H.','Male',57,255,68,36),(20,20,'Silva, Lev Q.','Male',96,128,59,31),(21,21,'George, Sydnee Z.','Female',69,147,56,14),(22,22,'Woods, Josiah Q.','Female',24,274,52,26),(23,23,'Bailey, Uma I.','Female',14,181,73,24),(24,24,'Weaver, Ayanna N.','Female',46,262,64,1),(25,25,'Watts, Vielka T.','Female',54,87,69,2),(26,26,'Jackson, Allen B.','Female',54,151,62,24),(27,27,'Flynn, Garth Y.','Female',39,155,70,5),(28,28,'Hartman, Inez N.','Female',37,259,69,15),(29,29,'Summers, Emerald A.','Male',17,95,83,13),(30,30,'Byers, Larissa V.','Female',21,189,67,23),(31,31,'Clay, Velma J.','Female',30,198,60,29),(32,32,'Koch, Chandler N.','Male',57,190,60,10),(33,33,'Rivera, Kitra T.','Female',61,213,83,9),(34,34,'Mcclure, Galena Z.','Female',51,270,76,24),(35,35,'Phelps, Hakeem C.','Male',48,256,75,20),(36,36,'Hanson, Signe J.','Male',55,95,80,31),(37,37,'Cherry, Aaron L.','Female',45,92,60,6),(38,38,'Mercado, Emerald V.','Female',33,287,83,19),(39,39,'Stevenson, Brynne F.','Male',45,119,63,31),(40,40,'Vazquez, Inez A.','Female',57,132,81,31),(41,41,'Phillips, Hollee B.','Male',69,123,82,33),(42,42,'Armstrong, Alma Y.','Female',73,137,77,16),(43,43,'Patterson, Yoko K.','Male',52,251,82,0),(44,44,'Calhoun, Dawn Z.','Male',40,91,55,7),(45,45,'Hatfield, Kelly Q.','Female',71,254,75,38),(46,46,'Wilcox, Talon H.','Male',69,293,55,29),(47,47,'Schneider, Jana G.','Female',64,213,71,13),(48,48,'Lancaster, Colt A.','Male',50,92,56,23),(49,49,'Beard, Cairo S.','Female',50,90,52,28),(50,50,'Lee, Anika D.','Female',91,155,62,9),(51,51,'Scott, Cade A.','Male',94,243,73,5),(52,52,'Cleveland, Kyla O.','Female',8,173,84,20),(53,53,'Simpson, Rhoda X.','Female',24,221,71,39),(54,54,'Pierce, Xenos O.','Male',20,189,81,6),(55,55,'Guy, Marsden D.','Female',56,244,57,2),(56,56,'Lane, Amery X.','Female',17,85,81,10),(57,57,'Strickland, Teagan A.','Male',35,215,52,40),(58,58,'Clemons, Martina U.','Male',31,276,60,2),(59,59,'Caldwell, Yuri R.','Male',87,109,54,27),(60,60,'Hyde, Adena C.','Male',16,189,77,34),(61,61,'Calhoun, Owen E.','Female',84,254,81,13),(62,62,'Cleveland, Alan R.','Male',68,223,58,34),(63,63,'Duran, Cassady A.','Female',35,104,81,35),(64,64,'Burton, Zeus O.','Female',36,115,70,0),(65,65,'Nicholson, Damon U.','Female',76,234,84,2),(66,66,'Boyle, Medge Z.','Male',78,112,76,24),(67,67,'Hall, Ivor D.','Female',9,229,53,25),(68,68,'Ruiz, Virginia M.','Female',44,294,55,4),(69,69,'Morton, Gloria X.','Male',87,84,74,30),(70,70,'Klein, Sandra N.','Female',62,191,70,6),(71,71,'Durham, Dorian E.','Male',89,192,83,5),(72,72,'Landry, Bert R.','Male',7,105,58,25),(73,73,'Gomez, Branden I.','Female',19,298,72,15),(74,74,'Delacruz, Vincent Q.','Male',76,175,60,31),(75,75,'Woodard, Ursula V.','Male',68,185,61,25),(76,76,'Armstrong, James G.','Male',79,284,76,31),(77,77,'Gould, Jerry A.','Female',83,256,55,9),(78,78,'Pickett, Latifah W.','Male',87,253,68,26),(79,79,'Curry, Maxwell P.','Male',83,152,71,24),(80,80,'Knowles, Jaden R.','Female',84,279,82,35),(81,81,'Armstrong, Brendan L.','Female',94,80,58,38),(82,82,'Middleton, Neve C.','Female',77,91,64,26),(83,83,'Davenport, Garrett R.','Male',9,196,69,6),(84,84,'Saunders, Scott P.','Female',62,101,64,40),(85,85,'Russell, Riley H.','Male',14,153,82,14),(86,86,'Reyes, Charlotte N.','Female',31,128,72,8),(87,87,'Frost, Norman A.','Female',30,246,63,30),(88,88,'Lott, Ivana O.','Male',54,258,56,0),(89,89,'Sawyer, Allistair S.','Male',63,251,68,29),(90,90,'Graves, Sheila T.','Female',82,243,66,36),(91,91,'Mcgee, Vernon L.','Male',85,293,75,38),(92,92,'Padilla, Ila E.','Male',31,123,67,37),(93,93,'Stone, Quinn X.','Female',60,299,56,34),(94,94,'Thompson, Byron I.','Male',92,299,58,38),(95,95,'Fletcher, Cassandra F.','Male',82,140,81,4),(96,96,'Gardner, Caryn L.','Female',28,182,77,22),(97,97,'Herman, Guy H.','Male',31,170,77,36),(98,98,'Petty, Richard Y.','Female',94,139,76,28),(99,99,'Pacheco, Dieter B.','Male',12,243,76,40),(100,100,'Solis, Rylee T.','Female',39,190,52,40);
/*!40000 ALTER TABLE `myTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sells` (
  `bar` varchar(50) NOT NULL DEFAULT '',
  `beer` varchar(50) NOT NULL DEFAULT '',
  `price` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`bar`,`beer`),
  KEY `fk_sells_beer` (`beer`),
  CONSTRAINT `fk_sells_bar` FOREIGN KEY (`bar`) REFERENCES `bars` (`name`),
  CONSTRAINT `fk_sells_beer` FOREIGN KEY (`beer`) REFERENCES `beers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES ('A.P. Stump\'s','Hefeweizen',6.00),('Blue Angel','Hefeweizen Doppelbock',5.50),('Blue Angel','Original Premium Lager Dog',6.25),('Blue Tattoo','Killian\'s',6.00),('Britannia Arms','Budweiser',6.50),('Cabana','Budweiser',5.00),('Cabana','Heiniken',5.00),('Caravan','Budweiser',5.50),('Caravan','Heiniken',5.50),('Caravan','Original Premium Lager Dog',3.50),('Club 175','Budweiser',4.50),('Coconut Willie\'s Cocktail Lounge','Budweiser',3.25),('Eulipia','Hefeweizen Doppelbock',4.50),('Gecko Grill','Budweiser',3.00),('Giza Hookah Lounge','Stolichnaya Citrona',6.00),('Hedley Club','Hefeweizen',8.00),('Seven Bamboo','Budweiser',2.50),('The B-Hive','Michelob Amber Bock',5.00),('The Backbeat','Killian\'s',3.50),('The Blank Club','Budweiser',5.50),('The Shark and Rose','Budweiser',4.50),('The Shark and Rose','Original Premium Lager Dog',5.50);
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-24 15:40:46