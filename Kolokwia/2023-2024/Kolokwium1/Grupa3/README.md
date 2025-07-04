# Kolokwium 1:

### Zadanie 1:

Wyświetl liczbę produktów według kontynentu, do którego należą kraje dostawców według reguły:

- Jeżeli krajem dostwcy jest USA lub Kanada, produkty zaliczają się do kategorii `North America`.
- Jeżeli kraje dostawcy to Japonia lub Singapur, produkty zaliczają się do kategorii `Asia`.
- Wszystkie pozostałe kraje dostawców zaliczają się do grupy `Other`.

### Zadanie 2:

Wyświetl listę klientów, dla których istnieją zamówienia nienależące do przedziału od `1997-01-01` do `1997-06-01`, a także adres klienta zawiera podciąg `rue` oraz dane kontaktowe zaczynają się na literę od `A` do `F` lub trzecią literą jest `n`.

### Zadanie 3:

Wyświetl łączną kwotę w zamówieniach złożonych w kolejnych miesiącach roku 1998, wyliczoną dla każdego miesiąca osobno, narastająco od początku roku oraz w okresie bieżącego i poprzedzających dwóch miesięcy. Oczekiwany format to: `OrderMonth`, `TotalPayment`, `TotalPaymentForYear`, `TotalPaymentsForLastThreeMonths`. Do realizacji zapytania można wykorzystać widok (ang. _view_).

### Zadanie 4:

Korzystając z bazy `AdventureWorks2019` wyświetl ID terytorium, z którego pochodzą klienci z maksymalną liczbą nieprzypisanych do nich sklepów (odpowiednia kolumna zawiera wartość null), oraz liczbę klientów. Oczekiwany format to: `TerritoryID`, `[Customers without store]`.

### Zadanie 5:

Korzystając z bazy `AdventureWorks2019` wyświetl zestawienie produktów według kategorii w latach 2011-2012. Oczekiwany format wyniku to: `ProductSubcategoryID`, `CategoryName`, `TotalAmount`. Posortuj wyniki nierosnąco według `TotalAmount`.
