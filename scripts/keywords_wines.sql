SELECT wines.name, user_structure_count
FROM wines
JOIN keywords_wine 
    ON keywords_wine.wine_id = wines.id
JOIN keywords 
    ON keywords.id = keywords_wine.keyword_id
WHERE keyword_type = 'primary'
    AND keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')
    AND user_structure_count >= 10
GROUP BY wines.name
HAVING COUNT(*) >= 5
ORDER BY user_structure_count DESC
LIMIT 10;