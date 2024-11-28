# Finca

Este proyecto a sido creado con el fin de demostrar nuestras capacidades como desarrolladores de bases de datos y para comprobar la funcionalidad de la misma.

## Documentacion del proyecto
Este proyecto esta estructurado paso a paso en un notion que sigue un serie de sugerencias para la creacion la base de datos.

Se dejare el link del notion a continuacion:

    https://outrageous-rondeletia-363.notion.site/Finca-productiva-Jurley-14836dadd9408071b651fcc6403746c6

## Creacion del proyecto

Para la creacion de este proyecto tuvimos en cuenta los distintos requerimentos solicitados por el trainer, tales como: 

## Uso del proyecto
Para poder usar el proyecto debemos tener distintas herramientas tales como
 * SQLWorkbench
 * SQLServer
 * Git

 Se anexara el link del repositorio.

    https://github.com/JaynAP1/Proyecto_SQL_CorreaJerxon_BotelloYurley.git

### Modelado de la Base de Datos:

El modelo debe incluir las entidades necesarias para gestionar todos los aspectos de una finca de producción agrícola que involucra múltiples productos.
Las relaciones entre las entidades deben estar correctamente estructuradas y normalizadas hasta la Tercera Forma Normal (3FN).
Deben gestionar los procesos de producción, inventario, ventas, compras, empleados, proveedores, y todos los recursos involucrados en la operación de la finca.
Se debe simular una operación realista de la finca, con al menos 50 registros por tabla, distribuidos de manera coherente y relevante para cada entidad. Los datos deben ser consistentes y reflejar escenarios reales.
Los estudiantes son responsables de determinar qué entidades, atributos y relaciones son necesarias para reflejar con precisión la gestión de la finca.


Consultas SQL, Implementar 100 consultas SQL que permitan extraer información valiosa sobre la operación de la finca. Estas consultas deben enfocarse exclusivamente en:

Búsquedas de datos críticos, tales como el estado actual de los inventarios, producción mensual, ventas, compras a proveedores, costos operativos, desempeño de empleados, entre otros.
Las consultas deben ser diversas, utilizando combinaciones de joins, subconsultas, agrupaciones y filtrados.
Al menos 20 consultas deben involucrar subconsultas o agregaciones avanzadas, con el fin de generar informes o cálculos más complejos que puedan ser utilizados en la toma de decisiones.


Procedimientos Almacenados, Desarrollar 20 procedimientos almacenados que automaticen tareas importantes en la gestión de la finca, tales como:

Procesar las ventas y actualizar automáticamente los inventarios.
Registrar nuevos proveedores o empleados.
Actualizar el estado de maquinaria o equipo de trabajo según los reportes de mantenimiento.
Los procedimientos deben ser eficientes y optimizados, evitando la redundancia y garantizando integridad referencial.


Funciones SQL, Crear 20 funciones que permitan realizar cálculos personalizados o transformaciones que no puedan resolverse fácilmente con consultas directas. Por ejemplo:

Calcular el rendimiento promedio por hectárea de cada cultivo.
Estimar el costo operativo total de la finca en un período de tiempo determinado.
Las funciones deben ser reutilizables y contribuir a la optimización del sistema.


Eventos SQL, Definir 20 eventos que se ejecuten de forma automática en momentos específicos, para realizar tareas de mantenimiento, cálculos periódicos o actualizaciones automáticas. Estos pueden incluir:

Generar reportes mensuales de ventas y producción.
Actualizar automáticamente el salario de los empleados o el inventario de productos al final de cada jornada.
Los eventos deben estar correctamente calendarizados y ejecutarse sin interrumpir otras operaciones del sistema.


Triggers SQL, Implementar 20 triggers que respondan automáticamente a cambios en las tablas. Por ejemplo:

Cuando se inserte una nueva venta, actualizar el inventario de productos.
Al modificar el salario de un empleado, registrar el cambio en un historial.
Verificar la disponibilidad de maquinaria antes de asignarla a una tarea.
Los triggers deben garantizar la integridad de los datos y optimizar el rendimiento del sistema.


Control de Acceso y Roles de Usuario, Definir 5 tipos de usuarios para el sistema, cada uno con permisos específicos y restricciones de acceso.

Cada usuario debe tener un conjunto de privilegios que se ajuste a su rol dentro de la operación de la finca. Por ejemplo, un administrador con acceso total, un vendedor con acceso limitado a ventas e inventario, un contador que pueda manejar los reportes financieros, etc.
Los permisos deben ser implementados de manera precisa para evitar acceso no autorizado y garantizar la seguridad de los datos.

