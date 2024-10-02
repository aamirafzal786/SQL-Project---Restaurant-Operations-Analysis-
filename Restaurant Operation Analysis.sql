use restaurant_db;
select * from Menu_items;

select * from order_details;
-- OBJECTIVE-1 --

-- View the menu_items table and write a query to find the number of items on the menu --
select category,count(distinct(Item_name)) as Item_Count from menu_items group by category;

-- What are the least and most expensive items on the menu? --
select * from Menu_Items
order by Price;

select * from Menu_Items
order by Price DESC;

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu? --
Select item_name,Price from Menu_items
where category="Italian"
order by Price;

Select * from Menu_items
where category="Italian"
order by Price DESC;

select *
from menu_items
Where category="American"
order by price desc;
-- How many dishes are in each category? What is the average dish price within each category? --
select category,
round(avg(price),2) as Average_price from Menu_Items
Group by category;


-- OBJECTIVE-2 --
-- View the order_details table. What is the date range of the table? --
SELECT * FROM  ORDER_DETAILS;

SELECT min(order_date) as start_date,max(order_Date) as end_date FROM ORDER_DETAILS;
-- How many orders were made within this date range? How many items were ordered within this date range? -- 
 Select count(distinct order_id)as total_orders  from order_Details
 where order_date between '2023-01-01' and '2023-03-31';
 
 select Count(order_details_id) as ordered_items from order_details;
-- Which orders had the most number of items? --
select order_id,count(item_id) as num_items 
from order_details
group by order_id
order by num_items DESC;
-- How many orders had more than 12 items? --
select count(*) as More_then_12_Orders from
(select order_id,count(item_id) from order_details
group by order_id
having count(Item_id) >12) as num_orders
;

-- Objective 3 --
-- Combine the menu_items and order_details tables into a single table --
Select * from order_details o
left join menu_items m
on o.item_id= m.menu_item_id;

-- What were the  most ordered items? What categories were they in? --
Select category,item_name,count(order_details_id) as num_purchases
 from order_details o
left join menu_items m
on o.item_id= m.menu_item_id
group by item_name,category
order by num_purchases desc;

-- What were the least ordered items? What categories were they in? --

Select category,item_name,count(order_details_id) as num_purchases
 from order_details o
left join menu_items m
on o.item_id= m.menu_item_id
group by item_name,category
order by num_purchases asc;

-- What were the top 5 orders that spent the most money? --
Select order_id,sum(price) as total_spend
 from order_details o
left join menu_items m
on o.item_id= m.menu_item_id
Group by order_id
order by total_spend DESC
limit 5;
-- View the details of the highest spend order. Which specific items were purchased?-- 
Select category,count(item_id) as num_items
 from order_details o
left join menu_items m
on o.item_id= m.menu_item_id
where order_id=440
group by category;



-- BONUS: View the details of the top 5 highest spend orders --

Select order_id,category,count(item_id) as num_items
 from order_details o
left join menu_items m
on o.item_id= m.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by category,order_id;

