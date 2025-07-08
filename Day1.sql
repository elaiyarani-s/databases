CREATE TABLE Students (
 student_id INT PRIMARY KEY,
   name VARCHAR(100),
   age INT
);

CREATE TABLE Courses (
 course_id INT PRIMARY KEY,
   course_name VARCHAR(100)
);

CREATE TABLE Enrollments (
 enrollment_id INT PRIMARY KEY,
   student_id INT,
   course_id INT,
   grade CHAR(1),
   FOREIGN KEY (student_id) REFERENCES Students (student_id),
   FOREIGN KEY (course_id) REFERENCES Courses (course_id)
);


INSERT INTO Students VALUES
(1, 'Sara', 20),
(2, 'Magnus', 30),
(3, 'Robert', 20);


INSERT INTO Courses VALUES
(101,'Math'),
(102, 'History'),
(103, 'Programming');

INSERT INTO Enrollments VALUES
(1,1,101,'A'),
(2,1,103,'B'),
(3,2,101,'D'),
(4,3,103,'A');

SELECT c.course_name, COUNT(*) AS num_students
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

 