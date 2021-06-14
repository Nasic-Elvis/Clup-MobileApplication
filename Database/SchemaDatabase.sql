-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema clup_engsw2020
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clup_engsw2020
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clup_engsw2020` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `clup_engsw2020` ;

-- -----------------------------------------------------
-- Table `clup_engsw2020`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`store` (
  `idstore` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `telephoneNumber` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  `bookableCapacity` INT NULL DEFAULT NULL,
  `imgUrl` VARCHAR(1200) NULL DEFAULT NULL,
  `rating` DOUBLE NULL DEFAULT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `iconUrl` VARCHAR(200) NULL DEFAULT NULL,
  `category` VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (`idstore`))
ENGINE = InnoDB
AUTO_INCREMENT = 140
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `clup_engsw2020`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `Surname` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `BirthdayDate` DATE NULL DEFAULT NULL,
  `Sesso` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `TelephoneNumber` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `Email` VARCHAR(75) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `Username` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `Password` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `idStore` INT NULL DEFAULT NULL,
  `guest` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `idStore_idx` (`idStore` ASC) VISIBLE,
  CONSTRAINT `idStore`
    FOREIGN KEY (`idStore`)
    REFERENCES `clup_engsw2020`.`store` (`idstore`))
ENGINE = InnoDB
AUTO_INCREMENT = 431
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `clup_engsw2020`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`booking` (
  `idBooking` INT NOT NULL AUTO_INCREMENT,
  `bookingDate` DATE NULL DEFAULT NULL,
  `ArrivalTime` TIME NULL DEFAULT NULL,
  `FinishTime` TIME NULL DEFAULT NULL,
  `idUser` INT NULL DEFAULT NULL,
  `idStore` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idBooking`),
  INDEX `idUser_idx` (`idUser` ASC) VISIBLE,
  INDEX `idStore_idx` (`idStore` ASC) VISIBLE,
  CONSTRAINT `idStoreInBooking`
    FOREIGN KEY (`idStore`)
    REFERENCES `clup_engsw2020`.`store` (`idstore`),
  CONSTRAINT `idUserInBooking`
    FOREIGN KEY (`idUser`)
    REFERENCES `clup_engsw2020`.`user` (`idUser`))
ENGINE = InnoDB
AUTO_INCREMENT = 129
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `clup_engsw2020`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`category` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
AUTO_INCREMENT = 52
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `clup_engsw2020`.`days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`days` (
  `iddays` INT NOT NULL AUTO_INCREMENT,
  `day` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`iddays`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `clup_engsw2020`.`storeindays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clup_engsw2020`.`storeindays` (
  `idstoreInDays` INT NOT NULL AUTO_INCREMENT,
  `idStore` INT NULL DEFAULT NULL,
  `idDay` INT NULL DEFAULT NULL,
  `from` VARCHAR(45) NULL DEFAULT NULL,
  `to` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idstoreInDays`),
  INDEX `fk_idStore_idx` (`idStore` ASC) VISIBLE,
  INDEX `fk_day_idx` (`idDay` ASC) VISIBLE,
  CONSTRAINT `fk_day`
    FOREIGN KEY (`idDay`)
    REFERENCES `clup_engsw2020`.`days` (`iddays`),
  CONSTRAINT `fk_idStore`
    FOREIGN KEY (`idStore`)
    REFERENCES `clup_engsw2020`.`store` (`idstore`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
