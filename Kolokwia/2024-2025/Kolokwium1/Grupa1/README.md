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

Tworzymy projekt bazy danych do agencji zajmującej się aktorami. Agencja współpracuje z różnymi aktorami i potrzebuje systemu do śledzenia, w jakich spektaklach występują jej podopieczni oraz jakie są podstawowe informacje o tych spektaklach. System powinien umożliwiać przechowywanie i zarządzanie następującymi danymi:

1. Dla każdego spektaklu, który jest w zainteresowaniu agencji, potrzebujemy znać jego tytuł oraz krótki opis oraz okres jego wystawiania, a także teatr, w którym jest wystawiany. Każdy spektakl powinien być jednoznacznie identyfikowany w systemie.
2. Agencja musi posiadać rejestr aktorów, z którymi współpracuje. Dla każdego aktora wystarczy zapisać jego imię i nazwisko, PESEL, stan cywilny (opcjonalnie). Każdy aktor również musi być jednoznacznie identyfikowany.
3. Kluczowa informacja dla agencji jest powiązanie aktorów ze spektaklami. Należy zaprojektować sposób zapisu informacji o tym, którzy aktorzy grają w których spektaklach. Trzeba uwzględnić fakt, że jeden aktor może występować w wielu różnych spektaklach, a w jednym spektaklu zazwyczaj gra wielu aktorów.
4. Każdy spektakl powinien być sklasyfikowany według gatunku. Istnieje z góry ustalony, ograniczony zestaw gatunków (np. Dramat, Komedia, Musical, Eksperymentalny), którymi posługuje się agencja. System musi zapewnić, że każdy spektakl jest przypisany do dokładnie jednego z tych predefiniowanych gatunków i umożliwiać zarządzanie tą listą gatunków

### Zadanie 02: Zapytania SQL na bazie `Northwind`

1. Lista krajów, z których pochodzą dostawcy wraz z liczbą dostawców z danego kraju.
   - Lista powinna być posortowana od kraju o największej liczbie dostawców do najmniejszej.
   - W przypadku krajów o takiej samej liczbie dostawców, lista powinna być posortowana alfabetycznie po nazwie kraju.
2. Znajdź te produkty, dla których stosowane były co najmniej 3 różne ceny jednostkowe w różnych zamówieniach. Wyświetl te ceny.
   - Zapytanie powinno zwracać unikalne wiersze dla produktów.
   - Zwracane kolumny: `ProductID`, `ProductName`, `UnitPrice`.
3. Wymień nazwiska pracowników oraz nazwę kategorii dla pracowników, którzy nie obsługiwali danej kategorii produktów w zamówieniach w roku 1996, tj. szukamy takiej kombinacji pracownika i kategorii produktów, która nie pojawia się w zamówieniach złożonych w 1996.
   - Zwracane kolumny: `LastName`, `CategoryName`.
4. Wymień nazwy produktów wraz z ich kategorią oraz opisem kategorii, dla których złożono mniej zamówień w 1997 r. niż w 1996 r.
   - Lista powinna być posortowana w kolejności malejącej po różnicy w liczbie zamówień.
   - Zwracane kolumny: `ProductName`, `CategoryName`, `Description`, `liczba_1996`, `liczba_1997`.
5. Ruchoma średnia miesięczna liczba produktów w kolejnych miesiącach roku 1997 sprzedana w danej kategorii obliczona dla obecnego miesiąca i dwóch poprzednich w roku 1997.
   - Wynik: `CategoryName`, `Year`, `Month`, `TotalAvgForLastMonths`.
