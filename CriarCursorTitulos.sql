USE PUBS

IF EXISTS (SELECT Name FROM SysObjects WHERE Name = 'CriarCursorTitulos')
	DROP PROCEDURE CriarCursorTitulos

GO

CREATE PROCEDURE CriarCursorTitulos
AS
DECLARE Sales CURSOR
FORWARD_ONLY STATIC FOR
	SELECT Titles.Title_ID, Titles.Title, Titles.Ytd_Sales, Titles.Price,
		Roysched.Lorange, Roysched.Hirange, Roysched.Royalty
	FROM Titles, Roysched
	WHERE Titles.Title_ID = Roysched.Title_ID
	ORDER BY Titles.Title, Roysched.Royalty