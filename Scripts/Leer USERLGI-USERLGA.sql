-- Aplica tanto para XX_USERLGI y XX_USERLGA
-- Verificar que se encuentren creados los campos
SELECT dbo.LOG_Usuario(F2_USERLGI) AS USERLGI
	,dbo.LOG_Fecha_Mov(F2_USERLGI) AS FECHA_USER_LGI
FROM SF2010
