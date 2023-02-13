--
-- Create the [SalesLT].[usp_TruncateProductStaging] stored procedure 
--

CREATE OR ALTER PROCEDURE [SalesLT].[usp_TruncateProductStaging]
AS
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [SalesLT].[ProductStaging];

	SET NOCOUNT OFF; 
GO
