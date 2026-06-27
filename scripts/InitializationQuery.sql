-- ============================================================================
-- Data Warehouse Setup Script
-- Purpose: Initialize a new DataWarehouse database with medallion architecture
-- ============================================================================

-- Connect to the master database to perform instance-level operations
USE master;
GO

-- Drop existing DataWarehouse database if it exists (clean slate)
-- This section ensures we start fresh without conflicts
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	-- Set database to SINGLE_USER mode to disconnect any active users
	-- ROLLBACK IMMEDIATE rolls back any open transactions before switching modes
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	-- Drop the database and all its contents
	DROP DATABASE DataWarehouse;
END;
GO

-- Create a new DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Switch context to the newly created DataWarehouse database
USE DataWarehouse;
GO

-- ============================================================================
-- Create Medallion Architecture Schemas
-- ============================================================================

-- BRONZE schema: Raw data layer
-- Purpose: Store raw, unprocessed data ingested from source systems
-- Characteristics: Minimal transformations, preserves source structure
CREATE SCHEMA bronze;
GO

-- SILVER schema: Cleaned and standardized layer
-- Purpose: Store validated, cleaned, and deduplicated data
-- Characteristics: Applied data quality rules, standardized formats, business rules applied
CREATE SCHEMA silver;
GO

-- GOLD schema: Business-ready analytics layer
-- Purpose: Store aggregated, denormalized data optimized for reporting and analysis
-- Characteristics: Ready for BI tools, dimensional models, pre-aggregated metrics
CREATE SCHEMA gold;
GO