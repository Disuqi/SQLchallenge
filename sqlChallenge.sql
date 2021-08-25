-- Sakila Challenge

-- 1. List all actors
SELECT * FROM actor;
-- 2. Find the surname of the actor with the forename 'John'
SELECT last_name FROM actor WHERE first_name = 'John';
-- 3. Find all actors with surname 'Neeson'.
SELECT * FROM actor WHERE last_name = 'Neeson';
-- 4. Find all actors with ID numbers divisible by 10
SELECT * FROM actor WHERE actor_id % 10 = 0;
-- 5. What is the description of the movie with an ID of 100?
SELECT description FROM film WHERE film_id = 100;
-- 6. Find every R-rated movie.
SELECT * FROM film WHERE rating = 'R';
-- 7. Find every non-R-rated movie.
SELECT * FROM film WHERE rating != 'R';
-- 8. Find the ten shortest movies.
SELECT * FROM film ORDER BY length DESC LIMIT 10;
-- 9. Find the movies with the longest runtime, without using LIMIT.
SELECT * FROM film WHERE length = (SELECT MAX(length) FROM film);
-- 10. Find all movies that have deleted scenes.
SELECT * FROM film WHERE special_features = '%Deleted Scenes%';
-- 11. Using HAVING , reverse-alphabetically list the last names that are not repeated.
SELECT DISTINCT last_name FROM actor HAVING last_name IS NOT NULL ORDER BY last_name DESC;
-- 12. Using HAVING , list the last names that appear more than once, from highest to lowest frequency.
SELECT COUNT(last_name) AS counter, last_name FROM actor GROUP BY last_name HAVING counter > 1 ORDER BY counter DESC;
-- 13. Which actor has appeared in the most films?
SELECT film_actor.actor_id, actor_info.first_name, actor_info.last_name
,COUNT(film_actor.actor_id) AS films 
FROM film_actor
JOIN actor_info 
ON film_actor.actor_id = actor_info.actor_id
GROUP BY film_actor.actor_id 
ORDER BY COUNT(film_actor.actor_id) DESC LIMIT 1;
-- 14. When is 'Academy Dinosaur' due?
SELECT release_year FROM film WHERE title = 'Academy Dinosaur';
-- 15. What is the average runtime of all films?
SELECT AVG(length) FROM film;
-- 16. List the average runtime for every film category.
SELECT category, AVG(length) FROM film_list GROUP BY category;
-- 17. List all movies featuring a robot.
SELECT description FROM film WHERE description LIKE '%robot%';
-- 18. How many movies were released in 2010?
SELECT COUNT(release_year) FROM film WHERE release_year = 2010;
-- 19. Find the titles of all the horror movies.
SELECT title FROM film_list WHERE category = 'Horror';
-- 20. List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff WHERE staff_id = 2;
-- 21. List all the movies that Fred Costner has appeared in.
SELECT title FROM film_list WHERE actors LIKE '%Fred Costner%';
-- 22. How many distinct countries are there?
SELECT DISTINCT country FROM country;
-- 23. List the name of every language in reverse-alphabetical order.
SELECT name FROM language ORDER BY name DESC;
-- 24. List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%-son' ORDER BY first_name ASC;
-- 25. Which category contains the most films?
SELECT category, COUNT(category) FROM film_list GROUP BY category ORDER BY COUNT(category) DESC LIMIT 1;



--World Challenge SQL

