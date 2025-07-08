CREATE TABLE Departments (
 dept_id INT PRIMARY KEY,
   dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Employees (
 emp_id INT PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   age INT CHECK (age >= 18),
   email VARCHAR(100) UNIQUE,
   salary DECIMAL(10,2) DEFAULT 30000,
   dept_id INT,
   FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Departments VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Marketing');

INSERT INTO Employees VALUES
(101,'Anna', 28, 'anna@gmail.com', 55000, 1),
(102,'Bob', 35, 'bob@gmail.com', 62000, 2),
(103,'Magnus', 23, 'Magnus@gmail.com', DEFAULT, 3),
(104, 'Adam', 18, 'bob2@gmail.com', 40000, 1 );

SELECT * FROM Employees e JOIN Departments d ON e.dept_id = d.dept_id