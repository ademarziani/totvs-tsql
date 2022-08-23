declare @n int = 1
declare @max int
declare @query varchar(1000)
declare @tabla varchar(6)
declare @emp varchar(2) = '030'

create table #datos (tabla varchar(6), cantreg int)

--|---------------------------------------------
--| Cambiar el where para
--| en caso de no considerar alguna 
--| regla en particular de nombres de tablas
--|---------------------------------------------
SELECT identity(int,1,1) as id, name
INTO #tablas 
FROM sys.objects
WHERE type_desc = 'USER_TABLE'
and LEN(name) = 6
and SUBSTRING(name,4,3) = @emp+'0'
and LEFT(name,1) not in ('X')
and LEFT(name,2) not in ('SX')
and LEFT(name,3) not in ('SIX')

set @max = @@ROWCOUNT

while @n <= @max
	begin

	set @tabla = (select name from #tablas where id = @n)
	
	set @query = '
	declare @cantreg int = (select count(*) from '+@tabla+')
	 
	if @cantreg <> 0
		begin
		
		insert into #datos
			values ('''+@tabla+''', @cantreg)			
	end '
		
	exec(@query)
		
	set @n = @n + 1
end 

--|------------------------------------
--| Select Final
--| Cambiar order by si es necesario
--|------------------------------------
select *
from #datos
order by tabla

drop table #tablas
drop table #datos
