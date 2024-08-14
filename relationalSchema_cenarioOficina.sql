create database if not exists cenario_oficina;  
use cenario_oficina; 

-- tabela clients
create table clients (
	idClient int primary key auto_increment,
    nameClient varchar(100) not null,
    addressClient varchar(150),
    phone varchar(13) not null
);

-- tabela vehicle
create table vehicle (
	idVehicle int primary key auto_increment,
    carModel varchar(50) not null,
    licensePlate varchar(7) not null unique,
    yearCar int,
    idClient int,
    foreign key (idClient) references Clients(idClient)
);

-- tabela mechanic
create table mechanic (
	idMechanic int primary key auto_increment,
    codeMec int unique not null,
    address varchar(150),
    specialty varchar (50)
);


-- tabela team
create table team (
	idTeam int primary key auto_increment,
    nameTeam varchar(45) not null
);

CREATE TABLE mechanic_Team (
    idMechanic INT,
    idTeam INT,
    PRIMARY KEY (idMechanic, idTeam),
    FOREIGN KEY (idMechanic) REFERENCES Mechanic(idMechanic),
    FOREIGN KEY (idTeam) REFERENCES Team(idTeam)
);

-- tabela service
create table service (
	idService int primary key auto_increment,
    descService varchar(100) not null,
    laborCost decimal(10,2) not null
);

-- tabela work order
create table WorkOrder (
	idWorkOrder int primary key auto_increment,
    numberWorkOrder int not null,
    issueDate date not null,
    valueWorkOrder decimal (10,2) not null,
	statusWorkOrder VARCHAR(45) NOT NULL,
    completionDate DATE,
    idVehicle int,
    idTeam int,
    foreign key (idVehicle) references Vehicle(idVehicle),
    foreign key (idTeam) references Team(idTeam)
);

-- tabela WorkOrder_Service (ligação de ordem de serviço e serviço)
CREATE TABLE WorkOrder_Service (
    idWorkOrder int,
    idService int,
    primary key (idWorkOrder, idService),
    foreign key (idWorkOrder) references WorkOrder(idWorkOrder),
    foreign key (idService) references Service(idService)
);

-- tabela Part
CREATE TABLE Part (
    idParte int primary key auto_increment,
    price decimal(10, 2) not null,
    description varchar(150)
);

-- tabela WorkOrder_Part (ligaçao serviço e peças)
CREATE TABLE WorkOrder_Part (
    idWorkOrder int,
    idPart int,
    primary key (idWorkOrder, idPart),
    foreign key (idWorkOrder) references WorkOrder(idWorkOrder),
    foreign key (idPart) references Part(idPart)
);

-- tabela Payment
CREATE TABLE Payment (
    idPayment int primary key auto_increment,
    idWorkOrder int,
    method enum('Cartão', 'Dois Cartões', 'Boleto', 'Pix', 'Transferência', 'Dinheiro') not null,
    amount decimal(10, 2) not null,
    paymentDate date,
    foreign key (idWorkOrder) references WorkOrder(idWorkOrder)
);

-- tabela Supplier
CREATE TABLE Supplier (
    idSupplier int primary key auto_increment,
    nameSupplier varchar(100) not null,
    contact varchar(50),
    phone varchar(13),
    address varchar(150)
);

-- tabela purchase
CREATE TABLE Purchase (
    idPurchase int primary key auto_increment,
    idSupplier int,
    purchaseDate date,
    totalValue decimal(10, 2) not null,
    foreign key (idSupplier) references Supplier(idSupplier)
);

-- tabela Purchase_Part (Relação entre Purchase e Part)
CREATE TABLE Purchase_Part (
    idPurchase int,
    idPart int,
    quantity int not null,
    unitPrice decimal(10, 2) not null,
    primary key (idPurchase, idPart),
    foreign key (idPurchase) references Purchase(idPurchase),
    foreign key (idPart) references Part(idPart)
);

-- tabela Appointment 
CREATE TABLE Appointment (
    idAppointment int primary key auto_increment,
    idClient int,
    idVehicle int,
    appointmentDate date,
    appointmentTime time,
    status enum('Agendado', 'Cancelado', 'Finalizado') not null,
    foreign key (idClient) references Clients(idClient),
    foreign key (idVehicle) references Vehicle(idVehicle)
);

-- Tabela Maintenance History 
CREATE TABLE MaintenanceHistory (
    idHistory int primary key auto_increment,
    idVehicle int,
    idWorkOrder int,
    maintenanceDate date,
    details varchar(255),
    foreign key (idVehicle) references Vehicle(idVehicle),
    foreign key (idWorkOrder) references WorkOrder(idWorkOrder)
);

-- tabela Employee 
CREATE TABLE Employee (
    idEmployee int primary key auto_increment,
    employeeName varchar(100) not null,
    roleEmployee varchar(50),
    salary decimal(10, 2),
    hireDate date,
    idTeam int,
	foreign key (idTeam) references Team(teamID)
);

-- tabela Extra Service 
CREATE TABLE ExtraService (
    idExtraService int primary key auto_increment,
    description varchar(150) not null,
    price decimal(10, 2) not null
);

-- tabela WorkOrder_ExtraService (Relação WorkOrder e ExtraService)
CREATE TABLE WorkOrder_ExtraService (
    idWorkOrder int,
    idExtraService int,
    primary key (idWorkOrder, idExtraService),
    foreign key (idWorkOrder) references WorkOrder(idWorkOrder),
    foreign key (idExtraService) references ExtraService(idExtraService)
);