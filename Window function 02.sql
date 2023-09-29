create database achiever;



create table product(
	product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);
-- desc product;
-- truncate table product;

INSERT INTO product (product_category, brand, product_name, price)
VALUES 
    ('phone', 'Samsung', 'Galaxy S21', 999),
    ('phone', 'Samsung', 'Galaxy A52', 499),
    ('phone', 'Samsung', 'Galaxy Z Flip 3', 1099),
    ('phone', 'Apple', 'iPhone 13 Pro', 1199),
    ('phone', 'Apple', 'iPhone SE', 699),
    ('phone', 'Apple', 'iPhone 12 Mini', 799),
    ('phone', 'OnePlus', 'OnePlus 9 Pro', 899),
    ('phone', 'OnePlus', 'OnePlus Nord N200', 299),
    ('phone', 'OnePlus', 'OnePlus 8T', 749),
    ('phone', 'Xiaomi', 'Mi 11 Lite', 329),
    ('phone', 'Xiaomi', 'Mi 11 Ultra', 1199),
    ('phone', 'Xiaomi', 'Poco X3 Pro', 249),
    ('phone', 'Sony', 'Xperia 1 III', 1299),
    ('headphone', 'Bose', 'Sport Earbuds', 179),
    ('headphone', 'Sony', 'WH-1000XM3', 349),
    ('headphone', 'Sony', 'WF-1000XM4', 279),
    ('headphone', 'Sony', 'WH-XB900N', 249),
    ('headphone', 'Sennheiser', 'Momentum 3', 399),
    ('headphone', 'Sennheiser', 'HD 660 S', 499),
    ('headphone', 'Sennheiser', 'CX 400BT', 179),
    ('headphone', 'Apple', 'AirPods Pro', 249),
    ('headphone', 'Apple', 'AirPods Max', 549),
    ('headphone', 'Apple', 'Beats Solo Pro', 299),
    ('headphone', 'JBL', 'Free X', 149),
    ('headphone', 'JBL', 'Quantum 800', 199),
    ('laptop', 'Dell', 'Inspiron 15', 849),
    ('laptop', 'Dell', 'G5 Gaming Laptop', 1299),
    ('laptop', 'Lenovo', 'ThinkPad X1 Carbon', 1699),
    ('laptop', 'Lenovo', 'Yoga C940', 1199),
    ('laptop', 'Lenovo', 'IdeaPad Flex 5', 699),
    ('laptop', 'HP', 'Spectre x360', 1399),
    ('laptop', 'HP', 'Pavilion 14', 949),
    ('laptop', 'HP', 'Omen 15', 1799),
    ('laptop', 'Acer', 'Aspire 5', 649),
    ('laptop', 'Acer', 'Predator Helios 300', 1299),
    ('earphone', 'Jabra', 'Elite 45h', 99),
    ('earphone', 'Bose', 'Sport Earbuds', 179),
    ('earphone', 'Bose', 'QuietComfort Earbuds', 279),
    ('earphone', 'Bose', 'SoundSport Free', 199),
    ('earphone', 'Sony', 'WF-1000XM4', 279),
    ('earphone', 'Sony', 'WH-CH710N', 199),
    ('earphone', 'Sony', 'WF-XB700', 129),
    ('smartwatch', 'Apple', 'Apple Watch Series 6', 399),
    ('smartwatch', 'Apple', 'Apple Watch SE', 279),
    ('smartwatch', 'Apple', 'Apple Watch Series 3', 199),
    ('smartwatch', 'Samsung', 'Galaxy Watch 4', 249),
    ('smartwatch', 'Samsung', 'Galaxy Watch Active 2', 249),
    ('smartwatch', 'Samsung', 'Galaxy Fit 2', 59),
    ('smartwatch', 'Garmin', 'Forerunner 945', 599),
    ('smartwatch', 'Garmin', 'Vivoac0tive 4', 349),
    ('smartwatch', 'Garmin', 'Instinct', 299),
    ('smartwatch', 'Fitbit', 'Sense', 299);
    
select brand ,count(product_category) from product group by brand ;

-- first_value() - it accepts only one argument
-- query to display the most expensive product(product_name) under each category(corresponding to each record)

select e.* ,
first_value(product_name) over(partition by product_category order by price desc) most_exp_product
from product e ;

select * ,
first_value(price) over(partition by product_category order by price desc) as max_price
from product;

-- last_value() - it accepts only one argument
-- query to diplay least expensive product under each category(corresponding to each record)

select * ,
last_value(product_name) over( partition by product_category order by price desc
range between unbounded preceding and unbounded following 
-- this is frame clause [ range/rows between unbounded preceding and (unbounded following)/(current row) ]
) as least_exp_product
from product;

select * ,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) over( partition by product_category order by price desc
range between unbounded preceding and unbounded following ) as least_exp_product
from product;
-- we can write the above query as follows in easy and well-mannered format

select * ,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product
from product
window w as (partition by product_category order by price desc
range between unbounded preceding and unbounded following);

-- nth_value() - takes two arguments
-- query to display the second most expensive product under each category
select * ,
nth_value(product_name,2) over(partition by product_category order by price) as 2nd_most_exp_product
from product; 


select * ,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product,
nth_value(product_name, 2) over w as second_last_exp_product
from product
window w as (partition by product_category order by price desc
range between unbounded preceding and unbounded following);

-- ntile - used to group together a set of data within your partition and place it into certain buckets,
-- every buckets have about equal data
-- query to segregate all expensive phones, mod-range phones and cheaper phones
select product_name,
case when x.bucket = 1 then 'expensive phone'
	 when x.bucket = 2 then 'mid-range phone'
     when x.bucket = 3 then 'cheaper phone' 
     else 'cheapest phone' end phone_type
from (
	 select *,
	 ntile(4) over (order by price desc) as bucket
	 from product
	 where product_category = 'phone') x;
     
-- cume_dist(Cumulative Distribution) - no arguments required - mathematical formulae - value lies between 0 to 1 
-- formula = current row no/total no of rows
-- queru to fetch all products which are constititing the first 30% of data in products table based on price     
select * ,
cume_dist() over (order by price desc) as cume_distribution
from product;


select *,
round(cume_dist() over(order by price desc)::numeric*100 ,2) as cume_dist_percentage
from product;

select product_name , cume_distribution,(cume_dist_per||'%') from 
	   (SELECT *, 
       cume_dist() OVER (ORDER BY price DESC) AS cume_distribution,
       round(cume_dist() OVER (ORDER BY price DESC)::numeric*100, 2) AS cume_dist_per
FROM product)x
where x.cume_dist_per<30;

-- percent_rank() - (1>= percent_rank >0) - 
-- formulae = (current row no - 1)/(total no of rows - 1)
-- how expensive a product is from table

select product_name, per_rank
from(
	select *,
	percent_rank() over(order by price) as percentage_rank,
	round(percent_rank() over (order by price)::numeric*100,2) as per_rank
	from product) x
where x.product_name = 'OnePlus 9 Pro';