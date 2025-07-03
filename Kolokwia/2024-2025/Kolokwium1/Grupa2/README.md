# Kolokwium 1:

### Zadanie 01: Tworzenie diagramu

> Celem zadania jest przygotowanie projektu tabel.
>
> Dla opisanego poniżej problemu projekt powinien definiować:
>
> 1. Tabele,
> 2. Kolumny:
>    - Typy danych,
>    - Długość,
>    - Wymagalność.
> 3. Klucze główne,
> 4. Klucze obce.
>
> Dla każdego klucza obcego na diagramie należy zdefiniować tabele i kolumny/kolumny w tej tabeli, do której klucz obcy się odnosi.
>
> Należy przygotować diagram ER z określeniem dla poszczególnych relacji: a. krotności b. znaczenia (etykiety).
>
> W przypadku potrzeby doprecyzowania założeń, proszę podać w odpowiedzi przyjęte dodatkowe założenia.

Opis systemu:

1. Każdy pracownik należy do jednego działu firmy.
2. Pracownik może być odpowiedzialny za wiele produktów, ale jeden produkt ma tylko jednego odpowiedzialnego pracownika.
3. Pracownik może tworzyć wiele ofert. Każda oferta dotyczy jednego klienta i jednego produktu.
4. Oferta może być spersonalizowana i mieć zatwierdzony koszt.
5. Pracownik może być przypisany do wielu produktów w relacji pomocniczej (np. produkcja), nie tylko jako odpowiedzialny.
6. Dla każdego klienta zapisujemy nazwę, miasto i kraj.
7. Dla każdego produktu zapisujemy nazwę i opis.
8. Dla pracownika zapisujemy imię, nazwisko, telefon, dział, czy jest kierownikiem i czy obsługuje kalendarz klienta.

### Zadanie 02: Zapytania SQL na bazie `Northwind`

1. Wypisz klientów, którzy kupili więcej różnych produktów w III kwartale roku 1996 niż w III kwartale roku 1997.
2. Wypisz w porządku alfabetycznym nazwiska pracowników, którzy nadzorowali przynajmniej 2 zamówienia wysłane do Niemiec i kiedykolwiek nadzorowali zamówienie zawierające produkt którego nazwa rozpoczyna się na `si` lub `lu`.
3. Wypisz nazwę kraju i liczbę zamówień złożonych przez klientów z każdego kraju, posortowaną według rosnącej liczby zamówień dla wszystkich klientów.
4. Łączna liczba zamówień złożonych w kolejnych miesiącach roku 1997, wyliczona narastająco od początku roku oraz w okresie poprzedzających 2 miesięcy.

- Wynik: `Month`, `TotalCountforYear`, `TotalCountForLastMonths`.
- Do realizacji zapytania można wykorzystać widok (ang. _view_).
