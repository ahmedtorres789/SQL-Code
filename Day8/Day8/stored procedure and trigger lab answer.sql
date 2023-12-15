USE ITI_new 

--     Create a stored procedure to show the number of students per department.[use ITI DB]
CREATE OR ALTER PROC StudentsPerDepartment AS
BEGIN
    SELECT Dept_Id, COUNT(*) as NumberOfStudents
    FROM Student
    GROUP BY Dept_Id;
END;

EXEC StudentsPerDepartment


/* 2.	Create a stored procedure that will check for the number of employees in the project 100 if they are more than 3 print a message to the user “'The number of employees in the project 100 is 3 or more'” if they are less display a message to the user “'The following employees work for the project p1'” in addition to the first name and last name of each one. [Company DB] */

USE Company_SD;

CREATE OR ALTER PROCEDURE EmployeesInProj100 AS
BEGIN
    IF @@ROWCOUNT = (SELECT 1 FROM Works_For ww WHERE Pno = 100 HAVING COUNT(*) >= 3)
    BEGIN
        PRINT 'The number of employees in the project 100 is 3 or more';
    END
    ELSE
    BEGIN
        PRINT 'The following employees work for the project p1';
        SELECT e.Fname , e.Lname
        FROM Employee e
        WHERE e.SSN IN (SELECT wf.ESSn FROM Works_For wf WHERE wf.Pno = 100);
    END
END;

EXEC EmployeesInProj100





/*3.	 Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) and it will be used to update works_for table. [Company DB] */

USE Company_SD;

create or alter procedure ReplaceEmployeeInProject @new_id int, @old_id int, @pnum int
as 
 if exists ( select ssn from employee where ssn = @new_id )
 begin
 begin try
  update dbo.works_for
  set essn = @new_id where ( essn = @old_id and pno = @pnum)
 end try 
 begin catch
  select 'Not Allowed';
 end catch
 end
 else
 begin
  select 'Employee is Not Existed '
 end

exec ReplaceEmployeeInProject 223344 , 335578 , 200

SELECT * FROM Works_for


/* If a user updated the Hours column then the project number, the user name that made that update, the date of the modification and the value of the old and the new Hours will be inserted into the Audit table */ 

USE Company_SD;


create table Audit
(

ProjectNo varchar(50),
UserName varchar(50),
ModifiedDate date,
Hours_Old int,
Hours_New int 

)


create trigger t19 
on works_for
after update 
as 
if update(Hours) 
 begin 
 declare @pno int 
 declare @hours_old int  
 declare @hours_new int 
 select @pno = pno from inserted
 select @hours_old = Hours from deleted
 select @hours_new = Hours from inserted

 insert into Audit values(@pno, SUSER_NAME(), GETDATE(), @hours_old, @hours_new)
 end

update works_for set hours = 10 
where pno = 100


select * from audit







--.     Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--Print a message for the user to tell him that he ‘can’t insert a new record in that table’


use ITI_new
go


CREATE TRIGGER t15 
on Department
INSTEAD OF INSERT 
AS 
SELECT 'Not allowed'


insert into department (Dept_Id) 
values (1)
