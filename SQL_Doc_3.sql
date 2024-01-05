-- select * from actor

-- select * from country

-- select * from film_actor;

-- Inner join on the Actor and film_actor table
select actor.actor_id, first_name, last_name, film_id  
from film_actor 
inner join actor 
on actor.actor_id = film_actor.actor_id;

-- Left Join on the actor and film_actor table
select actor.actor_id, first_name, last_name, film_id
from film_actor
left join actor 
on actor.actor_id = film_actor.actor_id;


-- Join that will produce info about a customer 
-- from the country of Angola
select customer.first_name, customer.last_name, customer.email, country
from customer 
full join address
on customer.address_id = address.address_id 
full join city 
on address.city_id = city.city_id 
full join country on city.country_id = country.country_id 
where country = 'Angola';

-- Subquery Examples
-- Two queries split apart
-- Find a customer_id that has an amount greater than 175 in total payments
select customer_id
from payment 
group by customer_id 
having SUM(amount) > 175
order by SUM(amount) desc;

-- Subquery to do ^^^
select store_id, first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment 
	group by customer_id 
	having SUM(amount) > 175
	order by SUM(amount)desc 
)
group by store_id, first_name, last_name
-- limit 1;

-- find customers in Angola who have a sum amount of purchase > 175
select customer.first_name, customer.last_name, customer.email, country
from customer
inner join address
on customer.address_id = address.address_id 
inner join city
on address.city_id = city.city_id 
inner join country 
on city.country_id = country.country_id 
where country = 'Philippines' and customer_id in (
	select customer_id
	from payment
	group by customer_id 
	having SUM(amount) < 175
	order by SUM(amount) desc
);

-- Basic Subquery
-- Find all films with a language of English
select *
from film 
where language_id in (
	select language_id 
	from language
	where name = 'English'
);

select 
	case 
		when film_id = 1 then 'Film ID One!'
		else 'Not film ID one'
	end 
as is_film_one
from film;
	
Homework
-- 1. List all customers who live in Texas (use JOINs)
select customer.first_name, customer.last_name, address.state
from customer 
inner join address 
on customer.address_id = address.address_id
where address.state = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, payment.amount
from payment 
inner join customer
on payment.customer_id = customer.customer_id
where payment.amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use subqueries)
select customer.first_name, customer.last_name
from customer 
where customer.customer_id in (
	select payment.customer_id
	from payment
	group by payment.customer_id
	having SUM (payment.amount) > 175
);
-- 4. List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, customer.email, country
from customer 
full join address
on customer.address_id = address.address_id 
full join city 
on address.city_id = city.city_id 
full join country on city.country_id = country.country_id 
where country = 'Nepal';

select customer.first_name, customer.last_name
from customer
inner join address
on customer.address_id = address.address_id 
inner join city 
on address.city_id = city.city_id 
inner join country 
on city.country_id = country.country_id 
where country = 'Nepal';

-- 5. Which staff member had the most transactions?
select staff.first_name, staff.last_name, count(*) as transaction
from staff
inner join transaction
on staff.staff_id = transaction.staff_id
group by staff.staff_id, staff.first_name, staff.last_name 
order by transaction desc 
limit 1;

-- 6. How many movies of each rating are there?
select rating.rating, count(*) as num_movies
from movies 
inner join rating
on movies.rating_id = rating.rating_id
group by rating.rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer.first_name, customer.last_name
from customer
where customer.customer_id in (
	select payment.customer_id
	from payment
	where payment.amount > 6.99
	group by payment.customer_id
	having count(*) = 1
);
-- 8. How many free rentals did our stores give away?
select count(*) as num_free_rental
from rental
inner join payment
ON rental.payment_id = payment.payment_id
where payment.amount = 0;