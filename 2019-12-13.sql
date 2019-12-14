--2019-12-12
--2019-12-12
--IMPLEMENTING ERROR HANDLING AND CONTROL LOGIC
--THROW ERROR

CREATE PROCEDURE Examples.HandlingErrors
AS
	DECLARE @NoOp int = 0;
	THROW 50000, 'An error has ocured!', 1;
GO

EXEC Examples.HandlingErrors;

--THROW EXAMPLE
CREATE PROCEDURE Examples.StopBatchError
AS
--BATCH IS FROM DECLARE TO SELECT PART
	DECLARE @NoOp int = 100;
	THROW 50000, 'Batch Stopped!', 1;
	SELECT @NoOp, SYSDATETIME();
	GO

--RAISERROR EXAMPLE
CREATE PROCEDURE Examples.ContinueBatchError 
AS
	declare @NoOp int = 100;
	RAISERROR ('Batch Continued!', 16, 1);
	SELECT @NoOp, SYSDATETIME();
GO

EXEC Examples.StopBatchError;
EXEC Examples.ContinueBatchError;

--transaction control logic in your error handling
CREATE TABLE Examples.Worker
(
	WorkerId int NOT NULL IDENTITY(1,) CONSTRAINT PKWorker PRIMARY KEY,
	WorkerName nvarchar(50) NOT NULL CONSTRAINT AKWorker UNIQUE
);

CREATE TABLE Examples.WorkerAssigment
(
	WorkerAssigmentId int IDENTITY(1,1) CONSTRAINT PKWorkerAssigment PRIMARY KEY,
	WorkerId int NOT NULL,
	CompanyName nvarchar(50) NOT NULL
		CONSTRAINT CHKWorkerAssigment_CompanyName
			CHECK (CompanyName <> 'Contoso, Ltd.'),
		CONSTRAINT AKWorkerAssigment UNIQUE (WorkerId, CompanyName)
);

CREATE PROCEDURE Examples.Worker_AddWithAssigment
	@WorkerName nvarchar(50),
	@CompanyName nvarchar(50)
AS
	SET NOCOUNT ON;
	--DO ANY NO DATA TESTING BEFORE STARTING THE TRANSACTION
	IF @WorkerName IS NULL OR @CompanyName IS NULL
		THROW 5000,'Both parameters must be not null', 1);

		DECLARE @Location nvarchar(30), @NewWorkerId int;
		BEGIN TRY
			BEGIN TRANSACTION

			SET @Location ='Creating Worker Row';
			INSERT INTO Examples.WorkerAssigment(WorkerName)
			VALUES (@WorkerName);

			SELECT @NewWorkerId = SCOPE_IDENTITY(),
				@Location = 'Creating WorkAssigment Row';

			INSERT INTO Examples.WorkerAssigment(WorkerId, CompanyName)
			VALUES (@NewWorkerId, @CompanyName);

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			--AT THE END OF THE CALL, WE WANT THE TRANSACTION ROLLED BACK
			--ROLLBACK THE TRANSACTION FIRST, SO IT DEFINITELY OCCURS AS THE THROW
			--STATEMENT WOULD KEEP IT FROM HAPPENING
			IF XACT_STATE() <> 0 --IF THEREIS A TRANSACTION IN EFFECT
				ROLLBACK TRANSACTION;

			--FORMAT A MESSAGE THAT TELLS THE ERROR AND THEN THROW IT.
			DECLARE @ErrorMessage nvarchar(4000);
			SET @ErrorMessage = CONCAT('Error Ocurred Durring: ''',@Location,'''',
										'System Error: ',
										ERROR_NUMBER(), ':',ERROR_MESSAGE());
			THROW 50000, @ErrorMessage, 1;
		END CATCH;
GO

