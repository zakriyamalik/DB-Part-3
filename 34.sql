create database databasemid1;

create table department
(
dep_id int primary key not null,
name varchar(25),
location varchar(255)
)

create table Employee
(
emp_id int primary key not null,
name varchar(25),
dep_id int references department(dep_id)
)
INSERT INTO department (dep_id, name, location) VALUES
(1, 'Sales', 'New York'),
(2, 'Marketing', 'Los Angeles'),
(3, 'Engineering', 'San Francisco'),
(4, 'HR', 'Chicago');
INSERT INTO Employee (emp_id, name, dep_id) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Michael Johnson', 3),
(4, 'Emily Brown', 2);
select * from department;
select * from Employee;
SELECT top 2 * FROM department 
where location is not null;

delete from department where name = 'sales';

select count(*) as maxi
from department;




select * from department;
select * from Employee;




SELECT * FROM department 
right join employee on
department.dep_id=employee.dep_id;

select name from department
where dep_id is not null
group by name
having name like '%g'
order by name desc;





