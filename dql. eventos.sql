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
	end
// Delimiter ;

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
end
// Delimiter ;

-- 8. Crea un evento que actualize la fecha de llegada de un vehiculo de transporte.

Delimiter //
create event SelectTrans
on schedule at '2024-11-27 12:30:00'
do
begin
	update transporte set Fecha_Salida = "2024-11-30" where id = 1;
end
// Delimiter ;

-- 8. Reiniciar el contador de dias de un empleado.
Delimiter //
Create event Actualizar_dias
on schedule at '2024-11-27 11:48'
do
begin
	update empleado set Dias_Trabajados = 0;
end
// Delimiter ;

-- 9. Cambiar la forma de pago de un producto a una hora especificada solo si los productos fueron pagados en efectivo.
Delimiter //
Create event FormaPagoChange
on schedule at '2024-11-27 12:00'
do
begin
    update pagos set Forma_Pago = "Sin datos" where Forma_Pago = "efectivo";
end
// Delimiter ;

-- 10. Dejar sin finca la maquinaria de ford.

Delimiter //
Create event MaquinariaFord
on schedule at '2024-11-27 12:10'
do
begin
	update maquinaria set id_finca = 0 where Marca = "Ford";
end
// Delimiter ;
