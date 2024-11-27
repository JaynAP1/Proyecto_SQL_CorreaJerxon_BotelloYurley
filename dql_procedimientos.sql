Use Finca_Jurley;

-- 1. Crear un procedimiento que permita agregar un nuevo estado.
drop procedure if exists AddNewEstado;
Delimiter //
Create procedure AddNewEstado(in Nombre varchar(30))
begin
	insert into estado (Nombre) values (Nombre);
end
// Delimiter ;
call AddNewEstado("Reserva");

-- 2. Crea un procedimiento que permita cambiar el valor de la venta total.
drop procedure if exists CalcularVenta;
Delimiter //
Create procedure CalcularVenta(in id_in int, out Salida bigint)
begin
	Select (producto_cantidad * Precio_unidad) into Salida  from Ventas inner join Productos on ventas.id_producto = productos.id where ventas.id = id_in;
    
    update ventas set Valor_Unidad = Salida where id = id_in;
end
// Delimiter ;

call CalcularVenta(1,@Salida);
select @salida as NuevoValor;

-- 3. Cambiar el estado de las maquinas.
drop procedure if exists CambiarEstadoMaquinaria;

Delimiter //
Create procedure CambiarEstadoMaquinaria(in id_in int, in id_NewEstado int)
begin
	Declare EstadoActual int;
    Set EstadoActual = (select id_Estado from maquinaria where id = id_in);

	if id_NewEstado < 3 then
		if id_NewEstado != EstadoActual then
			update maquinaria set id_Estado = id_NewEstado where id = id_in;
		else
			signal sqlstate '45000' set message_text = "El estado al que intentas es el mismo que ya tiene.";
		end if;
    else 
		signal sqlstate '45000' set message_text = "El estado al que intentas cambiar es inaccesible para la maquinaria.";
	end if;
	
end// 
Delimiter ;

call CambiarEstadoMaquinaria(1,2);

-- 4. Cambiar el estado de un empleado.
drop procedure if exists CambiarEstadoEmpleado;
Delimiter //
Create procedure CambiarEstadoEmpleado(in id_in int, in id_NewEstado int)
begin
	Declare EstadoActual int;
    Set EstadoActual = (select id_Estado from Empleado where id = id_in);

	if id_NewEstado = 3 or id_NewEstado = 4 or id_NewEstado = 5 then
		if id_NewEstado != EstadoActual then
			update Empleado set id_Estado = id_NewEstado where id = id_in;
		else
			signal sqlstate '45000' set message_text = "El estado al que intentas es el mismo que ya tiene.";
		end if;
    else 
		signal sqlstate '45000' set message_text = "El estado al que intentas cambiar es inaccesible para los empleados.";
	end if;
	
end//
 Delimiter ;
call CambiarEstadoEmpleado(1,3);

-- 5. Agregar un nuevo empleado.
drop Procedure if exists AgregarEmpleado;
Delimiter //
create procedure AgregarEmpleado(in Nombre1 varchar(30), in Nombre2 varchar(30), in Apellido1 varchar(30), in Apellido2 varchar(30), in Cargo varchar(100), in Telefono bigint, in Direccion varchar(50), in Cedula bigint, in Email varchar(100))
begin
	INSERT INTO Empleado (Nombre1, Nombre2, Apellido1, Apellido2, Cargo, Telefono, Direccion, Cedula, Email, Sueldo_Diario, id_Estado, Dias_Trabajados) VALUES (Nombre1, Nombre2, Apellido1, Apellido2, Cargo, Telefono, Direccion, Cedula, Email, 3000, 3, 5);
end // 
Delimiter ;

call AgregarEmpleado('Jose', 'Luis', 'Maldonado', 'Pérez', 'Vendedor', 3101234567, 'Carrera 6, Quindío', 232313142, 'carlos@empresa.com');

-- 6. Calcular la la ganancia de un empleado semanal.
drop procedure if exists CalcularSueldoSemanal;
Delimiter //
Create procedure CalcularSueldoSemanal(in id_in int, out SueldoSemanal int)
begin
	Select (Sueldo_Diario * Dias_Trabajados) into SueldoSemanal from empleado where id = id_in; 
