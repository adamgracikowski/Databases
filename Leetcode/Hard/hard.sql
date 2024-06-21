-- SQL Hard:

-- 601. Human Traffic of Stadium:
-- https://leetcode.com/problems/human-traffic-of-stadium

with cte as (
    select 
        id, 
        visit_date, 
        people, 
        id - row_number() over(
            order by id
        ) as rnum
from stadium
where people >= 100
)
select 
    id, 
    visit_date, 
    people 
from cte
where rnum in (
    select rnum
    from cte
    group by rnum
    having count(*) >= 3
)

-- 262. Trips and Users:
-- https://leetcode.com/problems/trips-and-users

with cte as (
select distinct
	request_at as 'day',
    cast(count(status) over(partition by request_at)  as decimal(10,2)) totalrequest,
    count(
        case 
            when status in ('cancelled_by_driver', 'cancelled_by_client') then 1 
            else null end
    ) over (partition by request_at) totalcancelrequest 
from Trips t
where t.request_at > '2013-09-29' and t.request_at < '2013-10-04'
    and not exists(
            select *
		    from Users u
		    where t.client_id = u.users_id 
                and u.banned = 'yes'
                or t.driver_id = u.users_id 
                and u.banned = 'yes'
    )
)
select 
    day,
    round(totalcancelrequest / totalrequest,2) as 'cancellation rate'
from cte