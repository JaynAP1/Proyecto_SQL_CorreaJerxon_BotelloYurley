use finca_jurley;

-- 1. crea un trigger que actualice la cantidad de stock  

drop trigger actualizar_stock2;
delimiter //
create trigger actualizar_stock2
before  update on inventario_producto
for each row 
begin
 insert into historial (tipo, descripcion, id_finca) values ('stock viejo', old.cantidad_stock, 1);
end //
delimiter ;

update inventario_producto  set cantidad_stock =(select cantidad from (select inventario_producto.cantidad_stock - ventas.Producto_Cantidad as 'cantidad' 
from inventario_producto inner join productos on productos.id_Inventario_producto=inventario_producto.id 
inner join ventas on productos.id =ventas.id_Producto )as obtener limit 1) where id=1  ;


-- 2 crear un trigger que actualice el estado de la maquinaria y los datos viejos sean añadidos al historial
 drop trigger actualizar_estado;
 delimiter //
 create trigger actualizar_estado 
 before update on  maquinaria 
 for each row 
 begin
	insert into historial (tipo,descripcion,id_finca) values ('estado viejo' , old.id_estado,1);
 end //
 delimiter ;
 
 update maquinaria  set id_estado=2 where id=1;
 
 
 -- 3  crear un trigger que actualice el estado de empleado y los datos viejos sean añadidos al historial
 
 delimiter //
 create trigger actualizar_estado_empleados
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update empleado  set id_estado= 4 where id=1 ;
 
 
 -- 4 crear un trigger que actualice el estado de producto y los datos viejos sean añadidos al historial
 
  delimiter //
 create trigger actualizar_estado_productos
 after update on productos
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update productos  set id_estado= 7 where id=1 ;
 
 -- 5 crear un trigger que actualice el estado de clientes  y los datos viejos sean añadidos al historial
 
   delimiter //
 create trigger actualizar_estado_cliente
 after update on clientes
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update clientes  set id_estado= 4 where id=1 ;
 
 
 -- 6   crear un trigger elimine datos innecesarios de historial segun la id
 
   delimiter //
 create trigger actualizar_ruta
 after update on transporte
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_ruta,1);
 end //
 delimiter ;
 
 update transporte set id_ruta= 4 where id=1 ;
 
 -- 7 crear un trigger que actualice el estado del producto si la cantidad  de stock  es igual a 0
 drop trigger
 delimiter //
 create trigger actualizar_cargo
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('cargo_anterior' , old.cargo ,1);
 end //
 delimiter ;
 
 update empleado set cargo= 'vendedor' where id=2 ;
 
 -- 8 actualizar los dias de trabajo
 
  delimiter //
 create trigger actualizar_dias
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('dias_trabajados' , old.Dias_Trabajados,1);
 end //
 delimiter ;
 
 update empleado set Dias_Trabajados= 4 where id=2 ;
 
 
 -- 9 crear un trigger que actualice el sueldo diario de los empleados  y los datos viejos sean añadidos al historial
 
   delimiter //
 create trigger actualizar_sueldo_diario
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('dias_trabajados' , old.Sueldo_Diario ,1);
 end //
 delimiter ;
 
 update empleado set Sueldo_Diario= 45000 where id=2 ;
 
 -- 10  crear un trigger que actualice el valor de la unidad de cada venta  y los datos viejos sean añadidos al historial
  drop trigger actualizar_valor_unidad;
    delimiter //
 create trigger actualizar_valor_unidad
 after update on ventas
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('sueldo_anterior' , old.Valor_Unidad ,1);
 end //
 delimiter ;
 
 update ventas set Valor_Unidad= 7990000 where id=2 ;