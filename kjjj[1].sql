-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.4.21-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win64
-- HeidiSQL Wersja:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Zrzut struktury bazy danych megakurs_task-manager
CREATE DATABASE IF NOT EXISTS `megakurs_task-manager` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `megakurs_task-manager`;

-- Zrzut struktury tabela megakurs_task-manager.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `taskName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userID` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taskID` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT uuid(),
  PRIMARY KEY (`taskName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli megakurs_task-manager.tasks: ~4 rows (około)
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`taskName`, `userID`, `taskID`) VALUES
	('jutro wesele', '095e9a3d-1c36-4ce5-8c13-e63fefc71804', '264b3e91-2a06-4f2f-afcc-19a346fa2bb0'),
	('posprzątać domki', '365e77bc-d680-4bac-bf55-5464c1f085e5', '0d33bc06-8a31-42f8-8bb1-cf292914ba15'),
	('środa energylandia', '095e9a3d-1c36-4ce5-8c13-e63fefc71804', 'a49bf4c7-d376-4674-bbdb-2490f2483018'),
	('umyć zęby', '095e9a3d-1c36-4ce5-8c13-e63fefc71804', '4ed1a150-5185-4d07-a568-306f4182c996');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;

-- Zrzut struktury tabela megakurs_task-manager.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT uuid(),
  `login` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pwdhash` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli megakurs_task-manager.users: ~4 rows (około)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `login`, `pwdhash`) VALUES
	('095e9a3d-1c36-4ce5-8c13-e63fefc71804', 'kamil', '$2b$06$gqc7VkCMQVBI42uG/cG4PuMefoaqvff0misGvtVA3MH2cqGZ0NPpi'),
	('0fe4f39a-cad0-442d-9ca7-abcb46ffe511', 'Dawidek', '$2b$06$zTBYENnEEIEVn.a8.wy9HeDu6UyqrYAEnGXUh/s5b5M1FPp2cBPB.'),
	('365e77bc-d680-4bac-bf55-5464c1f085e5', 'tomek', '$2b$06$/tsWnkDRi/.IVRpEySzEKem7mST95ERKZ3LsiurQH0Rufa5hzE/Be'),
	('9c5b4f11-acdf-4377-b226-72b2c19ee48a', 'Janek', '$2b$06$z8o6tQJ2CQnQrfiBYh0mjedgwFsRTIKws2BKGGRi8QJSG5eAGlma6'),
	('d5310c9c-da92-4ffb-ae3a-b43acab947f6', 'patryczek', '$2b$06$pezZ.1xaE5621ZOCAf5h9.knbr20ACJwBSDyn/GOloEfNzLH8YkS6');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Zrzut struktury tabela megakurs_task-manager.users_tasks
CREATE TABLE IF NOT EXISTS `users_tasks` (
  `id` int(11) NOT NULL,
  `userID` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taskName` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  KEY `taskName` (`taskName`),
  CONSTRAINT `FK_users_tasks_tasks` FOREIGN KEY (`taskName`) REFERENCES `tasks` (`taskName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_users_tasks_users` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli megakurs_task-manager.users_tasks: ~0 rows (około)
/*!40000 ALTER TABLE `users_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_tasks` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
