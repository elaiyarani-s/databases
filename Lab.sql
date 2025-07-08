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