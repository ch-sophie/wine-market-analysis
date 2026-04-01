-- Give 3 awards to the 3 best wineries

-- 1 get best winery for consumers by ratings_count
SELECT 
    w.winery_id, 
    wn.name AS winery_name,
    AVG(w.ratings_average) AS avg_rating,
    SUM(w.ratings_count) AS total_reviews
FROM wines w 
JOIN wineries wn ON w.winery_id = wn.id
GROUP BY w.winery_id 
HAVING total_reviews > 100
LIMIT 1 -- top1 wn Siepi

-- 2 get winery with best wine rating
SELECT 
    wn.name AS winery_name 
    ROUND(AVG(w.ratings_average), 2) AS global_rating,
    SUM(w.ratings_count) AS total_reviews,
    COUNT(w.id) AS number_of_wines
FROM wineries wn 
JOIN wines w ON wn.id = w.winery_id 
GROUP BY wn.id 
HAVING total_reviews > 100 
ORDER BY global_rating DESC
LIMIT 1 -- wn Tenuta Tignanello wine "Solaia"

-- 3 get winery with best value for money wine
SELECT 
    wn.name AS winery_name,
    w.name AS wine_name,
    w.ratings_average AS rating,
    v.price_euros AS price,
    ROUND((w.ratings_average / v.price_euros) * 10, 2) AS value_index
FROM wineries wn 
JOIN wines w ON wn.id = w.winery_id
JOIN vintages v ON w.id = v.wine_id 
WHERE v.price_euros IS NOT NULL
    AND w.ratings_count > 500
    AND v.price_euros < 50
ORDER BY value_index DESC
LIMIT 1 -- wn Tignanello wine "Colheita Porto"
