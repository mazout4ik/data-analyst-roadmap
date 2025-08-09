use chinook;

-- INNER JOIN ex.:
-- only the matches between the two tables

SELECT c.FirstName, c.LastName, i.InvoiceId
FROM Customer c INNER JOIN Invoice i ON c.CustomerId = i.CustomerId;





-- LEFT JOIN ex.:
-- All from Left and matches & NULL from Right

SELECT c.FirstName, c.LastName, i.InvoiceId
FROM Customer c LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId;



-- FULL OUTER JOIN ex.:
-- ALL rows from BOTH tables, match or no match

SELECT c.FirstName, c.LastName, i.InvoiceId
FROM Customer c FULL OUTER JOIN Invoice i ON c.CustomerId = i.CustomerId; -- not in MySQL

-- ========================================================================================================

-- Show all invoices with the customer’s first and last name
select i.InvoiceID, c.FirstName, c.LastName
from invoice i inner join customer c on i.CustomerId = c.CustomerId
order by i.InvoiceId asc;


-- List all invoice lines with the track name.
select il.InvoiceLineId, t.Name
from invoiceline il inner join track t on il.TrackId = t.TrackId
order by il.InvoiceLineId asc;


-- Display all albums with their artist name
select a.Title, ar.Name
from album a inner join artist ar on a.ArtistId = ar.ArtistId
order by a.Title asc;


-- List all tracks with their genre name
select t.Name, g.Name
from track t inner join genre g on t.GenreId = g.GenreId
order by t.Name asc;


-- Show all tracks with the album title and media type
select t.Name Track, a.Title Album, m.Name Media
from track t inner join album a on t.AlbumId = a.AlbumId
			inner join mediatype m on t.MediaTypeId = m.MediaTypeId
order by t.Name asc;


-- Find all employees and the customers they support (Employee → Customer).
select e.FirstName Employee_Fname, e.LastName Employee_Lname, c.FirstName CustomerFname, c.LastName Customer_Lname
from employee e inner join customer c on c.SupportRepId = e.EmployeeId
order by e.EmployeeId asc;


-- Show all customers and their invoice total
select c.FirstName, c.LastName, sum(i.Total) Total_spent
from customer c inner join invoice i on c.CustomerId = i.CustomerId
group by c.CustomerId
order by Total_spent desc;



-- List all invoice lines with track name and unit price
select il.InvoiceLineId, t.Name, t.UnitPrice
from invoiceline il inner join track t on il.TrackId = t.TrackId
order by il.InvoiceLineId asc;


-- Display each track with its playlist name (track in a playlist).
select t.Name Track, p.Name Playlist
from track t inner join playlisttrack pt on t.TrackId = pt.TrackId
			inner join playlist p on pt.PlaylistId = p.PlaylistId
order by t.Name asc;


-- List all invoices with the billing country and related customer name.
select i.InvoiceId, i.BillingCountry Country, c.FirstName, c.LastName
from invoice i inner join customer c on i.CustomerId = c.CustomerId
order by i.InvoiceId asc;


-- Show all customers and any invoices they may have
select c.FirstName, c.LastName, i.InvoiceId
from customer c left join invoice i on i.CustomerId = c.CustomerId
order by c.LastName;


-- List all employees and the customers they support, even if they support none
select e.FirstName Employee_Fname, e.LastName Employee_Lname, c.FirstName Customer_Fname, c.LastName Customer_Lname
from employee e left join customer c on c.SupportRepId = e.EmployeeId
order by e.LastName;


-- Display all artists and their albums (include artists with no albums)
select ar.Name, a.Title
from artist ar left join album a on ar.ArtistId = a.ArtistId
order by ar.Name;


-- Show all playlists and any tracks they have (even if empty)
select p.Name Playlist, t.Name Track
from playlist p left join playlisttrack pt on p.PlaylistId = pt.PlaylistId
				inner join track t on t.TrackId = pt.TrackId
order by p.Name;


select count(table1.Track)
from (select p.Name Playlist, t.Name Track
from playlist p left join playlisttrack pt on p.PlaylistId = pt.PlaylistId
				inner join track t on t.TrackId = pt.TrackId
order by p.Name) as table1; -- checks for left/inner join output


