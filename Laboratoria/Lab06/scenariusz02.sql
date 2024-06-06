 -- scenariusz 02:

alter table Orders
add IsCancelled int default 0

begin transaction

update Orders
set IsCancelled = 1
where CustomerID = 'ALFKI'
	
update od
set od.Quantity = 0
from [Order Details] od
join Orders o on od.OrderID = o.OrderID
where o.CustomerID = 'ALFKI'

-- Sprawdzenie czy wszystkie zam�wienia klienta ALFKI zosta�y zaktualizowane:

declare @CancelledOrdersCount int;
select @CancelledOrdersCount = count(*)
from Orders
where CustomerID = 'ALFKI' 
	and IsCancelled = 1;

if @CancelledOrdersCount = (
	select count(*)
    from [Order Details] od
    join Orders o on od.OrderID = o.OrderID
    where o.CustomerID = 'ALFKI' 
		and od.Quantity = 0
)
begin
    commit;
    print 'Zam�wienia klienta ALFKI zosta�y anulowane.';
end
else
begin
    rollback;
    print 'Wyst�pi� b��d. Transakcja zosta�a cofni�ta.';
end