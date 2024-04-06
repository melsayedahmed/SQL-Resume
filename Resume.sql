--                                           ********************************************************************************************************************************
--                                           *                                                                                                                              *
--                                           *                                                            SQL Resume                                                        *
--                                           *                                                                                                                              *
--                                           *                                                        By Mohab Mohammed                                                     *
--                                           ********************************************************************************************************************************

-- *********************************************************************************************************************************************************************************************************************

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
smallmoney	4Byte.0000            -- 4 Numbers After Point
money		8Byte.0000            -- 4 Numbers After Point
real		  .0000000         -- 7 Numbers After Point
float		  .000000000000000 -- 15 Numbers After Point
dec			-- Datatype and Make Valiadtion at The Same Time => Recommended
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
