-- MySQL Script generated by MySQL Workbench
-- Mon Dec 18 19:27:45 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Rental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Rental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Rental` DEFAULT CHARACTER SET utf8 ;
USE `Rental` ;

-- -----------------------------------------------------
-- Table `Rental`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Customer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Phone_Number` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Phone_Number_UNIQUE` (`Phone_Number` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Address_UNIQUE` (`Address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Vehicle_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Vehicle_Type` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Type_Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Type_Name_UNIQUE` (`Type_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Vehicle` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Vehicle_Type_id` BIGINT NOT NULL,
  `Model` VARCHAR(45) NULL DEFAULT NULL,
  `Registration_Number` VARCHAR(45) NULL DEFAULT NULL,
  `Current_Kilomters` BIGINT NULL DEFAULT NULL,
  `Status` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Vehicle_Vehicle_Type_idx` (`Vehicle_Type_id` ASC) VISIBLE,
  UNIQUE INDEX `Registration_Number_UNIQUE` (`Registration_Number` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicle_Vehicle_Type`
    FOREIGN KEY (`Vehicle_Type_id`)
    REFERENCES `Rental`.`Vehicle_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Contract` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Start_Contract` DATETIME NOT NULL,
  `End_Contract` DATETIME NOT NULL,
  `Salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Employee` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Contract_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Employee_Contract1_idx` (`Contract_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Contract1`
    FOREIGN KEY (`Contract_id`)
    REFERENCES `Rental`.`Contract` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Status` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Status_UNIQUE` (`Status` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Rental_Deal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Rental_Deal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Customer_id` BIGINT UNSIGNED NOT NULL,
  `Start_Rental` DATETIME NOT NULL,
  `End_Rental` DATETIME NOT NULL,
  `Total_Cost` DECIMAL(10,2) NOT NULL,
  `Employee_id` BIGINT NOT NULL,
  `Status_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Rental_Deal_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  INDEX `fk_Rental_Deal_Employee1_idx` (`Employee_id` ASC) VISIBLE,
  INDEX `fk_Rental_Deal_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rental_Deal_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Rental`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rental_Deal_Employee1`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `Rental`.`Employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rental_Deal_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `Rental`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Vehicle_has_Rental_Deal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Vehicle_has_Rental_Deal` (
  `id` BIGINT NOT NULL,
  `Vehicle_id` BIGINT NOT NULL,
  `Rental_Deal_id` BIGINT NOT NULL,
  INDEX `fk_Vehicle_has_Rental_Deal_Rental_Deal1_idx` (`Rental_Deal_id` ASC) VISIBLE,
  INDEX `fk_Vehicle_has_Rental_Deal_Vehicle1_idx` (`Vehicle_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Vehicle_has_Rental_Deal_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `Rental`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicle_has_Rental_Deal_Rental_Deal1`
    FOREIGN KEY (`Rental_Deal_id`)
    REFERENCES `Rental`.`Rental_Deal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Maintenance` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Vehicle_id` BIGINT NOT NULL,
  `Maintenance_Date` DATETIME NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Cost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Maintenance_Vehicle1_idx` (`Vehicle_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maintenance_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `Rental`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Insurance_Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Insurance_Company` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Insurance_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idInsurance_Company_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Insurance_Name_UNIQUE` (`Insurance_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Insurance` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Vehicle_id` BIGINT NOT NULL,
  `PolicyNumber` INT NOT NULL,
  `Cost` DECIMAL(10,2) NOT NULL,
  `Insurance_Company_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Insurance_Vehicle1_idx` (`Vehicle_id` ASC) VISIBLE,
  UNIQUE INDEX `PolicyNumber_UNIQUE` (`PolicyNumber` ASC) VISIBLE,
  INDEX `fk_Insurance_Insurance_Company1_idx` (`Insurance_Company_id` ASC) VISIBLE,
  CONSTRAINT `fk_Insurance_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `Rental`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Insurance_Insurance_Company1`
    FOREIGN KEY (`Insurance_Company_id`)
    REFERENCES `Rental`.`Insurance_Company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Feedback` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Rate` INT NOT NULL,
  `Description` VARCHAR(45) NULL DEFAULT NULL,
  `Rental_Deal_id` BIGINT NOT NULL,
  `Customer_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idFeedback_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Feedback_Rental_Deal1_idx` (`Rental_Deal_id` ASC) VISIBLE,
  INDEX `fk_Feedback_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Feedback_Rental_Deal1`
    FOREIGN KEY (`Rental_Deal_id`)
    REFERENCES `Rental`.`Rental_Deal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Feedback_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Rental`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Payment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Amount` DECIMAL(10,2) NOT NULL,
  `Payment_Date` DATETIME NOT NULL,
  `Payment_Method` VARCHAR(45) NOT NULL,
  `Rental_Deal_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Payment_Rental_Deal1_idx` (`Rental_Deal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Rental_Deal1`
    FOREIGN KEY (`Rental_Deal_id`)
    REFERENCES `Rental`.`Rental_Deal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rental`.`Damage_Raport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rental`.`Damage_Raport` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `Raport_Date` DATETIME NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Vehicle_id` BIGINT NOT NULL,
  `Rental_Deal_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Damage_Raport_Vehicle1_idx` (`Vehicle_id` ASC) VISIBLE,
  INDEX `fk_Damage_Raport_Rental_Deal1_idx` (`Rental_Deal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Damage_Raport_Vehicle1`
    FOREIGN KEY (`Vehicle_id`)
    REFERENCES `Rental`.`Vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Damage_Raport_Rental_Deal1`
    FOREIGN KEY (`Rental_Deal_id`)
    REFERENCES `Rental`.`Rental_Deal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
