-- SQL 50 from leetcode.com:

-- 1) 1757. Recyclable and Low Fat Products:
-- https://leetcode.com/problems/recyclable-and-low-fat-products

select p.product_id 
from Products p
where p.low_fats = 'Y'
    and p.recyclable = 'Y'

-- 2) 584. Find Customer Referee:
-- https://leetcode.com/problems/find-customer-referee

select c.name
from Customer c
where COALESCE(c.referee_id, 0) <> 2

-- 3) 595. Big Countries:
-- https://leetcode.com/problems/big-countries

select 
    w.name,
    w.population, 
    w.area 
from World w
where w.area >= 3000000 
    or w.population >= 25000000

-- 4) 1148. Article Views I:
-- https://leetcode.com/problems/article-views-i

select distinct
    v.author_id as id
from Views v
where v.author_id = v.viewer_id
order by author_id asc

-- 5) 1683. Invalid Tweets:
-- https://leetcode.com/problems/invalid-tweets

select t.tweet_id 
from Tweets t
where len(t.content) > 15

-- 6) 1378. Replace Employee ID With The Unique Identifier:
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier

select 
	eu.unique_id, 
	e.name 
from Employees e
left join EmployeeUNI eu
on e.id = eu.id

-- 7) 1068. Product Sales Analysis I:
-- https://leetcode.com/problems/product-sales-analysis-i

select 
	p.product_name, 
	s.year, 
	s.price 
from Sales s
join Product p 
on s.product_id = p.product_id

-- 8) 1581. Customer Who Visited but Did Not Make Any Transactions:
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions

select 
    v.customer_id,
    count(*) as count_no_trans
from Visits v
left join Transactions t
on v.visit_id = t.visit_id
where t.visit_id is null
group by v.customer_id

-- 9) 197. Rising Temperature:
-- https://leetcode.com/problems/rising-temperature

select current_day.id
from Weather as current_day
where exists (
    select *
    from Weather as yesterday
    where current_day.temperature > yesterday.temperature
    and current_day.recordDate = dateadd(day, 1, yesterday.recordDate)
)

-- 10) 1661. Average Time of Process per Machine:
-- https://leetcode.com/problems/average-time-of-process-per-machine

select
    a1.machine_id,
    round(avg(a1.timestamp - a2.timestamp), 3) as processing_time
from Activity a1
join Activity a2
on a1.machine_id = a2.machine_id
    and a1.process_id = a2.process_id
    and a1.activity_type = 'end'
    and a2.activity_type = 'start'
group by a1.machine_id

-- 11) 577. Employee Bonus:
-- https://leetcode.com/problems/employee-bonus

select
    e.name,
    b.bonus
from Employee e
left join Bonus b
on e.empId = b.empId
where coalesce(b.bonus, 0) < 1000

-- 12) 1280. Students and Examinations:
-- https://leetcode.com/problems/students-and-examinations

select 
    st.student_id,
    st.student_name,
    su.subject_name,
    (
        select count(*) from Examinations e
        where e.student_id = st.student_id
            and e.subject_name = su.subject_name
    ) as attended_exams
from Subjects su, Students st
order by st.student_id, su.subject_name

-- 13) 570. Managers with at Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports

select e2.name from Employee e1, Employee e2
where e1.managerId = e2.id
group by e2.id, e2.name
having count(*) > 4

-- 14) 1934. Confirmation Rate:
-- https://leetcode.com/problems/confirmation-rate

with cte (user_id, confirmed, total) as (
    select 
        s.user_id,
        sum(case when c.action = 'confirmed' then 1 else 0 end) as confirmed,
        count(*) as total
    from signups s
    left join confirmations c
    on s.user_id = c.user_id
    group by s.user_id
)
select 
    user_id,
    case 
        when total = 0 then 0 
        else round(cast(confirmed as float) / total, 2) 
    end as confirmation_rate 
from cte;

-- 15) 620. Not Boring Movies:
-- https://leetcode.com/problems/not-boring-movies

select * from cinema
where id % 2 = 1 
	and description <> 'boring'
order by rating desc

-- 16) 1251. Average Selling Price:
-- https://leetcode.com/problems/average-selling-price

-- I sposób:

with cte (product_id, total_value, total_units) as (
    select 
        p.product_id,
        sum(p.price * us.units) as total_value,
        sum(us.units) as total_units
    from Prices p
    left join UnitsSold us
    on p.product_id = us.product_id
        and p.start_date <= us.purchase_date
        and us.purchase_date <= p.end_date
    group by p.product_id
)
select
    product_id,
    case 
        when total_units = 0 or total_units is null then 0 
        else round(cast(total_value as float) / total_units, 2) 
    end as average_price
