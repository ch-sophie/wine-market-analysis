SELECT w.name, user_structure_count
FROM wines w 
JOIN keywords_wine kw
    ON kw.wine_id = w.id
JOIN keywords 
    ON keywords.id = kw.keyword_id
WHERE keyword_type = 'primary'
    AND keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')
    AND user_structure_count >= 10
GROUP BY w.name
HAVING COUNT(*) >= 5
ORDER BY user_structure_count DESC
LIMIT 10;