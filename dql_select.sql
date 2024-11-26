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
  
-- 56 muestra los productos de kg
  
select nombre , contenido from  productos  where contenido = '1 kg';
  
-- 57 muestra los productos  de  250 gramos
  
select nombre , contenido from  productos  where contenido = '250g';
    
-- 58 muestra los productos  de  500 gramos
    
select nombre , contenido from  productos  where contenido = '500g';
        
-- 59 muestra los productos  de  250 ml
    
select nombre , contenido from  productos  where contenido = '250ml';
     
-- 60 muetre los datos de la tabla de transportes

select * from Transporte ;


-- 61  muestre el vehiculo y la ruta del producto.

select ventas.id_Producto, Modelo, Ruta from ventas inner join transporte on ventas.id_transporte = transporte.id inner join ruta on transporte.id_Ruta = ruta.id where ventas.id_transporte is null;

-- 62. Todas las ventas que tengan transporte nulo.
select count(id) from ventas where id_transporte is null;

