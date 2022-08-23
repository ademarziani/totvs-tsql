-- preparo la tabla temporal con un ID
-- para poder resolver el algoritmo
-- que se encuentra en la siguiente instruccion
SELECT	IDENTITY(INT,1,1) AS ID
		,E1_FILIAL
		,E1_TIPO
		,E1_PARCELA
		,E1_PREFIXO
		,E1_NUM
		,E1_CLIENTE
		,E1_LOJA
		,A1_NOME
		,E1_EMISSAO
		,E1_VENCTO
		,E1_MOEDA
		,E1_TXMOEDA
		,E1_VALOR
		,E1_VLCRUZ
		,CASE WHEN E1_MOEDA <> 1 THEN E1_SALDO * E1_TXMOEDA ELSE E1_SALDO END E1_SALDO
INTO #STA_SE1
FROM SE1010 SE1
	INNER JOIN SA1010 SA1
		ON E1_CLIENTE = A1_COD
		AND E1_LOJA = A1_LOJA
		AND SA1.D_E_L_E_T_ <> '*'
WHERE SE1.D_E_L_E_T_ <> '*'
AND E1_TIPO <> 'CH'
ORDER BY E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_PARCELA, E1_NUM

SELECT MAX(A.ID) AS ID
		,A.E1_FILIAL
		,A.E1_TIPO
		,A.E1_PARCELA
		,A.E1_PREFIXO
		,A.E1_NUM
		,A.E1_CLIENTE
		,A.E1_LOJA
		,A.A1_NOME
		,A.E1_EMISSAO
		,A.E1_VENCTO
		,A.E1_MOEDA
		,A.E1_TXMOEDA
		,A.E1_VALOR
		,A.E1_VLCRUZ
		,A.E1_SALDO
		,SUM(CASE WHEN A.ID <> 0 THEN B.E1_SALDO ELSE 0 END) AS SALDOACUM -- Siempre sumarizo por el campo de la tabla B)
FROM #STA_SE1 A
	INNER JOIN #STA_SE1 B
		-- Resuelvo el join por lo que quiera agrupar
		ON A.E1_CLIENTE = B.E1_CLIENTE
		AND A.E1_LOJA = B.E1_LOJA
		-- Siempre queda igual
		AND A.ID >= B.ID
GROUP BY A.E1_FILIAL
		,A.E1_TIPO
		,A.E1_PARCELA
		,A.E1_PREFIXO
		,A.E1_NUM
		,A.E1_CLIENTE
		,A.E1_LOJA
		,A.A1_NOME
		,A.E1_EMISSAO
		,A.E1_VENCTO
		,A.E1_MOEDA
		,A.E1_TXMOEDA
		,A.E1_VALOR
		,A.E1_VLCRUZ		
		,A.E1_SALDO
ORDER BY E1_CLIENTE, E1_LOJA, ID, E1_PREFIXO, E1_PARCELA, E1_NUM

DROP TABLE #STA_SE1
