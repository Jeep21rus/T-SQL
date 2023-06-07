-- 6. Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
--	 6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue,
--	 для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0

if object_id('dbo.TR_Basket_insert_update') is not null drop trigger dbo.TR_Basket_insert_update;
go

create trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
	set nocount on;

	declare @count int
	declare @id_sku int

	select
		@count = count(*)
		,@id_sku = ID_SKU
	from inserted
	group by ID_SKU

	if @count > 1
	begin
		update
			dbo.Basket
		set DiscountValue = Value * 0.05
		where ID_SKU = @id_sku
	end
	else
	begin
		update
			dbo.Basket
		set DiscountValue = 0
		where ID_SKU = @id_sku
    end
end