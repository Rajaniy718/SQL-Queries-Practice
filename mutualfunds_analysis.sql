SELECT *
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE COALESCE(scheme_name, min_sip, min_lumpsum, expense_ratio,fund_size_cr, fund_age_yr, fund_manager, alpha, sd, beta, sharpe, risk_level,
               amc_name, rating, category, sub_category, returns_1yr, returns_3yr, returns_5yr ) = '';

SELECT returns_3yr
FROM [dbo].[comprehensive_mutual_funds_data]
	
--------- Handling missing numeric values separately------------ 	
SELECT *
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE returns_3yr IS NULL OR returns_3yr = '' 
	
SELECT *
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE alpha IS NULL OR alpha = '' 

SELECT *
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE category IS NULL OR category = ''

SELECT *
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE category IS NULL OR category = '' OR min_lumpsum IS NULL OR min_lumpsum ='';

------- Handling missing values togerther---

SELECT *
FROM [comprehensive_mutual_funds_data]
WHERE returns_3yr  IS NULL OR returns_3yr = '' OR  returns_5yr IS NULL OR returns_5yr = '' OR min_sip IS NULL OR min_sip = '' OR min_lumpsum IS NULL OR min_lumpsum= '' OR
      expense_ratio IS NULL OR expense_ratio= '' OR fund_size_cr IS NULL OR fund_size_cr= '' OR fund_age_yr IS NULL OR fund_age_yr= '' OR alpha IS NULL OR alpha= '' OR 
	  sd IS NULL OR sd= '' OR beta  IS NULL OR beta= '' OR sharpe  IS NULL OR sharpe= '' OR risk_level IS NULL OR risk_level= '' OR rating  IS NULL OR rating= '' OR
      returns_1yr IS NULL OR returns_1yr = '' ;


SELECT category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr , CAST(min_sip AS int) 
FROM [comprehensive_mutual_funds_data] 
where min_sip = '' OR min_lumpsum= '' OR expense_ratio= '' OR fund_size_cr= '' OR fund_age_yr= '' OR alpha= '' OR sd= '' OR beta= '' OR sharpe= '' OR risk_level= '' OR rating= '' OR
returns_1yr = '' ;
;

SELECT category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip , 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr
FROM [comprehensive_mutual_funds_data]
WHERE returns_3yr = '' OR returns_5yr = '' OR category = '' OR sub_category='' OR amc_name= '' OR scheme_name = '' OR fund_manager='' ;

--------Checking numeric values----------

SELECT category, sub_category, amc_name, scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip,
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating, returns_1yr
FROM [comprehensive_mutual_funds_data]
WHERE (ISNUMERIC(returns_3yr) = 1 AND ISNUMERIC(returns_5yr) = 1) 
   OR (ISNUMERIC(min_sip) = 1 AND ISNUMERIC(min_lumpsum) = 1)
   OR (ISNUMERIC(expense_ratio) = 1 AND ISNUMERIC(fund_size_cr) = 1)
   OR (ISNUMERIC(fund_age_yr) = 1 AND ISNUMERIC(alpha) = 1)
   OR (ISNUMERIC(sd) = 1 AND ISNUMERIC(beta) = 1)
   OR (ISNUMERIC(sharpe) = 1 AND ISNUMERIC(risk_level) = 1)
   OR (ISNUMERIC(rating) = 1 AND ISNUMERIC(returns_1yr) = 1)
   OR category = '' OR sub_category = '' OR amc_name = '' OR scheme_name = '' OR fund_manager = '';


--------Checking Duplicate values---------

SELECT category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip , 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr ,COUNT(*) AS duplicate_count 
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip , 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr
HAVING COUNT(*)> 1 ;

SELECT SUM(duplicate_count) AS total_duplicate_count
FROM ( SELECT category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip , 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr ,COUNT(*) AS duplicate_count 
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY category ,sub_category ,amc_name , scheme_name, fund_manager, returns_3yr, returns_5yr, min_sip , 
       min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, alpha, sd, beta, sharpe, risk_level, rating,returns_1yr
HAVING COUNT(*)> 1 

) AS duplicates;

SELECT category, sub_category, amc_name, scheme_name, fund_manager,returns_3yr, returns_5yr,  COUNT(*) AS duplicate_count
    FROM [dbo].[comprehensive_mutual_funds_data]
    GROUP BY category, sub_category, amc_name, scheme_name, fund_manager, returns_3yr, returns_5yr
    HAVING COUNT(*) > 1

SELECT SUM(duplicate_count) AS total_duplicate_count
FROM (
    SELECT category, sub_category, amc_name, scheme_name, fund_manager,returns_3yr, returns_5yr,  COUNT(*) AS duplicate_count
    FROM [dbo].[comprehensive_mutual_funds_data]
    GROUP BY category, sub_category, amc_name, scheme_name, fund_manager, returns_3yr, returns_5yr
    HAVING COUNT(*) > 1
) AS duplicates;

