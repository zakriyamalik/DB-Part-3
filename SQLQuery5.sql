-- Use the myzdb database
USE myzdb;

-- Create the student table
CREATE TABLE Student (
    RollNo VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255),
	Gender VARCHAR(255),
    Phone VARCHAR(255),
);

INSERT INTO [student] ([RollNo],[Name],[Gender],[Phone])
VALUES ('L164123','Ali Ahmed','Male','0333-3333333')
Go
INSERT INTO [student] ([RollNo],[Name],[Gender],[Phone])
VALUES ('L164124','Rafia Ahmed','Female','0332-3456789')
Go
INSERT INTO [student] ([RollNo],[Name],[Gender],[Phone])
VALUES ('L164125','Basit Junaid','Male','0345-3243567')
Go
SELECT * FROM student
CREATE TABLE ATTENDANCE (
    ROLLNO VARCHAR(255),
    DATE DATETIME,
    STATUS VARCHAR(255),
    CLASSVENUE INT,
    FOREIGN KEY (ROLLNO) REFERENCES STUDENT(ROLLNO) ON UPDATE NO ACTION
);

INSERT INTO ATTENDANCE (ROLLNO, DATE, STATUS, CLASSVENUE)
VALUES ('L164123', '2016-02-22', 'P', 2),
       ('L164124', '2016-02-23', 'P', 1),
       ('L164125', '2016-02-24', 'P', 2);

SELECT * FROM ATTENDANCE
CREATE TABLE CLASSVENUE (
    ID INT PRIMARY KEY NOT NULL,
    Building VARCHAR(255),
    RoomNum VARCHAR(255),
    Teacher VARCHAR(255)
);

INSERT INTO CLASSVENUE (ID, Building, RoomNum, Teacher)
VALUES (1, 'CS', '2', 'Sarim Baig'),
       (2, 'Civil', '7', 'Bismillah Jan');


SELECT * FROM CLASSVENUE
create table Teacher (
Name nvarchar(500),
Designation nvarchar(500),
Department nvarchar(500)
);
INSERT INTO [Teacher] (Name,Designation,Department)
VALUES ('Sarim baig','Assistant Prof.','Computer Science')
Go
INSERT INTO [Teacher] (Name,Designation,Department)
VALUES ('Bismillah Jan','Lecturer','Civil Eng')
Go
INSERT INTO [Teacher] (Name,Designation,Department)
VALUES ('Kashif zafar','Professor','Electric Eng')
Go
SELECT * FROM Teacher