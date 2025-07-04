# Kolokwium 3:

## Opis bazy danych `TheatreReservations`

> **UWAGA:** Dla uproszczenia przyjęto, że każdy bilet na dany spektakl kosztuje tyle samo i brak jest numeracji miejsc. Konieczne będzie przetestowanie dla 4 scenariuszy opisanych na końcu polecenia.

| Rezyserzy  |              |
| ---------- | ------------ |
| RezyserKod | integer (PK) |
| Imie       | varchar(50)  |
| Nazwisko   | varchar(100) |

| Sztuki         |                                       |
| -------------- | ------------------------------------- |
| SztukaKod      | integer (PK)                          |
| Tytul          | varchar(50)                           |
| RezyserKod     | integer (FK → `Rezyserzy.RezyserKod`) |
| Opis           | text (NULL)                           |
| DataPremieraOd | date                                  |
| DataPremieraDo | date (NULL)                           |

| Spektakle               |                                   |
| ----------------------- | --------------------------------- |
| SpektaklKod             | integer (PK)                      |
| SztukaKod               | integer (FK → `Sztuki.SztukaKod`) |
| DataIGodzinaSpektaklu   | datetime                          |
| LiczbaDostepnychBiletow | int (DEFAULT 100)                 |
| CenaBiletu              | money                             |

| Bilety        |                                                 |
| ------------- | ----------------------------------------------- |
| BiletKod      | integer (PK)                                    |
| SpektaklKod   | integer (FK → `Spektakle.SpektaklKod`)          |
| RezerwacjaKod | integer (FK → `Rezerwacje.RezerwacjaKod`, NULL) |

| Rezerwacje       |                        |
| ---------------- | ---------------------- |
| RezerwacjaKod    | integer (PK, IDENTITY) |
| DataRezerwacji   | date                   |
| CalkowitaWartosc | money                  |

## Zadanie 1

Przygotuj skrypt SQL `TEATR_NRALBUMU_task1.sql`, który:

1. **Utworzy** bazę `TEATR_NRALBUMU` (gdzie NRALBUMU to Twój nr albumu).
2. **Utworzy** wszystkie tabele: `Rezyserzy`, `Sztuki`, `Spektakle`, `Bilety`, `Rezerwacje` wraz z ich kluczami PK i FK.
3. **Zmieni** długość kolumny `Tytul` w tabeli `Sztuki` na `varchar(100)`.
4. **Wstawi** przykładowe dane:
   - 3 reżyserów,
   - 5 sztuk dla jednego wybranego reżysera (różne tytuły, różne okresy wystawiania),
   - 10 spektakli dla różnych sztuk (różne daty i godziny w przyszłości, różna liczba dostępnych biletów, różne ceny),
   - 4 bilety (dla dowolnych spektakli),
   - 2 rezerwacje.

## Zadanie 2

Napisz procedurę składowaną `RezerwujBilety` w bazie `TEATR_NRALBUMU`:

```sql
CREATE PROCEDURE RezerwujBilety
  @SpektaklKod   INT,
  @DataSpektaklu DATE,
  @LiczbaBiletow INT
AS
BEGIN
  -- użyj kursora do przeszukiwania spektakli
  -- krok 1: sprawdź dostępność biletów na wskazany spektakl i datę
  -- jeśli wystarczy:
  --   * utwórz nową rezerwację
  --   * wstaw @LiczbaBiletow wierszy do Bilety z RezerwacjaKod
  --   * zmniejsz LiczbaDostepnychBiletow w Spektakle
  --   * oblicz i zaktualizuj CalkowitaWartosc w Rezerwacje
  --   * PRINT szczegóły rezerwacji
  -- jeśli nie:
  --   krok 2: znajdź najbliższy przyszły spektakl tej samej sztuki z wolnymi biletami
  --     jeśli znaleziono → PRINT info (tytuł, data, wolne miejsca, cena)
  --   krok 3: jeśli dalej brak → znajdź najbliższy przyszły spektakl tej samej sztuki reżysera
  --     jeśli znaleziono → PRINT info (tytuł, reżyser, data, wolne miejsca, cena)
  --   w przeciwnym razie → PRINT 'Brak dostępnych spektakli spełniających kryteria'
END;
```

- **Zastosuj** transakcje i obsługę błędów.
- **Wykorzystaj** `PRINT('…')` do statusów.
- **Przetestuj** i **zapisz** scenariusze w pliku `Nazwisko_Imie.txt`:
  1. rezerwacja możliwa od razu,
  2. możliwa za 2 dni na tę samą sztukę,
  3. możliwa za 3 dni na sztukę tego samego reżysera,
  4. brak możliwości rezerwacji.

## Zadanie 3

Przygotuj skrypt `TEATR_NRALBUMU_task3.sql` z indeksami:

1. **Częste łączenie** tabel `Sztuki` i `Spektakle`.
2. **Unikalność** kombinacji `Imie` + `Nazwisko` w tabeli `Rezyserzy`.
3. **Szybkie wyszukiwanie** spektakli po `DataIGodzinaSpektaklu`.
4. **Indeks pomocniczy** na kolumnie `SpektaklKod` w tabeli `Bilety`.
5. **Szybkie filtrowanie** rezerwacji po `DataRezerwacji` i `CalkowitaWartosc`.

> **Wymagania techniczne:**
>
> - Użyj transakcji w miejscach krytycznych.
> - Zapewnij atomowość i obsługę błędów.
> - Oddziel komentarzami kolejne części skryptu.
> - Całość zapisz w `Nazwisko_Imie.sql`, wyniki testów w `Nazwisko_Imie.txt`.
