-- zadanie 01:

select 
	case
		when s.Country in ('USA', 'Canada') then 'North America'
		when s.Country in ('Japan', 'Singapore') then 'Asia'
		else 'Other'
	end as SupplierContinent,
	count(p.ProductID) as ProductCount
from Suppliers s
join Products p on p.SupplierID = s.SupplierID
group by 
	case
		when s.Country in ('USA', 'Canada') then 'North America'
		when s.Country in ('Japan', 'Singapore') then 'Asia'
		else 'Other'
	end
go

-- zadanie 02:

select distinct
    c.*
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate not between '1997-01-01' and '1997-06-01'
	and c.Address like '%rue%'
	and (left(c.ContactName, 1) between 'A' and 'F'
	or substring(c.ContactName, 3, 1) = 'n')
go

-- zadanie 03:

with MonthlySummary1998 as (
	select 
		month(o.OrderDate) as OrderMonth,
		sum(od.Quantity * od.UnitPrice) as TotalPayment
	from Orders o
	join [Order Details] od on od.OrderID = o.OrderID
	where year(o.OrderDate) = 1998
	group by month(o.OrderDate)
)
select 
	ms.OrderMonth,
	ms.TotalPayment as TotalPaymentForMonth,
	sum(ms.TotalPayment) over (
		order by ms.OrderMonth 
		rows between unbounded preceding and current row
	) as TotalPaymentsForYear,
	sum(ms.TotalPayment) over (
		order by ms.OrderMonth 
		rows between 3 preceding and 1 preceding
	) as TotalPaymentsForLastThreeMonths
from MonthlySummary1998 ms
order by ms.OrderMonth
go

-- zadanie 04:

use AdventureWorks2019
go

with WithoutStores as (
	select 
		sc.TerritoryID,
		count(*) as CustomersWithoutStore
	from Sales.Customer sc
	where sc.StoreID is null
	group by sc.TerritoryID
)
select ws.* from WithoutStores ws
where ws.CustomersWithoutStore = (
	select max(ws.CustomersWithoutStore) from WithoutStores ws)
go

-- zadanie 05:

use AdventureWorks2019
go

select
    p.ProductSubcategoryID,
    psc.Name as CategoryName,
    sum(sod.LineTotal) as TotalAmount
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
join Production.Product p on sod.ProductID = p.ProductID
join Production.ProductSubcategory psc on p.ProductSubcategoryID = psc.ProductSubcategoryID
where year(soh.OrderDate) in (2011, 2012)
group by
    p.ProductSubcategoryID,
    psc.Name
order by
    TotalAmount desc
go