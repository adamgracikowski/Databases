-- zadanie 01:

select 
	od.ProductID, 
	o.ShipCountry, 
	sum(od.Quantity) as [TotalQuantity] 
from [Order Details] od
join Orders o on od.OrderID = o.OrderID
where o.EmployeeID = 2
group by od.ProductID, o.ShipCountry
order by od.ProductID, o.ShipCountry
go

-- zadanie 02:

declare @chocolade_id int
select @chocolade_id = p.ProductId 
from Products p 
where p.ProductName like '%Chocolade%'

select 
	e.FirstName, 
	e.LastName, 
	sum(od.Quantity) from Employees e 
join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] od on o.OrderID = od.OrderID
where YEAR(o.OrderDate) = 1998 
	and od.ProductID = @chocolade_id
group by e.FirstName, e.LastName
having sum(od.Quantity) >= 100
go

-- zadanie 03:

select 
	p.ProductID, 
	p.ProductName,
	avg(od.Quantity) as [Average Quantity], 
	count(o.OrderID) as [Total Orders]
from [Order Details] od
	join Orders o on o.OrderID = od.OrderID
	join Customers c on o.CustomerID = c.CustomerID
	join Products p on p.ProductID = od.ProductID
where c.Country = 'Italy'
group by o.OrderID, p.ProductID, p.ProductName
having avg(od.Quantity) >= 20
order by count(o.OrderID) desc;
go

-- zadanie 04:

select 
	c.CompanyName, 
	p.ProductName, 
	o.OrderDate, 
	sum(od.Quantity) as [Total Quantity] from Customers c
join Orders o on o.CustomerID = c.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID
where c.City = 'Berlin'
group by c.CompanyName, p.ProductName, o.OrderDate
order by c.CompanyName, p.ProductName, o.OrderDate
go

-- zadanie 05:

select distinct 
	p.ProductId, 
	p.ProductName 
from Products p
where exists (
	select * from Orders o 
	join [Order Details] od on o.OrderID = od.OrderID
	where od.ProductID = p.ProductID 
		and o.ShipCountry = 'France' 
		and year(o.ShippedDate) = 1998
) order by p.ProductId
go

-- zadanie 06:

select 
	c.CustomerID, 
	c.ContactName 
from Customers c 
where c.CustomerId in (
	select o.CustomerId from Orders o
	group by o.CustomerID
	having count(*) >= 2
	) and not exists (
	select * from [Order Details] od
	join Products p on p.ProductID = od.ProductID
	join Orders o on o.OrderID = od.OrderID
	where o.CustomerID = c.CustomerID 
		and p.ProductName like 'Ravioli%'
) order by c.CustomerID
go

-- II sposób:

select 
	c.CustomerID, 
	c.CompanyName
from Customers c
where c.CustomerID IN (
    select o.CustomerID
    from Orders o
    group by o.CustomerID
    having count(*) >= 2
) and c.CustomerID not in (
    select o.CustomerID
    from Orders o
    join [Order Details] od on o.OrderID = od.OrderID
    join Products p on od.ProductID = p.ProductID
    where p.ProductName like 'Ravioli%'
)

-- zadanie 07:

select 
	c.CompanyName, 
	o.OrderID, 
	sum(distinct od.ProductID) as [ProductCount] 
from Orders o
join [Order Details] od on o.OrderID = od.OrderID
join Customers c on c.CustomerID = o.CustomerID
where c.Country = 'France'
group by o.OrderID, c.CompanyName
having sum(distinct od.ProductID) >= 4
order by c.CompanyName, o.OrderID
go

-- zadanie 08:

select c.CompanyName 
from Customers c
where (
	select count(*) from Orders o 
	where o.CustomerID = c.CustomerID 
		and o.ShipCountry = 'France'
	) >= 5 and (
	select count(*) from Orders o 
	where o.CustomerID = c.CustomerID 
		and o.ShipCountry = 'Belgium'
    ) <= 2
order by c.CompanyName
go

