

--Stored Proc Advantages
--1-It can be easily modified without need to redeploy app 
--2-Reduce Netowrk traffic
--3-Security
--4-Take params
--5-Increase Preformance 
--6-We can write any bussiness logic in it 
--7-Prevent Server Errors
--8-Hide Bussiness Rules





--3 types of SP
--1) built in SP
	sp_bindrule r1 , 'TableName.ColumnName'
	sp_unbindrule
	sp_helpconstraint 'Student'
	sp_addtype
	sp_helptext
	 
--2) User Defined SP

--Creat Proc that Display all Students
create proc Getst 
as
	select *
	from Student

 Getst



--Call stored
--1-
    Getst 
--2-
   execute Getst


--Create Proc that Take address and return 
--Students Info in that address

CREATE PROC GetStdInf @address VARCHAR(30)
AS 
SELECT s.St_Id , s.St_Fname
FROM Student s
WHERE s.St_Address = @address

GetStdInf 'cairo'




	
------------------------Stored With DML------------------------------
--Write Stored that Insert values in students table 
--Note Prevent server error that came from DML Queries

insert into Student(st_id,st_fname)
values(663,'ali')

CREATE OR ALTER proc InstStd @id INT , @name VARCHAR(20)
AS
 BEGIN TRY
 INSERT INTO Student(St_Id , St_Fname) VALUES(@Id , @name)
END TRY
BEGIN CATCH
SELECT 'error'
SELECT ERROR_MESSAGE()
END CATCH




 InstStd 1 , 'ali'








InstStd 44,'ali'
	
--Create Proc that take two int and print sum

CREATE OR ALTER  proc Sumdata @x INT= 100 ,@y INT = 101  -- with default value
as
	Select @x+@y
		
Sumdata 


Sumdata 3,5         ---Pass parameter by position 



Sumdata @y=9,@x=4   -- Pass parameter by Name



Sumdata @y=3

Sumdata




--Write Proc that take two ages and return student info who's age
--Match that range

CREATE OR ALTER PROCEDURE StdAgeInfo @age1 INT , @age2 INT
as
SELECT s.St_Id , s.St_Fname
FROM Student s
WHERE s.St_Age BETWEEN @age1 AND @age2

DECLARE @t TABLE(id INT , name VARCHAR(50))
INSERT INTO @t
EXECUTE StdAgeInfo  20 , 30
SELECT * FROM @t



create proc GetStbyAge @age1 int,@age2 int
AS
	select st_id,st_fname
	from Student
	where st_age between @age1 and @age2

-----------------------------insert based on execute--------------------------

declare @t table(ID int , Sname varchar(20))
insert into @t
execute GetstbyAge  23,28
Select * from @t

------------------------------Stored with return------------------------------ 












---Proc takes id and return age 
create Proc GetStdAge @id int
AS
DECLARE @age INT 
 SELECT @age = s.St_Age
 FROM Student s
 WHERE s.St_Id = @Id
 RETURN @age

 DECLARE @test INT 
 EXECUTE @test = GetStdAge 3
 SELECT @test




 CREATE OR ALTER Proc GetStdName @id int
AS
DECLARE @name VARCHAR(50) 
 SELECT @name = s.St_Fname
 FROM Student s
 WHERE s.St_Id = @Id
 RETURN @name

 GetStdName 3









--------------------Save return value in var----------------------------
declare @x int
execute @x= GetStdAge 3
select @x


--Create Proc that take student id Return Student name 
create Proc GetStdName @id int
as
	declare @name varchar(10)
		Select @name=St_Fname
		from Student
		where st_id=@id
	return @name

declare @name varchar(10)
exec @name =GetStdName   1
select @name

---------------------------------

CREATE OR alter proc GetStdAge @id INT
AS
BEGIN
    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Student WHERE st_id = @id)
    BEGIN
        RETURN -1  -- Return -1 if the student does not exist
    END

  ELSE  
  BEGIN
    SELECT St_Fname FROM Student WHERE st_id = @id
   
    RETURN 0  -- Return 0 to indicate success
	END
END




SELECT * FROM Student WHERE st_id = 10 
---------

  GetStdAge @id = 10  






--Note stored has two types of parameters 
--Input 
--Output



CREATE OR ALTER Proc Getdata @id INT OUTPUT, @name VARCHAR(20) OUTPUT
as
	Select @name =St_Fname
	from Student
	where st_id=@Id
	SET @Id = @Id +5

