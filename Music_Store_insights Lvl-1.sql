/* Q1: Who is the senior most employee based on job title? */ 

select * from employee
order by levels desc
limit 1;


/* Q2: Which countries have the most Invoices? */

select billing_country, count(*) as Invoices_Count from invoice
group by billing_country
order by Invoices_Count desc;


/* Q3: What are top 3 values of total invoice? */

select * from invoice
order by total desc
limit 3;


/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city, sum(total) as Total_Sales from invoice
group by billing_city
order by Total_Sales desc
limit 1;


/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select c.customer_id, c.first_name, c.last_name, sum(total) as Total_spent
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by Total_spent desc
limit 1;



