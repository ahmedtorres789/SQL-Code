 Use ITI_new
--1.	 Create a scalar function that takes a date and returns the Month name of that date. test (‘1/12/2009’)
CREATE OR ALTER FUNCTION GetMonthName(@date DATE)
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @GetMonthName VARCHAR(50)
    SELECT @GetMonthName =  DATENAME(MONTH, @date)
	RETURN @GetMonthName
END


   SELECT dbo.GetMonthName('2009-1-12') AS MonthName

--2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.

  CREATE OR ALTER FUNCTION GetRange(@start INT, @end INT)
   RETURNS @result TABLE(Value INT)
   AS
   BEGIN
       WHILE @start <= @end
       BEGIN
           INSERT INTO @result VALUES (@start)
           SET @start = @start + 1
       END
       RETURN
   END

   SELECT * FROM GetRange(5 , 10)

--3.	 Create a tabled valued function that takes Student No and returns Department Name with Student full name.
   CREATE or ALTER FUNCTION GetStDetails(@stNo INT)
   RETURNS TABLE
   AS
   RETURN 
   (
   SELECT d.Dept_Name, s.St_Fname + ' ' + s.St_Lname AS FullName
   FROM Student s
   JOIN Department d ON s.Dept_Id = d.Dept_Id
   WHERE s.St_Id = @stNo
   );
   
   SELECT * FROM GetStDetails(7)

--4.	Create a scalar function that takes Student ID and returns a message to the user (use Case statement)
--a.	If the first name and Last name are null then display 'First name & last name are null'
--b.	If the First name is null then display 'first name is null'
--c.	If the Last name is null then display 'last name is null'
--d.	Else display 'First name & last name are not null'
CREATE OR ALTER FUNCTION CheckStudentName(@studentId INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE  @msg NVARCHAR(255)
	SELECT @msg = CASE 
        WHEN  s.St_Fname IS NULL AND s.St_Lname IS NULL THEN 'First name & last name are null'
        WHEN s.St_Fname IS NULL THEN 'First name is null'
        WHEN s.St_Lname IS NULL THEN 'Last name is null'
        ELSE 'First name & last name are not null'
    END
    -- Fetch the first and last names based on student ID
    FROM Student s 
    WHERE St_Id = @studentId

    RETURN @msg
END

SELECT dbo.CheckStudentName(1)




--5.	Create a function that takes an integer that represents the format of the Manager hiring date and displays department name, Manager Name, and hiring date with this format. 

CREATE OR ALTER FUNCTION GetManagerDetails(@dateFormat INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
       d.Dept_Name ,  d.Dept_Manager  AS MangerID,
        CASE 
            WHEN @dateFormat = 1 THEN FORMAT(d.Manager_hiredate	, 'yyyy-MM-dd')
            WHEN @dateFormat = 2 THEN FORMAT(d.Manager_hiredate, 'MM/dd/yyyy')
			when @dateFormat = 3 then FORMAT(d.Manager_hiredate , 'MMMM/yyyy')
            -- Add more formats here as needed
            ELSE FORMAT(d.Manager_hiredate, 'yyyy-MM-dd') -- Default format
        END AS HiringDate
    FROM Department d
    
)

SELECT * FROM GetManagerDetails(1)


--6.	Create multi-statements table-valued function that takes a string
--If string='first name' returns student first name
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
 --Use the “ISNULL” function


  CREATE OR ALTER FUNCTION GetStudentNamePart(@part NVARCHAR(50))
   RETURNS @result TABLE(NPart NVARCHAR(255))
   AS
   BEGIN
       IF @part = 'first name'
           INSERT INTO @result SELECT ISNULL(St_Fname, '') FROM Student
       ELSE IF @part = 'last name'
           INSERT INTO @result SELECT ISNULL(St_Lname, '') FROM Student
       ELSE IF @part = 'full name'
           INSERT INTO @result SELECT ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') FROM Student
       RETURN
   END

   SELECT * FROM GetStudentNamePart('last name')
--7.	Write a query that returns the Student No and Student first name without the last char

SELECT St_Id, LEFT(St_Fname, LEN(St_Fname) - 1) AS FirstName
   FROM Student



 Use Company_SD

--1.	Create a function that takes project number and display all employees in this project

 CREATE OR ALTER FUNCTION GETEMPPROJ(@projno int)
 RETURNS TABLE 
 AS 
 RETURN 
 (
 SELECT CONCAT(e.Fname , e.Lname) As EmpName  , p.Pnumber 
 FROM Employee e
 Join Works_for wf on e.SSN = wf.ESSn
 Join Project p on p.Pnumber = wf.Pno
 Where  p.Pnumber = @projno
 )

 SELECT * FROM GETEMPPROJ(100)
--2.	write a Query that computes the increment in salary that arises if the salary of employees increased by any value

