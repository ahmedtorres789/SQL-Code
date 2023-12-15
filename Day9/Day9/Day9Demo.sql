--------------------------Cursor----------------------------
 --Create cursor that view student info for alex student 

 DECLARE c1 CURSOR 
 FOR 
    SELECT st_id , St_fname
	 FROM Student
	 WHERE St_Address = 'alex'
	FOR READ ONLY 
	 DECLARE @id INT , @name VARCHAR(100)
	 OPEN c1 
	 FETCH c1 INTO @id , @name
	 @@fetchSt













-----------------------------------------------------
--Write cursor query that show student names in one cell
USE iti_new
--[ahmed , amr , mona,.............]

declare c1 cursor
for 
    select ST_Fname 
	from Student
	where St_Fname is not null

declare @fname varchar(10) , @allnames varchar(500)=''
open c1

fetch c1 into @fname
while @@FETCH_STATUS=0
BEGIN
IF (@allnames IS NULL OR LEN(@allnames) = 0)
    SET @allnames = @fname
ELSE
BEGIN
   set @allnames = @allnames + ' , ' + @fname
   END
   fetch c1 into @fname
end
select @allnames
close c1
deallocate c1 

--Write a cursor that update instructors salary if salary >3000 
--increase it by 20%
--Else increase it by 10%
declare c1 cursor 
for
   select Salary
   from Employee
for update 

declare @sal int 

open c1
fetch c1 into @sal

while @@FETCH_STATUS=0
begin 
    if (@sal >300)
	   update Employee Set Salary= Salary *1.3
	   where current of c1 
     
	 else 
	    update Employee Set Salary= Salary *1.1
		where current of c1 

		fetch c1 into @sal
end

close c1
deallocate c1 
-----------------------------Students Task----------------------------
--Count times that amr apper after ahmed in srudent table 
--ahmed then amr
Select * from student 
insert into student values (16 , 'Ahmed' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (17 , 'Amr' , 'Mohmaed' , 'Cairo' , 20 , 20 , NULL)
insert into student values (18 , 'Test' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)

insert into student values (18 , 'Ahmed' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (19 , 'Test' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (20 , 'Amr' , 'Mohmaed' , 'Cairo' , 20 , 20 , NULL)


declare c1 cursor 
for
   select St_Fname 
   from [dbo].[Student]
   
for read only
declare @Fanme varchar(20) , @counter int =0

open c1
fetch c1 into @Fanme

while @@FETCH_STATUS=0
begin 
if (@Fanme ='ahmed')
  begin 
   Fetch C1 into @Fanme   
   if(@Fanme = 'amr')
   set @counter+=1
  end
 Fetch C1 into @Fanme   

end 
select @counter

close c1
deallocate c1




--------------------------------------Clustered Index-----------------------------------------
create table stud
(
id int primary key,
sname nvarchar(50),
sal int,
age int
)

--indexing affect with the existing data
insert into stud(id) values (2)
insert into stud(id) values (1)
insert into stud(id,sal) values (3,100)
insert into stud(id,sal) values (5,50)

select * into studNewTable
from stud

select * from studNewTable where id=3
select * from stud where id=3

--Create clustered on Sal in table Student 
create clustered index cindex
	on stud(sal)

--Create nonclustered on Sal in table Student 
create nonclustered index cindex
	on stud(sal)

--Create uniqe index(nonClustered) not Unique is a constraint
--that executed in old and new data 
create unique index uni_index  
on stud(sal)

drop index stud.cindex



--------------------------Indexed View -----------------
alter view VCairo
with schemabinding
as
select  s.St_Fname ,St_Address
from dbo.Student s
where St_Address= 'cairo'

create  unique CLUSTERED index VCairoindex  
on VCairo(St_Fname)

SELECT * FROM VCairo v
WHERE v.St_Fname ='ahmed'


drop table dbo.Student

select * from VCairo WITH (NOEXPAND) where St_Fname='ahmed'
------------------SQL sever profiler and tuning advisor---------------




