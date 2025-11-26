#Task1:Total number of companies per industry
SELECT ci.industry, COUNT(c.company_id) AS total_companies
FROM company_industry ci
JOIN companies c ON ci.company_id = c.company_id
GROUP BY ci.industry;
#Task2:List all companies in 'Technology' industry
SELECT c.name
FROM companies c
JOIN company_industry ci ON c.company_id = ci.company_id
WHERE ci.industry='Technology';
#Task3:Average employee count per industry
SELECT ci.industry, AVG(ec.employee_count) AS avg_employee_count
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry;
#task4:Maximum employee count per industry
SELECT ci.industry, MAX(ec.employee_count) AS max_employee_count
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry;
#task5:Minimum employee count per industry
SELECT ci.industry, MIN(ec.employee_count) AS min_employee_count
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry;
##task6:Industries with companies having >1000 employees
SELECT ci.industry, COUNT(c.company_id) AS large_companies
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
JOIN companies c ON ci.company_id = c.company_id
WHERE ec.employee_count > 1000
GROUP BY ci.industry;
#task7:Industries with companies having <50 employees
SELECT ci.industry, COUNT(c.company_id) AS small_companies
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
JOIN companies c ON ci.company_id = c.company_id
WHERE ec.employee_count < 50
GROUP BY ci.industry;
#task8:Industries sorted by total employees
SELECT ci.industry, SUM(ec.employee_count) AS total_employees
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry
ORDER BY total_employees DESC;
#task9:Industries with average employee count >500
SELECT ci.industry, AVG(ec.employee_count) AS avg_employee_count
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry
HAVING AVG(ec.employee_count) > 500;

#task10:Industries with no employee data
SELECT ci.industry
FROM company_industry ci
LEFT JOIN employee_counts ec ON ci.company_id = ec.company_id
WHERE ec.employee_count IS NULL
GROUP BY ci.industry;

#task11:Total job postings per industry
SELECT i.industry_name, COUNT(p.job_id) AS total_jobs
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN postings p ON ji.job_id = p.job_id
GROUP BY i.industry_name;

#task12:Average median salary per industry
SELECT i.industry_name, AVG(s.med_salary) AS avg_median_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name;

#task13:Maximum salary per industry
SELECT i.industry_name, MAX(s.max_salary) AS max_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name;

#task14:Minimum salary per industry
SELECT i.industry_name, MIN(s.min_salary) AS min_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name;

#task15 Number of postings per company per industry
SELECT ci.industry, c.name AS company_name, COUNT(p.job_id) AS job_count
FROM postings p
JOIN companies c ON p.company_id = c.company_id
JOIN company_industry ci ON c.company_id = ci.company_id
GROUP BY ci.industry, c.name;
#task16:Industries with average median salary > 50000
SELECT i.industry_name, AVG(s.med_salary) AS avg_med_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name
HAVING AVG(s.med_salary) > 50000;

#task17:Industries with maximum postings
SELECT i.industry_name, COUNT(p.job_id) AS total_jobs
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN postings p ON ji.job_id = p.job_id
GROUP BY i.industry_name
ORDER BY total_jobs DESC
LIMIT 10;

#task18:Top paying job titles per industry
SELECT i.industry_name, p.title, MAX(s.max_salary) AS highest_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN postings p ON ji.job_id = p.job_id
JOIN salaries s ON p.job_id = s.job_id
GROUP BY i.industry_name, p.title
ORDER BY i.industry_name, highest_salary DESC;

#task19:Industries with jobs having min salary < 20000
SELECT i.industry_name, COUNT(p.job_id) AS low_salary_jobs
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
JOIN postings p ON ji.job_id = p.job_id
WHERE s.min_salary < 20000
GROUP BY i.industry_name;

#task20:Average number of postings per industry

SELECT i.industry_name, COUNT(p.job_id)/COUNT(DISTINCT p.company_id) AS avg_postings_per_company
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN postings p ON ji.job_id = p.job_id
GROUP BY i.industry_name;
#task21:Top 10 skills required per industry

SELECT i.industry_name, js.skill_abr, COUNT(*) AS skill_count
FROM job_skills js
JOIN job_industries ji ON js.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name, js.skill_abr
ORDER BY i.industry_name, skill_count DESC;

