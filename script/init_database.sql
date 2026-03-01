/*
==========================================================================================================================================================================================================
Create Database 'DataWarehouse'
==========================================================================================================================================================================================================
Script Purpose:
	This script creates a new database names 'DataWarehouse' after checking if it already exists.
	If thedatabase exists,it is dropped andrecreated. Additionally, the script sets up three schemas
	within the database: 'bronze', 'silver', and 'gold'.

WARNING:
	Running ths script will dropthe entire 'DataWarehouse' daabase if it exists.
	All data in the database will be permanenly deleted. Proceed with caution and ensure you
	have proper backup before running this script.
*/
USE master;
GO


--Drop and recreate the 'Datawarehouse' databae
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Daawarehouse;
END;
GO

--Creae the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE datawarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;


DROP DATABASE datawarehouse;
