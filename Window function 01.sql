show databases;
use achiever;
show tables;

create table employee(
emp_id int primary key,
emp_name varchar(50),
dept_name varchar(50),
salary int);

select * from employee;
truncate table employee;
INSERT into employee (emp_id,emp_name,dept_name,salary) 
values (101,'Raj','HR',24000),
(102,'Rajesh','Admin',25000),
(103,'Akash','Finance',23000),
(104,'Prithvi','Finance',15000),
(105,'Dorvin','Admin',17000),
(106,'Rajkuamr','HR',19000),
(107,'Marvik','Finance',14500),
(108,'Rohit','Finance',23000),
(109,'Dev','Analyst',25000),
(110,'Preet','Analyst',17500),
(111, 'Maxie', 'sales', 13969),
(112, 'Blakeley', 'Analyst', 17000),
(113, 'Ray', 'Support', 11597),
(114, 'Minny', 'Support', 10538),
(115, 'Ive', 'Admin', 17415),
(116, 'Chariot', 'HR', 27174),
(117, 'Sheridan', 'sales', 24090),
(118, 'Jamey', 'HR', 22902),
(119, 'Ekaterina', 'HR', 27174),
(120, 'Thorndike', 'Analyst', 16152),
(121, 'Laughton', 'HR', 29067),
(122, 'Hildagard', 'Analyst', 11843),
(123, 'Dredi', 'Admin', 14916),
(124, 'Ryan', 'Sales', 14344),
(125, 'Bryana', 'Sales', 10023),
(126, 'Marietta', 'Finance', 21487),
(127, 'Lilly', 'Admin', 25000),
(128, 'Blanch', 'Support', 28550),
(129, 'Wilden', 'HR', 14838),
(130, 'Lyndsey', 'Admin', 14916);

select dept_name ,count(dept_name) from employee group by dept_name;



select max(salary) from employee;
select dept_name ,max(salary) from employee group by dept_name;
select dept_name , count(dept_name) from employee group by dept_name;
-- delete from employee where dept_name = 'Digital'; 

delete from employee where emp_id = 107;

-- over() syntax- OVER ([PARTITION BY columns] [ ORDER BY columns])

select e.* , max(salary) over () as max_salary from employee e;
select e.*, min(salary) over (partition by dept_name) as min_salary from employee e;


-- row_number(), rank(), dense_rank() -- no argument needed

select e.* ,
row_number() over(partition by dept_name) as rn
from employee e;

-- fetch the first 2 employee from each department to join the company
-- row_number() assigns the next rank for same data, 
-- like if two employee have same salary then rank of both the employee will be different.
select * from(
	select e.*, 
	row_number() 
	over(partition by dept_name order by emp_id ) as rn_id
	from employee e) x
where x.rn_id<3;

-- fetch the top 3 employee in each department earning the max salary
-- rank() function - assigns the same rank for same data,
-- like if two employee have same salary then rank of both the employee will be same 
-- and will skip the current row rank(1,1,3,4,4,6,....)
select * from(
select e.*,
rank() over(partition by dept_name order by salary desc) rank_sal
from employee e) x
where x.rank_sal<4;

-- 
-- dense_rank() funtion - assigns the same rank for same data,
-- like if two employee have the same salary then rank of both the employee will be same 
-- but will not skip the current row rank.(1,1,2,3,3,4,....)
select * from(
	select e.*,
	dense_rank() over(partition by dept_name order by salary desc) as d_rank 
	from employee e) x
where x.d_rank<4;

-- lag(column_name, previous_steps, default), 
-- lead(column_name, next_steps , default)
-- query to display if the salary of an employee is higher, lower or equal to previous employee

select e.* ,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary
from employee e;
select e.*,
lag(salary,2,0) over(partition by dept_name order by emp_id) as prev_emp_salary
from employee e;

select e.* ,
lead(salary) over(partition by dept_name order by emp_id) as next_emp_salary
from employee e;

select e.* ,
lead(salary,2,0) over(partition by dept_name order by emp_id) as next_2_emp_salary
from employee e;

select e.* ,
lag(salary) over(partition by dept_name order by emp_id) as prev_emp_salary,
case when salary< lag(salary) over(partition by dept_name order by emp_id) then 'higher then previous employee'
	 when salary> lag(salary) over(partition by dept_name order by emp_id) then 'lower then previous employee'
     when salary = lag(salary) over(partition by dept_name order by emp_id) then 'same as the previous employee' END sal_range
from employee e;

/*
select e1.emp_id, e1.salary,e1.dept_name,e2.salary, 
case when e1.salary<e2.salary then 'high'
	 when e1.salary>e2.salary then 'low'
     else 'same' end comp_sal
from employee e1 left join employee e2 on e1.emp_id = e2.emp_id+1;
*/