#task22:Number of unique skills per industry
SELECT i.industry_name, COUNT(DISTINCT js.skill_abr) AS unique_skills
FROM job_skills js
JOIN job_industries ji ON js.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name;

#task23:Average number of skills per job per industry
SELECT i.industry_name, AVG(skill_count) AS avg_skills_per_job
FROM (
  SELECT ji.industry_id, COUNT(js.skill_abr) AS skill_count
  FROM job_skills js
  JOIN job_industries ji ON js.job_id = ji.job_id
  GROUP BY js.job_id, ji.industry_id
) AS sub
JOIN industries i ON sub.industry_id = i.industry_id
GROUP BY i.industry_name;

#task24:Top 5 specialities per industry (by company count)
SELECT ci.industry, cs.speciality, COUNT(DISTINCT cs.company_id) AS company_count
FROM company_specialities cs
JOIN company_industry ci ON cs.company_id = ci.company_id
GROUP BY ci.industry, cs.speciality
ORDER BY ci.industry, company_count DESC
LIMIT 5;

#task25:Number of companies having specialities per industry
SELECT ci.industry, COUNT(DISTINCT cs.company_id) AS companies_with_speciality
FROM company_specialities cs
JOIN company_industry ci ON cs.company_id = ci.company_id
GROUP BY ci.industry;

#task26:Industries with most benefit types offered
SELECT i.industry_name, COUNT(DISTINCT b.type) AS unique_benefits
FROM benefits b
JOIN postings p ON b.job_id = p.job_id
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY unique_benefits DESC;

#task27:Average number of benefits per job per industry
SELECT i.industry_name, AVG(benefit_count) AS avg_benefits_per_job
FROM (
  SELECT p.job_id, ji.industry_id, COUNT(b.type) AS benefit_count
  FROM benefits b
  JOIN postings p ON b.job_id = p.job_id
  JOIN job_industries ji ON p.job_id = ji.job_id
  GROUP BY p.job_id, ji.industry_id
) AS sub
JOIN industries i ON sub.industry_id = i.industry_id
GROUP BY i.industry_name;

#task28:Industries offering “Health Insurance” benefit
SELECT i.industry_name, COUNT(DISTINCT p.job_id) AS jobs_with_health_insurance
FROM benefits b
JOIN postings p ON b.job_id = p.job_id
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE b.type LIKE '%Health Insurance%'
GROUP BY i.industry_name;

#task29:Industries with jobs having inferred benefits

SELECT i.industry_name, COUNT(DISTINCT p.job_id) AS inferred_benefit_jobs
FROM benefits b
JOIN postings p ON b.job_id = p.job_id
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE b.inferred = 1
GROUP BY i.industry_name;

#30:Top 5 most common benefits per industry

SELECT i.industry_name, b.type, COUNT(*) AS benefit_count
FROM benefits b
JOIN postings p ON b.job_id = p.job_id
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name, b.type
ORDER BY i.industry_name, benefit_count DESC
LIMIT 5;

#task31:Industries with highest average max salary

SELECT i.industry_name, AVG(s.max_salary) AS avg_max_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name
ORDER BY avg_max_salary DESC;
#task32:Industries with lowest average min salary
SELECT i.industry_name, AVG(s.min_salary) AS avg_min_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name
ORDER BY avg_min_salary ASC;

#task33:Median salary distribution per industry
SELECT i.industry_name, MEDIAN(s.med_salary) AS median_salary
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
GROUP BY i.industry_name;

#task34:Top 5 companies with highest median salary in each industry
SELECT ci.industry, c.name AS company_name, AVG(s.med_salary) AS avg_median_salary
FROM postings p
JOIN companies c ON p.company_id = c.company_id
JOIN company_industry ci ON c.company_id = ci.company_id
JOIN salaries s ON p.job_id = s.job_id
GROUP BY ci.industry, c.name
ORDER BY ci.industry, avg_median_salary DESC
LIMIT 5;

#35:Industries with jobs paying above 1 lakh (max salary)
SELECT i.industry_name, COUNT(p.job_id) AS high_salary_jobs
FROM job_industries ji
JOIN industries i ON ji.industry_id = i.industry_id
JOIN salaries s ON ji.job_id = s.job_id
JOIN postings p ON ji.job_id = p.job_id
WHERE s.max_salary > 100000
GROUP BY i.industry_name;