select *
from [dbo].[comprehensive_mutual_funds_data]
where amc_name = 'Nippon India Mutual Fund' and fund_manager = 'Vivek Sharma'

-----------Summary Statistics ----------------
---Categorical analysis: 
---1. Scheme_name

SELECT DISTINCT(scheme_name) , count(*) as total_count
FROM [dbo].[comprehensive_mutual]_funds_data]
GROUP BY (scheme_name)
ORDER BY DESC

SELECT DISTINCT(sum(scheme_name))
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY (scheme_name)

SELECT DISTINCT(scheme_name) , count(*) as total_count
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY (scheme_name)di der 

Select scheme_name , total_count
from (
			SELECT DISTINCT(scheme_name) , count(*) as total_count
			FROM [dbo].[comprehensive_mutual_funds_data]
			GROUP BY (scheme_name)
	 ) AS distinct_count
Group by scheme_name, total_count
ORDER BY total_count DESC

select *
from [dbo].[comprehensive_mutual_funds_data]
where  scheme_name = 'SBI Long Term Advantage Fund'

------ Fund_manager - fund manager with top 5 fund size and rating --------???

SELECT TOP 5 (fund_manager), fund_size_cr, rating, count(*) as total_count
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY fund_size_cr,fund_manager, rating
ORDER BY fund_size_cr DESC 

SELECT DISTINCT (fund_manager), fund_size_cr, rating, count(*) as total_count
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY fund_manager,fund_size_cr, rating
ORDER BY rating DESC , fund_size_cr DESC

------- Asset Management Companies (AMCs) -- AMC market share: top three amc's -----------

SELECT DISTINCT(amc_name) , count(amc_name) as 'total_count'  
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY amc_name
ORDER BY 2 DESC

---- top 3 with values-----------

SELECT TOP 3 amc_name , count(amc_name) as'total_count' 
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY amc_name
ORDER BY COUNT(*) DESC;

---------AMC performance: Analyze whether funds from specific AMCs tend to have higher or lower ratings, returns, or other characteristics. -------------
----------AMC reputation: Identify well-known AMCs in your dataset ------------

SELECT  amc_name, returns_1yr, returns_3yr, returns_5yr
FROM [dbo].[comprehensive_mutual_funds_data]
GROUP BY amc_name, rating, returns_1yr, returns_3yr, returns_5yr
ORDER BY returns_1yr, returns_3yr, returns_5yr ASC

SELECT  Distinct amc_name, rating --, returns_1yr, returns_3yr, returns_5yr
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE rating = 5
GROUP BY amc_name, rating --, returns_1yr, returns_3yr, returns_5yr

SELECT  TOP 3 amc_name,  returns_1yr, returns_3yr, returns_5yr
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE rating = 5
GROUP BY amc_name, returns_1yr, returns_3yr, returns_5yr

SELECT amc_name,  returns_1yr 
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE rating = 5 and returns_1yr > 8.9
--GROUP BY returns_1yr, amc_name --, returns_3yr, returns_5yr
ORDER BY returns_1yr DESC 

SELECT  amc_name,  returns_1yr 
FROM [dbo].[comprehensive_mutual_funds_data]
WHERE rating = 5 and amc_name ='Bank of India Mutual Fund'
--GROUP BY amc_name, returns_1yr 
--ORDER BY returns_1yr ASC

SELECT DISTINCT amc_name
FROM [dbo].[comprehensive_mutual_funds_data]

-------------------Return Analysis--------------
-- Data Preparation---
---Descriptive statistics------

--Mean--
SELECT AVG(column_name) AS mean_value
FROM [dbo].[comprehensive_mutual_funds_data];

--Median--
SELECT column_name AS median_value
FROM [dbo].[comprehensive_mutual_funds_data]
ORDER BY column_name
LIMIT 1 OFFSET (SELECT COUNT(*) FROM your_table) / 2;

--Mode--
WITH RankedValues AS (
  SELECT column_name,
         ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY COUNT(*) DESC) AS rnk
  FROM [dbo].[comprehensive_mutual_funds_data]
  GROUP BY column_name
)
SELECT column_name AS mode_value
FROM RankedValues
WHERE rnk = 1;

--Standard Deviation--
SELECT STDDEV(column_name) AS std_dev_value
FROM [dbo].[comprehensive_mutual_funds_data];

--Min and Max--
SELECT MIN(column_name) AS min_value,
       MAX(column_name) AS max_value
FROM [dbo].[comprehensive_mutual_funds_data];

--Count--
SELECT COUNT(*) AS row_count
FROM [dbo].[comprehensive_mutual_funds_data];

--Quartile--
SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY column_name) AS q1_value
FROM [dbo].[comprehensive_mutual_funds_data];


------Time Series Analysis---------












