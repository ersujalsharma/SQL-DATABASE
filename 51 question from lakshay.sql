CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;
-- DROP TABLE WORKER; 
CREATE TABLE WORKER(
	WORKER_ID INT PRIMARY KEY  auto_increment,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
INSERT INTO WORKER(WORKER_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE, DEPARTMENT) VALUES 
	(001,'Monika','Arora',100000,'14-02-20 09:00:00','HR'),
    (002,'Niharika','Verma',80000,'14-06-11 09:00:00','Admin'),
    (003,'Vishal','Singhal',300000,'14-02-20 09:00:00','HR'),
    (004,'Amitabh','Singh',500000,'14-02-20 09:00:00','Admin'),
    (005,'Vivek','Bhati',500000,'14-06-11 09:00:00','Admin'),
    (006,'Vipul','Diwan',200000,'14-06-11 09:00:00','Account'),
    (007,'Satish','Kumar',75000,'14-01-20 09:00:00','Account'),
    (008,'Geetika','Chauhan',90000,'14-04-11 09:00:00','Admin');
SELECT * FROM WORKER;
CREATE TABLE BONUS(
	WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    foreign key (WORKER_REF_ID) REFERENCES WORKER(WORKER_ID) ON DELETE CASCADE
);
INSERT INTO BONUS (WORKER_REF_ID,BONUS_AMOUNT,BONUS_DATE) VALUES 
	(001,5000,'16-02-20'),
    (002,3000,'16-06-11'),
    (003,4000,'16-02-20'),
    (001,4500,'16-02-20'),
    (002,3500,'16-06-11');
CREATE TABLE TITLE(
	WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) references WORKER(WORKER_ID) ON DELETE CASCADE
);
INSERT INTO TITLE (WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM) VALUES
	(001,'Manager','2016-02-20 00:00:00'),
    (002,'Executive','2016-06-11 00:00:00'),
    (008,'Executive','2016-06-11 00:00:00'),
    (005,'Manager','2016-06-11 00:00:00'),
    (004,'Asst. Manager','2016-06-11 00:00:00'),
    (007,'Executive','2016-06-11 00:00:00'),
    (006,'Lead','2016-06-11 00:00:00'),
    (003,'Lead','2016-06-11 00:00:00');
    
-- 1 Write an SQL Query to fetch "First_Name" from Worker table using alias name as <Worker_Name>.
Select first_name WORKER_NAME from Worker;
-- 2 Write an SQL Query to fetch "First_name from table in upper case"  
Select Upper(first_name) Worker_Name from Worker;
-- 3 fetch unique value of department from worker table
Select distinct(department) from worker; 
-- or
select department from worker group by department;
-- 4 print first three letter of first_name from worker table
Select substring(first_name,1,3) First_Name from worker; 
-- 5 find the position of the alphabet 'b' in first name column Amitabh from worker table.
select instr(first_name,'B') from worker where first_name = 'Amitabh';
-- 6 print first_name from worker table after removing white spaces from right side
select rtrim(first_name) from worker;
-- 7 print first_name from worker table after removing white spaces from left side
select ltrim(first_name) from worker;
-- 8 fetch unique value of department from worker and print its length
select distinct department , length(department) from worker;
-- 9 print first_naem from worker table after replacing 'a' with 'A'
select replace(first_name,'a','A') first_name from worker;	
-- 10 print first-name and last name in one column complete_name 
select concat(first_name,' ',last_name) Complete_Name from worker;
-- 11 print all worker detail from the worker tabl order by first_name ascending
select * from worker order by first_name ASC;
-- 12 print all worker detail from the worker tabl order by first_name ascending department desc
select * from worker order by first_name ASC, department desc;
-- 13 print details for workers with the first_name as Vipul and Satish
select * from worker where first_name = 'Vipul' or first_name = 'Satish';
-- or USING in operator
select * from worker where first_name in ('Vipul','Satish');
-- 14 print details for workers excluding with the first_name as Vipul and Satish
select * from worker where first_name not in ('Vipul','Satish');
-- 15 print details of workers with department name = 'Admin*'
select * from worker where department like 'Admin%';
-- 16 print deatils of workers whose first_name contains 'a'
select * from worker where first_name like '%a%';
-- 17 print details of workers whose first_name ends with 'a'.alter
select * from worker where first_name like '%a';
-- 18 print details of workers whose first_name ends with 'h' and contains six alphabets
select * from worker where first_name like '%h' and length(first_name) = 6;
-- 19 print details of workers whose salary between 100000 and 500000
select * from worker where salary between 100000 and 500000;
--
select * from worker where salary>=100000 and salary <=500000;
-- 20 print details of worker who have joined in feb 2014
select * from worker where year(joining_date) = 2014 and month(joining_date) = '02';
-- 21 fetch the count of employees working in the department 'Admin'
select count(*) Count,department from worker group by department having department = 'Admin';
-- 22 fetch worker full names with salaries >= 50000 and <=100000
select concat(first_name,' ',last_name) Full_Name, salary from worker where salary between 50000 and 100000; 
-- 23 fetch no of workers for each dapartment in descending order
select count(*) No_Of_Employee, Department from worker group by department order by No_Of_Employee desc;
-- 24 print details of workers who are also managers.
select w.* from worker w inner join title t on w.worker_id = t.worker_ref_id where t.worker_title = 'Manager'; 
-- 25 fetch no more than one of diffrent title in the org
select count(*) no_of_worker,worker_title from worker w inner join title t on w.worker_id = t.worker_ref_id group by worker_title having no_of_worker>1;
-- 26 show only odd rows from a table
select * from worker where MOD(worker_id,2)!=0;
-- 27 show only even rows from a table 
select * from worker where MOD(worker_id,2) = 0;
-- 28 clone a new table from another table 
create table worker_clone like worker;
insert into worker_clone select * from worker;
select * from worker_clone;
-- 29 fetch intersecting records of two tables
select worker.* from worker inner join worker_clone using(worker_id);
-- 30 write a sql query to show records from one table that another table does not have.
-- minus operation 
select worker.* from worker left join worker_clone using(worker_id) where worker_clone.worker_id is null;
-- 31 show current date and time;
select curdate();
select now();
-- 32 show the top n (say 5) records of a table order by descending salary
select * from worker order by salary limit 5;
-- 34 determine the nth highest salary from the table
select * from worker w1 where 5 = (
	select count(salary) from worker w2 where w2.salary>=w1.salary);
