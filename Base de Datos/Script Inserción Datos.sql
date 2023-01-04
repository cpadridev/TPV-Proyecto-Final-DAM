-- -----------------------------------------------------
-- Insert data `tpv`.`customer`
-- -----------------------------------------------------
INSERT INTO `tpv`.`customer` (`idCustomer`, `name`, `surnames`, `email`, `address`) VALUES ('1', 'Adrián', 'Carmona', 'cpadri2003@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`idCustomer`, `name`, `surnames`, `email`, `address`) VALUES ('2', 'Sofia', 'Puertas', 'sofiapuertas@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`idCustomer`, `name`, `surnames`, `email`, `address`) VALUES ('3', 'Damaris', 'Sanchez', 'damarissanchez@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`idCustomer`, `name`, `surnames`, `email`, `address`) VALUES ('4', 'Jean', 'Martin', 'jeanmartin@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`idCustomer`, `name`, `surnames`, `email`, `address`) VALUES ('5', 'Saida', 'Campoy', 'saidacampoy@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');


-- -----------------------------------------------------
-- Insert data `tpv`.`role`
-- -----------------------------------------------------
INSERT INTO `tpv`.`role` (`idRole`, `name`) VALUES ('1', 'Administrador');
INSERT INTO `tpv`.`role` (`idRole`, `name`) VALUES ('2', 'Encargado');
INSERT INTO `tpv`.`role` (`idRole`, `name`) VALUES ('3', 'Empleado');


-- -----------------------------------------------------
-- Insert data `tpv`.`user`
-- -----------------------------------------------------
INSERT INTO `tpv`.`user` (`idUser`, `name`, `surnames`, `username`, `password`, `idRole`) VALUES ('1', 'Admin', 'Admin', 'admin', 'admin', 1);
INSERT INTO `tpv`.`user` (`idUser`, `name`, `surnames`, `username`, `password`, `idRole`) VALUES ('2', 'Encargado', 'Encargado', 'encargado', 'encargado', '2');
INSERT INTO `tpv`.`user` (`idUser`, `name`, `surnames`, `username`, `password`, `idRole`) VALUES ('3', 'Empleado', 'Empleado', 'empleado', 'empleado', '3');


-- -----------------------------------------------------
-- Insert data `tpv`.`sale`
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Insert data `tpv`.`permission`
-- -----------------------------------------------------
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('1', 'Introducir ventas');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('2', 'Devolución ventas');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('3', 'Introducir productos');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('4', 'Modificar / Eliminar productos');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('5', 'Campañas de publicidad');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('6', 'Gestionar usuarios');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('7', 'Edición de permisos');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('8', 'Cambio de contraseñas');
INSERT INTO `tpv`.`permission` (`idPermission`, `description`) VALUES ('9', 'Edición de roles');


-- -----------------------------------------------------
-- Insert data `tpv`.`offer`
-- -----------------------------------------------------
INSERT INTO `tpv`.`offer` (`idOffer`, `name`, `period`, `file`) VALUES ('1', 'Publicidad', '2022-01-31', ?);
INSERT INTO `tpv`.`offer` (`idOffer`, `name`, `description`, `period`, `discount`) VALUES ('2', 'Descuento', 'Bebidas', '2022-01-31', '10');


-- -----------------------------------------------------
-- Insert data `tpv`.`category`
-- -----------------------------------------------------
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('1', 'Ofertas');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('2', 'Bebidas');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('3', 'Helados');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('4', 'Golosinas');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('5', 'Patatas');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('6', 'Juguetes');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('7', 'Revistas');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('8', 'Cromos');
INSERT INTO `tpv`.`category` (`idCategory`, `name`) VALUES ('9', 'Otros');


-- -----------------------------------------------------
-- Insert data `tpv`.`location`
-- -----------------------------------------------------
INSERT INTO `tpv`.`location` (`idLocation`, `name`) VALUES ('1', 'Mostrador');
INSERT INTO `tpv`.`location` (`idLocation`, `name`) VALUES ('2', 'Estantes');
INSERT INTO `tpv`.`location` (`idLocation`, `name`) VALUES ('3', 'Nevera');
INSERT INTO `tpv`.`location` (`idLocation`, `name`) VALUES ('4', 'Congelador');
INSERT INTO `tpv`.`location` (`idLocation`, `name`) VALUES ('5', 'Almacén');


-- -----------------------------------------------------
-- Insert data `tpv`.`product`
-- -----------------------------------------------------
INSERT INTO `tpv`.`product` (`idProduct`, `name`, `image`, `price`, `quantity`, `idCategory`, `idLocation`, `idOffer`) VALUES ('1', 'Fanta Naranja', ?, '0.69', '100', '1', '3', '2');
INSERT INTO `tpv`.`product` (`idProduct`, `name`, `image`, `price`, `quantity`, `idCategory`, `idLocation`) VALUES ('2', 'Lenguas', ?, '0.05', '1000', '4', '1');
INSERT INTO `tpv`.`product` (`idProduct`, `name`, `image`, `price`, `quantity`, `idCategory`, `idLocation`) VALUES ('3', 'Sobres Copa Mundial 2022', ?, '1', '50', '8', '1');


-- -----------------------------------------------------
-- Insert data `tpv`.`sales_details`
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Insert data `tpv`.`permissions_roles`
-- -----------------------------------------------------
-- Administrador
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '1');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '2');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '3');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '4');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '5');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '6');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '7');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '8');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('1', '9');

-- Encargado
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('2', '1');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('2', '2');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('2', '3');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('2', '4');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('2', '5');
-- Empleado
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('3', '1');
INSERT INTO `tpv`.`permissions_roles` (`idRole`, `idPermission`) VALUES ('3', '3');


-- -----------------------------------------------------
-- Insert data `tpv`.`offers_customers`
-- -----------------------------------------------------

