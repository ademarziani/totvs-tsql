-- Ojo que actualiza el X3_ORDEM
DECLARE @ID INT = 0

;WITH TMP AS (
	SELECT TOP 1000 *
	FROM SX3010
	WHERE X3_ARQUIVO = 'ZR2'
	ORDER BY X3_ORDEM )

-- Renumera desde 1 
UPDATE TMP
SET @ID = @ID + 1,
	X3_ORDEM = RIGHT('0'+CAST(@ID AS VARCHAR(2)), 2)
WHERE X3_ARQUIVO = 'ZR2'

