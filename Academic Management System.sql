CREATE DATABASE student_database;
USE student_database;
--  Create tables StudentInfo, CourseInfo, EnrollmentInfo
CREATE TABLE StudentInfo (
    STU_ID int PRIMARY KEY,
    STU_NAME varchar(100),
    DOB DATE,
    PHONE_NO varchar(15), 
    EMAIL_ID varchar(50),
    ADDRESS varchar(250)
);
CREATE TABLE CourseInfo (
    COURSE_ID INT,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100),
    PRIMARY KEY (COURSE_ID)
);
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    PRIMARY KEY (ENROLLMENT_ID),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CourseInfo(COURSE_ID)
);

-- Insert values in StudentInfo, CourseInfo, EnrollmentInfo tables
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
(101, 'Tom Hardy', '1993-07-23', '9999999991', 'tom101@gmail.com', 'Chennai'),
(102, 'Sam Joseph', '1994-06-23', '9999999992', 'sam102@gmail.com', 'Bangalore'),
(103, 'Ben Issac', '1993-08-25', '9999999993', 'ben103@gmail.com', 'Bangalore'),
(104, 'Kane Lewis', '1993-10-23', '9999999994', 'kane104@gmail.com', 'Pune'),
(105, 'Ian Robert', '1994-06-14', '9999999995', 'ian105@gmail.com', 'Delhi'),
(106, 'John Austin', '1991-07-17', '9999999996', 'john106@gmail.com', 'Indore');

INSERT INTO CourseInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
(1, 'SQL', 'Hayden'),
(2, 'Python', 'Ashish'),
(3, 'AWS', 'Tim'),
(4, 'JAVA', 'Harry'),
(5, 'CSS', 'Nathan');

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) VALUES 
(10001, 101, 1, 'ENROLLED'),
(10002, 103, 2, 'ENROLLED'),
(10003, 104, 4, 'ENROLLED'),
(10004, 102, 3, 'ENROLLED'),
(10005, 105, 3, 'NOT ENROLLED'),
(10006, 106, 5, 'ENROLLED')
(10007, 101, 5, 'NOT ENROLLED');

-- query to retrieve student details, such as student name, contact informations, and Enrollment status
SELECT s.STU_NAME, s.PHONE_NO, s.ADDRESS, e.ENROLL_STATUS
FROM StudentInfo s
JOIN EnrollmentInfo e
ON s.STU_ID = e.STU_ID
ORDER BY e.ENROLL_STATUS ASC;

-- query to retrieve a list of courses in which a specific student is enrolled
SELECT c.COURSE_NAME, s.STU_NAME
FROM EnrollmentInfo e
JOIN CourseInfo c ON e.COURSE_ID = c.COURSE_ID
JOIN StudentInfo s ON s.STU_ID = e.STU_ID
WHERE e.STU_ID = 101
AND e.ENROLL_STATUS = 'ENROLLED';

-- query to retrieve course information, including course name, instructor information
SELECT *
FROM CourseInfo;

-- query to retrieve course information for a specific course
SELECT *
FROM CourseInfo
WHERE COURSE_NAME = 'SQL';

-- query to retrieve course information for multiple courses
SELECT *
FROM CourseInfo
WHERE COURSE_NAME IN ('SQL', 'Python');

-- queries to ensure accurate retrieval of student information
SELECT * FROM StudentInfo;

-- query to retrieve the number of students enrolled in each course
SELECT c.Course_Name, COUNT(e.course_id) AS numberofStud
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.course_id = e.course_ID
WHERE e.enroll_status = 'ENROLLED'
GROUP BY c.Course_Name;

-- query to retrieve the list of students enrolled in a specific course
SELECT e.COURSE_ID, c.COURSE_NAME, s.STU_NAME
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.course_id = e.course_ID
JOIN StudentInfo s ON s.STU_ID = e.STU_ID
WHERE e.enroll_status = 'ENROLLED';

-- query to retrieve the count of enrolled students for each instructor
SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS numberofStud
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.course_id = e.course_ID
WHERE e.enroll_status = 'ENROLLED'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

-- query to retrieve the list of students who are enrolled in multiple courses
SELECT e.stu_id, COUNT(c.course_id) AS numberofStud
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.course_id = e.course_ID
WHERE e.enroll_status = 'ENROLLED'
GROUP BY e.stu_id
HAVING COUNT(c.course_id) > 1;

-- query to retrieve the courses that have the highest number of enrolled students (arranging from highest to lowest)
SELECT c.COURSE_ID, c.COURSE_NAME, COUNT(e.STU_ID) AS numberofStud
FROM CourseInfo c
JOIN EnrollmentInfo e ON c.course_id = e.course_ID
WHERE e.enroll_status = 'ENROLLED'
GROUP BY c.COURSE_ID, c.COURSE_NAME
ORDER BY COUNT(e.STU_ID) DESC;