## Consultas

```sql
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

```

## Procedimientos
```sql

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
drop procedure if exists CambiarEstadoMaquinaria;

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
drop procedure if exists CambiarEstadoEmpleado;
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
drop Procedure  if exists AgregarEmpleado;
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
drop procedure if exists CambiarSueldo;
Delimiter //
Create procedure CambiarSueldo(in id_in int, in NuevoDiario int)
begin
	Update Empleado set Sueldo_Diario = NuevoDiario where id = id_in;
end
// Delimiter ;

call CambiarSueldo(1, 30000);

-- 8. Cambiar la cantidad de dias que trabaja un empleado.
Drop procedure if exists CambiarDias;
Delimiter //
Create procedure CambiarDias(in id_in int, in Cantidad_Dias int)
begin
	Update Empleado set Dias_Trabajados = Cantidad_Dias where id = id_in;
end
// Delimiter ;

call CambiarDias(1,2);

-- 9. Agregar una nueva Ruta.
Drop Procedure if exists RutasNuevas;
Delimiter //
Create procedure RutasNuevas(in Ruta_Nueva varchar(50),in ConductoRuta varchar (100))
begin
	Insert into Ruta (Ruta, Conductor) values (Ruta_Nueva, Conductor);
end
// Delimiter ;
Call RutasNuevas("Bogota - Valledupar", "Jose Ignacio");

-- 10. Actualizar una ruta existente.
Drop procedure if exists ActualizarRuta;
Delimiter //
Create procedure ActualizarRuta(in id_in int,in RutaActualizada varchar(50))
begin
	Update Ruta set Ruta = RutaActualizada where id = id_in;
end
// Delimiter ;

Call ActualizarRuta(1, "Bogota - Tibu");


-- 11. crear un proedimiento donde se agreguen nuevos clientes
Drop procedure if exists add_new_cliente;
delimiter //
create procedure add_new_cliente (in Nombre1 varchar (30), in Nombre2 varchar (30),in Apellido1 varchar (30) ,
in Apellido2 varchar (30),in Telefono bigint ,in Direccion varchar(30),in Cedula bigint )
begin 
	insert into Clientes (Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Cedula) VALUES
	(Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Cedula);
end //
delimiter ;

call add_new_cliente ('camilo', 'Eduardo', 'contreras', 'perez', 3023456721, 'Calle 15, Bogotá', 1098765432);
select * from clientes ;


-- 12 crear un proedimiento donde se agreguen nuevos proveedores 

Drop procedure if exists add_new_proveedor;
delimiter //
create procedure add_new_proveedor (in Nombre varchar (30),in Apellido1 varchar (30) ,
in Apellido2 varchar (30), in Telefono bigint , in Email varchar (30),in id_Estado int,in id_Empresa int  )
begin 
	insert into Proveedores (Nombre, Apellido1, Apellido2, Telefono, Email, id_Estado, id_Empresa) VALUES
(Nombre, Apellido1, Apellido2, Telefono, Email, id_Estado, id_Empresa) ;
end //
delimiter ;

call add_new_proveedor ('jesus','contreras', 'ortiz', 3002456710,'jesusEduardo02@gmail.com',3,4);
select * from proveedores ;

-- 13 crear un procedimiento don se puedan eliminar empleados segun id 
Drop procedure if exists eliminar_empleado;
delimiter //
create procedure eliminar_empleado (in id_empleado int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from empleado where empleado.id=id_empleado);
    if eliminar = 1 then 
		delete from empleado where empleado.id=id_empleado;
        signal sqlstate '45000' set message_text = 'se ha eliminado el empleado de manera correcta';
    else 
     signal sqlstate '45000' set message_text = 'No hay empleado con esta id';
	end if ;
end //
delimiter ;

call eliminar_empleado(47);
select * from empleado;

-- 14  crear un procedimiento que agrege  nuevas empresas proveedoras de insumos agropecuarios

Drop procedure if exists add_empresa;
delimiter //
create procedure add_empresa (in Nombre varchar (30),Ubicacion varchar (30) ,Descripcion varchar (100) )
begin 	
	insert into Empresa (Nombre, Ubicacion, Descripcion) VALUES
	(Nombre, Ubicacion, Descripcion) ;
end //
delimiter ;

call add_empresa ('agrovida','Bogotá','fuente de insumos de buena calidad para tu finca');
select * from empresa;


-- 15  crear un procedimiento que permita actualizar la cantidad de stock en inventario_productos según id.
Drop procedure if exists Actualizar_stock;
Delimiter //
Create procedure Actualizar_stock(in id_pro int,in cantidad_actualizada varchar(50))
begin
	Update inventario_producto set cantidad_stock=cantidad_actualizada where id = id_pro;
end// 
Delimiter ;

Call Actualizar_stock(1, 948);

select * from inventario_producto;

-- 16  crear un procedimiento que permita agregar nuevas fincas si asi se desea

Drop procedure if exists add_finca;
delimiter //
create procedure add_finca (in Nombre varchar (30) ,in id_Ciudad int,in Tamaño_Total int ,in Tamaño_Sembrado int)
begin 	
	insert into Finca (Nombre, id_Ciudad, Tamaño_Total, Tamaño_Sembrado) VALUES
	 (Nombre, id_Ciudad, Tamaño_Total, Tamaño_Sembrado) ;
end //
delimiter ;

call add_finca ('Finca el Bosque',(SELECT id FROM Ciudades WHERE Nombre = 'Bogota' LIMIT 1), 800, 400);
select * from finca;


-- 17  crear un procedimiento que permita agregar nuevas maquinas.
Drop procedure if exists add_maquina;
delimiter //
create procedure add_maquina (in Marca varchar (30),in Modelo varchar (30) ,in Descripcion varchar (100),in id_Estado int,in id_Finca int)
begin 	
	insert into Maquinaria (Marca, Modelo, Descripcion, id_Estado, id_Finca) VALUES
	 (Marca, Modelo, Descripcion, id_Estado, id_Finca) ;
end //
delimiter ;

call add_maquina ('Kubota','M5-111', 'Tractor con tecnología avanzada para el cultivo de cacao', 4, 2);
select * from Maquinaria;

-- 18 crear procedimiento que permita eliminar los proveedores con los que se termino el convenio o se encuentran inactivo

Drop procedure if exists eliminar_proveedores;
delimiter //
create procedure eliminar_proveedores (in id_proveedores int)
begin 	
	declare eliminar int;
    set eliminar= (select count(*) from proveedores where proveedores.id=id_proveedores);
    if eliminar = 1 then 
		delete from proveedores where proveedores.id=id_proveedores;
        signal sqlstate '45000' set message_text = 'se ha eliminado el empleado de manera correcta';
    else 
     signal sqlstate '45000' set message_text = 'No hay empleado con esta id';
	end if ;
end //
delimiter ;

call eliminar_proveedores(51);
select * from proveedores;


-- 19  crear un procedimiento que cambie el estado de los productos entre los estados agotados o en venta
drop procedure if exists Cambiarproducto;
Delimiter //
Create procedure Cambiarproducto(in id_pro int, in id_NewEstado int)
begin
	Declare EstadoActual int;
    Set EstadoActual = (select id_Estado from productos where id = id_pro);

	if id_NewEstado = 7 or id_NewEstado = 8  then
		if id_NewEstado != EstadoActual then
			update productos set id_Estado = id_NewEstado where id = id_pro;
		else
			signal sqlstate '45000' set message_text = "El estado al que intentas es el mismo que ya tiene.";
		end if;
    else 
		signal sqlstate '45000' set message_text = "El estado al que intentas cambiar es inaccesible para los empleados.";
	end if;
	
end//
 Delimiter ;
call Cambiarproducto(1,8);
select * from productos;

-- 20  crear un procedimiento que nos aplique un descuento del 5% a las ventas que tienen una cantidad de ventas  mayor a 40 y cuentan con trasportes

drop procedure if exists aplicar_descuentos ;

delimiter //
create procedure aplicar_descuentos (in idventa int )
begin
	declare total_pago int;
    set total_pago= (select ventas.Producto_Cantidad * productos.Precio_Unidad +30000 -(100 *0.05) as pago_total from productos 
    inner join ventas on ventas.id_producto = productos.id where ventas.Producto_Cantidad>40 and ventas.Transporte=1 limit 1);
    update pagos set total = total_pago where pagos.id_venta=idventa ;
    
end //
delimiter ;

call aplicar_descuentos(1);
select  * from pagos;
```

