create database consistance;
use consistance;

create table student(
studentId int auto_increment,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(studentId)
);
desc student;
select* from student;

insert into student values(1,'Krish','Naik',25),(2,'Dev','Raj',26),(3,'Rajesh','Mehta',28);


create table department(
studentId int auto_increment,
department_name varchar(25) not null,
foreign key(studentId) references student(studentId)
);
desc department;

insert into department values(1,'Comp Science'),(2,'Mechanical'),(3,'Electrical');
select * from department;

select concat(first_name, ' ', last_name), department_name,age from student 
inner join department 
on student.studentId=department.studentId;
-- ----------------or----------------
select concat(first_name, ' ', last_name), department_name,age from student 
inner join department using(studentId);

-- creating view ---
create view stud_depart_view as
select concat(first_name, ' ', last_name), department_name,age from student 
inner join department 
on student.studentId=department.studentId;

select * from stud_depart_view;
drop view stud_depart_view;
-- ---------------------------------------------------------------------------------------------------
-- JOINS(INNER, OUTER, LEFT, RIGHT, NATURAL, CROSS)
show databases;
use consistance;

select * from student;
insert into student values (4,'Ramesh','Singh',27),(5,'Virendra','Modi',26);
select * from department;

-- INNER JOIN
select * from student Inner join department
on student.studentId=department.studentId;

-- LEFT JOIN
select * from student left join department
on student.studentId= department.studentId;

-- LEFT JOIN
Select * from department left join student 
on department.studentId=student.studentId; 

-- RIGHT JOIN
Select * from student right join department 
on department.studentId=student.studentId;  

-- FULL OUTER JOIN
select * from student left join department
on student.studentId= department.studentId
union
Select * from student right join department 
on department.studentId=student.studentId;  


-- CROSS JOIN(it works without condition, and gives all possible combination)
select concat(student.first_name,' ', student.last_name) as Sname, student.age, department.department_name 
from student cross join department;


-- NATURAL JOIN
select student.first_name, student.last_name, student.age, department.department_name 
from student natural join department; 



