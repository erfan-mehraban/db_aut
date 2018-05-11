USE HW2_2;

#############################################################

#با استفاده از یک کوئری بازگشتی، تعداد عکس‌های مربوط به وقایع هر سلسله‌ی ایران (dynasty) را بدست آورید.


WITH recursive DYN(D_pid, D_dynasty) AS
(
SELECT pid, dynasty FROM (pictures JOIN EVENT ON eid = event_id) WHERE country_id IN
(
SELECT cid FROM countries WHERE countries.name="Iran"
) LIMIT 1
UNION
SELECT pid, dynasty FROM (pictures JOIN EVENT ON eid = event_id) WHERE pid NOT IN
(
SELECT D_pid FROM DYN
)
)
SELECT
  DYN.dynasty,
  DYN.count(*)
FROM DYN
GROUP BY dynasty;

#############################################################

#یک view (جدول مجازی) بسازید که مقادیر زیر فیلدهای آن باشند.

CREATE VIEW Sec2 AS
  SELECT
    title,
    full_path,
    full_name,
    countries.name,
    dynasty
  FROM (((pictures
    LEFT JOIN photographer ON taken_by = phid) JOIN event ON event_id = eid) JOIN countries ON country_id = cid)

#############################################################

#یک trigger طراحی کنید که باعث شود هرگاه یک کشور حذف شد، تمامی عکس‌های مربوط به آن نیز حذف گردد.

CREATE TRIGGER del_cou
  AFTER DELETE
  ON countries
  FOR EACH ROW
  BEGIN
    DELETE pictures.* FROM pictures
    WHERE event_id IN
          (
            SELECT eid
            FROM event
            WHERE country_id = OLD.cid
          );
  END;

#############################################################

/*
وقایع کشور ایسلند را ابتدا بر اساس زمان رخداد و سپس بر اساس عنوان آن‌ها مرتب کنید.
 سپس نتیجه را بر اساس سلسله‌ها گروه‌بندی نمایید و از هر گروه، کهن‌ترین رخداد را تحویل دهید.
*/

SELECT *
FROM event
WHERE occured_at IN
      (
        SELECT min(occured_at)
        FROM (SELECT e.*
              FROM event e
              WHERE country_id IN
                    (
                      SELECT cid
                      FROM countries
                      WHERE countries.name = "Iceland"
                    )
              ORDER BY occured_at, title) AS e2
        GROUP BY dynasty
      );

#############################################################
/*
در پایگاه داده‌‌ی فعلی، برخی عکس‌ها به درستی به وقایع مرتبط نشده‌اند. عکس‌های مربوط به آثار سلسله اشکانیان، به سلسله قاجار مرتبط شده
 و عکس‌های آثار سلسه قاجار نیز به سلسله اشکانیان مرتبط شده‌اند. کوئری (یا کوئری‌هایی) بنویسید که این اشتباهات را اصلاح نمایند.
*/

UPDATE event
SET dynasty = "ashk"
WHERE dynasty = "ghaajar";
UPDATE event
SET dynasty = "ghaajar"
WHERE dynasty = "ashkanian";
UPDATE event
SET dynasty = "ashkanian"
WHERE dynasty = "ashk";

#############################################################

#میانگین سنی عکاسان متولد هر کشور را که از کشور برزیل عکسی ثبت نموده‌اند، به دست آورید.

SELECT
  countries.name,
  avg(age)
FROM (countries
  JOIN photographer ON countries.cid = photographer.born_in)
WHERE phid IN
      (
        SELECT taken_by
        FROM pictures
        WHERE event_id IN
              (
                SELECT eid
                FROM event
                WHERE country_id IN
                      (
                        SELECT cid
                        FROM countries
                        WHERE countries.name = "Brazil"
                      )
              )
      )
GROUP BY photographer.born_in;

#############################################################
# اسامی تمامی سلسله‌هایی را بدست آورید که عکاسان اهل مکزیک، حداقل 50 عکس از وقایع آن‌ها ثبت نموده‌اند. اسامی تمامی سلسله‌هایی را بدست آورید که عکاسان اهل مکزیک، حداقل 50 عکس از وقایع آن‌ها ثبت نموده‌اند.

SELECT dynasty
FROM ((event
  JOIN pictures ON event.eid = pictures.event_id) JOIN photographer ON taken_by = phid)
WHERE born_in IN
      (
        SELECT cid
        FROM countries
        WHERE countries.name = "Mexico"
      )
GROUP BY dynasty
HAVING count(*) > 50;