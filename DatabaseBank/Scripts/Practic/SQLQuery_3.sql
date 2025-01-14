USE Practic

GO


CREATE OR ALTER FUNCTION getMin()
RETURNS INT
AS
BEGIN
    DECLARE @min INT;

    WITH Counts AS (
        SELECT idArtist, COUNT(*) AS cnt
        FROM Expozitie
        GROUP BY idArtist
    ),
    MinCount AS (
        SELECT MIN(cnt) AS minCnt
        FROM Counts
    )
    SELECT TOP 1 @min = minCnt
    FROM MinCount


    RETURN @min;
END;

GO
CREATE OR ALTER FUNCTION Afisare(
	@numar INT
)
RETURNS TABLE AS RETURN 
	SELECT m.Denumire AS Denumire
	FROM Mobilier m INNER JOIN Expozitie e ON
	m.idArtist=e.idArtist
	Group by m.Denumire
	HAVING COUNT(e.idArtist) >= @numar;
GO
DECLARE @min INT
	SELECT @min = dbo.getMin();
PRINT @min;
SELECT * FROM Afisare(@min)