## Funciones
```sql
-- 1. calcular el sueldo total  para cada empleado de la finca segun los dias trabajados

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

-- 2. segun la cantidad y el precio por unidad del producto calcular el total a pagar en venta

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


-- 3. genere el total de ganacias que se tiene si se conoce que  el promedio de ganancias es del  0.2%(20%)

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


-- 4. muestre el valor total de las ventas realizadas

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


-- 5. hacer un pedido de prueba  que tenga en cuenta  el valor del producto total agregandole el precio de viaje

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

-- 6. hacer que los pedidos de prueba teniendo en cuenta  el valor del producto total agregandole el precio de viaje pero solo si estos incluyen trasporte donde se conoce que el valor 
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


-- 7. Obten el promedio del total de ventas que se han tenido .

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

-- 8. muestra el producto con mayor ventas realizadas

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

-- 9. muestra el nombre del cliente que mas compra a realizado

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


-- 10. muestre el nombre  del empleado que mas ventas a realizados

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

-- 11. Listar la cantidad de empleados en cada estado.
Delimiter //
Create Function EmpleadosEstado(Estado int)
returns int deterministic
begin
	Declare Cantidad int;
    set Cantidad = Estado;
    return Cantidad;
end //
Delimiter ;

Select Estado.Nombre, EmpleadosEstado(count(id_Estado)) as Cantidad from empleado inner join estado on empleado.id_Estado = estado.id group by 1;

-- 12. Listar la cantidad de maquinaria en cada estado.
Delimiter //
Create function MaquinariaEstado(Estado int)
returns int deterministic
begin
	Declare Cantidad int;
    set Cantidad = Estado;
    Return Cantidad;
end //
Delimiter ;

Select Estado.Nombre, MaquinariaEstado(count(id_Estado)) as Cantidad from maquinaria inner join estado on maquinaria.id_Estado = estado.id group by 1;

-- 13. 	Mostrar el terreno sin cultivar de alguna finca.
Delimiter //
Create function TerrenoSinCultivo(id_Finca_in int)
returns int deterministic
begin
	Declare SinCultivo int;
    select (Tamaño_total - Tamaño_Sembrado) into SinCultivo from finca where id = id_Finca_in;
    return SinCultivo;
end //
Delimiter ;
Select TerrenoSinCultivo(1);

-- 14. Determinar cuantos productos tiene un proveedor en especifico.
Delimiter //
Create function ProductosProveedor(id_in int)
returns int deterministic
begin
	Declare Cantidad int;
	select count(Inventario_produccion.Nombre) into Cantidad from Inventario_Produccion inner join proveedores on Inventario_Produccion.id_proveedor = proveedores.id where proveedores.id = id_in;
    Return Cantidad;
end //
Delimiter ;

Select ProductosProveedor(4);

-- 15. Buscar todos un proveedores que tenga el apellido que prefiera.
Delimiter //
Create function BuscarApellido(Apellido varchar(30))
returns varchar (30) deterministic
begin
	 Declare Retorno varchar(30);
     set Retorno = Apellido;
     Return Retorno;
end //
Delimiter ;
select * from proveedores where Apellido1 = BuscarApellido("Perez") or apellido2 = BuscarApellido("Perez");

-- 16. Obtener la cantidad de maquinaria operativa en una finca específica
Delimiter //
Create function Maquinaria_Finca( finca_Id int) 
returns int deterministic
begin
    declare cantidad int;
    select COUNT(*) into cantidad
    from maquinaria where id_Estado = 1 and id_Finca = finca_id;
    Return cantidad;
end;
// Delimiter ;

select Maquinaria_Finca(1);

-- 17. Obtener la cantidad de maquinaria no operativa en una finca específica
Delimiter //
Create function Maquinaria_Finca_noOperativa( finca_Id int) 
returns int deterministic
begin
    declare cantidad int;
    select COUNT(*) into cantidad
    from maquinaria where id_Estado = 2 and id_Finca = finca_id;
    Return cantidad;
end;
// Delimiter ;

select Maquinaria_Finca_noOperativa(1);

-- 18. Calcular el porcentaje de área sembrada respecto al total de una finca.

Delimiter //
Create function PorcentajeSembrado(Finca_id int)
returns decimal	(5,2) deterministic
begin
	Declare RetornoPorcentaje Decimal (5,2);
    select (Tamaño_Sembrado / Tamaño_Total)* 100 into RetornoPorcentaje from finca where id = Finca_id;
    return RetornoPorcentaje;
end
// Delimiter ;

select PorcentajeSembrado(1)

-- 19. Mostrar la cantidad de mantenimientos de la finca deseada.
Delimiter //
Create function TotalMantenimientos (Finca_id int)
returns int deterministic
begin
	Declare Cantidad int;
	select count(*) into Cantidad from historial where Tipo = "Mantenimiento" and id_Finca = Finca_id;
    Return Cantidad;
end
// Delimiter ;

Select TotalMantenimientos(1);

-- 19. Mostrar la cantidad de Cosecha de la finca deseada.
Delimiter //
Create function TotalCosecha (Finca_id int)
returns int deterministic
begin
	Declare Cantidad int;
	select count(*) into Cantidad from historial where Tipo = "Cosecha" and id_Finca = Finca_id;
    Return Cantidad;
end
// Delimiter ;

Select TotalCosecha(1);
```

