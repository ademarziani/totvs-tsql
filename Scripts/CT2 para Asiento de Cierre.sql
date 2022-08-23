SELECT 'CT2' AS IDENT, CONTA, CUSTO, ITEM, CLVL, SUM(SALDOD) AS SALDOD, SUM(SALDOC) AS SALDOC, SUM(SALDOD)-SUM(SALDOC) AS DIF, TPSALDO, MOEDA, JAPROC
FROM (
	SELECT CT2_FILIAL AS FILIAL
		,CT2_MOEDLC AS MOEDA
		,CT2_DEBITO CONTA
		,CT2_CCD CUSTO
		,CT2_ITEMD ITEM
		,CT2_CLVLDB CLVL
		,CT2_TPSALD AS TPSALDO
		,' ' AS JAPROC
		,SUM(CT2_VALOR) AS SALDOD
		,CAST(0 AS FLOAT) AS SALDOC
	FROM CT2010
	WHERE CT2_FILIAL = ''
	AND CT2_TPSALD = '1'
	AND CT2_DC IN ('1','3')
	AND CT2_DATA <= '20211231'
	AND CT2_ROTINA <> 'CTBA410'
	AND D_E_L_E_T_ <> '*'
	GROUP BY CT2_FILIAL, CT2_TPSALD, CT2_MOEDLC, CT2_DEBITO, CT2_CCD, CT2_ITEMD, CT2_CLVLDB

	UNION ALL

	SELECT CT2_FILIAL AS FILIAL
		,CT2_MOEDLC AS MONEDA
		,CT2_CREDIT CONTA
		,CT2_CCC CUSTO
		,CT2_ITEMC ITEM
		,CT2_CLVLCR CLVL
		,CT2_TPSALD AS TPSALDO
		,' ' AS JAPROC
		,CAST(0 AS FLOAT) AS SALDOD
		,SUM(CT2_VALOR) AS SALDOC
	FROM CT2010
	WHERE CT2_FILIAL = ''
	AND CT2_TPSALD = '1'
	AND CT2_DC IN ('2','3')
	AND CT2_DATA <= '20211231'
	AND CT2_ROTINA <> 'CTBA410'
	AND D_E_L_E_T_ <> '*'
	GROUP BY CT2_FILIAL, CT2_TPSALD, CT2_MOEDLC, CT2_CREDIT, CT2_CCC, CT2_ITEMC, CT2_CLVLCR ) AS TMP
GROUP BY MOEDA, CONTA, CUSTO, ITEM, CLVL, TPSALDO, JAPROC
HAVING ROUND(SUM(SALDOD)-SUM(SALDOC),2) <> 0
ORDER BY MOEDA, CONTA, CUSTO, ITEM, CLVL, TPSALDO, JAPROC
