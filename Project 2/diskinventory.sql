/**************************************************************************
* Date          Programmer             Description
*---------    ---------------         ---------------------
*10/8/2021	  JCarr				      Initial Dev of Disk db
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
disk_type_id		int	not null primary key,
description char(10) not null
);


create table genre (
genre_id int not null primary key,
description char(10) not null
);

create table artist_type (
artist_type_id int not null primary key,
description char(10) not null
);

--general tables
create table status (
disk_status_id int not null primary key,
description char(10) not null
);

create table borrower(
borrower_id int not null primary key,
fname char(10) not null,
lname  char(10) not null,
phone  char(10) not null
);

create table artist (
artist_id int not null primary key,
artist_type_id int not null references artist_type(artist_type_id),
description char(10) not null
);


create table disk(
disk_id int not null primary key,
disk_type_id int not null references disk_type(disk_type_id),
disk_status_id int not null references status(disk_status_id),
genre_id int not null references genre(genre_id),
release_date date not null,
cd_name char(10) not null
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



