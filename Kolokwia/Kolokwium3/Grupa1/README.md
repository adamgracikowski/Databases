# Kolokwium 3:

## Opis bazy danych EduCourses:

| Courses | |
| ------ | ------ |
| CourseID | integer (primary key, automatically incremented) |
| CourseName | nvarchar(100) |
| BasePrice | money |
| PlannedGroupsAmount | integer (default value 1) |
| DateStart | date |
| DateEnd | date |
| IsActive | boolean (default value true) |

| Groups | |
| ------ | ------ |
| GroupID | integer (primary key, automatically incremented) |
| GroupType | nvarchar(25) (default "zajęciowy") |
| CourseID | integer (reference to Course) |
| MaxGroupCapacity | integer |

| GroupTimetables | |
| ------ | ------ |
| GroupID | integer (reference to Group) |
| Room | nvarchar(10) |
| DatetimeStart | datetime |
| DatetimeEnd | datetime |

| Users | |
| ------ | ------ |
| UserID | integer (primary key, automatically incremented) |
| Email | nvarchar(255) |
| FirstName | nvarchar(200) |
| LastName | nvarchar(200) |
| ISActive | boolean |
| Age | integer |

| Enrollments | |
| ------ | ------ |
| UserID | integer (reference to Users) |
| CourseID | integer (reference to Course) |
| EnrollmentDate | datetime |
| TotalCost | money |
| DiscountType | varchar(100) (defalut value "bezwarunkowy") |
| DiscountValue | money|
| IsCompleted | boolean (default value false) |
| IsDropped | boolean (defalut value false) |

## Zadanie 1:
- Przygotować skrypt `script01.sql`, w którym tworzona jest baza danych EduCourses, tabele oraz relacje między nimi (zgodnie z podanym modelem danych).
- Przygotować skrypt `script02.sql`, w którym zostaną wykonane następujące modyfikacje modelu danych:
    - Dodana zostaje kolumna PhoneNumber (varchar(25)) do tabeli Users.
    - Usunięta zostaje kolumna Age.
    - Dodane zostaje sprawdzenie tego, że StartDate będzie zawsze wcześniejszą datą w porównaniu do DateEnd w tabeli Courses.
- Przygotować skrypt `script03.sql`, w którym zostaną wstawione przynajmniej po 3 rekordy do każdej tabeli w utworzonej bazie. Dane muszą być sensowne!


## Zadanie 2:
- Przygotować skrypt `script04.sql`, w którym dodawane są indeksy dla następujących wymagań:
    - Częste łączenie tabel Users i Enrollments.
    - Unikalność Email.
    - Częste wyszukieanie danych według daty rozpoczęcia i zakończenia kursu.
    - Złożony indeks w tabelu Enrollments.
    - Filtracja użytkowników według imienia i nazwiska.


## Zadanie 3:
Przygotować procedurę składowaną w pliku `procedure.sql` do zapisu użytkownika na wybrany kurs.
Procedura przyjmuje parametry `user_email` oraz `course_id`.
Wykonuje walidację poprzez sprawdzenie:
- czy podany użytkownik jest aktywny, 
- czy kurs jest aktywny oraz 
- czy istnieje chociaż jedno dostępne miejsce w grupach przypisanych do danego kursu.

Jeżeli nie istnieje użytkownik o podanym adresie mailowym, to jest on dodawany do tabeli Users.
Jeżeli warunki walidacji są spełnione, procedura oblicza koszt kursu zgodnie z zasadami:
- Jeżeli użytkownik kupił pierwszy kurs w systemie, to otrzymuje bezwarunkowy rabat w wysokości 100 zł.
- Jeżeli użytkownik zakupił drugi kurs w systemie, otrzymuje stały rabat w wysokości 5%.
- Jeżeli kupił n-ty kurs ($n>2$), to otrzymuje rabat lojalnościowy w wysokości n%, który należy dodać do stałego rabatu.