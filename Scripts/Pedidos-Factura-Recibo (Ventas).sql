DECLARE @FILIAL VARCHAR(4) = '0101'

SELECT C5_CLIENTE
	,C5_LOJACLI
	,C5_EMISSAO
	,C5_NUM
	,ISNULL(MAX(F2_EMISSAO),'') AS F2_EMISSAO
	,ISNULL((	SELECT DISTINCT F2_DOC+','
				FROM SF2010 SF2_AUX
				WHERE SF2_AUX.F2_FILIAL = @FILIAL
				AND SF2_AUX.F2_CLIENTE = MAX(SF2.F2_CLIENTE)
				AND SF2_AUX.F2_LOJA = MAX(SF2.F2_LOJA)
				AND SF2_AUX.F2_DOC = MAX(SF2.F2_DOC)
				AND SF2_AUX.F2_ESPECIE = MAX(SF2.F2_ESPECIE)
				AND SF2_AUX.F2_SERIE = MAX(SF2.F2_SERIE)
				AND SF2_AUX.D_E_L_E_T_ <> '*'  
				ORDER BY 1
				FOR XML PATH('')), '') AS F2_DOC

	,ISNULL(SUM(F2_VALMERC),0) AS F2_VALFAT

	,ISNULL((	SELECT DISTINCT EL_RECIBO+','
				FROM SEL010 SEL_AUX
				WHERE SEL_AUX.EL_FILIAL = @FILIAL
				AND SEL_AUX.EL_CLIENTE = MAX(SF2.F2_CLIENTE)
				AND SEL_AUX.EL_LOJA = MAX(SF2.F2_LOJA)
				AND SEL_AUX.EL_NUMERO = MAX(SF2.F2_DOC)
				AND SEL_AUX.EL_TIPO = MAX(SF2.F2_ESPECIE)
				AND SEL_AUX.EL_PREFIXO = MAX(SF2.F2_SERIE)
				AND SEL_AUX.D_E_L_E_T_ <> '*'  
				ORDER BY 1
				FOR XML PATH('')), '') AS EL_RECIBO
	,ISNULL(MAX(EL_DTDIGIT),'') AS EL_DTDIGIT
	,ISNULL(SUM(EL_VLMOED1),0) AS EL_VALCOB
FROM SC5010 SC5
	INNER JOIN SA1010 SA1
		ON A1_COD = C5_CLIENTE
		AND A1_LOJA = C5_LOJACLI
		AND SA1.D_E_L_E_T_ <> '*'
	INNER JOIN SC6010 SC6
		ON C5_FILIAL = C6_FILIAL
		AND C5_NUM = C6_NUM
		AND SC6.D_E_L_E_T_ <> '*'
	INNER JOIN SB1010 SB1
		ON B1_COD = C6_PRODUTO
		AND SB1.D_E_L_E_T_ <> '*'
	LEFT JOIN SD2010 SD2
		ON D2_FILIAL = C5_FILIAL
		AND D2_CLIENTE = C5_CLIENTE
		AND D2_LOJA = C5_LOJACLI
		AND D2_PEDIDO = C6_NUM
		AND D2_ITEMPV = C6_ITEM		
		AND D2_ESPECIE = 'NF'
		AND SD2.D_E_L_E_T_ <> '*'
	LEFT JOIN SF2010 SF2
		ON D2_FILIAL = F2_FILIAL
		AND D2_DOC = F2_DOC
		AND D2_SERIE = F2_SERIE
		AND D2_CLIENTE = F2_CLIENTE
		AND D2_LOJA = F2_LOJA
		AND D2_ESPECIE = F2_ESPECIE
		AND SF2.D_E_L_E_T_ <> '*'
	LEFT JOIN SEL010 SEL
		ON EL_NUMERO = F2_DOC
		AND EL_PREFIXO = F2_SERIE
		AND EL_CLIENTE = F2_CLIENTE
		AND EL_LOJA = F2_LOJA
		AND EL_TIPO = F2_ESPECIE
		AND SEL.D_E_L_E_T_ <> '*'
WHERE SC5.D_E_L_E_T_ <> '*'	
GROUP BY C5_CLIENTE
	,C5_LOJACLI
	,C5_EMISSAO
	,C5_NUM
ORDER BY C5_NUM