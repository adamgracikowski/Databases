# Laboratorium 7: Stored procedures na bazie [Northwind](https://en.wikiversity.org/wiki/Database_Examples/Northwind)

### Scenariusz 01:

Celem zadania jest przygotowanie procedury składowanej parametryzowanej identyfikatorem klienta (CustomerID).
Procedura dla każdego zamówienia tego klienta sprawdza liczbę złożonych wcześniej zamówień przez klienta na dany produkt.

- Jeżeli wynosi ona od 1 do 2, udzielana jest zniżka w wysokości 5%.
- Jeżeli wynosi ona 3, udzielana jest zniżka w wysokości 10%.
- Jeżeli liczba ta jest większa niż 3, przysługuje zniżka 20%.
- Jeżeli zamówienia jest pierwszym zamówieniem na podany produkt, zniżka wynosi 0%.
  Wartość rabatu w procentach jest zapisywana przez procedurę w kolumnie Discount w tabeli [Order Details].
