-- 4 Создать представление (на выходе: файл в репозитории dbo.vw_SKUPriceв ветке VIEWs)
--	4.1 Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта
--	(используя функцию dbo.udf_GetSKUPrice)

if object_id('dbo.vw_SKUPrice') is not null drop view dbo.vw_SKUPrice;
go

create view dbo.vw_SKUPrice as
select
	ID
	,Code
	,Name
	,dbo.udf_GetSKUPrice(ID) as Price
from dbo.SKU;

