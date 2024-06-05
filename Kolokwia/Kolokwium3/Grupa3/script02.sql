--Task 1, Part 2 & 3:

use HotelApplication
go

--Dodanie nowej kolumny do HotelRooms:
alter table HotelRooms
add IsReserved bit not null default 0
go

--Modyfikacja kolumny w tabeli Hotels:
alter table Hotels
alter column HotelName varchar(100) not null
go

--Wstawienie wartosci do tabeli Hotels:
insert into Hotels (HotelCode, HotelName, City, Description)
values
(1, 'Sunrise', 'New York', 'A beautiful hotel in the heart of the city'),
(2, 'Seaside', 'Los Angeles', 'A relaxing hotel near the beach');
go

--Wstawienie wartosci do tabeli HotelRooms:
insert into HotelRooms (RoomCode, HotelCode, NumberOfGuests, CostOfANight)
values
(101, 1, 2, 150.00),
(102, 1, 4, 200.00),
(201, 2, 2, 180.00),
(202, 2, 3, 220.00);
go

--Wstawienie wartosci do tabeli Reservations:
insert into Reservations (RoomCode, DateFrom, DateTo, TotalCost)
values
(101, '2024-06-01', '2024-06-05', 600.00),
(102, '2024-07-01', '2024-07-03', 400.00),
(201, '2024-08-10', '2024-08-15', 900.00),
(202, '2024-09-20', '2024-09-25', 1100.00);
go

--Wyswietlenie wstawionych wartosci:
select * from Hotels
go

select * from HotelRooms
go

select * from Reservations
go