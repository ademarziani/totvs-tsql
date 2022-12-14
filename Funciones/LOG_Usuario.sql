SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[LOG_Usuario] (@Texto VARCHAR(100))
	RETURNS Varchar(100)
AS
BEGIN
	DECLARE @retorno Varchar(6)
		
	SET @retorno = SUBSTRING(@Texto, 11,1)+SUBSTRING(@Texto, 15,1)+
	SUBSTRING(@Texto, 2, 1)+SUBSTRING(@Texto, 6, 1)+
	SUBSTRING(@Texto, 10,1)+SUBSTRING(@Texto, 14,1)+
	SUBSTRING(@Texto, 1, 1)+SUBSTRING(@Texto, 5, 1)+
	SUBSTRING(@Texto, 9, 1)+SUBSTRING(@Texto, 13,1)+
	SUBSTRING(@Texto, 17,1)+SUBSTRING(@Texto, 4, 1)+
	SUBSTRING(@Texto, 8, 1)

	RETURN (@retorno);
END



