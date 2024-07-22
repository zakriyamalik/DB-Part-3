create database assignment2_q2
use assignment2_q2

-- Create Employee table
CREATE TABLE Employee (
    EMPLOYEE_ID INT,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    EMAIL VARCHAR(50),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE DATE,
    JOB_ID VARCHAR(10),
    SALARY INT,
    COMMISSION_PCT INT,
    MANAGER_ID INT,
    DEPARTMENT_ID INT
);
-- Remove the HIRE_DATE column from the Employee table
ALTER TABLE Employee
DROP COLUMN HIRE_DATE;

-- Update the HIRE_DATE data in the Employee table to NULL
UPDATE Employee
SET HIRE_DATE = NULL;

-- Insert data into Employee table

INSERT INTO Employee 
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567',  'AD_PRES', 24000, 0, 0, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568',  'AD_VP', 17000, 0, 100, 90),
(102, 'De', 'Haan', 'LDEHAAN', '515.123.4569',  'AD_VP', 17000, 0, 100, 90),
(108, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567',  'IT_PROG', 9000, 0, 302, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', 'IT_PROG', 6000, 0, 303, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569',  'IT_PROG', 4800, 0, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', NULL,  'IT_PROG', 4800, 0, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.4560',  'IT_PROG', 4200, 0, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569',  'FI_MGR', 12000, 0, 301, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', NULL,  'FI_ACCOUNT', 9000, 0, 108, 100),
(110, 'John', NULL, NULL, NULL, NULL, NULL,  NULL, NULL, NULL),
(111, 'Ismael', 'Chen', 'ICHEN', '515.124.4269',  'FI_ACCOUNT', 8200, 0, 108, 100),
(112, 'Jose Manuel', 'Urman', 'IMURMAN', '515.124.4469',  'FI_ACCOUNT', 7800, 0, 108, 100),
(113, 'Lais', 'Popp', 'LPOPP', '515.124.4567', 'FILACCOUNT', 6900, 0, 108, 100),
(114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', NULL, NULL, NULL, NULL, NULL),
(115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562',  NULL, 11000, 0, 200, 30),
(116, 'Shell', 'Baida', 'SBAIDA', '515.127.4563', 'PU_CLERK', 2900, 0, 114, 30),
(117, 'Sigal', 'Tobias', 'STOBIAS', NULL, 'PU_CLERK', 2800, 0, 114, 30),
(118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4564',  'PU_CLERK', 2600, 0, 114, 30),
(119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', 'PU_CLERK', 2500, 0, 114, 30),
(120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', 'ST_MAN', 8000, 0, 100, 50),
(121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234',  'ST_MAN', 8200, 0, 300, 50),
(122, 'Payam', 'Kaulling', 'PKALIFLIN', '650.123.3234', 'ST_MAN', 7900, 0, 100, 50),
(123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234',  'ST_MAN', 6500, 0, 300, 50),
(124, 'Kevin', 'Moungos', 'KMOURGOS', '650.123.5234',  'ST_MAN', 5800, 0, 300, 50),
(125, 'Nayer', 'JMAYER','JNAYER', '650.124.1214',  'ST_CLERK', 3200, 0, 120, 50);



select * from Employee


-- Create Department table
CREATE TABLE Department (
    DEPARTMENT_ID INT,
    DEPARTMENT_NAME VARCHAR(50),
    MANAGER_ID INT,
    LOCATION_ID INT
);

-- Insert data into Department table
INSERT INTO Department (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2700),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120, 'Treasury', 0, 1700),
(130, 'Corporate Tax', 0, 1700),
(140, 'Control And Credit', 0, 1700),
(150, 'Shareholder Services', 0, 1700),
(160, 'Benefits', 0, 1700);

-- Create Location table
CREATE TABLE Location (
    LOCATION_ID INT,
    STREET_ADDRESS VARCHAR(50),
    POSTAL_CODE VARCHAR(50),
    CITY VARCHAR(50),
    STATE_PROVINCE VARCHAR(50),
    COUNTRY_ID VARCHAR(50)
);

-- Insert data into Location table
INSERT INTO Location (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', 'IT', NULL),
(1100, '93091 Calle della Te', '10934', 'Venice', 'IT', NULL),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', 'JP', NULL),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brun', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', 'CN', NULL),
(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
(2300, '198 Clementi North', '540198', 'Singapore', 'SG', NULL),
(2400, '8204 Arthur St', 'London', 'UK', NULL, NULL),
(2500, 'Magdalen Centre, The', '0X9 928', 'Oxford', 'Oxford', 'UK'),
(2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
(2700, 'Schwanthalerstr. 703', '80925', 'Munich', 'Bavaria', 'DE'),
(2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
(2900, '20 Rue des Corps-Sai', '1730', 'Geneva', 'Geneve', NULL),
(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
(3100, 'Pieter Breughelstraat', '30295K', 'Utrecht', 'Utrecht', 'NL'),
(3200, 'Mariano Escobedo 999', '11932', 'Mexico City', 'Distrito Federal', 'MX');

-- Create Jobs table
CREATE TABLE Jobs (
    JOB_ID VARCHAR(10),
    JOB_TITLE VARCHAR(50),
    MIN_SALARY INT,
    MAX_SALARY INT
);

-- Insert data into Jobs table
INSERT INTO Jobs (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('AC_MGR', 'Accounting Manager', 8200, 16000),
('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('PU_MAN', 'Purchasing Manager', 8000, 15000),
('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('SH_CLERK', 'Shipping Clerk', 2500, 5500),
('IT_PROG', 'Programmer', 4000, 10000),
('MK_MAN', 'Marketing Manager', 9000, 15000),
('MK_REP', 'Marketing Representative', 4000, 9000),
('HR_REP', 'Human Resources Representative', 4000, 9000),
('PR_REP', 'Public Relations Representative', 4500, 10500);

--1. find the name (first_name, last_name) and the salary of the employees who have a higher
--salary than the employee whose last_name=‘Bull’


select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee 
where Employee.SALARY>(Select SALARY from Employee where LAST_NAME='Bull') 

--2. find the name (first_name, last_name) of all employees who works in the IT department.

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee join
Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID 
group by Department.DEPARTMENT_ID,Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY,DEPARTMENT_NAME
having Department.DEPARTMENT_NAME='IT'

--3 find the name (first_name, last_name) of the employees who have a manager and worked
--in a USA based department.

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee join
Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID join
Location on Department.LOCATION_ID=Location.LOCATION_ID
where Employee.MANAGER_ID<>0 and Location.COUNTRY_ID='US'

--4 find those employees who earn more than the average salary. Return employee ID, first name,
--last name.

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.EMPLOYEE_ID,AVG(Salary) as Average_Salary
 from Employee
group by  Employee.FIRST_NAME,Employee.LAST_NAME,Employee.EMPLOYEE_ID,SALARY
having SALARY>AVG(Salary)

--5. find those employees whose department is located at ‘Toronto’. Return first name, last
--name, employee ID, job ID.


select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.EMPLOYEE_ID from Employee join
Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID join
Location on Department.LOCATION_ID=Location.LOCATION_ID 
where Location.CITY='Toronto' 


--6. find those employees who report to that manager whose first name is ‘Payam’. Return first
--name, last name, employee ID and salary

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.EMPLOYEE_ID from Employee 
where Employee.manager_id = ( select Employee.EMPLOYEE_ID from employee where Employee.FIRST_NAME='Payam')

--7. find all those departments where at least one employee is employed. Return department name


select Distinct Department.DEPARTMENT_NAME from Employee right join
Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID


--8. find those employees who do not work in the departments where managers’ IDs are
--between 100 and 200 (Begin and end values are included.). Return all the fields of the
--employees

select * from employee join
Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID where
Department.MANAGER_ID not between 100 and 200

--9. From the following table, find those employees whose salary matches the lowest salary of
--any of the departments. Return first name, last name and department ID.

select top 1 Employee.FIRST_NAME,Employee.LAST_NAME,min(salary) as Minimum_Salary,Employee.DEPARTMENT_ID from Employee


group by Employee.FIRST_NAME,Employee.LAST_NAME,SALARY,Employee.DEPARTMENT_ID
order by min(SALARY) asc

--10.find the name (first_name, last_name) of the employees who are managers.

select Employee.FIRST_NAME,Employee.LAST_NAME from Employee where EMPLOYEE_ID in
(Select MANAGER_ID from Employee)


--11.find those employees whose salary is lower than that of employees whose job title is
--"MK_MAN". Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name,
--last name, job ID


select Employee.EMPLOYEE_ID, Employee.FIRST_NAME,Employee.LAST_NAME,Employee.JOB_ID from Employee join
Jobs on Employee.JOB_ID=Jobs.JOB_ID where Jobs.JOB_TITLE='MK_MAN'


--12.Find the name (first_name, last_name), and salary of the employees whose salary is
--greater than the average salary

select Employee.EMPLOYEE_ID, Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY>(select avg(salary) from Employee as Average_Salary)


--13.Find the name (first_name, last_name), and salary of the employees whose salary is equal 
--to the minimum salary for their job grade.

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY=(select min(salary) from Employee as Minimum_Salary)

--14.Find the name (first_name, last_name), and salary of the employees who earns 
--more than  the average salary and works in any of the IT departments.


select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY>(select avg(salary) from Employee as Average_Salary join Department on Employee.DEPARTMENT_ID=Department.DEPARTMENT_ID where Department.DEPARTMENT_NAME='IT')


--15. Find the name (first_name, last_name), and salary of the employees who 
--earns more than  the earning of Mr. Bell. 

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY>(select salary from Employee where Employee.LAST_NAME='Bell')

--16.Find the name (first_name, last_name), and salary of the employees who earn the
--same  salary as the minimum salary for all departments. 

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY=(select min(salary) from Employee )

--17.Find the name (first_name, last_name), and salary of the employees whose salary is 
--greater than the average salary of all departments. 

select Employee.FIRST_NAME,Employee.LAST_NAME,Employee.SALARY from Employee
where SALARY>(select avg(salary) from Employee )

--18.Find the 3rd maximum salary in the employees table.

select distinct top 1 Employee.SALARY from Employee where SALARY<
(select distinct max(Employee.SALARY) from Employee where SALARY<
(select distinct max(Employee.SALARY) from Employee))
order by SALARY desc



