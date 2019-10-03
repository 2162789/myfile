READ UpgradeDB\Ver1060705\Entity.sql;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayPeriodDaysTaken') then
   drop procedure FGetPayPeriodDaysTaken;
end if;

Create FUNCTION DBA.FGetPayPeriodDaysTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Out_NPL double;
  select sum(CurrentLveDays)+sum(PreviousLveIncDays) into Out_NPL
    from LeaveDeductionRecord
    where EmployeeSysId = In_EmployeeSysId
    and PayRecYear = In_PayRecYear
    and PayRecPeriod = In_PayRecPeriod
    and PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType;
  if Out_NPL is null then set Out_NPL=0
  end if;
  return Out_NPL
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayPeriodHrsTaken') then
   drop procedure FGetPayPeriodHrsTaken;
end if;

Create FUNCTION DBA.FGetPayPeriodHrsTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Out_NPL double;
  select sum(CurrentLveHours)+sum(PreviousLveIncHours) into Out_NPL
    from LeaveDeductionRecord
    where EmployeeSysId = In_EmployeeSysId
    and PayRecYear = In_PayRecYear
    and PayRecPeriod = In_PayRecPeriod
    and PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType;
  if Out_NPL is null then set Out_NPL=0
  end if;
  return Out_NPL
end
;

If not exists(select * from Keyword where KeyWordId = 'EX_NPLLveTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLLveTaken','NPL Taken','NPL Taken','EXPORT',0,0,0,'NPLLveTaken',504,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_NPLLveTakenHr') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLLveTakenHr','NPL Taken(Hr)','NPL Taken(Hr)','EXPORT',0,0,0,'NPLLveTakenHr',505,1,0,'');
end if;

IF NOT EXISTS(SELECT * FROM Subregistry WHERE RegistryId='ACCPACOption' AND SubregistryId = 'SignOnId') THEN
 INSERT INTO Subregistry (RegistryId,SubregistryId,IntegerAttr) VALUES('ACCPACOption','SignOnId',0);
END IF;

Commit work;

