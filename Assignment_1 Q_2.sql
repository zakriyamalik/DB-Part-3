USE assignment1;
CREATE TABLE staff_member (
    f_name VARCHAR(255),
    l_name VARCHAR(255),
    u_no INT PRIMARY KEY
);
CREATE TABLE student (
    f_name VARCHAR(255),
    l_name VARCHAR(255),
    user_no INT PRIMARY KEY,
    project_no INT NOT NULL,
    super_no INT,
    asseeeor_no1 INT,
    assessor_no2 INT,
    FOREIGN KEY (super_no) REFERENCES staff_member(u_no),
	CONSTRAINT uk_project_no UNIQUE (project_no) 
);
	   drop TABLE student;
CREATE TABLE Project (
    proj_no INT PRIMARY KEY NOT NULL,
    proj_name VARCHAR(255),
    level VARCHAR(255),
    keyword VARCHAR(255),
    description TEXT,
	FOREIGN KEY (proj_no) REFERENCES student(project_no)
);
 drop TABLE Project;
CREATE TABLE exam (
    user_no INT,
    exam_no INT,
    time TIME,
    day DATE,
    room_no INT,
    PRIMARY KEY (user_no, exam_no)
);
 drop TABLE exam;
 CREATE TABLE exam (
    user_no INT,
    exam_no INT,
    time TIME,
    day DATE,
    room_no INT,
    PRIMARY KEY (user_no, exam_no),
    FOREIGN KEY (user_no) REFERENCES student(user_no) -- Corrected foreign key relationship
);
INSERT INTO staff_member (f_name, l_name, u_no)
VALUES ('John', 'Doe', 1),
       ('Jane', 'Smith', 2),
       ('Alice', 'Johnson', 3);
INSERT INTO student (f_name, l_name, user_no, project_no, super_no, asseeeor_no1, assessor_no2)
VALUES ('Michael', 'Brown', 101, 1, 1, 2, 3),
       ('Sarah', 'Williams', 102, 2, 2, 3, 1),
       ('David', 'Jones', 103, 3, 3, 1, 2);
INSERT INTO Project (proj_no, proj_name, level, keyword, description)
VALUES (1, 'Project A', 'Advanced', 'Java', 'Description of Project A'),
       (2, 'Project B', 'Intermediate', 'Andriod', 'Description of Project B'),
       (3, 'Project C', 'Beginner', 'C++', 'Description of Project C');
 UPDATE Project
SET level = CASE
               WHEN keyword = 'Advanced' THEN 3
               WHEN keyword = 'Intermediate' THEN 2
               WHEN keyword = 'Beginner' THEN 1
               ELSE 0
           END;
INSERT INTO exam (user_no, exam_no, time, day, room_no)
VALUES (101, 1, '09:00:00', '2022-01-10', 101),
       (102, 1, '10:30:00', '2022-01-11', 102),
       (103, 1, '14:00:00', '2022-01-12', 103);
-- Delete the records of all students who are working on project no 10
DELETE FROM student WHERE project_no = 10;
-- Change the level of projects from 4 to 5 which have ‘Android’ in their keywords
UPDATE Project SET level = '5' WHERE keyword = 'Android';
-- Query 1: Find exam time and date of student user no: 1010 and Room_no = 005
SELECT time, day FROM exam WHERE user_no = 1010 AND room_no = 005;
-- Query 2: Show all project names in descending order
SELECT proj_name FROM Project ORDER BY proj_name DESC;
-- Query 3: Show fname of staff member with L_Name starting with A and ending with A
SELECT f_name FROM staff_member WHERE l_name LIKE 'A%A';
-- Query 4: Show name of student who has not been assigned any supervisor as yet
SELECT f_name, l_name FROM student WHERE super_no IS NULL;
-- Query 5: Show user no who are sitting between room 005 and 009 during exam
SELECT DISTINCT user_no FROM exam WHERE room_no BETWEEN 005 AND 009;

-- Query 6: Show students name with its supervisor name and project number
SELECT s.f_name AS student_fname, s.l_name AS student_lname, 
       st.f_name AS supervisor_fname, st.l_name AS supervisor_lname, 
       s.project_no
FROM student s
LEFT JOIN staff_member st ON s.super_no = st.u_no;