DECLARE @nameTest VARCHAR(20)  ,@idTest INT  = 5

EXECUTE Getdata @idTest OUTPUT , @nameTest OUTPUT

SELECT @nameTest , @idTest




declare @name varchar(10)
execute Getdata 3,@name output
select @name

--Return more than one value (age , name) using Output
--Create proc that take student id and return student name , age  

Create Proc Getdata @id int,@age int output,@name varchar(20) output
as
	Select @age=st_age,@name=st_fname
	from Student
	where st_id=@id
		
declare @x int,@y varchar(20)
execute Getdata 6,@x output,@y output
select @x,@y








-------------------------------------- Security -----------------------------------
sp_helptext 'Getdata'

alter Proc Getdata @id int,@age int output,@name varchar(20) output
with encryption
as
	Select @age=st_age,@name=st_fname
	from Student
	where st_id=@id

sp_helptext 'Getdata'

------------------------------ Input / Output ----------------------------
--Create proc that take student id and return student name , age  

Create Proc Getmydata @varInOut int output,@name varchar(20) output
with encryption
as
	Select @varInOut=st_age,@name=st_fname
	from Student
	where st_id=@varInOut
		
declare @x int=6,@y varchar(20)
execute Getmydata @x output,@y output
select @x,@y



CREATE OR ALTER PROC getStdData @tablename VARCHAR(20)
AS 
 EXECUTE ('select * from '+@tablename )


 getStdData 'studentjjg'



--IS it avilable to write execute in functions ????
--No because function accept select only inside it 
--but execute not garantee if it's contain
--select only or not 


--Here thier are no benefits from stored 
--Because we pass with all steps for running query 
--Each time we run stored

create proc updateStdSuper @Id int , @superId int
as
  execute('update student set St_super='+@superId+' where '+@Id)

updateStd 6,4




-------------------------------------------------------------------
--3)Trigger
----It's a special type or Sored Proc
--Can't call
--can't Send parameter
--triggers  on Table
--Listen to (insert update delete)

---------------------------------DML triggers-------------------------------- 
--Creat Trigger that print welcome Message after insert in student table

CREATE  TRIGGER t3 
ON Student 
AFTER INSERT
AS 
  SELECT 'Welcome to iti'

 INSERT INTO Student (St_Id , St_Fname )VALUES(333, 'ddd')








create trigger t11
on student
after insert
as
	select 'welcome to ITI'

--Trigger fire after insert
insert into Student(st_id,st_fname)
values(79,'ali')

--Create trigger that Get date of update

CREATE TRIGGER t2 
ON Student
AFTER UPDATE
AS 
SELECT GETDATE()

UPDATE Student SET St_Lname='kkk' WHERE St_Id=333








create trigger t20
on student
after update   --for
as
	select getdate()



update Student
	set st_age+=1

--Trigger prevent users from delete from table student 
-- and show massege not allowed for user + suser_name()

CREATE TRIGGER t44 
ON Student
INSTEAD OF DELETE 
AS 
SELECT 'not allowed for user '+ suser_name()

DELETE FROM Student WHERE St_Id= 333












create trigger t3
on student
instead of delete
as
	select 'Not allowed for user= '+suser_name()

--test
delete from Student where st_id=779


--How can i make table read only 
--if i prevent insert , update , delete

CREATE TRIGGER t4 
ON Instructor 
INSTEAD OF UPDATE , INSERT , DELETE
AS 
  SELECT 'Edit Not allowed '


  DELETE FROM Instructor
  SELECT * FROM Instructor i




create trigger t4
on department
instead of insert,update,delete
as
	select 'not allowed'

--Test
update Department
	Set dept_name='Cloud'
where Dept_Id=5000

--Trigger autommatically take schema for Data base object
-- that Trigger created in it 

CREATE SCHEMA test

ALTER SCHEMA dbo TRANSFER test.Course

alter TRIGGER test.t6 
ON test.Course
AFTER INSERT
as
SELECT 'new course addded  gdgxdhgcdhg'









--Create trigger that say hi if any one update student Fname

create  schema STDT
go
alter schema dbo transfer STD.Student 

alter trigger STD.t9
on STD.student
after update
as
	if update(St_Fname)
		select 'hi'

--Test
update STD.student
	set St_Fname='ahmed'
where St_id=7


--How can we know data after delete it or update it
 












--Create Trigger that select old and new data after update 
--any column in Student table 

