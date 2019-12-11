--2019-12-10
--USING FORENING KEY CONSTRAINTS TO ENFORCE RELATIONSHIPS
CREATE TABLE Examples.Parent
(
	ParentId	int NOT NULL CONSTRAINT PKParent PRIMARY KEY
);

SELECT * FROM Examples.Parent;

CREATE TABLE Examples.Child
(
	ChildId int NOT NULL CONSTRAINT PHChild PRIMARY KEY,
	ParentId int NULL
);

SELECT * FROM Examples.Child

ALTER TABLE Examples.Child
	ADD CONSTRAINT FKChild_Ref_ExamplesParent
		FOREIGN KEY (ParentId) REFERENCES Examples.Parent(ParentId);

INSERT INTO Examples.Parent VALUES (10);

INSERT INTO Examples.Child VALUES (1, 10);

SELECT * FROM Examples.Parent;
SELECT * FROM Examples.Child;

--IMPORTANTE PARA PONER VALORES EN LA TABLAS, CHECAR ESTO A DETALLE
CREATE TABLE Examples.TwoPartKey
(
	KeyColumn1 int NOT NULL,
	KeyColumn2 int NOT NULL,
	CONSTRAINT PFTwoPartKey PRIMARY KEY (KeyColumn1, KeyColumn2)
);

SELECT * FROM Examples.TwoPartKey;

--AQUI EL PRIMER VALOR ES LA PRIMER COLUMNA
INSERT INTO Examples.TwoPartKey VALUES (10, 10); --ID = 1010

SELECT * FROM Examples.TwoPartKey;

DROP TABLE IF EXISTS Examples.TwoPartKeyReference
CREATE TABLE Examples.TwoPartKeyReference
(
	KeyColumn1 int NOT NULL,
	KeyColumn2 int NOT NULL,
	CONSTRAINT FKTwoPartKeyReference_Ref_ExamplesTwoPartKey
		FOREIGN KEY (KeyColumn1, KeyColumn2)
			REFERENCES Examples.TwoPartKey (KeyColumn1, KeyColumn2)
);

SELECT * FROM Examples.TwoPartKeyReference;

--EN EL LIBRO LO PONE TODO EN UNA PARTE PARA MAS PRACTICA SE PONE EN DOS LINEAS
INSERT INTO Examples.TwoPartKeyReference VALUES (10, 10);
INSERT INTO Examples.TwoPartKeyReference VALUES (NULL, NULL);

SELECT * FROM Examples.TwoPartKeyReference;



CREATE TABLE Examples.Invoice
(
	InvoiceId	int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY
);

CREATE TABLE Examples.InvoiceLineItem
(
	InvoiceLineItemId int NOT NULL CONSTRAINT PHInvoiceLineItem PRIMARY KEY,
	InvoiceLineNumber smallint NOT NULL,
	InvoiceId	int	NOT NULL
		CONSTRAINT FKInvoiceLineItem_Ref_ExamplesInvoice
			REFERENCES Examples.invoice(InvoiceId)
				ON DELETE CASCADE
				ON UPDATE NO ACTION,
		CONSTRAINT AKInvoiceLineItem UNIQUE (InvoiceId, InvoiceLineNumber)
);

INSERT INTO Examples.Invoice(InvoiceId)
VALUES (1),(2),(3);
INSERT INTO Examples.InvoiceLineItem(InvoiceLineItemId, InvoiceId, InvoiceLineNumber)
VALUES (1,1,1),(2,1,2),(3,2,1);

SELECT Invoice.InvoiceId, InvoiceLineItem.InvoiceLineItemId
FROM Examples.Invoice
		FULL OUTER JOIN Examples.InvoiceLineitem
			ON Invoice.InvoiceId = InvoiceLineItem.InvoiceId;

DELETE Examples.Invoice
WHERE InvoiceId = 1;

CREATE TABLE Examples.Code
(
	Code	varchar(10) NOT NULL CONSTRAINT PKCode PRIMARY KEY
);

CREATE TABLE Examples.CodedItem
(
	Code	varchar(10) NOT NULL
		CONSTRAINT FKCodedItem_Ref_ExampleCode
			REFERENCES Examples.Code (Code)
				ON UPDATE CASCADE
);

INSERT INTO Examples.Code (Code)
VALUES ('Blacke');
INSERT INTO Examples.CodedItem (Code)
VALUES ('Blacke');

SELECT Code.Code, CodedItem.Code AS CodedItemCode
FROM Examples.Code
		FULL OUTER JOIN Examples.CodedItem
			ON Code.Code = CodedItem.Code;

UPDATE Examples.Code
SET Code = 'Black';

SELECT * FROM Examples.Code


-- limiting a column toi a set of values
DROP TABLE Examples.Attendee

CREATE TABLE Examples.Attendee
(
	ShirtSize varchar(10) NULL
);

SELECT * FROM Examples.Attendee;

ALTER TABLE Examples.Attendee
	 ADD CONSTRAINT CHKAttendee_ShirtSizeDomain
			CHECK (ShirtSize in ('S', 'M', 'L', 'XL', 'XXL'));

SELECT * FROM Examples.Attendee;

INSERT INTO Examples.Attendee (ShirtSize)
VALUES ('XS');

CREATE TABLE Examples.ShirtSize
(
	ShirtSize varchar(10) NOT NULL CONSTRAINT PKShirtSize PRIMARY KEY
);

INSERT INTO Examples.ShirtSize(ShirtSize)
VALUES ('S'),('M'),('L'),('XL'),('XXL');

SELECT * FROM Examples.ShirtSize

ALTER TABLE Examples.Attendee
	DROP CONSTRAINT CHKAttendee_ShirtSizeDomain;

ALTER TABLE Examples.attendee
	ADD CONSTRAINT FKAttendee_Ref_ExamplesShirtsize
		FOREIGN KEY (ShirtSize) REFERENCES Examples.ShirtSize(ShirtSize);

INSERT INTO Examples.Attendee
VALUES ('XS');