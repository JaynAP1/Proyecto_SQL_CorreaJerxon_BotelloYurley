use finca_jurley;

-- 1. crea un trigger que actualice la cantidad de stock  dependiendo de las ventas que se han llevado a cabo por cada producto

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


-- 2. crear un trigger que actualice el estado de la maquinaria y los datos viejos sean añadidos al historial
 
 delimiter //
 create trigger actualizar_estad_maqui 
 before update on  maquinaria 
 for each row 
 begin
	insert into historial (tipo,descripcion,id_finca) values ('estado viejo' , old.id_estado,1);
 end //
 delimiter ;
 
 update maquinaria  set id_estado=2 where id=1;
 
 
 -- 3. crear un trigger que actualice el estado de empleado y los datos viejos sean añadidos al historial
 
 delimiter //
 create trigger actualizar_estado_empleados
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update empleado  set id_estado= 4 where id=1 ;
 
 
 -- 4. crear un trigger que actualice el estado de producto y los datos viejos sean añadidos al historial

 delimiter //
 create trigger  actualizar_estado_productos
 after update on productos
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update productos  set id_estado=8 where id=1 ;
 
 -- 5. crear un trigger que actualice la direccion de los clientes  y los datos viejos sean añadidos al historial
 
 delimiter //
 create trigger actualizar_direccion_clientes
 after update on clientes
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Direccion_anterior', old.direccion,1);
 end //
 delimiter ;
 
 update clientes  set direccion='calle 4 bogota' where id=1 ;
 
 
 -- 6. crear un trigger que elimine datos innecesarios del historial segun la id
 
 delimiter //
 create trigger eliminar_dato_historial
 after delete on historial
 for each row 
 begin 
  delete from historial  where id=58;
 end //
 delimiter ;
 
 -- 7. crear un trigger que actualice el cargo de los empleados segun la id
 
 delimiter //
 create trigger actualizar_cargo
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('cargo_anterior' , old.cargo ,1);
 end //
 delimiter ;
 
 update empleado set cargo= 'vendedor' where id=2 ;
 
 -- 8. crea un trigger que actualize  los dias de trabajo

  delimiter //
 create trigger actualizar_dias
 after update on empleado
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('dias_trabajados' , old.Dias_Trabajados,1);
 end //
 delimiter ;
 
 update empleado set Dias_Trabajados= 4 where id=2 ;
 

 -- 9. crear un trigger que actualice el estado del producto  ha(agotado) si la cantidad  de stock  es igual a 0.

 delimiter //
 create trigger estados_agotados 
 before update on productos
 for each row 
 begin 
	if (select count(id) from Inventario_Producto where Cantidad_Stock=0 ) = 1 then 
    update productos set id_estado=7 where id=2;
    end if;
 end //
 delimiter ;

 -- 10. crear un trigger que actualice el valor de la unidad de cada venta  y los datos viejos sean añadidos al historial
  
 delimiter //
 create trigger actualizar_valor_unidad
 after update on ventas
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('sueldo_anterior' , old.Valor_Unidad ,1);
 end //
 delimiter ;
 
 update ventas set Valor_Unidad= 15000 where id=2 ;


  -- 11. Crea un trigger que cuando se inserte un nuevo estado envie al historial el estado nuevo.
  
  Delimiter //
  Create trigger Nuevo_Estado
  after insert on Estado
  for each row
  begin
   insert into historial (tipo,descripcion,id_finca) values ('Estado Recien Agregado' , new.Nombre ,1);
  end //
  Delimiter ;
  
  Insert into Estado(Nombre) values ("En proceso");	
  

-- 12. Crea un trigger que cuando una ruta se actualize su valor viejo sea enviado al historial.

Delimiter //
Create trigger Actualizar_Ruta
before update on Ruta
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Anterior', old.Ruta, 1);
end //
Delimiter ;

update ruta set Ruta = "Bogota - Caracas" where id = 17;

-- 13. Crea una trigger que cuando se actualize un proveedor envie su nombre viejo al historial.

Delimiter //
Create trigger Actualizar_proveedor
before update on proveedores
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizado', old.Nombre, 1);
end //
Delimiter ;

update Proveedores set Nombre = "Jair" where id = 1;
   
-- 14. Crear un trigger que cuando se actualize un producto envie su nombre al historial.
Delimiter //
Create trigger productos_Nombre
before update on productos
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizado', old.Nombre, 1);
end //
Delimiter ;

update productos set precio_unidad = 100 where id = 1;

-- 15. Crear un trigger que cuando se actualize la finca envie el nombre de la finca que fue actualizada al historial.
Delimiter //
Create trigger Finca_Nombre
before update on Finca
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizado', old.Nombre, 1);
end //
Delimiter ;

update Finca set Nombre = "SuperFinca" where id = 1;
  
-- 16. Crear un trigger que al eliminar una ciudad envie el nombre de la ciudad eliminada al historial.

Delimiter //
Create trigger Eliminar_Ciudad
before delete on Ciudades
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Eliminado', old.Nombre, null);
end //
Delimiter ;

delete from ciudades where id_region = 2;

-- 17. Crear un trigger que al eliminar una ciudad envie el nombre de la ciudad eliminada al historial.
Delimiter //
Create trigger Eliminar_Region
before delete on Region
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Eliminado', old.Nombre, null);
end //
Delimiter ;

delete from region where id = 2;

-- 18. Crea un trigger que al actualizar el nombre de una ciudad devuelva el nombre viejo al historial.
Delimiter //
Create trigger Actualizar_Ciudad
before Update on ciudades
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizar', old.Nombre, null);
end //
Delimiter ;

-- 19. Crea un trigger que al actualizar el nombre de una region devuelva el nombre viejo al historial.
Delimiter //
Create trigger Actualizar_Region
before Update on Region
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizar', old.Nombre, null);
end //
Delimiter ;

-- 20. Crea un trigger que al insertar una finca nueva envie el dato de la creacion al historial.
Delimiter //
Create trigger Finca_Nueva
after insert on Finca
for each row
begin
	Insert into Historial (Tipo,Descripcion,id_Finca) values ('NuevoDato', new.Nombre, null);
end
// Delimiter ;

insert into Finca (Nombre, id_ciudad, Tamaño_total, Tamaño_sembrado) values ("EsaFinca",3,10,1)
