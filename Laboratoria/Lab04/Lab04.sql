-- zadanie 01:

select * from Orders
go

-- zadanie 02:

select * from Orders o 
where o.ShipCountry in ('Mexico', 'Germany', 'Brazil')
go

-- zadanie 03:

select distinct o.ShipCity 
from Orders o 
where o.ShipCountry = 'Germany'
go

-- zadanie 04:

select * from Orders o 
where MONTH(o.OrderDate) = 7 
	and YEAR(o.OrderDate) = 1996
go

-- zadanie 05:

select distinct LEFT(UPPER(c.CompanyName), 10) as [Company Code] 
from Customers c
go

-- zadanie 06:

select o.* from Orders o
join Customers c on o.CustomerID = c.CustomerID
where c.Country = 'France'
go

-- zadanie 07:

select distinct o.ShipCountry from Orders o
join Customers c on o.CustomerID = c.CustomerID
where c.Country = 'Germany'
go

-- zadanie 08:

select o.* from Orders o
join Customers c on o.CustomerID = c.CustomerID
where c.Country <> o.ShipCountry
go

-- zadanie 09:

select * from Customers c
where not exists (
	select * from Orders o 
	where o.CustomerID = c.CustomerID
)
go

-- zadanie 10:

select * from Customers c
where not exists (
	select * from Orders o 
	join [Order Details] od on o.OrderID = od.OrderID
	join Products p on od.ProductID = p.ProductID
	where p.ProductName like '%Chocolate%' 
		  and o.CustomerID = c.CustomerID
)
go

-- zadanie 11:

select * from Customers c
where exists (
	select * from Orders o 
	join [Order Details] od on o.OrderID = od.OrderID
	join Products p on od.ProductID = p.ProductID
	where p.ProductName like '%Scottish Longbreads%' 
		  and o.CustomerID = c.CustomerID)
go

-- zadanie 12:

select o.* from Orders o
where not exists(
	select * from [Order Details] od
	join Products p on od.ProductID = p.ProductID
	where p.ProductName like '%Chocolade%' and od.OrderID = o.OrderId
) and exists(
	select * from [Order Details] od
	join Products p on od.ProductID = p.ProductID
	where p.ProductName like '%Scottish Longbreads%' and od.OrderID = o.OrderId
) 
go

-- zadanie 13:

select distinct e.FirstName, e.LastName 
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
where o.CustomerID like '%ALFKI%'
go

select distinct e.FirstName, e.LastName 
from Employees e
where exists (
	select * from Orders o
	where o.CustomerID like '%ALFKI%' 
		and o.EmployeeID = e.EmployeeID
)
go

-- zadanie 14:

select 
	e.FirstName, 
	e.LastName, 
	c.CompanyName, 
	o.OrderDate, 
	(case when od.OrderID is null then 0 else 1 end) as [Contains Chocolade]
from Employees e 
left join Orders o on o.EmployeeID = e.EmployeeID
left join [Order Details] od on o.OrderID = od.OrderID 
	and od.productid = (
		select p.ProductId from Products p 
		where p.ProductName = 'Chocolade'
	)
left join Customers c on c.CustomerID = o.CustomerID
go

-- zadanie 15:

select 
	p.ProductName, 
    o.ShipCountry as [Ship Country], 
    o.OrderID as [Order ID], 
    YEAR(o.OrderDate) as [Order Year], 
    MONTH(o.OrderDate) as [Order Month],
    o.OrderDate as [Order Date]
from Products p
join [Order Details] od on p.ProductID = od.ProductID
join Orders o on od.OrderID = o.OrderId
join Customers c on o.CustomerID = c.CustomerID
where c.Country = 'Germany' 
	and p.ProductName like '[c-s]%'
order by o.OrderDate desc
go

-- zadanie 16:

select
	RIGHT(c.ContactName, CHARINDEX(' ', REVERSE(c.ContactName)) - 1) as [Nazwisko Klienta],
	o.OrderID as [Identyfikator zamówienia],
	p.ProductName as [Nazwa produktu],
	od.Quantity as [Zamówiona iloœæ],
	od.UnitPrice as [Cena produktu],
	(od.Quantity * od.UnitPrice) as [Cena ca³kowita],
	DATEDIFF(day, o.OrderDate, o.ShippedDate) as [Liczba dni]
from Orders o
join [Order Details] od on o.OrderID = od.OrderID
join Customers c on o.CustomerID = c.CustomerID
join Products p on od.ProductID = p.ProductID
order by o.OrderID asc

-- zadanie 17:

declare @p1 money,
	    @p2 money,
		@p3 money,
		@p4 money

with q (customer_id, total_expense) as (
	select 
		o.CustomerId, 
		sum(od.Quantity*od.UnitPrice - (1 - od.Discount))
	from [Order Details] od
	join Orders o on o.OrderID = od.OrderID
	group by o.CustomerID
)
select @p1 = max(q.total_expense), @p4 = min(q.total_expense) from q

set @p3 = @p4 + (@p1 - @p4)/4
set @p2 = @p3 + (@p1 - @p4)/4
set @p1 = @p2 + (@p1 - @p4)/4

select o.CustomerId as [Customer], 
	   sum(od.Quantity*od.UnitPrice - (1 - od.Discount)) as [Total Expenses],
	   case 
			when sum(od.Quantity*od.UnitPrice - (1 - od.Discount)) <= @p3 then 'D'
		    when sum(od.Quantity*od.UnitPrice - (1 - od.Discount)) <= @p2 then 'C'
			when sum(od.Quantity*od.UnitPrice - (1 - od.Discount)) <= @p1 then 'B'
			else 'A'
	   end as [Clasification]
from [Order Details] od
join Orders o on o.OrderID = od.OrderID
group by o.CustomerID
order by Clasification asc
go