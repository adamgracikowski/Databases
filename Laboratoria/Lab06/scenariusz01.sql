-- scenariusz 01:

begin transaction

-- Utworzenie tabeli ArchivedOrders:

select
     o.*, 
	 GETDATE() as ArchiveDate
into ArchivedOrders
from Orders o
where year(o.OrderDate) = 1996;

-- Utworzenie tabeli ArchivedOrderDetails:

select 
    od.*
into ArchivedOrderDetails
from [Order Details] od
join ArchivedOrders ao ON od.OrderID = ao.OrderID
where year(ao.OrderDate) = 1996;

-- Usuniêcie wierszy z Order Details:

delete from [Order Details]
where OrderID in (
	select OrderID 
	from Orders 
	where year(OrderDate) = 1996
);

-- Usuniêcie wierszy z Orders:

delete from Orders
where year(OrderDate) = 1996;

-- Ustawienie kluczy w tabeli ArchivedOrders:

alter table ArchivedOrders
add constraint PK_ArchivedOrders 
primary key (OrderID);
go

alter table ArchivedOrders
add constraint FK_ArchivedOrders_Customers 
foreign key (CustomerID) 
references Customers(CustomerID);
go

alter table ArchivedOrders
add constraint FK_ArchivedOrders_Employees 
foreign key (EmployeeID) 
references Employees(EmployeeID);
go

-- Ustawienie kluczy w tabeli ArchivedOrderDetails:

alter table ArchivedOrderDetails
add constraint PK_ArchivedOrderDetails 
primary key (OrderID, ProductID); -- Klucz z³o¿ony sk³adaj¹cy siê z OrderID i ProductID
go

alter table ArchivedOrderDetails
add constraint FK_ArchivedOrderDetails_Orders 
foreign key (OrderID) 
references ArchivedOrders(OrderID);
go

alter table ArchivedOrderDetails
add constraint FK_ArchivedOrderDetails_Products 
foreign key (ProductID) 
references Products(ProductID);
go

commit

-- Sprawdzenie poprawnoœci:

select * from Orders
where year(OrderDate) = 1996;
go

select * from ArchivedOrders ao
go

select * from [Order Details]
where OrderID in (select OrderID from Orders where year(OrderDate) = 1996)
go

select * from ArchivedOrderDetails aod
go