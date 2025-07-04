# Kolokwium 2:

### Zadanie 1:

Utwórz bazę `Tournament`, a w niej tabelę `Participants` według podanego poniżej opisu schematu. Rozwiązanie umieść w skrypcie `solution.sql`.

| Praticipants              |                                                  |
| ------------------------- | ------------------------------------------------ |
| ParticipantID             | integer (primary key, automatically incremented) |
| Email                     | string                                           |
| BirthdayDate              | date                                             |
| IsActive                  | boolean                                          |
| Name                      | string                                           |
| Surname                   | string                                           |
| OrganizationalFee         | money                                            |
| JoinDate                  | datetime                                         |
| TotalAmountOfCompetitions | integer                                          |
| TotalPoints               | decimal                                          |
| PointsPerCompetition      | decimal                                          |

### Zadanie 2:

Przygotuj projekt z aplikacją konsolową, która będzie zawierać niezbędne klasy, żeby połączyć się z bazą danych. W zaimplementowanych klasach umieść następującą logikę:

- W pierwszej transakcji należy usunąć wszysktkich nieaktywnych uczestników z najstarszą datą dołączenia do systemu.
- W drugiej transakcji należy utworzyć trzech nowych użytkowników z losowymi wartościami atrybutów. `PointsPerCompetition = TotalPoints / TotalAmountOfCompetitions`.
- W trzeciej transakcji należy:
  - Zmodyfikować wszystkie wiersze dodając wartość `5.5` do `TotalPoints`.
  - Dodać nowego użytkownika z `TotalAmountOfCompetitions = 1` oraz `TotalPoints = 100.1`.
- W czwartej transakcji należy:
  - Dodać w pętli czterech nowych użytkowników z losowymi wartościami atrybutów.
  - Zamienić `JoinDate` dla nieaktywnych użytkowników z najpóźniejszą i najwcześniejszą `JoinDate`.
  - Po każdej transakcji zawartość całej tabeli powinna zostać pobrana z bazy danych i wyświetlona w oknie konsoli (linia po linii).