## Eventos
```sql
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
end // 
Delimiter ;

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
end //
 Delimiter ;

-- 9. Cambiar la forma de pago de un producto a una hora especificada solo si los productos fueron pagados en efectivo.
Delimiter //
Create event FormaPagoChange
on schedule at '2024-11-27 12:00'
do
begin
    update pagos set Forma_Pago = "Sin datos" where Forma_Pago = "efectivo";
end //
 Delimiter ;

-- 10. Dejar sin finca la maquinaria de ford.

Delimiter //
Create event MaquinariaFord
on schedule at '2024-11-27 12:10'
do
begin
	update maquinaria set id_finca = 0 where Marca = "Ford";
end // 
Delimiter ;

-- 11. crear un evento que le vaya sumando un dia de trabajo a cada empleado 

delimiter //
drop event if exists suma_dias_trabajos;
create event suma_dias_trabajos
on  schedule every 1 day 
do 
begin 
update empleado set Dias_Trabajados= Dias_Trabajados+1 where empleado.id_Estado =3;
end //
delimiter ;
select * from empleado;

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

drop event if exists descuento_producto;
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
drop event if exists descuento_procedures;
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

drop event if exists descuento_procedures;
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
drop event if exists agregar_new_estado;
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
drop event if exists cosecha;
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
drop event if exists venta_total;
delimiter //
create event venta_total 
on  schedule every 7 day
do 
begin 
	call CalcularVenta(2,@Salida);
end //
delimiter ;
select @salida as NuevoValor;
```

