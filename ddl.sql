Create Database if not exists Finca_Jurley;
Use Finca_Jurley;

Create table if not exists Region(
id int,
Nombre varchar(30),
primary key (id)
);

Create table if not exists Estado (
id int,
Nombre varchar(30),
primary key (id)
);

Create table if not exists Ciudades (
id int,
Nombre varchar (30),
id_Region int,
primary key(id),
foreign key (id_Region) references Region(id)
);

Create table if not exists Finca (
id int,
Nombre varchar (30),
id_Ciudad int,
Tamaño_Total int,
Tamaño_Sembrado int,
primary key(id),
foreign key (id_Ciudad) references Ciudades(id)
);

Create table if not exists Maquinaria (
id int,
Marca varchar (30),
Modelo varchar (30),
Descripcion varchar (50),
id_Estado int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Estado) references Estado(id)
);

create table if not exists Ruta (
id int,
Ruta varchar (100),
Conductor varchar (50),
primary key (id)
);

Create table if not exists Transporte (
id int,
Marca varchar (30),
Modelo varchar (30),
id_Ruta int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Ruta) references Ruta(id)
);

Create table if not exists Historial(
id int,
Tipo varchar (30),
Descripcion varchar (50),
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

Create table if not exists Empresa (
id int,
Nombre varchar (30),
Ubicacion varchar (30),
Descripcion varchar (50),
primary key (id)
);

Create table if not exists Proveedores (
id int,
Nombre varchar (30),
Apellido1 varchar (30),
Apellido2 varchar (30),
Telefono bigint,
Email varchar(40),
id_Estado int,
id_Empresa int,
primary key(id),
foreign key (id_Empresa) references Empresa(id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Inventario_Produccion (
id int,
Nombre varchar(30),
Cantidad int,
Valor_Unitario int,
id_Proveedor int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

create table if not exists Inventario_Producto (
id int,
Cantidad_Stock int,
Fecha_produccion varchar (30),
Fecha_Caducidad varchar(30),
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

Create table if not exists Productos (
id int,
Nombre varchar (30),
Precio_Unidad int,
Descripcion varchar(50),
Contenido varchar (50),
Tipo varchar (30),
id_Estado int,
id_Inventario_producto int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Clientes (
id int, 
Nombre1 varchar (30),
Nombre2 varchar (30),
Apellido1 varchar (30),
Apellido2 varchar (30),
Telefono int,
Direccion varchar(30),
Cedula bigint,
primary key(id)
);

Create table if not exists Empleado (
id int, 
Nombre1 varchar (30),
Nombre2 varchar (30),
Apellido1 varchar (30),
Apellido2 varchar (30),
Cargo varchar (30),
Telefono int,
Direccion varchar(30),
Cedula bigint,
Email varchar (30),
Comision int,
id_Estado int,
primary key (id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Ventas (
id int,
id_Producto int,
id_Cliente int,
Producto_Cantidad int,
Valor_Unidad int,
Transporte tinyint,
id_Transporte int,
id_Empleado int,
primary key (id),
foreign key (id_Producto) references Productos(id),
foreign key (id_Cliente) references Clientes(id),
foreign key (id_Transporte) references Transporte(id),
foreign key (id_Empleado) references Empleado(id)
);

Create table if not exists Pagos (
id int,
Total int,
Forma_Pago varchar(30),
Fecha_Pago date,
id_venta int,
id_Cliente int,
primary key (id),
foreign key (id_Venta) references Ventas (id),
foreign key (id_Cliente) references Clientes (id)
);

Create table if not exists Pedido (
id int,
id_Producto int,
id_Venta int,
Fecha_Pedido date,
primary key (id),
foreign key (id_Producto) references Productos (id),
foreign key (id_Venta) references Ventas (id)
)