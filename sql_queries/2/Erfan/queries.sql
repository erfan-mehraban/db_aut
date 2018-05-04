#1
# Actually it isnt recursive
WITH RECURSIVE SUP_EMP (dynasty, c) AS (
    SELECT
        e.dynasty,
        count (*)
    FROM
        event e join pictures p on p.event_id = e.eid
        join countries c on e.country_id = c.cid
    WHERE
        c.name = "Iran"
    GROUP BY
        e.dynasty;
)
SELECT
    *
FROM
    SUP_EMP;

#2
create view (title, img_path‬‬, photographer_name, country, dynasty) as(
    select
        e.title, p.full_path, ph.full_name, c.name, e.dynasty
    from
        (
            (
                pictures p left join photographer ph on p.taken_by = ph.phid
            )
            join event e on p.event_id = e.eid
        ) join countries c on e.country_id = c.cid
    where

);

#3
create trigger delete_pic_on_countries
after delete on countries
for each row
begin
    delete p from pictures p join event e on p.event_id = e.eid
    where
        OLD.cid = e.country_id;
end;

#4
create view island_events as (
    select *
    from
        event e
        join countries c on e.country_id = c.cid
    where
        c.name = "Island"
    order by
        e.occured_at,
        e.title
);

select *
from island_events i
where
    i.occured_at in(
        select min(ii.occured_at)
        from island_events ii
        group by ii.dynasty
    );

#5
update event
set
    dynasty = CASE WHEN dynasty = "ghajar" THEN "ashkanian" END,
    dynasty = CASE WHEN dynasty = 'ashkanian' THEN 'ghajar' END;

#6
select avg(ph.age)
from
    ((event e join pictures p on p.event_id = e.eid)
    join photographer ph on p.taken_by = ph.phid)
    join countries c on e.country_id = c.cid
where c.name = "brazil"
group by ph.born_in;

#7
select e.dynasty
from
    ((event e join pictures p on p.event_id = e.eid)
    join photographer ph on p.taken_by = ph.phid)
    join countries c on ph.born_in = c.cid
where
    c.name = "mexico"
group by e.dynasty
having count(*) > 50;