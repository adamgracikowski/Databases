use northwind
go

create procedure apply_discount
	@customer_id nchar(5)
as
begin
	declare @product_id int,
			@order_id int,
			@order_date datetime,
			@previous_orders_count int,
			@discount decimal(5,2)

	declare order_cursor cursor for
	select od.OrderID, od.ProductID, o.OrderDate
	from [Order Details] od
	join Orders o on o.OrderID = od.OrderID
	where o.CustomerID = @customer_id

	open order_cursor
	fetch next from order_cursor into @order_id, @product_id, @order_date
	while @@FETCH_STATUS = 0
	begin
		-- zliczenie poprzednich zamówieñ:
		select @previous_orders_count = count(*)
		from [Order Details] od
		join Orders o on o.OrderID = od.OrderID
		where od.ProductID = @product_id
			  and o.CustomerID = @customer_id
			  and o.OrderDate < @order_date

		-- wyznaczenie rabatu:
		if @previous_orders_count = 0
			set @discount = 0
		else if @previous_orders_count between 1 and 2
			set @discount = 0.05
		else if @previous_orders_count = 3
			set @discount = 0.1
		else if @previous_orders_count > 3
			set @discount = 0.2
		
		-- ustawienie rabatu dla odpowiedniego zamówienia:
		update [Order Details]
		set Discount = @discount
		where OrderID = @order_id
			and ProductID = @product_id

		fetch next from order_cursor into @order_id, @product_id, @order_date
	end

	close order_cursor
	deallocate order_cursor
end
go

declare @customer_id nchar(5) = 'ALFKI'

-- przyk³ad wykonania:
exec apply_discount @customer_id

-- sprawdzenie poprawnoœci:
select od.OrderID, od.ProductID, od.Discount, o.CustomerID, o.OrderDate from [Order Details] od
join Orders o on od.OrderID = o.OrderID
where CustomerID = @customer_id

-- usuniêcie procedury:
drop procedure apply_discount