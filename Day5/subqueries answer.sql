USE ITI_new

--1.	Simple Subquery: Write a query to find all courses with a duration longer than the average course duration.
SELECT * 
FROM course
WHERE Crs_Duration > (SELECT AVG(Crs_Duration) FROM course);



--2.	Correlated Subquery: Find the names of students who are older than the average age of students in their department.

SELECT s.St_Fname 
FROM student s 
WHERE s.St_Age > (SELECT AVG(St_Age) FROM student i WHERE i.Dept_Id = s.Dept_Id);

-- 3.	Subquery in FROM Clause: Create a list of departments and the number of instructors in each, using a subquery.

SELECT d.Dept_Name, COUNT(i.Ins_Id) AS number_of_instructors
FROM department d
JOIN (SELECT Dept_Id, Ins_Id FROM instructor) i ON d.Dept_Id = i.Dept_Id
GROUP BY d.Dept_Name;


--4.	Subquery in SELECT Clause: For each student, display their name and the number of courses they are enrolled in.

SELECT s.St_Fname, (SELECT COUNT(Crs_Id) FROM Stud_Course c WHERE c.St_Id = s.St_Id) AS CourseCount
FROM student s;

--5.	Multiple Subqueries: Find the name and salary of the instructor who earns more than the average salary of their department

SELECT i.Ins_Name, i.salary
FROM instructor i
WHERE i.salary > (SELECT AVG(salary) FROM instructor s WHERE s.Dept_Id = i.Dept_Id);


--6.	UNION: Combine the names of all students and instructors into a single list.
SELECT St_Fname FROM student
UNION
SELECT Ins_Name FROM instructor;


--7.	UNION with Condition: Create a list of courses that either have a duration longer than 50 hours or are taught by an instructor named 'Ahmed'.

SELECT Crs_Name, Crs_Duration
FROM Course
WHERE Crs_Duration > 50

UNION

SELECT c.Crs_Name, c.Crs_Duration
FROM Course c
JOIN Ins_Course ic ON ic.Crs_Id = c.Crs_Id
JOIN Instructor i ON ic.Ins_Id = i.Ins_Id
WHERE i.Ins_Name = 'Ahmed';




--8.	Subquery with EXISTS: List all departments that have at least one course with a duration over 60 hours.

SELECT * 
FROM department d
WHERE EXISTS (SELECT i.* FROM Instructor i 
join Ins_Course ss on ss.Ins_Id = i.Ins_Id
join Course c on c.Crs_Id = ss.Crs_Id
AND c.Crs_Duration > 60
where i.Dept_Id = d.Dept_Id
);


--9.	Nested Subqueries: Display the names of students who are taking courses in the same department they belong to.
SELECT  s.St_Fname, s.Dept_Id
FROM Student s
WHERE s.Dept_Id in (
    SELECT d.Dept_Id
    FROM Department d
    JOIN Instructor i ON d.Dept_Id = i.Dept_Id
    JOIN Ins_Course ic ON i.Ins_Id = ic.Ins_Id
    JOIN Stud_Course sc ON s.St_Id = sc.St_Id
    WHERE s.Dept_Id = d.Dept_Id
);

--10.	TOP Clause: Select the top 5 highest-graded students in the 'SQL Server' course.

SELECT TOP 5 s.St_Fname, g.Grade
FROM student s
JOIN Stud_Course g ON s.St_Id = g.St_Id
JOIN Course c ON g.Crs_Id = c.Crs_Id
WHERE c.Crs_Name = 'SQL Server'
ORDER BY g.grade DESC;

--11.	TOP with Ties: Show the top 3 departments with the most courses, including ties.
SELECT TOP (3) WITH TIES d.Dept_Name ,d.Dept_Id , COUNT(c.Crs_Id) as no_of_courses
from Department d
Join Instructor I on i.Dept_Id = d.Dept_Id
Join Ins_Course ss on ss.Ins_Id = I.Ins_Id
join course c on c.Crs_Id = ss.Crs_Id
group by d.Dept_Id , d.Dept_Name 
ORDER BY  COUNT (c.Crs_Id) desc ;


--12.	Subquery with IN: Find all students who are enrolled in 'C Programming' or 'Java'.

SELECT s.St_Fname
FROM student s
JOIN Stud_Course sc ON s.St_Id = sc.St_Id
WHERE sc.Crs_Id IN (SELECT Crs_Id FROM course WHERE Crs_Name IN ('C Programming', 'Java'));


-- 13.	Complex UNION: Create a list of all courses and instructors, showing course names and instructor names in separate columns.
SELECT c.Crs_Name , NULL AS instructor_name FROM course c
UNION ALL
SELECT NULL, i.Ins_Name FROM instructor i;


--14.	Subquery in WHERE Clause: Identify students who are taking courses that are longer than the average duration of all courses.
SELECT s.St_Fname
FROM student s
JOIN Stud_Course e ON s.St_Id = e.St_Id
JOIN course c ON e.Crs_Id = c.Crs_Id
WHERE c.Crs_Duration > (SELECT AVG(cc.Crs_Duration) FROM course cc);


--15.	Combining TOP and Subquery: Display the top 10% of courses based on the number of students enrolled.

SELECT TOP 10 Percent c.Crs_Name, COUNT(e.St_Id) AS student_count
FROM course c
JOIN Stud_Course e ON c.Crs_Id = e.Crs_Id
GROUP BY c.Crs_Name
ORDER BY student_count DESC;




