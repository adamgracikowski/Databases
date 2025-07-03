use BicycleRental
go

-- Indeks wspomagaj�cy cz�ste ��czenie tabel Users i BicycleRents
create index idx_UserID_BicycleRents on BicycleRents (UserID);
go

-- Indeks zapewniaj�cy unikalno�� kolumny Email w tabeli Users
create unique index idx_unique_Email on Users (Email);
go

-- Indeks wspomagaj�cy filtracj� w tabeli BicycleRents wed�ug RentStation i ReturnedAt
create index idx_RentStation_ReturnedAt on BicycleRents (RentStation, ReturnedAt);
go

-- Z�o�ony indeks w tabeli Stations (je�eli nie istnieje)
if not exists (
    select * from sys.indexes 
    where name = 'idx_City_RacksAmount' and object_id = object_id('Stations')
)
begin
    create index idx_City_RacksAmount on Stations (City, RacksAmount);
end
go

-- Indeks wspomagaj�cy filtracj� u�ytkownik�w wed�ug imienia i nazwiska
create index idx_FirstName_LastName on Users (FirstName, LastName);
go
