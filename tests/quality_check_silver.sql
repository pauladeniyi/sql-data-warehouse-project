/*

=====================================================================================
Quality Checks
=====================================================================================

Script Purpose:
	This scriptperforms various quality checks for data consistency, accuracy, and
	standardization accross the 'silver' schemas. It includes checks for:
	- Null or duplicate primary keys.
	- Unwanted spaces in string fields.
	- Data standardization and consistency.
	- Invalid date ranges and orders.
	- Data consistency between related fields.


	Usage Notes:
		- Run these checks after data loading Silver Laer.
		- Investigae and resolve any discrepancies found during the check
======================================================================================
*/
--Check for duplicate keys
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;




--Check for white spaces
SELECT 
	cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);


--Check for negative values and NULL
SELECT 
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;


--Check for consistency in the start date and end date
SELECT
prd_start_dt,
prd_end_dt
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt;



-- Data Standardization and Consistency
SELECT 
	DISTINCT cst_gndr
FROM silver.crm_cust_info;



--Check for invalid dates
SELECT sls_order_dt FROM silver.crm_sales_details
WHERE sls_order_dt <= 0;

SELECT NULLIF(sls_due_dt, 0) AS sls_order_dt
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101;

-- Check if Order date is lower than Shippimg date
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

--Check for Data consistency
-->> Sales = Quantity X Price
-->> Sales, QUantity and Price must not be negative or null
SELECT 
DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
ORDER BY sls_sales, sls_quantity, sls_price;