CREATE OR ALTER TRIGGER t33
ON Student
AFTER INSERT 
AS 
   SELECT * FROM INSERTED
   SELECT * FROM DELETED

INSERT INTO Student (St_Id , St_Fname) VALUES(3440 , 'ddd')












create trigger t8
on course
after update
as
	select * from inserted
	select * from deleted





update course
	set crs_name='html5',crs_duration=40,top_id=1
where crs_id=900

--Create trigger that print student name that you deleted




CREATE TRIGGER t10
ON Student
AFTER DELETE
AS
 SELECT St_Fname
 FROM DELETED


 DELETE FROM Student WHERE St_Id = 333






delete from Topic
where Top_Id=2

--Create trigger that print course name that you updated

create trigger t8
on course
after update
as
	select crs_name from deleted


update course
	set crs_name='Cloud',crs_duration=45
where crs_id=300

--Cretate trigger that prevent user from delete any course in monday
--and show user that tried to update 

CREATE TRIGGER t11
ON Course
AFTER DELETE
AS
IF(FORMAT(GETDATE() , 'dddd') = 'monday')
  BEGIN
   INSERT INTO Course
  SELECT * FROM DELETED
  -- rollback
  END
  
  DELETE FROM Course WHERE Crs_Id= 1300

  SELECT * FROM Course c










alter trigger t9
on course
instead of delete
as
	if format(getdate(),'dddd')='wednesday'	
		begin
			select 'not delete'
		
			insert into course
			select * from deleted
		end

insert into Course (Crs_Id , Crs_Name , Crs_Duration)
values (1300 , 'DB' , 48)

delete Course where Crs_Id = 1300

select * from Course













----------------------------Audit tables --------------------------------

--Create trigger that audit name for user excute update on 
--On top_id  and date of execution , old and new value 









CREATE TABLE history
(
NewTopId INT , 
OldTopId INT , 
UpdatDate DATE , 
UserName VARCHAR(500)
)

CREATE TRIGGER t12 
ON Topic 
AFTER UPDATE
AS
 IF UPDATE(Top_Id)
  BEGIN
  DECLARE @oldid INT , @newid INT 
  SELECT @newid = Top_Id FROM INSERTED
  SELECT @oldid = Top_Id FROM DELETED

  INSERT INTO history VALUES(@newid , @oldid , GETDATE() , SUSER_NAME())
  END

  UPDATE Topic SET Top_Id = 8
  WHERE Top_Id = 6
  SELECT * FROM history h











create trigger t11
on Topic
instead of update
as 
	if update(Top_Id)
		begin
			   declare @new int,@old int
		       select @old=Top_Id from deleted
			   select @new=Top_Id from inserted
			   insert into history
			   values(suser_name(),getdate(), @old, @new)
		end

		update Topic set Top_id= 10 where Top_Id=3

select * from history
---------------------------disable/enable Trigger------------------------
alter table department disable trigger t4
alter table department enable trigger t4
-------------------------------Drop DML trigger---------------------------

drop trigger t5

---------------------------------  DDL  -------------------------------






create trigger t15
on database
for drop_table 
as 
select'Not allowd'
ROLLBACK

CREATE TABLE tt(id int)

DROP TABLE tt

SELECT * FROM tt




drop table emp

select * from emp

------------------------------enable / disable Trigger-----------------------
ENABLE TRIGGER t5 ON DATABASE
GO
DISABLE TRIGGER t5 ON DATABASE
GO
----------------------enable / disable all Triggers in table------------------
ENABLE TRIGGER ALL ON TableNAme
DISABLE TRIGGER ALL ON topic








--------------------------------Drop DDL trigger------------------------------

DROP TRIGGER t5 ON DATABASE

------------------------------output Runtime trigger --------------------------
 
delete from [dbo].[Student]
OUTPUT DELETED.St_Fname , DELETED.St_Address
where st_id=13




delete from student
output getdate(),deleted.st_fname
where st_id=21


update Student
set st_fname='ali'
output suser_name(),inserted.st_age , inserted.St_Age
where st_id=1


update Student
set st_fname='ali'
output suser_name(),inserted.st_age 
where st_id=1
























insert into student(st_id,st_fname)
output 'welcome to iti'
values(57,'ali')











update Instructor set Salary+=200
output (inserted.Salary-deleted.Salary)*100/inserted.Salary
where Ins_Id=2

----------------

