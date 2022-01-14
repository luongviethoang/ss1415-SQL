USE AdventureWorks2019
GO
-- 1
Declare @TranName varchar(30);
Select @TranName = 'FirstTransaction';
Begin Transaction @TranName ;
Delete From HumanResources.JobCandidate Where JobCandidateID = 13;
GO
-- 2
Begin Transaction ;
GO
Delete From HumanResources.JobCandidate Where JobCandidateID = 11;
GO
Commit Transaction;
GO
-- 3
Begin Transaction DeleteCandidate
With Mark N'Deleting a Job Candidate';
GO
Delete From HumanResources.JobCandidate Where JobCandidateID = 11;
GO
COMMIT Transaction DeleteCandidate;
GO
-- 4
USE Sterling;
GO
Create  Table ValueTable ([value] char)
GO
-- 5
Begin Transaction 
Insert Into ValueTable Values('A');Insert Into ValueTable Values('B');
GO
Rollback Transaction 
Insert Into ValueTable Values('C');
Select [value] From ValueTable;
GO

-- 6
Create procedure SaveTranExample @InputCandidateID INT
AS
Declare @Trancounter int;
Set @Trancounter = @@TRANCOUNT; IF @Trancounter > 0
Save Transaction ProcedureSave;
ELSE
Begin Transaction ;
Delete HumanResources.JobCandidate
Where JobCandidateID = @InputCandidateID; IF @Trancounter = 0
COMMIT Transaction ;
IF @Trancounter = 1
RollBack Transaction ProcedureSave;
GO
-- 7
PRINT @@TRANCOUNT BEGIN TRAN
PRINT @@TRANCOUNT BEGIN TRAN
PRINT @@TRANCOUNT COMMIT
PRINT @@TRANCOUNT COMMIT
PRINT @@TRANCOUNT
GO
-- 8
PRINT @@TRANCOUNT BEGIN TRAN
PRINT @@TRANCOUNT BEGIN TRAN
PRINT @@TRANCOUNT
ROLLBACK
PRINT @@TRANCOUNT
GO
-- 9
Begin Transaction ListPriceUpdate
With Mark 'UPDATE Product list prices';
GO
UPDATE Production.Product
SET ListPrice = ListPrice * 1.20 Where ProductNumber LIKE 'BK-%';
GO
COMMIT Transaction ListPriceUpdate;
GO