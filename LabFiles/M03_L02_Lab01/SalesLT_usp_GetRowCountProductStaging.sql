--
-- Create the [SalesLT].[usp_GetRowCountProductStaging] stored procedure 
--

CREATE OR ALTER PROCEDURE [SalesLT].[usp_GetRowCountProductStaging]
AS
	SELECT COUNT(StagingID) AS [RowCount]
	FROM [SalesLT].[ProductStaging]

GO