end // 
Delimiter ;

call CalcularSueldoSemanal(1,@SueldoSemana);
Select @SueldoSemana as SueldoSemana;

-- 7. Cambiar el sueldo diario de un empleado.
drop procedure if exists CambiarSueldo;
Delimiter //
Create procedure CambiarSueldo(in id_in int, in NuevoDiario int)
begin
	Update Empleado set Sueldo_Diario = NuevoDiario where id = id_in;
end // 
Delimiter ;

call CambiarSueldo(1, 30000);

-- 8. Cambiar la cantidad de dias que trabaja un empleado.
Drop procedure if exists CambiarDias;
Delimiter //
Create procedure CambiarDias(in id_in int, in Cantidad_Dias int)
begin
	Update Empleado set Dias_Trabajados = Cantidad_Dias where id = id_in;
end// 
Delimiter ;

call CambiarDias(1,2);

-- 9. Agregar una nueva Ruta.
Drop Procedure if exists RutasNuevas;
Delimiter //
Create procedure RutasNuevas(in Ruta_Nueva varchar(50),in ConductoRuta varchar (100))
begin
	Insert into Ruta (Ruta, Conductor) values (Ruta_Nueva, Conductor);
end //
 Delimiter ;
Call RutasNuevas("Bogota - Valledupar", "Jose Ignacio");

-- 10. Actualizar una ruta existente.
Drop procedure if exists ActualizarRuta;
Delimiter //
Create procedure ActualizarRuta(in id_in int,in RutaActualizada varchar(50))
begin
	Update Ruta set Ruta = RutaActualizada where id = id_in;
end// 
Delimiter ;

Call ActualizarRuta(1, "Bogota - Tibu");


-- 11. crear un proedimiento donde se agreguen nuevos clientes
Drop procedure if exists add_new_cliente;
delimiter //
create procedure add_new_cliente (in Nombre1 varchar (30), in Nombre2 varchar (30),in Apellido1 varchar (30) ,
in Apellido2 varchar (30),in Telefono bigint ,in Direccion varchar(30),in Cedula bigint )
begin 
	insert into Clientes (Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Cedula) VALUES
	(Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Cedula);
end //
delimiter ;

call add_new_cliente ('camilo', 'Eduardo', 'contreras', 'perez', 3023456721, 'Calle 15, Bogotá', 1098765432);
select * from clientes ;


-- 12 crear un proedimiento donde se agreguen nuevos proveedores 

Drop procedure if exists add_new_proveedor;
delimiter //
create procedure add_new_proveedor (in Nombre varchar (30),in Apellido1 varchar (30) ,
in Apellido2 varchar (30), in Telefono bigint , in Email varchar (30),in id_Estado int,in id_Empresa int  )
begin 
	insert into Proveedores (Nombre, Apellido1, Apellido2, Telefono, Email, id_Estado, id_Empresa) VALUES
(Nombre, Apellido1, Apellido2, Telefono, Email, id_Estado, id_Empresa) ;
end //
delimiter ;

call add_new_proveedor ('jesus','contreras', 'ortiz', 3002456710,'jesusEduardo02@gmail.com',3,4);
select * from proveedores ;

-- 13 crear un procedimiento don se puedan eliminar empleados segun id 
Drop procedure if exists eliminar_empleado;
delimiter //
create procedure eliminar_empleado (in id_empleado int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from empleado where empleado.id=id_empleado);
    if eliminar = 1 then 
		delete from empleado where empleado.id=id_empleado;
        signal sqlstate '45000' set message_text = 'se ha eliminado el empleado de manera correcta';
    else 
     signal sqlstate '45000' set message_text = 'No hay empleado con esta id';
	end if ;
end //
delimiter ;

call eliminar_empleado(47);
select * from empleado;

-- 14  crear un procedimiento que agrege  nuevas empresas proveedoras de insumos agropecuarios

Drop procedure if exists add_empresa;
delimiter //
create procedure add_empresa (in Nombre varchar (30),Ubicacion varchar (30) ,Descripcion varchar (100) )
begin 	
	insert into Empresa (Nombre, Ubicacion, Descripcion) VALUES
	(Nombre, Ubicacion, Descripcion) ;
