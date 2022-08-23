SELECT D2_FILIAL AS 'TIENDA'
	,D2_ITEM AS 'ITEM'
	,D2_COD AS 'CODIGO'
	,D2_TP AS 'TIPO_PR'
	,D2_TES AS 'TES'
	,D2_EMISSAO AS 'FECH_COMPR'
	,D2_CLIENTE AS 'CLIENTE'
	,D2_GRUPO AS 'GRUPO'
	,BM_DESC AS 'DESC_GRUPO'
	,D2_SERIE AS 'SERIE'
	,D2_ESPECIE AS 'ESPECIE'
	,D2_DOC AS 'NRO_COMPRO'
	,D2_QUANT AS 'CANTIDAD'
	,D2_PRCVEN AS 'VAL_UNIT'
	,D2_TOTAL AS 'TOTAL'
	,CASE 
		WHEN (D2_BASIMP1 + D2_BASIMP2 + D2_BASIMP3 + D2_BASIMP3 + D2_VALIMP1 + D2_VALIMP2 + D2_VALIMP3 + D2_VALIMP4 + D2_VALIMP5 + D2_VALIMP6 + D2_VALIMP7 + D2_VALIMP8 + D2_VALIMP9) = 0
			THEN D2_TOTAL
		ELSE 0
		END AS 'EXENTO'
	,D2_BASIMP1 AS 'BASIVA_21'
	,D2_BASIMP2 AS 'BASIVA_105'
	,D2_BASIMP3 AS 'BASIVA_27'
	,D2_VALIMP1 AS 'VALIVA_21'
	,D2_VALIMP2 AS 'VALIVA_105'
	,D2_VALIMP3 AS 'VALIVA_27'
	,D2_VALIMP8 AS 'VAL_III'
	,D2_CONTA AS 'CTA_CONTAB'
	,D2_XENTREG AS 'ENTREG_POR'
	,D2_XDIAST AS 'DEV_REESTR'
	,D2_CUSTO5 AS 'COSTO'
	,CASE 
		WHEN D2_GRUPO IN (
				'0001'
				,'0002'
				)
			THEN ISNULL((
						SELECT TOP 1 D1_VUNIT + (D1_VALIMP7 / D1_QUANT)
						FROM PROTHEUS_PRD.PROTHEUS_PRD.dbo.SD1010 WITH (NOLOCK)
						WHERE D1_COD = D2_COD
							AND D1_DTDIGIT <= D2_EMISSAO
							AND D1_FILIAL = '00'
							AND D1_ESPECIE = 'NF'
						ORDER BY D1_DTDIGIT DESC
						), 0)
		ELSE 0
		END AS 'ULT_COMPRA'
FROM SD2010 SD2 WITH (NOLOCK)
LEFT JOIN SBM010 SBM WITH (NOLOCK) ON BM_GRUPO = D2_GRUPO
WHERE D2_ESPECIE IN (
		'CF'
		,'NF'
		,'RFN'
		)
	AND SD2.D_E_L_E_T_ = ''
	AND D2_FILIAL <> ''
	AND D2_EMISSAO BETWEEN '[p(1)]'
		AND '[p(2)]'

UNION ALL

SELECT D1_FILIAL AS 'TIENDA'
	,D1_ITEM AS 'ITEM'
	,D1_COD AS 'CODIGO'
	,D1_TP AS 'TIPO_PR'
	,D1_TES AS 'TES'
	,D1_EMISSAO AS 'FECH_COMPR'
	,D1_FORNECE AS 'CLIENTE'
	,D1_GRUPO AS 'GRUPO'
	,BM_DESC AS 'DESC_GRUPO'
	,D1_SERIE AS 'SERIE'
	,D1_ESPECIE AS 'ESPECIE'
	,D1_DOC AS 'NRO_COMPRO'
	,D1_QUANT * - 1 AS 'CANTIDAD'
	,D1_VUNIT * - 1 AS 'VAL_UNIT'
	,D1_TOTAL AS 'TOTAL'
	,CASE 
		WHEN (D1_BASIMP1 + D1_BASIMP2 + D1_BASIMP3 + D1_VALIMP1 + D1_VALIMP2 + D1_VALIMP3 + D1_VALIMP4 + D1_VALIMP5 + D1_VALIMP6 + D1_VALIMP7 + D1_VALIMP8 + D1_VALIMP9) = 0
			THEN D1_TOTAL
		ELSE 0
		END AS 'EXENTO'
	,D1_BASIMP1 * - 1 AS 'BASIVA_21'
	,D1_BASIMP2 * - 1 AS 'BASIVA_105'
	,D1_BASIMP3 * - 1 AS 'BASIVA_27'
	,D1_VALIMP1 * - 1 AS 'VALIVA_21'
	,D1_VALIMP2 * - 1 AS 'VALIVA_105'
	,D1_VALIMP3 * - 1 AS 'VALIVA_27'
	,D1_VALIMP8 * - 1 AS 'VAL_III'
	,D1_CONTA AS 'CTA_CONTAB'
	,D1_XENTREG AS 'ENTREG_POR'
	,D1_XDIAST AS 'DEV_REESTR'
	,D1_CUSTO5 * - 1 AS 'COSTO'
	,CASE 
		WHEN D1_GRUPO IN (
				'0001'
				,'0002'
				)
			THEN ISNULL((
						SELECT TOP 1 (D1_VUNIT + (D1_VALIMP7 / D1_QUANT)) * - 1
						FROM PROTHEUS_PRD.PROTHEUS_PRD.dbo.SD1010 UPC WITH (NOLOCK)
						WHERE SD1.D1_COD = UPC.D1_COD
							AND UPC.D1_DTDIGIT <= SD1.D1_EMISSAO
							AND UPC.D1_FILIAL = '00'
							AND UPC.D1_ESPECIE = 'NF'
						ORDER BY UPC.D1_DTDIGIT DESC
						), 0)
		ELSE 0
		END AS 'ULT_COMPRA'
FROM SD1010 SD1 WITH (NOLOCK)
LEFT JOIN SBM010 SBM WITH (NOLOCK) ON BM_GRUPO = D1_GRUPO
WHERE D1_ESPECIE IN (
		'NCC'
		,'RFD'
		)
	AND SD1.D_E_L_E_T_ = ''
	AND D1_FILIAL <> ''
	AND D1_EMISSAO BETWEEN '[p(1)]'
		AND '[p(2)]'
