#1
-- 2query way
SELECT score FROM team WHERE team.name="esteghlal";
SELECT score FROM team WHERE team.name="perspolis";
-- 1query way
SELECT score FROM team WHERE team.name="esteghlal" or team.name="perspolis";

#2
#saving id of saipa in view
CREATE VIEW saipa AS
	SELECT team.id FROM team WHERE team.name="saipa";

#selecting game wich has that id
SELECT * from game WHERE game.id =
    (
    # now extract id from this table wich has most point
    SELECT id FROM
    # create table which contain game id and point as count of scored losed
        (SELECT game.id, game.host_point as point FROM game,saipa WHERE game.guest_team = saipa.id and game.guest_point < game.host_point
        UNION
        SELECT game.id, game.guest_point as point FROM game,saipa WHERE game.host_team = saipa.id and game.guest_point > game.host_point) as bakht
    ORDER BY point DESC LIMIT 1
);

#3
SELECT * FROM team ORDER BY team.score LIMIT 1;

#4
SELECT * FROM team ORDER BY team.score LIMIT 1 DESC;

#5
SELECT team.coach FROM team ORDER BY team.score LIMIT 1;

#6
CREATE VIEW most_score AS
(SELECT game.guest_team, game.host_team , SUM(game.host_point+game.guest_point) as points FROM game GROUP BY game.id ORDER BY points DESC LIMIT 1);

SELECT team.* FROM team,most_score WHERE team.id=most_score.host_team or team.id=most_score.guest_team;

#7
SELECT * FROM team WHERE team.id = 
    (SELECT team_id FROM
    # getting game wich has most score
            (SELECT game.host_team as team_id, game.host_point as point FROM game,saipa WHERE game.guest_point < game.host_point
            UNION
            SELECT game.guest_team as team_id, game.guest_point as point FROM game,saipa WHERE game.guest_point > game.host_point) as bakht
    ORDER BY point LIMIT 1
    );

#8
SELECT * FROM team WHERE team.id = 
    (SELECT team_id FROM
    # getting game wich has most score
            (SELECT game.host_team as team_id, game.host_point as point FROM game,saipa WHERE game.guest_point < game.host_point
            UNION
            SELECT game.guest_team as team_id, game.guest_point as point FROM game,saipa WHERE game.guest_point > game.host_point) as bakht
    ORDER BY point DESC LIMIT 1
    );

#9
SELECT player.name FROM player WHERE player.id = 
(
   SELECT team.captain_id FROM team WHERE team.name = "zob ahan"
);

#10
SELECT player.name from player WHERE player.injury=1 and player.team_id=
(
    SELECT team.id FROM team WHERE team.name = "saih jamegan"
);

#11
SELECT player.name FROM player WHERE player.post="hamle" and player.team_id in
(
    SELECT team.id FROM team WHERE team.in_Asia_league=1
);

#12
SELECT * FROM player WHERE player.in_national_team=1 ORDER BY age LIMIT 1;

#13
SELECT player.name FROM player,team WHERE player.in_national_team=1 and player.team_id = team.id AND team.name="sepid rood";

#14
# null in captian_team_id means player isnt captain
SELECT player.name FROM player WHERE player.captian_team_id<>null;

#15
SELECT * FROM team WHERE team.in_Asia_league=1 AND team.city="tehran";