create table tbmesa(idmesa serial primary key, numeroMesa numeric(10,0) not null);
create table tbcargo(idcargo serial primary key,  descripcion char(40) not null);
create table tbestado(idestado serial primary key, descripcion char(30) not null);
create table tbformapago(idformapago serial primary key, descripcion char(30) not null);
create table tbproveedor(idproveedor serial primary key,  nombre char(30) not null,  apellido char(30) not null,  identificacion numeric(10,0) not null,  telefono numeric(10,0) not null,  correo char(60) not null);
create table tbempleado(idempleado serial primary key,  nombre char(30) not null,  apellido char(30) not null,  identificacion numeric(10,0) not null,  telefono numeric(10,0) not null,  correo char(60) not null,  contrasena char(50) not null,  idcargo int not null references tbcargo(idcargo));
create table tbingrediente(idingrediente serial primary key, nombre char(30) not null, descripcion varchar(120) not null, precio numeric(12,2) not null, codigo numeric(10,0) not null, idestado int not null references tbestado(idestado));
create table tbplato(idplato serial primary key, nombre char(30) not null, descripcion varchar(120), precio numeric(12,2) not null);
create table tbingredientexplato(idingredientexplato serial primary key, cantidad numeric(10,0) not null, idingrediente int not null references tbingrediente(idingrediente), idplato int not null references tbplato(idplato));
create table tbinventario(idinventario serial primary key, fecha date not null, cantidad numeric(12,0) not null, idproveedor int not null references tbproveedor(idproveedor), idingrediente int not null references tbingrediente(idingrediente));
create table tbmenu(idmenu serial primary key, idplato int not null references tbplato(idplato));
create table tbpedido(idpedido serial primary key, fecha date not null, idempleado int not null references tbempleado(idempleado), idestado int not null references tbestado(idestado), idmesa int not null references tbmesa(idmesa));
create table tbpedidoxplato(idpedidoxplato serial primary key, cantidad numeric(10,0) not null, idplato int not null references tbplato(idplato), idpedido int not null references tbpedido(idpedido));
create table tbfactura(idfactura serial primary key, fecha date not null, total numeric(12,0) not null, idempleado int not null references tbempleado(idempleado), idestado int not null references tbestado(idestado), idpedido int not null references tbpedido(idpedido), idformapago int not null references tbformapago(idformapago))
