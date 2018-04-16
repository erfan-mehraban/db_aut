CREATE TABLE Artist
(
  aid     INT AUTO_INCREMENT
    PRIMARY KEY,
  name    VARCHAR(30)     NULL,
  country VARCHAR(30)     NULL,
  age     INT             NULL,
  gender  ENUM ('M', 'F') NULL
)
  ENGINE = InnoDB;

CREATE TABLE Attended
(
  auid INT NOT NULL,
  cid  INT NOT NULL,
  PRIMARY KEY (auid, cid)
)
  ENGINE = InnoDB;

CREATE INDEX cid
  ON Attended (cid);

CREATE TABLE Audience
(
  auid      INT AUTO_INCREMENT
    PRIMARY KEY,
  full_name VARCHAR(50)     NULL,
  age       INT             NULL,
  gender    ENUM ('M', 'F') NULL
)
  ENGINE = InnoDB;

ALTER TABLE Attended
  ADD CONSTRAINT attended_ibfk_2
FOREIGN KEY (auid) REFERENCES Audience (auid);

CREATE TABLE Concert
(
  cid          INT AUTO_INCREMENT
    PRIMARY KEY,
  location     VARCHAR(30) NULL,
  ticket_price INT         NULL,
  year         INT         NULL
)
  ENGINE = InnoDB;

ALTER TABLE Attended
  ADD CONSTRAINT attended_ibfk_1
FOREIGN KEY (cid) REFERENCES Concert (cid);

CREATE TABLE Playedin
(
  sid INT NOT NULL,
  cid INT NOT NULL,
  PRIMARY KEY (sid, cid),
  CONSTRAINT Playedin_Concert_cid_fk
  FOREIGN KEY (cid) REFERENCES Concert (cid)
)
  ENGINE = InnoDB;

CREATE INDEX Playedin_Concert_cid_fk
  ON Playedin (cid);

CREATE TABLE Song
(
  sid      INT AUTO_INCREMENT
    PRIMARY KEY,
  title    VARCHAR(30) NULL,
  aid      INT         NULL,
  genre    VARCHAR(30) NULL,
  duration INT         NULL,
  CONSTRAINT aid
  FOREIGN KEY (aid) REFERENCES Artist (aid)
)
  ENGINE = InnoDB;

CREATE INDEX aid
  ON Song (aid);

ALTER TABLE Playedin
  ADD CONSTRAINT Playedin_Song_sid_fk
FOREIGN KEY (sid) REFERENCES Song (sid);

