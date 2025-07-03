-- zadanie 01:

select p.ProductName
from Products p
where p.ProductName like '%A%'
order by p.ProductName desc
go

-- zadanie 02:

select 
	e.FirstName, 
	e.LastName
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID
where p.ProductName = 'Boston Crab Meat'
group by e.FirstName, e.LastName
having max(od.Quantity) > (
	select avg(od.Quantity) 
	from [Order Details] od
	join Products p on p.ProductID = od.ProductID
	where p.ProductName = 'Boston Crab Meat'
) order by e.FirstName, e.LastName
go

-- zadanie 03:

with MonthProductSummary as (
	select 
		p.ProductName,
		(select sum(od.Quantity)
		 from [Order Details] od
		 join Orders o on o.OrderID = od.OrderID
		 where od.ProductID = p.ProductID 
			and month(o.OrderDate) between 5 and 10 
		) as TotalQuantityFromMayToOctober,
		(select sum(od.Quantity)
		 from [Order Details] od
		 join Orders o on o.OrderID = od.OrderID
		 where od.ProductID = p.ProductID 
			and month(o.OrderDate) not between 5 and 10 
		) as TotalQuantityFromNovermberToApril
	from Products p
)
select mps.ProductName from MonthProductSummary mps
where mps.TotalQuantityFromMayToOctober > mps.TotalQuantityFromNovermberToApril
order by mps.TotalQuantityFromMayToOctober desc
go

-- II sposób:
with MonthProductSummary as (
    select 
        p.ProductName,
        sum(case when month(o.OrderDate) between 5 and 10 then od.Quantity else 0 end) 
			as TotalQuantityFromMayToOctober,
        sum(case when month(o.OrderDate) not between 5 and 10 then od.Quantity else 0 end) 
			as TotalQuantityFromNovermberToApril
    from Products p
    join [Order Details] od on p.ProductID = od.ProductID
    join Orders o on o.OrderID = od.OrderID
    group by p.ProductName
)
select mps.ProductName 
from MonthProductSummary mps
where mps.TotalQuantityFromMayToOctober > mps.TotalQuantityFromNovermberToApril
order by mps.TotalQuantityFromMayToOctober desc
go

-- zadanie 04:

select * from Orders o
where o.OrderID in (
	select o.OrderID
	from Orders o
	join [Order Details] od on od.OrderID = o.OrderID
	where o.ShipCountry <> 'France'
	group by o.OrderID
	having count(distinct od.ProductID) >= 5
) order by o.OrderID
go

-- II sposób:
select * from Orders o
where exists (
	select ord.OrderID
	from Orders ord
	join [Order Details] od on od.OrderID = ord.OrderID
	where ord.ShipCountry <> 'France'
	group by ord.OrderID
	having count(distinct od.ProductID) >= 5
		and o.OrderId = ord.OrderId
) order by o.OrderID
go

-- III sposób:
select o.*
from Orders o
join (
	select 
		od.OrderID, 
        count(distinct od.ProductID) as DifferentProductsCount
    from [Order Details] od
    group by od.OrderID
    having count(distinct od.ProductID) >= 5
) as pc on o.OrderID = pc.OrderID
where o.ShipCountry != 'France'
order by o.OrderID
go

-- zadanie 05:

with MonthlySummary1997 as (
	select 
		month(o.OrderDate) as [OrderMonth],
		count(*) as [TotalOrders]
	from Orders o
	where year(o.OrderDate) = 1997
	group by month(o.OrderDate)
)
select 
	ms.OrderMonth,
	ms.TotalOrders,
	sum(ms.TotalOrders) over (
		order by ms.OrderMonth 
		rows between unbounded preceding and current row
	) as TotalCountForYear,
	sum(ms.TotalOrders) over (
		order by ms.OrderMonth 
		rows between 2 preceding and current row
	) as [TotalCountForLastMonths]
from MonthlySummary1997 ms
order by ms.OrderMonth