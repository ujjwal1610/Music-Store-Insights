/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT  first_name as 'First Name', last_name as 'Last Name', email 
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;	


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select ar.artist_ID, ar.name, count(*) No_of_tracks
from track t
join genre g on t.genre_id = g.genre_id
join album a on t.album_id = a.album_id
join artist ar on a.artist_id = ar.artist_id
where g.name like 'Rock'
group by ar.artist_id, ar.name
order by No_of_tracks desc
limit 10;


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select name,milliseconds
from track
where milliseconds > (select avg(milliseconds)
					from track)
order by milliseconds desc;
