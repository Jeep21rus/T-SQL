-- 3 Создать функцию
--	3.1 Входной параметр @ID_SKU
--	3.2 Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
--		3.2.1 сумма Value по переданному SKU / сумма Quantity по переданному SKU
--	3.3 На выходе значение типа decimal(18, 2)

if object_id('dbo.udf_GetSKUPrice') is not null drop function dbo.udf_GetSKUPrice;
go

create function dbo.udf_GetSKUPrice
(
	@ID_SKU int
) returns decimal(18, 2)
as
begin
	declare @Result decimal(18, 2)

	select 
		@Result = sum(Value) / sum(Quantity)
	from dbo.Basket
	where ID_SKU = @ID_SKU
	return @Result
end
go

