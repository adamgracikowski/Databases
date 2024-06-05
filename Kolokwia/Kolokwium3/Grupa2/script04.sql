use BicycleRental
go

-- Indeks wspomagaj¹cy czêste ³¹czenie tabel Users i BicycleRents
create index idx_UserID_BicycleRents on BicycleRents (UserID);
go

-- Indeks zapewniaj¹cy unikalnoœæ kolumny Email w tabeli Users
create unique index idx_unique_Email on Users (Email);
go

-- Indeks wspomagaj¹cy filtracjê w tabeli BicycleRents wed³ug RentStation i ReturnedAt
create index idx_RentStation_ReturnedAt on BicycleRents (RentStation, ReturnedAt);
go

-- Z³o¿ony indeks w tabeli Stations (je¿eli nie istnieje)
if not exists (
    select * from sys.indexes 
    where name = 'idx_City_RacksAmount' and object_id = object_id('Stations')
)
begin
    create index idx_City_RacksAmount on Stations (City, RacksAmount);
end
go

-- Indeks wspomagaj¹cy filtracjê u¿ytkowników wed³ug imienia i nazwiska
create index idx_FirstName_LastName on Users (FirstName, LastName);
go
