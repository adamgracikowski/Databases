# Kolokwium 3:

## Opis bazy danych HotelApplication:

| Hotels | |
| ------ | ------ |
| HotelCode | integer (primary key) |
| HotelName | varchar(10) (not null) |
| City | varchar(100) (not null) |
| Description | text |

| HotelRooms | |
| ------ | ------ |
| RoomCode | integer (primary keyd) |
| HotelCode | integer (reference to Hotels) |
| NumberOfGuests | integer |
| CostOfANight | money |

| Reservations | |
| ------ | ------ |
| ReservationID | integer (primary key, automatically incremented) |
| RoomCode | integer (reference to HotelRooms) |
| DateFrom | date |
| DateTo | date |
| TotalCost | money (can be left empty) |

## Zadanie 1:
- Przygotować skrypt `script01.sql`, w którym tworzona jest baza danych HotelApplication, tabele oraz relacje między nimi (zgodnie z podanym modelem danych).
- Przygotować skrypt `script02.sql`, w którym zostaną wykonane następujące modyfikacje modelu danych:
    - Dodana zostaje kolumna IsReserved (bit) z wartością domyślną 0.
    - Rozszerzona zostaje kolumna HotelName do 100 znaków.
    - Wstawione zostają co najmniej po 2 rekordy do każdej tabeli w utworzonej bazie.

## Zadanie 2:
- Przygotować skrypt `script03.sql`, w którym dodawane są indeksy dla następujących wymagań:
    - Częste łączenie tabel Hotels i HotelRooms.
    - Unikalność HotelName.
    - Filtracja pokoi według liczby gości.
    - Klucz główny w tabeli Reservations (jeżeli nie istnieje).
    - Filtracja rezerwacji według daty rozpoczęcia i zakończenia pobytu.

## Zadanie 3:
Przygotować procedurę składowaną w pliku `procedure.sql` do automatycznej rezerwacji pokoju hotelowego.
Procedura przyjmuje parametry `hotel_name` oraz `number_of_guests`, `date_from` oraz `date_to`.
- Jeżeli dostępny jest co najmniej jeden wolny pokój we wskazanym terminie, procedura tworzy wpis do tabeli rezerwacji, obliczając całkowity koszt. Dodatkowo, uaktualnia status pokoju na zajęty oraz wyświetla wstawiony i zmodyfikowany wiersz tabeli.
- Jeżeli w wybranym hotelu brak dostępnych pokoi, procedura wyświetla wszystkie pokoje w hotelach położonych w tym samym mieście, które są dostępne w podanym terminie w formacie (HotelName, RoomCode, CostOfANight).
