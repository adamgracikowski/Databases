--Task 1, Part 2:
use EduCourses
go

alter table Users
add PhoneNumber varchar(25)
go

alter table Users
drop column Age
go

alter table Courses
add constraint CourseEndLaterThanStart check (DateStart < DateEnd)
go