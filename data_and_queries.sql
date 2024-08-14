-- Inserção de Clientes
INSERT INTO Clients (nameClient, addressClient, phone) VALUES
('João Ninguém', '123 Main St', '999999999'),
('Janet Silva', '456 Oak Ave', '888888888'),
('Diego Souza', '789 Pine Rd', '777777777');

-- Inserção de Veículos
INSERT INTO Vehicle (carModel, licensePlate, yearCar, idClient) VALUES
('Toyota Corolla', 'ABC1234', 2018, 1),
('Honda Civic', 'XYZ5678', 2020, 2),
('Ford Focus', 'LMN2345', 2017, 3);

-- Inserção de Mecânicos
INSERT INTO Mechanic (codeMec, address, specialty) VALUES
(1001, '12 Baker St', 'Suspensão'),
(1002, '34 Elm St', 'Freios'),
(1003, '56 Maple Ave', 'Motor');

-- Inserção de Equipes
INSERT INTO Team (nameTeam) VALUES 
('Time Um'),
('Time Dois');

-- Inserção de Relação Mecânico-Equipe
INSERT INTO Mechanic_Team (idMechanic, idTeam) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Inserção de Serviços
INSERT INTO Service (descService, laborCost) VALUES
('Mudança de Óleo', 100.00),
('Substituição de freio', 250.00),
('Ajuste do motor', 300.00);

-- Inserção de Peças
INSERT INTO Part (price, description) VALUES
(50.00, 'Filtro de óleo'),
(150.00, 'Pastilhas de freio'),
(200.00, 'Correia');

-- Inserção de Ordens de Serviço
INSERT INTO WorkOrder (numberWorkOrder, issueDate, valueWorkOrder, statusWorkOrder, completionDate, idVehicle, idTeam) VALUES
(101, '2023-08-01', 400.00, 'Completo', '2023-08-03', 1, 1),
(102, '2023-08-05', 500.00, 'Em Andamento', NULL, 2, 2),
(103, '2023-08-15', 600.00, 'Agendado', NULL, 3, 1);

-- Inserção de Relação WorkOrder-Service
INSERT INTO WorkOrder_Service (idWorkOrder, idService) VALUES
(1, 1),
(1, 2),
(2, 3);

-- Inserção de Relação WorkOrder-Part
INSERT INTO WorkOrder_Part (idWorkOrder, idPart) VALUES
(1, 1),
(1, 2),
(2, 3);

-- Inserção de Pagamentos
INSERT INTO Payment (idWorkOrder, method, amount, paymentDate) VALUES
(1, 'Pix', 400.00, '2023-08-04'),
(2, 'Cartão', 250.00, '2023-08-06'),
(2, 'Dinheiro', 250.00, '2023-08-06');

-- Inserção de Fornecedores
INSERT INTO Supplier (nameSupplier, contact, phone, address) VALUES
('Auto Parts Cia.', 'Luis', '999999998', '101 Auto St'),
('Suprimentos para Carros Ltd.', 'Maria', '888888887', '202 Supply Ave');

-- Inserção de Compras
INSERT INTO Purchase (idSupplier, purchaseDate, totalValue) VALUES
(1, '2023-07-15', 1500.00),
(2, '2023-07-20', 1800.00);

-- Inserção de Relação Purchase-Part
INSERT INTO Purchase_Part (idPurchase, idPart, quantity, unitPrice) VALUES
(1, 1, 10, 50.00),
(2, 2, 12, 150.00),
(1, 3, 8, 200.00);

-- Inserção de Agendamentos
INSERT INTO Appointment (idClient, idVehicle, appointmentDate, appointmentTime, status) VALUES
(1, 1, '2023-08-10', '09:00:00', 'Agendado'),
(2, 2, '2023-08-12', '14:00:00', 'Agendado');

-- Inserção de Histórico de Manutenções
INSERT INTO MaintenanceHistory (idVehicle, idWorkOrder, maintenanceDate, details) VALUES
(1, 1, '2023-08-03', 'Troca de óleo e substituição de freio concluída.'),
(2, 2, '2023-08-06', 'Ajuste de motor em andamento.');

-- Inserção de Funcionários
INSERT INTO Employee (employeeName, roleEmployee, salary, hireDate, idTeam) VALUES
('Alice Johnson', 'Gerente', 5000.00, '2022-01-01', 1),
('Bob Williams', 'Assistente', 3000.00, '2023-03-15', 2);

-- Inserção de Serviços Extras
INSERT INTO ExtraService (descExtraService, price) VALUES
('Lavagem de carro', 50.00),
('Limpeza Interior', 75.00);

-- Inserção de Relação WorkOrder-ExtraService
INSERT INTO WorkOrder_ExtraService (idWorkOrder, idExtraService) VALUES
(1, 1),
(2, 2);

-- -- -- Queries -- -- --

-- Recuperação Simples com SELECT
SELECT nameClient, addressClient, phone FROM Clients;

-- Filtros com WHERE Statement
SELECT carModel, licensePlate, yearCar FROM Vehicle WHERE yearCar > 2018;

-- Crie expressões para gerar atributos derivados
SELECT 
    descService, 
    laborCost, 
    laborCost * 1.1 as totalCostWithTax
FROM Service;

-- Defina ordenações dos dados com ORDER BY
SELECT employeeName, roleEmployee, salary 
FROM Employee 
ORDER BY salary desc; 

-- Condições de filtros aos grupos – HAVING Statement
SELECT 
    idWorkOrder, 
    SUM(amount) as totalPayments 
FROM Payment 
GROUP BY idWorkOrder 
HAVING SUM(amount) > 300.00;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
SELECT 
    Clients.nameClient, 
    Vehicle.carModel, 
    Mechanic.specialty, 
    WorkOrder.statusWorkOrder, 
    Payment.amount
FROM WorkOrder
JOIN Vehicle on WorkOrder.idVehicle = Vehicle.idVehicle
JOIN Clients on Vehicle.idClient = Clients.idClient
JOIN Mechanic_Team on WorkOrder.idTeam = Mechanic_Team.idTeam
JOIN Mechanic on Mechanic_Team.idMechanic = Mechanic.idMechanic
JOIN Payment on WorkOrder.idWorkOrder = Payment.idWorkOrder
WHERE WorkOrder.statusWorkOrder = 'Completo';




