Use finca_jurley;

-- 1. Muestra la ciudad junto a su region.
select Region.Nombre, Ciudades.Nombre from ciudades inner join region on ciudades.id_Region = Region.id;

-- 2. Muestra todas las ciudades pertenecientes a la region de antioquia.
select Region.Nombre, Ciudades.Nombre from ciudades inner join region on ciudades.id_Region = Region.id where Region.Nombre = "Antioquia";

-- 3. Muestra todas las ciuadades pertenecientes a la region atlantico.
select Region.Nombre, Ciudades.Nombre from ciudades inner join region on ciudades.id_Region = Region.id where Region.Nombre = "Atlantico";

-- 4. Muestra todas las ciuadades que inicien por C.
select Nombre from ciudades having left(Nombre,1) = "C";

-- 5. Muestra todas las ciudades que inicien por A.
select Nombre from ciudades having left(Nombre,1) = "A";

-- 6. Muestra las regiones que tengan mas de 3 ciudades.
select Region.Nombre, count(ciudades.Nombre) as Cantidad_Ciudades from ciudades inner join region on ciudades.id_Region = Region.id group by 1 having count(ciudades.Nombre) > 2;

-- 7. Muestre las regiones que tienen mas de una ciudad pero menos de 4.
select Region.Nombre, count(ciudades.Nombre) as Cantidad_Ciudades from ciudades inner join region on ciudades.id_Region = Region.id group by 1 having count(ciudades.Nombre) > 1 and count(ciudades.Nombre) < 4;

-- 8. Muestre las regiones que no tienen ninguna ciudad.
select Region.Nombre, count(ciudades.Nombre) as Cantidad_Ciudades from ciudades inner join region on ciudades.id_Region = Region.id group by 1 having count(ciudades.Nombre) = 0;

-- 9. Muestre las ciudades que tienen fincas.
select ciudades.Nombre from ciudades inner join finca on ciudades.id = finca.id_Ciudad;

-- 10. Muestre todas las fincas.
select * from finca;

-- 11. Muestre la cantidad de hectareas que quedan por sembrar en las fincas.
select Nombre, (Tamaño_Total - Tamaño_Sembrado) as Hectareas_por_sembrar from finca;

-- 12. Muestre todas las fincas con mas de 500 hectareas totales.
select * from finca where Tamaño_Total > 500;

-- 13. Muestre todas las fincas con menos de 500 hectareas totales.
select * from finca where Tamaño_Total <= 500;

-- 14. Muestre todas las fincas con mas de 100 hectareas sembradas.
select * from finca where Tamaño_Sembrado > 100;

-- 15. Muestre todos los clientes.
select * from clientes;

-- 16. Muestre el nombre de los clientes en una sola columna.
select concat_ws("",Nombre1," ", Nombre2," ", Apellido1, " ",Apellido2) as Nombre_Completo from clientes;

-- 17. Muestre el telefono de los clientes.
select Nombre1, Apellido1, telefono from clientes;

-- 18. Muestre cuantos clientes se llaman "Juan".
select nombre1, count(Nombre1) as Repeticiones from clientes where nombre1 = "Juan";

-- 19. 	Muestre todos los clientes que se apellidan garcia.
select concat_ws("",Nombre1," ", Nombre2," ", Apellido1, " ",Apellido2) as Nombre_Completo from clientes where Apellido1 = "Garcia" or Apellido2 = "Garcia";

-- 20. Muestre todos los clientes que sus dos apellidos sean los mismos.
select concat_ws("",Nombre1," ", Nombre2," ", Apellido1, " ",Apellido2) as Nombre_Completo from clientes where Apellido1 = Apellido2;

-- 21. Muestra todos los clientes que vivan en bogota.
select * from clientes where Direccion like "%Bogota%";

-- 22. Muestre todos los clientes que su cedula inicie en 1 y termine en 5.
select Nombre1, Cedula from clientes having left(Cedula, 1) = 1 and right(Cedula,1) = 5;

-- 23. Muestre todas las empresas.
select * from empresa;

-- 24. Muestre las empresas que estan ubicadas en Bogota.
select * from empresa where Ubicacion = "Bogota";

-- 25. Muestre las empresas que tengan que ver con fertilizantes.
select * from empresa where Descripcion like '%fertilizantes%';

-- 26. Muestre Todas las empresas que en su nombre contengan la palabra "Agro".
select * from empresa where Nombre like '%Agro%';

-- 27. Muestre la cantidad de empresas que tienen la palabra "Agro".
Select count(Nombre) as Empresas_Agro from Empresa where Nombre like '%Agro%';

-- 28. Muestre las empresas que no tienen la palabra "Agro".
Select * from Empresa where Nombre not like '%Agro%';

-- 29. Muestre todos los estados que hay.
select * from estado;

-- 30. Mostrar el historial.
select * from historial;

