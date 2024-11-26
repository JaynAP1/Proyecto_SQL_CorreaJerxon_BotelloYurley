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

-- 22. Muestre todos los clientes que su cedula inicie

-- 23. Muestre todas las empresas.
select * from empresa;

-- 24. Muestre las empresas que estan ubicadas en Bogota.
select * from empresa where Ubicacion = "Bogota";

-- 25. Muestre las empresas que tengan que ver con fertilizantes.
select * from empresa where Descripcion like '%fertilizantes%';