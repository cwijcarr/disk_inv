/**************************************************************************
* Date          Programmer             Description
*---------    ---------------         ---------------------
*10/8/2021		JCarr				    Initial Dev of Disk db
*10/15/2021		JCarr					Added Fill Data
*10/22/2021		JCarr					Added Select statements
*10/25/2021		JCarr					Added Procs
*10/27/2021		JCarr					Added more stored procedures
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
description nvarchar(200) 
);


create table genre (
genre_id int not null primary key,
description nvarchar(200) not null
);

create table artist_type (
artist_type_id int not null primary key,
description nvarchar(200) 
);

--general tables
create table status (
disk_status_id int primary key,
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
artist_type_id int references artist_type(artist_type_id),
description nvarchar(200) not null
);


create table disk(
disk_id int primary key,
disk_type_id int references disk_type(disk_type_id),
disk_status_id int references status(disk_status_id),
genre_id int references genre(genre_id),
release_date date not null,
cd_name nvarchar(30) not null
);


create table disk_artist(
disk_artist_id int primary key,
artist_id int references artist(artist_id),
disk_id int references disk(disk_id),


);
create table disk_has_borrower (
borrow_status nvarchar not null,
disk_id int references disk(disk_id),
borrower_id int not null references borrower(borrower_id),
return_date date null,
borrow_date date not null,

);


--Disk name Inserts
INSERT INTO disk
(disk_id, release_date, cd_name)

VALUES

('1','1971','Led Zeppelin IV'),
('2','1973','Dark Side of the Moon'),
('3','1980','Back in Black'),
('4','1971', 'Who is Next'),
('5','1976', 'Hotel California'),
('6','1967', 'The Doors'),
('7','1975', 'Born to Run'),
('8','1975','Wish you Were Here'),
('9','1979','The Wal,'),
('10','1976','Boston'),
('11','1972','Exile on Main Street'),
('12','1966','Revolver'),
('13','1978','Van Halen I'),
('14','1975','A Night at the Opera'),
('15','1975','Physical Graffiti'),
('16','1968','Electric Ladyland'),
('17','1968','The Beatles'),
('18','1969','Abbey Road'),
('19','1971','Sticky Fingers'),
('20','1977','Roumors');



-- Borrower Inserts

Insert INTO artist_type
(artist_type_id, description)
Values
('1','Solo'),
('2', 'Group')

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
(artist_id,description, artist_type_id)


Values
('1', 'Led Zeppelin','2'),
('2','Pink Floyd','1'),
('3', 'AC/DC','2'),
('4', 'The Who','2'),
('5', 'Fleetwood Mac','1'),
('6', 'Eagles','2'),
('7', 'The Doors','2'),
('8', 'Bruce Springsteen','1'),
('9', 'Pink Floyd','1'),
('10', 'Pink Floyd','1'),
('11', 'Boston','2'),
('12', 'The Rolling Stones','2'),
('13', 'The Beatle','2'),
('14', 'Van Halen','1'),
('15', 'Queen','2'),
('16', 'Led Zeppelin','2'),
('17', 'The Jimi Hendrix Experience','2'),
('18', 'The Beatles','2'),
('19', 'The Beatles','2'),
('20', 'The Rolling Stones','2');



--Disk has borrower Insert
INSERT INTO disk_has_borrower
(borrower_id,borrow_status, borrow_date, return_date,disk_id)


VALUES
('1','1','1-1-2012','1-3-2012','1'),
('2','1','1-2-2012','1-4-2012','1'),
('2','1','1-3-2012','1-5-2012','1'),
('4','1','1-4-2012','1-6-2012','1'),
('5','1','1-5-2012','2-7-2012','3'),
('6','1','1-6-2012','2-8-2012','3'),
('7','1','1-7-2012','2-9-2012','3'),
('8','1','1-8-2012','2-10-2012','2'),
('9','1','1-9-2012','3-11-2012','2'),
('10','1','1-10-2012','4-12-2012','5'),
('11','1','1-11-2012','2-13-2012','6'),
('12','2','1-12-2012','5-14-2012','6'),
('13','2','1-13-2012',null ,'6'),
('14','2','1-14-2012',null ,'8'),
('15','2','1-15-2012',null ,'9'),
('16','1','1-16-2012','5-16-2012','9'),
('17','1','1-17-2012','4-17-2012','10'),
('18','1','1-18-2012','4-18-2012','11'),
('19','1','1-19-2012','7-19-2012','11'),
('20','1','1-20-2012','4-20-2012','12');



--Insert Disk Artist
INSERT INTO disk_artist
(disk_id, artist_id, disk_artist_id)


Values
('1','1','1'),
('1','2','2'),
('1','3','3'),
('2','1','4'),
('3','4','5'),
('4','5','6'),
('5','6','7'),
('6','7','8'),
('7','8','9'),
('8','9','10'),
('9','10','11'),
('10','11','12'),
('11','12','13'),
('12','13','14'),
('13','14','15'),
('14','15','16'),
('15','16','17'),
('16','17','18'),
('17','18','19'),
('18','19','20');
;
select borrower_id as Borrower_id, disk_id as Disk_id, 
convert(varchar, borrow_date, 101) as Borrowed_Date, return_date 
as Return_date
From disk_has_borrower
where return_date is null;


  --start Select statements
--3.
SELECT cd_name as 'Disk Name', release_date as 'Release Date', description as 'Artist'
From Disk
Join disk_artist on disk.disk_id = disk_artist.disk_id
join artist on artist.artist_id = disk_artist.disk_artist_id
Where artist_type_id = 1
Order By description
;

--4
DROP VIEW IF EXISTS View_Individual_Artist
go
CREATE view View_Individual_Artist as
Select artist_id, description
from artist
where artist_type_id = 1;
go

Select description
from View_Individual_Artist
;

--5
Select cd_name as 'Disk Name', release_date as 'Release Date', description as 'Artist'
From Disk
Join disk_artist on disk_artist.disk_id = disk.disk_id
join artist on artist.artist_id = disk_artist.artist_id
Where artist_type_id = 2
Order By description
;


--6 
Select cd_name as 'Disk Name', release_date as 'Release Date', description as 'Artist'
From Disk
Join disk_artist on disk_artist.disk_id = disk.disk_id
join artist on artist.artist_id = disk_artist.artist_id
Where artist_type_id = 2   --cant figure it out
Order By description
;
--7
Select cd_name as 'Disk Name', release_date as 'Release Date', fname as 'First', lname as 'Last', borrow_date as 'Borrowed Date', return_date as 'Returned Date'
From disk
join disk_has_borrower on disk.disk_id = disk_has_borrower.disk_id
join borrower on borrower.borrower_id = disk_has_borrower.borrower_id
Where borrow_status = '1'
Order by fname

;
--8


Select disk_has_borrower.disk_id as 'DiskId',cd_name as 'Disk Name',  Count(borrow_status) as 'Times Borrowed'
From disk
join disk_has_borrower on disk.disk_id = disk_has_borrower.disk_id
where borrow_status = 2
group by disk_has_borrower.disk_id, disk.cd_name, borrow_status
order by 'DiskId'
go
;

--9
select cd_name, borrow_date as Borrowed, 
return_date as Returned, lname
from disk_has_borrower
join disk on disk.disk_id = disk_has_borrower.disk_id
join borrower on borrower.borrower_id = disk_has_borrower.borrower_id
where return_date is null
order by cd_name;
go



--1
Drop proc if exists sp_ins_disk_has_borrower
go
create proc sp_ins_disk_has_borrower
	@disk_id int, @borrower_id int, @borrow_date datetime2, 
	@return_date datetime2 = null
	as
	begin try
	insert into disk_has_borrower
	(disk_id, borrower_id, borrow_date, return_date)
	Values
	(@disk_id, @borrower_id, @borrow_date, @return_date);
	end try
	begin catch
		print 'An error occurred. Row was not inserted.';
		print 'Error number: ' + convert(varchar, Error_number());
		print ' Error message: ' + convert(varchar(255), ERROR_MESSAGE());
	END CATCH
	GO
	exec sp_ins_disk_has_borrower 20, 19, '10/15/2021';
	go
	exec sp_ins_disk_has_borrower 20, 19, '10/01/2021', '10/10/2021';
	go
	exec sp_ins_disk_has_borrower 20, 100, '10/04/2021', '10/20/2021';
	go


	--2
Drop proc if exists sp_upd_disk_has_borrower
go
create proc sp_upd_disk_has_borrower
	@disk_has_borrower_id int, @disk_id int, @borrower_id int,
	@borrow_date datetime2, @return_date datetime2 = null
	as
Begin try
update disk_has_borrower
	set disk_id = @disk_id, borrower_id = @borrower_id,
	borrow_date = @borrow_date, return_date = @return_date
	where @disk_has_borrower_id = @disk_has_borrower_id
	end try
	begin catch
		print 'An error occurred. Row was not inserted.';
		print 'Error number: ' + convert(varchar, Error_number());
		print ' Error message: ' + convert(varchar(255), ERROR_MESSAGE());
	END CATCH
	go
	exec sp_upd_disk_has_borrower 22, 1, 11, '1/2/2021', '2/2/2021';
	go
	exec sp_upd_disk_has_borrower 22, 1, 11, '1/1/2021';
	go
	exec sp_upd_disk_has_borrower 22, 1, 1111, '1/1/2021';
	go



-- Project 5 #2
DROP PROC IF EXISTS sp_ins_artist
go

CREATE PROC sp_ins_artist
@description nvarchar(120), @artist_type int

as
Begin Try
INSERT INTO artist
(description, artist_type_id)

Values
(@description, @artist_type);
end try
begin catch
		print 'An error occurred. Data was not inserted.';
		print 'Error number: ' + convert(varchar, Error_number());
		print ' Error message: ' + convert(varchar(255), ERROR_MESSAGE());
	END CATCH
	go

exec sp_ins_artist 'Cher', '1'
go
exec sp_ins_artist 'Jared Letto', '1'
go
exec sp_ins_artist 'Jared Letto', '111111'
go


grant exec on sp_ins_artist to ProjectUserjc;
go
--update artist
DROP PROC IF EXISTS sp_upd_artist
go

CREATE PROC sp_upd_artist
@description nvarchar(120), @artist_type int, @artist_id int

as
Begin Try
UPDATE artist
set description = @description
	,artist_type_id = @artist_type
Where artist_id = @artist_id
end try
begin catch
		print 'An error occurred. Data was not inserted.';
		print 'Error number: ' + convert(varchar, Error_number());
		print ' Error message: ' + convert(varchar(255), ERROR_MESSAGE());
	END CATCH
	go

exec sp_upd_artist 'Update Cher', 1, '23'
go
exec sp_upd_artist 'Jared Letto update', 1, '24'
go
exec sp_upd_artist 'Jared Letto update', 11111, '24'
go
grant exec on sp_upd_artist to ProjectUserjc;


--delete
DROP PROC IF EXISTS sp_del_artist
go

CREATE PROC sp_del_artist
@artist_id int

as
Begin Try
DELETE artist
where artist_id = @artist_id
end try
begin catch
		print 'An error occurred. Data was not deleted.';
		print 'Error number: ' + convert(varchar, Error_number());
		print ' Error message: ' + convert(varchar(255), ERROR_MESSAGE());
	END CATCH
	go

	exec sp_del_artist 24;
	go
	exec sp_del_artist 1;
	go
	
	grant exec on sp_del_artist to ProjectUserjc;
	go



--Part 3 and part 4 couldnt finish in time.
