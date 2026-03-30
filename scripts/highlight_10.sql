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