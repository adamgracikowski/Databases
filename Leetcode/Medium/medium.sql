-- SQL Medium:

-- 1393. Capital Gain/Loss:
-- https://leetcode.com/problems/capital-gainloss

select
    stock_name,
    sum(iif(operation = 'Sell', price, -1 * price)) as capital_gain_loss
from Stocks
group by stock_name

-- 608. Tree Node:
-- https://leetcode.com/problems/tree-node

-- I sposób:

with cte as (
select 
    t1.id,
    sum(iif(t2.id is null, 0, 1)) as leafs
from Tree t1
left join Tree t2
on t1.id = t2.p_id
group by t1.id
)

select
    c.id,
    case 
        when t.p_id is null then 'Root'
        when c.leafs = 0 then 'Leaf'
        else 'Inner'
    end as type
from cte c
join Tree t
on c.id = t.id 

-- II sposób:

select
    t.id,
    case 
        when t.p_id is null then 'Root'
        when (select count(*) from Tree where p_id = t.id) = 0 then 'Leaf'
        else 'Inner'
    end as type
from Tree t

-- III sposób:

select
    t.id,
    case 
        when t.p_id is null then 'Root'
        when exists (select * from Tree where p_id = t.id) then 'Inner'
        else 'Leaf'
    end as type
from Tree t

-- 178. Rank Scores:
-- https://leetcode.com/problems/rank-scores

select
    score,
    dense_rank() over (
        order by score desc
    ) as [rank]
from Scores

-- 1158. Market Analysis I:
-- https://leetcode.com/problems/market-analysis-i

select
    u.user_id as buyer_id,
    u.join_date,
    (
        select count(*)
        from Orders
        where buyer_id = u.user_id
            and year(order_date) = 2019
    ) as orders_in_2019 
from Users u

-- 184. Department Highest Salary:
-- https://leetcode.com/problems/department-highest-salary

with cte as (
    select
        d.name as Department,
        e.name as Employee,
        e.salary as Salary,
        dense_rank() over (
            partition by d.name
            order by e.salary desc
        ) as salary_rank
    from Department d
    join Employee e
    on e.departmentId = d.id
)
select Department, Employee, Salary from cte
where salary_rank = 1

-- 177. Nth Highest Salary:
-- https://leetcode.com/problems/nth-highest-salary

create function getNthHighestSalary(@n int) returns int as
begin
    return (
        select top 1 salary
        from (
            select salary, dense_rank() over (
                order by salary desc
            ) as [rank]
            from Employee
        ) as cte
        where [rank] = @n
    )
end