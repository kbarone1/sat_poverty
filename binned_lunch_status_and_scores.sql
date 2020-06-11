/* This query separates the percentages of students receiving free lunch into four categories. It reinforces the finding from
___ query indicating that schools with higher percentages of students receiving free lunch also have lower test scores. */

SELECT  
	CASE 
		WHEN frpm.`Percent (%) Eligible Free (K-12)` <= 0.25 THEN 'low_percentage'
		WHEN (frpm.`Percent (%) Eligible Free (K-12)` > 0.25) AND (frpm.`Percent (%) Eligible Free (K-12)` <= 0.5)   THEN 'med_low_percentage'
		WHEN (frpm.`Percent (%) Eligible Free (K-12)` > 0.5) AND (frpm.`Percent (%) Eligible Free (K-12)` <= 0.75) THEN 'med_high_percentage'
		ELSE 'high_percentage' END  AS perc_students_free_lunch,
	ROUND(AVG(sat.AvgScrMath + sat.AvgScrRead + sat.AvgScrWrite)) AS avg_total_sat_score,
	SUM(frpm.`Enrollment (K-12)`) AS sum_enrolled
FROM frpm 
JOIN satscores sat
ON sat.sname = frpm.`School Name` 
AND sat.dname = frpm.`District Name`
WHERE (sat.AvgScrMath IS NOT NULL) AND (sat.AvgScrRead IS NOT NULL) AND (sat.AvgScrWrite IS NOT NULL)
GROUP BY perc_students_free_lunch
ORDER BY avg_total_sat_score DESC;
