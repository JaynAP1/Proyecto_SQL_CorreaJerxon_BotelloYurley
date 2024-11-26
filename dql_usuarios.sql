Use Finca_Jurley;

-- USUARIOS

-- creacion de usuario gerente. sus permisos son(lectura,actualizar,eliminar,insertar)
create user 'Gerente'@'%host'identified by 'Gerente01';
grant select,update,delete,insert on Finca_Jurley.* to 'Gerente'@'%host';
show grants for 'Gerente'@'%host';

-- creacion de usuario administrador. sus permisos son(lectura,actualizar,eliminar,insertar) 

create user 'Administrador'@'%host'identified by 'administrador100';
grant select,update,delete,insert on Finca_Jurley.* to 'Administrador'@'%host';
show grants for 'Administrador'@'%host';

-- creacion de usuario cliente. sus permisos son(lectura en productos)
create user 'cliente'@'%host'identified by 'cliente123';
grant select on Finca_Jurley.Productos to 'cliente'@'%host';
show grants for 'cliente'@'%host';

-- creacion de usuario empleado. sus permisos son(lectura en prooducto,pedido,inventario_productos y inventario produccion )
create user 'empleado'@'%host'identified by 'cliente123';
grant select on Finca_Jurley.Productos to 'empleado'@'%host';
grant select on Finca_Jurley.pedido to 'empleado'@'%host';
grant select, update on Finca_Jurley.Inventario_Producto to 'empleado'@'%host';
grant select on Finca_Jurley.Inventario_Produccion to 'empleado'@'%host';
show grants for 'empleado'@'%host';

-- creacion de usuario proveedores. sus permisos son(lectura en inventario produccion)
create user 'proveedores'@'%host'identified by 'proveedor300';
grant select on Finca_Jurley.Inventario_Produccion to 'proveedores'@'%host';
show grants for 'proveedores'@'%host';


-- verificacion de que si se crearon los usuarios.
select user from mysql.user;