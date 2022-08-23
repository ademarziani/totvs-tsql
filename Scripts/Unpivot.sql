SELECT M2_DATA, MONEDA, RIGHT(MONEDA,1) AS NROMON, TASA
FROM SM2010 SM2
	UNPIVOT ( TASA FOR MONEDA IN (M2_MOEDA2, M2_MOEDA3, M2_MOEDA4, M2_MOEDA5) ) AS UNPVT
WHERE D_E_L_E_T_ <> '*'	
ORDER BY 1,2