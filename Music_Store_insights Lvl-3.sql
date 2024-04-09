/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

WITH best_selling_artist AS (
	SELECT ar.artist_id AS artist_id, ar.name AS artist_name, SUM(il.unit_price*il.quantity) AS total_sales
	FROM invoice_line il
	JOIN track t ON t.track_id = il.track_id
	JOIN album a ON a.album_id = t.album_id
	JOIN artist ar ON ar.artist_id = a.artist_id
	GROUP BY 1, 2
	ORDER BY 3 DESC
	)
SELECT c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3
ORDER BY 3 DESC;


/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

with MPG as
(SELECT customer.country, genre.name, genre.genre_id, COUNT(invoice_line.quantity) AS purchases,
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 1,2,3
	ORDER BY 1 ASC, 4 DESC
)
SELECT * FROM MPG WHERE RowNo <= 1;


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

with Top_Customer as
(select c.customer_id, c.first_name, c.last_name, c.country, sum(total) as 'Total Spending',
row_number() over(Partition by c.country order by sum(total) desc) as 'Row_no'
from invoice i
join customer c on i.customer_id = c.customer_id
group by 1,2,3,4
order by 4 asc, 5 desc
)
select * from Top_Customer
where Row_no = 1;
