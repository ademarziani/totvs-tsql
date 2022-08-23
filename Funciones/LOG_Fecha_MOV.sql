/****** Object:  UserDefinedFunction [dbo].[LOG_Fecha_Mov]    Script Date: 08/22/2022 21:53:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[LOG_Fecha_Mov] (@Texto VARCHAR(100))
	RETURNS Varchar(100)
AS

BEGIN
	DECLARE @retorno Varchar(8)
	DECLARE @agregado datetime
	
	SET @agregado = '19960101'	
		
	IF @Texto <> ''
		SET @retorno = CONVERT(varchar(8),CONVERT(datetime,CONVERT(numeric, CONVERT( char(2), ASCII(SUBSTRING(@Texto,12,1))-50)+CONVERT( char(2), ASCII(SUBSTRING(@Texto,16,1))-50) ))+@agregado,112)
	ELSE
		SET @retorno = '19000101'

	RETURN (@retorno);
END

GO


