CREATE TABLE Students(
	StudentId int PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar (30) NOT NULL
	);

ALTER TABLE Students
	ADD Column1 varchar (20) NULL,
	cOLUMN2 int NULL;

CREATE INDEX Idx_Students ON Students (BirthDate);