-- List all customers and their support rep (employee), even if missing
select c.FirstName Customer_Fname, c.LastName Customer_Lname, e.FirstName Employee_Fname, e.LastName Employee_Lname
from customer c left join employee e on c.SupportRepId = e.EmployeeId
order by c.LastName asc;


-- Show all albums and related tracks, including albums without tracks
select a.Title, t.Name
from album a left join track t on a.AlbumId = t.AlbumId
order by a.Title;


-- List all media types and any tracks they have (include unused media types)
select m.Name Media, t.Name Track
from mediatype m left join track t on t.MediaTypeId = m.MediaTypeId
order by m.Name asc;


-- Display all genres and any tracks in them (include empty genres)
select g.Name Genre, t.Name Track
from genre g left join track t on g.GenreId = t.GenreId
order by g.Name asc;


-- Show all customers with their invoice totals if any, else NULL
select c.firstName Customer_Fname, c.LastName Customer_Lname, sum(i.Total) Total_spent
from customer c left join invoice i on i.CustomerId = c.CustomerId
group by c.CustomerId 
order by sum(i.Total) desc;


-- List all employees with the number of customers they support (use LEFT JOIN with GROUP BY)
select e.EmployeeId, count(c.CustomerId) Number_of_customers
from employee e left join customer c on e.EmployeeId = c.SupportRepId
group by e.EmployeeId
order by 2 desc;

select * from employee;


-- Find the total sales per customer, including customers with no sales (LEFT JOIN)
select c.firstName Customer_Fname, c.LastName Customer_Lname, sum(i.Total) Total_spent
from customer c left join invoice i on i.CustomerId = c.CustomerId
group by c.CustomerId 
order by sum(i.Total) desc;


-- List all artists with the number of albums they have
select ar.Name Artist, count(a.AlbumId) Number_of_albums
from artist ar left join album a on a.ArtistId = ar.ArtistId
group by ar.ArtistId
order by 2 desc;


-- Show all playlists with the count of tracks in each (including empty playlists)
select p.PlaylistId, p.Name Playlist, count(t.TrackId) Number_of_tracks
from playlist p left join playlisttrack pt on p.PlaylistId = pt.PlaylistId
				left join track t on t.TrackId = pt.TrackId
group by p.PlaylistId
order by 2 desc;

select * from playlist;


-- Display all employees and how many customers they support
select e.EmployeeId, count(c.CustomerId) Number_of_customers
from employee e left join customer c on e.EmployeeId = c.SupportRepId
group by e.EmployeeId
order by 2 desc;


-- Find the total invoice amount per billing country (use JOIN if needed)
select i.BillingCountry, round(sum(i.Total),0) Total_spent
from invoice i
group by 1
order by 2 desc;


-- Show all customers with their support rep name and total sales
select c.FirstName Customer_Fname, c.LastName Customer_lname, e.FirstName Rep_Fname, e.LastName Rep_Lname, sum(i.Total) Total_spent
from customer c left join employee e on c.SupportRepId = e.EmployeeId
				left join invoice i on c.CustomerId = i.CustomerId
group by c.CustomerId
order by 5 desc;


-- List all albums with the total number of tracks
select a.Title, count(t.TrackId)
from album a left join track t on t.albumId = a.AlbumId
group by a.AlbumId
order by 2 desc;


-- Show all genres with the total duration of tracks
select g.Name Genre, sum(t.Milliseconds) Total_duration_ms
from genre g left join track t on g.GenreId = t.GenreId
group by g.GenreId
order by 2 desc;


select * from track;


-- Find all artists who have more than 5 albums (use JOIN + GROUP BY + HAVING)
select ar.Name Artist, count(a.AlbumId) Number_of_albums
from artist ar left join album a on ar.ArtistId = a.ArtistId
group by ar.ArtistID
having count(a.AlbumId) > 5
order by 2 desc;


-- Show all customers with their last invoice date (LEFT JOIN)
select c.FirstName Customer_Fname, c.LastName Customer_Lname, max(i.InvoiceDate) last_invoice_date
from customer c left join invoice i on i.CustomerId = c.CustomerId
group by c.CustomerId
order by 3 desc;




select * from invoice;