-- 31. Mostrar todo el historial que tengan de tipo mantenimiento.
select * from historial where Tipo = "Mantenimiento";

-- 32. Mostrar la cantidad de objetos del historial que esta en cosecha.
select count(Tipo) from historial where Tipo = "Cosecha";

-- 33. Mostrar los historiales que tienen que ver con cacao.
select * from historial where Descripcion like "%Cacao%";

-- 34. Mostrar el nombre de las fincas que tienen historial.
select historial.Tipo, historial.Descripcion, finca.Nombre from historial inner join Finca on historial.id_finca = finca.id;

-- 35. Mostrar todos los fertilizantes almacenados.
select * from inventario_produccion where Nombre like '%Fertilizante%';

-- 36. Mostrar los tipos de cafe almacenados y sus objetos.
select * from inventario_produccion where Nombre like '%Cafe%';

-- 37. Mostrar el cacao y sus objetos almacenados.
select * from inventario_produccion where Nombre like '%Cacao%';

-- 38. Mostrar el nombre de los productos que no son traidos por proveedores.
select nombre from inventario_produccion where id_Proveedor is null;

-- 39. Mostrar el nombre de los proveedores que cada objeto.
select inventario_produccion.Nombre, concat_ws("",proveedores.Nombre," ", Apellido1, " ",Apellido2) as Nombre_Completo  from inventario_produccion inner join proveedores on inventario_produccion.id_proveedor = proveedores.id;

-- 40. Mostrar el objeto con el valor mas alto.
select * from inventario_produccion order by 4 desc;

-- PRIMERAS 10 SUBCONSULTAS 

-- 41. Sacar el promedio de todos los objetos referentes al cafe.
select avg(Valor) as promedio_Cafe from (select sum(Valor_Unitario) as "Valor" from inventario_produccion where Nombre like "%Cafe%") as obtener;

-- 42. Sacar el promedio de todos los fertilizantes. 
select avg(Valor) as promedio_Cafe from (select sum(Valor_Unitario) as "Valor" from inventario_produccion where Nombre like "%Fertilizante%") as obtener;

-- 43. Sacar el promedio de todos los objetos.
select avg(Valor) as promedio_Cafe from (select sum(Valor_Unitario) as "Valor" from inventario_produccion) as obtener;

-- 44. Sacar el valor total de cada objeto.
select Nombre, Valor from (select Nombre as "Nombre", (cantidad * valor_unitario) as "Valor" from inventario_produccion) as obtener;

-- 45. Sacar el valor total de todos los objetos.
select Valor from (select sum(Cantidad * valor_unitario) as "Valor" from inventario_produccion) as obtener;

-- 46. Mostrar la tabla inventario_producto.
select * from inventario_producto;

-- 47. Mostrar los productos que vencen en el 2025 y mes 6.
select * from (select * from inventario_producto where month(Fecha_Caducidad) = 6) as obtener;

-- 48. Mostrar los productos que fueron producion en el mes 1 del año 2024.
select * from (select * from inventario_producto where month(Fecha_Produccion) = 1) as obtener;

-- 49. Mostrar los productos con mas stock de 1000.
select * from (select * from inventario_producto where Cantidad_Stock > 1000) as obtener; 

-- 50. Mostrar el nombre de los productos.
select id, Nombre, Cantidad from (select Inventario_producto.id as "id",Cantidad_stock as "Cantidad" ,productos.Nombre as "Nombre" from Inventario_producto inner join productos on inventario_producto.id = productos.id_inventario_producto) as obtener;

-- 51  mostrar la tabla productos

select * from productos;

-- 52 mostrar los productos y el total de ventas que ha tenido ordenando de mayor a menor

select productos.nombre, count(id_producto) as cantidad from ventas inner join productos on ventas.id_producto = productos.id group by 1 order by 2 desc;

-- 53  mostrar los productos con precio mayor a 20000
 
select nombre, Precio_Unidad from productos where Precio_Unidad > 20000;
 
 -- 54 mostrar los productos con precio mayor a 10000
  
select nombre, Precio_Unidad from productos where Precio_Unidad < 10000;
 
-- 55 mostrar los productos entre 10000 y 20000
select nombre, Precio_Unidad from productos where Precio_Unidad between  10000 and 20000 ;
  
-- 56 muestra los productos de 1 kg
  
select nombre , contenido from  productos  where contenido = '1 kg';
  
-- 57 muestra los productos  con contenido de  250 gramos
  
select nombre , contenido from  productos  where contenido = '250g';
    
-- 58 muestra los productos  con contenido de  500 gramos
    
select nombre , contenido from  productos  where contenido = '500g';
        
-- 59 muestra los productos con contenido de 250 ml
    
select nombre , contenido from  productos  where contenido = '250ml';
     
-- 60 muetre los datos de la tabla de transportes

