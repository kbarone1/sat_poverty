SELECT  
	satscores_join_frpm.dname AS district,
	schools.City AS city,
	satscores_join_frpm.sname AS school,
	satscores_join_frpm.AvgScrMath + satscores_join_frpm.AvgScrRead + satscores_join_frpm.AvgScrWrite AS total_sat_score,
	ROUND((satscores_join_frpm.`Percent (%) Eligible Free (K-12)`) * 100) AS percent_free_lunch_eligible,
	satscores_join_frpm.`Enrollment (K-12)` AS enrollment
FROM (
	SELECT * 
	FROM satscores sat
	JOIN frpm
	ON sat.sname = frpm.`School Name` 
	AND sat.dname = frpm.`District Name`
	WHERE (sat.AvgScrMath IS NOT NULL) AND (sat.AvgScrRead IS NOT NULL) AND (sat.AvgScrWrite IS NOT NULL)
) satscores_join_frpm
LEFT JOIN schools
ON satscores_join_frpm.sname = schools.School
AND satscores_join_frpm.dname = schools.District
ORDER BY total_sat_score DESC;
