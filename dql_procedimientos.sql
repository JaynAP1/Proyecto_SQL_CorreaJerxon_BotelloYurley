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
drop procedure CambiarEstadoMaquinaria;

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
	
end
// Delimiter ;

call CambiarEstadoMaquinaria(1,2);

-- 4. Cambiar el estado de un empleado.
drop procedure CambiarEstadoEmpleado;
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
	
end
// Delimiter ;
call CambiarEstadoEmpleado(1,3);

-- 5. Agregar un nuevo empleado.
drop Procedure AgregarEmpleado;
Delimiter //
create procedure AgregarEmpleado(in Nombre1 varchar(30), in Nombre2 varchar(30), in Apellido1 varchar(30), in Apellido2 varchar(30), in Cargo varchar(100), in Telefono bigint, in Direccion varchar(50), in Cedula bigint, in Email varchar(100))
begin
	INSERT INTO Empleado (Nombre1, Nombre2, Apellido1, Apellido2, Cargo, Telefono, Direccion, Cedula, Email, Sueldo_Diario, id_Estado, Dias_Trabajados) VALUES (Nombre1, Nombre2, Apellido1, Apellido2, Cargo, Telefono, Direccion, Cedula, Email, 3000, 3, 5);
end
// Delimiter ;

call AgregarEmpleado('Jose', 'Luis', 'Maldonado', 'Pérez', 'Vendedor', 3101234567, 'Carrera 6, Quindío', 232313142, 'carlos@empresa.com');

-- 6. Calcular la la ganancia de un empleado semanal.
drop procedure CalcularSueldoSemanal;
Delimiter //
Create procedure CalcularSueldoSemanal(in id_in int, out SueldoSemanal int)
begin
	Select (Sueldo_Diario * Dias_Trabajados) into SueldoSemanal from empleado where id = id_in; 
end
// Delimiter ;

call CalcularSueldoSemanal(1,@SueldoSemana);
Select @SueldoSemana as SueldoSemana;

-- 7. Cambiar el sueldo diario de un empleado.
drop procedure CambiarSueldo;
Delimiter //
Create procedure CambiarSueldo(in id_in int, in NuevoDiario int)
begin
	Update Empleado set Sueldo_Diario = NuevoDiario where id = id_in;
end
// Delimiter ;

call CambiarSueldo(1, 30000);

-- 8. Cambiar la cantidad de dias que trabaja un empleado.
Drop procedure CambiarDias;
Delimiter //
Create procedure CambiarDias(in id_in int, in Cantidad_Dias int)
begin
	Update Empleado set Dias_Trabajados = Cantidad_Dias where id = id_in;
end
// Delimiter ;

call CambiarDias(1,2);

-- 9. Agregar una nueva Ruta.
Drop Procedure RutasNuevas;
Delimiter //
Create procedure RutasNuevas(in Ruta_Nueva varchar(50),in ConductoRuta varchar (100))
begin
	Insert into Ruta (Ruta, Conductor) values (Ruta_Nueva, Conductor);
end
// Delimiter ;
Call RutasNuevas("Bogota - Valledupar", "Jose Ignacio");

-- 10. Actualizar una ruta existente.
Drop procedure ActualizarRuta;
Delimiter //
Create procedure ActualizarRuta(in id_in int,in RutaActualizada varchar(50))
begin
	Update Ruta set Ruta = RutaActualizada where id = id_in;
end
// Delimiter ;

Call ActualizarRuta(1, "Bogota - Tibu");

