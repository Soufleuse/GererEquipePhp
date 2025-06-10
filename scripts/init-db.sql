-- Script d'initialisation de la base de données
-- Ce fichier sera exécuté automatiquement lors de la première création de la DB

USE `LigueHockey`;

-- --------------------------------------------------------

--
-- Structure de la table `AnneeStats`
--

CREATE TABLE IF NOT EXISTS `AnneeStats` (
  `AnneeStats` smallint(6) NOT NULL,
  `DescnCourte` varchar(10) NOT NULL,
  `DescnLongue` varchar(200) NOT NULL,
  PRIMARY KEY (`AnneeStats`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `AnneeStats`
--

INSERT INTO `AnneeStats` (`AnneeStats`, `DescnCourte`, `DescnLongue`) VALUES
(2017, '2017/2018', 'Représente la saison 2017/2018'),
(2018, '2018/2019', 'Représente la saison 2018/2019'),
(2019, '2019/2020', 'Représente la saison 2019/2020'),
(2020, '2020/2021', 'Représente la saison 2020/2021'),
(2021, '2021/2022', 'Représente la saison 2021/2022'),
(2022, '2022/2023', 'Représente la saison 2022/2023'),
(2023, '2023/2024', 'Représente la saison 2023/2024'),
(2024, '2024/2025', 'Représente la saison 2024/2025');

-- --------------------------------------------------------

--
-- Structure de la table `Equipe`
--

CREATE TABLE IF NOT EXISTS `Equipe` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `NomEquipe` varchar(50) NOT NULL,
  `Ville` varchar(50) NOT NULL,
  `AnneeDebut` int(11) NOT NULL,
  `AnneeFin` int(11) DEFAULT NULL,
  `EstDevenueEquipe` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Equipe`
--

INSERT INTO `Equipe` (`Id`, `NomEquipe`, `Ville`, `AnneeDebut`, `AnneeFin`, `EstDevenueEquipe`) VALUES
(1, 'Canadiensssss', 'Mourial', 1989, NULL, NULL),
(2, 'Bruns', 'Albany', 1984, NULL, NULL),
(3, 'Harfangs', 'Hartford', 1976, NULL, NULL),
(4, 'Boulettes', 'Victoriaville', 1999, NULL, NULL),
(5, 'Rocher', 'Percé', 2001, NULL, NULL),
(6, 'Pierre', 'Rochester', 1986, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `EquipeJoueur`
--

CREATE TABLE IF NOT EXISTS `EquipeJoueur` (
  `JoueurId` int(11) NOT NULL,
  `EquipeId` int(11) NOT NULL,
  `DateDebutAvecEquipe` datetime(6) NOT NULL,
  `DateFinAvecEquipe` datetime(6) DEFAULT NULL,
  `NoDossard` smallint(6) NOT NULL,
  PRIMARY KEY (`EquipeId`,`JoueurId`,`DateDebutAvecEquipe`),
  KEY `IX_EquipeJoueur_JoueurId` (`JoueurId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `EquipeJoueur`
--

INSERT INTO `EquipeJoueur` (`JoueurId`, `EquipeId`, `DateDebutAvecEquipe`, `DateFinAvecEquipe`, `NoDossard`) VALUES
(1, 1, '2008-09-30 00:00:00.000000', NULL, 23),
(2, 1, '2016-09-30 00:00:00.000000', NULL, 24),
(3, 1, '2017-09-30 00:00:00.000000', NULL, 25),
(4, 1, '2013-09-30 00:00:00.000000', NULL, 26),
(5, 2, '2014-09-30 00:00:00.000000', NULL, 27),
(6, 2, '2020-11-30 00:00:00.000000', NULL, 28),
(7, 2, '2018-01-15 00:00:00.000000', NULL, 29),
(8, 2, '2010-09-30 00:00:00.000000', NULL, 30),
(9, 3, '2018-04-20 00:00:00.000000', NULL, 31),
(10, 3, '2018-02-13 00:00:00.000000', NULL, 32),
(11, 3, '2018-10-30 00:00:00.000000', NULL, 33),
(12, 4, '2011-09-10 00:00:00.000000', NULL, 34),
(13, 4, '2012-08-20 00:00:00.000000', NULL, 35);

-- --------------------------------------------------------

--
-- Structure de la table `FeuillePointage`
--

CREATE TABLE IF NOT EXISTS `FeuillePointage` (
  `MomentDuButMarque` time(6) NOT NULL,
  `IdPartie` int(11) NOT NULL,
  `IdJoueurButMarque` int(11) NOT NULL,
  `IdJoueurPremiereAssistance` int(11) DEFAULT NULL,
  `IdJoueurSecondeAssistance` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdPartie`,`MomentDuButMarque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Joueur`
--

CREATE TABLE IF NOT EXISTS `Joueur` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Prenom` varchar(50) NOT NULL,
  `Nom` varchar(50) NOT NULL,
  `DateNaissance` datetime(6) NOT NULL,
  `VilleNaissance` varchar(50) NOT NULL,
  `PaysOrigine` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Joueur`
--

INSERT INTO `Joueur` (`Id`, `Prenom`, `Nom`, `DateNaissance`, `VilleNaissance`, `PaysOrigine`) VALUES
(1, 'Jack', 'Tremblay', '1988-10-20 00:00:00.000000', 'Lévis', 'Canada'),
(2, 'Simon', 'Lajeunesse', '1996-01-25 00:00:00.000000', 'St-Stanislas', 'Canada'),
(3, 'Mathieu', 'Grandpré', '1995-03-05 00:00:00.000000', 'Val d\'or', 'Canada'),
(4, 'Ryan', 'Callahan', '1991-03-15 00:00:00.000000', 'London', 'Canada'),
(5, 'Drew', 'McCain', '1992-06-18 00:00:00.000000', 'Albany', 'États-Unis'),
(6, 'John', 'Harris', '2000-09-10 00:00:00.000000', 'Chico', 'États-Unis'),
(7, 'Phil', 'Rodgers', '1996-12-21 00:00:00.000000', 'Calgary', 'Canada'),
(8, 'Ted', 'Rodriguez', '1992-10-21 00:00:00.000000', 'Regina', 'Canada'),
(9, 'Patrice', 'Lemieux', '1998-04-21 00:00:00.000000', 'Chibougamau', 'Canada'),
(10, 'Maurice', 'Béliveau', '1997-06-01 00:00:00.000000', 'Beauceville', 'Canada'),
(11, 'Andrew', 'Cruz', '1997-07-30 00:00:00.000000', 'Dallas', 'États-Unis'),
(12, 'Chris', 'Trout', '1991-08-20 00:00:00.000000', 'Eau Claire', 'États-Unis'),
(13, 'Sergei', 'Datzyuk', '1992-09-06 00:00:00.000000', 'Eau Claire', 'États-Unis');

-- --------------------------------------------------------

--
-- Structure de la table `Parametres`
--

CREATE TABLE IF NOT EXISTS `Parametres` (
  `nom` varchar(255) NOT NULL,
  `dateDebut` datetime(6) NOT NULL,
  `valeur` varchar(200) NOT NULL,
  `dateFin` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`nom`,`dateDebut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Parametres`
--

INSERT INTO `Parametres` (`nom`, `dateDebut`, `valeur`, `dateFin`) VALUES
('AjoutSteve', '2020-01-01 00:00:00.000000', 'ma valeur', NULL),
('nombrePartiesJouees', '1995-08-01 00:00:00.000000', '82', '2004-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2004-08-01 00:00:00.000000', '0', '2005-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2005-08-01 00:00:00.000000', '82', '2012-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2012-08-01 00:00:00.000000', '48', '2013-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2013-08-01 00:00:00.000000', '82', '2019-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2019-08-01 00:00:00.000000', '71', '2020-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2020-08-01 00:00:00.000000', '56', '2021-07-31 00:00:00.000000'),
('nombrePartiesJouees', '2021-08-01 00:00:00.000000', '82', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `Partie`
--

CREATE TABLE IF NOT EXISTS `Partie` (
  `IdPartie` int(11) NOT NULL AUTO_INCREMENT,
  `DatePartieJouee` datetime(6) NOT NULL,
  `AnneeStats` smallint(6) NOT NULL,
  `NbreButsComptesParHote` smallint(6) DEFAULT NULL,
  `NbreButsComptesParVisiteur` smallint(6) DEFAULT NULL,
  `AFiniEnProlongation` varchar(1) DEFAULT NULL,
  `AFiniEnTirDeBarrage` varchar(1) DEFAULT NULL,
  `EstUnePartieDeSerie` varchar(1) NOT NULL,
  `EstUnePartiePresaison` varchar(1) NOT NULL,
  `EstUnePartieSaisonReguliere` varchar(1) NOT NULL,
  `SommairePartie` longtext NOT NULL,
  `IdEquipeHote` int(11) NOT NULL,
  `IdEquipeVisiteuse` int(11) NOT NULL,
  PRIMARY KEY (`IdPartie`),
  UNIQUE KEY `IX_Partie_IdEquipeHote_IdEquipeVisiteuse_DatePartieJouee` (`IdEquipeHote`,`IdEquipeVisiteuse`,`DatePartieJouee`),
  KEY `IX_Partie_AnneeStats` (`AnneeStats`),
  KEY `IX_Partie_IdEquipeVisiteuse` (`IdEquipeVisiteuse`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Partie`
--

INSERT INTO `Partie` (`IdPartie`, `DatePartieJouee`, `AnneeStats`, `NbreButsComptesParHote`, `NbreButsComptesParVisiteur`, `AFiniEnProlongation`, `AFiniEnTirDeBarrage`, `EstUnePartieDeSerie`, `EstUnePartiePresaison`, `EstUnePartieSaisonReguliere`, `SommairePartie`, `IdEquipeHote`, `IdEquipeVisiteuse`) VALUES
(1, '2024-10-05 20:00:00.000000', 2024, NULL, NULL, NULL, NULL, 'N', 'N', 'O', '', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `Penalites`
--

CREATE TABLE IF NOT EXISTS `Penalites` (
  `MomentDelaPenalite` time(6) NOT NULL,
  `IdPartie` int(11) NOT NULL,
  `IdJoueurPenalise` int(11) NOT NULL,
  PRIMARY KEY (`MomentDelaPenalite`,`IdPartie`),
  KEY `IX_Penalites_IdJoueurPenalise` (`IdJoueurPenalise`),
  KEY `IX_Penalites_IdPartie` (`IdPartie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Penalite_TypePenalite`
--

CREATE TABLE IF NOT EXISTS `Penalite_TypePenalite` (
  `IdPenalite` int(11) NOT NULL,
  `IdTypePenalite` smallint(6) NOT NULL,
  `MomentDelaPenalite` time(6) NOT NULL,
  `IdJoueurPenalise` int(11) NOT NULL,
  PRIMARY KEY (`IdPenalite`),
  KEY `IX_Penalite_TypePenalite_IdTypePenalite` (`IdTypePenalite`),
  KEY `IX_Penalite_TypePenalite_MomentDelaPenalite_IdJoueurPenalise` (`MomentDelaPenalite`,`IdJoueurPenalise`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `StatsEquipe`
--

CREATE TABLE IF NOT EXISTS `StatsEquipe` (
  `AnneeStats` smallint(6) NOT NULL,
  `EquipeId` int(11) NOT NULL,
  `NbPartiesJouees` smallint(6) NOT NULL,
  `NbVictoires` smallint(6) NOT NULL,
  `NbDefaites` smallint(6) NOT NULL,
  `NbDefProlo` smallint(6) DEFAULT NULL,
  `NbButsPour` int(11) NOT NULL,
  `NbButsContre` int(11) NOT NULL,
  PRIMARY KEY (`EquipeId`,`AnneeStats`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `StatsEquipe`
--

INSERT INTO `StatsEquipe` (`AnneeStats`, `EquipeId`, `NbPartiesJouees`, `NbVictoires`, `NbDefaites`, `NbDefProlo`, `NbButsPour`, `NbButsContre`) VALUES
(2018, 1, 82, 33, 34, 15, 310, 312),
(2019, 1, 82, 43, 29, 10, 330, 290),
(2020, 1, 82, 50, 20, 12, 380, 267),
(2021, 1, 82, 50, 20, 12, 380, 267),
(2022, 1, 82, 50, 20, 12, 380, 267),
(2023, 1, 82, 51, 20, 11, 380, 267),
(2025, 1, 82, 40, 31, 11, 243, 261),
(2018, 2, 82, 45, 23, 14, 340, 275),
(2019, 2, 82, 48, 21, 13, 345, 255),
(2020, 2, 82, 45, 26, 11, 315, 287),
(2021, 2, 82, 45, 26, 11, 315, 287),
(2022, 2, 82, 45, 26, 11, 315, 287),
(2023, 2, 82, 45, 26, 11, 315, 287),
(2025, 2, 82, 33, 39, 10, 222, 271),
(2018, 3, 82, 47, 26, 9, 340, 298),
(2019, 3, 82, 46, 26, 10, 320, 295),
(2020, 3, 82, 44, 30, 8, 300, 307),
(2021, 3, 82, 44, 30, 8, 300, 307),
(2022, 3, 82, 44, 30, 8, 300, 307),
(2023, 3, 82, 44, 30, 8, 300, 307),
(2018, 4, 82, 41, 31, 10, 341, 280),
(2019, 4, 82, 38, 33, 11, 311, 307),
(2020, 4, 82, 34, 40, 8, 280, 337),
(2021, 4, 82, 34, 40, 8, 280, 337),
(2022, 4, 82, 34, 40, 8, 280, 337),
(2023, 4, 82, 34, 40, 8, 280, 337);

-- --------------------------------------------------------

--
-- Structure de la table `StatsJoueur`
--

CREATE TABLE IF NOT EXISTS `StatsJoueur` (
  `AnneeStats` smallint(6) NOT NULL,
  `JoueurId` int(11) NOT NULL,
  `EquipeId` int(11) NOT NULL,
  `NbPartiesJouees` smallint(6) NOT NULL,
  `NbButs` smallint(6) NOT NULL,
  `NbPasses` smallint(6) NOT NULL,
  `NbPoints` smallint(6) NOT NULL,
  `NbMinutesPenalites` smallint(6) NOT NULL,
  `PlusseMoins` smallint(6) NOT NULL,
  `Victoires` smallint(6) NOT NULL,
  `Defaites` smallint(6) NOT NULL,
  `Nulles` smallint(6) NOT NULL,
  `DefaitesEnProlongation` smallint(6) NOT NULL,
  `ButsAlloues` int(11) NOT NULL,
  `TirsAlloues` int(11) NOT NULL,
  `MinutesJouees` double NOT NULL,
  PRIMARY KEY (`JoueurId`,`EquipeId`,`AnneeStats`),
  KEY `IX_StatsJoueur_EquipeId` (`EquipeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `StatsJoueur`
--

INSERT INTO `StatsJoueur` (`AnneeStats`, `JoueurId`, `EquipeId`, `NbPartiesJouees`, `NbButs`, `NbPasses`, `NbPoints`, `NbMinutesPenalites`, `PlusseMoins`, `Victoires`, `Defaites`, `Nulles`, `DefaitesEnProlongation`, `ButsAlloues`, `TirsAlloues`, `MinutesJouees`) VALUES
(2018, 1, 1, 65, 1810, 20, 1830, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2019, 1, 1, 82, 1910, 20, 1930, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2020, 1, 1, 25, 10, 20, 30, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2021, 1, 1, 25, 10, 20, 30, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2022, 1, 1, 25, 10, 20, 30, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2023, 1, 1, 25, 10, 20, 30, 15, 5, 0, 0, 0, 0, 0, 0, 500),
(2018, 2, 1, 65, 1815, 10, 1825, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2019, 2, 1, 82, 1915, 10, 1925, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2020, 2, 1, 25, 15, 10, 25, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2021, 2, 1, 25, 15, 10, 25, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2022, 2, 1, 25, 15, 10, 25, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2023, 2, 1, 25, 15, 10, 25, 51, -2, 0, 0, 0, 0, 0, 0, 500),
(2018, 3, 1, 65, 1805, 24, 1829, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2019, 3, 1, 82, 1905, 24, 1929, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2020, 3, 1, 25, 5, 24, 29, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2021, 3, 1, 25, 5, 24, 29, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2022, 3, 1, 25, 5, 24, 29, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2023, 3, 1, 25, 5, 24, 29, 35, 25, 0, 0, 0, 0, 0, 0, 500),
(2018, 4, 1, 65, 1800, 0, 1800, 4, 0, 9, 2, 0, 6, 53, 564, 1500),
(2019, 4, 1, 82, 1900, 0, 1900, 4, 0, 9, 2, 0, 6, 53, 564, 1500),
(2020, 4, 1, 25, 0, 0, 0, 4, 0, 9, 2, 0, 6, 53, 564, 1500),
(2021, 4, 1, 25, 0, 0, 0, 4, 0, 9, 2, 0, 6, 53, 564, 1500),
(2022, 4, 1, 25, 0, 0, 0, 4, 0, 9, 2, 0, 6, 53, 564, 1500),
(2023, 4, 1, 25, 0, 0, 0, 4, 0, 9, 2, 0, 6, 53, 564, 1500);

-- --------------------------------------------------------

--
-- Structure de la table `TypePenalites`
--

CREATE TABLE IF NOT EXISTS `TypePenalites` (
  `IdTypePenalite` smallint(6) NOT NULL,
  `NbreMinutesPenalitesPourCetteInfraction` int(11) NOT NULL,
  `DescriptionPenalite` varchar(100) NOT NULL,
  PRIMARY KEY (`IdTypePenalite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `TypePenalites`
--

INSERT INTO `TypePenalites` (`IdTypePenalite`, `NbreMinutesPenalitesPourCetteInfraction`, `DescriptionPenalite`) VALUES
(1, 2, 'Mineure'),
(2, 5, 'Majeure'),
(3, 10, 'Inconduite de partie');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `EquipeJoueur`
--
ALTER TABLE `EquipeJoueur`
  ADD CONSTRAINT `FK_EquipeJoueur_Equipe_EquipeId` FOREIGN KEY (`EquipeId`) REFERENCES `Equipe` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_EquipeJoueur_Joueur_JoueurId` FOREIGN KEY (`JoueurId`) REFERENCES `Joueur` (`Id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `FeuillePointage`
--
ALTER TABLE `FeuillePointage`
  ADD CONSTRAINT `FK_FeuillePointage_Partie_IdPartie` FOREIGN KEY (`IdPartie`) REFERENCES `Partie` (`IdPartie`);

--
-- Contraintes pour la table `Partie`
--
ALTER TABLE `Partie`
  ADD CONSTRAINT `FK_Partie_AnneeStats_AnneeStats` FOREIGN KEY (`AnneeStats`) REFERENCES `AnneeStats` (`AnneeStats`),
  ADD CONSTRAINT `FK_Partie_Equipe_IdEquipeHote` FOREIGN KEY (`IdEquipeHote`) REFERENCES `Equipe` (`Id`),
  ADD CONSTRAINT `FK_Partie_Equipe_IdEquipeVisiteuse` FOREIGN KEY (`IdEquipeVisiteuse`) REFERENCES `Equipe` (`Id`);

--
-- Contraintes pour la table `Penalites`
--
ALTER TABLE `Penalites`
  ADD CONSTRAINT `FK_Penalites_Joueur_IdJoueurPenalise` FOREIGN KEY (`IdJoueurPenalise`) REFERENCES `Joueur` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_Penalites_Partie_IdPartie` FOREIGN KEY (`IdPartie`) REFERENCES `Partie` (`IdPartie`);

--
-- Contraintes pour la table `Penalite_TypePenalite`
--
ALTER TABLE `Penalite_TypePenalite`
  ADD CONSTRAINT `FK_Penalite_TypePenalite_Penalites_MomentDelaPenalite_IdJoueurP~` FOREIGN KEY (`MomentDelaPenalite`,`IdJoueurPenalise`) REFERENCES `Penalites` (`MomentDelaPenalite`, `IdPartie`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_Penalite_TypePenalite_TypePenalites_IdTypePenalite` FOREIGN KEY (`IdTypePenalite`) REFERENCES `TypePenalites` (`IdTypePenalite`) ON DELETE CASCADE;

--
-- Contraintes pour la table `StatsEquipe`
--
ALTER TABLE `StatsEquipe`
  ADD CONSTRAINT `FK_StatsEquipe_Equipe_EquipeId` FOREIGN KEY (`EquipeId`) REFERENCES `Equipe` (`Id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `StatsJoueur`
--
ALTER TABLE `StatsJoueur`
  ADD CONSTRAINT `FK_StatsJoueur_Equipe_EquipeId` FOREIGN KEY (`EquipeId`) REFERENCES `Equipe` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_StatsJoueur_Joueur_JoueurId` FOREIGN KEY (`JoueurId`) REFERENCES `Joueur` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
