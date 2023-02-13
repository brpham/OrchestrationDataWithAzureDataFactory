--
-- Create the [SalesLT].[usp_PrepareProductStaging] stored procedure 
--

CREATE OR ALTER PROCEDURE [SalesLT].[usp_PrepareProductStaging]
AS
	SET NOCOUNT ON;
	DECLARE @RowCount BIGINT = 0;

	SET @RowCount = (SELECT COUNT(StagingID) FROM [SalesLT].[ProductStaging])

	IF (@RowCount = 0)
	BEGIN
		Return 0; -- Success
	END
	ELSE
	BEGIN
		RAISERROR ('More than Zero rows found in ProductStaging.', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );
		Return 1; -- error
	END

	SET NOCOUNT OFF; 
GO
