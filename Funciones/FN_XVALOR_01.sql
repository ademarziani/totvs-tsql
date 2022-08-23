/****** Object:  UserDefinedFunction [dbo].[FN_XVALOR_01]    Script Date: 8/8/2022 12:23:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FN_XVALOR_01]
(
	-- Add the parameters for the function here
	@VALOR FLOAT,
	@FECHA VARCHAR(8),
	@MON_ORI INT,
	@MON_DES INT,
	@TXMONEDA FLOAT
)
RETURNS FLOAT
AS
BEGIN
	
	DECLARE @RET FLOAT = 0
	DECLARE @TASA_ORI FLOAT = 0
	DECLARE @TASA_DES FLOAT = 0

	--|-------------------------------------------------------
	--| Si ambas monedas son iguales, devuelvo el mismo valor		
	--|-------------------------------------------------------
	IF @MON_ORI = @MON_DES
		BEGIN
		
		SET @RET = @VALOR	
		
		RETURN @RET
	END
	
	IF @MON_ORI = 1 AND @MON_DES <> 1 AND @TXMONEDA = 1
		BEGIN
		
		SET @TXMONEDA = 0
	END		

	--|-----------------------------------------------	
	--| En esta seccion determino el valor de la tasa
	--| de la moneda origen
	--|-----------------------------------------------
	IF @MON_ORI = 1 
		BEGIN
				
		SET @TASA_ORI = 1		
	END
	ELSE
		BEGIN
		
		IF @TXMONEDA <> 0
			BEGIN
			
			SET @TASA_ORI = @TXMONEDA
		END
		ELSE
			BEGIN
			
			SELECT @TASA_ORI = MAX(TASA)
			FROM SM2010 SM2
				UNPIVOT ( TASA FOR MONEDA IN (M2_MOEDA2, M2_MOEDA3, M2_MOEDA4, M2_MOEDA5) ) AS UNPVT
			WHERE M2_DATA = @FECHA
			AND RIGHT(UNPVT.MONEDA,1) = @MON_ORI
			AND D_E_L_E_T_ <> '*'						
		END		
	END

	--|-----------------------------------------------	
	--| En esta seccion determino el valor de la tasa
	--| de la moneda destino
	--|-----------------------------------------------
	IF @MON_DES = 1 
		BEGIN
				
		SET @TASA_DES = 1		
	END
	ELSE
		BEGIN
		
		IF @TXMONEDA <> 0 AND @MON_ORI = 1
			BEGIN
			
			SET @TASA_DES = @TXMONEDA
		END
		ELSE
			BEGIN
			
			SELECT @TASA_DES = MAX(TASA)
			FROM SM2010 SM2
				UNPIVOT ( TASA FOR MONEDA IN (M2_MOEDA2, M2_MOEDA3, M2_MOEDA4, M2_MOEDA5) ) AS UNPVT
			WHERE M2_DATA = @FECHA
			AND RIGHT(UNPVT.MONEDA,1) = @MON_DES
			AND D_E_L_E_T_ <> '*'						
		END		
	END

	--|-----------------------
	--| Hago el calculo final
	--|-----------------------	
	IF @TASA_DES <> 0
		SET @RET = ROUND( @TASA_ORI * @VALOR / @TASA_DES, 4 )
				
	RETURN @RET
END




GO


