-- 5 Создать процедуру (на выходе: файл dbo.usp_MakeFamilyPurchase)
--	5.1 Входной параметр (@FamilySurName varchar(255)) одно из значений атрибута SurName таблицы dbo.Family
--	5.2 Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
--	   5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
--	   5.2.2 При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет


if object_id('dbo.usp_MakeFamilyPurchase') is not null drop procedure dbo.usp_MakeFamilyPurchase;
go

create procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
begin

    if not exists
		(
		select
			ID
			,SurName
			,BudgetValue
		from dbo.Family
		where SurName = @FamilySurName
		)
    begin
        print ('Семьи с данной фамилией не существует в таблице Family')
	end

    declare @familyBasketValue decimal(18, 2)
    set
		@familyBasketValue = 
			(
			select
				sum(Value)
			from dbo.Basket as b
				inner join dbo.Family as f on b.ID_Family = f.ID
			where SurName = @FamilySurName)

    update dbo.Family
    set
		BudgetValue = BudgetValue - @familyBasketValue
    where SurName = @FamilySurName
end
