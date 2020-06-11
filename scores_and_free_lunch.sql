SELECT  sub.dname AS district,
schools.City AS city,
sub.sname AS school,
sub.AvgScrMath + sub.AvgScrRead + sub.AvgScrWrite AS total_sat_score,
ROUND((sub.`Percent (%) Eligible Free (K-12)`) * 100) AS percent_free_lunch_eligible,
sub.`Enrollment (K-12)` AS enrollment
FROM (SELECT * 
	FROM satscores sat
	JOIN frpm
	ON sat.sname = frpm.`School Name` 
	AND sat.dname = frpm.`District Name`
	WHERE sat.AvgScrMath IS NOT NULL) sub
LEFT JOIN schools
ON sub.sname = schools.School
AND sub.dname = schools.District
ORDER BY 4 DESC;