# Kolokwium 2:

### Zadanie 1:

Utwórz bazę `Enterprise`, a w niej tabelę `Invoices` według podanego poniżej opisu schematu. Rozwiązanie umieść w skrypcie `solution.sql`.

| Invoices      |                                                  |
| ------------- | ------------------------------------------------ |
| InvoiceID     | integer (primary key, automatically incremented) |
| Netto         | money                                            |
| Brutto        | money                                            |
| AccountNumber | text                                             |

### Zadanie 2:

Przygotuj projekt z aplikacją konsolową, która będzie zawierać niezbędne klasy, żeby połączyć się z bazą danych. W zaimplementowanych klasach umieść następującą logikę:

- W pierwszej transakcji usuwa istniejące rekordy z tabeli Invoices.
- W drugiej transakcji tworzy trzy rekordy o kwotach netto 100, 200 i 300 i kwotach brutto równych `1.23 * Netto`.
- W trzeciej transakcji wykonuje dwie operacje:
  - Modyfikuje rekordy poprzez zmianę kwoty brutto poprzez dwukrotne jej zwiększenie.
  - Dopisuje fakturę o kwocie brutto 1000.
- W czwartej transakcji:
  - W pętli tworzy 10 rekordów o losowych wartościach atrybutów.
  - Poddaje losowym modyfikacjom faktury o największej oraz najmniejszej wartości Brutto.

Po każdej z transakcji należy pobrać z bazy danych zawartość całej tabeli i wyświetlić je w postaci komunikatów w oknie konsoli.
