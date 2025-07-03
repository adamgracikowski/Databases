--Task 2:

use HotelApplication
go

create procedure automatic_reservation (
	@hotel_name varchar(10),
	@number_of_guests int,
	@date_from date,
	@date_to date
) as 
begin
	--Deklaracja zmiennych:
	declare @hotel_code int,
			@room_code int,
			@total_cost money,
			@night_cost money,
			@hotel_city varchar(100);

	--Ustawienie zmiennych zwi¹zanych z hotelem:
	select @hotel_code = h.HotelCode, @hotel_city = h.City 
	from Hotels h 
	where h.HotelName = @hotel_name;

	if @hotel_code is null
	begin
		raiserror('Hotel not found', 16, 1);
		return;
	end

	begin transaction

	--Szukanie wolnego pokoju w hotelu:
	select top 1 @room_code = hr.RoomCode, @night_cost = hr.CostOfANight
	from HotelRooms hr
	where hr.HotelCode = @hotel_code
	    and hr.IsReserved = 0
		and hr.NumberOfGuests >= @number_of_guests
		and not exists (
			select * from Reservations r
			where r.RoomCode = hr.RoomCode
			and r.DateFrom <= @date_to
			and r.DateTo >= @date_from
		);

	if @room_code is not null
	begin
		--Obliczenie kosztu rezerwacji:
		set @total_cost = datediff(day, @date_from, @date_to) * @night_cost;

		--Wstawienie nowej rezerwacji do tabeli:
		insert into Reservations(RoomCode, DateFrom, DateTo, TotalCost)
		values (@room_code, @date_from, @date_to, @total_cost);

		--Uaktualnienie statusu pokoju hotelowego:
		update HotelRooms
		set IsReserved = 1
		where RoomCode = @room_code;

		--Wyœwietlenie utworzonej rezerwacji:
		select * from Reservations 
		where ReservationCode = SCOPE_IDENTITY();

		--Zatwierdzenie transakcji:
		commit transaction;
	end
	else begin
		rollback transaction;

		-- Wyœwietlenie dostêpnych pokoi w mieœcie:
		select h.HotelName, hr.RoomCode, hr.CostOfANight 
		from HotelRooms hr
		join Hotels h on h.HotelCode = hr.HotelCode
		where h.City = @hotel_city
			and h.HotelCode != @hotel_code
			and hr.IsReserved = 0
			and hr.NumberOfGuests >= @number_of_guests
			and not exists (
				select * from Reservations r
				where r.RoomCode = hr.RoomCode
				and r.DateFrom <= @date_to
				and r.DateTo >= @date_from
		    )
		order by h.HotelName, hr.CostOfANight asc;
	end
end;

--Przyk³adowe wywo³anie:
exec automatic_reservation 
    @hotel_name = 'Sunrise',
    @number_of_guests = 2,
    @date_from = '2024-06-15',
    @date_to = '2024-06-20';

drop procedure automatic_reservation