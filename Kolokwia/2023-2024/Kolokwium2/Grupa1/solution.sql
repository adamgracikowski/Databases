create database Tournament
go

-- prze³¹czenie siê na kontekst nowej bazy:
use Tournament
go

-- utworzenie tabeli w nowej bazie danych:
create table Participants (
    ParticipantID int primary key identity(1,1),
    Email varchar(200),
    BirthdayDate date,
    IsActive bit default 1,
    Name varchar(200),
    Surname varchar(200),
    OrganizationalFee money,
    JoinDate datetime,
    TotalAmountOfCompetitions int,
    TotalPoints decimal(10, 2),
    PointsPerCompetition decimal(10, 2)
)
go