-- zadanie 01:

declare @old_employee int,
		@now_employee int
set @old_employee = 1
set @now_employee = 4

update Orders
set EmployeeID = @now_employee 
where EmployeeID = @old_employee

select * from Orders o
where o.EmployeeID = @old_employee

-- zadanie 02:

begin transaction

declare @ikura_id int
select @ikura_id = p.ProductID 
from Products p
where p.ProductName = 'Ikura'

update od
set od.Quantity = round(0.8 * od.Quantity, 0)
from [Order Details] od
join Orders o on od.OrderID = o.OrderID
where o.OrderDate > '1997-05-15' 
	and od.ProductID = @ikura_id

commit

-- zadanie 03:

begin transaction

declare @chocolade_id int,
		@order_id int

select @chocolade_id = p.ProductID 
from Products p
where p.ProductName = 'Chocolade'

select top 1 @order_id = o.OrderID 
from Orders o
join [Order Details] od on o.OrderID = od.OrderID
where o.CustomerID = 'ALFKI' 
	and od.ProductID <> @chocolade_id
group by o.OrderID, o.OrderDate
order by o.OrderDate desc

insert into [Order Details]
values (
	@order_id, 
	@chocolade_id, 
	1, 
	(select UnitPrice from Products where ProductID = @chocolade_id), 
	0
)

commit

-- zadanie 04:

begin transaction

declare @product_id int,
		@order_id int,
        @unit_price money

select @product_id = p.ProductID,
	   @unit_price = p.UnitPrice 
from Products p 
where p.ProductName = 'Chocolade'

insert into [Order Details]
select 
	o.OrderID, 
	@product_id, 
	@unit_price, 
	1, 
	0 
from Orders o
where o.CustomerID = 'ALFKI' 
	and not exists (
		select 1
		from [Order Details] od
		where od.OrderID = o.OrderID
		and od.ProductID = @product_id
);
commit

-- zadanie 05:

delete from Customers 
where CustomerID not in (
	select CustomerID 
	from Orders
)
go