/*
====================================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================================================================
Script Purpose:
	This stores procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
		- Truncate the bronze tables before loading data.
		- Uses the 'BULK INSERT' command to load data from csv files to bronze tables.


	parameters:
		None.
	This stored procedure does not accpt any parameters or return any values.

	Usage Example:
		EXEC bronze.load_bronze;
====================================================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @Start_time DATETIME, @End_Time DATETIME,@Batch_Start_time DATETIME, @Batch_End_time DATETIME

BEGIN TRY
		PRINT '=====================================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================================================================';

		PRINT'---------------------------------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'---------------------------------------------------------------------------------------';
	
		SET @Batch_Start_time = GETDATE()
		PRINT'>>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		SET @Start_time = GETDATE()
		PRINT'>>>Loadding Table: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE()
		PRINT'>>>bronze.crm_cust_info Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds' 


		PRINT'>>>Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		SET @Start_time = GETDATE()
		PRINT'>>>Loading Table: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @End_time = GETDATE()
		PRINT'>>>bronze.crm_prd_info Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds'



		PRINT'>>>Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		SET @Start_time = GETDATE()
		PRINT'>>>Loading Table: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @End_time = GETDATE()
		PRINT'>>>bronze.crm_sales_details Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds'


		PRINT'>>>Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		SET @Start_time = GETDATE()
		PRINT'>>>Loading Table: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE()
		PRINT'>>>bronze.erp_cust_az12 Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds'

		PRINT'>>>Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;


		SET @Start_time = GETDATE()
		PRINT'>>>Loading Table: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE()
		PRINT'>>>bronze.erp_loc_a101 Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds'


		PRINT'>>>Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;


		SET @Start_time = GETDATE()
		PRINT'>>>Loading Table: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Pual\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @End_time = GETDATE();
		SET @Batch_End_time = GETDATE()
		PRINT'>>>bronze.erp_px_cat_g1v2 Load Duration:' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) + ' seconds'
		PRINT'========================================================================================='
		PRINT'Total duration for loading bronze tables'
		PRINT'========================================================================================='
		PRINT'>>>Load Duration:' + CAST(DATEDIFF(second, @Batch_Start_time, @Batch_End_time) AS NVARCHAR) + ' seconds'
	END TRY
	BEGIN CATCH
		PRINT'========================================================================================='
		PRINT'Error occured while loading Bronze Layer'
		PRINT'========================================================================================='
		PRINT 'Error Message:' + ERROR_MESSAGE()
		PRINT 'Error Number:' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error State:' + ERROR_STATE()
	END CATCH
END;

EXEC bronze.load_bronze;
