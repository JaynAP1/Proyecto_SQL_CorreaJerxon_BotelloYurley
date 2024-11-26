Create Database if not exists Finca_Jurley;
Use Finca_Jurley;

Create table if not exists Region(
id int auto_increment,
Nombre varchar(30) not null,
primary key (id)
);

Create table if not exists Estado (
id int auto_increment,
Nombre varchar(30) not null,
primary key (id)
);

Create table if not exists Ciudades (
id int auto_increment,
Nombre varchar (30) not null,
id_Region int,
primary key(id),
foreign key (id_Region) references Region(id)
);

Create table if not exists Finca (
id int auto_increment,
Nombre varchar (30) not null,
id_Ciudad int,
Tamaño_Total int not null,
Tamaño_Sembrado int not null,
primary key(id),
foreign key (id_Ciudad) references Ciudades(id)
);

Create table if not exists Maquinaria (
id int auto_increment,
Marca varchar (30) not null,
Modelo varchar (30) not null,
Descripcion varchar (100),
id_Estado int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Estado) references Estado(id)
);

create table if not exists Ruta (
id int auto_increment,
Ruta varchar (100) not null,
Conductor varchar (50) not null,
primary key (id)
);

Create table if not exists Transporte (
id int auto_increment,
Marca varchar (30) not null,
Modelo varchar (30) not null,
Fecha_Salida varchar (30),
Fecha_Llegada varchar (30),
id_Ruta int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Ruta) references Ruta(id)
);

Create table if not exists Historial(
id int auto_increment,
Tipo varchar (30) not null,
Descripcion varchar (100) not null,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

Create table if not exists Empresa (
id int auto_increment,
Nombre varchar (30) not null,
Ubicacion varchar (30) not null,
Descripcion varchar (100) not null,
primary key (id)
);

Create table if not exists Proveedores (
id int auto_increment,
Nombre varchar (30) not null,
Apellido1 varchar (30)not null,
Apellido2 varchar (30),
Telefono bigint not null,
Email varchar(40) not null,
id_Estado int,
id_Empresa int,
primary key(id),
foreign key (id_Empresa) references Empresa(id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Inventario_Produccion (
id int auto_increment,
Nombre varchar(100) not null,
Cantidad int not null,
Valor_Unitario int not null,
id_Proveedor int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

create table if not exists Inventario_Producto (
id int auto_increment,
Cantidad_Stock int not null,
Fecha_produccion varchar (30) not null,
Fecha_Caducidad varchar(30),
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id)
);

Create table if not exists Productos (
id int auto_increment,
Nombre varchar (100) not null,
Precio_Unidad int not null,
Descripcion varchar(100) ,
Contenido varchar (50) not null,
Tipo varchar (30) not null,
id_Estado int,
id_Inventario_producto int,
id_Finca int,
primary key (id),
foreign key (id_Finca) references Finca (id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Clientes (
id int auto_increment, 
Nombre1 varchar (30) not null,
Nombre2 varchar (30),
Apellido1 varchar (30) not null,
Apellido2 varchar (30),
Telefono bigint not null,
Direccion varchar(30) not null,
Cedula bigint not null,
primary key(id)
);

Create table if not exists Empleado (
id int auto_increment, 
Nombre1 varchar (30) not null,
Nombre2 varchar (30),
Apellido1 varchar (30) not null,
Apellido2 varchar (30),
Cargo varchar (100) not null,
Telefono bigint not null,
Direccion varchar(30) not null,
Cedula bigint not null,
Email varchar (30) not null,
Sueldo_Diario int not null,
id_Estado int,
Dias_Trabajados int not null,
primary key (id),
foreign key (id_Estado) references Estado(id)
);

Create table if not exists Ventas (
id int auto_increment,
id_Producto int,
id_Cliente int,
Producto_Cantidad int not null,
Valor_Unidad int not null,
Transporte tinyint not null,
id_Transporte int,
id_Empleado int,
primary key (id),
foreign key (id_Producto) references Productos(id),
foreign key (id_Cliente) references Clientes(id),
foreign key (id_Transporte) references Transporte(id),
foreign key (id_Empleado) references Empleado(id)
);

Create table if not exists Pagos (
id int auto_increment,
Total int not null,
Forma_Pago varchar(30) not null,
Fecha_Pago date  not null,
id_venta int,
id_Cliente int,
primary key (id),
foreign key (id_Venta) references Ventas (id),
foreign key (id_Cliente) references Clientes (id)
);

Create table if not exists Pedido (
id int auto_increment,
id_Producto int,
id_Venta int,
Fecha_Pedido date  not null,
primary key (id),
foreign key (id_Producto) references Productos (id),
foreign key (id_Venta) references Ventas (id)
)