-- -----------------------------------------------------
-- Insert data `tpv`.`customer`
-- -----------------------------------------------------
INSERT INTO `tpv`.`customer` (`id_customer`, `name`, `surnames`, `email`, `address`) VALUES ('1', 'Adrián', 'Carmona', 'cpadri2003@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`id_customer`, `name`, `surnames`, `email`, `address`) VALUES ('2', 'Sofia', 'Puertas', 'sofiapuertas@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`id_customer`, `name`, `surnames`, `email`, `address`) VALUES ('3', 'Damaris', 'Sanchez', 'damarissanchez@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`id_customer`, `name`, `surnames`, `email`, `address`) VALUES ('4', 'Jean', 'Martin', 'jeanmartin@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');
INSERT INTO `tpv`.`customer` (`id_customer`, `name`, `surnames`, `email`, `address`) VALUES ('5', 'Saida', 'Campoy', 'saidacampoy@gmail.com', 'C/ Mare de deu dels desamparats 25, PTA 1');


-- -----------------------------------------------------
-- Insert data `tpv`.`role`
-- -----------------------------------------------------
INSERT INTO `tpv`.`role` (`id_role`, `name`) VALUES ('1', 'Administrador');
INSERT INTO `tpv`.`role` (`id_role`, `name`) VALUES ('2', 'Encargado');
INSERT INTO `tpv`.`role` (`id_role`, `name`) VALUES ('3', 'Empleado');
INSERT INTO `tpv`.`role` (`id_role`, `name`) VALUES ('4', 'Cliente');


-- -----------------------------------------------------
-- Insert data `tpv`.`user`
-- -----------------------------------------------------
INSERT INTO `tpv`.`user` (`id_user`, `name`, `surnames`, `username`, `password`, `id_role`) VALUES ('1', 'Admin', 'Admin', 'admin', 'admin', 1);
INSERT INTO `tpv`.`user` (`id_user`, `name`, `surnames`, `username`, `password`, `id_role`) VALUES ('2', 'Encargado', 'Encargado', 'encargado', 'encargado', '2');
INSERT INTO `tpv`.`user` (`id_user`, `name`, `surnames`, `username`, `password`, `id_role`) VALUES ('3', 'Empleado', 'Empleado', 'empleado', 'empleado', '3');
INSERT INTO `tpv`.`user` (`id_user`, `name`, `surnames`, `username`, `password`, `id_role`) VALUES ('3', 'Cliente', 'Cliente', 'cliente', 'cliente', '4');


-- -----------------------------------------------------
-- Insert data `tpv`.`sale`
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Insert data `tpv`.`permission`
-- -----------------------------------------------------
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('1', 'Introducir ventas');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('2', 'Devolución ventas');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('3', 'Introducir productos');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('4', 'Modificar / Eliminar productos');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('5', 'Campañas de publicidad');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('6', 'Gestionar usuarios');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('7', 'Edición de permisos');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('8', 'Cambio de contraseñas');
INSERT INTO `tpv`.`permission` (`id_permission`, `description`) VALUES ('9', 'Edición de roles');


-- -----------------------------------------------------
-- Insert data `tpv`.`offer`
-- -----------------------------------------------------
INSERT INTO `tpv`.`offer` (`id_offer`, `name`, `period`) VALUES ('1', 'Publicidad', '2022-01-31');
INSERT INTO `tpv`.`offer` (`id_offer`, `name`, `description`, `period`, `discount`) VALUES ('2', 'Descuento', 'Bebidas', '2022-01-31', '10');


-- -----------------------------------------------------
-- Insert data `tpv`.`category`
-- -----------------------------------------------------
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('1', 'Ofertas');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('2', 'Bebidas');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('3', 'Helados');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('4', 'Golosinas');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('5', 'Snacks');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('6', 'Juguetes');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('7', 'Prensa');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('8', 'Cromos');
INSERT INTO `tpv`.`category` (`id_category`, `name`) VALUES ('9', 'Otros');


-- -----------------------------------------------------
-- Insert data `tpv`.`location`
-- -----------------------------------------------------
INSERT INTO `tpv`.`location` (`id_location`, `name`) VALUES ('1', 'Mostrador');
INSERT INTO `tpv`.`location` (`id_location`, `name`) VALUES ('2', 'Estantes');
INSERT INTO `tpv`.`location` (`id_location`, `name`) VALUES ('3', 'Nevera');
INSERT INTO `tpv`.`location` (`id_location`, `name`) VALUES ('4', 'Congelador');
INSERT INTO `tpv`.`location` (`id_location`, `name`) VALUES ('5', 'Almacén');


-- -----------------------------------------------------
-- Insert data `tpv`.`product`
-- -----------------------------------------------------
INSERT INTO `tpv`.`product` (`id_product`, `name`, `price`, `quantity`, `id_category`, `id_location`, `id_offer`) VALUES ('1', 'Fanta Naranja', '0.69', '100', '1', '3', '2');
INSERT INTO `tpv`.`product` (`id_product`, `name`, `price`, `quantity`, `id_category`, `id_location`) VALUES ('2', 'Lenguas', '0.05', '1000', '4', '1');
INSERT INTO `tpv`.`product` (`id_product`, `name`, `price`, `quantity`, `id_category`, `id_location`) VALUES ('3', 'Sobres Copa Mundial 2022', '1', '50', '8', '1');


-- -----------------------------------------------------
-- Insert data `tpv`.`sale_details`
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Insert data `tpv`.`role_permissions`
-- -----------------------------------------------------
-- Administrador
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '1');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '2');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '3');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '4');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '5');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '6');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '7');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '8');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('1', '9');

-- Encargado
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('2', '1');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('2', '2');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('2', '3');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('2', '4');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('2', '5');
-- Empleado
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('3', '1');
INSERT INTO `tpv`.`role_permissions` (`id_role`, `id_permission`) VALUES ('3', '3');


-- -----------------------------------------------------
-- Insert data `tpv`.`customer_offers`
-- -----------------------------------------------------

