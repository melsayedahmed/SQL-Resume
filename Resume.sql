--                         ********************************************************************************************************************************
--                         *                                                                                                                              *
--                         *                                                            SQL Resume                                                        *
--                         *                                                                                                                              *
--                         *                                                        By Mohab Mohammed                                                     *
--                         ********************************************************************************************************************************

-- *****************************************************************************************************************************************************************************

--------------------------- Comments  -----------------------------
-- Single Line Comment
/*
 Multi Line Comment
 .....
 .....
*/
===================================================================
===================================================================
--------------------------- Data Types ----------------------------
------------------- Numeric Data Types
bit         -- Boolean Value 0[false]: 1[true]
tinyint		-- 1 Byte => -128:127		| 0:255 [Unsigned]
smallint	-- 2 Byte => -32768:32767	| 0:65555 [Unsigned] 
int			-- 4 Byte (important)
bigint		-- 8 Byte (important)

------------------- Fractions Data Types
smallmoney	4Byte.0000                  		 -- 4 Numbers After Point
money		8Byte.0000               		     -- 4 Numbers After Point
real		  .0000000                  		 -- 7 Numbers After Point
float		  .000000000000000      		     -- 15 Numbers After Point
dec								     	       	 -- Datatype and Make Valiadtion at The Same Time => Recommended
dec(5, 2) 13524.22	18.1	12.2212 XXX 2.1234   --(important)

------------------- Char Data Types
char(10)		[Fixed Length Character]	Ahmed 10	Ali 10	
varchar(10)		[Variable Length Character]	Ahmed 5		Ali 3    --(important)
nchar(10)		[like char(), But With UniCode] على  
nvarchar(10)	[like varchar(), But With UniCode] على  
nvarchar(max)	[Up to 2GB]
varchar(max)
------------------- DateTime Data Types
Date			MM/dd/yyyy
Time			hh:mm:ss.123 --Defualt=> Time(3)
Time(4)			hh:mm:ss.1234
smalldatetime	MM/dd/yyyy hh:mm:00
datetime		MM/dd/yyyy hh:mm:ss.123
datetime2(5)	MM/dd/yyyy hh:mm:ss.12345
datetimeoffset	11/23/2020 10:30 +2:00 Timezone

------------------- Binary Data Types
binary 01110011 11110000
image

------------------- Other Data Types
Xml
sql_variant -- Like Var In Javascript

==================================================================
--------------------------- Variables ----------------------------
-- 1. Global Variables
select @@Version
select @@ServerName

-- 2. Local Variables
declare @age int = 3
set @age = 55
print @age

-------------------------------------------------------------------
-- DDL => Data Definition Language
-- 1. Create
create database RouteCycle37G01
use RouteCycle37G01

create table Employee
(
SSN int primary key identity(1, 1),
FName varchar(15) not null,
LName varchar(15),
Address varchar(20),
Salary Money,
Gender char(1),
BDate Date,
DNo int,
SuperSSN int references Employee(SSN)
)
create table Department
(
Number int primary key identity(10, 10),
Name varchar(15) not null,
StarteDate Date,
MGRSSN int references Employee(SSN)
)
create table DeptLocations
(
Number int references Department(Number),
Name varchar(15),
primary key(Number, Name)
)

create table Project
(
PNum int primary key identity, 
PName varchar(20) not null,
Location varchar(20),
DNo int references Department(Number)
)

create table Dependent
(
Name varchar(20) not null,
Gender char(1),
BDate Date,
Relationship varchar(20),
ESSN int references Employee(SSN),
primary key(ESSN, Name)
)

create table Works_On
(
ESSN int references Employee(SSN),
PNo int references Project(PNum),
Hours tinyint ,
primary key(ESSN, PNo)
)

-- 2. ALter [Update]
alter table Employee
add foreign key (DNo) references Department(Number)

alter table Employee
add ID bigint

alter table Employee
alter column SSN bigint


alter table Employee
drop column ID 

-- 3. Drop [Remove]
drop table Employee
=========================================================================
-- DML => Data Manpulation Language
-- 1. Insert
-------- Simple Insert

use MyCompany
insert into Employee values('Ahmed', 'Ali', 2000, 'Alex', '1234567')

insert into Employee (FName, Salary) values('Yousef', 200)

--------- Row Constructor Insert
insert into Employee
values ('Ali', 'Amr', 3456782, GetDate(),'BNS', 'M', 2345, Null, 10),
		('Ali', 'Amr', 3456782, GetDate(),'BNS', 'M', 2345, Null, 10),
		('Ali', 'Amr', 3456782, GetDate(),'BNS', 'M', 2345, Null, 10),
		('Ali', 'Amr', 3456782, GetDate(),'BNS', 'M', 2345, Null, 10)
insert into Employee
values ('Ali', 'Amr', 3456782, GetDate(),'BNS', 'M', 2345, Null, 10)

