CREATE TABLE City (
    CityId INT PRIMARY KEY,
    CityName VARCHAR(50)
);

CREATE TABLE Building (
    BuildingId INT PRIMARY KEY,
    CityId INT,
    Floors INT,
    FOREIGN KEY(CityId) REFERENCES City(CityId)
);
CREATE TABLE ElevatorType(
    ElevatorTypeId INT PRIMARY KEY,
    TypeName VARCHAR(50)
);

CREATE TABLE ElevatorModel (
    ElevatorModelId INT PRIMARY KEY,
    ModelName INT,
    Speed INT,
    MaxWeight INT,
    PeopleLimit INT,
    ElevatorTypeId INT,
    FOREIGN KEY(ElevatorTypeId) REFERENCES ElevatorType(ElevatorTypeId)
);

CREATE TABLE Elevator (
    ElevatorId INT PRIMARY KEY,
    ElevatorModelId INT,
    BuildingId INT,
    InstallationDate DATE,
    FOREIGN KEY(ElevatorModelId) REFERENCES ElevatorModel(ElevatorModelId),
    FOREIGN KEY(BuildingId) REFERENCES Building(BuildingId)
);

CREATE TABLE ServiceStatus (
    ServiceStatusId INT PRIMARY KEY,
    StatusDescription VARCHAR(50)
);

CREATE TABLE EmployeeStatus (
    EmployeeStatusId INT PRIMARY KEY,
    StatusDescription VARCHAR(50)
);

CREATE TABLE Technician (
    EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    EmailAddress VARCHAR(50),
    AnnualSalary INT,
    SpecialSkill VARCHAR(100),
    EmployeeStatusId INT,
    FOREIGN KEY(EmployeeStatusId) REFERENCES EmployeeStatus(EmployeeStatusId)
);

CREATE TABLE ServiceActivity (
    ServiceActivityid INT PRIMARY KEY,
    EmployeeId INT,
    ElevatorId INT,
    ServiceDateTime DATE,
    ServiceDescription VARCHAR(50),
    ServiceStatusId INT,
    FOREIGN KEY(EmployeeId) REFERENCES Technician(EmployeeId),
    FOREIGN KEY(ElevatorId) REFERENCES Elevator(ElevatorId)

);

--------------INSERT------------------------

INSERT INTO City VALUES
(1, 'Stockholm'),
(2, 'Göteborg'),
(3, 'Malmö');

INSERT INTO Building VALUES
(1, 1, 20),
(2, 1, 35),
(3, 2, 15),
(4, 3, 40);

INSERT INTO ElevatorType VALUES
(1, 'Passenger'),
(2, 'Freight'),
(3, 'Service');

INSERT INTO ElevatorModel VALUES
(1, 1001, 200, 1000, 12, 1),
(2, 1002, 150, 2000, 6, 2),
(3, 1003, 180, 1200, 10, 3);

INSERT INTO Elevator  VALUES
(1, 1, 1, '2012-05-01'),
(2, 2, 2, '2010-08-15'),
(3, 3, 3, '2022-01-10'),
(4, 1, 4, '2019-12-25');

INSERT INTO ServiceStatus VALUES
(1, 'Pending'),
(2, 'In Progress'),
(3, 'Completed'),
(4, 'Cancelled');

INSERT INTO EmployeeStatus VALUES
(1, 'Active'),
(2, 'On Leave'),
(3, 'Retired');

INSERT INTO Technician (EmployeeId, FirstName, LastName, EmailAddress, AnnualSalary, SpecialSkill, EmployeeStatusId) VALUES
(1, 'Astrid', 'Johansson', 'astrid.johansson@artico.com', 70000, 'Hydraulic Systems', 1),
(2, 'William', 'Svensson', 'william.svensson@artico.com', 75000, 'Electric Systems', 1),
(3, 'Liam', 'Larsson', 'liam.larsson@artico.com', 68000, 'Emergency Repairs', 2);