-- 1. Using COUNT, get the number of cities in the USA.
SELECT COUNT(name)
FROM city
WHERE CountryCode = 'USA';
-- 2. Find out the population and life expectancy for people in Argentina.
SELECT population, lifeexpectancy FROM country WHERE name = 'Argentina';
-- 3. Using IS NOT NULL , ORDER BY , and LIMIT , which country has the highest life expectancy?
SELECT name FROM country WHERE lifeexpectancy IS NOT NULL ORDER BY lifeexpectancy DESC LIMIT 1;
-- 4. Using JOIN ... ON , find the capital city of Spain.
SELECT city.name FROM city 
JOIN country ON city.id = country.capital
WHERE country.name = 'Spain';
-- 5. Using JOIN ... ON , list all the languages spoken in the Southeast Asia region.
SELECT countrylanguage.language, count(countrylanguage.language) 
FROM countrylanguage 
JOIN country ON countrylanguage.countrycode = country.code
WHERE country.region = 'Southeast Asia'
GROUP BY countrylanguage.language;
-- 6. Using a single query, list 25 cities around the world that start with the letter F.
SELECT name FROM city WHERE name LIKE 'f%';
-- 7. Using COUNT and JOIN ... ON , get the number of cities in China.
SELECT country.name, COUNT(city.countrycode) 
FROM city 
JOIN country ON city.countrycode = country.code
WHERE country.name = 'China';
-- 8. Using IS NOT NULL , ORDER BY , and LIMIT , which country has the lowest population? Discard non-zero populations.
SELECT name FROM country WHERE population IS NOT NULL ORDER BY population ASC LIMIT 1;
-- 9. Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(code) from country;
-- 10. What are the top ten largest countries by area?
SELECT name FROM country ORDER BY surfacearea DESC LIMIT 10;
-- 11. List the five largest cities by population in Japan.
SELECT name FROM city WHERE countrycode = (SELECT code FROM country WHERE name = 'Japan') ORDER BY population DESC LIMIT 5;
-- 12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country SET headofstate = 'Elizabeth II' WHERE name = 'United Kingdom';
SELECT name, code FROM country WHERE headofstate = 'Elizabeth II';
-- 13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT name, (population/surfacearea) AS ratio FROM country HAVING ratio != 0 ORDER BY ratio ASC LIMIT 10;
-- 14. List every unique world language.
SELECT DISTINCT language FROM countrylanguage;
-- 15. List the names and GNP of the world's top 10 richest countries.
SELECT name, gnp FROM country ORDER BY  gnp DESC LIMIT 10;
-- 16. List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT country.name, COUNT(countrylanguage.language) AS counter 
FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
GROUP BY country.name
ORDER BY  counter DESC LIMIT 10;
-- 17. List every country where over 50% of its population can speak German
SELECT country.name
FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = 'German' AND countrylanguage.percentage > 50;
-- 18. Which country has the worst life expectancy? Discard zero or null values.
SELECT name, MIN(lifeexpectancy) FROM country
WHERE lifeexpectancy IS NOT NULL AND lifeexpectancy != 0;
-- 19. List the top three most common government forms.
SELECT governmentform, COUNT(governmentform) AS counter FROM country
GROUP BY governmentform
ORDER BY counter DESC LIMIT 3;
-- 20. How many countries have gained independence since records began?
SELECT COUNT(indepYear) FROM country WHERE indepYear IS NOT NULL;



--Movielens SQL
-- 1. List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies 
WHERE release_date BETWEEN '1983-01-01' AND '1993-01-01' 
ORDER BY release_date DESC;
-- 2. Without using LIMIT , list the titles of the movies with the lowest average rating.
SELECT movies.title, ratings.rating FROM movies 
JOIN ratings ON movies.id = ratings.movie_id
HAVING ratings.rating < AVG(ratings.rating);
-- 3. List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT * FROM movies 
JOIN genres_movies ON movies.id = genres_movies.movie_id
JOIN ratings ON movies.id = ratings.movie_id
WHERE genres_movies.genre_id = (SELECT id FROM genres WHERE name = 'Sci-Fi')
AND ratings.rating = 5
AND ratings.user_id IN (
	SELECT id FROM users WHERE gender = 'M' AND age = 24 AND occupation_id =(
		SELECT id FROM occupations WHERE name = 'Student'));
-- 4. List the unique titles of each of the movies released on the most popular release day.
SELECT DISTINCT title FROM movies where release_date = (select release_date FROM MOVIES group by release_date order by count(release_date) desc limit 1;)
-- 5. Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT genres.name, COUNT(genres_movies.movie_id) AS counter FROM genres
JOIN genres_movies ON genres.id = genres_movies.genre_id
GROUP BY genres_movies.genre_id
ORDER BY counter ASC;