-- zadanie 09:

with cte as (
	select 
		p.ProductName, 
		c.CompanyName, 
		max(od.Quantity) as [MaxQuantity]
	from Products p
	join [Order Details] od on od.ProductID = p.ProductID
	join Orders o on o.OrderID = od.OrderID
	join Customers c on c.CustomerID = o.CustomerID
	group by p.ProductName, c.CompanyName
), cte1 as (
select 
	ProductName, 
	CompanyName,
	MaxQuantity,
	max(MaxQuantity) over (partition by ProductName) as MQ
from cte
)
select 
	ProductName, 
	CompanyName,
	MQ as [MaxQuantity]
from cte1
where MaxQuantity = MQ
order by ProductName, CompanyName;
go

-- II sposób:

with MaxOrderQuantity as (
    select 
		od.ProductID,
        MAX(od.Quantity) AS MaxQuantity
	from [Order Details] od
    group by od.ProductID
)
select 
    p.ProductName,
    c.CompanyName,
    moq.MaxQuantity
from Customers c
join Orders o ON c.CustomerID = o.CustomerID
join [Order Details] od ON o.OrderID = od.OrderID
join Products p ON od.ProductID = p.ProductID
join MaxOrderQuantity moq ON od.ProductID = moq.ProductID 
	and od.Quantity = moq.MaxQuantity
order by 
    p.ProductName, c.CompanyName
go

-- zadanie 10:

with EmployeeOrders as (
	select 
		e.EmployeeId,
		count(o.OrderId) as [TotalOrders]
	from Employees e
	join Orders o on e.EmployeeID = o.EmployeeID
	group by e.EmployeeID
)
select * from EmployeeOrders eo
where eo.TotalOrders > 1.2 * (select avg(eo.TotalOrders) from EmployeeOrders eo)
order by eo.TotalOrders desc
go

---- zadanie 11:

select top 5 
	od.OrderId, 
	count(od.ProductID) [ProductCount] 
from [Order Details] od
group by od.OrderID
order by count(od.ProductID) desc
go

-- zadanie 12:

with QuantitySummary as (
	select 
		p.ProductName, 
		coalesce((
			select sum(od.Quantity) 
			from [Order Details] od
			join Orders o on od.OrderID = o.OrderID
			where od.ProductID = p.ProductID
				and year(o.OrderDate) = 1996), 0) as TotalQuantityIn1996,
		coalesce((
			select sum(od.Quantity) from [Order Details] od
		    join Orders o on od.OrderID = o.OrderID
		    where od.ProductID = p.ProductID
				and year(o.OrderDate) = 1997), 0) as TotalQuantityIn1997
	from Products p
)
select * from QuantitySummary qs
where qs.TotalQuantityIn1997 > qs.TotalQuantityIn1996
order by qs.TotalQuantityIn1997 desc, 
		 qs.TotalQuantityIn1996 desc
go

-- II sposób:
with QuantitySummary as (
	select 
		p.ProductName,
		sum(case when year(o.OrderDate) = 1996 then od.Quantity else 0 end) as TotalQuantityIn1996,
		sum(case when year(o.OrderDate) = 1997 then od.Quantity else 0 end) as TotalQuantityIn1997
	from Products p
	join [Order Details] od on p.ProductID = od.ProductID
	join Orders o on od.OrderID = o.OrderID
	where year(o.OrderDate) in (1996, 1997)
	group by p.ProductName
)
select * from QuantitySummary qs
where qs.TotalQuantityIn1997 > qs.TotalQuantityIn1996
order by qs.TotalQuantityIn1997 desc, 
		 qs.TotalQuantityIn1996 desc
go

-- zadanie 13:

