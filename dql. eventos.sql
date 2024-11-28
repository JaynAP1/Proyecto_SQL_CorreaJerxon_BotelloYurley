Use finca_jurley;

Set global event_scheduler = ON;

-- 1.Crea un evento que aumente el salario de cada empleado un 5%.

Delimiter //
Create event Actualizar_Sueldo
on schedule at '2024-11-28 20:20:00'
do
begin
	Update empleado set Sueldo_Diario = Sueldo_Diario + (Sueldo_Diario * 0.05);
end //
Delimiter ;

-- 2. Crea un evento que te inserte un estado.

Delimiter //
Create event Insertar_Estado
on schedule at current_timestamp + interval 1 minute
do insert into estado values ("Espera");
// Delimiter ;

-- 3. Crea un evento que aumente el tamaño de la finca 1.

Delimiter //
Create event Aumentar_Tamaño
on schedule at '2024-11-28 9:00:00'
do
begin
	update finca set Tamaño_Total = Tamaño_Total + 10 where id = 1;
end //
Delimiter ;

-- 4. Crea un evento que de forma periodica aumente el tamaño sembrado de la finca 1.

Delimiter //
Create event SembradoAumento
on schedule at current_timestamp + interval 5 minute
do
begin
Update finca set Tamaño_Sembrado = Tamaño_Sembrado + 1 where id = 1;
end //
Delimiter ;

-- 5. Crea un evento que cambie el estado de la maquinaria 1 cada cierto tiempo.

Delimiter //
Create event CambiarEstadoMaquina
on schedule at current_timestamp + interval 1 second
do
begin
Declare Estado int;
set Estado = (select id_Estado from maquinaria where id = 1);

if Estado = 1 then
	update maquinaria set id_Estado = 2 where id = 1;
else 
	update maquinaria set id_Estado = 1 where id = 1;
end if;
end // 
Delimiter ;

-- 6. Crea un evento que elimine una venta mañana a las 8.

Delimiter //
Create event DeleteVenta
on schedule at '2024-11-27 11:25:00'
do
begin
	Delete from ventas where id = 1;
end
// Delimiter ;

-- 7. Crea un evento que inserte un transporte a las 11:30.

Delimiter //
Create event InserTransporte
on schedule at '2024-11-27 11:30:00'
do
begin
	insert into Transporte (Marca,Modelo,Fecha_Salida,Fecha_Llegada,id_Ruta,id_Finca) values ("Ford", "F-150", "2024-11-27", "2024-12-10", 2, 1);
end // 
Delimiter ;

-- 8. Crea un evento que actualize la fecha de llegada de un vehiculo de transporte.

Delimiter //
create event SelectTrans
on schedule at '2024-11-27 12:30:00'
do
begin
	update transporte set Fecha_Salida = "2024-11-30" where id = 1;
end // 
Delimiter ;

-- 9. Reiniciar el contador de dias de un empleado.

Delimiter //
Create event Actualizar_dias
on schedule at '2024-11-27 11:48'
do
begin
	update empleado set Dias_Trabajados = 0;
end //
 Delimiter ;

-- 10. Cambiar la forma de pago de un producto a una hora especificada solo si los productos fueron pagados en efectivo.

Delimiter //
Create event FormaPagoChange
on schedule at '2024-11-27 12:00'
do
begin
    update pagos set Forma_Pago = "Sin datos" where Forma_Pago = "efectivo";
end //
 Delimiter ;

-- 11. Dejar sin finca la maquinaria de ford.

Delimiter //
Create event MaquinariaFord
on schedule at '2024-11-27 12:10'
do
begin
	update maquinaria set id_finca = 0 where Marca = "Ford";
end // 
Delimiter ;



-- 12 crear un evento donde se vaya calculando el salario del empleado por dia

create table if not exists salario (
id int primary key not null , 
salario_total bigint,
id_Empleado int,
foreign key (id_Empleado) references Empleado(id)
);

insert into salario(id,salario_total,id_Empleado) values (1, 100, 1);

select * from salario ;

delimiter //
create event suma_salario
on  schedule every 1 day 
do 
begin 
	update salario  set salario_total = (select Sueldo_Diario * Dias_Trabajados from empleado where salario.id_empleado = empleado.id);
end //
delimiter ;


-- 13 crae un evento que aplique un descuento del 5% a todo los productos  con un intervalo de una hora
-- drop event if exists descuento_producto;

delimiter //
create event descuento_producto
on schedule at current_timestamp + interval 1 hour
do 
begin 
update productos set Precio_Unidad= Precio_Unidad*(5/100)where id_estado= 8;
end //
delimiter ;
select * from productos;


-- 14 aplicar en un evento un procedimiento de los anteriores que se ejecute una vez.En un dia especifico.
-- drop event if exists descuento_procedures;

delimiter //
create event descuento_procedures 
on  schedule AT '2024-11-27 6:17'
do 
begin 
call aplicar_descuentos(3);
end //
delimiter ;

select  * from pagos;
-- 15  aplicar un evento para uno de los procedimientos anteriores que se ejecute cada dia
-- drop event if exists descuento_procedures;

delimiter //
create event descuento_procedures 
on  schedule every 1 day
do 
begin 
	call Cambiarproducto(2,8);
end //
delimiter ;

select  * from productos;

-- 16 aplicar un evento para uno de los procedimientos anteriores (1. Crear un procedimiento que permita agregar un nuevo estado.) que se ejecute en un dia especifico
-- drop event if exists agregar_new_estado;

delimiter //
create event agregar_new_estado 
on  schedule every 1 day
do 
begin 
	call AddNewEstado('Eliminado');
end //
delimiter ;

select  * from estado;
-- 17  crea un evento para una funcion(Mostrar la cantidad de Cosecha de la finca deseada.) de las anteriores creadas
-- drop event if exists cosecha;

delimiter //
create event cosecha 
on  schedule every 1 day
do 
begin 
	Select TotalCosecha(1);
end //
delimiter ;


-- 18 Cambiar la forma de pago de un producto cada dos dias solo si los productos fueron pagados con tarjeta de credito.

Delimiter //
Create event PagoChange
on schedule every 2 day
do
begin
    update pagos set Forma_Pago = "Sin datos" where Forma_Pago = "Tarjeta de Crédito";
end //
 Delimiter ;

-- 19 crear un evento que cancele el trasporte del pedido con  id 1 con intervalo de tiempo especifico

delimiter //
create  event cancelar_transporte_ventass
on schedule at '2024-11-27 6:00'
do
begin
	update ventas  set Trasporte=0 ,id_transporte = null  where id=1;
end //
delimiter ;

-- 20  crear un evento para el siguiente procedimiento (Crea un procedimiento que permita cambiar el valor de la venta total.) por cada 7 dias
-- drop event if exists venta_total;

delimiter //
create event venta_total 
on  schedule every 7 day
do 
begin 
	call CalcularVenta(2,@Salida);
end //
delimiter ;
select @salida as NuevoValor;


-- 21 crear procedimiento que permita eliminar los proveedores con los que se termino el convenio o se encuentran inactivo

Drop procedure if exists eliminar_proveedores;
delimiter //
create procedure eliminar_proveedores (in id_proveedores int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from proveedores where proveedores.id=id_proveedores);
    if eliminar = 1 then 
		delete from proveedores where proveedores.id=id_proveedores;
    else 
     signal sqlstate '45000' set message_text = 'No hay empleado con esta id';
	end if ;
end //
delimiter ;

call eliminar_proveedores(50);
select * from proveedores;