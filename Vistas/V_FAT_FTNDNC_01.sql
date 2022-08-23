CREATE VIEW V_FAT_FTNDNC_01
AS

SELECT F2_FILIAL
	,F2_EMISSAO
	,A1_COD
	,A1_LOJA
	,A1_NOME
	,F2_ESPECIE
	,LEFT(F2_SERIE,1) AS F2_SERIE
	,F2_DOC
	,F2_MOEDA
	,F2_TXMOEDA
	,F2_VALBRUT
	,F2_VALMERC
	,COALESCE(MAX(E1_VENCTO), '') AS E1_VENCTO
	,COALESCE(MAX(E1_VENCREA), '') AS E1_VENCREA	
	,COALESCE(E4_COND, '') AS E4_COND
	,COALESCE(E4_DESCRI, '') AS E4_DESCRI
	,D2_ITEM
	,D2_COD
	,B1_DESC
	,D2_LOTECTL
	,D2_DTVALID
	,D2_QUANT
	,D2_PRCVEN
	,D2_TOTAL
	,D2_REMITO
	,D2_SERIREM
	,D2_ITEMREM
FROM SD2010 SD2
	INNER JOIN SF2010 SF2
		ON D2_FILIAL = F2_FILIAL
		AND D2_CLIENTE = F2_CLIENTE
		AND D2_LOJA = F2_LOJA
		AND D2_DOC = F2_DOC
		AND D2_SERIE = F2_SERIE
		AND D2_ESPECIE = F2_ESPECIE
		AND SF2.D_E_L_E_T_ <> '*'
	INNER JOIN SB1010 SB1
		ON B1_COD = D2_COD
		AND SB1.D_E_L_E_T_ <> '*'
	INNER JOIN SA1010 SA1
		ON A1_COD = D2_CLIENTE
		AND A1_LOJA = D2_LOJA
		AND SA1.D_E_L_E_T_ <> '*'
	LEFT JOIN SE4010 SE4
		ON F2_COND = E4_CODIGO
		AND SE4.D_E_L_E_T_ <> '*'
	LEFT JOIN SE1010 SE1
		ON E1_TIPO = F2_ESPECIE
		AND E1_PREFIXO = F2_SERIE
		AND E1_NUM = F2_DOC
		AND E1_CLIENTE = F2_CLIENTE
		AND E1_LOJA = F2_LOJA
		AND SE1.D_E_L_E_T_ <> '*'
WHERE D2_ESPECIE IN ('NF','NDC')
AND SD2.D_E_L_E_T_ <> '*'
GROUP BY F2_FILIAL
	,F2_EMISSAO
	,A1_COD
	,A1_LOJA
	,A1_NOME
	,F2_ESPECIE
	,F2_SERIE
	,F2_DOC
	,F2_MOEDA
	,F2_TXMOEDA
	,F2_VALBRUT
	,F2_VALMERC
	,E1_VENCREA
	,E4_COND
	,E4_DESCRI
	,D2_ITEM
	,D2_COD
	,B1_DESC
	,D2_LOTECTL
	,D2_DTVALID
	,D2_QUANT
	,D2_PRCVEN
	,D2_TOTAL
	,D2_REMITO
	,D2_SERIREM
	,D2_ITEMREM

UNION ALL

SELECT F1_FILIAL
	,F1_EMISSAO
	,A1_COD
	,A1_LOJA
	,A1_NOME
	,F1_ESPECIE
	,LEFT(F1_SERIE,1) AS F1_SERIE
	,F1_DOC
	,F1_MOEDA
	,F1_TXMOEDA
	,F1_VALBRUT
	,F1_VALMERC
	,COALESCE(MAX(E1_VENCTO), '') AS E1_VENCTO
	,COALESCE(MAX(E1_VENCREA), '') AS E1_VENCREA	
	,COALESCE(E4_COND, '') AS E4_COND
	,COALESCE(E4_DESCRI, '') AS E4_DESCRI
	,D1_ITEM
	,D1_COD
	,B1_DESC
	,D1_LOTECTL
	,D1_DTVALID
	,D1_QUANT
	,D1_VUNIT
	,D1_TOTAL
	,'' AS D1_REMITO
	,'' AS D1_SERIREM
	,'' AS D1_ITEMREM
FROM SD1010 SD1
	INNER JOIN SF1010 SF1
		ON D1_FILIAL = F1_FILIAL
		AND D1_FORNECE = F1_FORNECE
		AND D1_LOJA = F1_LOJA
		AND D1_DOC = F1_DOC
		AND D1_SERIE = F1_SERIE
		AND D1_ESPECIE = F1_ESPECIE
		AND SF1.D_E_L_E_T_ <> '*'
	INNER JOIN SB1010 SB1
		ON B1_COD = D1_COD
		AND SB1.D_E_L_E_T_ <> '*'
	INNER JOIN SA1010 SA1
		ON A1_COD = D1_FORNECE
		AND A1_LOJA = D1_LOJA
		AND SA1.D_E_L_E_T_ <> '*'
	LEFT JOIN SE4010 SE4
		ON F1_COND = E4_CODIGO
		AND SE4.D_E_L_E_T_ <> '*'
	LEFT JOIN SE1010 SE1
		ON E1_TIPO = F1_ESPECIE
		AND E1_PREFIXO = F1_SERIE
		AND E1_NUM = F1_DOC
		AND E1_CLIENTE = F1_FORNECE
		AND E1_LOJA = F1_LOJA
		AND SE1.D_E_L_E_T_ <> '*'
WHERE D1_ESPECIE IN ('NCC')
AND SD1.D_E_L_E_T_ <> '*'
GROUP BY F1_FILIAL
	,F1_EMISSAO
	,A1_COD
	,A1_LOJA
	,A1_NOME
	,F1_ESPECIE
	,F1_SERIE
	,F1_DOC
	,F1_MOEDA
	,F1_TXMOEDA
	,F1_VALBRUT
	,F1_VALMERC
	,E1_VENCREA
	,E4_COND
	,E4_DESCRI
	,D1_ITEM
	,D1_COD
	,B1_DESC
	,D1_LOTECTL
	,D1_DTVALID
	,D1_QUANT
	,D1_VUNIT
	,D1_TOTAL
	,D1_REMITO
	,D1_SERIREM
	,D1_ITEMREM
