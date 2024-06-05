use BicycleRental
go

create procedure ReturnBicycle
    @user_id int,
    @rent_id int,
    @station_id int
as
begin
    -- Deklaracja zmiennych:
    declare @current_datetime datetime = getdate();
    declare @total_cost money;
    declare @available_racks int;
    declare @is_manual_return bit = 0;

    -- Pocz�tek transakcji:
    begin try
        begin transaction;

        -- Sprawdzenie liczby dost�pnych stojak�w na stacji:
        select @available_racks = AvailableRacks
        from Stations
        where StationID = @station_id;

        if @available_racks > 0
        begin
            -- Zmniejszenie liczby dost�pnych stojak�w:
            update Stations
            set AvailableRacks = AvailableRacks - 1
            where StationID = @station_id;
        end
        else
        begin
            -- Brak dost�pnych stojak�w, ustawienie flagi r�cznego zwrotu:
            set @is_manual_return = 1;
        end

        -- Obliczenie kosztu przejazdu (zak�adamy stawk� 5.00 na godzin�)
        select @total_cost = datediff(hour, RentedAt, @current_datetime) * 5.00
        from BicycleRents
        where RentID = @rent_id;

        -- Aktualizacja danych w tabeli BicycleRents:
        update BicycleRents
        set ReturnedAt = @current_datetime,
            ReturnStation = @station_id,
            TotalCost = @total_cost,
            IsFinished = 1,
			IsReturnedManually = @is_manual_return
        where RentID = @rent_id;

        -- Aktualizacja salda u�ytkownika:
        update Users
        set CurrentBalance = CurrentBalance - @total_cost
        where UserID = @user_id;

        -- Zatwierdzenie transakcji:
        commit transaction;
    end try
    begin catch
        -- Wycofanie transakcji w przypadku b��du:
        rollback transaction;

        -- Wy�wietlenie informacji o b��dzie:
        declare @error_message nvarchar(4000), @error_severity int, @error_state int;
        select @error_message = error_message(), @error_severity = error_severity(), @error_state = error_state();
        raiserror (@error_message, @error_severity, @error_state);
    end catch
end
go