end //
delimiter ;

call add_empresa ('agrovida','Bogotá','fuente de insumos de buena calidad para tu finca');
select * from empresa;


-- 15  crear un procedimiento que permita actualizar la cantidad de stock en inventario_productos según id.
Drop procedure if exists Actualizar_stock;
Delimiter //
Create procedure Actualizar_stock(in id_pro int,in cantidad_actualizada varchar(50))
begin
	Update inventario_producto set cantidad_stock=cantidad_actualizada where id = id_pro;
end// 
Delimiter ;

Call Actualizar_stock(1, 948);

select * from inventario_producto;

-- 16  crear un procedimiento que permita agregar nuevas fincas si asi se desea

Drop procedure if exists add_finca;
delimiter //
create procedure add_finca (in Nombre varchar (30) ,in id_Ciudad int,in Tamaño_Total int ,in Tamaño_Sembrado int)
begin 	
	insert into Finca (Nombre, id_Ciudad, Tamaño_Total, Tamaño_Sembrado) VALUES
	 (Nombre, id_Ciudad, Tamaño_Total, Tamaño_Sembrado) ;
end //
delimiter ;

call add_finca ('Finca el Bosque',(SELECT id FROM Ciudades WHERE Nombre = 'Bogota' LIMIT 1), 800, 400);
select * from finca;


-- 17  crear un procedimiento que permita agregar nuevas maquinas.
Drop procedure if exists add_maquina;
delimiter //
create procedure add_maquina (in Marca varchar (30),in Modelo varchar (30) ,in Descripcion varchar (100),in id_Estado int,in id_Finca int)
begin 	
	insert into Maquinaria (Marca, Modelo, Descripcion, id_Estado, id_Finca) VALUES
	 (Marca, Modelo, Descripcion, id_Estado, id_Finca) ;
end //
delimiter ;

call add_maquina ('Kubota','M5-111', 'Tractor con tecnología avanzada para el cultivo de cacao', 4, 2);
select * from Maquinaria;

-- 18 crear procedimiento que permita eliminar los proveedores con los que se termino el convenio o se encuentran inactivo

Drop procedure if exists eliminar_proveedores;
delimiter //
create procedure eliminar_proveedores (in id_proveedores int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from proveedores where proveedores.id=id_proveedores);
    if eliminar = 1 then 
		delete from proveedores where proveedores.id=id_proveedores;
        signal sqlstate '45000' set message_text = 'se ha eliminado el empleado de manera correcta';
    else 
     signal sqlstate '45000' set message_text = 'No hay empleado con esta id';
	end if ;
end //
delimiter ;

call eliminar_proveedores(51);
select * from proveedores;


-- 19  crear un procedimiento que cambie el estado de los productos entre los estados agotados o en venta
drop procedure if exists Cambiarproducto;
Delimiter //
Create procedure Cambiarproducto(in id_pro int, in id_NewEstado int)
begin
	Declare EstadoActual int;
    Set EstadoActual = (select id_Estado from productos where id = id_pro);

	if id_NewEstado = 7 or id_NewEstado = 8  then
		if id_NewEstado != EstadoActual then
			update productos set id_Estado = id_NewEstado where id = id_pro;
		else
			signal sqlstate '45000' set message_text = "El estado al que intentas es el mismo que ya tiene.";
		end if;
    else 
		signal sqlstate '45000' set message_text = "El estado al que intentas cambiar es inaccesible para los empleados.";
	end if;
	
end//
 Delimiter ;
call Cambiarproducto(1,8);
select * from productos;

-- 20  crear un procedimiento que nos aplique un descuento del 5% a las ventas que tienen una cantidad de ventas  mayor a 40 y cuentan con trasportes

drop procedure aplicar_descuentos;


create procedure aplicar_descuentos (in idventa int )
begin
	declare total_pago int;
    set total_pago= (select ventas.cantidad_stock * productos.producto_unidad +30000 -(100 *0.05)  from productos 
    inner join ventas on ventas.id_producto = productos-id where ventascantidad_stock>40 and ventas.Trasporte=1);
    update pagos set total = total_pago where pagos.id_ventas=idventa;
end //
delimiter ;

