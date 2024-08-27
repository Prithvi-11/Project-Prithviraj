-- Create a database named "EventsManagement"
CREATE DATABASE "EventsManagement"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create tables for Events, Attendees, and Registrations
CREATE TABLE Events (
    Event_Id INT,
    Event_Name VARCHAR(30),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description VARCHAR(200),
    PRIMARY KEY (Event_Id)
);

CREATE TABLE Attendees (
    Attendee_Id INT,
    Attendee_Name VARCHAR(30),
    Attendee_Phone NUMERIC,
    Attendee_Email VARCHAR(30),
    Attendee_City VARCHAR(20),
    PRIMARY KEY (Attendee_Id)
);

-- The FOREIGN KEY constraints
CREATE TABLE Registrations (
    Registration_Id INT,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount NUMERIC,
    PRIMARY KEY (Registration_Id),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- Insert some sample data for Events, Attendees, and Registrations tables
INSERT INTO Events 
(Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES
('101', 'AR Rahman', '2024-03-03', 'Chennai', 'Music Show'), 
('102', 'Comicon 2023', '2023-11-19', 'Bangalore', 'Exhibition'),
('103', 'National Awards', '2023-11-12', 'Delhi', 'Movie'),
('104', 'I was not Ready Da!', '2024-01-06', 'Bangalore', 'Comedy'),
('105', 'Thangalan - Tamil', '2024-02-13', 'Kolkata', 'Movie');

SELECT * FROM Events;

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES 
('1001', 'Muskaan', '9999999991', 'Muskaan@gmail.com', 'Delhi'),
('1002', 'Rajat', '9999999992', 'Rajat@gmail.com', 'Delhi'),
('1003', 'Abhinav', '9999999993', 'Abhinav@gmail.com', 'Mumbai'),
('1004', 'Kundan', '9999999994', 'Kundan@gmail.com', 'Uttar Pradesh'),
('1005', 'Karishma', '9999999995', 'Karishma@gmail.com', 'Mumbai'),
('1006', 'Shivani', '9999999996', 'Shivani@gmail.com', 'Goa'),
('1007', 'Devashish', '9999999997', 'Devashish@gmail.com', 'Uttrakhand'),
('1008', 'Sarthak', '9999999998', 'Sarthak@gmail.com', 'Delhi');

SELECT * FROM Attendees;

INSERT INTO Registrations 
(Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES 
('10001', '101', '1001', '2023-10-12', '7500'),
('10002', '102', '1003', '2023-09-25', '1000'),
('10003', '103', '1002', '2023-10-29', '2000'),
('10004', '104', '1004', '2023-10-20', '500'),
('10005', '101', '1005', '2023-09-10', '7500'),
('10006', '103', '1008', '2023-09-15', '2000'),
('10007', '101', '1007', '2023-11-01', '7500'),
('10008', '102', '1006', '2023-11-05', '1000');

SELECT * FROM Registrations;

-- Inserting a new event
Insert INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES 
('106', 'Unheard Diaries', '2023-10-29', 'Delhi', 'Storytelling');

-- Updating an event's information
UPDATE Events
SET Event_Location = ‘Mumbai’ WHERE Event_Id = '104';

-- Deleting an event
DELETE FROM Events WHERE Event_Id = '105';

-- Inserting a new attendee
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) 
VALUES ('1009', 'Krishna', '9999999999', 'Krishna@gmail.com', 'Tamil Nadu');

-- Registering an attendee for an event
INSERT INTO Registrations 
(Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) 
VALUES ('10009', '101', '1009', '2023-11-11', '7500');

-- Query to retrieve event information, generate attendee lists, and calculate event
attendance statistics
WITH Event1 AS(
SELECT E.Event_id, E.event_name, E.event_date, E.event_location,
SUM(R.registration_amount) OVER(PARTITION by E.event_id) AS Amountgenperevent
FROM Events E JOIN Registrations R ON E.event_id = R.event_id
JOIN Attendees A ON A.attendee_id = R.attendee_id)
SELECT Event_id, event_name, event_location, Amountgenperevent 
FROM Event1
GROUP BY 1,2,3,4
ORDER BY Amountgenperevent DESC;
