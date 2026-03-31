-- Highlight 10 wines to increase sales
-- Join vintages and wines for price and year
-- Select high rating average (> 4.5) and high rating count (> 1000)

SELECT 
    w.name AS wine_name,
    v.name AS vintage_name,
    w.ratings_average,
    w.ratings_count,
    v.price_euros,
    v.year
FROM wines w
JOIN vintages v ON w.id = v.wine_id
WHERE w.ratings_count > 1000  -- Ensuring social proof
ORDER BY w.ratings_count DESC
LIMIT 10;

-------------------------------------------
-- Get top 10 wines and group by so it's different wines - not the same wine 2015, 2016, 2017
SELECT
    w.name,
    c.name AS country,
    w.ratings_average,
    w.ratings_count,
    AVG(v.price_euros) AS avg_price,
    MIN(v.price_euros) AS entry_price,
    MAX(v.year) AS most_recent_vintage,
    COUNT(v.id) AS vintage_count,
    (w.ratings_average * LOG(w.ratings_count)) AS score
FROM wines w
JOIN regions r ON w.region_id = r.id
JOIN countries c ON r.country_code = c.code
LEFT JOIN vintages v ON v.wine_id = w.id
AND v.price_euros IS NOT NULL
WHERE w.ratings_count > 1000
GROUP BY w.id, w.name, w.ratings_average, w.ratings_count, c.name
ORDER BY score DESC
LIMIT 10;