select *
from absenteeism_at_work;

select *
from reasons;

select * 
from compensation;

-- create a join table

select *
from absenteeism_at_work a
left join compensation c
on a.ID = c.ID
left join reasons r
on a.Reason_for_absence = r.Number;

-- find the healthiest employees
-- healthy = no smoke & no drink & BMI < 25 & absentism < avgerage

select *
from absenteeism_at_work a
where Social_drinker = 0 and Social_smoker = 0 and Body_mass_index < 25 and absenteeism_time_in_hours < (select avg(absenteeism_time_in_hours) from absenteeism_at_work a);

-- compensation rate increase for non-smokers/ budget = $983,221, hence $0.68 increase per hour/ $1414 increase per year

select count(*) as nonsmokers
from absenteeism_at_work
where Social_smoker = 0;


-- optimisation of original query
select a.ID, 
r.Reason, 
case when body_mass_index < 18.5 then 'underweight'
	when body_mass_index between 18.5 and 25 then 'Healthy Weight'
	when body_mass_index between 25 and 30 then 'Overweight'
    when body_mass_index > 30 then 'Obese'
    else 'unknown' end as BMI_Category,
case when month_of_absence in (12,1,2) then 'winter'
	when month_of_absence in (3,4,5) then 'spring'
    when month_of_absence in (6,7,8) then 'summer'
    when month_of_absence in (9,10,11) then 'fall'
    else 'unknown' end as Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
son,
Social_drinker,
Social_smoker,
pet,
Disciplinary_failure,
age,
Work_load_Average_day,
absenteeism_time_in_hours
from absenteeism_at_work a
left join compensation c
on a.ID = c.ID
left join reasons r
on a.Reason_for_absence = r.Number;