## Triggers

```sql
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
 
 -- 5. crear un trigger que actualice el estado de clientes  y los datos viejos sean añadidos al historial
 
 delimiter //
 create trigger actualizar_estado_cliente
 after update on clientes
 for each row 
 begin 
  insert into historial (tipo,descripcion,id_finca) values ('Estado_anterior' , old.id_estado,1);
 end //
 delimiter ;
 
 update clientes  set id_estado= 4 where id=1 ;
 
 
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
  
  -- 12. Crea un trigger que cuando elimines un dato de la tabla empleado se envie hacia el historial.
  
drop trigger Eliminar_Ruta;

Delimiter //
Create trigger Eliminar_Ruta
before delete on Ruta
for each row
begin
	insert into historial (tipo,descripcion,id_finca) values ('Eliminado' , old.Ruta ,1);
end //
Delimiter ;

delete from Ruta where id = 17;

-- 13. Crea un trigger que cuando una ruta se actualize su valor viejo sea enviado al historial.

Delimiter //
Create trigger Actualizar_Ruta
before update on Ruta
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Anterior', old.Ruta, 1);
end //
Delimiter ;

update ruta set Ruta = "Bogota - Caracas" where id = 17;

-- 14. Crea una trigger que cuando se actualize un proveedor envie su nombre viejo al historial.

Delimiter //
Create trigger Actualizar_proveedor
before update on proveedores
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizado', old.Nombre, 1);
end //
Delimiter ;

update Proveedores set Nombre = "Jair" where id = 1;
   
-- 15. Crear un trigger que cuando se actualize un producto envie su nombre al historial.
Delimiter //
Create trigger productos_Nombre
before update on productos
for each row
begin
	insert into Historial (Tipo,Descripcion,id_finca) values ('Actualizado', old.Nombre, 1);
end //
Delimiter ;

update productos set precio_unidad = 100 where id = 1;

-- 16. Crear un trigger que cuando se actualize la finca envie el nombre de la finca que fue actualizada al historial.
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
drop trigger Eliminar_ciudad;

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
```

## Usuarios

```sql

-- creacion de usuario gerente. sus permisos son(lectura,actualizar,eliminar,insertar)
create user 'Gerente'@'host'identified by 'Gerente01';
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
```

# Desarrollado por
Proyecto desarrollado por Jerxon Jair Correa Amaris y Yurley Botello Garcia.
