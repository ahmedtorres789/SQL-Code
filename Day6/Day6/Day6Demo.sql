
------------------------------Views------------------------------------

/** Views **/
/*
IS A Saved select statment we can't write insert update delete in it .

Views Properties : 
�	No DML Queries inside view body 
�	Standered View may be Considered as Virtual table 
�	Has No Parms 

--Why and when we use it?
�	Simplify construction of complex queries
�	Specify user view
�	Limit access to data [grant revoke]
�	Hide names of database objects [table name and columns]
*/								

/** Creating Views **/








---Selecting data from View 

select * from Vstuds

---Alias name for view column 
--Create view that contain cairo strudent informatio

ALTER VIEW Vcairo (Sid , Sname , Saddress)
AS
SELECT s.St_Id , s.St_Fname , s.St_Address
FROM Student s
WHERE s.St_Address = 'cairo'

SELECT Sid FROM Vcairo







select * from Vcairo
select sname from Vcairo
--Create view that containt alex strudent informatio


ALTER view Valex(Sid,Sname,Saddress)
WITH ENCRYPTION
as
	Select st_id,st_fname,st_address
	from Student
	where st_address='alex'




select * from valex



sp_helptext 'Valex'




--Create view for cairo and alex students--
--View inside view 

create view Vall
as
SELECT * FROM VCairo 
UNION ALL 
SELECT *FROM Valex

SELECT * FROM Vall v



------------------------------------------

Create view Vjoin(sid,sname,did,dname)
with encryption
AS
 SELECT s.St_Id , s.St_Fname , D.Dept_Id , d.Dept_Name
 FROM Student s , Department d
 WHERE d.Dept_Id = s.Dept_Id

 SELECT * FROM Vjoin







select * from vjoin

select sname,dname from vjoin
-- view for sname,dname,grade
alter view vgrades ( sname,dname,cname , grade)
as
SELECT s.St_Fname AS gggg , D.Dept_Name uuuu , c.Crs_Name , sc.Grade
FROM Department d , Student s , Stud_Course sc , Course c
WHERE D.Dept_Id = s.Dept_Id AND s.St_Id = sc.St_Id 
     AND sc.Crs_Id = c.Crs_Id



select * from vgrades

sp_helptext 'vjoin'
----------------------For view security------------------------------
create view vgrades
with encryption
as
select sname,dname,grade
from vjoin v inner join Stud_Course sc
	on v.sid=sc.St_Id









----------------------------------- View+DML -------------------------------------
-----View DML in One table
	
---------------------------1- Insert in one table--------------------------------- 
--1- Rest column in table that we toke view from should have one of the flowing
--(Defualt value , identity , allow null , derived)




insert into vcairo
VALUES(123 , 'ttttt' , 'Cairo')

SELECT * FROM VCairo

SELECT * FROM Student s 

values(3210,'ali','cairo')

-------------------With Check options-------------------------
insert into vcairo
values(325,'ali','alex')

SELECT * FROM VCairo

SELECT * FROM Student s 






alter view Vcairo(sid,sname,sadd)
as
	Select st_id,st_fname,st_address
	from Student
	where st_address='cairo'
with check option


insert into vcairo
values(326,'ali','cairo')



insert into vcairo
values(329,'ali','alex')

select * from vcairo





--------------------------------------Update-----------------------------
update  vcairo
set  sadd ='alex' where sid =326

SELECT * FROM vcairo





--------------------------------------Delete -----------------------------
delete  from  vcairo
where  sname ='Nour'



-------------------DML with view that came from Multi tables-----------------------




alter view Vjoin(sid,sname ,SDid,did,dname)
with encryption
as
select st_id,st_fname, S.Dept_Id ,d.dept_id,dept_name
from student S inner join department d
	on d.dept_id=s.dept_id

--Delete XXXXXXXXXXXXXXXX



--insert   update avilable with conditions
-----------1-insert and update must affect in one table 
insert into vjoin
values(21,'nada',700,'Cloud')

SELECT * FROM Student s
SELECT * FROM Department d 
SELECT * FROM vjoin




--insert in table 
insert into vjoin(sid,sname , SDid)
values(22,'ali' , 800)


insert into vjoin(did,dname)
values(800,'BI')

update vjoin 
set sname ='Doaa'
where sid=5

--indexed view --Continued--
--When we use it When you use the same complex query on many tables, multiple times.
--When new system need to read old table data, but doesn't watch to change their
--perceived schema.
create view vdata
with schemabinding
as
	select ins_name,salary
	from dbo.Instructor   --We have to write Schema name 
	where dept_id=10 

--Fist one will be altered
alter table instructor alter column ins_degree varchar(50)

--But this one will not altered because it's found in view 
--and view take phicycal copy from table 
alter table instructor alter column ins_name varchar(100)




-----------------------------
---------------------------------Data base intergrity---------------------------














---------------------------------------Conistraint-------------------------------------
--Set of conditions we apply it in columns 
--Constraint applied to new and old data so if old data dosen't match 
--Conistraint it won't Created 
create table Dept
(
 Dept_id int primary key,
 dname varchar(20)
)

