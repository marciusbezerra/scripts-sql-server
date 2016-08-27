use Northwind

DECLARE TodosOsContatos CURSOR
	KEYSET
	FOR
	SELECT CompanyName, ContactName, ContactTitle
	FROM Customers

GO

OPEN TodosOsContatos
PRINT 'O Cursor tem ' + CONVERT(char(3), @@CURSOR_ROWS) + ' linhas.'
DECLARE @Companhia varchar(40)
DECLARE @Contato varchar(40)
DECLARE @Titulo varchar(40)

FETCH FIRST FROM TodosOsContatos INTO @Companhia, @Contato, @Titulo

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT CONVERT(char(30), @Companhia) + CONVERT(char(25), @Contato) + CONVERT(char(20), @Titulo)
	FETCH NEXT FROM TodosOsContatos INTO @Companhia, @Contato, @Titulo
END

CLOSE TodosOsContatos
DEALLOCATE TodosOsContados