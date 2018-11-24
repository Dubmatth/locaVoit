-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 27 Novembre 2017 à 10:53
-- Version du serveur :  10.1.16-MariaDB
-- Version de PHP :  5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `locavoit2016`
--
CREATE DATABASE IF NOT EXISTS `locavoit2016` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `locavoit2016`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `idCat` char(1) NOT NULL,
  `descCat` varchar(50) NOT NULL,
  `nbPortesCat` tinyint(1) UNSIGNED NOT NULL,
  `nbPlacesCat` tinyint(2) UNSIGNED NOT NULL,
  `nbBagCat` tinyint(1) UNSIGNED NOT NULL,
  `pxKmCat` decimal(5,2) UNSIGNED NOT NULL,
  `pxJourCat` decimal(5,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`idCat`, `descCat`, `nbPortesCat`, `nbPlacesCat`, `nbBagCat`, `pxKmCat`, `pxJourCat`) VALUES
('A', 'petite voiture économique 3p', 3, 4, 2, '0.19', '12.50'),
('B', 'petite voiture économique 5p', 5, 5, 2, '0.21', '16.50'),
('C', 'voiture compacte', 5, 5, 3, '0.23', '21.15'),
('N', 'monospace', 5, 6, 4, '0.29', '35.25'),
('P', 'minibus', 4, 9, 5, '0.32', '41.10');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `idCli` int(10) UNSIGNED NOT NULL,
  `nomCli` varchar(30) NOT NULL,
  `prenomCli` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `clients`
--

INSERT INTO `clients` (`idCli`, `nomCli`, `prenomCli`) VALUES
(1, 'Leroy', 'Albert'),
(2, 'Leprince', 'Laurent'),
(3, 'Dheux', 'Albert'),
(4, 'Léroy', 'Philippe'),
(5, 'Legrand', 'Alexandre'),
(6, 'Lequin', 'Charles'),
(7, 'Lagaffe', 'Gaston');

-- --------------------------------------------------------

--
-- Structure de la table `locations`
--

