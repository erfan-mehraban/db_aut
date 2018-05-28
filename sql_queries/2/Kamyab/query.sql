# 1
WITH RECURSIVE ev_dyn (eid, dynasty, pid) AS
( SELECT eid, dynasty, pid
  FROM event
    JOIN pictures
      ON event.eid = pictures.event_id
    JOIN countries
      ON event.country_id = countries.cid
    WHERE countries.name = "Iran"
  LIMIT 1
  UNION DISTINCT
  SELECT eid, dynasty, pid
  FROM event
    JOIN pictures
      ON event.eid = pictures.event_id
    JOIN countries
      ON event.country_id = countries.cid
    WHERE countries.name = "Iran"
      WHERE (eid, dynasty, pid) NOT IN (SELECT * FROM ev_dyn)
    LIMIT 1)
SELECT dynasty, COUNT(*) FROM ev_dyn
GROUP BY dynasty;
/*
The query above have syntax error
becuase mysql implemntion of recursive
doesn't supprot limit in recursive member part
and dosen't allow use CTE name (here: ev_dyn) in where clause
*/
WITH RECURSIVE ev_dyn (eid, dynasty, pid) AS
( SELECT eid, dynasty, pid
  FROM event
    JOIN pictures
      ON event.eid = pictures.event_id
    JOIN countries
      ON event.country_id = countries.cid
    WHERE countries.name = "Iran"
  UNION DISTINCT
  SELECT eid, dynasty, pid
  FROM event
    JOIN pictures
      ON event.eid = pictures.event_id
    JOIN countries
      ON event.country_id = countries.cid
    WHERE countries.name = "Iran")
SELECT dynasty, COUNT(*) FROM ev_dyn
GROUP BY dynasty;
/*
The query above runs corecctly
*/

# 2
CREATE VIEW view1
    AS SELECT event.title, pictures.full_path, photographer.full_name AS photographer, countries.name AS country, event.dynasty
    FROM event
      LEFT JOIN countries
        ON event.country_id = countries.cid
      LEFT JOIN pictures
        ON event.eid = pictures.event_id
      LEFT JOIN photographer
        ON pictures.taken_by = photographer.phid;
# DROP VIEW view1;


# 3
DELIMITER $$
CREATE TRIGGER dlt_country
  BEFORE DELETE ON countries
  FOR EACH ROW
  BEGIN
    DELETE FROM pictures
    WHERE pictures.event_id IN (SELECT event.eid
                                FROM event
                                WHERE event.country_id = OLD.cid);
    END $$

CREATE TRIGGER set_null_event
  BEFORE DELETE ON countries
  FOR EACH ROW
  BEGIN
    UPDATE event
    SET country_id = NULL
    WHERE country_id = OLD.cid;
    END $$

CREATE TRIGGER set_null_photographer
  BEFORE DELETE ON countries
  FOR EACH ROW
  BEGIN
    UPDATE photographer
    SET born_in = NULL
    WHERE born_in = OLD.cid;
    END $$
DELIMITER ;

# DROP TRIGGER dlt_country;
# DROP TRIGGER set_null_event;
# DROP TRIGGER set_null_photographer;

# 4
SELECT g.dynasty, MAX(g.occured_at) FROM  (SELECT *
                                            FROM event
                                             JOIN countries
                                               ON event.country_id = countries.cid
                                           ORDER BY event.occured_at, event.title) AS g
GROUP BY dynasty;

# 5
UPDATE event
  SET dynasty = CASE dynasty
                    WHEN "Ashkanian" THEN "Ghajarieh"
                    WHEN "Ghajarieh" THEN "Ashkanian"
                    ELSE dynasty
      END;

# 6
SELECT photographer_country.name, AVG(age) as average
FROM photographer
  JOIN countries AS photographer_country
    ON photographer.born_in = photographer_country.cid
WHERE phid IN (SELECT DISTINCT phid
                FROM photographer
                  JOIN pictures
                    ON photographer.phid = pictures.taken_by
                  JOIN event
                    ON event.eid = pictures.event_id
                  JOIN countries
                    ON event.country_id = countries.cid
    WHERE countries.name = 'Brazil')
GROUP BY photographer_country.cid;

# 7
SELECT dynasty
FROM  event
  JOIN pictures
    ON event.eid = pictures.event_id
WHERE pictures.taken_by IN (SELECT phid
                             FROM photographer, countries
                             WHERE photographer.born_in = countries.cid
                                   AND countries.name = "Mexico")
GROUP BY dynasty
HAVING COUNT(*) > 50;
