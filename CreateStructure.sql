-- 2. Создать таблицы (на выходе: файл в репозитории CreateStructure.sql в ветке Tables)
-- 2.1 dbo.SKU (ID identity, Code, Name)
--   2.1.1 Ограничение на уникальность поля Code
--   2.1.2 Поле Code вычисляемое: "s" + ID
-- 2.2 dbo.Family (ID identity, SurName, BudgetValue)
-- 2.3 dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (Внешний ключ на таблицу dbo.Family) Quantity,
-- Value, PurchaseDate, DiscountValue)
--   2.3.1 Ограничение, что поле Quantity и Value не могут быть меньше 0
--  2.3.2 Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)

if object_id('dbo.SKU', 'U') is not null drop table dbo.SKU;
create table dbo.SKU 
	(
	ID int identity(1, 1) not null constraint PK_IDSKU primary key
	,Code as ('s' + cast(ID AS varchar(50))) constraint UQ_Code unique
	,Name varchar(255) not null
	);
go


if object_id('dbo.Family', 'U') is not null drop table dbo.Family;
create table dbo.Family 
	(
	ID int identity(1, 1) not null constraint PK_IDFamily primary key
	,SurName varchar(255) not null
	,BudgetValue decimal(18, 2) not null
	);
go


if object_id('dbo.Basket', 'U') is not null drop table dbo.Busket;
create table dbo.Basket 
	(
	ID int identity(1, 1) not null constraint PK_IDBusket primary key
	,ID_SKU int not null
	,ID_Family int not null
	,Quantity int not null constraint CK_Quantity check (Quantity >= 0)
	,Value int not null constraint CK_Value check (Value >= 0)
	,PurchaseDate date not null constraint DFT_PurchaseDate default getdate()
	,DiscountValue decimal(18, 2) not null
	 -- объявление ограничений внешнего ключа на уровне таблицы, чтобы удобнее было
	 -- в случае чего прописать инструкции on delete и on update
	,constraint FK_SKU foreign key (ID_SKU) references SKU (ID)
	,constraint FK_Family foreign key (ID_Family) references Family (ID)
	);