from cte

-- II sposób:

select 
	p.product_id, 
	ifnull(round(sum(us.units * p.price) / sum(us.units), 2), 0) as average_price
from Prices p
left join UnitsSold us
on p.product_id = u.product_id 
	and u.purchase_date between start_date and end_date
group by product_id;

-- 17) 1075. Project Employees I:
-- https://leetcode.com/problems/project-employees-i

select 
    project_id, 
    round(avg(experience_years * 1.0), 2) as average_years 
from Project p 
inner join Employee e 
on p.employee_id = e.employee_id 
group by project_id

-- 18) 1633. Percentage of Users Attended a Contest:
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest

declare @total int
select @total = count(*) from Users u

select 
    r.contest_id,
    round(100 * cast(count(*) as float) / @total, 2) as percentage
from Register r
left join Users u
on r.user_id = u.user_id
group by r.contest_id
order by percentage desc, contest_id asc

-- 19) 1211. Queries Quality and Percentage:
-- https://leetcode.com/problems/queries-quality-and-percentage

select 
    q.query_name,
    round(avg(cast(q.rating as float) / q.position), 2) as quality,
    round(100.0 * sum(case when q.rating < 3 then 1 else 0 end) / count(*), 2) as poor_query_percentage 
from Queries q
where q.query_name is not null
group by q.query_name

-- 20) 1193. Monthly Transactions I:
-- https://leetcode.com/problems/monthly-transactions-i

select 
    concat(year(t.trans_date), '-', format(month(t.trans_date), '00')) as [month],
    t.country,
    count(*) as trans_count,
    sum(case when t.state = 'approved' then 1 else 0 end) as approved_count,
    sum(t.amount) as trans_total_amount,
    sum(case when t.state = 'approved' then t.amount else 0 end) as approved_total_amount 
from Transactions t
group by year(t.trans_date), month(t.trans_date), t.country

-- 21) 1174. Immediate Food Delivery II:
-- https://leetcode.com/problems/immediate-food-delivery-ii

with cte (is_immediate) as (
    select iif(d.order_date = d.customer_pref_delivery_date, 1, 0) 
    from Delivery d
    where d.order_date = (
        select min(order_date) 
        from Delivery 
        where d.customer_id = customer_id
    ) 
)
select round(100 * avg(cast(is_immediate as float)), 2) as immediate_percentage 
from cte

-- 22) 550. Game Play Analysis IV:
-- https://leetcode.com/problems/game-play-analysis-iv

declare @total int,
        @consecutive int

select @consecutive = count(*)
from Activity a1
join Activity a2
on a1.player_id = a2.player_id
and datediff(day, a1.event_date, a2.event_date) = 1
and a1.event_date = (
    select min(event_date) 
    from Activity 
    where player_id = a1.player_id
)

select @total = count(distinct player_id) 
from Activity

select round(cast(@consecutive as float) / @total, 2) as fraction

-- 23) 2356. Number of Unique Subjects Taught by Each Teacher:
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher

select 
    t.teacher_id,
    count(distinct t.subject_id) as cnt
from Teacher t
group by t.teacher_id

-- 24) 1141. User Activity for the Past 30 Days I:
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i

select 
    a.activity_date as [day],
    count(distinct user_id) as active_users
from Activity a
where a.activity_date > dateadd(day, -30, '2019-07-27') 
    and a.activity_date <= '2019-07-27'
group by a.activity_date

-- 25) 1070. Product Sales Analysis III:
-- https://leetcode.com/problems/product-sales-analysis-iii

select
    s.product_id,
    s.year as first_year,
    s.quantity,
    s.price
from Sales s
where s.year = (
    select min(year) 
    from Sales 
    where product_id = s.product_id
)

-- 26) 596. Classes More Than 5 Students:
-- https://leetcode.com/problems/classes-more-than-5-students

select c.class 
from Courses c 
group by c.class
having count(c.student) >= 5

-- 27) 1729. Find Followers Count:
-- https://leetcode.com/problems/find-followers-count

select 
    f.user_id,
    count(f.follower_id) AS followers_count
from Followers f
group by f.user_id
order by f.user_id asc

-- 28) 619. Biggest Single Number:
-- https://leetcode.com/problems/biggest-single-number

declare @result int

select top 1 @result = num from MyNumbers
group by num
having count(*) = 1
order by num desc

