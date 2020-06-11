SELECT  
CASE 
  WHEN frpm.`Percent (%) Eligible Free (K-12)` <= 0.25 THEN 'low_percentage'
  WHEN (frpm.`Percent (%) Eligible Free (K-12)` > 0.25) AND (frpm.`Percent (%) Eligible Free (K-12)` <= 0.5)   THEN 'med_low_percentage'
  WHEN (frpm.`Percent (%) Eligible Free (K-12)` > 0.5) AND (frpm.`Percent (%) Eligible Free (K-12)` <= 0.75) THEN 'med_high_percentage'
  ELSE 'high_percentage' END  AS perc_students_free_lunch,
ROUND(AVG(sat.AvgScrMath + sat.AvgScrRead + sat.AvgScrWrite)) AS total_sat_score,
SUM(frpm.`Enrollment (K-12)`) AS sum_enrolled
FROM frpm 
JOIN satscores sat
ON sat.sname = frpm.`School Name` 
AND sat.dname = frpm.`District Name`
WHERE sat.AvgScrMath IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;
