-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eclb_dev
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eclb_dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eclb_dev` DEFAULT CHARACTER SET utf8 ;
USE `eclb_dev` ;

-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfPatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfPatrimonies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypeOfPatrimony_Description` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfCompositePatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfCompositePatrimonies` (
  `id` INT NOT NULL,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypesOfCompositePatrimonies_Description` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`CompositePatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`CompositePatrimonies` (
  `patrimonyId` INT NOT NULL,
  `typeOfCompositePatrimonyId` INT NOT NULL,
  PRIMARY KEY (`patrimonyId`),
  INDEX `FK_CompositePatrimonies_TypesOfCompositePatrimonies` (`typeOfCompositePatrimonyId` ASC) VISIBLE,
  CONSTRAINT `fk_CompositePatrimonies_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CompositePatrimonies_TypesOfCompositePatrimonies`
    FOREIGN KEY (`typeOfCompositePatrimonyId`)
    REFERENCES `eclb_dev`.`TypesOfCompositePatrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Patrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Patrimonies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `unescoClassification` INT NOT NULL,
  `typeOfPatrimonyId` INT NOT NULL,
  `compositePatrimonyId` INT NULL,
  `hasLocation` INT NOT NULL DEFAULT 0,
  `country` VARCHAR(60) NULL,
  `state` VARCHAR(60) NULL,
  `city` VARCHAR(60) NULL,
  `district` VARCHAR(60) NULL,
  `address` VARCHAR(100) NULL,
  `postalCode` INT NULL,
  `longitude` DOUBLE NULL,
  `latitude` DOUBLE NULL,
  `altitude` DOUBLE NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Patrimonies_TypesOfPatrimonies` (`typeOfPatrimonyId` ASC) VISIBLE,
  INDEX `fk_Patrimonies_CompositePatrimonies1_idx` (`compositePatrimonyId` ASC) VISIBLE,
  CONSTRAINT `FK_Patrimonies_TypesOfPatrimonies`
    FOREIGN KEY (`typeOfPatrimonyId`)
    REFERENCES `eclb_dev`.`TypesOfPatrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patrimonies_CompositePatrimonies1`
    FOREIGN KEY (`compositePatrimonyId`)
    REFERENCES `eclb_dev`.`CompositePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfSimplePatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfSimplePatrimonies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypesOfSimplePatrimonies_Description` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Collections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Collections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`SimplePatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`SimplePatrimonies` (
  `patrimonyId` INT NOT NULL,
  `typeOfSimplePatrimonyId` INT NOT NULL,
  `collectionId` INT NOT NULL,
  PRIMARY KEY (`patrimonyId`),
  INDEX `FK_SimplePatrimonies_TypesOfSimplePatrimonies` (`typeOfSimplePatrimonyId` ASC) VISIBLE,
  INDEX `fk_SimplePatrimonies_Collections1_idx` (`collectionId` ASC) VISIBLE,
  CONSTRAINT `FK_SimplePatrimonies_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SimplePatrimonies_TypesOfSimplePatrimonies`
    FOREIGN KEY (`typeOfSimplePatrimonyId`)
    REFERENCES `eclb_dev`.`TypesOfSimplePatrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SimplePatrimonies_Collections1`
    FOREIGN KEY (`collectionId`)
    REFERENCES `eclb_dev`.`Collections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Persons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyPersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyPersons` (
  `personId` INT NOT NULL,
  `birthday` DATE NOT NULL,
  `biography` TEXT NOT NULL,
  `deathDate` DATE NULL,
  `photo` LONGBLOB NULL,
  PRIMARY KEY (`personId`),
  CONSTRAINT `fk_PatrimonyPersons_Persons1`
    FOREIGN KEY (`personId`)
    REFERENCES `eclb_dev`.`Persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`NotablePersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`NotablePersons` (
  `patrimonyPersonId` INT NOT NULL,
  PRIMARY KEY (`patrimonyPersonId`),
  CONSTRAINT `fk_NotablePersons_PatrimonyPersons1`
    FOREIGN KEY (`patrimonyPersonId`)
    REFERENCES `eclb_dev`.`PatrimonyPersons` (`personId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfActings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfActings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypesOfRoles_Description` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Acting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Acting` (
  `id` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `patrimonyId` INT NOT NULL,
  `notablePersonId` INT NOT NULL,
  `typeOfActingId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Acting_Patrimonies1_idx` (`patrimonyId` ASC) VISIBLE,
  INDEX `fk_Acting_NotablePersons1_idx` (`notablePersonId` ASC) VISIBLE,
  INDEX `fk_Acting_TypesOfActings1_idx` (`typeOfActingId` ASC) VISIBLE,
  CONSTRAINT `fk_Acting_Patrimonies1`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Acting_NotablePersons1`
    FOREIGN KEY (`notablePersonId`)
    REFERENCES `eclb_dev`.`NotablePersons` (`patrimonyPersonId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Acting_TypesOfActings1`
    FOREIGN KEY (`typeOfActingId`)
    REFERENCES `eclb_dev`.`TypesOfActings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfMedias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfMedias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypesOfMedias_Ddescription` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `file` LONGBLOB NOT NULL,
  `extension` VARCHAR(6) NOT NULL,
  `patrimonyId` INT NOT NULL,
  `typesOfMediaId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Media_Patrimonies` (`patrimonyId` ASC) VISIBLE,
  UNIQUE INDEX `UK_Media_Name` (`name` ASC, `patrimonyId` ASC) VISIBLE,
  INDEX `FK_Media_TypesOfMedias` (`typesOfMediaId` ASC) VISIBLE,
  CONSTRAINT `FK_Media_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Media_TypesOfMedias`
    FOREIGN KEY (`typesOfMediaId`)
    REFERENCES `eclb_dev`.`TypesOfMedias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Memories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Memories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `description` TEXT NOT NULL,
  `patrimonyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Memories_Patrimonies` (`patrimonyId` ASC) VISIBLE,
  CONSTRAINT `FK_Memories_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Visitors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Visitors` (
  `personId` INT NOT NULL,
  `address` VARCHAR(80) NOT NULL,
  `number` INT NOT NULL,
  `complemento` VARCHAR(80) NULL,
  `district` VARCHAR(40) NOT NULL,
  `city` VARCHAR(40) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `postalCode` CHAR(8) NOT NULL,
  `phone` CHAR(12) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `memoryId` INT NOT NULL,
  PRIMARY KEY (`personId`),
  UNIQUE INDEX `UK_Visitors_EMail` (`email` ASC) VISIBLE,
  INDEX `fk_Visitors_Memories1_idx` (`memoryId` ASC) VISIBLE,
  CONSTRAINT `fk_Visitors_Persons`
    FOREIGN KEY (`personId`)
    REFERENCES `eclb_dev`.`Persons` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visitors_Memories1`
    FOREIGN KEY (`memoryId`)
    REFERENCES `eclb_dev`.`Memories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Authors` (
  `patrimonyPersonId` INT NOT NULL,
  PRIMARY KEY (`patrimonyPersonId`),
  CONSTRAINT `fk_Authors_PatrimonyPersons1`
    FOREIGN KEY (`patrimonyPersonId`)
    REFERENCES `eclb_dev`.`PatrimonyPersons` (`personId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Authorships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Authorships` (
  `patrimonyId` INT NOT NULL,
  `authorId` INT NOT NULL,
  `description` TEXT NOT NULL,
  INDEX `fk_Authorships_Patrimonies1_idx` (`patrimonyId` ASC) VISIBLE,
  PRIMARY KEY (`patrimonyId`, `authorId`),
  CONSTRAINT `fk_Authorships_Patrimonies1`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authorships_Authors1`
    FOREIGN KEY (`authorId`)
    REFERENCES `eclb_dev`.`Authors` (`patrimonyPersonId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`VisitGuides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`VisitGuides` (
  `compositePatrimonyId` INT NOT NULL,
  `personId` INT NOT NULL,
  INDEX `FK_VisitGuides_CompositePatrimonies` (`compositePatrimonyId` ASC) VISIBLE,
  PRIMARY KEY (`compositePatrimonyId`, `personId`),
  INDEX `fk_VisitGuides_Persons1_idx` (`personId` ASC) VISIBLE,
  CONSTRAINT `FK_VisitGuides_CompositePatrimonies`
    FOREIGN KEY (`compositePatrimonyId`)
    REFERENCES `eclb_dev`.`CompositePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VisitGuides_Persons1`
    FOREIGN KEY (`personId`)
    REFERENCES `eclb_dev`.`Persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`VisitationItinerary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`VisitationItinerary` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(80) NOT NULL,
  `composityPatrimonyId` INT NOT NULL,
  `durattion` TIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_VisitationItineraries` (`description` ASC) VISIBLE,
  INDEX `FK_VisitationItinerary_CompositePatrimonies` (`composityPatrimonyId` ASC) VISIBLE,
  CONSTRAINT `FK_VisitationItinerary_CompositePatrimonies`
    FOREIGN KEY (`composityPatrimonyId`)
    REFERENCES `eclb_dev`.`CompositePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`VisitationStages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`VisitationStages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `visitationItineraryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_VisitationStages_VisitationItinerary` (`visitationItineraryId` ASC) VISIBLE,
  CONSTRAINT `FK_VisitationStages_VisitationItinerary`
    FOREIGN KEY (`visitationItineraryId`)
    REFERENCES `eclb_dev`.`VisitationItinerary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`VisitationElements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`VisitationElements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `visitationStageId` INT NOT NULL,
  `simplePatrimonyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_VisitationElements_VisitationStages` (`visitationStageId` ASC) VISIBLE,
  INDEX `FK_VisitationElements_SimplePatrimonies` (`simplePatrimonyId` ASC) VISIBLE,
  UNIQUE INDEX `UK_VisitationElements_SimplePatrimonyId` (`simplePatrimonyId` ASC) VISIBLE,
  CONSTRAINT `fk_VisitationElements_VisitationStages1`
    FOREIGN KEY (`visitationStageId`)
    REFERENCES `eclb_dev`.`VisitationStages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VisitationElements_SimplePatrimonies1`
    FOREIGN KEY (`simplePatrimonyId`)
    REFERENCES `eclb_dev`.`SimplePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`GuidedVisits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`GuidedVisits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dateTime` DATETIME NOT NULL,
  `visitationItineraryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_GuidedVisits_VisitationItinerary` (`visitationItineraryId` ASC) VISIBLE,
  CONSTRAINT `FK_GuidedVisits_VisitationItinerary`
    FOREIGN KEY (`visitationItineraryId`)
    REFERENCES `eclb_dev`.`VisitationItinerary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Visits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Visits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dateTime` VARCHAR(45) NOT NULL,
  `guidedVisitId` INT NOT NULL,
  `visitorId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Visits_GuidedVisits` (`guidedVisitId` ASC) VISIBLE,
  INDEX `FK_Visits_Visitors` (`visitorId` ASC) VISIBLE,
  CONSTRAINT `FK_Visits_GuidedVisits`
    FOREIGN KEY (`guidedVisitId`)
    REFERENCES `eclb_dev`.`GuidedVisits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Visits_Visitors`
    FOREIGN KEY (`visitorId`)
    REFERENCES `eclb_dev`.`Visitors` (`personId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfEvents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfEvents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `date` DATE NOT NULL,
  `description` TEXT NOT NULL,
  `patrimonyId` INT NOT NULL,
  `typeOfEventId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Events_Patrimonies` (`patrimonyId` ASC) VISIBLE,
  INDEX `fk_Events_TypesOfEvents1_idx` (`typeOfEventId` ASC) VISIBLE,
  CONSTRAINT `FK_Events_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Events_TypesOfEvents1`
    FOREIGN KEY (`typeOfEventId`)
    REFERENCES `eclb_dev`.`TypesOfEvents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`EventMedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`EventMedia` (
  `mediaId` INT NOT NULL,
  `eventId` INT NOT NULL,
  PRIMARY KEY (`mediaId`, `eventId`),
  INDEX `FK_EventMedia_Events` (`eventId` ASC) VISIBLE,
  CONSTRAINT `FK_EventMedia_Media`
    FOREIGN KEY (`mediaId`)
    REFERENCES `eclb_dev`.`Media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EventMedia_Events`
    FOREIGN KEY (`eventId`)
    REFERENCES `eclb_dev`.`Events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfPatrimonyHistorics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfPatrimonyHistorics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_TypesOfPatrimonyHistorics_Description` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyHistorics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyHistorics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `narrative` LONGTEXT NOT NULL,
  `patrimonyId` INT NOT NULL,
  `typeOfPatrimonyHistoricId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_PatrimonyHistorics_Patrimonies` (`patrimonyId` ASC) VISIBLE,
  INDEX `fk_PatrimonyHistorics_TypesOfPatrimonyHistorics1_idx` (`typeOfPatrimonyHistoricId` ASC) VISIBLE,
  CONSTRAINT `FK_PatrimonyHistorics_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PatrimonyHistorics_TypesOfPatrimonyHistorics1`
    FOREIGN KEY (`typeOfPatrimonyHistoricId`)
    REFERENCES `eclb_dev`.`TypesOfPatrimonyHistorics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyHistoricMedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyHistoricMedia` (
  `patrimonyHistoricId` INT NOT NULL,
  `mediaId` INT NOT NULL,
  PRIMARY KEY (`patrimonyHistoricId`, `mediaId`),
  INDEX `FK_PatrimonyHistoricMedia_Media` (`mediaId` ASC) VISIBLE,
  CONSTRAINT `fk_PatrimonyHistoricMedia_PatrimonyHistorics1`
    FOREIGN KEY (`patrimonyHistoricId`)
    REFERENCES `eclb_dev`.`PatrimonyHistorics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PatrimonyHistoricMedia_Media1`
    FOREIGN KEY (`mediaId`)
    REFERENCES `eclb_dev`.`Media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Quiz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  `patrimonyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_Quizz_Patrimonies` (`patrimonyId` ASC) VISIBLE,
  UNIQUE INDEX `UK_Quizz_Description_PatrimonyId` (`description` ASC, `patrimonyId` ASC) VISIBLE,
  CONSTRAINT `FK_Quizz_Patrimonies`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `enuciation` TEXT NOT NULL,
  `quizzId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Questions_Quizz1_idx` (`quizzId` ASC) VISIBLE,
  CONSTRAINT `fk_Questions_Quizz1`
    FOREIGN KEY (`quizzId`)
    REFERENCES `eclb_dev`.`Quiz` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`QuestionItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`QuestionItems` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descrition` TEXT NOT NULL,
  `isAnswer` VARCHAR(45) NOT NULL,
  `questionId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_QuestionItems_Questions` (`questionId` ASC) VISIBLE,
  CONSTRAINT `FK_QuestionItems_Questions`
    FOREIGN KEY (`questionId`)
    REFERENCES `eclb_dev`.`Questions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Users` (
  `personId` INT NOT NULL,
  `login` VARCHAR(20) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `function` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`personId`),
  UNIQUE INDEX `UK_Users_Login` (`login` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Persons1`
    FOREIGN KEY (`personId`)
    REFERENCES `eclb_dev`.`Persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyMovimentation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyMovimentation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `origin` VARCHAR(100) NOT NULL,
  `destination` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `simplePatrimonyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PatrimonyMovimentation_SimplePatrimonies1_idx` (`simplePatrimonyId` ASC) VISIBLE,
  CONSTRAINT `fk_PatrimonyMovimentation_SimplePatrimonies1`
    FOREIGN KEY (`simplePatrimonyId`)
    REFERENCES `eclb_dev`.`SimplePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`Expositions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`Expositions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`ExposedPatrimonies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`ExposedPatrimonies` (
  `expositionId` INT NOT NULL,
  `simplePatrimonyId` INT NOT NULL,
  PRIMARY KEY (`expositionId`, `simplePatrimonyId`),
  INDEX `fk_ExposedPatrimonies_SimplePatrimonies1_idx` (`simplePatrimonyId` ASC) VISIBLE,
  CONSTRAINT `fk_ExposedPatrimonies_Expositions1`
    FOREIGN KEY (`expositionId`)
    REFERENCES `eclb_dev`.`Expositions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExposedPatrimonies_SimplePatrimonies1`
    FOREIGN KEY (`simplePatrimonyId`)
    REFERENCES `eclb_dev`.`SimplePatrimonies` (`patrimonyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`TypesOfPatrimonyNews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`TypesOfPatrimonyNews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyNews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyNews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `patrimonyId` INT NOT NULL,
  `typeOfPatrimonyNewsId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PatrimonyNews_Patrimonies1_idx` (`patrimonyId` ASC) VISIBLE,
  INDEX `fk_PatrimonyNews_TypesOfPatrimonyNews1_idx` (`typeOfPatrimonyNewsId` ASC) VISIBLE,
  CONSTRAINT `fk_PatrimonyNews_Patrimonies1`
    FOREIGN KEY (`patrimonyId`)
    REFERENCES `eclb_dev`.`Patrimonies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PatrimonyNews_TypesOfPatrimonyNews1`
    FOREIGN KEY (`typeOfPatrimonyNewsId`)
    REFERENCES `eclb_dev`.`TypesOfPatrimonyNews` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eclb_dev`.`PatrimonyNewsMedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eclb_dev`.`PatrimonyNewsMedia` (
  `patrimonyNewsId` INT NOT NULL,
  `mediaId` INT NOT NULL,
  PRIMARY KEY (`patrimonyNewsId`, `mediaId`),
  INDEX `fk_PatrimonyNewsMedia_Media1_idx` (`mediaId` ASC) VISIBLE,
  CONSTRAINT `fk_PatrimonyNewsMedia_PatrimonyNews1`
    FOREIGN KEY (`patrimonyNewsId`)
    REFERENCES `eclb_dev`.`PatrimonyNews` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PatrimonyNewsMedia_Media1`
    FOREIGN KEY (`mediaId`)
    REFERENCES `eclb_dev`.`Media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
