-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tpv
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tpv` ;

-- -----------------------------------------------------
-- Schema tpv
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpv` DEFAULT CHARACTER SET latin1 ;
USE `tpv` ;

-- -----------------------------------------------------
-- Table `tpv`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`category` (
  `idCategory` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`customer` (
  `idCustomer` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surnames` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`offer` (
  `idOffer` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `period` DATE NOT NULL,
  `file` LONGBLOB NULL DEFAULT NULL,
  `discount` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`idOffer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`offers_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`offers_customers` (
  `idCustomer` INT(11) NOT NULL,
  `idOffer` INT(11) NOT NULL,
  PRIMARY KEY (`idCustomer`, `idOffer`),
  INDEX `fk_Customer_has_Offer_Offer1_idx` (`idOffer` ASC),
  INDEX `fk_Customer_has_Offer_Customer1_idx` (`idCustomer` ASC),
  CONSTRAINT `fk_Customer_has_Offer_Customer1`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `tpv`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Offer_Offer1`
    FOREIGN KEY (`idOffer`)
    REFERENCES `tpv`.`offer` (`idOffer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`location` (
  `idLocation` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocation`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`permission` (
  `idPermission` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPermission`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`product` (
  `idProduct` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  `price` DOUBLE NOT NULL,
  `quantity` INT(11) NOT NULL,
  `idCategory` INT(11) NOT NULL,
  `idLocation` INT(11) NOT NULL,
  `idOffer` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idProduct`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_Product_Offer1_idx` (`idOffer` ASC),
  INDEX `fk_Product_Category1_idx` (`idCategory` ASC),
  INDEX `fk_Product_Location1_idx` (`idLocation` ASC),
  CONSTRAINT `fk_Product_Category1`
    FOREIGN KEY (`idCategory`)
    REFERENCES `tpv`.`category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Location1`
    FOREIGN KEY (`idLocation`)
    REFERENCES `tpv`.`location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Offer1`
    FOREIGN KEY (`idOffer`)
    REFERENCES `tpv`.`offer` (`idOffer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`role` (
  `idRole` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRole`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`permissions_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`permissions_roles` (
  `idRole` INT(11) NOT NULL,
  `idPermission` INT(11) NOT NULL,
  PRIMARY KEY (`idRole`, `idPermission`),
  INDEX `fk_Role_has_Permission_Permission1_idx` (`idPermission` ASC),
  INDEX `fk_Role_has_Permission_Role1_idx` (`idRole` ASC),
  CONSTRAINT `fk_Role_has_Permission_Permission1`
    FOREIGN KEY (`idPermission`)
    REFERENCES `tpv`.`permission` (`idPermission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Role_has_Permission_Role1`
    FOREIGN KEY (`idRole`)
    REFERENCES `tpv`.`role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`user` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surnames` VARCHAR(45) NULL DEFAULT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idRole` INT(11) NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `login_UNIQUE` (`username` ASC),
  INDEX `fk_User_Role1_idx` (`idRole` ASC),
  CONSTRAINT `fk_User_Role1`
    FOREIGN KEY (`idRole`)
    REFERENCES `tpv`.`role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`sale` (
  `idSale` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `payment` VARCHAR(30) NOT NULL,
  `total` DOUBLE NOT NULL,
  `iva` INT NULL DEFAULT NULL,
  `total_iva` DOUBLE NULL DEFAULT NULL,
  `message` VARCHAR(255) NULL DEFAULT NULL,
  `idCustomer` INT(11) NOT NULL,
  `idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idSale`),
  INDEX `fk_Sale_Customer1_idx` (`idCustomer` ASC),
  INDEX `fk_Sale_User1_idx` (`idUser` ASC),
  CONSTRAINT `fk_Sale_Customer1`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `tpv`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_User1`
    FOREIGN KEY (`idUser`)
    REFERENCES `tpv`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tpv`.`sales_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpv`.`sales_details` (
  `idSale` INT(11) NOT NULL,
  `idProduct` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`idSale`, `idProduct`),
  INDEX `fk_Sale_has_Product_Product1_idx` (`idProduct` ASC),
  INDEX `fk_Sale_has_Product_Sale_idx` (`idSale` ASC),
  CONSTRAINT `fk_Sale_has_Product_Product1`
    FOREIGN KEY (`idProduct`)
    REFERENCES `tpv`.`product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_has_Product_Sale`
    FOREIGN KEY (`idSale`)
    REFERENCES `tpv`.`sale` (`idSale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
