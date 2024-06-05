--Task 1, Part 1:
create database BicycleRental
go

use BicycleRental
go

create table Bicycles (
	BicycleID int primary key identity(1,1),
	BicycleType varchar(100) default 'Adventure Road Bike',
	Origin varchar(80) default 'NextBike'
)
go

create table Stations (
	StationID int primary key identity(1,1),
	City varchar(100),
	Address text,
	RacksAmount int,
	AvailableRacks int
) 
go

create table Users (
	UserID int primary key identity(1,1),
	Email varchar(255),
	FirstName varchar(200),
	LastName varchar(200),
	IsActive bit,
	Age int,
	CurrentBalance money
)
go

create table BicycleRents (
	RentID int primary key identity(1,1),
	UserID int foreign key references Users(UserID),
	BicycleID int foreign key references Bicycles(BicycleID),
	RentedAt datetime,
	ReturnedAt datetime,
	RentStation int foreign key references Stations(StationID),
	ReturnStation int foreign key references Stations(StationID),
	TotalCost money,
	IsFinished bit default 0,
) 
go