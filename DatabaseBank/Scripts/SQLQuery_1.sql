GO
CREATE OR ALTER FUNCTION ValidareDate(
	@idComanda INT,
	@idInghetata INT,
	@data DATE,
	@discount INT
)RETURNS INT AS BEGIN 
	declare @count int
	SELECT @count = COUNT(*) From Livrarii where idInghetata =@idInghetata and idComanda=@idComanda;

	IF @count > 0
		return 0
	RETURN 1
END
GO