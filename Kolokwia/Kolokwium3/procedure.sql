use EduCourses
go

create procedure enroll_client
    @user_email varchar(255),
    @course_id int
as
begin
	declare @user_id int,
			@is_user_active bit,
            @is_course_active bit,
			@total_enrolled_users int,
			@total_course_capacity int,
            @total_courses int,
            @base_price money,
            @discount money = 0,
            @total_cost money,
            @discount_type varchar(100) = 'bezwarunkowy'

	begin transaction

	select @user_id = UserID, @is_user_active = IsActive
    from Users
    where Email = @user_email

	-- Sprawdzenie, czy u¿ytkownik istnieje:
	if @user_id is null
    begin
		-- Jeœli u¿ytkownik nie istnieje, tworzymy nowego:
        insert into Users (Email, IsActive)
        values (@user_email, 1);

        set @user_id = scope_identity();
        set @is_user_active = 1;
    end

	-- Sprawdzenie, czy u¿ytkownik jest aktywny:
	if @is_user_active = 0
    begin
        raiserror('U¿ytkownik jest nieaktywny.', 16, 1);
        rollback transaction;
        return;
    end

	-- Sprawdzenie, czy kurs jest aktywny:
    select @is_course_active = IsActive, @base_price = BasePrice
    from Courses
    where CourseID = @course_id;

    if @is_course_active = 0
    begin
        raiserror('Kurs jest nieaktywny.', 16, 1);
        rollback transaction;
        return;
    end

	-- Sprawdzenie, czy istnieje wolne miejsce w kursie:
	select @total_enrolled_users = count(*) 
	from Enrollments
	where CourseID = @course_id
		and IsCompleted = 0
		and IsDropped = 0

	select @total_course_capacity = sum(MaxGroupCapacity)
	from Groups
	where CourseID = @course_id

	if @total_enrolled_users >= @total_course_capacity
	begin
	    raiserror('Brak dostêpnych miejsc.', 16, 1);
        rollback transaction;
        return;
	end

	-- Obliczenie rabatu na podstawie liczby zakupionych kursów:
    select @total_courses = count(*)
    from Enrollments
    where UserID = @user_id;

    if @total_courses = 0
    begin
        set @discount = 100;
    end
    else if @total_courses = 1
    begin
        set @discount = @base_price * 0.05;
        set @discount_type = 'sta³y rabat 5%';
    end
    else
    begin
        set @discount = @base_price * (0.05 + @total_courses * 0.01);
        set @discount_type = concat('lojalnoœciowy rabat ', @total_courses, '%');
    end

    set @total_cost = @base_price - @discount;

	-- Dodanie nowego rekordu w tabeli course_enrollment:
    insert into Enrollments (UserID, CourseID, EnrollmentDate, TotalCost, DiscountType, DiscountValue)
    values (@user_id, @course_id, getdate(), @total_cost, @discount_type, @discount);

	commit
end