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