-- 1. All information about all actors
select * from actor

-- 2. The titles and descriptions of all films
select title, description from film

-- 3. Names of all categories
select name from category

-- 4. List of actors ordered by last name and first name 
SELECT last_name, first_name FROM actor ORDER BY last_name, first_name


-- 5. Titles and length of all films with a length of more than 120 min ordered by length from highest to lowest
SELECT 
  title, length 
FROM film 
WHERE 
  length > 120 
ORDER BY 
  length DESC

-- 6. Titles of all films with a title starting with 'C'
SELECT title FROM film WHERE title LIKE 'C%'

-- 7. Titles of all films that have in the titles somewhere the phrase 'day'
SELECT title FROM film WHERE title LIKE '%day%'

-- 8. All unique ratings that exist in films
SELECT DISTINCT rating FROM film


-- rental duration in film table is the length of a rental period, in days 
-- rental rate in the film table is the cost to rent the film for the period specified in the rental_duration column (you have to pay the rental_rate for each rental_duraction)
-- 9. Film titles with their rental duration (the length of the rental period, in days) and the rental rate (the cost to rent the film for the period specified in the rental_duration column) 
SELECT rental_duration, rental_rate, (rental_duration * rental_rate) AS total_rent FROM film


-- 10. Film titles and the rental rate per day sorted by this rental rate per day from highest to lowest
SELECT title, rental_duration, rental_rate, (rental_duration * rental_rate) AS total_rent
FROM film ORDER BY total_rent DESC, title ASC

-- 11. Find all the addresses where the district is empty or null
SELECT * FROM address WHERE district IS NULL OR district = ''

-- 12. The total number of films 
SELECT COUNT(DISTINCT film_id) FROM film

-- 13. The shortest film length
SELECT MIN(length) FROM film

-- 14. How many films have a difference between the film replacement cost and the rental rate greater than 17?
?
SELECT (replacement_cost - rental_rate) AS result_ FROM film WHERE result_  > 17

-- 15. Titles of all Sci-Fi movies
?
SELECT title FROM film WHERE title IN ('Sci-Fi')
SELECT title FROM film WHERE title LIKE '%Sci-Fi%'


-- 16. All films in which William Hackman have played
SELECT f.title, ac.first_name, ac.last_name
FROM film f 
	INNER JOIN film_actor fa ON f.film_id = fa.film_id
	INNER JOIN actor ac ON ac.actor_id = fa.actor_id
WHERE ac.actor_id = 175
	
?ac.first_name = 'Willam' AND ac.last_name = 'Hackman'

-- 17. Titles and lengths of films that have the longest length among all films
SELECT title, length FROM film ORDER BY length DESC LIMIT 1

-- 18. Titles and length of all films that are shorter than the average length of all films sorted by lenght in ascending order 

	
-- 19. The number of films per rating
SELECT rating, count(*) FROM film GROUP BY rating ORDER BY count(*) DESC

-- 20. The number of films per language
SELECT l.name, count(f.title) FROM language l
	INNER JOIN film f ON l.language_id = f.language_id
GROUP BY l.name

-- 21. The number of films per category sorted from highest to lowest
SELECT c.name, count(f.title) 
FROM film_category fc
	INNER JOIN film f ON fc.film_id = f.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY count(f.title) DESC


-- 22. Actor id, first name, and last name for all actors who have never appeared in a film rated ‘PG’.
?
SELECT DISTINCT ac.actor_id, ac.first_name, ac.last_name
FROM film f 
	INNER JOIN film_actor fa ON f.film_id = fa.film_id
	INNER JOIN actor ac ON ac.actor_id = fa.actor_id
WHERE f.rating NOT IN ('PG')
ORDER BY actor_id

-- 23. List of actors and the number of films he/she played in ordered by that number from highest to lowest
SELECT ac.first_name, ac.last_name, COUNT(f.title) AS number_of_films
FROM film f 
	INNER JOIN film_actor fa ON f.film_id = fa.film_id
	INNER JOIN actor ac ON ac.actor_id = fa.actor_id
GROUP BY ac.first_name, ac.last_name
ORDER BY number_of_films DESC

-- 24. List of all the customers with id, first and last name who have rented more than 3 horror movies
SELECT c.customer_id, c.first_name, c.last_name, COUNT(cat.name) FROM customer c
	INNER JOIN rental r ON c.customer_id = r.customer_id
	INNER JOIN inventory i ON r.inventory_id = i.inventory_id
	INNER JOIN film_category fc ON i.film_id = fc.film_id
	INNER JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name IN ('Horror')
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(cat.name) > 3

-- 25. How many actors have not acted in any film?
?
SELECT COUNT(*) FROM film_actor WHERE film_id IS NULL


-- 26. How many DVDs are out on rent?



-- 27. Number of rentals per store
SELECT s.store_id, count(r.rental_id) FROM store s
	INNER JOIN staff st ON s.store_id = st.store_id
	INNER JOIN rental r ON st.staff_id = r.staff_id
GROUP BY s.store_id
	
-- 28. All city we have stores in



-- 29. Names of all customers that live in the same country as one of our stores


	
-- 30. List every actor and their total run time of sci-fi films they have been in.


	
-- 31. What are the most common hours when people pay for a dvd rental? Order the payment hours by the number of payments 



-- 32. Longest film rental duration and the customer who rented that film with the title of the film (tipp: not the rental duration in the film table)



-- 33. All customers who have the same first name
?
SELECT first_name, last_name FROM
(
SELECT first_name,last_name,count(*) FROM customer
GROUP BY first_name,last_name
HAVING COUNT(*) > 1
) AS S

-- 34. All films that are available only in one store



-- 35. All stores with their total revenue


-- 36. Create an interesting query of your own that is not already in the assignment. Give, along with the query, the question that the query is answering (as a comment) 
	
