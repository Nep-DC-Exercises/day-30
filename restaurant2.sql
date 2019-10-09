-- schema for restaurant2 database 
CREATE TABLE restaurant (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT,
    category TEXT
);

CREATE TABLE reviewer (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    karma INTEGER CHECK (karma >= 0 AND karma <= 7)
);

CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    reviewer_id INTEGER REFERENCES reviewer(id),
    stars INTEGER CHECK (stars >= 0 AND stars <= 5),
    title TEXT,
    review TEXT,
    restaurant_id INTEGER REFERENCES restaurant(id)
);

-- List all the reviews for a given restaurant given a specific restaurant ID.

SELECT review
    FROM review
    WHERE restaurant_id = 1;


-- List all the reviews for a given restaurant, given a specific restaurant name.

SELECT restaurant.id, restaurant.name, review.review
    FROM restaurant
    INNER JOIN review
        ON restaurant.id = review.restaurant_id
    WHERE restaurant.name = 'Nandos';


-- List all the reviews for a given reviewer, given a specific author name.

SELECT reviewer.name, review.review
    FROM reviewer
    INNER JOIN review
        ON reviewer.id = review.reviewer_id
    WHERE reviewer.name = 'Jerry Seinfeld';

-- List all the reviews along with the restaurant they were written for. In the query result, select the restaurant name and the review text.

SELECT restaurant.name, review.review
    FROM review
    LEFT OUTER JOIN restaurant
        ON review.restaurant_id = restaurant.id
    WHERE restaurant.name = 'Chipotle';

-- Get the average stars by restaurant. The result should have the restaurant name and its average star rating.

SELECT restaurant.name, AVG(stars)
    FROM restaurant
    LEFT OUTER JOIN review
        ON restaurant.id = review.restaurant_id
GROUP BY restaurant.name;

-- Get the number of reviews written for each restaurant. The result should have the restaurant name and its review count.

SELECT restaurant.name, COUNT(review.review)
    FROM restaurant
    INNER JOIN review
        ON restaurant.id = review.restaurant_id
GROUP BY restaurant.name;

-- List all the reviews along with the restaurant, and the reviewer's name. The result should have the restaurant name, the review text, and the reviewer name. Hint: you will need to do a three-way join - i.e. joining all three tables together.

SELECT rs.name AS restaurant, rv.review, rr.name AS reviewer_name
    FROM restaurant rs
    INNER JOIN review rv
        ON rs.id = rv.restaurant_id
    INNER JOIN reviewer rr
        ON rv.reviewer_id = rr.id
ORDER BY rr.name;


-- Get the average stars given by each reviewer. (reviewer name, average star rating)

SELECT rr.name, AVG(rv.stars)
    FROM reviewer rr
    INNER JOIN review rv
        ON rr.id = rv.reviewer_id
GROUP BY rr.name;

-- Get the lowest star rating given by each reviewer. (reviewer name, lowest star rating)

SELECT rr.name, MIN(rv.stars)
    FROM reviewer rr
    INNER JOIN review rv
        ON rr.id = rv.reviewer_id
GROUP BY rr.name;

-- Get the number of restaurants in each category. (category name, restaurant count)
SELECT rs.category, COUNT(rs.category)
    FROM restaurant rs
GROUP BY rs.category;

-- Get number of 5 star reviews given by restaurant. (restaurant name, 5-star count)

SELECT rs.name, COUNT(rv.review)
    FROM restaurant rs
    INNER JOIN review rv
        ON rs.id = rv.restaurant_id
    WHERE rv.stars = 5
GROUP BY rs.name;


-- Get the average star rating for a food category. (category name, average star rating)

SELECT rs.category, AVG(rv.stars)
    FROM restaurant rs
    INNER JOIN review rv
        ON rs.id = rv.restaurant_id
GROUP BY rs.category;