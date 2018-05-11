#1
with recursive dynasty_pic (dynasty, countries) as (
    select  `event`.dynasty,
        count (*)
from
    `event`,
    pictures,
	countries
where
	pictures.event_id = `event`.eid
    and `event`.country_id = countries.cid
	and countries.`name` = 'Iran'
group by
	`event`.dynasty
);
#2
create view view1 as(
  select
  `event`.title,
  pictures.full_path,
  photographer.full_name,
  countries.name,
  `event`.dynasty
       from
	    (((`event` join pictures on `event`.eid = pictures.event_id)
                        left join photographer on pictures.taken_by=photographer.phid)
                        join countries on `event`.country_id=countries.cid)
		where

);

#3
create trigger deletecountry after delete on countries for each row
begin
delete
from pictures
  where
  pid in
(select pid
from
	 pictures, `event`
where
	 pictures.event_id=`event`.eid
	 and old.cid = `event`.country_id;
)
end;

#4
select * 
from `event`
where
country_id=(select cid from countries where `name`='Iceland')
order by
occured_at, title ;

select dynasty,min(occured_at)
from `event`
where
country_id=(select cid from countries where `name`='Iceland')
group by dynasty;


#5
update `event`
set
	dynasty = case dynasty
	when 'Qaajaar' then 'Ashkanian'
    when 'Ashkanian' then 'Qaajaar'
	Else dynasty
	end;

#6
select avg(photographer.age) as photographers_age_avg
from photographer,
	 pictures,
	 `event`,
	 countries
where
	photographer.phid=pictures.taken_by
	and pictures.event_id=`event`.eid
	and `event`.country_id=countries.cid
	and countries.`name` = 'Brazil'
group by photographer.born_in;

#7
select `event`.dynasty
from
	photographer,
	 pictures,
	 `event`,
	 countries
where
	`event`.eid=pictures.event_id
	and pictures.taken_by=photographer.phid
	and photographer.born_in=countries.cid
	and countries.`name` = 'Mexico'
group by `event`.dynasty
having count(pictures.pid) > 50;