select * from emp
create table emp
(
 eid int identity(1,1),                  
 ename varchar(20),                        --Domain integrity(Specify Rang of values)
 eadd varchar(20) default  'alex',         --Domain integrity 
 hiredate date default getdate(),          --Domain integrity
 sal int,								   --Domain integrity
 overtime int,							   --Domain integrity
 netsal as(isnull(sal,0)+isnull(overtime,0))  persisted, 
 BD date,
 age as(year(getdate())-year(BD)),
 gender varchar(1),
 hour_rate int not null,
 did int,
 constraint c11 primary key(eid,ename),  --Entity integrity(Row Uniqness)
 constraint c12 unique(sal)  ,
 constraint c13 unique(overtime),
 -- constraint c3 unique(sal , overtime),
 constraint c14 check(sal>1000),
 constraint c15 check(eadd in ('cairo','mansoura','alex')),
 constraint c16 check(gender='F' or gender='M'),
 constraint c17 check(overtime between 100 and 500),
 constraint c18 foreign key(did)  references Dept(Dept_id)
		
)

--Note Constraint on old and new data 
alter table emp add constraint c100 check(hour_rate>100)




SELECT * FROM Employee e
alter table Employee add constraint c100 check(Salary >= 2500)





--Drop Constraint 
alter table emp drop constraint c3


---------------------------------Sequence and Idintity------------------
--
--Create Sequence:object that generates a sequence of numbers according to 
--a specified specification
--To create a Sequence in SQL Server 2012 is very simple. You can
    -- create it with SQL Server Management Studio or T-SQL.
    --Create Sequence with SQL Server Management Studio
    --In Object Explorer window of SQL Server Management Studio, there is a Sequences node under Database -> [Database Name] -> Programmability. You can right click on it to bring up context menu, and then choose New Sequence� to open the New Sequence window. In New Sequence window, you can define the new Sequence, like Sequence Name, Sequence schema, Data type, Precision, Start value, Increment by, etc. After entering all the required information, click OK to save it. The new Sequence will show up in Sequences node.
    --Create Sequence with T-SQL
    --The following T-SQL script is used to create a new Sequence: 


	CREATE TABLE Test
	(
	ID INT , 
	Name VARCHAR(200)
	)

	INSERT INTO Test (Name)  VALUES( 'ttt')



-- Create seq progromatically:
CREATE SEQUENCE DemoSequence
START WITH 1
INCREMENT BY 1;




create sequence ss1
start with 1
increment by 1
minvalue 1
maxvalue 3
cycle

SELECT NEXT VALUE FOR ss1

-- Use Sequence
----The new NEXT VALUE FOR T-SQL keyword is used to get the next 
-----sequential number from a Sequence.
SELECT NEXT VALUE FOR DemoSequence

	INSERT INTO Test   VALUES(4 ,  'ttt')

	SELECT * FROM Test t









create table [Customers]
(
[CustomerID] int,
[LName] nvarchar(22),
[FName] nvarchar(22)
)

--Use it for insert
insert into [dbo].[Customers] ([CustomerID],[LName],[FName]) 
values(1,'fff','rrr');

insert into [dbo].[Customers] ([CustomerID],[LName],[FName]) 
values(NEXT VALUE FOR DemoSequence,'fff','rrr');

select * from Customers

--column can be updated
update [dbo].[Customers]
set [CustomerID]=12
where [CustomerID]=11

-------------------------------------Rules----------------------------------------------
--what if we want to apply Constraint in new data only
--what if we want to write Constraint once and make it shaired on more than one column
--what if we want to Datatype and apply constraint and Rules on it 
--As Resualt for all of that their is a Rules that solve ali this problems
--XXXXX       Constraint   ---> New Data
--XXXXX       Constraint   --->shared 
--XXXXX       Datatype        Constraint    Default

alter table instructor add constraint c200 check(salary>1000)
  
---------------------------------------------------------------------
CREATE rule MyRule1 AS @x>=2500 AND @x<=3500


GO

sp_bindrule MyRule1 , 'Employee.salary'
sp_bindrule MyRule1 , '[dbo].[Project].[Pnumber]'



sp_unbindrule 'Employee.salary'


UPDATE Employee SET Salary=2500 WHERE SSN = 112233

INSERT INTO Employee(SSN , Salary) VALUES( 111 , 3000)




--Rule
create rule r1 as @x>1000

sp_bindrule  r1,'Employee.salary'
sp_bindrule  r1,'emp.overtime'

sp_unbindrule 'Employee.salary'
sp_unbindrule '[dbo].[Project].[Pnumber]'

drop rule MyRule1












create default def1 as 5000




sp_bindefault  def1,'Employee.salary'

sp_unbindefault 'Employee.salary'

drop default def1




------------------------------------User defined Data Types--------------------------------------------------

--Create New Datatype  ---OverTimeDT  (int    >1000   default 5000)



