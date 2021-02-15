#PGDSE_SQL_I_CLASS_21.10.2020
create database SQL_I_CLASS;
use SQL_I_CLASS;
CREATE TABLE student (
    st_id INT,
    st_name VARCHAR(256),
    st_address VARCHAR(256),
    st_ph VARCHAR(10),
    email VARCHAR(256),
    city VARCHAR(256)
);
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PGDSE_SQL_I_CLASS_23.10.2020
desc student; # desc <table_name> will describe the structure of the table
SELECT # the keyword SELECT is used to call the columns 
    * # when all columns are called we use *
FROM # it tells the table we will use
    student; # table name
Insert into student (st_id,st_name,st_address,st_ph,email,city) 
values(100,'Shounak','8, Main Road West','9182815211','shounakdasgupta1991@gmail.com','Kolkata'),
(101,'Sushanta','8, Main Road West','9432668816','dasgupta1957@gmail.com','Kolkata'),
(102,'Mousumi','8, Main Road West','9874768525','dasgupta1966@gmail.com','Kolkata'),
(103,'Sayani','8, Main Road West','9916919413','sayani1210@gmail.com','Kolkata'),
(104,'Shreemayi','8, Main Road West','8334885700','dasguptashree@gmail.com','Kolkata'),
(105,'Sagnik',NULL,'8334885700','dasguptashree@gmail.com','Kolkata');
SELECT
    *
FROM
    student;
UPDATE student 
SET 
    st_ph = '9544654716'
WHERE
    st_id = 103;
SELECT
    *
FROM
    student;
UPDATE student 
SET 
    city = 'Chennai';
SELECT
    *
FROM
    student;
UPDATE student 
SET 
    city = 'Bangalore'
WHERE
    st_id = 102;
SELECT
    *
FROM
    student;
DELETE FROM student 
WHERE
    st_name = 'Sayani';
SELECT 
    *
FROM
    student;
alter table student add column age int;
SELECT 
    *
FROM
    student;
alter table student drop column age;
SELECT 
    *
FROM
    student;
alter table student add primary key (st_id);
desc student;
SELECT 
    *
FROM
    student;

SELECT 
    st_id, st_name
FROM
    student
WHERE
    city = 'chennai';
Alter Table student rename column city to Present_City;
SELECT 
    *
FROM
    student;
use hr;
SELECT 
    *
FROM
    employees;
SELECT 
    first_name, last_name
FROM
    employees;
SELECT 
    *
FROM
    employees
WHERE
    employee_id BETWEEN 100 AND 200;
SELECT 
    *
FROM
    employees
WHERE
    employee_id IN (100 , 101, 102);
SELECT 
    *
FROM
    employees
WHERE
    employee_id NOT IN (100 , 101, 102);
SELECT 
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
SELECT 
    *
FROM
    employees
LIMIT 10;
SELECT 
    *
FROM
    employees
LIMIT 2,10;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PGDSE_SQL_I_CLASS_28.10.2020
SELECT 
    *
FROM
    employees
WHERE
    salary > 10000
ORDER BY salary;
SELECT 
    *
FROM
    employees
WHERE
    salary > 10000
ORDER BY salary Desc;
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE 'A%';
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE '%h_';
# WAQ to display the names of the employees whose name has letter 'p' in it
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE '%p%';
# WAQ to display the names of the employees whose name has letter 'h' in the second position and 'a' in the last position
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE '_h%a';
# Creating Table with constrains
CREATE TABLE student_1 (
    st_id INT PRIMARY KEY,
    st_name VARCHAR(256) NOT NULL,
    st_address VARCHAR(256) NOT NULL,
    ph VARCHAR(10) UNIQUE NOT NULL CHECK (LENGTH(ph)=10),
    email VARCHAR(256) UNIQUE NOT NULL,
    city VARCHAR(256) DEFAULT 'Bangalore',
    age INT CHECK (age > 18)
);
INSERT INTO student_1(st_id,st_name,st_address,ph,email,city,age) 
VALUES 
(100,'SHOUNAK SUSHANTA DASGUPTA','8, Main Road West Kolkata','9182815211','shounakdasgupta1991@gmail.com','Kolkata',29),
(101,'BASABDUTTA PAL DASGUPTA','8, Main Road West Kolkata','9874768525','basab1991@gmail.com','Kolkata',25);
INSERT INTO student_1(st_id,st_name,st_address,ph,email,age) 
VALUES 
(102,'SAYANI DAS','8, Main Road West Kolkata','9916919413','sayani1210@gmail.com',30);
SELECT 
    *
