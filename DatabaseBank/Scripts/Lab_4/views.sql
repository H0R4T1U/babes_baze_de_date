USE Bank;
/*
Terenuri - 1 PK, 1 FK -> Client
Rezervari - 1 PK -> Account 
RezervariTerenuri - 2 PK -> Client_accounts
*/
GO
CREATE OR ALTER VIEW View_Client AS
SELECT client_id, first_name, last_name,email,address
FROM ClientsTest;

GO
CREATE OR ALTER VIEW View_ClientAccounts AS
SELECT a.Id AS AccountId, a.type,a.status,a.balance AS AccountsTest, c.first_name,c.last_name AS ClientsTest
FROM AccountsTest a
INNER JOIN ClientsAccountsTest ca ON a.Id = ca.AccountId
INNER JOIN ClientsTest c ON ca.ClientId = c.client_id; -- afisam toate rezervarile, clientii, pretul si locatia

GO
CREATE OR ALTER VIEW View_Accounts AS
SELECT c.branch_id AS ClientTest, COUNT(a.Id) AS TotalAccounts, SUM(a.balance) AS TotalBalance
FROM AccountsTest a
INNER JOIN ClientsAccountsTest ca ON a.Id = ca.AccountId
INNER JOIN ClientsTest c ON ca.ClientId = c.client_id
GROUP BY c.branch_id; -- nr de conturi si totalul de bani pentru fiecare branch

GO
CREATE OR ALTER PROCEDURE viewTableRows
	@tableName VARCHAR(50)
AS
BEGIN
	IF @tableName = 'Clients'
	BEGIN
		SELECT * FROM View_Client
	END

	ELSE IF @tableName = 'Accounts'
	BEGIN
		SELECT * FROM View_Accounts
	END

	ELSE IF @tableName = 'ClientAccounts'
	BEGIN
		SELECT * FROM View_ClientAccounts
	END
END

		
	
GO
SELECT * FROM View_Client
SELECT * FROM View_ClientAccounts
SELECT * FROM View_Accounts

GO
DROP VIEW View_Client;
DROP VIEW View_ClientAccounts;
DROP VIEW View_Accounts;