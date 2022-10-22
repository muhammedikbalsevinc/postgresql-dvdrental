-- 1. All information about all actors
select * from actor

-- 2. The titles and descriptions of all films
select title, description from film

-- 3. Names of all categories
select name from category

-- 4. List of actors ordered by last name and first name 
select last_name, first_name from actor order by last_name, first_name

-- 5. Titles and length of all films with a length of more than 120 min ordered by length from highest to lowest
select title, length from film 
	where length > 120 
	order by length desc

-- 6. Titles of all films with a title starting with 'C'
select title from film where title like 'C%'

-- 7. Titles of all films that have in the titles somewhere the phrase 'day'
select title from film where title like '%day%'

-- 8. All unique ratings that exist in films
select distinct rating from film


-- rental duration in film table is the length of a rental period, in days 
-- rental rate in the film table is the cost to rent the film for the period specified in the rental_duration column (you have to pay the rental_rate for each rental_duraction)
-- 9. Film titles with their rental duration (the length of the rental period, in days) and the rental rate (the cost to rent the film for the period specified in the rental_duration column) 
select rental_duration, rental_rate, (rental_duration * rental_rate) as total_rent from film

-- 10. Film titles and the rental rate per day sorted by this rental rate per day from highest to lowest
select title, rental_duration, rental_rate, (rental_duration * rental_rate) as total_rent
from film order by total_rent desc, title asc

-- 11. Find all the addresses where the district is empty or null
select * from address where district is null or district = ''

-- 12. The total number of films 
select count(film_id) from film

-- 13. The shortest film length
select min(length) from film

-- 14. How many films have a difference between the film replacement cost and the rental rate greater than 17?
select count((replacement_cost - rental_rate)) as r from film having count((replacement_cost - rental_rate))  > 17

-- 15. Titles of all Sci-Fi movies
select f.title, c.name  from film f inner join film_category fc on f.film_id = fc.film_id
	inner join category c on fc.category_id  = c.category_id
	where c.name = 'Sci-Fi'

-- 16. All films in which William Hackman have played
select f.title, ac.first_name, ac.last_name
from film f 
	inner join film_actor fa on f.film_id = fa.film_id
	inner join actor ac on ac.actor_id = fa.actor_id
where ac.first_name = 'William' and ac.last_name = 'Hackman'

-- 17. Titles and lengths of films that have the longest length among all films
select title, length from film 
where length in (
	select max(length) from film
)

-- 18. Titles and length of all films that are shorter than the average length of all films sorted by lenght in ascending order
select title, length from film
where length < (
	select avg(length) from film
)
order by length 

-- 19. The number of films per rating
select rating, count(*) from film group by rating order by count(*) desc

-- 20. The number of films per language
select l.name, count(f.title) from language l
	left join film f on l.language_id = f.language_id
group by l.name

-- 21. The number of films per category sorted from highest to lowest
select c.name, count(f.title) 
from film_category fc
	left join film f on fc.film_id = f.film_id
	left join category c on fc.category_id = c.category_id
group by c.name
order by count(f.title) desc

-- 22. Actor id, first name, and last name for all actors who have never appeared in a film rated ‘PG’.
select distinct ac.actor_id, ac.first_name, ac.last_name, f.rating
from film f 
	inner join film_actor fa on f.film_id = fa.film_id
	inner join actor ac on ac.actor_id = fa.actor_id
where f.rating::text not in ('PG')
order by actor_id;

select distinct ac.actor_id, ac.first_name, ac.last_name, f.rating
from film f 
	inner join film_actor fa on f.film_id = fa.film_id
	inner join actor ac on ac.actor_id = fa.actor_id
where cast(f.rating as text) not in ('PG')
order by actor_id;

-- 23. List of actors and the number of films he/she played in ordered by that number from highest to lowest
select ac.first_name, ac.last_name, count(f.title) as number_of_films
from film f 
	inner join film_actor fa on f.film_id = fa.film_id
	inner join actor ac on ac.actor_id = fa.actor_id
group by ac.first_name, ac.last_name
order by number_of_films desc

-- 24. List of all the customers with id, first and last name who have rented more than 3 horror movies
select c.customer_id, c.first_name, c.last_name, count(cat.name) as rented_horror_movies from customer c
	inner join rental r on c.customer_id = r.customer_id
	inner join inventory i on r.inventory_id = i.inventory_id
	inner join film_category fc on i.film_id = fc.film_id
	inner join category cat on fc.category_id = cat.category_id
