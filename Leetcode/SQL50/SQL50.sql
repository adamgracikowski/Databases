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
