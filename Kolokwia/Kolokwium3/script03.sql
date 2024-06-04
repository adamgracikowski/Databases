--Task 1, Part 3:
use EduCourses
go

insert into Courses (CourseName, BasePrice, PlannedGroupsAmount, DateStart, DateEnd, IsActive)
values 
('Mathematics 101', 500.00, 2, '2024-07-01', '2024-12-01', 1),
('History 101', 300.00, 1, '2024-07-01', '2024-12-01', 1),
('Science 101', 400.00, 3, '2024-07-01', '2024-12-01', 1);
go

insert into Groups (GroupType, CourseID, MaxGroupCapacity)
values 
('Lecture', 1, 30),
('Seminar', 2, 20),
('Lab', 3, 25);
go

insert into GroupTimetables (GroupID, Room, DatetimeStart, DatetimeEnd)
values 
(1, 'A101', '2024-07-01 09:00:00', '2024-07-01 10:30:00'),
(2, 'B202', '2024-07-02 11:00:00', '2024-07-02 12:30:00'),
(3, 'C303', '2024-07-03 13:00:00', '2024-07-03 14:30:00');
go

insert into Users (Email, FirstName, LastName, IsActive, PhoneNumber)
values 
('john.doe@example.com', 'John', 'Doe', 1, '123456789'),
('jane.smith@example.com', 'Jane', 'Smith', 1, '987654321'),
('alice.jones@example.com', 'Alice', 'Jones', 1, '456789123');
go

insert into Enrollments (UserID, CourseID, EnrollmentDate, TotalCost, DiscountType, DiscountValue, IsCompleted, IsDropped)
values 
(1, 1, '2024-06-01 10:00:00', 500.00, 'bezwarunkowy', 50.00, 0, 0),
(2, 2, '2024-06-02 11:00:00', 300.00, 'bezwarunkowy', 30.00, 0, 0),
(3, 3, '2024-06-03 12:00:00', 400.00, 'bezwarunkowy', 40.00, 0, 0);
go

--Wyœwietlenie wstawionych danych:
select * from Courses
go

select * from Enrollments
go

select * from Groups
go

select * from GroupTimetables
go

select * from Users
go