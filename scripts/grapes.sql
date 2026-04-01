-- SELECT * FROM grapes 

-- Get 3 most used grapes in wines and occurences
SELECT grape_id, COUNT(id) AS occurences
FROM most_used_grapes_per_country
GROUP BY grape_id
ORDER BY occurences DESC 
-- Result grape_id 2, 10, 5
-- in values 2 Cabernet Sauvignon, 10 Merlot, 5 Chardonnay 

-- Get name of 3 most used grapes and occurences
SELECT 
	g.name, 
	COUNT(*) AS occurences
FROM grapes g 
JOIN most_used_grapes_per_country mugpc ON g.id = mugpc.grape_id 
GROUP BY mugpc.grape_id  
ORDER BY occurences DESC

-- Get only wines with these 3 grapes
SELECT g.name AS grape_name, w.name AS wine_name, w.ratings_average
FROM grapes g 
JOIN most_used_grapes_per_country mugpc ON g.id = mugpc.grape_id 
JOIN regions r ON mugpc.country_code = r.country_code 
JOIN wines w ON r.id = w.region_id 
WHERE g.name IN ('Cabernet Sauvignon', 'Merlot', 'Chardonnay')

-- Get 5 best rated wines for each grapes
WITH RawList AS (
    SELECT 
        g.name AS grape_name,
        w.name AS wine_name,
        w.ratings_average,
        ROW_NUMBER() OVER (PARTITION BY g.name ORDER BY w.ratings_average DESC) as rank
    FROM grapes g
    JOIN most_used_grapes_per_country mug ON g.id = mug.grape_id
    JOIN regions r ON mug.country_code = r.country_code
    JOIN wines w ON r.id = w.region_id
    WHERE g.name IN ('Chardonnay', 'Merlot', 'Cabernet Sauvignon')
)
SELECT grape_name, wine_name, ratings_average
FROM RawList
WHERE rank <= 5;