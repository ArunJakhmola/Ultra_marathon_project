use local;

select * from ultra_marathon um;


-- how many states were represented in the race

select count(distinct state) distinct_count
from ultra_marathon um;

-- what was the average time of a man vs women

select Gender, round(avg(Total_minutes), 2) average_minutes 
from ultra_marathon um 
group by  Gender;


-- What were the youngest and oldest ages in the race

select Gender, min(Age) as youngest_age, max(Age) as oldest_age
from ultra_marathon um 
group by Gender;

--  What was the average time for each age group

select Age, avg(Total_minutes) average_time
from ultra_marathon um 
group by Age
order by Age:

-- Same question with grouped age.

WITH age_bucket AS (
    SELECT total_minutes,
        CASE 
            WHEN Age < 30 THEN 'age_20-29'
            WHEN Age < 40 THEN 'age_30-39'
            WHEN Age < 50 THEN 'age_40-49'
            WHEN Age < 60 THEN 'age_50-59'
            ELSE '60+'
        END AS age_group
    FROM ultra_marathon
)
select age_group, round(avg(total_minutes))
from age_bucket
group by age_group;


-- Top 3 males and females

with gender_rank as 
(select rank() over (partition by gender order by total_minutes asc) as gender_rank,
full_name, gender, total_minutes 
from ultra_marathon)
select * from gender_rank
where gender_rank < 4
order by total_minutes;

create or replace view ultra_marathon_test as 
select full_name, place, time, total_minutes , city, state, age, gender, latlong
from ultra_marathon um 

