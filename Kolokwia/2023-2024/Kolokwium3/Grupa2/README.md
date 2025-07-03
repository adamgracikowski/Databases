# Kolokwium 3:

## Opis bazy danych BicycleRental:

| Bicycles | |
| ------ | ------ |
| BicycleID | integer (primary key, automatically incremented) |
| BicycleType | varchar(100) (default value "Adventure Road Bike" |
| Origin | varchar(80) (default value "NextBike") |

| BicycleRents | |
| ------ | ------ |
| RentID | integer (primary key, automatically incremented) |
| UserID | integer (reference to Users) |
| BicycleID | integer (reference to Bicycles) |
| RentedAt | datetime |
| ReturnedAt | datetime |
| RentStation | integer (reference to Stations) |
| ReturnStation | integer (reference to Stations) |
| TotalCost | money |
| IsFinished | boolean (default value false) |
| IsReturnedManually | boolean (default value false) |

| Stations | |
| ------ | ------ |
| StationID | integer (primary key, automatically incremented) |
| City | varchar(100) |
| Address | text |
| RacksAmount | integer |
| AvailableRacks | integer |

| Users | |
| ------ | ------ |
| UserID | integer (primary key, automatically incremented) |
| Email | nvarchar(255) |
| FirstName | nvarchar(200) |
| LastName | nvarchar(200) |
| IsActive | boolean |
| Age | integer |
| CurrentBalance | money |

## Zadanie 1:
- Przygotować skrypt `script01.sql`, w którym tworzona jest baza danych EduCourses, tabele oraz relacje między nimi (zgodnie z podanym modelem danych).
- Przygotować skrypt `script02.sql`, w którym zostaną wykonane następujące modyfikacje modelu danych:
    - Dodana zostaje kolumna PhoneNumber (varchar(25)) do tabeli Users.
    - Usunięta zostaje kolumna Age.
    - Dodane zostaje kolumna BirthDate (datetime) oraz jednocześnie sprawdzenie wieku użytkowników (każdy użytkownik musi mieć co najmniej 18 lat).
- Przygotować skrypt `script03.sql`, w którym zostaną wstawione przynajmniej po 3 rekordy do każdej tabeli w utworzonej bazie.


## Zadanie 2:
- Przygotować skrypt `script04.sql`, w którym dodawane są indeksy dla następujących wymagań:
    - Częste łączenie tabel Users i BicycleRents.
    - Unikalność Email.
    - Filtracja BicycleRents według RentStation i ReturnedAt.
    - Złożony indeks w tabeli Stations (jeżeli nie istnieje).
    - Filtracja użytkowników według imienia i nazwiska.


## Zadanie 3:
Przygotować procedurę składowaną w pliku `procedure.sql` do zwrotu roweru wypożyczonego przez użytkownika.
Procedura przyjmuje parametry `user_id` oraz `rent_id` oraz `station_id`.
- Jeżeli stacja ma dostępny stojak, to zwraca rower, dopisując w tabeli BicycleRents kiedy rower został zwrócony, stację zwrotu, sumaryczny koszt przejazdu oraz fakt, że przejazd się zakończył. Zmniejszona musi zostać liczba dostępnych stojaków oraz bieżące saldo konta użytkownika.
- Jeżeli stacja nie ma dostępnych stojaków, to procedura zwraca rower, w analogiczny sposób, jednak ustawia flagę ręcznego zwrotu roweru. Liczba dostępnych stojaków nie zmienia się, bieżące saldo użytkownika zmniejsza się o koszt przejazdu.