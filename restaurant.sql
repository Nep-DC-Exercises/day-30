CREATE TABLE restaurant (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    distance INTEGER,
    stars INTEGER,
    category TEXT,
    favorite_dish TEXT,
    takeout BOOLEAN,
    last_ate TIMESTAMP  /* Timestamp has date and time. Date just has date */
);

INSERT INTO restaurant (
    name, distance, stars, category, favorite_dish, takeout, last_ate
)
    VALUES 
        ('Poor Calvin''s', 10, 5, 'Southern Asian Fusion', 'Chicken Teryaki Bowl', FALSE, '2019-05-13 22:11:00'),
        ('Lovie''s', 0.2, 3, 'Barbeque', 'Beef Brisket', TRUE, '2019-10-08 12:00:00');

-- Query Practice 

    --  The names of the restaurants that you gave a 5 stars to
SELECT name
    FROM restaurant
    WHERE stars = 5;

    -- The favorite dishes of all 5-star restaurants
SELECT favorite_dish AS dishes
    FROM restaurant
    WHERE stars = 5;

    -- The the id of a restaurant by a specific restaurant name, say 'Moon Tower'
SELECT id
    FROM restaurant
    WHERE name = 'Poor Calvin''s';

    -- restaurants in the category of 'BBQ'
SELECT name
    FROM restaurant
    WHERE category = 'Barbeque'
        OR category LIKE '%bbq&';

    -- restaurants that do take out
SELECT name
    FROM restaurant
    WHERE takeout = 'TRUE';

    -- restaurants that do take out and is in the category of 'BBQ'
SELECT name
    FROM restaurant
    WHERE takeout = 'TRUE'
        AND (category = 'Barbeque'
            OR category LIKE '%bbq&');

    -- restaurants within 2 miles
SELECT name
    FROM restaurant
    WHERE distance <= 2;

    -- restaurants you haven't ate at in the last week
SELECT name
    FROM restaurant
    WHERE last_ate <= '2019-10-02';

    -- restaurants you haven't ate at in the last week and has 5 stars
SELECT name
    FROM restaurant
    WHERE last_ate <= '2019-10-02'
        AND stars = 5;

-- Aggregation and Sorting Queries

    -- list restaurants by the closest distance.
SELECT *
    FROM restaurant
ORDER BY distance ASC;

    -- list the top 2 restaurants by distance.
SELECT *
    FROM restaurant
ORDER BY 
    distance ASC,
    category DESC 
LIMIT 2;

    -- list the top 2 restaurants by stars.
SELECT *
    FROM restaurant
ORDER BY 
    stars DESC 
LIMIT 2;    

    -- list the top 2 restaurants by stars where the distance is less than 2 miles.
SELECT *
    FROM restaurant
    WHERE distance <= 2
ORDER BY 
    stars DESC 
LIMIT 2;

    -- count the number of restaurants in the db.
SELECT COUNT(id)
    FROM restaurant;

    -- count the number of restaurants by category.
SELECT category, COUNT(id)
    FROM restaurant
    GROUP BY category;

    -- get the average stars per restaurant by category.
SELECT category, AVG(stars)
    FROM restaurant
    GROUP BY category;

    -- get the max stars of a restaurant by category.
SELECT category, max(stars)
    FROM restaurant
    GROUP BY category;