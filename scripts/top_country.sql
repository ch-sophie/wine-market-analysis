-- Identify the country with the highest user engagement
-- Engagement index to get users count per wines count
-- For marketing budget to reach a dense population of active consumers

SELECT 
	name as country_name,
	users_count,
	wines_count,
	wineries_count,
	(CAST(users_count AS FLOAT) / wines_count) AS engagement_index
FROM countries 
ORDER BY users_count DESC
LIMIT 1 -- USA