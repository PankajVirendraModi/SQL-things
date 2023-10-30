/*
1) What is a PROCEDURE ?
2) What is the purpose of using a PROCEDURE ?
5) Create procedure with parameters
6) Create procedure for a realistic usecase
*/

/* Syntax to create a procedure
"create or replace procedure" is used to create procedure and 
if there will be any other procedure with the same name then
it will replace the previuos procedure. the default DELIMITER IN SQL is ; but in stored procedure there are more sql query that ends with ; and to avoid this we use DELIMITER $$ ...... $$*/
create or replace procedure procedure_name(p_name varchar, p_age int)
language plpgsql
as $$
declare 
	 variable
begin
	 procedure body - all logics
end;
$$
--symbol  $$v'ari'bal'e'$$ is used to ignore anything inside it and print it as it is. 
select $$ i'm pankaj'$$;


create table products(
-- order_id int primary key,
product_code varchar(255),
product_name varchar(255),
price double precision,
quantity_remaining int,
quantity_sold int
);
-- alter table products rename column order_id to product_code;
-- alter table products aLTER column product_code set data type varchar(255);
insert into products values('P1','iPhone 13 Pro Max',1000,5,195);
Select * from products;
drop table sales;
create table sales(
	order_id serial primary key,
	order_date date,
	product_code varchar(20),
	quantity_ordered int,
	sale_price double precision
);

insert into sales (order_date, product_code, quantity_ordered, sale_price)
values
	('2023-01-10', 'P1', 100, 120000),
    ('2023-01-20', 'P1', 50, 60000),
    ('2023-02-05', 'P1', 45, 540000);
select * from sales;


-- create procedure
-- Create procedure without parameters
create or replace procedure pr_buy_products()
language plpgsql 
as $$
declare
	v_product_code varchar(20);
	v_price float;
begin
	select product_code,price
	into v_product_code, v_price
	from products
	where product_name = 'iPhone 13 Pro Max';
	
	insert into sales (order_date, product_code, quantity_ordered, sale_price)
		values (current_date, v_product_code, 1, (v_price*1));
	
	update products
	set quantity_remaining= (quantity_remaining -1),
		quantity_sold = (quantity_sold+1);
		
	raise notice 'product sold';
end;
$$

-- calling proedure to update the sales and product table
call pr_buy_products()
select * from products;
select * from sales;