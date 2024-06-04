--Task 3:
use EduCourses;
go

-- Indeks dla czêstego ³¹czenia tabel users_user i course_enrollment:
create index IdxUsersEnrollmentsUserID on Enrollments(UserID);
create index IdxUserEnrollmentsCourseID on Enrollments(CourseID);
go

-- Unikalnoœæ dla email w tabeli users_user:
create unique index IdxUsersEmailUnique on Users(Email);
go

-- Indeks dla czêstego wyszukiwania danych wed³ug daty rozpoczêcia i zakoñczenia kursu w tabeli course:
create index IdxCoursesDates on Courses(DateStart, DateEnd);
go

-- Z³o¿ony indeks w tabeli course_enrollment:
create index IdxEnrollmentsUserCourse on Enrollments(UserID, CourseID);
go

-- Indeks dla filtracji u¿ytkowników wed³ug imienia i nazwiska w tabeli users_user:
create index IdxUsersName on Users(FirstName, LastName);
go