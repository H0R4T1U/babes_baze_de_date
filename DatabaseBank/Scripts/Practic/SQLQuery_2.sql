USE Practic

GO



CREATE OR ALTER FUNCTION ValidareDate(
	@idArtist INT,
	@idMuzeu INT,
	@data DATE,
	@discount INT
)RETURNS INT AS BEGIN 
	declare @count int
	SELECT @count = COUNT(*) From Expozitie where idArtist =@idArtist and idMuzeu=@idMuzeu;

	IF @count > 0
		return 0
	RETURN 1
END
GO



GO
CREATE OR ALTER PROCEDURE AddExpozitii
	@idArtist INT,


	@idMuzeu INT,

	@dataExpozitie DATE,
	@pretBilet INT
AS BEGIN 
	DECLARE @validationStatus INT
	SELECT @validationStatus = dbo.ValidareDate(@idArtist,@idMuzeu,@dataExpozitie,@pretBilet );

	IF (@validationStatus = 0)
	BEGIN
		UPDATE Expozitie
			SET DataExpozitie=@dataExpozitie,Pret=@pretBilet
			where idArtist=@idArtist and idMuzeu=@idMuzeu;
	SELECT * FROM Expozitie
	PRINT('Expozitia a fost modificata cu succes!');
	END
	
	IF(@validationStatus = 1)
	BEGIN
		INSERT INTO Expozitie(idArtist,idMuzeu,DataExpozitie,Pret) VALUES
		(@idArtist,@idMuzeu,@dataExpozitie,@pretBilet)

		SELECT * FROM Artisti	
		SELECT * FROM Muzee
		SELECT * FROM Expozitie
		PRINT('S-a adaugat Expozitia')
	END
END
GO

EXEC AddExpozitii @idArtist=1,@idMuzeu=2,@dataExpozitie='2025-01-01',@pretBilet=40;
EXEC AddExpozitii @idArtist=1,@idMuzeu=2,@dataExpozitie='2025-01-05',@pretBilet=40;


