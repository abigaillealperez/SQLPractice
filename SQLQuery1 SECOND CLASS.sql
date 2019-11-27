--I created this schema at school lol XD
-- CREATE SCHEMA Examples;
-- GO

-- THIS IS A COMMENT

CREATE TABLE Examples.Widget(
	WidgetCode varchar (10) NOT NULL CONSTRAINT PKwidget PRIMARY KEY,
	WidgetName varchar (100) NULL,
	WidgetPrice varchar (10) NULL
);

select* from examples.widget

DROP TABLE Examples.Widget;