
use pubs

if exists (select name from sysobjects where name = 'BuscaDeLivro')
	drop procedure BuscaDeLivro

go

create procedure BuscaDeLivro
@arg1 varchar(99), @arg2 varchar(99),
@arg3 varchar(99), @arg4 varchar(99),
@arg5 varchar(99)
as
declare @Argumentos varchar(999)
declare @TextoSql varchar(999)

set @arg1 = ltrim(rtrim(@arg1))
set @arg2 = ltrim(rtrim(@arg2))
set @arg3 = ltrim(rtrim(@arg3))
set @arg4 = ltrim(rtrim(@arg4))
set @arg5 = ltrim(rtrim(@arg5))

set @Argumentos = "WHERE "

if len(@arg1) > 0 
	set @Argumentos = @Argumentos + "Title like '%" + @arg1 + "%' AND "

if len(@arg2) > 0 
	set @Argumentos = @Argumentos + "Title like '%" + @arg2 + "%' AND "

if len(@arg3) > 0 
	set @Argumentos = @Argumentos + "Title like '%" + @arg3 + "%' AND "

if len(@arg4) > 0 
	set @Argumentos = @Argumentos + "Title like '%" + @arg4 + "%' AND "

if len(@arg5) > 0 
	set @Argumentos = @Argumentos + "Title like '%" + @arg5 + "%' AND "


set @Argumentos = substring(@Argumentos, 1, len(@Argumentos) -4)

if len(@Argumentos) > 6 
	set @TextoSql = "select title from titles "  + @Argumentos + " order by title"
else
	set @TextoSql = "select title from titles order by title"

print @TextoSql -- Como o Debug.Print

execute (@TextoSql)
