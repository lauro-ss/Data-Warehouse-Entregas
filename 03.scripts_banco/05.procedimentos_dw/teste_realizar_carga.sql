USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_OLAP_REALIZAR_CARGA (@DATA_CARGA DATETIME) AS
BEGIN
	EXEC sp_dim_localidade @DATA_CARGA
	EXEC sp_dim_modalidade @DATA_CARGA
	EXEC sp_dim_status @DATA_CARGA
	EXEC sp_dim_transportadora @DATA_CARGA
	EXEC sp_fato_entrega @DATA_CARGA
END

EXEC SP_OLAP_REALIZAR_CARGA '20221106'
SELECT * FROM Dim_Localidade
SELECT * FROM Dim_Modalidade
SELECT * FROM Dim_Status
SELECT * FROM Fato_Entrega