---------------------------------------------------------------------------------------------------------
--Creating user defined data type
CREATE TYPE OverTimeDT FROM int NOT NULL;
--OR


--sp_addtype new_dtype,'nvarchar(50)','not null'
go
create rule greaterthan1000 as @s >1000
GO




create default d2 as 5000
GO




sp_bindrule greaterthan1000 , OverTimeDT







go
sp_bindefault d2 , OverTimeDT







CREATE TABLE MyEmp
(
SSN INT , 
Ename VARCHAR(200) , 
OTime OverTimeDT
)
INSERT INTO [dbo].[MyEmp](SSN , Ename) VALUES(1 , 'fff' )







--exists in Programmability=>Types=>User-Defined Data Types


			-----------------------
--Using new data type on a new table

create table emp3
(
IDNo int Primary key,
Name nvarchar(50),
overTime int
)
--Using new data type on a existing table table
--but that column must no have any data base objects related to it like
--(constraint ) 
go

alter table emp3
alter column overTime OverTimeValue


alter table emp3
alter column overTime int
--Removing user defined Data type
drop type IDNumber
--OR
sp_droptype OverTimeValue
		


-------------------------------------------------Schema------------------------------------







--what is Schema 
--it is Logical grouping for tables and data base objects
--Why we need Schema ?
--1-we can't make more than one object in Data base(table , view ,...) 
--with same name 
--2-Too Much Permission if we deal with each table indevidually
--3- We could give permision in schema 

------------------------Create Schema --------------------------
create schema Hr






alter schema Hr transfer instructor  

SELECT * FROM HR.Instructor i




CREATE TABLE HR.instructor_test (id INT)






select *
from serverName.DatabaseName.SchemaName.TableName

select *
from [DESKTOP-L03LHV7\DOAA].ITI.dbo.Student

create schema HR

create schema sales

--to move an existing table to my new schema

alter schema HR transfer Student

alter schema HR transfer Instructor

alter schema sales transfer department

create table Hr.stud
(
 id int,
 name varchar(20)
)

--Create table inside specific schema
create table sales.student
(
 id int,
 name varchar(20)
)

select * from Hr.Instructor

select * from hr.Instructor

select * from Instructor

select * from Student

select * from Hr.Student


-----------------Don't forget to change schema using wizerd---------------




SELECT * FROM s1

[Production].[ProductModelProductDescriptionCulture]



------------------------synonym-----------------------------------------
--what is synonym ? Saved alias name 
create synonym  s1
for [Production].[ProductModelProductDescriptionCulture]



create synonym
select * from s1

 

select s.St_Id
from Student s

create synonym HE
for HumanResources.EmployeeDepartmentHistory

select * from HE



DECLARE  @x INT =10

SELECT @x











SELECT 









-------------------------------Variables------------------------------

-------------------Declare variables---------------------  
--Declare then assign then select using select 
declare @x int = 10

set @x =20 -- Select @x = 20


select @x AS X
 





--Declare then assign then select using set 
declare @z int 
set @z =10
select @z

 
--Delcare and initialize then select 
declare @y int =10
select @y

--Save student avg age in a variable 

declare @age int 
SET @age = (SELECT AVG( st_Age) FROM student s)
select @age





DECLARE @age INT 
select @age = st_age from Student where St_Id=6
SELECT @age





select * from Student
--Note 
--we use Select for select only or insert value in var only

--Save id and name for student number 7


DECLARE @id INT

SELECT @id = s.St_Id , s.St_Fname
FROM Student s
WHERE s.St_Id = 7 

SELECT @id










declare @id int ,@name varchar(10)

select @id=St_Id , @name=St_Fname
from Student 
where St_Id=7

select @id , @name
----------------------Wrong select for both --------------------
declare @y int

select @y=St_Age , St_Fname
from Student 
where St_Id = 4

select @y

--use set for both 
--write a qurey that update student name take name and id from 
--user in run time and then select student name and it's 
--Deparment 
declare @name varchar(10)='Doaa' ,@dept int , @id int=3





DECLARE @dept INT ,  @name VARCHAR(30) = 'ahmed'

update Student 
set St_Fname= @name , @dept=Dept_Id
where St_Id=1

select @dept








--Save tanta Student age in a variable 
declare @m1 int 
select  st_age from Student where St_Address='cairo' AND St_Age IS NOT NULL
select @m1





---------------------------Table variable------------------------------
--How to declare table and it's columns
declare @t table ( col1 INT , col2 VARCHAR(20) )

INSERT INTO @t
select  st_age , St_Fname from Student where St_Address='cairo' AND St_Age IS NOT NULL
SELECT * FROM @t






--Save age for alex student in a variable
declare @t1 table (x int )

insert into @t1
select St_age 
from Student
where St_Address='tanta'

select x from  @t1
-----------------------Make top dynamic using var----------------------
--Find top n students 
declare @x int =4

select top(@x)*
from Student 
order by St_Age desc 

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
select * from t1
select @@IDENTITY





























































