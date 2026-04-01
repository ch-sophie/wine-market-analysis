-- Get 10 countries with best average rating for wines
SELECT 
    c.name AS country_name,
    AVG(w.ratings_average) AS global_average_rating,
    COUNT(w.id) AS total_wines_count
FROM countries c
JOIN regions r ON c.code = r.country_code
JOIN wines w ON r.id = w.region_id
GROUP BY c.name
HAVING total_wines_count >= 5
ORDER BY global_average_rating DESC
LIMIT 10;

-- Get 5 countries with best average rating for vintages
SELECT 
    c.name AS country_name,
    AVG(v.ratings_average) AS avg_vintage_rating,
    AVG(v.price_euros) AS avg_price,
    COUNT(v.id) AS number_of_vintages
FROM countries c
JOIN regions r ON c.code = r.country_code
JOIN wines w ON r.id = w.region_id
JOIN vintages v ON w.id = v.wine_id
GROUP BY c.name
HAVING number_of_vintages >= 5
ORDER BY avg_vintage_rating DESC
LIMIT 5;