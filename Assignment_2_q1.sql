create database assignment2
use assignment2;
-- Create the Supplier table
CREATE TABLE Supplier (
    s# VARCHAR(10),
    SName VARCHAR(255),
    Status INT,
    City VARCHAR(255)
);

-- Insert data into the Supplier table
INSERT INTO Supplier (s#, SName, Status, City) VALUES
('S1', 'smith', 20, 'london'),
('S2', 'jones', 10, 'paris'),
('S3', 'blakk', 30, 'paris'),
('S4', 'clark', 20, 'london'),
('S5', 'adnes', 30, 'athene');

-- Create the Part table
CREATE TABLE Part (
    part_id VARCHAR(10),
    part_name VARCHAR(255),
    color VARCHAR(255),
    city VARCHAR(255)
)

-- Insert data into the Part table
INSERT INTO Part (part_id, part_name, color, city) VALUES
('P1', 'NUT', 'Red', 'London'),
('P2', 'BOLT', 'Green', 'Paris'),
('P3', 'SCREW', 'Blue', 'Rome'),
('P4', 'SCREW', 'Red', 'London'),
('P5', 'CAM', 'Blue', 'Paris'),
('P6', 'COG', 'Red', 'London');

-- Create the Jobs table
CREATE TABLE Jobs (
    J# VARCHAR(10),
    JName VARCHAR(255),
    numworken INT,
    City VARCHAR(255)
);

-- Insert data into the Jobs table
INSERT INTO Jobs (J#, JName, numworken, City) VALUES
('J1', 'SORTER', 20, 'PARIS'),
('J2', 'PUNCH', 10, 'ROME'),
('J3', 'READER', 30, 'ATHENS'),
('J4', 'CONSOLE', 20, 'ATHENS'),
('J5', 'COLLATOR', 30, 'LONDON'),
('J6', 'TERMINAL', 20, 'OSLO'),
('J7', 'TAPE', 10, 'LONDON');

-- Create the Shipments table
CREATE TABLE Shipments (
    S# VARCHAR(10),
    P# VARCHAR(10),
    J# VARCHAR(10),
    QTY INT
);

-- Insert data into the Shipments table
INSERT INTO Shipments (S#, P#, J#, QTY) VALUES
('S1', 'P1', 'J1', 200),
('S1', 'P1', 'J4', 700),
('S2', 'P3', 'J1', 400),
('S2', 'P3', 'J2', 200),
('S2', 'P3', 'J3', 200),
('S2', 'P3', 'J4', 500),
('S2', 'P3', 'J5', 400),
('S2', 'P3', 'J7', 800),
('S2', 'P5', 'J2', 100),
('S3', 'P3', 'J1', 200),
('S4', 'P4', 'J2', 500),
('S4', 'P6', 'J3', 300),
('S5', 'P6', 'J7', 300),
('S5', 'P2', 'J2', 200),
('S5', 'P2', 'J4', 100),
('S5', 'P5', 'J5', 500),
('S5', 'P5', 'J7', 100),
('S5', 'P6', 'J2', 200),
('S5', 'P1', 'J4', 100),
('S5', 'P3', 'J4', 200),
('S5', 'P4', 'J4', 800),
('S5', 'P5', 'J4', 400),
('S5', 'P6', 'J4', 500);


SELECT * FROM Supplier;

SELECT * FROM Part;

SELECT * FROM Jobs;

SELECT * FROM Shipments;



--1. List the part number for every part that is shipped by more than one supplier.
select distinct s1.P# from Shipments s1 join
Shipments s2 on s1.P#=s2.P# and s1.S# <> s2.S#;



--2. Find the average weight of all parts.

SELECT AVG(weight) AS average_weight
FROM Part;

--3. For each part list the part number and the total quantity 
--in which that part is shipped and order the results in descending order of the
--total quantity shipped. Name the total quantity shipped in the result as total Shipped.

select shipments.P#,Sum(QTY) as Total_Shipped from shipments 
group by P#
order by  Total_Shipped desc 

--4. List only the names of those suppliers who ship a part that weighs more than 200.

select sname from Supplier join shipments on Supplier.s#=Shipments.S# join
part on Shipments.P#=part.part_id 
where part.weight>200 
 
--5. List the names of those cities in which both a supplier and 
--a job are located.

select distinct Supplier.City from Supplier join jobs 
on Supplier.city=jobs.City 

--6. List the names of those jobs that receive a shipment from supplier number S1.

select jobs.JName from jobs join 
Shipments on jobs.J#=Shipments.J# join
Supplier on Supplier.s#=Shipments.S# 

--7. List the names of those parts that are not shipped to any job.


select part.part_name from part left join  
shipments on Part.part_id=Shipments.P# 
where Shipments.P# is null 

--8. List the names of those suppliers who ship part number P2 to any job.

select supplier.SName from Supplier join Shipments on Supplier.s#=Shipments.S#
where Shipments.P#='P2'

--9. List the names of those suppliers who ship part at least one red part to any job.

select Supplier.SName from Supplier join Shipments on Supplier.s#=Shipments.S# join
part on Shipments.P#=part.part_id 
group by p#,color,Supplier.SName
having color='Red'


--10.List the part number for every part that is shipped more than once
--(the part must be shipped more than one time).

select shipments.P# from Shipments 
group by P#
having count(p#)>1



