/**************************************************************************
* Date          Programmer             Description
*---------    ---------------         ---------------------
*10/8/2021	  JCarr				      Initial Dev of Disk db
*10/15/2021	  JCarr					  Added Fill Data
*
***************************************************************************/
-- drop & create database
use master;
drop database if exists disk_inventoryjc;
go
create database disk_inventoryjc;
go

use disk_inventoryjc;
go
--create server login
if suser_id('ProjectUserJC') IS NOT NULL
drop login ProjectUserJC;
go
create login ProjectUserJC with password ='MSPress#1',
	default_database = disk_inventoryjc;
	go
use disk_inventoryjc;
go
create user ProjectUserJC;
go
alter role db_datareader add member ProjectUserJC;
go

-- create lookup tables
create table disk_type(
disk_type_id int not null primary key,
description nvarchar(200) not null
);


create table genre (
genre_id int not null primary key,
description nvarchar(200) not null
);

create table artist_type (
artist_type_id int not null primary key,
description nvarchar(200) not null
);

--general tables
create table status (
disk_status_id int not null primary key,
description nvarchar(200) not null
);

create table borrower(
borrower_id int not null primary key,
fname nvarchar(20) not null,
lname  nvarchar(20) not null,
phone  nvarchar(12) not null
);

create table artist (
artist_id int not null primary key,
artist_type_id int not null references artist_type(artist_type_id),
description nvarchar(200) not null
);


create table disk(
disk_id int not null primary key,
disk_type_id int not null references disk_type(disk_type_id),
disk_status_id int not null references status(disk_status_id),
genre_id int not null references genre(genre_id),
release_date date not null,
cd_name nvarchar(30) not null
);


create table disk_artist(
disk_artist_id int not null primary key,
artist_id int not null references artist(artist_id),
disk_id int not null references disk(disk_id),


);
create table disk_has_borrower (
borrow_status int not null primary key,
disk_id int not null references disk(disk_id),
borrower_id int not null references borrower(borrower_id),
return_date date null,
borrow_date date not null,

);


--Disk name Inserts
INSERT INTO disk
(disk_id, disk_type_id, disk_status_id, genre_id, release_date, cd_name)

VALUES

('1','1','1','1','1971','Led Zeppelin IV'),
('1','1','1','1','1973','Dark Side of the Moon'),
('1','1','1','1','1980','Back in Black'),
('1','1','1','1','1971', 'Who is Next'),
('1','1','1','1','1976', 'Hotel California'),
('1','1','1','1','1967', 'The Doors'),
('1','1','1','1','1975', 'Born to Run'),
('1','1','1','1','1975','Wish you Were Here'),
('1','1','1','1','1979','The Wal,'),
('1','1','1','1','1976','Boston'),
('1','1','1','1','1972','Exile on Main Street'),
('1','1','1','1','1966','Revolver'),
('1','1','1','1','1978','Van Halen I'),
('1','1','1','1','1975','A Night at the Opera'),
('1','1','1','1','1975','Physical Graffiti'),
('1','1','1','1','1968','Electric Ladyland'),
('1','1','1','1','1968','The Beatles'),
('1','1','1','1','1969','Abbey Road'),
('1','1','1','1','1971','Sticky Fingers'),
('1','1','1','1','1977','Roumors');



-- Borrower Inserts
INSERT INTO borrower
(fname, lname, phone, borrower_id)



VALUES
('CWI','Red','1234567890','1'),
('CWI','Blue','1234567890','2'),
('CWI','Black','1234567890','3'),
('CWI','White','1234567890','4'),
('CWI','Orange','1234567890','5'),
('CWI','Pink','1234567890','6'),
('CWI','Purple','1234567890','7'),
('CWI','Yellow','1234567890','8'),
('CWI','Green','1234567890','9'),
('CWI','Brown','1234567890','10'),
('CWI','Burnt Sienna','1234567890','11'),
('CWI','Sky Blue','1234567890','12'),
('CWI','Blood Orange','1234567890','13'),
('CWI','Cobalt','1234567890','14'),
('CWI','Saffron','1234567890','15'),
('CWI','Forrest Green','1234567890','16'),
('CWI','Titanium White','1234567890','17'),
('CWI','Aero','1234567890','18'),
('CWI','Alice','1234567890','19'),
('CWI','Amethyst','1234567890','20');




--Artist Inserts
INSERT INTO artist
(artist_id, artist_type_id,description)


Values
('1', '1', 'Led Zeppelin'),
('2', '1', 'Pink Floyd'),
('3', '1', 'AC/DC'),
('4', '1', 'The Who'),
('5', '1', 'Fleetwood Mac'),
('6', '1', 'Eagles'),
('7', '1', 'The Doors'),
('8', '1', 'Bruce Springsteen'),
('9', '1', 'Pink Floyd'),
('10', '1', 'Pink Floyd'),
('11', '1', 'Boston'),
('12', '1', 'The Rolling Stones'),
('13', '1', 'The Beatle'),
('14', '1', 'Van Halen'),
('15', '1', 'Queen'),
('16', '1', 'Led Zeppelin'),
('17', '1', 'The Jimi Hendrix Experience'),
('18', '1', 'The Beatles'),
('19', '1', 'The Beatles'),
('20', '1', 'The Rolling Stones');



--Disk has borrower Insert
INSERT INTO disk_has_borrower
(borrower_id,borrow_status, borrow_date, return_date, disk_id)


VALUES
('1','1','1-24-2012','1-26-2012','1'),
('2','1','1-4-2012','1-6-2012','12'),
('2','1','1-5-2012','1-7-2012','12'),
('4','1','1-8-2012','1-9-2012','15'),
('5','1','1-22-2012','2-2-2012','13'),
('6','1','1-25-2012','2-2-2012','11'),
('7','1','1-28-2012','2-2-2012','18'),
('8','1','1-27-2012','2-2-2012','16'),
('9','1','1-26-2012','3-2-2012','17'),
('10','1','1-25-2012','4-2-2012','19'),
('11','1','1-21-2012','2-2-2012','2'),
('12','1','1-23-2012','5-2-2012','4'),
('13','1','1-29-2012','2-2-2012','3'),
('14','1','1-2-2012','','5'),
('15','1','1-6-2012','','6'),
('16','1','1-8-2012','5-2-2012','7'),
('17','1','1-3-2012','4-2-2012','8'),
('18','1','1-7-2012','4-2-2012','9'),
('19','1','1-3-2012','7-2-2012','10'),
('20','1','1-2-2012','4-2-2012','20');



--Insert Disk Artist
INSERT INTO disk_artist
(disk_artist_id, disk_id, artist_id)



Values
('1','1','1'),
('2','1','2'),
('3','1','3'),
('4','2','1'),
('5','3','4'),
('6','4','5'),
('7','5','6'),
('8','6','7'),
('9','7','8'),
('10','8','9'),
('11','9','10'),
('12','10','11'),
('13','11','12'),
('14','12','13'),
('15','13','14'),
('16','14','15'),
('17','15','16'),
('18','16','17'),
('19','17','18'),
('20','18','19');