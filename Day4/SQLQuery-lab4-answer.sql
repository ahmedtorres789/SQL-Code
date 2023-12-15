USE Company_SD
--1.	Display the name of the departments and the name of the projects under its control.
SELECT d.Dname, p.Pname
FROM departments d
Inner JOIN project p ON d.Dnum = p.Dnum;

--2.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT e.Fname, d.Dependent_name
FROM employee e
Right JOIN dependent d ON e.SSN = d.ESSN;


--3.	Display the Id, name and location of the projects in Cairo or Alex city.  

SELECT Pnumber, Pname, Plocation
FROM project
WHERE City IN ('Cairo', 'Alex');



--4.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM employee
WHERE Dno = 30
AND salary BETWEEN 1000 AND 2000;


--5.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
SELECT e.Fname
FROM employee e
INNER JOIN Works_for wf ON e.SSN = wf.ESSn
INNER JOIN project p ON wf.Pno = p.Pnumber
WHERE e.Dno = 10
AND p.Pname = 'AL Rabwah'
AND wf.Hours >= 10;

--6.	Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT e.Fname ,e.Lname
FROM Employee e JOIN Employee so 
ON e.Superssn = so.SSN
WHERE so.Fname= 'kamel' AND so.Lname= 'mohamed'



--7.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.

SELECT e.Fname, p.Pname
FROM employee e
INNER JOIN Works_for wf ON e.SSN = wf.ESSn
INNER JOIN project p ON wf.Pno = p.Pnumber
ORDER BY p.Pname;



--8. For each project located in Cairo City, find the project number, the controlling department name, the department manager last name, address, and birthdate.

SELECT p.Pnumber, d.Dname, dm.Lname, dm.address, dm.Bdate
FROM project p
INNER JOIN Departments d ON p.Dnum = d.Dnum
INNER JOIN employee dm ON d.MGRSSN = dm.SSN
WHERE p.Plocation = 'Cairo';

--9. Display All Data of the managers.

SELECT *
FROM employee
WHERE SSN IN (SELECT DISTINCT MGRSSN FROM departments);

--another solution 

SELECT *
FROM Employee e 
INNER JOIN Departments d ON e.SSN = d.MGRSSN


--10. Display All Employees' data and the data of their dependents, even if they have no dependents.
SELECT e.*, d.dependent_name
FROM employee e
LEFT JOIN dependent d ON e.SSN = d.ESSN;


--11. For each project, list the project name and the total hours per week (for all employees) spent on that project.

SELECT p.Pname, SUM(wf.Hours) AS total_hours_per_week
FROM project p
LEFT JOIN Works_for wf ON p.Pnumber = wf.Pno	
GROUP BY p.Pname;

--12. Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT d.*
FROM Departments d 
INNER JOIN Employee e ON e.Dno = d.Dnum
WHERE SSN = (SELECT MIN (SSN) FROM Employee)

--13. For each department, retrieve the department name and the maximum, minimum, and average salary of its employees.
SELECT d.Dname, MAX(e.salary) AS max_salary, MIN(e.salary) AS min_salary, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employee e ON d.Dnum = e.Dno
GROUP BY d.Dname;

--14. For each department, if its average salary is less than the average salary of all employees, display its number, name, and the number of its employees.
SELECT d.Dnum , d.Dname, COUNT (e.SSN)
FROM departments d
LEFT JOIN employee e ON d.Dnum = e.Dno
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (SELECT AVG(Salary) FROM Employee)

-- 15.	Try to get the max 2 salaries 
SELECT  TOP 2 salary
FROM employee
ORDER BY salary DESC;



Use ITI_new
--1.	Find total grade for student  in each department  
SELECT d.Dept_Name, s.St_Fname, SUM(c.grade) AS total_grade
FROM department d
INNER JOIN student s ON d.Dept_Id = s.Dept_Id
INNER JOIN Stud_Course c ON s.St_Id = c.St_Id
GROUP BY d.Dept_Name, s.St_Fname;


--2.	Find Highest Instructor Salary for each Instructor Degree

SELECT i.Ins_Degree, MAX(i.salary) AS highest_salary
FROM instructor i
GROUP BY i.Ins_Degree;


