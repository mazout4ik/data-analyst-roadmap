use chinook;
select * from album;
select title from album;
select * from customer;
select count(customerid) from customer;
select * from mediatype;
select * from genre;
select * from invoice;
select distinct billingcity from invoice;
select count(distinct billingcity) from invoice;
select * from invoice
where billingcity = "Oslo";
