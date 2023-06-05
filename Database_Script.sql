DROP TABLE project cascade constraints;
CREATE TABLE project(
project_no		NUMBER(6) PRIMARY KEY,
project_name		VARCHAR2(30) NOT NULL,
location		VARCHAR2(25) NOT NULL,
project_category	VARCHAR2(16) NOT NULL,
project_start_date 	DATE,
project_end_date 	DATE,       
description  		VARCHAR2(40) NOT NULL,
budget			NUMBER(8) NOT NULL);

--create the project_task table
DROP TABLE project_task cascade constraints;
CREATE TABLE project_task(
task_no			NUMBER(6) PRIMARY KEY,
task_name		VARCHAR2(35) NOT NULL,
task_description 	VARCHAR2(35) NOT NULL,
task_start_date		DATE,
task_end_date		DATE,
project_no		NUMBER(6) REFERENCES project(project_no));

--create the employee table
DROP TABLE employee cascade constraints;
CREATE TABLE employee(
employee_no		NUMBER(6) PRIMARY KEY,
surname			VARCHAR2(15) NOT NULL,
firstnames		VARCHAR2(20) NOT NULL,
address 		VARCHAR2(20) NOT NULL,
town_city		VARCHAR2(20) NOT NULL,
postcode   		VARCHAR2(8) NOT NULL);

--create the volunteer_session table
DROP TABLE volunteer_session cascade constraints;
CREATE TABLE volunteer_session(
    session_no  NUMBER(6) Primary Key,
    sessiondate DATE,
    task_no NUMBER(6) REFERENCES Project_Task(task_no),
    employee_no NUMBER(6) REFERENCES Employee(employee_no),
    session_description VARCHAR2(30) NOT NULL);

--Insert data into project table
INSERT INTO project VALUES (001,'Spurn Nature Reserve','Spurn Head, E Yorks', 'Coastal Reserve', '01/01/2010', '','Marsh and Coast Special Protection Area', 200000);
INSERT INTO project VALUES (002,'Park Wood Conservation','Hutton, Cumbria', 'Woodland Reserve', '01/01/2015', '', 'Ancient Ash Woodland', 550000);
INSERT INTO project VALUES (003,'Yorkshire Dales Protection','Yorkshire Dales, Yorks', 'Upland area', '01/01/2016', '','Hills, rivers, valleys, farms', 1200000);

--Insert data into Project_Task table
INSERT INTO project_task VALUES (1001,'Beach Clean', 'Picking up litter', '12/01/2018', '12/02/2018', 001);
INSERT INTO project_task VALUES (1002,'Beach Clean', 'Picking up litter', '12/08/2018', '12/09/2018', 001);
INSERT INTO project_task VALUES (1003,'Ancient Tree Recording','Updating Ancient tree records', '06/01/2018', '06/06/2018', 002);
INSERT INTO project_task VALUES (1004,'Ancient Tree Recording','Updating Ancient tree records', '07/02/2018', '07/07/2018', 002);
INSERT INTO project_task VALUES (1005,'Farming Support','Dry Stone Walling', '09/16/2018', '09/23/2018', 003); 
INSERT INTO project_task VALUES (1006,'Farming Support','Livestock Counting', '09/16/2018', '09/17/2018', 003);

--Insert data into employee table
INSERT INTO employee VALUES (3312,'Jones', 'Pedro', '31, Ping St', 'Leeds', 'LS16 3PU');
INSERT INTO employee VALUES (3313,'Kaur', 'Sarah', '276, Roundhay Avenue', 'Leeds', 'LS6 3PL');
INSERT INTO employee VALUES (3314,'Arijit', 'Singh', '54, Rohini', 'Leeds', 'LS26 3PL');
INSERT INTO employee VALUES (3315,'Pritam', 'Mehera', '85, Sajorini', 'Leeds', 'LS36 3PL');
INSERT INTO employee VALUES (3316,'Neha', 'Kakar', '20, Chor Bazar', 'Leeds', 'LS46 3PL');
INSERT INTO employee VALUES (3317,'Dino', 'James', '26, Lotus Point', 'Leeds', 'LS56 3PL');

--Insert data into volunteer_session table
INSERT INTO volunteer_session VALUES (110, '05/16/2023', 1001, 3312, 'AI');
INSERT INTO volunteer_session VALUES (111, '05/17/2023', 1001, 3313, 'ML');
INSERT INTO volunteer_session VALUES (112, '05/18/2023', 1002, 3314, 'Python');
INSERT INTO volunteer_session VALUES (113, '05/19/2023', 1003, 3315, 'C++');
INSERT INTO volunteer_session VALUES (114, '05/20/2023', 1004, 3315, 'C');
INSERT INTO volunteer_session VALUES (115, '05/21/2023', 1005, 3316, 'Java');
INSERT INTO volunteer_session VALUES (116, '05/22/2023', 1006, 3316, 'JavaScript');
INSERT INTO volunteer_session VALUES (117, '05/23/2023', 1006, 3317, 'SQL');

--Selecting Query from all Tables from SQL
SELECT * FROM project;
SELECT * FROM project_task;
SELECT * FROM employee;
SELECT * FROM volunteer_session;

--Selecting Specific Columns from table Task 4
SELECT project_name, project_category, location, project_start_date from project; 
SELECT surname, postcode from employee;
SELECT session_no, task_no, session_description, sessiondate from volunteer_session WHERE sessiondate < '03/01/2023';

--Selecting Specific Columns from multiple table Task 5
SELECT project.project_no, project.project_name, project.project_start_date, project_task.task_name, project_task.task_start_date from project, project_task where project.project_no = project_task.project_no;
SELECT employee.firstnames, employee.surname, volunteer_session.sessiondate, volunteer_session.session_description from employee, volunteer_session where employee.employee_no=volunteer_session.employee_no; 
SELECT task_no, COUNT(session_no) FROM volunteer_session GROUP BY task_no HAVING COUNT(session_no)>1;
SELECT e.firstnames || ' ' || e.surname AS employee_name, pt.task_description, p.budget FROM employee e INNER JOIN volunteer_session vs ON e.employee_no = vs.employee_no INNER JOIN project_task pt ON vs.task_no = pt.task_no INNER JOIN project p ON pt.project_no = p.project_no WHERE p.budget > (SELECT AVG(budget) FROM project);
