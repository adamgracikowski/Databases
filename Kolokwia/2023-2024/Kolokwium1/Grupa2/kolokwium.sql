-- zadanie 01:

select 
	p.ProductName, 
	s.Country 
from Products p
join Suppliers s on p.SupplierID = s.SupplierID
where s.Country in ('USA', 'Spain')
order by s.Country, p.ProductName
go

-- zadanie 02:
select 
	p.ProductName,
	count(o.EmployeeID) as [EmployeeCount]
from Products p
join [Order Details] od on od.ProductID = p.ProductID
join Orders o on o.OrderID = od.OrderID
group by p.ProductName
having count(o.EmployeeID) >= 50
go

-- zadanie 03:

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
	) as TotalCountForYear,
	sum(ms.TotalOrders) over (
		order by ms.OrderMonth 
		rows between 2 preceding and current row
	) as [TotalCountForLastMonths]
from MonthlySummary1997 ms
order by ms.OrderMonth

use AdventureWorks2019
go

-- zadanie 04:

with WithoutStores as (
	select 
		sc.TerritoryID,
		count(sc.CustomerID) as CustomersWithoutStore
	from Sales.Customer sc
	where sc.StoreID is null
	group by sc.TerritoryID
)
select ws.* from WithoutStores ws
where ws.CustomersWithoutStore = (
	select max(ws.CustomersWithoutStore) 
	from WithoutStores ws
)
go

-- zadanie 05:

select 
	p.FirstName, 
	p.LastName 
from HumanResources.Employee e
join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
left join Sales.SalesOrderHeader soh on e.BusinessEntityID = soh.SalesPersonID
where soh.SalesPersonID is null
	and (p.FirstName like '[A-C]a%' or p.LastName like 'Al%')
order by p.LastName
go