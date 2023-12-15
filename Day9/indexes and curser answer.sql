

-- Index

--1 Create an index on column (Hiredate) that allow u to cluster the data in the table Department. What will happen?  

create clustered index index3 
on department(Manager_hiredate)
SELECT * FROM Department

-- cannot create clusterd index on non_primary key columns after making a primary key column

create nonclustered index index4 
on department(Manager_hiredate)

--2 Create an index that allows you to enter unique ages in the student table. What will happen?

create unique index index5 
on student(st_Age)
SELECT * FROM Student 
-- unique index apply on old and new data in the column so we cannot create this index.

--3 create a non-clustered index on column(Dept_Manager) that allows you to enter a unique instructor id in the table Department. 

create nonclustered index index6
on department(Dept_Manager) 
 

select * from department
select * from Instructor

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cursor

--1 In ITI database Count times that amr apper after ahmed in student table in st_Fname column (using the cursor)  

SELECT * FROM Student

use ITI_new


declare c1 cursor 
for select st_fname from Student 
where St_Fname is not null 
for read only 
declare @fname varchar(20) , @lname varchar(20) = '' ,@counter int = 0 
open c1 
fetch c1 into @fname
while @@FETCH_STATUS=0
 begin 
 if (@fname ='Amr'and @lname = 'Ahmed')    
  set @counter+=1
 else 
  set @lname = @fname
   fetch c1 into @fname
end
select @counter 
close c1 
deallocate c1

select * from Student

--2 In Company_SD in employee table Check if Gender='M' add 'Mr Befor Employee name    
 -- else if Gender='F' add Mrs Befor Employee name  then display all names  
 -- use cursor for update
   

use Company_SD
go

select * from Employee


declare c1 cursor 
for select Gender from Employee 
where Fname is not null 
for update 

declare  @gender varchar(20)
open c1 
fetch c1 into @gender
while @@FETCH_STATUS = 0 
begin 
 if @gender = 'M'
  update Employee set Fname = CONCAT('MR ',Fname)
  where current of c1
 else 
  update Employee set Fname= CONCAT('MRS ',Fname)
  where current of c1

fetch c1 into @gender
end
close c1 
deallocate c1

select Fname from Employee



----------------------------------------------------------------------------------------------------------

declare c1 cursor 
for select Gender from Employee 
where Fname is not null 
for update 

declare  @gender varchar(20)
open c1 
fetch c1 into @gender
while @@FETCH_STATUS = 0 
begin 
 if @gender = 'M'
  update Employee set Fname = CONCAT('MR ',Fname)
  where current of c1
 else 
  update Employee set Fname= CONCAT('MRS ',Fname)
  where current of c1

fetch c1 into @gender
end
-- select Fname from Employee
close c1 
deallocate c1