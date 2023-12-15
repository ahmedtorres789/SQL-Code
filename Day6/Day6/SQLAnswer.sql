USE Company_SD
--1.	Create a view that shows the project number and name along with the total number of hours worked on each project.
   CREATE VIEW ProjectHoursView AS
   SELECT p.Pnumber, p.Pname, SUM(h.Hours) AS TotalHours
   FROM Project p
   JOIN Works_for h ON p.Pnumber = h.Pno
   GROUP BY p.Pnumber, p.Pname;

   SELECT * from ProjectHoursView

--2.	Create a view that displays the project number and name along with the name of the department managing the project, ordered by project number.
 CREATE VIEW ProjectDepartmentView AS
   SELECT TOP (100) PERCENT p.Pnumber, p.Pname, d.Dname
   FROM Project p
   JOIN Departments d ON p.Dnum = d.Dnum
   ORDER BY p.Pnumber ;

    SELECT * from ProjectDepartmentView

--3.	Create a view that shows the project name and location along with the total number of employees working on each project.

CREATE VIEW ProjectEmployeeCountView AS 
SELECT p.Pname , p.Plocation  , COUNT(wf.ESSn) AS EmpCount
FROM Project p 
JOIN  Works_for wf ON wf.Pno = p.Pnumber
JOIN Employee e ON e.SSN = wf.ESSn
GROUP BY p.Pname , p.Plocation

SELECT * FROM ProjectEmployeeCountView

--4.	Create a view that displays the department number, name, and the number of employees in each department.
CREATE VIEW EmpCountView AS 

SELECT d.Dnum, d.Dname, COUNT(e.SSN) AS EmployeeCount
FROM Departments d
JOIN Employee e ON e.Dno = d.Dnum
GROUP BY d.Dnum, d.Dname;


SELECT * FROM EmpCountView

--5.	Create a view that shows the names of employees who work on more than one project, along with the count of projects they work on.

CREATE VIEW EmployeesMultipleProjectsView AS
SELECT e.Fname , COUNT(wf.Pno) AS project_count
FROM Employee e
JOIN works_for wf ON e.SSN = wf.ESSn
GROUP BY e.Fname 
Having COUNT(wf.pno) > 1

SELECT * FROM EmployeesMultipleProjectsView
--6.	Create a view that displays the average salary of employees in each department, along with the department name.

CREATE VIEW AvgSalaryDeptView AS 
SELECT d.Dname , AVG(e.Salary) as AverageSalary
FROM Departments d 
JOIN Employee e ON d.Dnum = e.Dno
GROUP BY d.Dname

SELECT * FROM AvgSalaryDeptView

--7.	Create a view that lists the names and age of employees and their dependents in a single result set. The age should be calculated based on the current date.

CREATE VIEW EmployeesDependentsAgeView AS
SELECT e.Fname , DATEDIFF (year , e.Bdate , GETDATE()) AS AGE
FROM Employee e 
UNION ALL 
SELECT de.Dependent_name, DATEDIFF(YEAR, de.Bdate, GETDATE()) AS Age
   FROM Dependent de;

   SELECT * FROM EmployeesDependentsAgeView

--8.	Create a view that displays the names of employees who have dependents, along with the number of dependents each employee has.

CREATE VIEW EmployeesDependentsCountView AS
SELECT e.Fname , COUNT(d.Dependent_name) as dependent_count
FROM Employee e 
JOIN Dependent d ON e.SSN = d.ESSN
GROUP BY e.Fname

SELECT * FROM EmployeesDependentsCountView

--9.	Create a new user defined data type named loc with the following Criteria:
--	nchar(2)
--	default: NY 
--	create a rule for this data type : values in (NY,DS,KW)) and associate it to 			the location column in new table named project2 with (name ,location)


-- Create the user-defined data type
CREATE TYPE loc FROM nchar(2) NOT NULL;
GO

Create Rule r2 AS @x in ('NY' , 'DS' , 'KW')
CREATE DEFAULT d1 as 'NY'
SP_bindefault d1 , loc
SP_bindrule r2 , loc 
-- Create the new table with the loc data type and CHECK constraint
CREATE TABLE project2 (
    name nvarchar(50) NOT NULL,
    location loc )



--10.	Create a view that displays the full name (first name and last name), salary, and the name of the department for employees working in the department with the highest average salary. 
CREATE VIEW HighestAvgSalaryDeptEmployeesView AS 
SELECT e.Fname+ ' '+ e.Lname AS Emp_name , e.Salary, d.Dname AS DepartmentName
FROM Employee e
JOIN Departments d ON e.Dno = d.Dnum
WHERE d.Dnum = (
    SELECT TOP 1 d_inner.Dnum
    FROM Departments d_inner
    JOIN Employee e_inner ON d_inner.Dnum = e_inner.Dno
    GROUP BY d_inner.Dnum, d_inner.Dname
    ORDER BY AVG(e_inner.Salary) DESC
);




--11.	Create a view that displays the names and salaries of employees who earn more than the average salary of their department.
    CREATE VIEW AboveAvgSalaryEmployeesView AS
    SELECT e.Fname, e.Lname, e.Salary
    FROM Employee e
    WHERE e.Salary > (
        SELECT AVG(Salary)
        FROM Employee em
        WHERE e.Dno = em.Dno
    );
