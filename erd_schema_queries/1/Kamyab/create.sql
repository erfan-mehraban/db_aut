CREATE TABLE attend
(
  pid INT NOT NULL,
  tid INT NOT NULL,
  PRIMARY KEY (pid, tid)
)
  ENGINE = InnoDB;

CREATE INDEX attend_teams_tid_fk
  ON attend (tid);

CREATE TABLE injuries
(
  pid        INT  NOT NULL,
  date_from  DATE NOT NULL,
  date_until DATE NULL,
  PRIMARY KEY (pid, date_from)
)
  ENGINE = InnoDB;

CREATE TABLE matches
(
  mid        INT AUTO_INCREMENT
    PRIMARY KEY,
  mdate      DATE NULL,
  host       INT  NULL,
  guest      INT  NULL,
  host_goal  INT  NULL,
  guest_goal INT  NULL
)
  ENGINE = InnoDB;

CREATE INDEX matches_teams_tid_fk
  ON matches (host);

CREATE INDEX matches_teams_tid_fk_2
  ON matches (guest);

CREATE TABLE players
(
  pid         INT AUTO_INCREMENT
    PRIMARY KEY,
  pname       VARCHAR(30)            NULL,
  age         INT                    NULL,
  position    VARCHAR(30)            NULL,
  is_capitan  TINYINT(1) DEFAULT '0' NULL,
  is_national TINYINT(1) DEFAULT '0' NULL
)
  ENGINE = InnoDB;

ALTER TABLE attend
  ADD CONSTRAINT attend_players_pid_fk
FOREIGN KEY (pid) REFERENCES players (pid);

ALTER TABLE injuries
  ADD CONSTRAINT table_name_players_pid_fk
FOREIGN KEY (pid) REFERENCES players (pid);

CREATE TABLE teams
(
  tid     INT AUTO_INCREMENT
    PRIMARY KEY,
  tname   VARCHAR(30)            NULL,
  city    VARCHAR(30)            NULL,
  coach   VARCHAR(30)            NULL,
  points  INT DEFAULT '0'        NULL,
  in_asia TINYINT(1) DEFAULT '0' NULL
)
  ENGINE = InnoDB;

ALTER TABLE attend
  ADD CONSTRAINT attend_teams_tid_fk
FOREIGN KEY (tid) REFERENCES teams (tid);

ALTER TABLE matches
  ADD CONSTRAINT matches_teams_tid_fk
FOREIGN KEY (host) REFERENCES teams (tid);

ALTER TABLE matches
  ADD CONSTRAINT matches_teams_tid_fk_2
FOREIGN KEY (guest) REFERENCES teams (tid);

