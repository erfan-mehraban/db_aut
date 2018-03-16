#1
SELECT MAX(Concert.ticket_price) FROM Concert WHERE Concert.location="Royal Concert Hall";

#2
SELECT Concert.location FROM Concert WHERE Concert.ticket_price>200;

#3
SELECT Audience.* FROM Audience,Attended WHERE Attended.auid=Audience.auid AND Attended.cid="C28";

#4
SELECT Song.* FROM Song,Artist WHERE Artist.name="salar" AND Artist.aid=Song.aid AND Song.sid IN
(
    --song played in borje milad
    SELECT Playedin.sid FROM Playedin, Concert WHERE Concert.location="borje milad" AND Concert.cid = Playedin.cid
);

#5
SELECT Artist.name FROM Artist ORDER BY Artist.age DESC LIMIT 1;

#6
CREATE VIEW Artist_Concert AS
SELECT DISTINCT Artist.aid, Concert.cid FROM Artist, Song, Playedin, Concert WHERE Song.aid=Artist.aid AND
    Playedin.sid=Playedin.cid AND Concert.cid = Playedin.cid AND Song.sid=Playedin.sid;

SELECT AVG(Audience.age) FROM Audience, Attended WHERE Audience.auid=Attended.auid AND Attended.cid IN
(
    SELECT Artist_Concert.cid FROM Artist_Concert, Artist WHERE Artist.name="sirvan" AND Artist_Concert.aid=Artist.aid
);

#7
SELECT Song.title FROM Song, Artist WHERE Song.aid=Artist.aid AND Artist.name="Elvis Presley" AND Song.genre="POP";

#8
SELECT Song.title FROM Song, Artist WHERE Song.aid=Artist.aid AND Artist.country="IRAN" AND Song.genre="ROCK";

#9
SELECT SUM(Concert.ticket_price) FROM Concert, Attended WHERE Concert.cid=Attended.cid AND Concert.location="borje milad"

#10
SELECT DISTINCT Audience.full_name FROM Audience, Concert, Attended WHERE Audience.auid=Attended.auid AND
    Attended.cid=Concert.cid AND Concert.year=2010;

#11
SELECT COUNT(*) FROM Audience, Attended WHERE Audience.auid=Attended.auid AND Attended.cid in
(
	SELECT DISTINCT Concert.cid FROM Concert, Playedin, Song WHERE Playedin.sid=Song.sid AND Playedin.cid=Concert.cid AND Song.title="hobab"
) GROUP BY gender;