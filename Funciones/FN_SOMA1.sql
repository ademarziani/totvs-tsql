/****** Object:  UserDefinedFunction [dbo].[SOMA1]    Script Date: 19/8/2019 19:20:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FN_SOMA1]
(
	@CSOMA VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN

	DECLARE @NI SMALLINT = 1
	DECLARE @CRET VARCHAR(100) = ''
	DECLARE @CB VARCHAR (100)
	DECLARE @TAMSOMA SMALLINT = LEN(@CSOMA)
	DECLARE @CX VARCHAR(100) = REPLICATE ('9', @TAMSOMA)
	DECLARE @EXIT BIT = 0

	WHILE @NI <= @TAMSOMA 
		BEGIN

		SET @CB = UPPER(SUBSTRING(@CSOMA,@NI,1))

		IF NOT ('0123456789ABCDEFGHIJKLMNOPQRSTUVXYWZ' LIKE '%'+@CB+'%')
		   SET @CRET = @CRET + '0'
		ELSE
		   SET @CRET = @CRET + SUBSTRING(@CSOMA,@NI,1)

		SET @NI = @NI + 1
	END

	SET @CSOMA = @CRET

	-- EXECUTA A NUMERA玢O NORMAL ATE 99999..99
	IF ISNUMERIC(@CSOMA) = 1 AND @CSOMA < @CX 
		BEGIN

		SET @CRET = RIGHT(REPLICATE('0', @TAMSOMA) + CAST(CAST(@CSOMA AS INT)+1 AS VARCHAR), @TAMSOMA)

		END
	ELSE
		BEGIN

		SET @CRET = ''
		SET @NI = @TAMSOMA
		
		WHILE @EXIT = 0 AND @NI >= 1 
			BEGIN

			SET @CB = SUBSTRING(@CSOMA,@NI,1)
		
			IF @CB = '9' 
				BEGIN
		
				SET @CB = 'A'
				SET @CRET = @CB + @CRET
			
				SET @EXIT = 1

			END

			ELSE IF UPPER(@CB) = 'Z' 
				BEGIN
		
				IF @NI > 1 
					BEGIN

					SET @CB = '0'
					SET @CRET = @CB + @CRET

					END
				ELSE
					SET @CRET = REPLICATE('*', @TAMSOMA)
			END

			ELSE 
				BEGIN
		
				SET @CB = CHAR(ASCII(@CB)+1)
				SET @CRET = @CB + @CRET 
				SET @EXIT = 1
			
			END    

			SET @NI = @NI - 1
		END                 
	
		SET @CRET = SUBSTRING(@CSOMA,1,LEN(@CSOMA)-LEN(@CRET)) + @CRET

	END

	RETURN @CRET

END
GO

