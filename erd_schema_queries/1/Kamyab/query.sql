# 1
SELECT tname,points FROM teams WHERE tname = "Esteghlal" OR tname ="Perspolis";

# 2

SELECT matches.mid,matches.mdate FROM matches,teams WHERE (teams.tname="Saipa" AND matches.host = teams.tid
  AND matches.host_goal<matches.guest_goal
  AND matches.guest_goal = (SELECT MAX(max_goal) FROM
  (  (SELECT MAX(guest_goal) AS max_goal FROM matches WHERE
  mid IN (SELECT matches.mid FROM matches,teams WHERE teams.tname="Saipa" AND matches.host = teams.tid)
  AND matches.host_goal<matches.guest_goal)
UNION
(SELECT MAX(host_goal) AS max_goal FROM matches WHERE
  mid IN (SELECT matches.mid FROM matches, teams WHERE teams.tname="Saipa" AND matches.guest = teams.tid)
  AND matches.guest_goal< matches.host_goal) ) AS mmax ) )

                                  OR

  (teams.tname="Saipa" AND matches.guest = teams.tid
  AND matches.host_goal > matches.guest_goal
  AND matches.host_goal =
      (SELECT MAX(max_goal) FROM
  (  (SELECT MAX(guest_goal) AS max_goal FROM matches WHERE
  mid IN (SELECT matches.mid FROM matches,teams WHERE teams.tname="Saipa" AND matches.host = teams.tid)
  AND matches.host_goal<matches.guest_goal)
UNION
(SELECT MAX(host_goal) AS max_goal FROM matches WHERE
  mid IN (SELECT matches.mid FROM matches, teams WHERE teams.tname="Saipa" AND matches.guest = teams.tid)
  AND matches.guest_goal< matches.host_goal) ) AS mmax ) );

# 3
SELECT tname FROM teams WHERE points = (SELECT MIN(points) FROM teams);

# 4
SELECT tname FROM teams WHERE points = (SELECT MAX(points) FROM teams);

# 5
SELECT coach FROM teams WHERE points = (SELECT MAX(points) FROM teams);

# 6
SELECT tname FROM teams JOIN ( SELECT host,guest FROM matches ORDER BY matches.host_goal + matches.guest_goal DESC LIMIT 1) as g
WHERE g.host = teams.tid OR g.guest = teams.tid;

# 7
SELECT team FROM
  (SELECT teams.tname AS team, SUM(matches.guest_goal) AS goals FROM matches,teams WHERE matches.host = teams.tid GROUP BY matches.host
UNION ALL
SELECT teams.tname AS team, SUM(matches.host_goal) AS goals FROM matches,teams WHERE matches.guest = teams.tid GROUP BY matches.guest ) AS sum_goal
GROUP BY team ORDER BY SUM(goals) DESC LIMIT 1;

# 8
SELECT team, SUM(goals) FROM
  (SELECT teams.tname AS team, SUM(matches.host_goal) AS goals FROM matches,teams WHERE matches.host = teams.tid GROUP BY matches.host
UNION ALL
SELECT teams.tname AS team, SUM(matches.guest_goal) AS goals FROM matches,teams WHERE matches.guest = teams.tid GROUP BY matches.guest ) AS sum_goal
GROUP BY team ORDER BY SUM(goals) DESC LIMIT 1;

# 9
SELECT pname FROM players,attend,teams WHERE teams.tname="Zob Ahan" AND teams.tid= attend.tid AND players.is_capitan = TRUE AND players.pid= attend.pid;

# 10
SELECT pname FROM players,injuries WHERE players.pid IN (SELECT attend.pid FROM attend, teams WHERE teams.tname= "Siah Jamegan" AND teams.tid = attend.tid) AND players.pid=injuries.pid;

# 11
SELECT players.pname FROM players,teams,attend WHERE players.pid = attend.pid AND attend.tid = teams.tid AND teams.in_asia = TRUE AND players.position = "Forward";

# 13
SELECT pname FROM players WHERE is_national = TRUE ORDER BY age LIMIT 1;

# 14
SELECT players.pname FROM players,teams,attend WHERE players.pid = attend.pid AND attend.tid = teams.tid AND teams.tname = "Sepid Rud" AND players.is_national = TRUE ;

# 15
SELECT pname FROM players WHERE players.is_capitan= TRUE;

# 16
SELECT tname FROM teams WHERE city="Tehran" AND in_asia = TRUE;
