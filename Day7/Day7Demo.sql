-----------------------Make top dynamic using var----------------------
--Find top n students 
DECLARE @n INT =4
select top(@n)*
from Student 
order by St_Age desc



-------------------------------
DECLARE @tabname VARCHAR(50)= '[dbo].[Instructor]' , @colname varchar(50) = '[Ins_Name]'
--SELECT @colname FROM @tabname

EXEC ( 'select '+@colname + ' from '+@tabname )





-----------------------------Dynamic query-----------------------------
declare @col varchar(10) ='Ins_Name' , @tab varchar(10)='instructor'
select @col from @tab


declare @col varchar(10) ='Ins_Name' , @tab varchar(10)='instructor'
execute('select '+@col+' from '+ @tab)

-----------------------------Globle var----------------------
select @@SERVERNAME
select @@VERSION

update Student 
set St_Age+=1

select @@ROWCOUNT

select @@ROWCOUNT

select * from stuhdkf
go 
select @@ERROR 

create table t1
(
id int identity (1 , 4),
name varchar(10)
)



insert into t1 values('DDDD')
--select * from t1
select @@IDENTITY














-------------------------------Contarl flow ---------------------------
--if , else 
--begin end
--if exists , if not exists
--while , continue , break 
--case
--iif
--waitfor
--Choose 



------------------------IF , else-----------------------------
DECLARE @x INT 
UPDATE Student 
SET St_Age+=1
WHERE St_Address = 'cairo'
SELECT @x = @@rowcount


IF @x > 1 
BEGIN
  SELECT 'Multi rows affected'
  PRINT 'Multi rows affected'
END
ELSE IF @x = 1
BEGIN
	 SELECT 'one rows affected'
END
ELSE 
 SELECT 'no rows affected'








declare @x int 
update Student 
set St_Age+=1
select @x= @@ROWCOUNT
if @x >0
   begin 
   select 'multi rows affected'
   end
else 
    begin 
	select 'no rows affected'
	end 

------------------------------if exists-------------------------------

if exists (select * from sys.tables where name='std2')
       select 'Table exicted'
else
create table std2
(
id int
)







-------------------------while 




declare @x int =10
while @x<=20
	begin  
	     set @x+=1
		 if(@x=14)
		  continue 
		  if(@x=16)
		  break
		  select @x
	end


	-- Declare a table variable to store the results
DECLARE @Results TABLE (ResultValue INT)

DECLARE @x INT = 10
WHILE @x <= 20
BEGIN
    SET @x += 1
    
    IF @x = 14
        CONTINUE
    
    IF @x = 16
        BREAK
    
    INSERT INTO @Results (ResultValue) VALUES (@x)
END

-- Select and union the results
SELECT ResultValue
FROM @Results


--------------------------Case---------------------------
Case 
    when Cond  then Res
	when Cond2  then Res
	else Res
end

DECLARE @id INT = 4 , @age INT , @msg VARCHAR(200)

SELECT @age = St_age FROM Student s WHERE s.St_Id = @id

SET @msg =  case 
            when @age>20 and @age<=30 then 'you can apply'
            when @age >30 then 'Sorry you cannot apply'
            when @age<20 then 'wait until 20 '
           -- else 'not allowed'
        END
SELECT @msg

SELECT Student.St_Age from Student where St_Id = 4

------------------------ iif ------------------
--iif(condition , value if true , value if false)



select s.St_Id , s.St_Fname, s.St_Age ,
       iif(s.St_Age >30 , 'you can not applay' , 'welcome') AS status
from Student  s






------------------------------Wait for
-- Delay the process by 20 seconds:
WAITFOR DELAY '00:00:20';
GO
select * from student


-- Delay the process until 6:15 PM
WAITFOR TIME '18:15:00';
Go
select * from student


---------------------------------------------------------------
--Batch
select * from Student
select * from Student where St_Id=1


--Script 

create rule r5 as @x>100
go
sp_bindrule r5 , 'instructor.Salary'














--Transaction
select 
update
delete 


Create table parent1 (pid int primary key)
Create table Child1 (cid int foreign key references parent1(pid))







insert into parent1 values(1)
insert into parent1 values(2)
insert into parent1 values(3)
insert into parent1 values(4)


insert into Child1 values(1)
insert into Child1 values(2)
insert into Child1 values(3)
insert into Child1 values(11)
TRUNCATE TABLE Child1
SELECT * FROM Child1

begin try
 begin transaction
   insert into Child1 values(1)
   insert into Child1 values(2)
   insert into Child1 values(77)
   insert into Child1 values(4)
  commit 
end try

begin catch
select ERROR_NUMBER() AS ErrorNumber,
       ERROR_STATE() AS ErrorState,
       ERROR_LINE() AS ErrorLine,
       ERROR_MESSAGE() AS ErrorMessage;
rollback
end catch

select * from Child1

truncate table Child1




insert into Child1 values(1),(2),(77)














update student 
set St_Age=1

------------------
select Coalesce(s.St_Fname , s.St_Lname ,  'NO DATA Found' )
from Student s







select * from Student
select nullif('ss','Hello')

select Coalesce( s.St_Fname , s.St_lname , 'ffffff')
from Student s


select max(len( St_Fname))
from Student

select power(Salary,2)
from Instructor

select top(1) St_Fname 
from Student
order by len(st_fname) desc

select upper(St_fname) , lower(St_Lname)
from student

select convert (varchar(20) , getdate() ,102)









select format (getdate(), 'dd:MMMM:yyyy , hh:mm:ss')






select DB_NAME() , SUSER_NAME()
----------------------------Custom Functions--------------------------------
--Notes
--1- Any function has retrun 
--2- we write select only inside it 


-------------------------------Scaler----------------------------
--Make a function that take student id and return name 
--string GetStudentName (int)

create function GetStudentName(@id int)
returns varchar(50)
  begin 
    DECLARE @name varchar(50)
    SELECT @name = St_Fname FROM Student s WHERE s.St_Id = @id
	RETURN @name
  end 

  SELECT dbo.GetStudentName(4) 




  select dbo.GetStudentName(3)

----------------------------------inline-------------------------------
--Return Table 
--We us it if function body selects only  

--Write a function that take department id and retrun
--Department instrctors name and their anniual salary

create OR alter function GetinsInfo(@did int)
returns table
as 
return 
(
SELECT i.Ins_Name , i.Salary*12 AS AnnSalary 
FROM Instructor i 
WHERE i.Dept_Id = @did

)
SELECT * INTO sgtdrtg
FROM GetinsInfo(10)

SELECT * FROM sgtdrtg




select * from GetinsInfo(10)











-----------------------------------multi ------------------------------
--Return table 
--We us it if function body selects + if , while or any logic 

--Write function that take formate from user
--If format= 'first' select id and Fname 
--If format ='last' select id and Lname
--If format ='full' select id and Fname + Lname 
create function GetStudents(@format varchar(10))
returns @t table (id int , ename varchar(30))
as
 BEGIN
    IF @format = 'first'
	BEGIN
	  INSERT INTO @t 
	  SELECT St_Id , St_Fname 
	  FROM Student s
	END
	ELSE IF @format = 'last'
	BEGIN
	  INSERT INTO @t 
	  SELECT St_Id , St_Lname 
	  FROM Student s
	END
	ELSE 
	BEGIN
	  INSERT INTO @t 
	  SELECT St_Id , st_fname + ' ' +St_Lname 
	  FROM Student s
	END

	  return 
 end

 SELECT * FROM GetStudents('first')


 select * from GetStudents('')

