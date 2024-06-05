--Task 1, Part 3:
use BicycleRental
go

insert into Bicycles (BicycleType, Origin) 
values 
('Mountain Bike', 'BikeCo'),
('City Bike', 'UrbanCycles'),
('Electric Bike', 'EcoWheels');
go

insert into Stations (City, Address, RacksAmount, AvailableRacks) 
values 
('Warsaw', 'Main Street 1', 10, 8),
('Krakow', 'Central Square 5', 15, 10),
('Gdansk', 'Seaside Boulevard 12', 20, 18);
go

insert into Users (Email, FirstName, LastName, IsActive, CurrentBalance, PhoneNumber, BirthDate) 
values 
('anna@example.com', 'Anna', 'Kowalska', 1, 50.00, '123-456-789', '1990-05-15'),
('jan@example.com', 'Jan', 'Nowak', 1, 30.00, '987-654-321', '1985-07-22'),
('ewa@example.com', 'Ewa', 'Zielinska', 0, 0.00, '555-123-456', '2000-03-10');
go

insert into BicycleRents (UserID, BicycleID, RentedAt, ReturnedAt, RentStation, ReturnStation, TotalCost, IsFinished) 
values 
(1, 1, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 1, 1, 20.00, 1),
(2, 2, '2024-06-02 09:00:00', '2024-06-02 11:00:00', 2, 2, 10.00, 1),
(3, 3, '2024-06-03 08:00:00', null, 3, null, 0.00, 0);
go

--Wyswietlenie wstawionych wartosci:

select * from Bicycles
go

select * from Stations
go

select * from Users
go

select * from BicycleRents
go