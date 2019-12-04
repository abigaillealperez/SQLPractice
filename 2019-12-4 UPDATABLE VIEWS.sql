CREATE TABLE Examples.Gadget
(
	GadgetId int NOT NULL CONSTRAINT PKGadget PRIMARY KEY,
	GadgetNumber char (8) NOT NULL CONSTRAINT AKGadget UNIQUE,
	GadgetType varchar (10) NOT NULL
);
INSERT INTO Examples.Gadget (GadgetId, GadgetNumber, GadgetType)
VALUES (1,'00000001','Electrinic'),
	   (2,'00000002','Manual'),
	   (3,'00000003','Manual');
GO

CREATE VIEW Examples.ElectronicGadget
AS
	SELECT GadgetId, GadgetNumber, GadgetType,
			UPPER(GadgetType) AS UpperGadgetType
	FROM Examples.Gadget
	WHERE GadgetType = 'Electronic';
GO

--COMPARISONS
--LIKE, IN,
--E.G. GadgetType LIKE 'Elec%'
-- % MEANS ANY VALUE
-- = MEANS EQUAL
-- < MEANS LESSER THAN
-- > MEANS GRATER THAN
-- <> OR != BOTH MEANS 'NOT EQUAL'

SELECT ElectronicGadget.GadgetNumber AS FronView, 
		Gadget.GadgetNumber AS FromTable,
		Gadget.GadgetType, ElectronicGadget.UpperGadgetType
FROM Examples.ElectronicGadget
		FULL OUTER JOIN Examples.Gadget
			ON ElectronicGadget.GadgetId = Gadget.GadgetId;
GO

INSERT INTO Examples.ElectronicGadget (GadgetId, GadgetNumber, GadgetType)
VALUES (4,'00000004','Electronic'),
		(5,'00000005','Manual');
GO

--UPDATE THE ROW WE COULD SEE TO VALUES THAT COULD NOT BE SEEN 
UPDATE Examples.ElectronicGadget
SET		GadgetType = 'Manual'
WHERE	GadgetNumber = '00000004';
GO

--Update the row we could NOT see to values that could actually see
UPDATE Examples.ElectronicGadget
SET		GadgetType = 'Electronic'
WHERE	GadgetNumber = '00000005';
GO

--LIMITING WHAT DATA CAN BE ADDED TO A TABLE TROUGH A VIEW BY DDL
ALTER VIEW Examples.ElectronicGadget
AS
		SELECT GadgetId, GadgetNumber, GadgetType,
				UPPER(GadgetType) AS UpperGadgetType
FROM Examples.Gadget
WHERE GadgetType = 'Electronic'
WITH CHECK OPTION;
GO

INSERT INTO Examples.ElectronicGadget (GadgetId, GadgetNumber, GadgetType)
VALUES (6,'00000006','Manual');
GO

INSERT INTO Examples.ElectronicGadget (GadgetId, GadgetNumber, GadgetType)
VALUES (6,'00000006','Electronic');
GO

UPDATE Examples.ElectronicGadget
SET GadgetType = 'Manual'
WHERE GadgetNumber = '00000004';
GO



