use chinook;

select * from customer;

select FirstName, LastName, Country
from customer
where Country = 'Canada';

select * from track;

select Name, UnitPrice
from track
where UnitPrice > 0.99;

select * from invoice;

select InvoiceId, BillingCountry, Total
from invoice
where Total > 10 and BillingCountry = 'USA';


select * from customer;

select FirstName, LastName, Country
from customer
where Country in ('Germany', 'France');


select * from employee;

select FirstName, LastName, Title
from employee
where Title in ('Sales Support Agent', 'IT Staff');


select * from track;

select Name, UnitPrice
from track
where UnitPrice between 0.99 and 1.99;


select * from customer;

select FirstName, LastName, Email
from customer
where Email like '%.com';

select * from album;

select Title, ArtistId
from album
where ArtistId = 22
order by Title asc;


select * from customer;

select FirstName, LastName, Country
from customer
order by Country asc, LastName asc;




select * from invoice;

select InvoiceId, BillingCountry, Total
from invoice
where BillingCountry = 'Brazil'
order by Total desc;













