--Task 1, Part 1:
create database EduCourses
go

use EduCourses
go

create table Courses (
	CourseID int primary key identity(1,1),
	CourseName nvarchar(100),
	BasePrice money,
	PlannedGroupsAmount int default 1,
	DateStart date,
	DateEnd date,
	IsActive bit default 1
)
go

create table Groups (
	GroupID int primary key identity(1,1),
	GroupType nvarchar(25) default 'zajêciowa',
	CourseID int foreign key references Courses(CourseID),
	MaxGroupCapacity int
) 
go

create table GroupTimetables (
	GroupID int foreign key references Groups(GroupID),
	Room nvarchar(10),
	DatetimeStart datetime,
	DatetimeEnd datetime
)
go

create table Users (
	UserID int primary key identity(1,1),
	Email varchar(255),
	FirstName varchar(200),
	LastName varchar(200),
	IsActive bit,
	Age int,
)
go

create table Enrollments (
	UserID int foreign key references Users(UserID),
	CourseID int foreign key references Courses(CourseID),
	EnrollmentDate datetime,
	TotalCost money,
	DiscountType varchar(100) default 'bezwarunkowy',
	DiscountValue money,
	IsCompleted bit default 0,
	IsDropped bit default 0
) 
go