where cat.name in ('Horror')
group by c.customer_id, c.first_name, c.last_name
having count(cat.name) > 3

-- 25. How many actors have not acted in any film?
select distinct a.actor_id, count(fa.film_id) from actor a
	left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null
group by a.actor_id

-- 26. How many DVDs are out on rent?
select count(*) from rental where return_date is null

-- 27. Number of rentals per store
select s.store_id, count(r.rental_id) as number_of_rentals from store s
	inner join staff st on s.store_id = st.store_id
	inner join rental r on st.staff_id = r.staff_id
group by s.store_id

-- 28. All city we have stores in
select c.city, s.address_id from city c
	inner join address a on c.city_id = a.city_id
	right join store s on a.address_id = s.address_id

-- 29. Names of all customers that live in the same country as one of our stores
select c.first_name, c.last_name, s.store_id, ctr.country  from store s
	left join address a on s.address_id = a.address_id
	inner join city ct on a.city_id = ct.city_id
	inner join country ctr on ct.country_id = ctr.country_id
	inner join customer c on c.store_id = s.store_id

-- 30. List every actor and their total run time of sci-fi films they have been in.
select a.first_name, a.last_name, sum(length) as total_run_time_SciFi
from film f
	inner join film_category fc on f.film_id = fc.film_id
	inner join category c on fc.category_id  = c.category_id
	inner join film_actor fa on fa.film_id = f.film_id
	inner join actor a on a.actor_id = fa.actor_id
where c.name = 'Sci-Fi'
group by a.first_name, a.last_name
order by total_run_time_SciFi desc

-- 31. What are the most common hours when people pay for a dvd rental? Order the payment hours by the number of payments 
select extract(hour from payment_date), count(payment_date) as payment from payment
group by extract(hour from payment_date)
order by 2 desc

-- 32. Longest film rental duration and the customer who rented that film with the title of the film (tipp: not the rental duration in the film table)	
select c.first_name, c.last_name, f.title, (r.return_date - r.rental_date) as rental_duration from rental r
	inner join customer c on r.customer_id = c.customer_id
	inner join inventory i on i.store_id = c.store_id
	inner join film f on f.film_id = i.film_id 
where (r.return_date - r.rental_date) is not null
order by rental_duration desc
fetch first 1 row with ties;

--with minutes
select c.first_name, c.last_name, f.title,
	(date_part('day', return_date::timestamp - r.rental_date::timestamp ) * 24 +
	date_part('hour', return_date::timestamp - r.rental_date::timestamp )) * 60 +
	date_part('minute', return_date::timestamp - r.rental_date::timestamp ) * 24 as rental_duration_minutes
from rental r
	inner join customer c on r.customer_id = c.customer_id
	inner join inventory i on i.store_id = c.store_id
	inner join film f on f.film_id =i.film_id
where (date_part('day', return_date::timestamp - r.rental_date::timestamp ) * 24 +
	date_part('hour', return_date::timestamp - r.rental_date::timestamp )) * 60 +
	date_part('minute', return_date::timestamp - r.rental_date::timestamp ) * 24 is not null
order by rental_duration_minutes desc
fetch first 1 row with ties;

-- 33. All customers who have the same first name
select first_name, last_name from customer
where first_name in (
select first_name from customer
group by first_name
having count(*) > 1
)
order by first_name

-- 34. All films that are available only in one store
select f.title, count(distinct s.store_id) as store_1_or_2 from film f
	inner join inventory i on f.film_id = i.film_id 
	inner join store s on i.store_id = s.store_id
	group by f.title
having count(distinct s.store_id) not in (2)
order by f.title

-- 35. All stores with their total revenue
select s.store_id, sum(p.amount) as total_revenue from store s
	inner join staff st on s.store_id = st.store_id
	inner join payment p on p.staff_id = st.staff_id
group by 1
	
-- 36. Create an interesting query of your own that is not already in the assignment. Give, along with the query, the question that the query is answering (as a comment) 
select title, rating,
case
	when rating = 'PG' then 1
	when rating = 'R' then 2
	when rating = 'PG-13' then 3
	when rating = 'G' then 4
	when rating = 'NC-17' then 5
end as ratings
from film
