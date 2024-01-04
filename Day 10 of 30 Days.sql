Q. Write a SQL query to calculate the running total of revenue date-wise and product-wise.


set search_path to shakra; -- for using particular schema in postgresql

create table orders(
	order_Date date,
	product_id int,
	revenue float(25)
);
insert into orders values
('2024-01-01',1,100.0),
('2024-01-01',2,150.0),
('2024-01-02',1,200.0),
('2024-01-02',2,100.0),
('2024-01-03',1,150.0),
('2024-01-03',3,300.0);

select * from orders;

-- with product_wise as(
	select o1.order_Date as od1, o1.product_id, o1.revenue,(
		select sum(o2.revenue) as total_rev
		from orders o2 where o2.product_id=o1.product_id and o2.order_Date<=o1.order_Date) as product_cumu_revenue
	from orders o1 order by o1.product_id;
-- 	),
	
-- date_wise as(
	select o3.order_Date as od2, o3.product_id, o3.revenue,(
		select sum(o4.revenue) as total_rev
		from orders o4 where o4.product_id<=o3.product_id and o4.order_Date=o3.order_Date) as date_cumu_revenue
	from orders o3 order by o3.order_Date;

-- select * from date_wise	join prod_wise on date_wise.od1 = prod_wise.od2;
-- select * from date_wise, prod_wise;
