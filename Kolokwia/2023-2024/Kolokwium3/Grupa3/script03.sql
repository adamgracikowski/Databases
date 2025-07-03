--Task 3:

use HotelApplication
go

create index IDX_HotelRooms_HotelCode
on HotelRooms (HotelCode);

create unique index IDX_Hotels_HotelName
on Hotels (HotelName);

create index IDX_HotelRooms_NumberOfGuests
on HotelRooms (NumberOfGuests);

declare @constraint_name nvarchar(200);
select @constraint_name = name
from sys.key_constraints
where type = 'PK' and parent_object_id = OBJECT_ID('Reservations');

if @constraint_name is not null
begin
    exec('alter table Reservations drop constraint ' + @constraint_name);
end

alter table Reservations
add constraint PK_Reservations primary key clustered (ReservationCode);

create index IDX_Reservations_DateFrom_DateTo
on Reservations (DateFrom, DateTo);