-- Check if the database exists before creating it
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'my_school_database')
BEGIN
    CREATE DATABASE my_school_database;
END
GO

-- Switch to the newly created database
USE my_school_database;
GO

-- Create Student table
CREATE TABLE Student (
    RollNum VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    warning_count INT
);

-- Insert rows into Student table
INSERT INTO Student (RollNum, Name, Gender, warning_count)
VALUES ('L164123', 'Ali Ahmad', 'Male', NULL),
       ('L164124', 'Rafia Ahmed', 'Female', NULL),
       ('L164125', 'Basit Junaid', 'Male', NULL);

-- Create Attendance table
CREATE TABLE Attendance (
    RollNum VARCHAR(10),
    Date DATE,
    Status CHAR(1),
    ClassVenue INT,
    FOREIGN KEY (RollNum) REFERENCES Student(RollNum) ON DELETE NO ACTION,
    FOREIGN KEY (ClassVenue) REFERENCES ClassVenue(ID) ON DELETE NO ACTION
);

-- Insert rows into Attendance table
INSERT INTO Attendance (RollNum, Date, Status, ClassVenue)
VALUES ('L164123', '2016-02-22', 'P', 2),
       ('L164124', '2016-02-23', 'A', 1),
       ('L164125', '2016-03-04', 'P', 2);

-- Create ClassVenue table
CREATE TABLE ClassVenue (
    ID INT PRIMARY KEY,
    Building VARCHAR(50),
    RoomNum INT,
    Teacher VARCHAR(50)
);

-- Insert rows into ClassVenue table
INSERT INTO ClassVenue (ID, Building, RoomNum, Teacher)
VALUES (1, 'CS', 2, 'Sarim Baig'),
       (2, 'Civil', 7, 'Bismillah Jan');

-- Create Teacher table
CREATE TABLE Teacher (
    Name VARCHAR(50) PRIMARY KEY,
    Designation VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert rows into Teacher table
INSERT INTO Teacher (Name, Designation, Department)
VALUES ('Sarim Baig', 'Assistant Prof.', 'Computer Science'),
       ('Bismillah Jan', 'Lecturer', 'Civil Eng.'),
       ('Kashif Zafar', 'Professor', 'Electrical Eng.');

-- Add Primary Key constraint to Attendance table
ALTER TABLE Attendance ADD CONSTRAINT PK_Attendance PRIMARY KEY (RollNum, Date);

-- Add Primary Key constraint to ClassVenue table
ALTER TABLE ClassVenue ADD CONSTRAINT PK_ClassVenue PRIMARY KEY (ID);

-- Add Primary Key constraint to Teacher table
ALTER TABLE Teacher ADD CONSTRAINT PK_Teacher PRIMARY KEY (Name);

-- Add Primary Key constraint to Student table
ALTER TABLE Student ADD CONSTRAINT PK_Student PRIMARY KEY (RollNum);

-- Alter table Student by adding new column “warning count” and deleting “Phone” Column

-- Perform the following DML actions

-- i. Add new row into Student table
INSERT INTO Student (RollNum, Name, Gender, warning_count)
VALUES ('L162334', 'Fozan Shahid', 'Male', 3);

-- iii. Update Teacher table Change “Kashif zafar” name to “Dr. Kashif Zafar”.
UPDATE Teacher SET Name = 'Dr. Kashif Zafar' WHERE Name = 'Kashif Zafar';

-- iv. Delete Student with rollnum “L162334”
DELETE FROM Student WHERE RollNum = 'L162334';

-- vi. Delete Attendance with rollnum “L164124”, if his status is absent.
DELETE FROM Attendance WHERE RollNum = 'L164124' AND Status = 'A';

-- Add unique constraint on column “Name” in Teacher table
ALTER TABLE Teacher ADD CONSTRAINT UC_Teacher_Name UNIQUE (Name);

-- Add check constraint for gender in Student table
ALTER TABLE Student ADD CONSTRAINT CK_Student_Gender CHECK (Gender IN ('Male', 'Female'));

-- Add check constraint for status in Attendance table
ALTER TABLE Attendance ADD CONSTRAINT CK_Attendance_Status CHECK (Status IN ('A', 'P'));