#task36:Job count trend over time per industry (year-wise)
SELECT i.industry_name, YEAR(FROM_UNIXTIME(p.listed_time)) AS year, COUNT(p.job_id) AS job_count
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name, year
ORDER BY i.industry_name, year;

#task37:Industries with jobs allowing remote work
SELECT i.industry_name, COUNT(p.job_id) AS remote_jobs
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE p.remote_allowed = 1
GROUP BY i.industry_name;

#task38:Industries with most sponsored jobs
SELECT i.industry_name, COUNT(p.job_id) AS sponsored_jobs
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE p.sponsored = 1
GROUP BY i.industry_name
ORDER BY sponsored_jobs DESC;

#task39:Industries with companies having employee count between 100–500
SELECT ci.industry, COUNT(c.company_id) AS mid_size_companies
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
JOIN companies c ON ci.company_id = c.company_id
WHERE ec.employee_count BETWEEN 100 AND 500
GROUP BY ci.industry;

#Industries with companies having employee count >5000
SELECT ci.industry, COUNT(c.company_id) AS huge_companies
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
JOIN companies c ON ci.company_id = c.company_id
WHERE ec.employee_count > 5000
GROUP BY ci.industry;

#41:Industries with average employee count per company
SELECT ci.industry, AVG(ec.employee_count) AS avg_employees
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry;

#Top 5 industries with most employees
SELECT ci.industry, SUM(ec.employee_count) AS total_employees
FROM company_industry ci
JOIN employee_counts ec ON ci.company_id = ec.company_id
GROUP BY ci.industry
ORDER BY total_employees DESC
LIMIT 5;

#43:Industries with highest average job views

SELECT i.industry_name, AVG(p.views) AS avg_views
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY avg_views DESC;

#44:Industries with jobs having highest applies
SELECT i.industry_name, MAX(p.applies) AS max_applies
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY max_applies DESC;
#45:Industries with highest remote job ratio
SELECT i.industry_name, SUM(p.remote_allowed)/COUNT(p.job_id) AS remote_ratio
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY remote_ratio DESC;

#46:Industries with jobs requiring highest experience level
SELECT i.industry_name, MAX(p.formatted_experience_level) AS highest_experience
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
GROUP BY i.industry_name;

#47:Industries with highest median salary for remote jobs
SELECT i.industry_name, AVG(s.med_salary) AS avg_med_salary
FROM postings p
JOIN salaries s ON p.job_id = s.job_id
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE p.remote_allowed = 1
GROUP BY i.industry_name
ORDER BY avg_med_salary DESC;

#48:Industries with most jobs closing within 30 days
SELECT i.industry_name, COUNT(p.job_id) AS jobs_30days
FROM postings p
JOIN job_industries ji ON p.job_id = ji.job_id
JOIN industries i ON ji.industry_id = i.industry_id
WHERE (p.closed_time - p.listed_time) <= 30
GROUP BY i.industry_name
ORDER BY jobs_30days DESC;
#49:Industries with highest number of benefits per job
SELECT i.industry_name, AVG(b_count) AS avg_benefits_per_job
FROM (
    SELECT p.job_id, ji.industry_id, COUNT(b.type) AS b_count
    FROM postings p
    LEFT JOIN benefits b ON p.job_id = b.job_id
    JOIN job_industries ji ON p.job_id = ji.job_id
    GROUP BY p.job_id, ji.industry_id
) AS sub
JOIN industries i ON sub.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY avg_benefits_per_job DESC;

#50:Industries with most skills per job

SELECT i.industry_name, AVG(skill_count) AS avg_skills_per_job
FROM (
    SELECT js.job_id, ji.industry_id, COUNT(js.skill_abr) AS skill_count
    FROM job_skills js
    JOIN job_industries ji ON js.job_id = ji.job_id
    GROUP BY js.job_id, ji.industry_id
) AS sub
JOIN industries i ON sub.industry_id = i.industry_id
GROUP BY i.industry_name
ORDER BY avg_skills_per_job DESC;













































