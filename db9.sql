-- Assuming you have privileges to create a database
CREATE DATABASE neon;  -- Replace 'neon' with your desired database name

USE neon;  -- Use the newly created database

-- Table Definitions
CREATE TABLE Student (
  roll_no INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  dept_id INT,
  batch INT,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  credit_hrs INT,
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Section (
  section_id INT PRIMARY KEY,
  course_id INT,
  capacity INT,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Enrolled (
  student_roll_no INT,
  section_id INT,
  PRIMARY KEY (student_roll_no, section_id),
  FOREIGN KEY (student_roll_no) REFERENCES Student(roll_no),
  FOREIGN KEY (section_id) REFERENCES Section(section_id)
);

CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE  -- Enforce unique department names
);

-- 1. Auditing Table and Triggers
CREATE TABLE Auditing (
  audit_id INT PRIMARY KEY IDENTITY(1,1),  -- Start from 1, increment by 1
  last_change_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  description VARCHAR(255)
);


--2

CREATE TRIGGER audit_student
AFTER INSERT OR UPDATE OR DELETE ON student
FOR EACH ROW
BEGIN
  INSERT INTO Auditing (last_change_on, table_name, description) VALUES (CURRENT_TIMESTAMP, 'student', CASE WHEN NEW.roll_no IS NULL THEN 'Delete' WHEN OLD.roll_no IS NULL THEN 'Insert' ELSE 'Update' END);
END;

CREATE TRIGGER audit_department
AFTER INSERT OR UPDATE OR DELETE ON department
FOR EACH ROW
BEGIN
  INSERT INTO Auditing (last_change_on, table_name, description) VALUES (CURRENT_TIMESTAMP, 'department', CASE WHEN NEW.dept_id IS NULL THEN 'Delete' WHEN OLD.dept_id IS NULL THEN 'Insert' ELSE 'Update' END);
END;

CREATE TRIGGER audit_faculty
AFTER INSERT OR UPDATE OR DELETE ON faculty
FOR EACH ROW
BEGIN
  INSERT INTO Auditing (last_change_on, table_name, description) VALUES (CURRENT_TIMESTAMP, 'faculty', CASE WHEN NEW.faculty_id IS NULL THEN 'Delete' WHEN OLD.faculty_id IS NULL THEN 'Insert' ELSE 'Update' END);
END;


-- 3. Registration System View
CREATE VIEW Registration_View AS
SELECT s.roll_no, s.name AS student_name, c.name AS course_name, sec.section_id, d.name AS department_name
FROM student s
JOIN enrolled e ON s.roll_no = e.student_roll_no
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
JOIN department d ON c.dept_id = d.dept_id;

-- 4. Registration Stored Procedure
DELIMITER //
CREATE PROCEDURE RegisterStudent(IN student_roll_no INT, IN section_id INT)
BEGIN
  INSERT INTO enrolled (student_roll_no, section_id) VALUES (student_roll_no, section_id);
END //
DELIMITER ;

-- 5. Department Table Security Trigger
CREATE TRIGGER protect_department
BEFORE UPDATE OR DELETE ON department
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Department table is read-only. Cannot modify existing departments.';
END;

-- 6. DDL Trigger for Data Definition Language
CREATE TRIGGER prevent_ddl
BEFORE DROP OR ALTER ON DATABASE
FOR EACH STATEMENT
BEGIN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'Data definition operations (ALTER, DROP) are not allowed
