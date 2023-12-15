USE ITI_new
-- Cross join 
-- select St_Fname and thier Dept_Name


SELECT s.St_Fname , d.Dept_Name
FROM Student s , Department d












--------------------------Inner join=Equi joins------------------------
--Find Student names and their Departments name

SELECT s.St_Fname , d.Dept_Name
FROM Student s , Department d
WHERE  d.Dept_Id = s.Dept_Id 















--another way using microsoft syntax

SELECT s.St_Fname , d.Dept_Name
FROM Student s INNER JOIN Department d
on  d.Dept_Id = s.Dept_Id 














--Find Student names and their Departments name and Dept_Id

SELECT s.St_Fname , d.Dept_Name , d.Dept_Id
FROM Student s INNER JOIN Department d
on  d.Dept_Id = s.Dept_Id 

SELECT s.St_Fname , d.Dept_Name
FROM Student s , Department d
WHERE  d.Dept_Id = s.Dept_Id AND s.St_Address = 'cairo'







--Find Students Name and department info

SELECT s.St_Fname , D.*
FROM Student s INNER JOIN Department d
on  d.Dept_Id = s.Dept_Id 











--Find Students name and thier Dept_Name who live in cairo
SELECT s.St_Fname , d.Dept_Name , s.St_Address
FROM Student s INNER JOIN Department d
on  d.Dept_Id = s.Dept_Id 
WHERE s.St_Address = 'cairo'






--Find Student names and thier department even they have 
--department or not 

SELECT s.St_Fname , d.Dept_Name
FROM Student s LEFT OUTER JOIN Department d
ON d.Dept_Id = s.Dept_Id






--Find student names and department names even department
--has students or not

SELECT s.St_Fname , d.Dept_Name
FROM Student s RIGHT OUTER JOIN Department d
ON d.Dept_Id = s.Dept_Id





--Find Student name and their leaders name

SELECT s.St_Fname AS StdName , L.St_Fname AS LeaderName
FROM Student l , Student s
WHERE s.St_super = l.St_Id 






----Find Student name and their leaders Information
SELECT s.St_Fname AS StdName , L.St_Fname AS LeaderName
FROM Student l , Student s
WHERE s.St_super = l.St_Id 









--Find Student names and their courses and course grades

SELECT s.St_Fname , c.Crs_Name , sc.Grade
FROM Student s , Stud_Course sc , Course c
WHERE s.St_Id = sc.St_Id AND c.Crs_Id = sc.Crs_Id

-----
SELECT  s.St_Fname , c.Crs_Name , sc.Grade
FROM Student s INNER JOIN Stud_Course sc
ON s.St_Id = sc.St_Id
INNER JOIN Course c 
ON c.Crs_Id =  sc.Crs_Id






--Find Student names and Department name 
--and their courses and course grades













--Find Student names and Department name 
--and their courses and course grades










----------------------------Joins with DML----------------------------
--Joins with Update
--Increase grade 10 marks for cairo students
select * from Student
select * from Course
select * from Stud_Course


UPDATE sc
SET Grade +=10
--SELECT s.St_Id , s.St_Fname , sc.Grade
FROM Student s , Stud_Course sc
WHERE s.St_Id = sc.St_Id AND s.St_Address  = 'cairo'







--Joins with Insert

--Write query that insert student Id , Std_Name , Grade in 
--Top student table For top student 
create table TopStudent
(
Id int ,
Std_Name varchar(20),
Grade int
)
INSERT INTO TopStudent
SELECT s.St_Id , s.St_Fname , sc.Grade
FROM Student s , Stud_Course sc
WHERE s.St_Id = sc.St_Id AND sc.Grade>100

SELECT * FROM TopStudent ts




----------------------------Joins with DML----------------------------
--Joins with Update
--Increase grade 10 marks for cairo students





update Stud_Course 
set Grade +=10
from Student s , Stud_Course sc 
where s.St_Id = sc.St_Id and s.St_Address='cairo'

select * from Student
select * from Course
select * from Stud_Course
--------------------------Rewrite Queries----------------
--Joins with Insert
create table TopStudent
(
Std_Name varchar(20),
Id int ,

Grade int
)

INSERT INTO TopStudent (ID  , Std_Name ,  Grade) 
SELECT  s.St_Id , s.St_Fname , sc.Grade
FROM Student s , Stud_Course sc
where s.St_Id = sc.St_Id and sc.Grade > 80

select * from TopStudent
select * from Stud_Course

--Joins with Delete




DELETE s
FROM Student s , Stud_Course sc 
WHERE s.St_Id = sc.St_Id AND sc.Grade <75

SELECT * FROM Stud_Course
-------------------Talk about PK_FK moodes and constraint-------------




--Find Sum of instructors salary



--Find Max and Min Salary for instructor 
--Find Sum of instructors salary



--Count Students -- use * , columns




--Find avg student ages





--Find Sum of salary for each department 





--Find Sum of salary for each department , did , dname 







--Find avg age for student per city per dept_id






--Explore Result
select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id





--Find Sum salary for each department 
--If Department sum slary>4000

select sum(salary),dept_id
from Instructor
group by dept_id
having sum(salary) >4000






--EX
select sum(salary),dept_id
from Instructor
group by dept_id
having Count(ins_id)<6





--EX2
select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id
having Count(ins_id)<6


---------------------------Subquery--------------------------------
--Select studeny info for students whose age< avg(age)
select *
from Student
where St_Age < (select AVG(st_age) from Student)


--(1,15)
select st_id, (select count(st_id) from Student)
from Student 

--Find Dname for depts that has students (sub query)

select d.Dept_Name
from Department d
where d.Dept_Id in (
select distinct  Dept_Id
from Student
where Dept_Id is not null
)

--Find Dname for depts that has students (join)

select d.Dept_Name
from Department d
where d.Dept_Id in (
select distinct  Dept_Id
from Student
where Dept_Id is not null
)

select distinct d.Dept_Name
from Student s , Department d 
where d.Dept_Id = s.Dept_Id and s.Dept_Id is not null


-------------------------Subquery  +  DML----------------------------
--Delete student grades (studentCourse )
--For student who lives in cairo



select salary
from Instructor

--Find Sum of instructors salary
select Sum(salary) AS tttt
from Instructor

--Find Max and Min Salary for instructor 
select Min(Salary) as Min_Val,Max(Salary) as Max_val
from Instructor

--Count Students
select count(*),count(st_id),count(st_lname),count(st_age)
from Student

select *
from Student

select avg(st_age)
from Student

select sum(st_age)/count(*)
from Student



select avg(isnull(st_age,0))
from Student



select sum(st_age)/count(*)
from Student



select sum(salary),dept_id
from Instructor
group by dept_id






select sum(salary),d.dept_id,dept_name
from Instructor i inner join Department d
on d.Dept_Id=i.Dept_Id
group by d.dept_id , dept_name







select avg(st_age),st_address,dept_id
from Student
group by st_address,dept_id
ORDER BY St_Address



select sum(salary),dept_id
from Instructor
--where salary>1000
group by dept_id



select sum(salary),dept_id
from Instructor
group by dept_id



select sum(salary),dept_id
from Instructor
group by dept_id
having sum(salary)>=13500





select sum(salary) , COUNT(Ins_Id),dept_id
from Instructor
group by dept_id
having Count(ins_id)<6





select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id
having Count(ins_id)<6









