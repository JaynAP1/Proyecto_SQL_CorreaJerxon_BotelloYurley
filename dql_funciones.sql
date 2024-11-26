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

select nombre, pedido_prueba(20) as total_pedido from productos  where id=20 ;

-- 6 hacer que los pedidos de prueba teniendo en cuenta  el valor del producto total agregandole el precio de viaje pero solo si estos incluyen trasporte donde se conoce que el valor 
-- fijo del trasporte es de 30000.

delimiter //
create function total_pedidos_con_trasportes (valorUnidad int , ProductoCantidad int)
returns bigint deterministic
begin 
	declare total_pedidos_trasporte int;
    set total_pedidos_trasporte= valorUnidad * ProductoCantidad + 30000 ;
    return total_pedidos_trasporte;
end //
delimiter ; 

select nombre, total_pedidos_con_trasportes(v.Producto_Cantidad, p.Precio_Unidad ) as total_pedido from productos p  inner join ventas v on p.id = v.id_producto  where v.Transporte=1 ;


-- 7 saca el  promedio total de ventas que se han tenido 

delimiter //
create function promedio_ventas ()
returns bigint deterministic
begin 
	declare promedio int;
    set promedio= ( select avg(cantidadventas) as promedio from (select count(v.id) as 'cantidadventas' from ventas v ) as obtener) ;
    return promedio;
end //
delimiter ; 
drop function promedio_ventas;
select promedio_ventas();

-- 8  muetsra el producto con mayor ventas realizadas


delimiter //
create function producto_mas_vendido ()
returns varchar(50) deterministic
begin 
	declare producto varchar(50);
    set producto= ( select namess from 
    (select productos.Nombre as 'namess' , count(id_producto) from ventas inner join productos on ventas.id_producto = productos.id group by 1 limit 1)
    as obtener limit 1) ;
    return producto;
end // 
delimiter ; 
drop function producto_mas_vendido;
select producto_mas_vendido();

-- 9 muestra el nombre del cliente que mas compra a realizado

delimiter //
create function cliente_compras ()
returns varchar(50) deterministic
begin 
	declare total varchar(50);
    set total= ( select id from 
    (select clientes.id as 'id' , count(id_producto) from ventas inner join clientes on ventas.id_cliente = clientes.id group by 1 limit 1)
    as obtener limit 1) ;
    return total;
end // 
delimiter ; 
drop function cliente_compras;
select nombre1 ,apellido1, apellido2, cliente_compras() as 'id' from clientes where clientes.id = id limit 1;


-- 10 muestre el nombre  del empleado que mas ventas a realizados

delimiter //
create function empleados_ventas ()
returns varchar(50) deterministic
begin 
		declare ventas varchar(50);
    set ventas= ( select id from 
    (select Empleado.id as 'id' , count(id_producto) from ventas inner join Empleado on ventas.id_Empleado = Empleado.id group by 1 limit 1)
    as obtener limit 1) ;
    return ventas;
end // 
delimiter ; 
drop function empleados_ventas;
select nombre1 ,apellido1, apellido2, empleados_ventas() as 'id', cargo from Empleado where Empleado.id = id limit 1 ;
