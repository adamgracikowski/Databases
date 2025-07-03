--Task 1, Part 2:
use BicycleRental
go

alter table Users
add PhoneNumber varchar(25)
go

alter table Users
drop column Age
go

alter table Users
add BirthDate datetime check (datediff(year, BirthDate, getdate()) >= 18)