CREATE TABLE `locations` (
  `idLoc` int(10) UNSIGNED NOT NULL,
  `voitureLoc` char(8) NOT NULL,
  `clientLoc` int(10) UNSIGNED NOT NULL,
  `dDebLoc` date NOT NULL,
  `dFinLoc` date DEFAULT NULL,
  `kmDebLoc` int(10) UNSIGNED NOT NULL,
  `kmFinLoc` int(10) UNSIGNED DEFAULT NULL,
  `prixLoc` decimal(7,2) DEFAULT NULL,
  `remLoc` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `locations`
--

INSERT INTO `locations` (`idLoc`, `voitureLoc`, `clientLoc`, `dDebLoc`, `dFinLoc`, `kmDebLoc`, `kmFinLoc`, `prixLoc`, `remLoc`) VALUES
(1, '1-AAA001', 1, '2016-10-03', '2016-10-07', 50, 750, '253.00', NULL),
(2, '1-AAA001', 4, '2016-10-07', '2016-10-09', 750, 1130, '144.20', NULL),
(3, '1-AAA001', 1, '2016-10-15', '2016-10-19', 1130, 2310, '344.20', NULL),
(4, '1-AAA001', 1, '2016-10-21', '2016-10-25', 2350, 4560, '539.90', 'griffes portière droite'),
(5, '1-AAA003', 1, '2016-11-01', '2017-11-27', 50, 39250, '12348.00', ''),
(6, '1-AAA002', 2, '2016-10-11', '2016-10-19', 50, 4120, '989.30', NULL),
(7, '1-CCC001', 6, '2016-10-07', '2016-10-12', 50, 3020, '893.10', NULL),
(8, '1-CCC002', 3, '2016-10-09', '2016-10-11', 50, 560, '222.30', NULL),
(9, '1-CCC002', 3, '2016-10-13', '2016-10-17', 580, 1135, '302.65', NULL),
(10, '1-CCC002', 5, '2016-10-21', '2016-10-26', 1135, 2360, '491.75', NULL),
(11, '1-NNN001', 2, '2016-10-08', '2016-10-14', 50, 2560, '999.99', NULL),
(12, '1-NNN001', 4, '2016-10-15', '2016-10-21', 2560, 3100, '471.60', NULL),
(14, '1-PPP001', 6, '2016-11-12', '2017-11-13', 50, 367, '15185.14', ''),
(15, '1-PPP002', 1, '2016-10-28', '2016-11-06', 50, 666, '1245.00', 'rétro cassé, sièges tachés'),
(16, '1-CCC001', 7, '2016-11-15', '2017-11-27', 3025, 6000, '8678.90', ''),
(17, '1-NNN001', 5, '2017-11-25', NULL, 51000, NULL, NULL, NULL),
(18, '1-PPP001', 5, '2017-11-20', NULL, 60000, NULL, NULL, NULL),
(19, '1-NNN002', 7, '2017-11-01', NULL, 35000, NULL, NULL, NULL),
(20, '1-BBB001', 1, '2017-11-27', NULL, 110000, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `voitures`
--

CREATE TABLE `voitures` (
  `idVoit` varchar(8) NOT NULL COMMENT 'plaque',
  `modVoit` varchar(30) NOT NULL,
  `catVoit` char(1) NOT NULL,
  `carbVoit` enum('E','D') NOT NULL COMMENT 'E/D',
  `kmVoit` int(10) UNSIGNED NOT NULL,
  `dDebVoit` date NOT NULL COMMENT 'mise en service',
  `dFinVoit` date DEFAULT NULL COMMENT 'mise hors service'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `voitures`
--

INSERT INTO `voitures` (`idVoit`, `modVoit`, `catVoit`, `carbVoit`, `kmVoit`, `dDebVoit`, `dFinVoit`) VALUES
('1-AAA001', 'VW Polo', 'A', 'E', 4560, '2016-10-01', NULL),
('1-AAA002', 'VW Polo', 'A', 'E', 4120, '2016-10-01', '2016-10-25'),
('1-AAA003', 'Citroen C1', 'A', 'E', 50, '2016-10-31', NULL),
('1-BBB001', 'VW Golf', 'B', 'D', 50, '2016-10-01', NULL),
('1-BBB002', 'VW Golf', 'B', 'D', 50, '2016-10-01', NULL),
('1-CCC001', 'VW Passat', 'C', 'D', 3020, '2016-10-01', NULL),
('1-CCC002', 'VW Passat', 'C', 'D', 2360, '2016-10-01', NULL),
('1-NNN001', 'Peugeot 807', 'N', 'D', 3100, '2016-10-01', NULL),
('1-NNN002', 'Peugeot 807', 'N', 'D', 50, '2016-10-01', NULL),
('1-PPP001', 'VW Transporter', 'P', 'D', 50, '2016-10-01', NULL),
('1-PPP002', 'Ford Transit', 'P', 'D', 50, '2016-10-15', NULL);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idCat`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`idCli`),
  ADD KEY `idCli` (`idCli`);

--
-- Index pour la table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`idLoc`),
  ADD KEY `voitureLoc` (`voitureLoc`),
  ADD KEY `clientLoc` (`clientLoc`);

--
-- Index pour la table `voitures`
--
ALTER TABLE `voitures`
  ADD PRIMARY KEY (`idVoit`),
  ADD KEY `catVoit` (`catVoit`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `idCli` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `locations`
--
ALTER TABLE `locations`
  MODIFY `idLoc` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`voitureLoc`) REFERENCES `voitures` (`idVoit`),
  ADD CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`clientLoc`) REFERENCES `clients` (`idCli`);

--
-- Contraintes pour la table `voitures`
--
ALTER TABLE `voitures`
  ADD CONSTRAINT `voitures_ibfk_1` FOREIGN KEY (`catVoit`) REFERENCES `categories` (`idCat`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