select @result as num

-- 29) 1045. Customers Who Bought All Products:
-- https://leetcode.com/problems/customers-who-bought-all-products

declare @total_products int
select @total_products = count(*) from Product

select
    c.customer_id
from Customer c
group by c.customer_id
having count(distinct c.product_key) = @total_products

-- 30) 1731. The Number of Employees Which Report to Each Employee:
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee

select 
    e1.employee_id,
    e1.name,
    count(*) as reports_count,
    round(avg(e2.age * 1.0), 0) as average_age    
from Employees e1
join Employees e2 on e1.employee_id = e2.reports_to
group by e1.employee_id, e1.name
order by e1.employee_id

-- 31) 1789. Primary Department for Each Employee:
-- https://leetcode.com/problems/primary-department-for-each-employee

select
    e.employee_id,
    e.department_id
from Employee e
where e.primary_flag = 'Y'
    or 1 = (
        select count(*) 
        from Employee
        where employee_id = e.employee_id
    )

-- 32) 610. Triangle Judgement:
-- https://leetcode.com/problems/triangle-judgement

select
    t.*,
    case 
        when t.x + t.y > t.z 
            and t.x + t.z > t.y 
            and t.y + t.z > t.x 
        then 'Yes' 
    else 'No' 
    end as triangle    
from Triangle t

-- 33) 180. Consecutive Numbers:
-- https://leetcode.com/problems/consecutive-numbers

select distinct l1.num as ConsecutiveNums
from Logs l1
join Logs l2 on l1.id = l2.id - 1
join Logs l3 on l1.id = l3.id - 2
where l1.num = l2.num and l2.num = l3.num

-- 34) 1164. Product Price at a Given Date:
-- https://leetcode.com/problems/product-price-at-a-given-date

declare @given_date date;
set @given_date = '2019-08-16'

-- I sposób:

select distinct
    p.product_id,
    coalesce((
        select top 1 new_price
        from Products
        where product_id = p.product_id
          and change_date <= @given_date
        order by change_date desc
    ), 10) as price
from Products p

-- II sposób:

declare @given_date date;
set @given_date = '2019-08-16';

select 
    t.product_id, 
    coalesce(p.new_price, 10) as price
from (
        select 
            product_id, 
            max(case when cast(change_date as date) <= @given_date then change_date end) as dt
        from products
        group by product_id
     ) as t
left join products p
on p.product_id = t.product_id and t.dt = p.change_date

-- 35) 1204. Last Person to Fit in the Bus:
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus

with cte (person_name, cumulative_weight) as (
    select
        q.person_name,
        sum(weight) over (order by q.turn)
    from Queue q 
)
select top 1
    person_name
from cte
where cumulative_weight <= 1000
order by cumulative_weight desc

-- 36) 1907. Count Salary Categories:
-- https://leetcode.com/problems/count-salary-categories

with cte as (
    select
        'Low Salary' as category,
        sum(iif(a.income < 20000, 1, 0)) as accounts_count
    from Accounts a 

    union all

    select
        'Average Salary' as category,
        sum(iif(a.income >= 20000 and a.income <= 50000, 1, 0)) as accounts_count
    from Accounts a 

    union all

    select
        'High Salary' as category,
        sum(iif(a.income > 50000, 1, 0)) as accounts_count
    from Accounts a 
)
select *
from cte

-- 37) 1978. Employees Whose Manager Left the Company:
-- https://leetcode.com/problems/employees-whose-manager-left-the-company

select e1.employee_id 
from Employees e1
left join Employees e2
on e1.manager_id = e2.employee_id
where e1.manager_id is not null
    and e2.employee_id is null
    and e1.salary < 30000
order by e1.employee_id

-- 38) 626. Exchange Seats:
-- https://leetcode.com/problems/exchange-seats

select
    case
        when id % 2 = 1 then lead(id, 1, id) over (order by id asc)
        when id % 2 = 0 then id - 1
    end as id,
    student
from Seat
order by id

-- 39) 1341. Movie Rating:
-- https://leetcode.com/problems/movie-rating

with TopUser as (
    select top 1
        u.name as results,
        count(*) as rating_count
    from MovieRating mr
    join Users u on u.user_id = mr.user_id
    group by u.name
    order by rating_count desc, results asc
),
TopMovie as (
    select top 1
        m.title as results,
        avg(cast(mr.rating as decimal(10, 2))) as average_rating
    from MovieRating mr
    join Movies m
    on mr.movie_id = m.movie_id
    where mr.created_at >= '2020-02-01'
        and mr.created_at <= '2020-02-29'
    group by title
    order by average_rating desc, m.title asc
)
select results from TopUser
union all
select results from TopMovie

