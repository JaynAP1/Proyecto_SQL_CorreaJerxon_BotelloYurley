Use Finca_Jurley;


-- funciones

-- 1 calcular el sueldo total  para cada empleado de la finca segun los dias trabajados

delimiter //
create function sueldo_total (sueldodia int, dias int)
returns bigint deterministic
begin 
	declare total int;
    set total= dias*sueldodia;
    return total;
end //
delimiter ; 

select id, nombre1, apellido1 , sueldo_total(Sueldo_Diario,Dias_Trabajados)as sueldo_total from Empleado;

-- 2 segun la cantidad y el precio por unidad del producto calcular el total a pagar en venta

delimiter //
create function total_pago (Cantidad int, Valor int)
returns bigint deterministic
begin 
	declare totalpago int;
    set totalpago= Cantidad*Valor;
    return totalpago;
end //
delimiter ; 

select id, total_pago(Producto_Cantidad,Valor_Unidad)as total_pago from ventas;


-- 3 genere el total de ganacias que se tiene si se conoce que  el promedio de ganancias es del  0.2%(20%)

delimiter //
create function ganacia_total ()
returns bigint deterministic
begin 
	declare totalganancias int;
    set totalganancias= (select sum(total_pago)* 0.2 from ( select total_pago(Producto_Cantidad,Valor_Unidad) as 'total_pago' from ventas ) as obtener) ;
    return totalganancias;
end //
delimiter ; 

select ganacia_total()as total;


-- 4 muestre el valor total de las ventas realizadas

delimiter //
create function valor_ventas ()
returns bigint deterministic
begin 
	declare totalventas int;
    set totalventas= (select sum(total_pago) from ( select total_pago(Producto_Cantidad,Valor_Unidad) as 'total_pago' from ventas ) as obtener) ;
    return totalventas;
end //
delimiter ; 

select valor_ventas()as valor_ventas;


-- 5 hacer un pedido de prueba  que tenga en cuenta  el valor del producto total agregandole el precio de viaje

delimiter //
create function pedido_prueba (idp int )
returns bigint deterministic
begin 
	declare total int;
    set total= ( select Precio_Unidad *40 + 30000 from productos where productos.id = idp ) ;
    return total;
end //
delimiter ; 
drop function pedido_prueba;
select * from productos;
select nombre, pedido_prueba(20) as total_pedido from productos  where id=20 ;

