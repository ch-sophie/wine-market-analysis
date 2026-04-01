-- Get 10 wines best value for money where price < 50
SELECT 
    w.name AS wine_name,
    r.name AS region,
    c.name AS country,
    w.ratings_average AS rating_average,
    w.ratings_count AS rating_count,
    AVG(v.price_euros) AS average_price
FROM wines w
JOIN regions r ON w.region_id = r.id
JOIN countries c ON r.country_code = c.code
JOIN vintages v ON w.id = v.wine_id
  AND w.ratings_average >= 4.3
  AND v.price_euros < 50
GROUP BY w.id, w.name, r.name, c.name, w.ratings_average, w.ratings_count
HAVING rating_count > 100
ORDER BY w.ratings_average DESC, average_price ASC
LIMIT 10;