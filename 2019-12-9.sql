--2019-12-9
DROP TABLE IF EXISTS Examples.Gadget;
CREATE TABLE Examples.Gadget
(
		GadgetId INT identity(1,1) NOT NULL CONSTRAINT PKGagdet PRIMARY KEY,
		GadgetCode varchar(10) NOT NULL
);
INSERT INTO Examples.Gadget (GadgetCode)
VALUES ('LENOVO-101');

SELECT * FROM examples.Gadget;

DELETE FROM Examples.Gadget WHERE GadgetId >= 2;

ALTER TABLE Examples.gadget ADD CONSTRAINT AKGadget UNIQUE (GadgetCode);

SELECT * FROM Examples.Gadget;

CREATE TABLE Examples.GroceryItem
(
	ItemCost smallmoney NULL,
	CONSTRAINT CHKGroceryItem_ItemCostRange
		CHECK (ItemCost > 0 AND ItemCost < 1000)
);

SELECT * FROM Examples.GroceryItem;

DROP TABLE Examples.GroceryItem;

CREATE TABLE Examples.GroceryItem
(
	ItemId int IDENTITY(1,1) PRIMARY KEY,
	ItemDescr varchar(200) NOT NULL,
	ItemCost smallmoney NULL,
	CONSTRAINT CHKGroceryItem_ItemCostRange
		CHECK (ItemCost > 0 AND ItemCost < 1000)
);

SELECT * FROM Examples.GroceryItem;

CREATE TABLE Examples.Message
(
	MessageTag char(5) NOT NULL,
	Comment nvarchar (MAX) NULL
);

ALTER TABLE Examples.Message
	ADD CONSTRAINT chkmESSAGE_mESSAGEtAGfORMAT
	check (MessageTag LIKE '[A-Z]-[0-9][0-9][0-9]');

	ALTER TABLE Examples.Message
		ADD CONSTRAINT CHKMessage_CommentNotEmpty
		CHECK (LEN(Comment) > 0);

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('nope', '');

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('A-001', '');

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('A-001', 'This is a comment');