with OrdersSummary as (
	select 
		p.ProductName, 
		(select count(*) from [Order Details] od
		 join Orders o on od.OrderID = o.OrderID
		 where od.ProductID = p.ProductID
			and year(o.OrderDate) = 1996
		) as TotalQuantityIn1996,
		(select count(*) from [Order Details] od
		 join Orders o on od.OrderID = o.OrderID
		 where od.ProductID = p.ProductID
			and year(o.OrderDate) = 1997
		) as TotalQuantityIn1997
	from Products p
)
select * from OrdersSummary os
where os.TotalQuantityIn1997 > os.TotalQuantityIn1996
order by os.TotalQuantityIn1997 desc, 
		 os.TotalQuantityIn1996 desc
go

-- zadanie 14:

create view Summary as (
	select 
		year(o.OrderDate) as OrderYear,
		datepart(month, o.OrderDate) as OrderMonth,
		o.OrderID, o.CustomerID, c.CompanyName, 
		c.Country as CustomerCountry,
		c.City as CustomerCity,
		o.ShipCountry, o.ShipCity, od.ProductID, p.ProductName, 
		ca.CategoryName, od.UnitPrice,
		od.Quantity, od.UnitPrice * od.Quantity as ProductValue 
	from Orders o
	join [Order Details] od on od.OrderID = o.OrderID
	join Customers c on c.CustomerID = o.CustomerID
	join Products p on od.ProductID = p.ProductID
	join Categories ca on ca.CategoryID = p.CategoryID
)
go

select * from Summary
go

-- zadanie 15:

select od.OrderID, 
	p.ProductName, 
	ca.CategoryName,
	od.UnitPrice * od.Quantity as ProductValue,
	sum(od.UnitPrice * od.Quantity) 
		over (partition by p.ProductName) as ProductTotalSale,
	sum(od.UnitPrice * od.Quantity) 
		over (partition by ca.CategoryName) as CategoryTotalSale
from Products p
join [Order Details] od on od.ProductID = p.ProductID
join Categories ca on ca.CategoryID = p.CategoryID
order by p.ProductName
go

-- zadanie 16:

select distinct
	p.ProductName, 
	ca.CategoryName,
	sum(od.UnitPrice * od.Quantity) 
		over (partition by p.ProductName) as ProductTotalSale,
	sum(od.UnitPrice * od.Quantity)
		over (partition by ca.CategoryName) as CategoryTotalSale,
	sum(od.UnitPrice * od.Quantity) 
		over () as TotalSale
from Products p
join [Order Details] od on od.ProductID = p.ProductID
join Categories ca on ca.CategoryID = p.CategoryID
order by p.ProductName
go

-- zadanie 17:

select
	od.OrderID,
	p.ProductID,
	od.UnitPrice * od.Quantity as ProductValue,
	sum(od.UnitPrice * od.Quantity) 
		over (order by od.OrderId, p.ProductId rows between unbounded preceding and current row)
		as ProdTotalSale
from Products p
join [Order Details] od on od.ProductID = p.ProductID
order by OrderId
go

-- zadanie 18:

select
	od.OrderID,
	p.ProductID,
	od.UnitPrice * od.Quantity as ProductValue,
	sum(od.UnitPrice * od.Quantity) 
		over (order by od.OrderId, p.ProductId rows between 2 preceding and current row)
		as ProdTotalSale
from Products p
join [Order Details] od on od.ProductID = p.ProductID
order by od.OrderId, p.ProductID
go

-- zadanie 19:

with OrdersGrouped as (
	select 
		sum(ProductValue) as OrderTotal,
		ProductName, 
		OrderYear, 
		OrderMonth
	from Summary
	group by ProductName, OrderYear, OrderMonth
)
select
	og.ProductName,
	og.OrderYear,
	og.OrderMonth,
	sum(og.OrderTotal)
		over (partition by og.ProductName, og.OrderYear, og.OrderMonth)
		as ProductMonthSale,
	sum(og.OrderTotal)
		over (partition by og.ProductName, og.OrderYear order by og.OrderMonth)
		as ProdUntilMonthSale,
	count(*) 
		over (partition by og.ProductName, og.OrderYear order by og.OrderMonth)
		as MonthCount
from OrdersGrouped og
order by og.ProductName, og.OrderYear, og.OrderMonth
go