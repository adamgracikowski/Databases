--Task 1, Part 1:

create database HotelApplication
go

use HotelApplication
go

create table Hotels (
	HotelCode int primary key,
	HotelName varchar(10) not null,
	City varchar(100) not null,
	Description text
)
go

create table HotelRooms (
	RoomCode int primary key,
	HotelCode int not null foreign key references Hotels(HotelCode),
	NumberOfGuests int not null,
	CostOfANight money not null
)
go

create table Reservations (
	ReservationCode int primary key identity(1,1),
	RoomCode int not null foreign key references HotelRooms(RoomCode),
	DateFrom date not null,
	DateTo date not null,
	TotalCost money 
)
go