/** Задание 1
Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)
**/
-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_25
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES (1,'ut',35627096,NULL,'1983-06-18 13:55:57','2010-10-12 17:36:29'),(2,'placeat',802827,NULL,'2012-11-20 09:52:45','1985-10-09 16:47:59'),(3,'soluta',2,NULL,'1996-09-28 21:45:16','1987-10-19 09:52:04'),(4,'non',994552,NULL,'1975-09-10 05:03:19','2001-05-13 20:51:34'),(5,'harum',34459243,NULL,'1972-09-04 17:27:12','1970-07-08 09:19:00'),(6,'ipsam',194393086,NULL,'2012-05-14 10:24:37','1998-07-09 01:15:48'),(7,'sed',126,NULL,'1971-04-17 06:32:36','1994-04-20 06:29:28'),(8,'saepe',768774469,NULL,'2010-10-25 13:40:47','1998-03-19 08:21:35'),(9,'quas',20472746,NULL,'2016-12-07 19:06:37','1982-10-06 13:27:54'),(10,'quis',0,NULL,'2006-11-16 16:29:32','1980-09-22 21:34:08');
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'quia',11),(2,'provident',12),(3,'aut',13),(4,'officiis',14),(5,'laborum',16),(6,'qui',17),(7,'quos',18),(8,'et',19),(9,'repudiandae',20),(10,'ut',11);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (11,11,'unfriended','2011-10-05 10:22:23','1974-11-08 06:20:31'),(12,12,'approved','2009-02-10 09:36:51','1970-01-10 20:27:45'),(13,13,'declined','1981-05-08 19:11:04','1993-11-16 18:29:32'),(14,14,'requested','1984-12-24 00:16:02','2009-06-01 12:55:58'),(16,16,'declined','1994-07-25 00:19:54','1987-11-08 02:39:53'),(17,17,'declined','1997-01-07 21:50:53','2003-09-24 21:48:02'),(18,18,'unfriended','1995-05-01 16:16:31','2008-08-21 12:36:16'),(19,19,'requested','2021-10-03 19:28:45','2003-10-27 05:05:53'),(20,20,'declined','2013-01-23 04:10:30','2007-12-01 13:50:53');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `media_id` (`media_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,11,1,'1997-09-12 15:33:42'),(2,12,2,'2021-11-07 16:59:00'),(3,13,3,'2018-11-21 01:00:53'),(4,14,4,'1982-04-13 02:41:49'),(5,16,5,'1980-02-08 08:00:33'),(6,17,6,'1999-08-27 00:32:53'),(7,18,7,'1984-12-05 18:02:17'),(8,19,8,'1981-03-05 00:16:06'),(9,20,9,'1987-02-03 01:26:17'),(10,11,10,'1975-06-28 04:15:10'),(11,12,1,'1973-08-06 06:14:31'),(12,13,2,'2002-08-01 17:29:34'),(13,14,3,'1988-07-26 01:26:29'),(14,16,4,'2014-01-11 10:57:22'),(15,17,5,'2006-12-27 23:42:55'),(16,18,6,'1996-02-17 02:15:02'),(17,19,7,'1973-12-30 00:01:43'),(18,20,8,'1993-08-21 16:58:00'),(19,11,9,'2017-08-14 07:18:43'),(20,12,10,'2011-11-08 22:35:49'),(21,13,1,'2010-12-29 21:12:58'),(22,14,2,'1987-10-03 09:27:49'),(23,16,3,'2011-01-11 13:06:54'),(24,17,4,'2010-12-24 09:01:23'),(25,18,5,'2016-02-24 22:26:15'),(26,19,6,'1977-08-29 17:16:02'),(27,20,7,'1979-08-26 19:21:46'),(28,11,8,'1997-04-11 07:09:50'),(29,12,9,'1990-01-18 20:08:34'),(30,13,10,'1978-05-01 01:06:05');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,11,'Quod laudantium maiores animi maiores quasi. Laborum sequi qui porro voluptatem consequatur. Odio est minus in.',NULL,'1991-07-20 10:19:55','1978-12-05 05:34:30'),(2,2,12,'Atque in aperiam aut odit quidem voluptate rerum. Dolor iste laudantium sed corporis. Sequi recusandae eos nisi recusandae molestiae beatae molestiae.',NULL,'2016-08-04 06:20:18','2009-05-15 15:26:54'),(3,3,13,'Et ut corporis optio voluptas labore rerum. Et omnis quisquam sunt placeat tenetur necessitatibus placeat. Repellat voluptate corrupti rerum sit et. Atque harum id consequuntur ad eum.',NULL,'1974-07-06 07:38:29','1998-01-07 22:57:03'),(4,4,14,'Eum sit saepe molestiae voluptas autem exercitationem nulla. Qui veniam aut nesciunt sunt. Error vitae et ut id.',NULL,'2013-05-23 03:24:58','1986-09-18 21:48:06'),(5,1,16,'Temporibus accusantium minus aut et doloribus. Aut excepturi natus reiciendis. Exercitationem quos cum dolores ut animi eos explicabo. Et veritatis laboriosam magnam quos.',NULL,'2004-07-03 10:37:01','2018-01-30 16:29:58'),(6,2,17,'Facilis aliquam aut est. Occaecati quia at architecto eum minima eos sint.',NULL,'1993-02-19 16:25:14','2019-08-29 04:38:42'),(7,3,18,'Veritatis molestiae ex dicta nemo est. Cumque quia ut doloribus quis sed dolores. Quas minima amet voluptas praesentium tenetur et.',NULL,'2017-10-18 23:02:44','2010-06-16 05:52:48'),(8,4,19,'Consequatur impedit minus mollitia. Nemo consequatur voluptatem nihil dolorum. Ratione veniam dolorum reprehenderit. Illo eaque aspernatur qui iure autem officia est nemo.',NULL,'1981-03-07 03:53:18','2003-10-12 02:31:18'),(9,1,20,'Non atque voluptatem eveniet numquam optio provident. Ea a molestias harum porro. Voluptates hic qui beatae alias explicabo non alias.',NULL,'2010-09-15 21:25:01','1992-11-24 11:04:16'),(10,2,11,'Nihil et consequatur quaerat autem eum nobis non. Quia cum neque in qui eos. Placeat et amet qui ullam. Maiores repellendus incidunt provident fuga praesentium magnam.',NULL,'2021-07-10 23:03:38','2007-12-28 05:56:03');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_attachments`
--

DROP TABLE IF EXISTS `media_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_attachments` (
  `media_id` bigint(20) unsigned NOT NULL,
  `attachment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`media_id`,`attachment_id`),
  KEY `attachment_id` (`attachment_id`),
  CONSTRAINT `media_attachments_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `media_attachments_ibfk_2` FOREIGN KEY (`attachment_id`) REFERENCES `attachments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_attachments`
--

LOCK TABLES `media_attachments` WRITE;
/*!40000 ALTER TABLE `media_attachments` DISABLE KEYS */;
INSERT INTO `media_attachments` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `media_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'totam','1986-11-19 10:08:03','2019-11-04 13:50:18'),(2,'nobis','2020-09-16 00:55:24','1984-03-11 14:35:58'),(3,'minus','1977-11-04 09:20:05','1973-05-06 04:46:25'),(4,'id','2010-09-23 06:56:20','2002-02-08 22:46:11');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_attachments`
--

DROP TABLE IF EXISTS `message_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_attachments` (
  `message_id` bigint(20) unsigned NOT NULL,
  `attachment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`message_id`,`attachment_id`),
  KEY `attachment_id` (`attachment_id`),
  CONSTRAINT `message_attachments_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `message_attachments_ibfk_2` FOREIGN KEY (`attachment_id`) REFERENCES `attachments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_attachments`
--

LOCK TABLES `message_attachments` WRITE;
/*!40000 ALTER TABLE `message_attachments` DISABLE KEYS */;
INSERT INTO `message_attachments` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `message_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,11,11,'Ipsam quos aliquid eaque ad error est non. Quis facilis culpa voluptate placeat.','1975-05-29 19:58:30'),(2,12,12,'Similique commodi enim ut est eum. Natus minima voluptas nihil totam aut. Cumque repudiandae libero beatae est et beatae ducimus. Cupiditate ipsa est corrupti.','2007-02-01 22:17:37'),(3,13,13,'Autem et corrupti totam aut sit. Placeat laborum quia omnis autem esse soluta. Quidem est qui harum id laborum quia non.','1997-01-25 05:47:09'),(4,14,14,'Ut impedit commodi ex reiciendis omnis consequatur enim. Ut facilis fugit velit blanditiis ut recusandae non quia. Nihil qui nobis quis ut ratione repudiandae.','1975-03-21 01:56:59'),(5,16,16,'Inventore consectetur laboriosam enim et. Culpa optio et eos quam ea qui. Voluptas qui et quia et et sequi. Blanditiis illo reiciendis molestias tempore.','2017-02-20 09:47:15'),(6,17,17,'Neque est ipsum necessitatibus soluta debitis velit ut. Natus corrupti rerum qui dolor est laboriosam. Ut qui id ex illo est.','1973-08-31 22:42:46'),(7,18,18,'Et exercitationem qui blanditiis sit occaecati tempora omnis quasi. Sed occaecati officia maxime neque. Eaque omnis et non magnam excepturi aut nam.','1981-05-04 08:24:49'),(8,19,19,'Quibusdam voluptates error in ratione. Eligendi voluptatem expedita voluptatem numquam. Sint voluptas nihil ut dolorem minus ut quisquam. Ab minus quidem odit consequatur tempora iste quos eos.','1970-06-07 20:37:59'),(9,20,20,'Quod numquam quis tempore eius. Recusandae est praesentium consequatur praesentium consectetur consequuntur omnis. In libero voluptas quo et fugit est. Explicabo dolorem quasi neque non placeat. Et odit aliquam esse deserunt et.','2021-03-13 23:28:23'),(10,11,11,'Ipsam eum accusamus omnis quo sed. Autem ad repudiandae in qui. Excepturi corporis optio veritatis enim consectetur aperiam.','1972-05-16 07:20:25'),(11,12,12,'Id similique inventore quo voluptatem reiciendis. Corporis sint quasi et est ipsam sint aspernatur. Voluptatem voluptate est deserunt qui.','1989-02-18 01:24:44'),(12,13,13,'Neque est dicta consequatur aliquam aperiam et. Fugiat maxime porro perspiciatis ut. Dignissimos iusto debitis commodi sunt minus sit.','2020-11-13 23:38:26'),(13,14,14,'Qui animi magnam dolores est voluptatem. Aut necessitatibus error et earum dolorum nesciunt. Quod laborum officia enim sed.','2003-04-27 18:22:39'),(14,16,16,'Inventore eum sed vitae corporis accusantium. Dolor qui dignissimos distinctio sed. Provident optio quia tenetur rerum aut quam. Sed amet sint qui soluta sit est optio ut. Doloremque ratione non et labore cupiditate qui.','1988-02-18 04:37:46'),(15,17,17,'Nihil non non vitae voluptatibus occaecati. Possimus minus alias voluptatem amet et. Facere assumenda quia omnis quaerat excepturi vel aspernatur. Nesciunt dolore nulla eum alias id dolorem eligendi.','2009-04-07 17:56:33'),(16,18,18,'Iure aut aut voluptatem amet vero veritatis quia. Aliquid velit ut nisi ea est fugiat atque explicabo. Eos animi sunt qui ut.','2001-03-22 16:51:00'),(17,19,19,'Quia voluptas voluptatem est ducimus et totam. Debitis aut voluptatem ipsa incidunt qui sapiente est. Iure quaerat unde nemo nulla quae dolor qui. Exercitationem necessitatibus optio aspernatur pariatur nihil itaque eum.','1986-04-20 19:39:20'),(18,20,20,'Eius non laudantium temporibus quas. Consectetur ducimus et quis quo et et. Rerum qui nesciunt tempore voluptatem in.','1999-10-06 13:57:22'),(19,11,11,'Laboriosam sed provident velit earum quia laudantium. Adipisci dolores omnis libero quo non saepe fugit sit. Et illum quos quas dolorem recusandae alias omnis.','1999-12-02 17:35:42'),(20,12,12,'Quibusdam veniam magnam vel maxime porro alias ullam nemo. Qui impedit ratione vitae recusandae. Ullam qui non sint fugiat libero at. Rem sed consequatur sunt eligendi. Dolorem illo aspernatur nihil aut dolor ratione.','1990-06-24 05:33:37'),(21,13,13,'Suscipit soluta aut dignissimos consequuntur. Odio hic omnis et aperiam laboriosam tempora. Quia fugiat tenetur eum quidem qui. Nesciunt ea dolorem ea sed inventore ea quam.','2011-11-09 21:54:27'),(22,14,14,'Quae alias sunt autem. Architecto facilis autem et. Ratione aut repellendus incidunt voluptatem. Illo et doloremque iusto est rem magni.','2000-07-21 05:43:29'),(23,16,16,'Non voluptatem itaque odio est veritatis facere aut architecto. Et vel in cumque id dolor similique id nihil. Magni nihil et quia perferendis sunt.','1995-04-19 23:52:35'),(24,17,17,'Id qui nisi eum rerum. Omnis est aut officiis aspernatur et. Aut nemo sunt officia a est explicabo sint. Aperiam qui facilis ea sed et modi delectus.','1973-10-14 21:48:34'),(25,18,18,'Consectetur dolore dolorem sapiente repellendus consequatur. Quos est sequi nihil autem aliquid. Nostrum accusantium dolor nemo nihil eius. Nostrum eveniet cupiditate in voluptas repudiandae dolorem beatae veritatis.','2021-12-21 13:26:23'),(26,19,19,'Qui nulla molestias animi omnis maxime. Atque aliquid magnam ipsam accusantium explicabo dolores. Ullam illo est rerum ea et asperiores delectus ipsum. Itaque exercitationem dolores et officiis porro esse.','2022-02-23 23:09:23'),(27,20,20,'Ex aut quis cumque non voluptatum veniam. Qui rerum et necessitatibus sint et. Soluta exercitationem quae omnis qui odio odio. Vero maiores consectetur ullam harum quisquam dolor.','1987-08-03 04:36:42'),(28,11,11,'Officiis laudantium molestiae quos. Cum non delectus sint architecto. Doloremque debitis est commodi. Accusantium amet ab necessitatibus consequatur corrupti ea quidem doloribus.','1987-10-08 17:38:40'),(29,12,12,'Ad dolores ex molestiae ad mollitia. Nemo quisquam corrupti repudiandae voluptatem eum corporis. Possimus qui et impedit ullam doloribus qui et.','1999-07-26 04:16:26'),(30,13,13,'Iusto minus nobis ut adipisci. Id et nemo illum quo numquam. Et aperiam quod repellendus.','2018-12-22 00:02:40');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'sapiente',11),(2,'et',12),(3,'est',13),(4,'eaque',14),(5,'et',16),(6,'voluptas',17),(7,'voluptatem',18),(8,'perferendis',19),(9,'sint',20),(10,'vitae',11);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  KEY `photo_id` (`photo_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `profiles_ibfk_2` FOREIGN KEY (`photo_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (11,'1','1996-09-18',1,'1973-03-23 13:35:49','es_CL'),(12,'1','1993-06-10',2,'2000-03-04 08:48:22','en_GU'),(13,'','1982-03-24',3,'1989-10-14 17:49:25','nb_NO'),(14,'','2009-05-26',4,'1983-06-22 00:54:40','fr_FR'),(16,'','1998-02-07',5,'2013-07-04 17:23:18','zu_ZA'),(17,'1','2009-02-08',6,'2002-02-15 05:18:17','lo_LA'),(18,'','1994-07-23',7,'1980-04-06 05:43:44','km_KH'),(19,'1','2018-03-15',8,'2004-07-06 02:26:05','ts_ZA'),(20,'1','1987-12-14',9,'1997-07-29 23:01:50','hi_IN');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='юзеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'Hildegard','Johnson','marc52@example.net','9ef6be8ea1c5f159a2bb94c26242a6952d8afad3',8272),(12,'Eleonore','Marquardt','green.ima@example.net','e3d6702be5d9f300122864323a36eab9066c6a47',352052),(13,'Erica','Windler','jeramie.haag@example.net','b39777a6bd91a16499abdf6dd8cabde1c30811b8',932509),(14,'Penelope','Kilback','octavia28@example.net','85ea912389a5b4d92d73042a2d7959ef88b8d479',0),(16,'Jaleel','Hermiston','brayan.champlin@example.net','33521b9e8516b3caadc55b6fea2698d6cd9f5ca7',1),(17,'Silas','Powlowski','daugherty.anastacio@example.org','c5174bd5bec850de5e60022b1593d6bd0da13780',201400),(18,'Vincent','Swift','shayna.vandervort@example.com','1f23d847b5c96c473b40d628cdf5ba5977e8e350',3242066752),(19,'Adolph','Ebert','abigayle88@example.com','9f8f40bbe661086a4cf8ca89ece66e2224077549',19409),(20,'Raina','Cormier','deonte07@example.net','01594b4ff8fbbe5951c788d27d37a0c0bbc0855b',836784);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (11,1),(11,10),(12,2),(13,3),(14,4),(16,5),(17,6),(18,7),(19,8),(20,9);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-14  6:38:21


/** Задание 2
Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
**/
select distinct firstname from users order by firstname;

/** Задание 3
Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
  Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
**/
alter table profiles add column is_active BOOLEAN default true;
update profiles set profiles.is_active = false where birthday<DATE_SUB(birthday,INTERVAL 18 YEAR);

/** Задание 4
Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).
**/
# Да, в моем случае через процедуру будет проще удалять, сохраняя текущую дату в переменную
delete from message_attachments where message_id in (select id from messages where created_at>current_timestamp());
delete from messages where created_at>current_timestamp();


/** Задание 5
Написать название темы курсового проекта (в комментарии)
**/
# управление финансами