select * from Transporte ;

-- 61  muestre el vehiculo y la ruta del producto.

select ventas.id_Producto, Modelo, Ruta from ventas inner join transporte on ventas.id_transporte = transporte.id inner join ruta on transporte.id_Ruta = ruta.id where ventas.id_transporte is null;

-- 62. Todas las ventas que tengan transporte nulo.

select count(id) from ventas where id_transporte is null;

-- 63 cual es la ruta mas solicitada para llevar pedidos

select ruta , count(id_ruta) as solicitudes from ruta  right join  Transporte on ruta.id = Transporte.id_ruta 
inner join ventas  on Transporte.id= ventas.id_transporte group by 1 order by 2 desc limit 1 ;


-- 64 muestre todos los cargos 
select distinct cargo from empleado;

-- 65 muestre los nombres y apellido de los  empleados que tienen cargo de Asistente de Ventas de Café

select nombre1,nombre2, apellido1, apellido2 from empleado where cargo='Asistente de Ventas de Café';

-- 66 muestra los nombre y apellidos de los vendedores

select nombre1,nombre2, apellido1, apellido2, cargo from empleado where cargo = 'vendedor';

-- 67 muestra los empleado que vivan en bucaramanga

select concat_ws(' ',nombre1,' ', nombre2,' ', apellido1, ' ', apellido2 ) as nombre_completo from empleado where direccion like '%bucaramanga%';

-- 68 muestra los empleados que viven en cucuta y quindio
select concat_ws(' ',nombre1,' ', nombre2,' ', apellido1, ' ', apellido2 )as nombre_completo from empleado where direccion like '%cucuta%' ;

-- 69 mostrar los datos de empleado con salarios entre 45000 y 55000 en el sueldo diario con orden de menor a mayor

select * from empleado where sueldo_diario>=45000 and sueldo_diario<=55000 order by 11;

-- 70 muestra los datos de empleado de aquello que su salario diario es de 45000 y ordenalos de mayor a menor
select * from empleado where sueldo_diario<45000 order by 11 desc;

-- 71 muestra los datos de lo empleado lo que su salario diario sea mayor a 55000 y ordenalos de mayor a menor
select * from empleado where sueldo_diario>55000 order by 11 desc;

-- 73 muetra los datos de empleado que tienen salario entre 40000 y 55000 que son de cucuta

select * from empleado where sueldo_diario  between 40000 and 55000 and direccion like '%cucuta%';

-- 73 muetra los datos de empleado que tienen salario entre 30000 y 45000 que son de bogota

select * from empleado where sueldo_diario  between 30000 and 45000 and direccion like '%bogota%';

-- 73 muetra los datos de empleado que tienen salario entre 30000 y 55000 que son de cucuta

select * from empleado where sueldo_diario  between 30000 and 55000 and direccion like '%Cartagena%';

-- 74 calcular el sueldo general de los clientes segun la cantidad de dias trabajados

select concat_ws(' ',nombre1,' ', nombre2,' ', apellido1, ' ', apellido2 ) as empleado ,sueldo_diario*Dias_Trabajados as sueldo from empleado;

-- 75 muestra el empleado com mayor sueldo adquirido 
select concat_ws(' ',nombre1,' ', nombre2,' ', apellido1, ' ', apellido2 ) as empleado ,sueldo_diario*Dias_Trabajados as sueldo from empleado order by 2 desc limit 1;

-- 76 muestra los nombres, apellidos y la cantidad de dias trabajados de la tabal empleados 

select nombre1, nombre2, apellido1,apellido2 , dias_trabajados from empleado;

-- 77  Muestre la id de los empleados que se encuentra con estado activo y donde la cantidad de dias trabajados sean igual a 5
select empleado.id, nombre1, nombre2, apellido1, apellido2 from empleado inner join estado on estado.id = empleado.id_Estado where estado.nombre='activo' ;

-- 78 Muestre la id de los empleados que se encuentra con estado activo y donde la cantidad de dias trabajados sean igual a 5
select empleado.id, nombre1, nombre2, apellido1, apellido2 from empleado inner join estado on estado.id = empleado.id_Estado where estado.nombre='activo' ;

-- 80 muetra la cantidad de empleados  con estado activo

select count(id_estado) as estado_activo from empleado inner join estado on estado.id = empleado.id_Estado where estado.nombre='activo' ;

-- 81 muestra la cantidad de empleados con estado inactivo

select count(id_estado) as estado_inactivo from empleado inner join estado on estado.id = empleado.id_Estado where estado.nombre='inactivo' ;


-- 82 muestre la marca y modelo de las maquina y el estado en que se encuentra 

select marca ,modelo ,estado.nombre as estado from maquinaria inner join estado on maquinaria.id_estado =estado.id ;

-- 83  muestre los nombres de los conductores que suelen tener como ruta de inicio la ciudad de bogota

