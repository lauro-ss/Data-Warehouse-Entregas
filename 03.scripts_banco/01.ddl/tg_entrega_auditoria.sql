USE bd_rede_entregas

DROP TRIGGER IF EXISTS TG_ENTREGA_AUDITORIA

CREATE TRIGGER TG_ENTREGA_AUDITORIA
ON ENTREGA
AFTER UPDATE 
AS
BEGIN
	IF trigger_nestlevel() < 2 
		UPDATE ENTREGA
		SET dataAtualizacao = getdate()
		WHERE id IN (SELECT id FROM INSERTED)
END