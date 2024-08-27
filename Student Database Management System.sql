-- Create a database named "student_database"
CREATE DATABASE student_database
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Create a table called "student_table"
CREATE TABLE Student_table (
    Student_id INT,
    Stu_name VARCHAR(100),
    Department VARCHAR(50),
    Email_id VARCHAR(50),
    Phone_no NUMERIC,
    Address VARCHAR(250),
    Date_Of_Birth DATE,
    Gender VARCHAR(30),
    Major VARCHAR(50),
    GPA NUMERIC,
    Grade VARCHAR(10)
);

-- Insert 10 sample records
INSERT INTO Student_table (Student_id, Stu_name, Department, email_id, Phone_no, Address, Date_Of_Birth, Gender, Major, GPA, Grade)
VALUES
('1', 'Jayashree Ravi', 'Business', 'Jayashree@gmail.com', '9999999991', 'Delhi', '1999-04-26', 'Female', 'MBA', '8.8', 'A'),
('2', 'Nizam Khan', 'Arts and Sciences', 'Nizam@gmail.com', '9999999992', 'Bangalore', '1992-07-15', 'Male', 'Mathematics', '8.6', 'A'),
('3', 'Ranjith Kumar', 'Business', 'Ranjith@gmail.com', '9999999993', 'Delhi', '1995-06-28', 'Male', 'MBA', '8.5', 'A'),
('4', 'Parthiban Leo', 'Arts and Sciences', 'ParthiLeo@gmail.com', '9999999994', 'Dehradhun', '1997-01-12', 'Male', 'Physics', '7.6', 'B'),
('5', 'Reshma Roy', 'Arts and communication', 'Reshma@gmail.com', '9999999995', 'Mumbai', '1995-10-26', 'Female', 'Communication', '6.9', 'B'),
('6', 'Shivani Krishnan', 'Arts and Sciences', 'Shivani@gmail.com', '9999999996', 'Goa', '2000-01-03', 'Female', 'Computer Science', '5.5', 'C'),
('7', 'Himanshu Gupta', 'Human Development', 'Himanshu@gmail.com', '9999999997', 'Indore', '2000-10-05', 'Male', 'Counseling', '7.0', 'B'),
('8', 'Pranesh Yadav', 'Arts and communication', 'Pranesh@gmail.com', '9999999998', 'Pune', '1999-11-16', 'Male', 'Theatre', '9.2', 'A'),
('9', 'Sarath Kumar', 'Business', 'Sarathk@gmail.com', '9999999999', 'Udaipur', '2003-08-14', 'Male', 'Accounting', '7.9', 'B'),
('10', 'Sonya Agarwal', 'Arts and Sciences', 'Sonya@gmail.com', '9999999911', 'Mumbai', '1997-03-12', 'Female', 'Physics', '4.9', 'C');

-- Student Information Retrieval
SELECT *
FROM Student_table
ORDER BY GPA DESC, Grade;

-- Query for Male Students
Select * from Student_table 
WHERE Gender = 'Male';

-- Query for Students with GPA less than 5.0
SELECT * 
FROM Student_table 
WHERE GPA <5.0;

-- Update Student Email and Grade
UPDATE Student_table
SET email_id = 'Sanyaa@gmail.com', Grade = 'D'
WHERE Student_id = '10';

-- Query for Students with Grade "B"
SELECT Stu_name, date_part('year',age(Date_Of_Birth)) as Age
FROM Student_table
Where Grade = 'B';

-- Grouping and Calculation
SELECT Department, Gender, Avg(GPA)
FROM Student_table
GROUP BY 1,2;

--  Table Renaming
ALTER TABLE Student_table
RENAME TO Student_info;
SELECT * FROM Student_info;

--  Retrieve Student with Highest GPA
SELECT Stu_name, GPA
FROM Student_info WHERE GPA = (Select Max(GPA) From Student_info);

