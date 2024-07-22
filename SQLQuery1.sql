create database lab_3;
use lab_3
create table salesman(
salesman_id int PRIMARY KEY,
name varchar(255),
city varchar (255),
commision float
);
 INSERT INTO salesman (salesman_id,name,city,commision)
VALUES (5001,'James Hoog', 'New York', 0.15),
 (5002,'Nail knite', 'Paris', 0.13),
 (5005,'Pit Alex', 'London', 0.15),
 (5006,'Mac Lyon', 'Paris', 0.15),
 (5007,'Paul Adam', 'San Jose', 0.15),
 (5003,'Lausan Hen', 'San Jose', 0.15);

 create table customers(
customer_id int PRIMARY KEY,
cust_name varchar(50),
city varchar(50),
grade int,
salesman_id int,
FOREIGN KEY (salesman_id) References salesman(salesman_id) ON DELETE CASCADE ON UPDATE CASCADE
);

GO
 INSERT INTO customers (customer_id, cust_name,city, grade, salesman_id)
 VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
 (3007,'John Brad Davis','New York',200,5001),
 (3005,'Graham Zusi','California',200,5002),
 (3008,'Julian Green', 'London',300,5002),
 (3004, 'Fabian Johnson', 'Paris', 300,5006),
 (3009, 'Geoff Cameron', 'Berlin' ,100,5003),
 (3003, 'Jozy Altidor', 'Moscow', 200,5007),
 (3001, 'John Brad Guzan', 'London',NULL,5005)
create table orders(
ord_no int PRIMARY KEY,
purch_amt int,
ord_date date,
customer_id int,
FOREIGN KEY (customer_id) References customers(customer_id)ON DELETE NO ACTION ON UPDATE NO ACTION,
salesman_id int,
FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id)ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO orders (ord_no, salesman_id, purch_amt, ord_date, customer_id)
VALUES (70001, 5002, 150.5, '2012-10-05', 3005),
 (70009, 5005, 270.65, '2011-9-10', 3001),
 (70002, 5001, 65.26, '2014-10-05', 3002),
 (70004, 5003, 110.5, '2011-08-17', 3009),
 (70007,5002, 948.5, '2012-09-10', 3005),
 (70005, 5001,2400.6, '2010-07-27', 3007),
 (70008, 5001,5760, '2013-09-10', 3002),
 (70010, 5006,1983.43, '2010-10-10', 3004),
 (70003, 5003,2480.4, '2013-10-10', 3009),
  (70012, 5002,250.45, '2010-06-27', 3008),
 (70011, 5007,75.29, '2014-08-17', 3003),
 (70013, 5001,3045.6, '2010-04-25', 3002);
 SELECT * FROM orders;
 --1
 SELECT * from customers where city='New York'ORDER BY cust_name;
 --2
 SELECT * from customers where cust_name like '%John%' AND (city='London' OR city='Paris' OR city='New York');
 --3
  SELECT * from customers where city='London' OR city='New York';
  --4
  SELECT * from orders where purch_amt>500;

  --5
  SELECT * from salesman where name like '_a%';
 
  --6
  SELECT * from orders

 SELECT name,commision+0.6,city FROM salesman
WHERE city='San Jose';
--7
SELECT * FROM orders
ORDER BY ord_date desc;
--8

SELECT salesman_id, LEFT(name, CHARINDEX(' ', name + ' ') - 1) AS firstname, city, commision
FROM salesman;

--9
SELECT * FROM orders

SELECT * FROM orders where MONTH(ord_date)=1;

--10

 SELECT YEAR(ord_date) AS [Year],MONTH(ord_date) AS [month],DAY(ord_date) AS [day],DATENAME(dw,ord_date) as [week_day],DATEPART(dy,ord_date) as [day_of_year] FROM orders;

 --Post lab from Q11 to Q14

  --11

  SELECT * from orders

  UPDATE orders set[purch_amt]=purch_amt*3 where MONTH(ord_date)=10;

  --12
 SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2013

INTERSECT

SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2014;

--13
SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2011

UNION

SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2013;

--14

SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2012

EXCEPT

SELECT DISTINCT c.customer_id, c.cust_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.ord_date) = 2014;
