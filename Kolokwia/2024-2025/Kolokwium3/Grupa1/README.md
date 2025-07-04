# Kolokwium 3:

## Opis bazy danych `CarReservations`

| rezerwacje             |                                          |
| ---------------------- | ---------------------------------------- |
| id_rezerwacji          | int (PK, IDENTITY)                       |
| imie_klienta           | varchar(20)                              |
| nazwisko_klienta       | varchar(10) (NOT NULL)                   |
| data_rezerwacji        | datetime                                 |
| samochód_1             | int (FK → `samochody.id_samochodu`)      |
| samochód_2             | int (FK → `samochody.id_samochodu`)      |
| samochód_3             | int (FK → `samochody.id_samochodu`)      |
| zarezerwowany_samochód | int NULL (FK → `samochody.id_samochodu`) |
| miasto                 | varchar(100)                             |

| samochody    |                               |
| ------------ | ----------------------------- |
| id_samochodu | int (PK)                      |
| id_salonu    | int (FK → `salony.id_salonu`) |
| model        | varchar(10) (NOT NULL)        |
| liczba_sztuk | int                           |

| salony    |              |
| --------- | ------------ |
| id_salonu | int (PK)     |
| miasto    | varchar(100) |

---

## Zadanie 1

Przygotuj skrypt SQL, który:

1. Utworzy tabele `rezerwacje`, `samochody` i `salony` wraz z kluczami głównymi i obcymi zgodnie z powyższym modelem.
2. Doda do tabeli `samochody` kolumnę `liczba_sprzedanych` int.
3. Zmieni typ kolumny `nazwisko_klienta` w tabeli `rezerwacje` na `varchar(20)`.
4. Wstawi co najmniej:
   - 2 wiersze do `salony`,
   - 4 wiersze do `samochody`,
   - 4 wiersze do `rezerwacje`.

## Zadanie 2

Przygotuj procedurę składowaną `AssignReservations` z dwoma parametrami:

- `@SalonID` int
- `@ReservationCursor` CURSOR (opcjonalnie – do iteracji nad `rezerwacje`)

Procedura powinna w jednej transakcji, w kolejności rosnących `data_rezerwacji`, dla wszystkich rekordów w `rezerwacje` ze `zarezerwowany_samochód IS NULL` i `id_salonu = @SalonID`:

- Próbować przypisać rezerwację do auta z kolumny `samochód_1`.
- Jeśli `liczba_sprzedanych = liczba_sztuk` dla `samochód_1`, spróbować `samochód_2`.
- Jeśli nadal brak wolnych, spróbować `samochód_3`.
- Jeśli żadna próba nie powiedzie się, wypisać listę dostępnych samochodów i miast (po jednej sztuce w każdej linii).

Zapewnij poprawne otwarcie i zamknięcie kursora oraz obsługę błędów/transakcji.

## Zadanie 3

Napisz skrypty `script03.sql` definiujące indeksy:

1. **Częste łączenie** tabel `rezerwacje` i `samochody`.
2. **Unikalność** kombinacji `nazwisko_klienta` + `data_rezerwacji`.
3. **Filtrowanie** rezerwacji wg `data_rezerwacji`.
4. **Złożony klucz główny** w tabeli `samochody` (zakładając jego brak).
5. **Filtrowanie** rezerwacji wg `samochód_1`, `samochód_2` i `samochód_3` łącznie.
