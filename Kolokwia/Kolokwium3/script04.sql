--Task 3:
use EduCourses;
go

-- Indeks dla czestego laczenia tabel Users i Enrollments:
create index IdxUsersEnrollmentsUserID on Enrollments(UserID);
create index IdxUserEnrollmentsCourseID on Enrollments(CourseID);
go

-- Unikalnosc dla Email w tabeli Users:
create unique index IdxUsersEmailUnique on Users(Email);
go

-- Indeks dla czestego wyszukiwania danych wedlug daty rozpoczecia i zakonczenia kursu w tabeli Courses:
create index IdxCoursesDates on Courses(DateStart, DateEnd);
go

-- Zlozony indeks w tabeli Enrollments:
create index IdxEnrollmentsUserCourse on Enrollments(UserID, CourseID);
go

-- Indeks dla filtracji uzytkownikow wedlug imienia i nazwiska w tabeli Users:
create index IdxUsersName on Users(FirstName, LastName);
go
