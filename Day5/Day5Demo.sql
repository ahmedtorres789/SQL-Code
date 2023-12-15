










SELECT *
FROM Student s
WHERE s.St_Age < (SELECT AVG(St_Age) FROM Student s1)




---------------------------Subquery--------------------------------
--Select studeny info for students whose age< avg(age)
select *
from Student
where St_Age < (select AVG(st_age) from Student)


--(1,15)
select st_id , COUNT(St_Id)--,(SELECT COUNT(St_Id) FROM Student s) 
from Student 
GROUP BY st_id




--Find Dname for depts that has students (sub query)
SELECT * FROM Department d
WHERE d.Dept_Id IN 
(SELECT DISTINCT s.Dept_Id FROM Student s WHERE s.Dept_Id IS NOT NULL)




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
--For student who live in cairo

delete
from Stud_Course
where st_id=1

delete
from Stud_Course
where st_id in (select st_id from Student where St_Address='cairo')



---------------------------union family-------------------------------
--union all    union    intersect   except

---------------------------union family-------------------------------
--union all    union    intersect   except
--note unioned column must be same data type

select ins_name , Salary
from Instructor
UNION ALL 
select st_fname , St_Lname
from Student




select st_fname,st_id
from Student
union all
select ins_name,ins_id
from Instructor

select st_id
from Student
union all
select ins_name
from Instructor


select st_fname
from Student
union all
select ins_name
from Instructor
--union rearrage and delete duplicates
select st_fname
from Student
union 
select ins_name
from Instructor

select st_fname
from Student
intersect 
select ins_name
from Instructor

select st_fname
from Student
except 
select ins_name
from Instructor

select st_fname,st_id
from Student
intersect 
select ins_name,ins_id
from Instructor



--------------------------order by-----------------------------------------
--Select student info orderby St_fname

select s.*
from Student s
order by St_fname


--Select student info orderby n column in select
select s.St_Id , s.St_Fname , s.St_Age
from Student s
order by  2


--Select st_fname,st_age,dept_id order by St_adress

select s.St_Id ,  s.St_Age , Dept_Id
from Student s
order by  s.St_Address


--Select st_fname,st_age,dept_id order by dept_id ,st_age 
select s.St_Id ,  s.St_Age , Dept_Id
from Student s
order by St_Id ,st_age 


--------------------------------Top----------------------------
--Select info for first 3 student
select top(3)*
from Student




--Select fname for first 3 student 

select top(3)St_Fname
from Student


SELECT TOP(1) i.Salary
FROM Instructor i
ORDER BY i.Salary DESC


SELECT MAX(i.Salary)
FROM Instructor i










--Select fname for first 3 student who live in alex
select top(3)St_Fname
from Student
where St_Address='alex'





--Select first 3 salary
select top(3)Salary
from Instructor






--Select Top 3 Salary 
select top(3) Salary
from Instructor
order by Salary desc 



--Select Top 3 ages 
select top(3) s.St_Age
from Student s
order by s.St_Age desc 



--Select Top 7 ages --with ties
select top(5) with ties s.St_Age 
from Student s
order by s.St_Age desc 





--newID()   GUID

select NEWID()

--Select newid for each student 
select *  , NEWID()
from Student
ORDER BY NEWID()



