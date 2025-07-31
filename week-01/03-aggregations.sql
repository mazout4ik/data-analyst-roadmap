- [x]  Count how many customers are in each country.

```sql
select count(CustomerId), Country
from customer
group by Country
order by Country asc;
```

- [x]  Show the total number of invoices issued.

```sql
select count(InvoiceId)
from invoice;
```

- [x]  Calculate the average invoice amount.

```sql
select avg(Total)
from invoice;
```

- [x]  Find the **maximum** invoice total.

```sql
select max(Total)
from invoice;
```

- [x]  Count how many tracks belong to each genre.

```sql
select count(t.TrackId), g.Name
from track t join genre g on g.GenreId = t.GenreID
group by g.Name;
```

- [x]  Show total sales (`SUM(Total)`) per billing country.

```sql
select sum(Total) as 'Total Sales', BillingCountry
from invoice
group by BillingCountry
order by sum(Total) desc;
```

- [x]  List countries with **more than 5** invoices.

```sql
select BillingCountry
from invoice
group by BillingCountry
having count(InvoiceId) > 5;
```

- [x]  Calculate total invoice value per customer.

```sql
select sum(Total), CustomerId
from invoice
group by CustomerId;
```

- [x]  Find the number of unique albums per artist.

```sql
select count(a.AlbumId), ar.Name
from album a join artist ar on a.ArtistId = ar.ArtistId
group by ar.Name; 
```

- [x]  List employees grouped by title, with a count per title.

```sql
select Title, count(Title)
from employee
group by Title;
```