INSERT INTO ServiceActivity (ServiceActivityid, EmployeeId, ElevatorId, ServiceDateTime, ServiceDescription, ServiceStatusId) VALUES
(1, 1, 1, '2024-10-05', 'Routine checkup', 3),
(2, 2, 2, '2025-01-14', 'Door malfunction', 3),
(3, 1, 3, '2025-03-09', 'Cable replacement', 2),
(4, 3, 4, '2025-06-10', 'Overload error', 1);


---------------------SELECT---------------------

SELECT * FROM City;

SELECT * FROM Building;

SELECT * FROM ElevatorType;

SELECT * FROM ElevatorModel;

SELECT * FROM Elevator;

SELECT * FROM ServiceStatus;

SELECT * FROM EmployeeStatus;

SELECT * FROM Technician;

SELECT * FROM ServiceActivity;


----------------------------SUMMARY OF THE TABLES--------------------------

SELECT 
    sa.ServiceActivityId,
    sa.ServiceDateTime,
    sa.ServiceDescription,
    ss.StatusDescription AS ServiceStatus,
    t.EmployeeId,
    t.FirstName,
    t.LastName,
    t.EmailAddress,
    t.SpecialSkill,
    es.StatusDescription AS EmployeeStatus,
    e.ElevatorId,
    em.ModelName,
    em.Speed,
    em.MaxWeight,
    em.PeopleLimit,
    et.TypeName AS ElevatorType,
    b.BuildingId,
    b.Floors,
    c.CityName

FROM ServiceActivity sa
JOIN Technician t ON sa.EmployeeId = t.EmployeeId
JOIN EmployeeStatus es ON t.EmployeeStatusId = es.EmployeeStatusId
JOIN ServiceStatus ss ON sa.ServiceStatusId = ss.ServiceStatusId
JOIN Elevator e ON sa.ElevatorId = e.ElevatorId
JOIN ElevatorModel em ON e.ElevatorModelId = em.ElevatorModelId
JOIN ElevatorType et ON em.ElevatorTypeId = et.ElevatorTypeId
JOIN Building b ON e.BuildingId = b.BuildingId
JOIN City c ON b.CityId = c.CityId
ORDER BY sa.ServiceDateTime DESC;

----------------------SERVICE SUMMARY BY GROUPS----------------------------

--1. Technicians:

SELECT 
    t.EmployeeId,
    t.FirstName,
    t.LastName,
    COUNT(sa.ServiceActivityId) AS TotalServices
FROM Technician t
LEFT JOIN ServiceActivity sa ON t.EmployeeId = sa.EmployeeId
GROUP BY t.EmployeeId, t.FirstName, t.LastName
ORDER BY TotalServices DESC;

--2. Status:

SELECT 
    ss.StatusDescription,
    COUNT(sa.ServiceActivityId) AS TotalServices
FROM ServiceActivity sa
JOIN ServiceStatus ss ON sa.ServiceStatusId = ss.ServiceStatusId
GROUP BY ss.StatusDescription
ORDER BY TotalServices DESC;

--3. City:

SELECT 
    c.CityName,
    COUNT(sa.ServiceActivityId) AS TotalServices
FROM ServiceActivity sa
JOIN Elevator e ON sa.ElevatorId = e.ElevatorId
JOIN Building b ON e.BuildingId = b.BuildingId
JOIN City c ON b.CityId = c.CityId
GROUP BY c.CityName
ORDER BY TotalServices DESC;

--4.Elevator Models:

SELECT 
    em.ModelName,
    COUNT(sa.ServiceActivityId) AS TotalServices
FROM ServiceActivity sa
JOIN Elevator e ON sa.ElevatorId = e.ElevatorId
JOIN ElevatorModel em ON e.ElevatorModelId = em.ElevatorModelId
GROUP BY em.ModelName
ORDER BY TotalServices DESC;


