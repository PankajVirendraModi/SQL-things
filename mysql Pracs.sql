SHOW DATABASES;
create database achiever;
use achiever;
CREATE Table customer_info(
id integer auto_increment,
first_name varchar(25) ,
last_name varchar(25) ,
salary integer,
primary key(id));

select * from customer_info;

insert into customer_info (first_name, last_name , salary)
 values
 ('Rajesh','Mehta', 25000),
 ('Raju','DEvgan',34000),
 ('Sikendra','Modi',29000),
 ('Uttam','Barnwal',45000),
 ('Dhruvesh','Sohani',null);
 
 
 -- drop database achiever;
 
select * from customer_info where salary is null;
select * from customer_info where salary is NOT null;
select * from customer_info;
  
update customer_info set salary=NULL where id=5;

delete from customer_info where id = 5;

# ALTER

alter table customer_info add email varchar(30);
update customer_info set email='rajesh@gmail.com' where id=1;
update customer_info set email='Raju@gmail.com' where id=2;
update customer_info set email='Sikendra@gmail.com' where id=3;
update customer_info set email='Uttam@gmail.com' where id=4;

select *  from customer_info;

alter table customer_info add dob date;
alter table customer_info add holidays varchar(25);
alter table customer_info drop holidays;
alter table customer_info add holidays1 varchar(254) not null;
alter table customer_info modify holidays1 varchar(26) not null;
desc customer_info;
alter table customer_info drop holidays1;
alter table customer_info modify dob year;
desc customer_info;
alter table customer_info drop column dob;



## Constraints(NOT NULL, Unique, Primary key, Foreign key, Index, Check, Default)
CREATE Table student(
id integer not null,
first_name varchar(25)  not null,
last_name varchar(25) not null,
age int);
select * fRom student;
desc student;

alter table student modify age int not null;
desc student;
-- Unique 
alter table student ADD unique(first_name);
desc student;
alter table student add constraint uc_student unique(age,first_name);
-- here uc_student is 'Index' assigning 2 features age and first_name as unique
desc student;
alter table student drop index uc_student;

-- Primary key
create table customer1(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
constraint pk_customer primary key(id, first_name));
-- to combine multiple column names in primary key we will use constraint
desc customer1;

alter table customer1 add primary key(id);
alter table customer1 drop primary key;

drop table customer1;
-- Foreign key(A Column of a Table and that Column is Primary key of another table, A table can have multiple Primary key)
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id));
desc person;
alter table person add constraint pk_person primary key(id, first_name);
alter table person drop primary key;
alter table person add constraint pk_person primary key(id, age);
desc person;

create table department(
id int not null,
department_id int not null,
department_name varchar(25) not null,
primary key(department_id),
constraint fk_perdept foreign key(id) references person(id));
desc department;


create table department1(
id int not null,
department_id int not null,
department_name varchar(25) not null,
primary key(department_id)
-- constraint fk_perdept foreign key(id) references person(id)
);
desc department1;
alter table department1 
add constraint foreign key(id) references person(id);
desc department1;

-- Check Constraint
create table customer2(
id int not null,
name varchar(25),
salary int ,
check(salary>50000));
-- desc customer2;
insert into customer2 values(1,'Rajesh',34000);
-- Error Code: 3819. Check constraint 'customer2_chk_1' is violated. As salary <50000
insert into customer2 values(1,'Rajesh',50001);
-- 1 row(s) affected. SUccessful As salary is > 50000


-- DEFAULT CONSTRIANTS
create table person1(
id int not null,
first_name varchar(25)not null,
last_name varchar(25) not null,
city varchar(24) default 'Mumbai'); -- default city id Mumbai
Desc person1;
alter table person1 alter city drop default;
alter table person1 modify city varchar(25) default 'Delhi';
desc person1;

use achiever;


-- SQL Indexes
/* CREATE INDEX statement in SQL is used to create indexes in tables.
The indexes are used to retrieve data from the database more quickly than others.
The User can not see the indexes, and they are just used to speed up queries/searches.
Note: Updating the table with indexes  takes a lot pf time than updating a table without indexes.
It is because the indexes also need an update.
So, only create index on those columns that will be frequently searches against.
*/

create table Vidyarthi(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int);

desc Vidyarthi;

create index index_age
on Vidyarthi(age);
alter table Vidyarthi drop index index_age;
desc Vidyarthi;
create index age_fname_indexees
on Vidyarthi(age, first_name);
DESC Vidyarthi;
alter table Vidyarthi drop index age_fname_indexees;
Drop table Vidyarthi;


use achiever;
show tables;

create table Vidyarthi(
studentId int not null,
first_name varchar(25),
last_name varchar(25),
age int,
primary key(studentId));
desc Vidyarthi;

insert into Vidyarthi values
(1,'Rajesh','mehta',26),
(2,'Jay','Sharma',28),
(3,'Mintu','Sharma',24);

select * from Vidyarthi;

create table departments(
studentId int auto_increment,
dept_name varchar(25) not null,
foreign key(studentId) references Vidyarthi(studentId)
);
desc departments;
insert into departments
values(1,'comp science'),(2,'neet'),(3,'Electrical');

Select * from departments;

-- drop table departments;
create view student_info as 
select first_name, last_name,age from Vidyarthi inner join departments
using(studentID);
DROP VIEW student_info;
-- see restrictions on views click below link
-- https://dev.mysql.com/doc/mysql-reslimits-excerpt/8.0/en/view-restrictions.html 