FROM
    student_1;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PGDSE_SQL_I_CLASS_30.10.2020
# WAQ to get the department wise salary further display only such rows where the average salary of the department is greater than 10000
SELECT 
    *, ROUND(AVG(salary), 2) AS Sal_avg
FROM
    employees
GROUP BY department_id
HAVING sal_avg > 10000;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PGDSE_SQL_I_CLASS_04.11.2020

# WAQ to get the employee name and the job ID along with the job title for all the employees
SELECT 
    e.first_name, e.last_name, e.job_id, j.job_title
FROM
    employees AS e
        JOIN
    jobs AS j ON e.job_id = j.job_id;
# WAQ to display the names of the employees, department_id, name and the city that he is working in
SELECT 
    e.first_name, e.last_name, d.department_name, l.city
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
        JOIN
    locations AS l ON l.location_id = d.location_id;
# WAQ to display the names of the employees, department_id, name and the city and the region that he is working in
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    l.city,
    r.region_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
        JOIN
    locations AS l ON l.location_id = d.location_id
        JOIN
    countries AS c ON l.country_id = c.country_id
        JOIN
    regions AS r ON c.region_id = r.region_id;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PGDSE_SQL_I_CLASS_06.11.2020
#  WAQ to get the details of the employees along with the names of the departments they work in.Also include such employees in the result set who have not been allotted to any department.
SELECT 
    e.*, d.department_name
FROM
    employees AS e
        LEFT OUTER JOIN
    departments AS d ON e.department_id = d.department_id;
# WAQ to get the details of the employees along with the names of the departments they work in.In the resultset include the names of the departments that are not having any employees working under it.
SELECT 
    e.*, d.department_name
FROM
    employees AS e
        RIGHT OUTER JOIN
    departments AS d ON e.department_id = d.department_id;
# WAQ to get the details of the employees along with the names of the departments they work in.In the resultset include the names employees who are not working in any department and also the names of the departments that are not having any employees working under it.
SELECT 
    e.*, d.department_name
FROM
    employees AS e
        LEFT OUTER JOIN
    departments AS d ON e.department_id = d.department_id 
UNION SELECT 
    e.*, d.department_name
FROM
    employees AS e
        RIGHT OUTER JOIN
    departments AS d ON e.department_id = d.department_id;
# WAQ to display the name of the employees, the department names, job titles of those who are some kind of manager.
SELECT 
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    e.job_id,
    j.job_title
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
        JOIN
    jobs AS j ON j.job_id = e.job_id
WHERE
    j.job_title LIKE '%Manager%';
# WAQ to display the names of the departments and the number of employees working in the department, along with the average salary drawn in the department
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS Emp_Count,
    ROUND(AVG(salary), 2) AS Avg_Sal
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
GROUP BY d.department_name;
#6. WAQ to display the names of the departments and the average salary drawn in the department where the average is more than 10000.
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS Emp_Count,
    ROUND(AVG(salary), 2) AS Avg_Sal
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING Avg_Sal > 10000;
#7. WAQ to display the department ids, names of the departments and the details about the person managing them.
SELECT 
    e.first_name,
    e.last_name,
    d.department_id,
    d.department_name,
    e.manager_id
   FROM
    employees AS e
        JOIN
    departments AS d ON d.manager_id=e.employee_id;
#WAQ to get the names of the employees and details of the person managing them
SELECT 
    e.first_name,
    e.last_name,
    e.manager_id,
    m.first_name,
    m.last_name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id;