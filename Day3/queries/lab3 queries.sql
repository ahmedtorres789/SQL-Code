USE Company_SD

--Display all the employees Data.
SELECT * FROM Employee;

--Display the employee First name, last name, Salary and Department number.
SELECT Fname, Lname, Salary, Dno FROM Employee;

--Display all the projects names, locations and the department which is responsible about it
SELECT p.Pname, p.Plocation, d.Dname AS responsible_department
FROM Project p
JOIN Departments d ON p.Dnum = d.Dnum;

--If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
SELECT CONCAT(Fname, ' ', Lname) AS full_name, (Salary*12) * 0.1 AS ANNUAL_COMM 
FROM Employee;

--Display the employees Id, name who earns more than 1000 LE monthly.
SELECT SSN, CONCAT(Fname, ' ', Lname) AS full_name 
FROM Employee
WHERE Salary > 1000;

--Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, CONCAT(Fname, ' ', Lname) AS full_name 
FROM Employee
WHERE Salary > 10000;

--Display the names and salaries of the female employees 
SELECT Fname, Lname, Salary 
FROM Employee 
WHERE Gender = 'F';

--Display each department id, name which managed by a manager with id equals 968574
SELECT Dnum, Dname 
FROM Departments 
WHERE MGRSSN = 968574;

--Dispaly the ids, names and locations of  the pojects which controled with department 10.
SELECT Pnumber, Pname, Plocation 
FROM Project 
WHERE Dnum = 10;


--DML

--Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee(Fname, Lname, Dno , ssn, superssn, salary)
VALUES ('YourFirstName', 'YourLastName', 30, 102672, 112233, 3000);

--Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
INSERT INTO Employee (Fname, Lname, Dno, ssn)
VALUES ('FriendFirstName', 'FriendLastName', 30, 102660);

--Upgrade your salary by 20 % of its last value.
UPDATE Employee 
SET salary = salary * 1.2 
WHERE Fname = 'YourFirstName' AND Lname = 'YourLastName';
-- يفضل استخدم ال ssn لانه unique 







