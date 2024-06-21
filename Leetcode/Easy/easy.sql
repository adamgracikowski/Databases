-- SQL Easy:

-- 1741. Find Total Time Spent by Each Employee:
-- https://leetcode.com/problems/find-total-time-spent-by-each-employee

select
    event_day as day,
    emp_id,
    sum(out_time - in_time) as total_time
from Employees
group by event_day, emp_id

-- 1693. Daily Leads and Partners:
-- https://leetcode.com/problems/daily-leads-and-partners

select
    date_id,
    make_name,
    count(distinct lead_id) as unique_leads,
    count(distinct partner_id) as unique_partners
from DailySales
group by date_id, make_name

-- 1795. Rearrange Products Table:
-- https://leetcode.com/problems/rearrange-products-table

select 
    product_id, 
    'store1' as store, 
    store1 as price
from products
where store1 is not null

union all

select 
    product_id, 
    'store2' as store, 
    store2 as price
from products
where store2 is not null

union all

select 
    product_id, 
    'store3' as store, 
    store3 as price
from products
where store3 is not null

-- 175. Combine Two Tables:
-- https://leetcode.com/problems/combine-two-tables

select 
    p.firstName,
    p.lastName,
    a.city,
    a.state
from Person p
left join Address a
on p.personId = a.personId

-- 181. Employees Earning More Than Their Managers:
-- https://leetcode.com/problems/employees-earning-more-than-their-managers

select
    e1.name as Employee
from Employee e1
join Employee e2
on e1.managerId = e2.id
where e1.salary > e2.salary

-- 183. Customers Who Never Order:
-- https://leetcode.com/problems/customers-who-never-order

select 
    c.name as Customers
from Customers c
left join Orders o
on c.id = o.customerId
where o.customerId is null

-- 607. Sales Person:
-- https://leetcode.com/problems/sales-person

select 
    sp.name 
from SalesPerson sp
where not exists (
    select * from Orders o
    join Company c
    on o.com_id = c.com_id
    where o.sales_id = sp.sales_id
        and c.name = 'RED'
)

-- 627. Swap Salary:
-- https://leetcode.com/problems/swap-salary

update Salary
set sex = iif(sex = 'm', 'f', 'm')

-- 1084. Sales Analysis III:
-- https://leetcode.com/problems/sales-analysis-iii

select
    p.product_id,
    p.product_name
from Product p
join Sales s
on p.product_id = s.product_id
group by p.product_id, p.product_name
having min(sale_date) >= '2019-01-01'
    and max(sale_date) <= '2019-03-31'

-- 1179. Reformat Department Table:
-- https://leetcode.com/problems/reformat-department-table

select id,
       sum(case when month = 'Jan' then revenue else null end) as Jan_Revenue,
       sum(case when month = 'Feb' then revenue else null end) as Feb_Revenue,
       sum(case when month = 'Mar' then revenue else null end) as Mar_Revenue,
       sum(case when month = 'Apr' then revenue else null end) as Apr_Revenue,
       sum(case when month = 'May' then revenue else null end) as May_Revenue,
       sum(case when month = 'Jun' then revenue else null end) as Jun_Revenue,
       sum(case when month = 'Jul' then revenue else null end) as Jul_Revenue,
       sum(case when month = 'Aug' then revenue else null end) as Aug_Revenue,
       sum(case when month = 'Sep' then revenue else null end) as Sep_Revenue,
       sum(case when month = 'Oct' then revenue else null end) as Oct_Revenue,
       sum(case when month = 'Nov' then revenue else null end) as Nov_Revenue,
       sum(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from Department
group by id

-- 1407. Top Travellers:
-- https://leetcode.com/problems/top-travellers

select 
    u.name,
    sum(iif(distance is null, 0, distance)) as travelled_distance 
from Users u 
left join Rides r
on u.id = r.user_id
group by u.id, u.name
order by travelled_distance desc, u.name

-- 1587. Bank Account Summary II:
-- https://leetcode.com/problems/bank-account-summary-ii

 select 
    u.name , 
    sum(t.amount) as balance
 from Users as u
 join Transactions t 
 on u.account = t.account
 group by u.name
 having sum(t.amount) > 10000

-- 1890. The Latest Login in 2020:
-- https://leetcode.com/problems/the-latest-login-in-2020

with cte as (
    select
        user_id,
        time_stamp,
        row_number() over (
            partition by year(time_stamp), user_id
            order by time_stamp desc
        ) as year_rank
    from Logins
)
select
    user_id,
    time_stamp as last_stamp
from cte
where year_rank = 1
    and year(time_stamp) = 2020

-- 1873. Calculate Special Bonus:
-- https://leetcode.com/problems/calculate-special-bonus

select
    employee_id,
    iif(employee_id % 2 = 1 and name not like 'M%', salary, 0) as bonus
from Employees
order by employee_id

-- 1965. Employees With Missing Information:
-- https://leetcode.com/problems/employees-with-missing-information

select employee_id 
from Employees
where employee_id not in (
    select employee_id 
    from salaries
) union
select employee_id 
from salaries
where employee_id not in (
    select employee_id 
    from Employees
)