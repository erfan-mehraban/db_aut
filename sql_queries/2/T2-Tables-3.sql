create table countries(
	cid int primary key,
    `name` varchar(80)
);
create table `event`(
	eid int primary key,
    title varchar(60),
    country_id int,
    dynasty varchar(60),
    occured_at DATETIME,
    foreign key (country_id) references countries(cid)
);
create table photographer(
	phid int primary key,
    full_name VARCHAR(255),
    born_in INT,
    age INT,
    foreign key(born_in) references countries(cid)
);
create table pictures(
	pid int primary key,
    full_path varchar(255),
    event_id int,
    taken_by int references photographer(phid),
    foreign key(event_id) references `event`(eid)
);