-- 33 determine the nth highest salary from the table
select * from worker order by salary desc limit 4,1;
-- 35 fetch the list of employee with the same salary
select * from worker w1 inner join worker w2 where w1.salary = w2.salary and w1.worker_id<>w2.worker_id;
-- 36 show the second highest salary from the table using subquery
select max(salary) from worker where salary < (select max(salary) from worker);
select max(salary) from worker where salary < (select max(salary) from worker where salary < (select max(salary) from worker));
-- 37  show one row twice in result from a table
select * from worker 
union all
select * from worker order by worker_id;
-- 38 list worker id who does not get bonus
select worker_id from worker where worker_id not in (select worker_ref_id from bonus);
-- 39 fetch first 50% records from table 
select * from worker where worker_id<=(select count(WORKER_ID)/2 from worker);
-- 40 fetch department that have less than 4 people in it.
select department,count(department) as depCount from worker group by department having depCount < 4;
-- 41 show all departments along with the number of people in their 
select department,count(*) from worker group by department;
-- 42 show the last record of the table
select * from worker where worker_id = (select max(worker_id) from worker);
-- 43 fetch first row of the table
select * from worker where worker_id = (select min(worker_id) from worker);
-- 44 fetch last 5 record
(select * from worker order by WORKER_ID desc limit 5) order by worker_id;
-- 45 print the name of employee having the highest salary in each department
select * from worker where salary in (select max(SALARY) from worker group by department);
-- 46 fetch 3 max salaries form a table using co-related subquery
select distinct w1.salary from worker w1 where 3>=(select count(distinct salary) from worker w2 where w2.salary >=w1.salary) order by w1.salary desc;
-- 47 fetch 3 min salary from a table usign co- realated subquery.
select distinct w1.salary from worker w1 where 3>=(select count(distinct salary) from worker w2 where w2.salary <=w1.salary) order by w1.salary desc;
-- 48 nth max salary
select distinct w1.salary from worker w1 where n>=(select count(distinct salary) from worker w2 where w2.salary <=w1.salary) order by w1.salary desc;
-- 49 fetch department along with their total salaries paid for each of them
select sum(salary) Total,department from worker group by department;
-- 50 fetch the name of workers who earn the highest salary
select * from worker where salary = (select max(salary) from worker);
-- 51 