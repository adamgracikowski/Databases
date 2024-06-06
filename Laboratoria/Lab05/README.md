# Laboratorium 5: Ćwiczenie zapytań na bazie [Northwind](https://en.wikiversity.org/wiki/Database_Examples/Northwind)

### Zadanie 01:
Ustal łączną ilość każdego produktu dostarczoną do poszczególnych krajów przez pracownika z identyfikatorem 2. Wynik powinien zawierać następujące kolumny: ProductID, ShipCountry, TotalQuantity.

### Zadanie 02:
Ustal listę pracowników, którzy sprzedali co najmniej 100 sztuk produktu Chocolade w roku 1998. Wynik powinien zawierać następujące kolumny: EmployeeName, EmployeeSurname, TotalQuantity.

### Zadanie 03:
Wymień wszystkie produkty, które zostały zamówione przez klientów z Włoch, takie, że średnio co najmniej 20 sztuk tego produktu zostało zamówionych w pojedynczym zamówieniu złożonym przez danego klienta. Ułóż wyniki w kolejności malejącej sumarycznej liczby zamówień złożonej przez klienta na dany produkt.

### Zadanie 04:
Wymień wszystkich klientów z Berlina i zamówione przez nich produkty. Wynik zapytania powinien zawierać następujące kolumny: CustomerName, ProductName, OrderDate, Quantity. Posortuj wynik w kolejności CustomerName, ProductName, OrderDate.

### Zadanie 05:
Wymień wszystkie produkty, które zostały dostarczone do Francji w 1998 roku.

### Zadanie 06:
Wymień wszystkich klientów, którzy złożyli co najmniej dwa zamówienia, ale nigdy nie zamówili produktów o nazwach zaczynających się od „Ravioli”.

### Zadanie 07:
Znajdź wszystkie zamówienia zawierające co najmniej 4 różne produkty i złożone przez klientów z Francji
Wynik powinien zawierać następujące kolumny: CompanyName, OrderId, ProductCount.

### Zadanie 08:
Wymień wszystkich klientów, którzy złożyli co najmniej pięć zamówień wysłanych do Francji, ale nie więcej niż 2 zamówienia wysłane do Belgii. Wynik powinien zawierać jedną kolumnę: CompanyName.

### Zadanie 09:
Dla każdego produktu znajdź wszystkich klientów, którzy złożyli zamówienie na największą kiedykolwiek zamówioną ilość tego produktu. Wynik: ProductName, CompanyName, MaxQuantity.

### Zadanie 10:
Wymień wszystkich pracowników, którzy nadzorowali liczbę zamówień większą niż 120% średniej liczby zamówień 
nadzorowanych przez pracownika.

### Zadanie 11:
Wyświetl dane 5 zamówień zawierających największą liczbę różnych produktów umieszczonych na jednym zamówieniu. Wynik powinien zawierać: OrderId, ProductCount

### Zadanie 12:
Znajdź wszystkie produkty, które zamówiono w większej ilości w 1997 r. niż w 1996 r.
Wynik powinien zawierać kolumny: ProductName, TotalQuantityIn1996, TotalQuantityIn1997.

### Zadanie 13:
Znajdź wszystkie produkty, na które złożono więcej zamówień w 1997 r. niż w 1996 r. Wynik powinien zawierać kolumny: ProductName, NumberOfOrdersIn1996, NumberOfOrdersIn1997.

### Zadanie 14:
Utwórz widok z sumaryczną ilością zamówionych produktów. Widok powinien zawierać: OrderYear, OrderMonth, OrderId, CustomerID, CompanyName, CustomerCountry, CustomerCity, ShipCountry, ShipCity, ProductID, ProductName, CategoryName, UnitPrice, Quantity, ProductValue – sumaryczną wartość zamówionego produktu (Quantity*UnitPrice).

### Zadanie 15:
Przygotuj raport zawierający numer zamówienia, nazwę produktu, nazwę kategorii produktu, wartość zamówionego 
produktu w tym zamówieniu, łączną wartość zamówień na ten produkt oraz łączną wartość zamówień na produkty tej kategorii.

### Zadanie 16:
Przygotuj raport zawierający nazwę produktu, nazwę kategorii produktu, łączną wartość zamówień na ten produkt, łączną wartość zamówień na produkty tej kategorii oraz łączną wartość wszystkich zamówień.

### Zadanie 17:
Przygotuj raport zawierający numer zamówienia, numer produktu, wartość tej linijki zamówienia (ProductValue), narastająco wartość ProductValue od początku zestawienia.

### Zadanie 18:
Przygotuj raport zawierający numer zamówienia, numer produktu, wartość tej linijki zamówienia (ProductValue), sumę wartości ProductValue w dwóch poprzedzających i bieżącym wierszu.

### Zadanie 19:
Przygotuj raport zawierający nazwę produktu, rok, miesiąc, łączną wartość sprzedaży tego produktu w danym roku i miesiącu, łączną wartość sprzedaży tego produktu od początku danego roku oraz liczbę miesięcy od początku 
roku z niezerową sprzedażą produktu.