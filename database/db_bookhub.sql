-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_bookhub
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `tb_genero`
--

DROP TABLE IF EXISTS `tb_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_genero` (
  `genero_id` int(11) NOT NULL AUTO_INCREMENT,
  `genero_nome` varchar(100) NOT NULL,
  PRIMARY KEY (`genero_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_genero`
--

LOCK TABLES `tb_genero` WRITE;
/*!40000 ALTER TABLE `tb_genero` DISABLE KEYS */;
INSERT INTO `tb_genero` VALUES (18,'Ficção científica distópica'),(19,'Política'),(20,'Thriller psicológico'),(21,'Ficção científica'),(22,'Ação'),(23,'Humor negro'),(24,'Psicologia'),(25,'Comportamento humano'),(26,'Ficção'),(27,'Romance de formação'),(28,'Autoajuda'),(29,'Finanças pessoais'),(30,'Realismo mágico'),(31,'Ficção histórica'),(32,'Romance clássico'),(33,'Drama social'),(34,'História'),(35,'Antropologia'),(36,'Drama'),(37,'Crítica social'),(38,'Romance'),(39,'Drama jurídico'),(40,'Thriller psicológico'),(41,'Suspense'),(42,'Romance dark'),(43,'Fantasia épica'),(44,'Política'),(45,'Guerra'),(46,'Fantasia'),(47,'Aventura'),(48,'Mitologia');
/*!40000 ALTER TABLE `tb_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_imagens`
--

DROP TABLE IF EXISTS `tb_imagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_imagens` (
  `imagem_id` int(11) NOT NULL AUTO_INCREMENT,
  `pub_id` int(11) DEFAULT NULL,
  `imagem_caminho` varchar(255) NOT NULL,
  `profile_picture` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`imagem_id`),
  KEY `pub_id` (`pub_id`),
  CONSTRAINT `fk_imagens_pub` FOREIGN KEY (`pub_id`) REFERENCES `tb_publicacoes` (`pub_id`) ON DELETE CASCADE,
  CONSTRAINT `tb_imagens_ibfk_1` FOREIGN KEY (`pub_id`) REFERENCES `tb_publicacoes` (`pub_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_imagens`
--

LOCK TABLES `tb_imagens` WRITE;
/*!40000 ALTER TABLE `tb_imagens` DISABLE KEYS */;
INSERT INTO `tb_imagens` VALUES (9,4,'https://i.ibb.co/5hcRLnGX/1.jpg',1),(10,4,'https://i.ibb.co/spk7K5J8/3.jpg',0),(11,4,'https://i.ibb.co/Z1BJrBHF/2.webp',0),(12,4,'https://i.ibb.co/Gfcb33jn/5.jpg',0),(13,4,'https://i.ibb.co/Xksxtn13/4.jpg',0),(14,5,'https://i.ibb.co/vCggm4mJ/1.jpg',1),(15,5,'https://i.ibb.co/1t4R5BmV/3.jpg',0),(16,5,'https://i.ibb.co/pjJ1wDkd/2.webp',0),(17,6,'https://i.ibb.co/hxF4WZNC/IMG-1.jpg',1),(18,6,'https://i.ibb.co/nMvNjFYJ/IMG-2.webp',0),(19,7,'https://i.ibb.co/MkGm0dnr/livro-mentes-perigosas-a-psicopatia-mora-ao-lado-2501-1-78644b053bbe99b1b14d4f5aedb504e2.webp',1),(20,7,'https://i.ibb.co/1fxtZPVf/IMG-4098.webp',0),(21,7,'https://i.ibb.co/mVFrNwHc/IMG-3.webp',0),(22,8,'https://i.ibb.co/DfRf3tST/3.jpg',1),(23,8,'https://i.ibb.co/zTDCMYnC/2.jpg',0),(24,8,'https://i.ibb.co/8n1cpSsv/4.jpg',0),(25,9,'https://i.ibb.co/x8dBm3CQ/IMG-3.jpg',1),(26,9,'https://i.ibb.co/6cpTTX6y/IMG-4.jpg',0),(27,9,'https://i.ibb.co/hJvqHMNH/IMG-1.png',0),(28,10,'https://i.ibb.co/C3Nc53PB/3.jpg',1),(29,10,'https://i.ibb.co/wZyrj3dS/1.jpg',0),(30,10,'https://i.ibb.co/9HF6LnfR/2.jpg',0),(31,11,'https://i.ibb.co/Z1YzQvMh/2.jpg',0),(32,11,'https://i.ibb.co/8DhyMjkR/1.jpg',1),(33,12,'https://i.ibb.co/8n88gNGF/4.webp',1),(34,12,'https://i.ibb.co/JRcV67TT/5.webp',0),(35,12,'https://i.ibb.co/h1x3jCK8/IMG-2.webp',0),(36,14,'https://i.ibb.co/5xTTX1rT/1.jpg',1),(37,14,'https://i.ibb.co/HfdxRG3z/2.webp',0),(38,14,'https://i.ibb.co/R4QjPP8z/1.webp',0),(39,15,'https://i.ibb.co/hxwRjVj7/1.jpg',1),(40,15,'https://i.ibb.co/0jdJGWPR/3.webp',0),(41,15,'https://i.ibb.co/dw19zNLp/4.webp',0),(42,16,'https://i.ibb.co/JwjMPPDY/IMG-4.jpg',1),(43,16,'https://i.ibb.co/3mVSbyqb/IMG-1.jpg',0),(44,16,'https://i.ibb.co/DDXh44xY/IMG-3.jpg',0),(45,16,'https://i.ibb.co/ksWb2Zh3/IMG-2.webp',0),(46,17,'https://i.ibb.co/1tG2CQCg/3.jpg',1),(47,17,'https://i.ibb.co/cVdFbXZ/1.jpg',0),(48,17,'https://i.ibb.co/jvP5LvhY/2.jpg',0),(49,18,'https://i.ibb.co/tMm9fWWg/1.jpg',1),(50,18,'https://i.ibb.co/0RhPWpX0/3.jpg',0),(51,18,'https://i.ibb.co/gFcgS8yt/2.jpg',0),(52,18,'https://i.ibb.co/XZW0wykm/4.jpg',0),(53,19,'https://i.ibb.co/bgG2wxqn/2.jpg',1),(54,19,'https://i.ibb.co/TqHrswBm/3.jpg',0),(55,19,'https://i.ibb.co/gZtK2DJn/1.jpg',0);
/*!40000 ALTER TABLE `tb_imagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_item`
--

DROP TABLE IF EXISTS `tb_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_isbnCode` varchar(17) DEFAULT NULL,
  `item_titulo` varchar(100) NOT NULL,
  `item_autor` varchar(30) NOT NULL,
  `item_editora` varchar(100) DEFAULT NULL,
  `item_datadepublicacao` date NOT NULL,
  `item_status` varchar(30) NOT NULL,
  `item_tipo` tinyint(4) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_item`
--

LOCK TABLES `tb_item` WRITE;
/*!40000 ALTER TABLE `tb_item` DISABLE KEYS */;
INSERT INTO `tb_item` VALUES (1,'7240328878975','Intelligent Plastic Gloves','Megan Stiedemann','Turner LLC','2024-08-28','Disponível',0),(2,'3960749668111','Practical Ceramic Pizza','Donald Mitchell-Rempel','Langosh, Barton and Erdman','2025-04-19','Disponível',0),(3,'4323854669478','Awesome Bamboo Hat','Iris Kovacek','Swift, Krajcik and Gibson','2024-07-20','Disponível',0),(4,'6238759524481','Fresh Concrete Shoes','Kathryn Gislason-Steuber','Zulauf, Tromp and Dooley','2025-03-26','Disponível',0),(5,'8645707266358','Tasty Rubber Pizza','Gary Reynolds V','Williamson, Miller and Durgan','2024-08-24','Reservado',0),(6,'1074118886464','Ergonomic Bamboo Towels','Harry Robel','Bogan and Sons','2025-03-24','Disponível',0),(7,'9941080756519','Small Marble Shoes','Troy Sipes','Hahn - Bartell','2025-03-03','Reservado',0),(8,'4054163874670','Handcrafted Metal Pizza','Regina Kemmer','Shields - O\'Conner','2025-01-02','Indisponível',0),(9,'978-3-16-148410-0','Harry Potter e a Pedra Filosofal','J.K. Rowling','Bloomsbury Publishing Rocco','1997-06-26','Disponível',0),(10,'978-0-452-28423-4','1984','George Orwell','Secker & Warburg','2009-07-21','Usado',0),(11,'978-0-06-085052-4','Brave New World','Aldous Huxley','HarperCollins Publishers','2006-10-17','Usado',0),(12,'978-1-25-009775-0','Futuristic Violence and Fancy Suits','David Wong','Titan Books','2015-10-06','Usado',0),(13,'978-8-52-506732-6','Mentes Perigosas: O Psicopata Mora ao Lado','Ana Beatriz Barbosa Silva','Principium','2018-10-30','Semi-novo',0),(14,'978-6-580-30903-0','O Apanhador no Campo de Centeio','J.D. Salinger','Todavia','2019-06-17','Novo',0),(15,'978-8-59-508153-6','O Homem Mais Rico da Babilônia','George S. Clason','HarperCollins','2017-08-04','Usado',0),(16,'0060883286','One Hundred Years of Solitude','Gabriel García Márquez','Harper Perennial Modern Classics','2006-02-21','Semi-novo',0),(17,'978-1-85326-000-1','Pride and Prejudice','Jane Austen','T. Egerton, Whitehall','1813-01-28','Marcas de uso',0),(18,'978-0-06-231609-7','Sapiens - Uma Breve História da Humanidade','Yuval Harari','L&PM','2015-01-01','Marcas de uso',0),(19,'978-8-5813-0172-3','O Grande Gatsby','F. Scott Fitzgerald','Geração Editorial','2013-06-01','Novo',0),(20,'978-0-06-112008-4','To Kill a Mockingbird','Harper Lee','J. B. Lippincott & Co.','1960-07-11','Usado',0),(21,'978-1-53-872473-6','Verity','Collen Hoover','Grand Central Publishing','2018-12-10','Usado',0),(22,'978-0345535566','A Game of Thrones 5-Book Boxed Set (Song of Ice and Fire Series)','George R. R. Martin','Bantam (Random House)','2013-10-29','Semi-novo',3),(23,'978-1408856789','Harry Potter Box Set: The Complete Collection','J.K. Rowling','Bloomsbury Children’s Books','2014-10-09','Marcas de uso',3),(24,'978-0395489321','The Lord of the Rings Boxed Set','J.R.R. Tolkien','William Morrow & Company','1988-03-03','Marcas de uso',3);
/*!40000 ALTER TABLE `tb_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_publicacao_genero`
--

DROP TABLE IF EXISTS `tb_publicacao_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_publicacao_genero` (
  `pub_id` int(11) NOT NULL,
  `genero_id` int(11) NOT NULL,
  PRIMARY KEY (`pub_id`,`genero_id`),
  KEY `genero_id` (`genero_id`),
  CONSTRAINT `tb_publicacao_genero_ibfk_1` FOREIGN KEY (`pub_id`) REFERENCES `tb_publicacoes` (`pub_id`) ON DELETE CASCADE,
  CONSTRAINT `tb_publicacao_genero_ibfk_2` FOREIGN KEY (`genero_id`) REFERENCES `tb_genero` (`genero_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_publicacao_genero`
--

LOCK TABLES `tb_publicacao_genero` WRITE;
/*!40000 ALTER TABLE `tb_publicacao_genero` DISABLE KEYS */;
INSERT INTO `tb_publicacao_genero` VALUES (4,18),(4,19),(4,20),(5,18),(6,21),(6,22),(6,23),(7,24),(7,25),(8,26),(8,27),(9,28),(9,29),(10,30),(10,31),(11,32),(11,33),(12,34),(12,35),(14,32),(14,36),(14,37),(15,37),(15,38),(15,39),(16,40),(16,41),(16,42),(17,43),(17,44),(17,45),(18,27),(18,46),(18,47),(19,43),(19,47),(19,48);
/*!40000 ALTER TABLE `tb_publicacao_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_publicacoes`
--

DROP TABLE IF EXISTS `tb_publicacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_publicacoes` (
  `pub_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `pub_tipo` tinyint(4) NOT NULL,
  `pub_titulo` varchar(50) NOT NULL,
  `pub_valor` decimal(10,2) DEFAULT NULL,
  `pub_pagamento` tinyint(4) DEFAULT NULL,
  `pub_descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`pub_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `fk_pub_item` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `tb_publicacoes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`user_id`),
  CONSTRAINT `tb_publicacoes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_publicacoes`
--

LOCK TABLES `tb_publicacoes` WRITE;
/*!40000 ALTER TABLE `tb_publicacoes` DISABLE KEYS */;
INSERT INTO `tb_publicacoes` VALUES (4,1,10,1,'Vendo o livro \"1984\"',29.99,1,'1984 é uma crítica poderosa ao totalitarismo. Mostra como o controle extremo destrói a liberdade e a verdade. Uma obra atual, reflexiva e essencial para entender o poder e seus abusos.'),(5,2,11,1,'Brave New World - ótimo livro',39.99,1,'Brave New World critica uma sociedade controlada pelo prazer e pela tecnologia. Mostra como a falsa felicidade pode anular a liberdade e a individualidade. Uma obra provocadora e atual.'),(6,1,12,1,'Futuristic Violence (Só venda)',29.99,1,'Mistura ação, humor e crítica social num futuro caótico. Divertido e irreverente, questiona poder, mídia e identidade com estilo e criatividade.'),(7,1,13,1,'Livro \"Mentes Perigosas\"',19.99,1,'revela o perfil dos psicopatas, desvendando suas atitudes e impactos. Um livro essencial para entender comportamentos perigosos e suas consequências na sociedade.'),(8,1,14,1,'O Apanhador no Campo de Centeio (Livro Ótimo)',60.00,1,'O livro explora a adolescência, a angústia e a busca por identidade. Holden é um personagem complexo, cuja voz autêntica emociona e provoca reflexão.'),(9,1,15,1,'O Homem Mais Rico da Babilônia (Valor negociável)',59.99,1,'Livro muito bom que traz lições simples e práticas sobre finanças pessoais, enriquecimento e disciplina. Um clássico que ensina a administrar dinheiro com sabedoria.'),(10,1,16,0,'DOANDO - One Hundred Years of Solitude',NULL,NULL,'PRA SAIR HOJE EM, LIVRO BALA!!'),(11,1,17,0,'Livro \"Pride and Prejudice\" para doação',NULL,NULL,'Pra quem gosta de um bom romance, só chama no zap (to falando do livro)'),(12,1,18,0,'Doando o livro \"Sapiens\"',NULL,NULL,'Ótimo livro pra entender como deu essa merda toda'),(14,1,19,2,'TROCA - O grande gatsby',NULL,NULL,'Troco por algum livro de suspense ou thriller'),(15,1,20,2,'To Kill a Mockingbird - troca',NULL,NULL,'Troco por mangá ou HQ em geral'),(16,1,21,2,'\"Verity\" da autora Collen Hoover - Troca',NULL,NULL,'Chama no WhatsApp para informar quais livros tem, e negociamos'),(17,1,22,1,'Box - Game of Thrones',89.99,1,'O box Game of Thrones traz uma saga épica, com tramas políticas, personagens marcantes e reviravoltas. Uma leitura envolvente e cheia de surpresas até o fim.'),(18,1,23,1,'Harry Potter (Coleção completa)',99.99,1,'Todos os 7 livros em perfeito estado de conservação, com poucas marcas de uso'),(19,1,24,1,'O Senhor dos Anéis - Box Completo',89.99,1,'História que reúne uma fantasia épica e atemporal, com mundo rico, heróis marcantes e uma jornada poderosa sobre amizade, coragem e o peso do destino.');
/*!40000 ALTER TABLE `tb_publicacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_nome` varchar(20) NOT NULL,
  `user_sobrenome` varchar(20) NOT NULL,
  `user_data_nascimento` date NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_celular` varchar(12) NOT NULL,
  `user_senha` varchar(15) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `user_celular` (`user_celular`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` VALUES (1,'Pedro','Alves','2001-05-15','pedroalves@gmail.com','11985541650','senhadopedro'),(2,'Thiago','Elias','1998-08-17','emaildothiago@gmail.com','11995287235','senhadothiago'),(3,'Diego','Almeida','1993-04-27','diegoalmeida@gmail.com','11984217900','senhadodiego'),(4,'Fabio','Cesar','1996-06-01','fabiocesar@gmail.com','11965227082','Fabio@1.');
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 18:02:45
