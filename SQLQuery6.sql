-- Create database
CREATE DATABASE University;

-- Use the University database
USE University;

-- Create Student table
CREATE TABLE Student (
    RollNum VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255),
    Gender VARCHAR(255),
    Phone VARCHAR(255)
);

-- Insert data into Student table
INSERT INTO Student (RollNum, Name, Gender, Phone)
VALUES ('L164123', 'Ali Ahmad', 'Male', '0333-3333333'),
       ('L164124', 'Rafia Ahmed', 'Female', '0333-3456789'),
       ('L164125', 'Basit Junaid', 'Male', '0345-3243567');

-- Create Attendance table
CREATE TABLE Attendance (
    RollNum VARCHAR(255),
    Date DATE,
    Status VARCHAR(255),
    ClassVenue INT,
    FOREIGN KEY (RollNum) REFERENCES Student(RollNum)
);

-- Insert data into Attendance table
INSERT INTO Attendance (RollNum, Date, Status, ClassVenue)
VALUES ('L164123', '2016-02-22', 'P', 2),
       ('L164124', '2016-02-23', 'A', 1),
       ('L164125', '2016-03-04', 'P', 2);

-- Create ClassVenue table
CREATE TABLE ClassVenue (
    ID INT PRIMARY KEY,
    Building VARCHAR(255),
    RoomNum VARCHAR(255),
    Teacher VARCHAR(255)
);

-- Insert data into ClassVenue table
INSERT INTO ClassVenue (ID, Building, RoomNum, Teacher)
VALUES (1, 'CS', '2', 'Sarim Baig'),
       (2, 'Civil', '7', 'Bismillah Jan');

-- Create Teacher table
CREATE TABLE Teacher (
    Name VARCHAR(255),
    Designation VARCHAR(255),
    Department VARCHAR(255)
);

-- Insert data into Teacher table
INSERT INTO Teacher (Name, Designation, Department)
VALUES ('Sarim Baig', 'Assistant Prof.', 'Computer Science'),
       ('Bismillah Jan', 'Lecturer', 'Civil Eng.'),
       ('Kashif Zafar', 'Professor', 'Electrical Eng.');

-- Print all tables
SELECT * FROM Student;
SELECT * FROM Attendance;
SELECT * FROM ClassVenue;
SELECT * FROM Teacher;
