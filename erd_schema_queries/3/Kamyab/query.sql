# 1
SELECT ticket_price FROM Concert WHERE location="Royal concert Hall" ORDER BY ticket_price DESC LIMIT 1;

# 2
SELECT DISTINCT location FROM Concert C WHERE (SELECT COUNT(*) FROM Attended A WHERE A.cid = C.cid)*C.ticket_price > 200;

# 3
SELECT A.full_name FROM Audience A, Attended AA WHERE A.auid = AA.auid AND AA.cid="C28";

# 4
SELECT S.title FROM Song S, Artist A, Concert C, Playedin P WHERE S.aid = A.aid AND C.location= "Borj Milad" AND S.sid = P.sid AND C.cid = P.cid AND A.name="Salar Aghili";

# 5
SELECT name FROM Artist WHERE country="Russia" ORDER BY age DESC LIMIT 1;

# 6
SELECT AVG(Au.age) FROM Audience Au, Artist A, Attended At, Concert C, Playedin P, Song S 
    WHERE Au.auid = At.auid AND At.cid = P.cid AND P.sid = S.sid AND S.aid = A.aid AND a.name="Sirvan Khosravi";

# 7
SELECT S.title FROM Song S, Artist A WHERE A.name="Elvis Presley" AND a.aid = S.aid AND S.genre="Pop";

# 8
SELECT S.title FROM Song S, Artist A WHERE A.country="Iran" And S.genre="Rock" AND S.aid = A.aid;

# 9
SELECT  SUM(C.ticket_price) FROM Concert C, Attended A WHERE A.cid = C.cid AND C.location="Borj Milad";

# 10
SELECT A.full_name FROM Audience A, Attended At, Concert C WHERE c.year = 2010 AND c.cid = At.cid AND At.auid= A.auid;

# 11
SELECT COUNT(*), Au.gender FROM Audience Au, Artist A, Attended At, Playedin P, Song S
    WHERE Au.auid = At.auid AND At.cid = P.cid AND P.sid = S.sid AND S.title = "Hobab" AND S.aid = A.aid AND A.name="Mohsen Yeganeh" GROUP BY Au.gender;