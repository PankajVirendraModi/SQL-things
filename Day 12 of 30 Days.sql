Q.1. write a SQL query to find the top 2 departments with the highest average employee salaries,
but only include departments with more than 2 employees.

-- Create the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);

-- Insert values into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
(101, 'Human Resources'),
(102, 'Marketing'),
(103, 'Sales');

-- Create the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Salary INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert values into the Employees table
INSERT INTO Employees (EmployeeID, Name, Salary, DepartmentID) VALUES 
(1, 'Aditya', 70000, 101),
(2, 'Bhavna', 48000, 102),
(3, 'Chetan', 50000, 101),
(4, 'Deepika', 55000, 103),
(5, 'Esha', 60000, 101),
(6, 'Faisal', 52000, 103),
(7,'Gaurav',58000 ,102);

select * from departments;
select * from employees;

WITH AvgSalaries AS (
    SELECT d.departmentid, d.departmentname, Round(AVG(e.salary)) AS avg_salary
    FROM departments d
    JOIN employees e ON d.departmentid = e.departmentid
    GROUP BY d.departmentid, d.departmentname
    HAVING COUNT(e.employeeid) > 2
)
SELECT departmentid, departmentname, avg_salary
FROM AvgSalaries
ORDER BY avg_salary DESC
LIMIT 2;

Q.2. Distinct vs Group By
Distinct: It removes the duplicate rows and returns the unique rows based on specified column(s)
Group by: It organizes data into groups based on common values in the specified column(s)