-- update 
update Employee
	set LName = 'Ibrahim'
	where LName = 'Ali'

update Employee
	set  = 23 , St_Address = 'Cairo'
	where St_Id = 5

-- delete 
delete from Employee
where EmpID = 2

------------------------------------------
use Route

-- Truncate 
truncate table Student
delete from Student
=========================================================================
-- DQL => Data Query Language

select *
from Student

select St_Fname +' '+ St_Lname FullName
from Student

select St_Fname +' '+ St_Lname as FullName
from Student

select St_Fname +' '+ St_Lname  [Full Name]
from Student

select [Full Name] = St_Fname +' '+ St_Lname  
from Student


select * 
from Student
where St_Age > 23

select * 
from Student
where St_Age between 21 and 25

select *
from Student
where St_Address in ('Alex', 'Mansoura', 'Cairo')


select *
from Student
where St_Address not in ('Alex', 'Mansoura', 'Cairo')

Select * 
from Student
where St_super is not Null

--------------------------

-- like With Some Patterns
/*
_ => one Char
% => Zero or More Chars 
*/ 
select *
from Student
where St_Fname like '_A%'        -- Na Fady Kamel Hassan Nada Nadia 
/*

'a%h'                            --ah aghjklh
'%a_'                            --ak hjkak
'[ahm]%' amr hassan mohamed      -- start "A" or "H" or "M"
'[^ahm]%'                        -- Not start "A" or "H" or "M"
'[a-h]%'                         -- start "A,B,C......H"
'[^a-h]%'                        -- Not start "A,B,C......H"
'[346]%'                         -- start "3" or "4" or "6"
'%[%]'                           --ghjkl%
'%[_]%'                          --Ahmed_Ali _
'[_]%[_]'                        --_Ahmed_

*/
select *
from Employee
where FName like '[_]A%'

-- Distinct                        --علشان يجبلي الداتا بتاعتي من غير تكرار
select distinct FName
from Employee

-- Order By                        -- علشان ارتب الداتا
select St_Id, St_Fname, St_Age
from Student
order by St_Fname, St_Age          -- From A to Z

select St_Id, St_Fname, St_Age
from Student
order by St_Fname, St_Age desc     -- From Z to A

select *
from Student
order by 1                         -- رقم 1 تعود علي اول Coulme
===========================================================
--------------------------- Joins -------------------------
-- Cross join (Cartisian Product)
select st_fname,dept_name
from student s,department d

select st_fname,dept_name
from student s cross join department d

-- Inner Join (Equi Join)
-- Equi Join Syntax
select st_fname,dept_name
from student s,department d
where d.dept_id=s.dept_id

select st_fname,d.*
from student s,department d
where d.dept_id=s.dept_id

-- Inner Join Syntax
select st_fname,dept_name
from student s inner join department d
	on d.dept_id=s.dept_id


-- Outer Join
-- Left Outer Join
select st_fname,dept_name
from student s left outer join department d
	on d.dept_id=s.dept_id

-- Right Outer Join
select st_fname,dept_name
from student s right outer join department d
	on d.dept_id=s.dept_id

-- Full Outer Join
select st_fname,dept_name
from student s full outer join department d
	on d.dept_id=s.dept_id

-- Self Join
select s.st_fname,s1.*
from student s,student s1
where s1.st_id=s.st_super

select s.st_fname,s1.*
from student s inner join student s1
on s1.st_id=s.st_super

-- Multi Table Join
-- Equi Join Syntax
select st_fname,crs_name,grade
from Student s,Stud_Course sc,course c
where s.St_Id=sc.St_Id and c.Crs_Id=sc.Crs_Id

-- Inner Join Syntax
select st_fname,crs_name,grade
from Student s inner join Stud_Course sc
     on s.St_Id=sc.St_Id 
	 inner join course c
	 on c.Crs_Id=sc.Crs_Id
----------------------------------
-- Join + DML
-- Update 

-- Updates Grades Of Student Who 're Living in Cairo
update SC
	set grade += 10
from Student S inner join Stud_Course SC
on  S.St_Id = SC.St_Id and St_Address = 'cairo'

-- Self Study
-- Delete
-- Insert
----------------------------------------------------------
----------------------------------------------------------
=======================================================
--------------------- Built-in Functions --------------
=======================================================

------------------- Aggregate Functions ---------------
--  Return Value That Not Existed In Database
--	Count, Sum, Avg, Max, Min  

select count(*)
from student

--The Count of Students That have Ages (Not Null)
select count(st_age) 
from student

select count(*) , count(st_id), count(st_lname), count(st_age)
from Student

select sum(salary)
from instructor


select avg(st_age)
from Student
select sum(st_age)/COUNT(*)
from Student
select sum(st_age)/COUNT(st_age)
from Student



select Max(Salary) as MaxSalary, Min(Salary) as MinSalary
from Instructor


