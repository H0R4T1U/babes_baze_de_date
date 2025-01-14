USE Bank
GO

/*
Terenuri - 1 PK, 1 FK -> Client
Rezervari - 1 PK -> Account 
RezervariTerenuri - 2 PK -> Client_accounts
*/

GO
CREATE OR ALTER PROCEDURE insertTableRows 
	@tableName VARCHAR(50),
	@noOfRows INT
AS
BEGIN

	DECLARE @contor INT
	SET @contor = 1

	WHILE @contor <= @noOfRows
	BEGIN		
		IF @tableName = 'Clients'
		BEGIN
			DECLARE @first_name VARCHAR(20)
			DECLARE @last_name VARCHAR(20)
			DECLARE @email VARCHAR(20)
			DECLARE @address VARCHAR(20)

			DECLARE @branch_id INT


			SET @first_name = 'prenume ' + CONVERT(VARCHAR(7), @contor)
			SET @last_name = 'nume ' + CONVERT(VARCHAR(7), @contor)
			SET @email = 'email: ' + CONVERT(VARCHAR(7), @contor)
			SET @address = 'addr: ' + CONVERT(VARCHAR(7), @contor)

			SELECT TOP 1 @branch_id = branch_id FROM Branches ORDER BY NEWID()

			INSERT INTO ClientsTest(client_id, branch_id, first_name, last_name,email,address) 
			VALUES (@contor, @branch_id, @first_name, @last_name,@email,@address)
	   END
		
		ELSE IF @tableName = 'Accounts'
		BEGIN
			DECLARE @type VARCHAR(50)
			DECLARE @status VARCHAR(20)
			DECLARE @balance FLOAT

			SET @type = 'type:' + CONVERT(VARCHAR(7), @contor)
			SET @status = 'status:' + CONVERT(VARCHAR(7), @contor)
			SET @balance = RAND() * 50
			
			INSERT INTO AccountsTest(Id, type, status,balance)
			VALUES (@contor, @type, @status,@balance)
		END

		ELSE IF @tableName = 'ClientAccounts'
		BEGIN
			DECLARE @idAccount INT
			DECLARE cursorRezervari CURSOR FAST_FORWARD FOR

			SELECT Id FROM AccountsTest;
			OPEN cursorRezervari
			FETCH NEXT FROM cursorRezervari INTO @idAccount;
			WHILE @@FETCH_STATUS=0	
			BEGIN
				INSERT INTO ClientsAccountsTest(ClientId, AccountId)
			    VALUES (@idAccount, @idAccount)
				SET @contor = @contor + 1
				FETCH NEXT FROM cursorRezervari INTO @idAccount;
			END

			CLOSE cursorRezervari;
			DEALLOCATE cursorRezervari
			
		END
		SET @contor = @contor + 1
	END
	
END

GO
USE Bank
EXEC insertTableRows Clients, 10000;
EXEC insertTableRows Accounts, 10000;
EXEC insertTableRows ClientAccounts, 10000;

SELECT * FROM ClientsTest;
SELECT * FROM AccountsTest;
SELECT * FROM ClientsAccountsTest;

DELETE FROM ClientsAccountsTest
DELETE FROM AccountsTest
DELETE FROM ClientsTest