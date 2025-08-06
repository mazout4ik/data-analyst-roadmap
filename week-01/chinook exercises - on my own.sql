use chinook;


-- Count how many customers are in each country.

select * from customer;

select count(CustomerId), Country
from customer
group by Country
order by Country asc;


select * from invoice;

select count(InvoiceId)
from invoice;

select avg(Total)
from invoice;

select max(Total)
from invoice;


select * from track;

select count(t.TrackId), g.Name
from track t join genre g on g.GenreId = t.GenreID
group by g.Name;


select * from invoice;

select sum(Total) as 'Total Sales', BillingCountry
from invoice
group by BillingCountry
order by sum(Total) desc;



select * from invoice;

select BillingCountry
from invoice
group by BillingCountry
having count(InvoiceId) > 5;



-- Calculate total invoice value per customer.

select * from invoice;

select sum(Total), CustomerId
from invoice
group by CustomerId;

select * from customer;

select * from album;

select count(a.AlbumId), ar.Name
from album a join artist ar on a.ArtistId = ar.ArtistId
group by ar.Name; 

select * from artist;



-- List employees grouped by title, with a count per title.

select * from employee;

select Title, count(Title)
from employee;
group by Title;



-- Customers who have spent more than $45 total (from Invoice)

select * from invoice;

select CustomerId, sum(Total)
from invoice
group by CustomerId 
having sum(Total) > 45;


-- Which countries have the most Invoices? Use the Invoice table to determine the countries that 
-- have the most invoices. Provide a table of BillingCountry and Invoices ordered by the number of 
-- invoices for each country. The country with the most invoices should appear first.


select * from invoice;

select count(InvoiceId) as No_of_invoices, BillingCountry
from invoice
group by BillingCountry
order by 1 desc;


-- Which city has the best customers? We would like to throw a promotional Music Festival in 
-- the city we made the most money. Write a query that returns the 1 city that has the highest sum of 
-- invoice totals. Return both the city name and the sum of all invoice totals.


select * from invoice;

select BillingCity, sum(Total) as Total_sales
from invoice
group by BillingCity 
order by 2 desc 
limit 1;



-- Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Build a query that returns the person who has spent the most money. I found the solution by linking the 
-- following three: Invoice, InvoiceLine, and Customer tables to retrieve this information, but you can 
-- probably do it with fewer!



select * from invoice;

select c.FirstName, c.LastName, sum(i.Total) Total_spent
from invoice i join customer c on i.CustomerId = c.CustomerId
group by i.CustomerId
order by sum(i.Total) desc
limit 1;


 
-- Use your query to return the email, first name, last name, and Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email address starting with A.


select distinct c.Email, c.FirstName, c.LastName, g.Name
from customer c join invoice i on c.CustomerId = i.CustomerId
				join invoiceline il on i.InvoiceId = il.InvoiceId
				join track t on t.TrackId = il.TrackId
				join genre g on g.GenreId = t.GenreId
where g.Name = "Rock"
order by c.Email asc;




 -- Who is writing the rock music? Now that we know that our customers love rock music, 
 -- we can decide which musicians to invite to play at the concert.


select * from track;

select distinct t.Composer, g.Name
from track t join genre g on g.GenreId = t.GenreId
where g.Name = "Rock";


-- Let’s invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.


select distinct t.Composer, a.Name
from artist a, track t
where t.Composer is not null
order by 1 asc;


select distinct t.Composer, g.Name, count(t.TrackId)
from track t join genre g on g.GenreId = t.GenreId
where g.Name = "Rock" and t.Composer is not null
group by t.Composer
order by count(t.TrackId) desc;


select distinct a.Name, g.Name, count(t.Name)
from track t 
	join genre g on g.GenreId = t.GenreId
	join artist a on t.Composer = a.Name
where g.Name = "Rock" and t.Composer is not null
group by t.Composer
order by count(t.Name) desc;


SELECT AR.NAME,
  	COUNT(T.NAME)
  FROM TRACK T
  JOIN GENRE G ON T.GENREID = G.GENREID
  JOIN ALBUM AL ON AL.ALBUMID = T.ALBUMID
  JOIN ARTIST AR ON AR.ARTISTID = AL.ARTISTID
  WHERE G.NAME = 'Rock'
  GROUP BY 1
  ORDER BY 2 desc
limit 1;



-- Now use this artist to find which customer spent the most on this artist.

-- For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.

-- Notice, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
-- so you need to use the InvoiceLine table to find out how many of each product was purchased, 
-- and then multiply this by the price for each artist.



select c.CustomerId, c.FirstName, c.LastName, il.InvoiceId, sum(il.UnitPrice * il.Quantity) as Cost 
from invoice i join customer c on c.CustomerId = i.CustomerId
				join invoiceline il on il.InvoiceId = i.InvoiceId
				join track t on t.TrackId = il.TrackId
				join album a on t.AlbumId = a.AlbumId
				join artist ar on ar.ArtistId = a.ArtistId,
				(SELECT AR.NAME Artist,
  	COUNT(T.NAME)
  FROM TRACK T
  JOIN GENRE G ON T.GENREID = G.GENREID
  JOIN ALBUM AL ON AL.ALBUMID = T.ALBUMID
  JOIN ARTIST AR ON AR.ARTISTID = AL.ARTISTID
  WHERE G.NAME = 'Rock'
  GROUP BY 1
  ORDER BY 2 desc
limit 1) as t1
where ar.Name = t1.Artist
group by InvoiceId
order by Cost desc
limit 5;


