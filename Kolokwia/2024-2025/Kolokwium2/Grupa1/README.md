# Kolokwium 2:

### Zadanie 1: Projekt bazy danych SQL

Na podstawie poniższego opisu wykonaj polecenia SQL tworzące odpowiednie tabele w bazie danych:

- Każdy klient ma unikalny identyfikator (`Id_klienta`) oraz nazwę (`Nazwa_klienta`).
- Każda faktura posiada numer (`Id_faktury`), kwotę netto (`Kwota_netto`), datę wystawienia (`Data_wystawienia`) oraz jest przypisana do jednego klienta (`Id_klienta`).

### Zadanie 2: Tworzenie transakcji

Na podstawie tabel `Klient` i `Faktura` z pierwszego zadania, napisz instrukcje SQL lub kod Java (z użyciem JDBC), które wykonują poniższe operacje.
Upewnij się, że każda operacja odbywa się w ramach transakcji (czyli z użyciem `BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK` lub ich odpowiedników w JDBC).

1. Napisz kod (SQL lub Java z JDBC), który:
   - Dodaje określoną liczbę klientów (np. 2) do tabeli Klient, z nazwami podanymi przez użytkownika.
   - Dla każdego klienta wstawia 1 lub więcej faktur z kwotą netto i datą wystawienia.
   - Wszystkie wstawienia wykonuje w ramach jednej transakcji.
2. Napisz transakcję SQL lub kod Java, który:
   - Pyta użytkownika o datę w formacie `yyyy-MM-dd`.
   - Usuwa z tabeli Faktura wszystkie faktury wystawione po tej dacie.
   - Wycofuje zmiany w razie błędu.
3. Napisz zapytania SQL lub kod Java, który:
   - Wyświetlają wszystkie rekordy z tabel `Klient` i `Faktura`.
   - W przypadku faktur pokaż również nazwę klienta (wykorzystaj `JOIN`).