select conductor, ruta from Ruta where left(ruta,6)="Bogota";

-- 84  muetras los empleado que tengan como nombre carlos

select nombre1,nombre2 from empleado where left(nombre1 , 6 )='carlos' or left(nombre2 , 6 )='carlos' ;

-- 85 muestre el id del proveedor y el nombre de la empresa a la que pertenece

select proveedores.id, empresa.nombre from proveedores inner join empresa on proveedores.id_empresa = empresa.id;

-- 86 muestre los estados que tiene cada proveedor sin que estos se repitan 

select distinct estado.nombre from estado inner join proveedores on proveedores.id_estado = estado.id;

-- 87 muetre los proveedores que estan inactivos y la empresa a la que pertenecen

select concat_ws(" ", proveedores.nombre," ",proveedores.apellido1, " ", proveedores.apellido2," " ) as Proveedor, estado.nombre, empresa.nombre 
from proveedores inner join estado on estado.id =proveedores.id_estado 
inner join empresa on proveedores.id_empresa=empresa.id where estado.nombre='inactivo';

-- 88 cuantos provedores pertenecen a una misma empresa ordenar del mayor a menor 

select empresa.nombre, count(id_empresa) as Total_empleados from proveedores inner join empresa on proveedores.id_empresa=empresa.id group by 1;

-- 89 mostrar las marca, modelo de las maquinas donde la descripcion nos indica que son tractores

select marca, modelo, descripcion from maquinaria  where left(descripcion, 7) ='Tractor';


-- ULTIMAS 10 SUBCONSULTAS 

-- 90 muestre el promedio de productos que fueron suministrados por las diferentes empresas
 select Empresa, avg(total_productos) from (select empresa.nombre as 'Empresa',count(id_empresa )as 'total_productos' from proveedores inner join empresa on empresa.id=proveedores.id_empresa group by 1) as obtener group by 1;

-- 91 muestre el total de productos que tienen fecha de caducidad para el mes de enero (01)

select Producto , total_productos from(select productos.nombre as 'Producto', count(inventario_producto.id) as 'total_productos' 
from productos inner join inventario_producto  on productos.id_Inventario_producto=Inventario_producto.id 
where month(Fecha_Caducidad )= '01' group by 1) as obtener group by 1;

-- 92  muestra el promedio de ventas que se ha tenido el cliente con id 2
select avg(cantidadventas) as promedio from (select count(v.id) as 'cantidadventas' from ventas v  where id_cliente=2) as obtener;

-- 93 muestre cuales fueron los producto que en venta hubo una cantidad mayor a 30

select id_venta, producto, cantidad from (select productos.nombre as 'producto', producto_cantidad as 'cantidad', ventas.id as 'id_venta'
from productos inner join ventas  on ventas.id_producto = productos.id where ventas.Producto_Cantidad >30 ) as obtener;

-- 94 calcular el valor las ganacias totales de ventas
select sum(cantidad*valor) from ( select Producto_Cantidad as 'cantidad' , Valor_Unidad as 'valor'  from ventas ) as obtener;

-- 95 calcular el total de ganancia que se tiene si se conoce que el promedio de ganacias es del 20% lo que equivale al(0.2%)
select producto,cantidad*valor*0.2 as ganacia_por_producto from ( select productos.nombre as 'producto', Producto_Cantidad as 'cantidad' , Valor_Unidad as 'valor'  
from ventas inner join productos on ventas.id_producto = productos.id ) as obtener;

-- 96 muestre la cantidad de pagos realizados a tarvés de tranferencias 
select  total_pagos_tranferencias from (select count(id ) as 'total_pagos_tranferencias' from pagos where forma_pago ='Transferencia') as obtener;

-- 97 muestre el promedio de pagos realizados a través de efectivos y  tarjeta de credito 

select avg(total_efectivo) as promedio_efectivo , avg(total_tarjeta)  as promedio_tarjeta_credito 
from(select count(case when forma_pago='Efectivo' then 1 end) as 'total_efectivo' ,
count(case when forma_pago='Tarjeta de Crédito' then 1 end) as 'total_tarjeta' from pagos )as obtener;


-- 98 calcule la suma del total de pago realizados

select sum(total_pagos) as total_pagos from(select total as 'total_pagos' from pagos) as obtener; 

-- 99  muestra el total de pagos que se realizaron en el mes de noviembre(11)

select count(id) total_fechas_mes_noviembre from (select id as 'id'from pagos where month (Fecha_Pago)='11')as obtener;

-- 100  nombre del producto mas solicitados a la hora de los pedidos

select producto,solicitudes from(select productos.nombre as 'producto' , count(id_producto) as 'solicitudes' from productos inner join pedido on productos.id =pedido.id_Producto  group by 1  order by 2 desc limit 3 ) as obtener ;



