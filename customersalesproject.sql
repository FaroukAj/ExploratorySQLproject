USE wfsdata;

SELECT * FROM customerdata;


-- TASK : Find the total revenue generated by each payment method
SELECT
	SUM(CASE WHEN payment_method = 'Debit Card' THEN price*quantity ELSE 0 END)AS 'Debit Payment',
    	SUM(CASE WHEN payment_method = 'Credit Card' THEN price*quantity ELSE 0 END)AS 'Credit Payment',
    	SUM(CASE WHEN payment_method = 'Cash' THEN price*quantity ELSE 0 END)AS 'Cash Payment'    
FROM customerdata; 
						/* OR */
SELECT payment_method, 
SUM(quantity * price) as total_revenue
FROM customerdata
GROUP BY payment_method;


-- Identify the top 10 customers by total revenue generated.
SELECT customer_id, SUM(quantity * price) AS total_spent
FROM customerdata
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Calculate the average age and gender distribution of customers who shop at each shopping mall.
SELECT  COUNT(DISTINCT customer_id) AS customer_count, 
	AVG(age), 
	SUM(CASE WHEN gender ='Female' THEN 1 ELSE 0 END) AS 'Female_count', 
	SUM(CASE WHEN gender ='Male' THEN 1 ELSE 0 END) AS 'Male_count', shopping_mall
FROM customerdata
GROUP BY shopping_mall;

-- Determine the most popular category of products purchased by each age group (under 18, 18-30, 31-50, over 50).
SELECT 
  CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age >= 18 AND age <= 30 THEN '18-30'
    WHEN age >= 31 AND age <= 50 THEN '31-50'
    ELSE 'Over 50'
  END AS age_group,
  category,
  COUNT(*) AS purchase_count
FROM customerdata
GROUP BY age_group, category
ORDER BY age_group, purchase_count DESC;

-- Find the average revenue generated per day for each shopping mall.
WITH avg_rev AS (
SELECT shopping_mall,
	invoice_date AS Date, 
	ROUND(AVG(quantity*price), 2) AS Avg_revenue
FROM customerdata
GROUP BY shopping_mall, invoice_date
ORDER BY Shopping_mall
)
SELECT *
FROM avg_rev;




