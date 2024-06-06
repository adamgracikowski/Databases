# Laboratorium 6: Ćwiczenie SQL DLL na bazie [Northwind](https://en.wikiversity.org/wiki/Database_Examples/Northwind)

### Zadanie 01:
Przypisz wszystkie zamówienia nadzorowane przez pracownika o identyfikatorze 1 pracownikowi o identyfikatorze 4.

### Zadanie 02:
Dla wszystkich zamówień złożonych po 15/05/1997 na produkt Ikura zmniejsz o 20% (zaokrąglając do najbliższej liczby całkowitej) ilość zamówionych sztuk produktu.

### Zadanie 03:
Znajdź identyfikator ostatniego zamówienia złożonego przez klienta ALFKI, które nie obejmuje produktu Chocolade. Znajdź identyfikator produktu Chocolade. Dodaj Chocolade do listy produktów zamówionych w ramach  tego zamówienia, z ilością równą 1.

### Zadanie 04:
Dodaj produkt Chocolade do wszystkich zamówień złożonych przez klienta ALFKI, które jeszcze nie zawierają tego produktu.

### Zadanie 05:
Usuń dane wszystkich kontrahentów, którzy nie złożyli żadnych zamówień.

### Zadanie 06:
Wymień wszystkich klientów, którzy złożyli co najmniej dwa zamówienia, ale nigdy nie zamówili produktów o nazwach zaczynających się od „Ravioli”.

### Scenariusz 01:
Istnieje potrzeba przeniesienia danych niektórych zamówień do tabel archiwalnych. 
W celu realizacji zadania należy:
- Utworzyć tabelę ArchivedOrders z tym samym zestawem kolumn, co tabela Orders.
- Zdefiniować w niej klucze podstawowe oraz klucze obce.
- Dodać kolumnę ArchiveDate (datetime).
- Utworzyć tabelę ArchivedOrderDetails z tym samym zestawem kolumn co tabela [Order Details].
- Przenieść wszystkie zamówienia wykonane w 1996 roku do nowych tabel.
- Ustawić ArchiveDate na bieżącą datę.

### Scenariusz 02:
Wszystkie zamówienia złożone przez klienta ALFKI zostały anulowane. 
Aby odzwierciedlić tą informację w bazie danych, należy:
- Dodać nową kolumnę IsCancelled (bit) do tabeli zamówień.
- Ustawić wartość tej kolumny na 0 dla każdego klienta z wyjątkiem ALFKI oraz ustawić wartość tej kolumny na 1 dla zamówień klienta ALFKI.
- Ustawić na 0 ilość w każdym zamówieniu klienta ALFKI.