-- 40) 1321. Restaurant Growth:
-- https://leetcode.com/problems/restaurant-growth

with cte as (
    select 
        visited_on, 
        sum(amount) as amount
    from customer
    group by visited_on
)
select 
    visited_on, 
    sum(amount) over (
        order by visited_on 
        rows between 6 preceding and current row
    ) as amount, 
    round(avg(amount*1.00) over (
        order by visited_on 
        rows between 6 preceding and current row
    ), 2) as average_amount
from cte
order by visited_on
offset 6 rows

-- 41) 602. Friend Requests II: Who Has the Most Friends:
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends

-- I sposób:

with c1 as (
    select
        requester_id as id,
        count(*) as num
    from RequestAccepted
    group by requester_id
),
c2 as (
    select
        accepter_id as id,
        count(*) as num
    from RequestAccepted
    group by accepter_id
)
select top 1
    coalesce(c1.id, c2.id) as id,
    coalesce(c1.num, 0) + coalesce(c2.num, 0) as num
from c1
full join c2
on c1.id = c2.id
order by num desc

-- II sposób:

with cte as (
    (select accepter_id as id, count(*) as num from RequestAccepted group by accepter_id)
    union all
    (select requester_id as id, count(*) as num from RequestAccepted group by requester_id)
)

select top 1 
    id, 
    sum(num) as num from cte
group by id
order by num desc

-- 42) 585. Investments in 2016:
-- https://leetcode.com/problems/investments-in-2016

select 
    round(sum(i.tiv_2016 * 1.0), 2) as tiv_2016 
from Insurance i
where exists (
    select * from Insurance
    where tiv_2015 = i.tiv_2015
        and pid <> i.pid
) and not exists (
    select * from Insurance
    where lat = i.lat
        and lon = i.lon
        and pid <> i.pid
)

-- 43) 185. Department Top Three Salaries:
-- https://leetcode.com/problems/department-top-three-salaries

with ranked_salaries as (
    select 
        d.name as Department,
        e.name as Employee,
        e.salary as Salary,
        dense_rank() over (
            partition by e.departmentId
            order by e.salary desc
        ) as [rank]
    from Employee e
    join Department d
    on e.departmentId = d.id
)
select Department, Employee, Salary from ranked_salaries
where rank < 4

-- 44) 1667. Fix Names in a Table:
-- https://leetcode.com/problems/fix-names-in-a-table

select
    user_id,
    concat(upper(left(name, 1)), lower(right(name, len(name) - 1))) as name
from Users
order by user_id

-- 45) 1527. Patients With a Condition:
-- https://leetcode.com/problems/patients-with-a-condition

select * from Patients
where conditions like 'DIAB1%'
    or conditions like '% DIAB1%'

-- 46) 196. Delete Duplicate Emails:
-- https://leetcode.com/problems/delete-duplicate-emails

with cte as (
    select
        id,
        row_number() over (
            partition by email order by id
        ) as [counter]
    from Person
)
delete from Person
where id in (select id from cte where [counter] > 1)

-- 47) 176. Second Highest Salary:
-- https://leetcode.com/problems/second-highest-salary

declare @max_salary int
select @max_salary = max(salary) from Employee

select max(salary) as SecondHighestSalary 
from employee
where salary != @max_salary

-- 48) 1484. Group Sold Products By The Date:
-- https://leetcode.com/problems/group-sold-products-by-the-date

with cte as (
    select distinct
        sell_date,
        product
    from Activities
)
select
    sell_date,
    count(product) as num_sold,
    string_agg(product, ',') within group (order by product) as products
from cte
group by sell_date

-- 49) 1327. List the Products Ordered in a Period:
-- https://leetcode.com/problems/list-the-products-ordered-in-a-period

select
    p.product_name,
    sum(o.unit) as unit
from Products p
join Orders o
on o.product_id = p.product_id
where o.order_date >= '2020-02-01'
    and o.order_date <= '2020-02-29'
group by p.product_name
having sum(o.unit) >= 100

-- 50) 1517. Find Users With Valid E-Mails:
-- https://leetcode.com/problems/find-users-with-valid-e-mails

select * from Users
where mail like '[a-zA-Z]%@leetcode.com'
and mail not like '%[#%^$!&*()+=@]%@leetcode.com'