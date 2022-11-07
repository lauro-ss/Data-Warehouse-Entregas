USE bd_rede_entregas

CREATE OR ALTER PROCEDURE SP_DIM_STATUS (@DATA_CARGA DATETIME) AS
BEGIN
	SELECT * FROM Dim_Status
	DECLARE @COD_STATUS INT, @STATUS VARCHAR(16)

	DECLARE C_STATUS CURSOR FOR 
	SELECT cod_status, status FROM Aux_Status
	WHERE DATA_CARGA = @DATA_CARGA

	OPEN C_STATUS
	FETCH C_STATUS INTO @COD_STATUS, @STATUS

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		-- UPDATE
		IF EXISTS (SELECT cod_status FROM Dim_Status WHERE cod_status = @COD_STATUS)
		BEGIN
			UPDATE Dim_Status SET status = @STATUS
			WHERE cod_status = @COD_STATUS
		END
		-- INSERT
		ELSE
		BEGIN
			INSERT INTO Dim_Status(cod_status, status)
									  VALUES(@COD_STATUS, @STATUS)
		END

		FETCH C_STATUS INTO @COD_STATUS, @STATUS
	END
	CLOSE C_STATUS
	DEALLOCATE C_STATUS
END