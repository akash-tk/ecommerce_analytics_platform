-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: ecom_db
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

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
-- Table structure for table `analytics_app_category`
--

DROP TABLE IF EXISTS `analytics_app_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_category`
--

LOCK TABLES `analytics_app_category` WRITE;
/*!40000 ALTER TABLE `analytics_app_category` DISABLE KEYS */;
INSERT INTO `analytics_app_category` VALUES (2,'Electronics','2024-10-11 03:59:01.260767','2024-10-11 03:59:01.325635'),(3,'Clothing','2024-10-11 03:59:01.260767','2024-10-11 03:59:01.325635'),(4,'Home & Kitchen','2024-10-11 03:59:01.260767','2024-10-11 03:59:01.325635');
/*!40000 ALTER TABLE `analytics_app_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_customer`
--

DROP TABLE IF EXISTS `analytics_app_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `country` varchar(100) NOT NULL,
  `registration_date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_customer`
--

LOCK TABLES `analytics_app_customer` WRITE;
/*!40000 ALTER TABLE `analytics_app_customer` DISABLE KEYS */;
INSERT INTO `analytics_app_customer` VALUES (1,'John Doe','john.doe@example.com','USA','2024-10-07 05:16:28.000000','2024-10-11 03:59:01.354958','2024-10-11 03:59:01.385475'),(2,'Jane Smith','jane.smith@example.com','UK','2024-10-07 05:16:59.000000','2024-10-11 03:59:01.354958','2024-10-11 03:59:01.385475'),(3,'Alice Johnson','alice.johnson@example.com','UK','2024-10-07 05:17:21.000000','2024-10-11 03:59:01.354958','2024-10-11 03:59:01.385475'),(4,'John Doe','johndoe@example.com','USA','2024-10-07 00:00:00.000000','2024-10-11 03:59:01.354958','2024-10-11 03:59:01.385475'),(6,'Test','test@gmail.com','USA','2024-10-11 06:29:00.000000','2024-10-11 06:30:00.199389','2024-10-11 06:30:00.199404'),(7,'Otis','otis@gmail.com','germany','2024-10-15 05:55:53.000000','2024-10-15 05:59:58.192346','2024-10-15 05:59:58.192356'),(8,'Millie','millie@gmail.com','canada','2024-10-15 06:03:36.000000','2024-10-15 06:05:14.949486','2024-10-15 06:05:14.949507'),(9,'Ruby','ruby@gmail.com','uk','2024-10-15 06:25:42.000000','2024-10-15 06:26:14.889730','2024-10-15 06:26:14.889749'),(10,'Dustin','dustin@gmail.com','canada','2024-10-15 06:27:40.000000','2024-10-15 06:28:37.708496','2024-10-15 06:28:37.708520'),(11,'Mike','mike@gmail.com','canada','2024-10-15 06:29:18.000000','2024-10-15 06:29:39.043515','2024-10-15 06:29:39.043564');
/*!40000 ALTER TABLE `analytics_app_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_inventory`
--

DROP TABLE IF EXISTS `analytics_app_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_inventory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `last_restocked_date` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  CONSTRAINT `analytics_app_invent_product_id_a1dfd4dc_fk_analytics` FOREIGN KEY (`product_id`) REFERENCES `analytics_app_product` (`id`),
  CONSTRAINT `analytics_app_inventory_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_inventory`
--

LOCK TABLES `analytics_app_inventory` WRITE;
/*!40000 ALTER TABLE `analytics_app_inventory` DISABLE KEYS */;
INSERT INTO `analytics_app_inventory` VALUES (1,6,'2024-10-07 05:22:06.000000',2,'2024-10-11 03:59:01.414959','2024-10-11 06:28:41.648913'),(2,4,'2024-10-15 06:27:01.255647',3,'2024-10-11 03:59:01.414959','2024-10-15 06:27:01.255654'),(3,5,'2024-10-15 06:34:06.250720',4,'2024-10-11 03:59:01.414959','2024-10-15 06:34:06.250729'),(4,4,'2024-10-15 06:06:36.169901',5,'2024-10-11 03:59:01.414959','2024-10-15 06:06:36.169924');
/*!40000 ALTER TABLE `analytics_app_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_order`
--

DROP TABLE IF EXISTS `analytics_app_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_date` datetime(6) NOT NULL,
  `status` varchar(20) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `customer_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_app_order_customer_id_26d55313_fk_analytics` (`customer_id`),
  CONSTRAINT `analytics_app_order_customer_id_26d55313_fk_analytics` FOREIGN KEY (`customer_id`) REFERENCES `analytics_app_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_order`
--

LOCK TABLES `analytics_app_order` WRITE;
/*!40000 ALTER TABLE `analytics_app_order` DISABLE KEYS */;
INSERT INTO `analytics_app_order` VALUES (1,'2024-10-07 05:17:58.000000','canceled',849.98,1,'2024-10-11 03:59:01.470632','2024-10-11 06:28:41.651388'),(4,'2024-10-07 00:00:00.000000','delivered',100.00,1,'2024-10-11 03:59:01.470632','2024-10-11 03:59:01.500685'),(5,'2024-10-07 00:00:00.000000','delivered',100.00,1,'2024-10-11 03:59:01.470632','2024-10-11 03:59:01.500685'),(6,'2024-10-08 08:17:50.000000','delivered',100.00,1,'2024-10-11 03:59:01.470632','2024-10-11 03:59:01.500685'),(7,'2024-10-08 08:19:07.000000','delivered',200.00,2,'2024-10-11 03:59:01.470632','2024-10-11 03:59:01.500685'),(8,'2024-10-11 06:30:04.000000','canceled',456.00,6,'2024-10-11 06:30:17.903619','2024-10-11 06:32:21.934745'),(9,'2024-10-15 06:00:05.000000','shipped',678.00,7,'2024-10-15 06:00:24.550097','2024-10-15 06:00:24.550116'),(10,'2024-10-15 06:05:34.000000','shipped',349.00,8,'2024-10-15 06:05:48.894427','2024-10-15 06:05:48.894450'),(11,'2024-10-15 06:26:18.000000','shipped',234.00,9,'2024-10-15 06:26:27.982840','2024-10-15 06:26:27.982870'),(12,'2024-10-15 06:28:40.000000','shipped',111.00,10,'2024-10-15 06:28:50.060007','2024-10-15 06:28:50.060039');
/*!40000 ALTER TABLE `analytics_app_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_orderitem`
--

DROP TABLE IF EXISTS `analytics_app_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `price_at_time_of_order` decimal(10,2) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `analytics_app_orderi_order_id_b0453253_fk_analytics` (`order_id`),
  KEY `analytics_app_orderi_product_id_302fe272_fk_analytics` (`product_id`),
  CONSTRAINT `analytics_app_orderi_order_id_b0453253_fk_analytics` FOREIGN KEY (`order_id`) REFERENCES `analytics_app_order` (`id`),
  CONSTRAINT `analytics_app_orderi_product_id_302fe272_fk_analytics` FOREIGN KEY (`product_id`) REFERENCES `analytics_app_product` (`id`),
  CONSTRAINT `analytics_app_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_orderitem`
--

LOCK TABLES `analytics_app_orderitem` WRITE;
/*!40000 ALTER TABLE `analytics_app_orderitem` DISABLE KEYS */;
INSERT INTO `analytics_app_orderitem` VALUES (1,1,699.99,1,2,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(2,1,89.99,1,4,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(8,2,19.99,1,2,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(9,2,19.99,1,2,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(11,1,100.00,4,4,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(12,1,100.00,5,4,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(13,0,100.00,5,2,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(14,0,100.00,5,2,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(15,1,100.00,5,3,'2024-10-11 03:59:01.530340','2024-10-11 03:59:01.563088'),(16,5,15.00,6,3,'2024-10-11 03:59:01.530340','2024-10-11 04:15:58.306768'),(19,2,230.00,1,3,'2024-10-11 06:27:19.595306','2024-10-11 06:27:19.595333'),(21,15,346.00,8,4,'2024-10-11 06:31:08.299373','2024-10-11 06:33:01.027507'),(22,2,278.00,9,4,'2024-10-15 06:00:43.093254','2024-10-15 06:00:43.093287'),(23,1,349.00,10,5,'2024-10-15 06:06:36.164886','2024-10-15 06:06:36.164941'),(24,1,234.00,11,3,'2024-10-15 06:27:01.253762','2024-10-15 06:27:01.253787'),(25,1,111.00,12,4,'2024-10-15 06:28:59.219834','2024-10-15 06:28:59.219860');
/*!40000 ALTER TABLE `analytics_app_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_product`
--

DROP TABLE IF EXISTS `analytics_app_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `SKU` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `category_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SKU` (`SKU`),
  KEY `analytics_app_produc_category_id_41bf1489_fk_analytics` (`category_id`),
  CONSTRAINT `analytics_app_produc_category_id_41bf1489_fk_analytics` FOREIGN KEY (`category_id`) REFERENCES `analytics_app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_product`
--

LOCK TABLES `analytics_app_product` WRITE;
/*!40000 ALTER TABLE `analytics_app_product` DISABLE KEYS */;
INSERT INTO `analytics_app_product` VALUES (2,'Smart TV','55 inch 4K Ultra HD Smart LED TV','TV-001',699.99,1,2,'2024-10-11 03:59:01.593259','2024-10-11 03:59:01.628081'),(3,'Bluetooth Headphones','Noise-cancelling over-ear headphones','HP-002',199.99,1,2,'2024-10-11 03:59:01.593259','2024-10-11 03:59:01.628081'),(4,'Winter Jacket','Warm and stylish winter jacket','CJ-003',89.99,1,3,'2024-10-11 03:59:01.593259','2024-10-11 03:59:01.628081'),(5,'Coffee Maker','Automatic drip coffee maker','CM-004',49.99,0,4,'2024-10-11 03:59:01.593259','2024-10-11 03:59:01.628081');
/*!40000 ALTER TABLE `analytics_app_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_product_tags`
--

DROP TABLE IF EXISTS `analytics_app_product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_product_tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `analytics_app_product_tags_product_id_tag_id_2a299874_uniq` (`product_id`,`tag_id`),
  KEY `analytics_app_produc_tag_id_bbd5a41c_fk_analytics` (`tag_id`),
  CONSTRAINT `analytics_app_produc_product_id_321905ee_fk_analytics` FOREIGN KEY (`product_id`) REFERENCES `analytics_app_product` (`id`),
  CONSTRAINT `analytics_app_produc_tag_id_bbd5a41c_fk_analytics` FOREIGN KEY (`tag_id`) REFERENCES `analytics_app_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_product_tags`
--

LOCK TABLES `analytics_app_product_tags` WRITE;
/*!40000 ALTER TABLE `analytics_app_product_tags` DISABLE KEYS */;
INSERT INTO `analytics_app_product_tags` VALUES (1,2,2),(2,3,3),(3,4,1),(4,5,2);
/*!40000 ALTER TABLE `analytics_app_product_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_app_tag`
--

DROP TABLE IF EXISTS `analytics_app_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_app_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_app_tag`
--

LOCK TABLES `analytics_app_tag` WRITE;
/*!40000 ALTER TABLE `analytics_app_tag` DISABLE KEYS */;
INSERT INTO `analytics_app_tag` VALUES (1,'Sale','2024-10-11 03:59:01.661163','2024-10-11 03:59:01.692450'),(2,'New','2024-10-11 03:59:01.661163','2024-10-11 03:59:01.692450'),(3,'Best Seller','2024-10-11 03:59:01.661163','2024-10-11 03:59:01.692450');
/*!40000 ALTER TABLE `analytics_app_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add customer',7,'add_customer'),(26,'Can change customer',7,'change_customer'),(27,'Can delete customer',7,'delete_customer'),(28,'Can view customer',7,'view_customer'),(29,'Can add order',8,'add_order'),(30,'Can change order',8,'change_order'),(31,'Can delete order',8,'delete_order'),(32,'Can view order',8,'view_order'),(33,'Can add order item',9,'add_orderitem'),(34,'Can change order item',9,'change_orderitem'),(35,'Can delete order item',9,'delete_orderitem'),(36,'Can view order item',9,'view_orderitem'),(37,'Can add tag',10,'add_tag'),(38,'Can change tag',10,'change_tag'),(39,'Can delete tag',10,'delete_tag'),(40,'Can view tag',10,'view_tag'),(41,'Can add inventory',11,'add_inventory'),(42,'Can change inventory',11,'change_inventory'),(43,'Can delete inventory',11,'delete_inventory'),(44,'Can view inventory',11,'view_inventory'),(45,'Can add product',12,'add_product'),(46,'Can change product',12,'change_product'),(47,'Can delete product',12,'delete_product'),(48,'Can view product',12,'view_product'),(49,'Can add category',13,'add_category'),(50,'Can change category',13,'change_category'),(51,'Can delete category',13,'delete_category'),(52,'Can view category',13,'view_category'),(53,'Can add category',8,'add_category'),(54,'Can change category',8,'change_category'),(55,'Can delete category',8,'delete_category'),(56,'Can view category',8,'view_category'),(57,'Can add customer',10,'add_customer'),(58,'Can change customer',10,'change_customer'),(59,'Can delete customer',10,'delete_customer'),(60,'Can view customer',10,'view_customer'),(61,'Can add tag',9,'add_tag'),(62,'Can change tag',9,'change_tag'),(63,'Can delete tag',9,'delete_tag'),(64,'Can view tag',9,'view_tag'),(65,'Can add order',11,'add_order'),(66,'Can change order',11,'change_order'),(67,'Can delete order',11,'delete_order'),(68,'Can view order',11,'view_order'),(69,'Can add product',7,'add_product'),(70,'Can change product',7,'change_product'),(71,'Can delete product',7,'delete_product'),(72,'Can view product',7,'view_product'),(73,'Can add order item',12,'add_orderitem'),(74,'Can change order item',12,'change_orderitem'),(75,'Can delete order item',12,'delete_orderitem'),(76,'Can view order item',12,'view_orderitem'),(77,'Can add inventory',13,'add_inventory'),(78,'Can change inventory',13,'change_inventory'),(79,'Can delete inventory',13,'delete_inventory'),(80,'Can view inventory',13,'view_inventory');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$eMHUWLMNa7ea2UfKNKaIiQ$pbLInzqUwYhbKPwuCkqsrPq13gBxN7ac78ufws0Vpck=','2024-10-14 12:53:12.436068',1,'akashtk','','','akash.tk333@gmail.com',1,1,'2024-10-07 03:44:32.400000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-10-07 05:09:50.635000','1','Smartphone',3,'',12,1),(2,'2024-10-07 05:11:12.653000','1','Electronics',3,'',13,1),(3,'2024-10-07 05:11:32.757000','2','Electronics',1,'[{\"added\": {}}]',13,1),(4,'2024-10-07 05:11:48.493000','3','Clothing',1,'[{\"added\": {}}]',13,1),(5,'2024-10-07 05:11:58.633000','4','Home & Kitchen',1,'[{\"added\": {}}]',13,1),(6,'2024-10-07 05:12:14.680000','1','Sale',1,'[{\"added\": {}}]',10,1),(7,'2024-10-07 05:12:20.137000','2','New',1,'[{\"added\": {}}]',10,1),(8,'2024-10-07 05:12:29.421000','3','Best Seller',1,'[{\"added\": {}}]',10,1),(9,'2024-10-07 05:14:05.449000','2','Smart TV',1,'[{\"added\": {}}]',12,1),(10,'2024-10-07 05:14:53.391000','3','Bluetooth Headphones',1,'[{\"added\": {}}]',12,1),(11,'2024-10-07 05:15:32.009000','4','Winter Jacket',1,'[{\"added\": {}}]',12,1),(12,'2024-10-07 05:16:16.610000','5','Coffee Maker',1,'[{\"added\": {}}]',12,1),(13,'2024-10-07 05:16:59.122000','1','John Doe',1,'[{\"added\": {}}]',7,1),(14,'2024-10-07 05:17:21.739000','2','Jane Smith',1,'[{\"added\": {}}]',7,1),(15,'2024-10-07 05:17:45.806000','3','Alice Johnson',1,'[{\"added\": {}}]',7,1),(16,'2024-10-07 05:18:23.675000','1','Order 1 - John Doe',1,'[{\"added\": {}}]',8,1),(17,'2024-10-07 05:18:45.613000','2','Order 2 - Jane Smith',1,'[{\"added\": {}}]',8,1),(18,'2024-10-07 05:20:43.354000','1','Smart TV (x1)',1,'[{\"added\": {}}]',9,1),(19,'2024-10-07 05:21:00.578000','2','Winter Jacket (x1)',1,'[{\"added\": {}}]',9,1),(20,'2024-10-07 05:21:26.488000','3','Bluetooth Headphones (x1)',1,'[{\"added\": {}}]',9,1),(21,'2024-10-07 05:22:08.560000','1','Inventory for Smart TV',1,'[{\"added\": {}}]',11,1),(22,'2024-10-07 05:22:20.934000','2','Inventory for Bluetooth Headphones',1,'[{\"added\": {}}]',11,1),(23,'2024-10-07 05:22:37.291000','3','Inventory for Winter Jacket',1,'[{\"added\": {}}]',11,1),(24,'2024-10-07 05:22:56.684000','4','Inventory for Coffee Maker',1,'[{\"added\": {}}]',11,1),(25,'2024-10-07 10:56:39.164000','4','Smart TV (x2)',2,'[{\"changed\": {\"fields\": [\"Price at time of order\"]}}]',9,1),(26,'2024-10-07 10:56:56.170000','5','Smart TV (x5)',2,'[{\"changed\": {\"fields\": [\"Price at time of order\"]}}]',9,1),(27,'2024-10-07 12:18:33.717000','7','Coffee Maker (x7)',3,'',9,1),(28,'2024-10-07 12:18:33.717000','6','Winter Jacket (x10)',3,'',9,1),(29,'2024-10-07 12:18:33.717000','5','Smart TV (x5)',3,'',9,1),(30,'2024-10-07 12:18:33.717000','4','Smart TV (x2)',3,'',9,1),(31,'2024-10-07 17:52:32.636000','2','Order 2 - Jane Smith',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(32,'2024-10-07 17:52:57.984000','2','Order 2 - Jane Smith',2,'[]',8,1),(33,'2024-10-07 17:53:14.498000','1','Order 1 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(34,'2024-10-08 03:48:25.882000','3','Order 3 - John Doe',3,'',8,1),(35,'2024-10-08 03:58:37.645000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(36,'2024-10-08 03:59:02.268000','4','Order 4 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(37,'2024-10-08 04:02:34.838000','2','Order 2 - Jane Smith',3,'',8,1),(38,'2024-10-08 04:27:30.139000','14','Smart TV (x0)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',9,1),(39,'2024-10-08 04:27:36.204000','13','Smart TV (x0)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',9,1),(40,'2024-10-08 04:27:49.161000','5','Order 5 - John Doe',2,'[]',8,1),(41,'2024-10-08 04:30:04.100000','1','Order 1 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(42,'2024-10-08 04:30:36.953000','1','Order 1 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(43,'2024-10-08 04:36:43.461000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(44,'2024-10-08 04:36:47.870000','4','Order 4 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(45,'2024-10-08 04:36:51.284000','1','Order 1 - John Doe',2,'[]',8,1),(46,'2024-10-08 05:02:39.431000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(47,'2024-10-08 05:02:56.215000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(48,'2024-10-08 05:04:34.690000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(49,'2024-10-08 05:04:55.708000','5','Order 5 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',8,1),(50,'2024-10-08 05:39:20.641000','5','Coffee Maker',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',12,1),(51,'2024-10-08 06:13:34.498000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(52,'2024-10-08 06:14:34.874000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(53,'2024-10-08 06:14:59.119000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(54,'2024-10-08 06:15:22.063000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(55,'2024-10-08 06:15:45.854000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(56,'2024-10-08 06:16:31.854000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(57,'2024-10-08 06:16:52.401000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(58,'2024-10-08 06:17:11.457000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(59,'2024-10-08 06:17:34.867000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(60,'2024-10-08 06:17:55.150000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(61,'2024-10-08 06:18:13.573000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(62,'2024-10-08 06:18:29.346000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(63,'2024-10-08 06:19:01.283000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(64,'2024-10-08 06:19:17.510000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(65,'2024-10-08 06:19:31.780000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(66,'2024-10-08 06:23:42.058000','1','John Doe',2,'[]',7,1),(67,'2024-10-08 06:24:01.137000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(68,'2024-10-08 06:24:16.637000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(69,'2024-10-08 06:24:32.935000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(70,'2024-10-08 06:48:10.243000','1','John Doe',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(71,'2024-10-08 06:49:17.167000','2','Jane Smith',2,'[{\"changed\": {\"fields\": [\"Country\"]}}]',7,1),(72,'2024-10-08 08:18:14.007000','6','Order 6 - John Doe',1,'[{\"added\": {}}]',8,1),(73,'2024-10-08 08:18:55.678000','16','Bluetooth Headphones (x5)',1,'[{\"added\": {}}]',9,1),(74,'2024-10-08 08:19:17.675000','7','Order 7 - Jane Smith',1,'[{\"added\": {}}]',8,1),(75,'2024-10-08 08:19:39.920000','17','Bluetooth Headphones (x2)',1,'[{\"added\": {}}]',9,1),(76,'2024-10-11 04:15:06.898070','17','Bluetooth Headphones (x2)',3,'',12,1),(77,'2024-10-11 04:15:58.309707','16','Bluetooth Headphones (x5)',2,'[{\"changed\": {\"fields\": [\"Price at time of order\"]}}]',12,1),(78,'2024-10-11 05:38:43.624741','34','Test Category',3,'',8,1),(79,'2024-10-11 05:38:43.624776','33','Test Category',3,'',8,1),(80,'2024-10-11 05:38:43.624790','32','Test Category',3,'',8,1),(81,'2024-10-11 05:38:43.624801','31','Test Category',3,'',8,1),(82,'2024-10-11 05:38:43.624812','30','Test Category',3,'',8,1),(83,'2024-10-11 05:38:43.624822','29','Test Category',3,'',8,1),(84,'2024-10-11 05:38:43.624832','28','Test Category',3,'',8,1),(85,'2024-10-11 05:38:43.624842','27','Test Category',3,'',8,1),(86,'2024-10-11 05:38:43.624852','26','Test Category',3,'',8,1),(87,'2024-10-11 05:38:43.624862','25','Test Category',3,'',8,1),(88,'2024-10-11 05:38:43.624872','24','Test Category',3,'',8,1),(89,'2024-10-11 05:38:43.624881','23','Test Category',3,'',8,1),(90,'2024-10-11 05:38:43.624891','22','Test Category',3,'',8,1),(91,'2024-10-11 05:38:43.624902','21','Test Category',3,'',8,1),(92,'2024-10-11 05:38:43.624912','20','Test Category',3,'',8,1),(93,'2024-10-11 05:38:43.624922','19','Test Category',3,'',8,1),(94,'2024-10-11 05:38:43.624932','18','Test Category',3,'',8,1),(95,'2024-10-11 05:38:43.624942','17','Test Category',3,'',8,1),(96,'2024-10-11 05:38:43.624957','16','Test Category',3,'',8,1),(97,'2024-10-11 05:38:43.624967','15','Test Category',3,'',8,1),(98,'2024-10-11 05:38:43.624977','14','Test Category',3,'',8,1),(99,'2024-10-11 05:38:43.624986','13','Test Category',3,'',8,1),(100,'2024-10-11 05:38:43.624996','12','Test Category',3,'',8,1),(101,'2024-10-11 05:38:43.625007','11','Test Category',3,'',8,1),(102,'2024-10-11 05:38:43.625458','10','Test Category',3,'',8,1),(103,'2024-10-11 05:38:43.625482','9','Test Category',3,'',8,1),(104,'2024-10-11 05:38:43.625494','8','Test Category',3,'',8,1),(105,'2024-10-11 05:38:43.625504','7','Test Category',3,'',8,1),(106,'2024-10-11 05:38:43.625515','6','Test Category',3,'',8,1),(107,'2024-10-11 05:38:43.625525','5','Test Category',3,'',8,1),(108,'2024-10-11 06:04:51.867249','5','Test Customer',3,'',10,1),(109,'2024-10-11 06:22:36.905641','18','Bluetooth Headphones (x2)',1,'[{\"added\": {}}]',12,1),(110,'2024-10-11 06:23:20.962062','1','Order 1 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(111,'2024-10-11 06:24:15.487844','18','Bluetooth Headphones (x2)',3,'',12,1),(112,'2024-10-11 06:25:36.651227','2','Inventory for Bluetooth Headphones',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',13,1),(113,'2024-10-11 06:25:58.916394','2','Inventory for Bluetooth Headphones',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',13,1),(114,'2024-10-11 06:26:31.188653','2','Inventory for Bluetooth Headphones',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',13,1),(115,'2024-10-11 06:27:19.597962','19','Bluetooth Headphones (x2)',1,'[{\"added\": {}}]',12,1),(116,'2024-10-11 06:28:03.712618','20','Smart TV (x4)',1,'[{\"added\": {}}]',12,1),(117,'2024-10-11 06:28:21.335592','20','Smart TV (x4)',3,'',12,1),(118,'2024-10-11 06:28:41.652100','1','Order 1 - John Doe',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(119,'2024-10-11 06:30:00.200469','6','Test',1,'[{\"added\": {}}]',10,1),(120,'2024-10-11 06:30:17.904530','8','Order 8 - Test',1,'[{\"added\": {}}]',11,1),(121,'2024-10-11 06:31:08.301014','21','Winter Jacket (x5)',1,'[{\"added\": {}}]',12,1),(122,'2024-10-11 06:31:31.005939','8','Order 8 - Test',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(123,'2024-10-11 06:31:45.151855','8','Order 8 - Test',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(124,'2024-10-11 06:32:00.010129','8','Order 8 - Test',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(125,'2024-10-11 06:32:12.240000','8','Order 8 - Test',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(126,'2024-10-11 06:32:21.935625','8','Order 8 - Test',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(127,'2024-10-11 06:33:01.032169','21','Winter Jacket (x15)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',12,1),(128,'2024-10-15 05:59:58.192901','7','Otis',1,'[{\"added\": {}}]',10,1),(129,'2024-10-15 06:00:24.551086','9','Order 9 - Otis',1,'[{\"added\": {}}]',11,1),(130,'2024-10-15 06:00:43.096180','22','Winter Jacket (x2)',1,'[{\"added\": {}}]',12,1),(131,'2024-10-15 06:05:14.950353','8','Millie',1,'[{\"added\": {}}]',10,1),(132,'2024-10-15 06:05:48.895694','10','Order 10 - Millie',1,'[{\"added\": {}}]',11,1),(133,'2024-10-15 06:06:36.171831','23','Coffee Maker (x1)',1,'[{\"added\": {}}]',12,1),(134,'2024-10-15 06:26:14.890768','9','Ruby',1,'[{\"added\": {}}]',10,1),(135,'2024-10-15 06:26:27.984315','11','Order 11 - Ruby',1,'[{\"added\": {}}]',11,1),(136,'2024-10-15 06:27:01.256708','24','Bluetooth Headphones (x1)',1,'[{\"added\": {}}]',12,1),(137,'2024-10-15 06:28:37.709913','10','Dustin',1,'[{\"added\": {}}]',10,1),(138,'2024-10-15 06:28:50.061562','12','Order 12 - Dustin',1,'[{\"added\": {}}]',11,1),(139,'2024-10-15 06:28:59.222276','25','Winter Jacket (x1)',1,'[{\"added\": {}}]',12,1),(140,'2024-10-15 06:29:39.045145','11','Mike',1,'[{\"added\": {}}]',10,1),(141,'2024-10-15 06:29:55.138031','13','Order 13 - Mike',1,'[{\"added\": {}}]',11,1),(142,'2024-10-15 06:30:07.974756','26','Winter Jacket (x1)',1,'[{\"added\": {}}]',12,1),(143,'2024-10-15 06:33:49.343256','13','Order 13 - Mike',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(144,'2024-10-15 06:34:06.251849','13','Order 13 - Mike',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',11,1),(145,'2024-10-15 06:34:23.441810','13','Order 13 - Mike',3,'',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'analytics_app','category'),(10,'analytics_app','customer'),(13,'analytics_app','inventory'),(11,'analytics_app','order'),(12,'analytics_app','orderitem'),(7,'analytics_app','product'),(9,'analytics_app','tag'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-10-10 08:38:11.979063'),(2,'auth','0001_initial','2024-10-10 08:38:12.784227'),(3,'admin','0001_initial','2024-10-10 08:38:12.980603'),(4,'admin','0002_logentry_remove_auto_add','2024-10-10 08:38:12.988429'),(5,'admin','0003_logentry_add_action_flag_choices','2024-10-10 08:38:12.997633'),(6,'analytics_app','0001_initial','2024-10-10 08:38:13.815751'),(7,'contenttypes','0002_remove_content_type_name','2024-10-10 08:38:13.906371'),(8,'auth','0002_alter_permission_name_max_length','2024-10-10 08:38:13.994270'),(9,'auth','0003_alter_user_email_max_length','2024-10-10 08:38:14.015926'),(10,'auth','0004_alter_user_username_opts','2024-10-10 08:38:14.025671'),(11,'auth','0005_alter_user_last_login_null','2024-10-10 08:38:14.093557'),(12,'auth','0006_require_contenttypes_0002','2024-10-10 08:38:14.097426'),(13,'auth','0007_alter_validators_add_error_messages','2024-10-10 08:38:14.105131'),(14,'auth','0008_alter_user_username_max_length','2024-10-10 08:38:14.199627'),(15,'auth','0009_alter_user_last_name_max_length','2024-10-10 08:38:14.282559'),(16,'auth','0010_alter_group_name_max_length','2024-10-10 08:38:14.303466'),(17,'auth','0011_update_proxy_permissions','2024-10-10 08:38:14.314188'),(18,'auth','0012_alter_user_first_name_max_length','2024-10-10 08:38:14.400179'),(19,'sessions','0001_initial','2024-10-10 08:38:14.448853'),(20,'analytics_app','0002_category_created_at_category_updated_at_and_more','2024-10-11 03:59:01.719401'),(21,'analytics_app','0003_alter_inventory_last_restocked_date','2024-10-13 17:29:04.304187');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('bcxphjozl8sy2gq2f87lcp2sio037lcs','.eJxVjMsOwiAQRf-FtSE8hocu3fcbCMyAVA0kpV0Z_12bdKHbe865LxbittawjbyEmdiFSXb63VLER247oHtst86xt3WZE98VftDBp075eT3cv4MaR_3WRoHQGrxLVnkDFp3IhNJjcQDFgy0ITpIiSigyGEVOo7VSC6JzUom9P72FN3E:1t0KZU:m7kupjt5CDD3Y9Xomgwkwbcqne9SgVip-Rhfhslb9o8','2024-10-28 12:53:12.441512'),('vqpyxqtrh5uh0v366b5lch9n5dzaq9p5','.eJxVjDsOwyAQBe9CHaEFYz4p0_sMaJfFwUmEJWNXUe4eIblI2jcz7y0iHnuJR8tbXFhchRKX340wPXPtgB9Y76tMa923hWRX5EmbnFbOr9vp_h0UbKXXlK0bkckkdA5Hy34gBZQJALQH8mhUYKakXGADPvjB2DTP3mStdBCfL_y8N_s:1sxfDt:wCV5mBgFfFLwDyU_Ze8cWs6S_g8qUziDl6S2wN0d-6c','2024-10-21 04:19:53.024000');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-15 15:36:52
