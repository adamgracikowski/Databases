--Task 3:
use EduCourses;
go

-- Indeks dla cz�stego ��czenia tabel users_user i course_enrollment:
create index IdxUsersEnrollmentsUserID on Enrollments(UserID);
create index IdxUserEnrollmentsCourseID on Enrollments(CourseID);
go

-- Unikalno�� dla email w tabeli users_user:
create unique index IdxUsersEmailUnique on Users(Email);
go

-- Indeks dla cz�stego wyszukiwania danych wed�ug daty rozpocz�cia i zako�czenia kursu w tabeli course:
create index IdxCoursesDates on Courses(DateStart, DateEnd);
go

-- Z�o�ony indeks w tabeli course_enrollment:
create index IdxEnrollmentsUserCourse on Enrollments(UserID, CourseID);
go

-- Indeks dla filtracji u�ytkownik�w wed�ug imienia i nazwiska w tabeli users_user:
create index IdxUsersName on Users(FirstName, LastName);
go