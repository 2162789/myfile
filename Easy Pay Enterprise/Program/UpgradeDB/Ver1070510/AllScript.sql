IF NOT EXISTS(SELECT 1 FROM SYS.SYSCOLUMNS WHERE creator = 'DBA' AND tname = 'AllowanceRecord' AND cname = 'FullAmount') THEN
  alter table AllowanceRecord add FullAmount double null 
END IF;

IF NOT EXISTS(SELECT 1 FROM SYS.SYSCOLUMNS WHERE creator = 'DBA' AND tname = 'AllowanceRecord' AND cname = 'FullAmountF') THEN
  alter table AllowanceRecord add FullAmountF double null 
END IF;

update AllowanceRecord set FullAmount = AllowanceAmount, FullAmountF = AllowanceAmountF where FullAmount is NULL;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewAllowanceRecord') then
DROP PROCEDURE InsertNewAllowanceRecord;
end if;
CREATE PROCEDURE "DBA"."InsertNewAllowanceRecord"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double,
in In_FullAmount double,
in In_FullAmountF double,
out In_AllowanceSGSPGenId char(30))
begin
  select FGetNewSGSPGeneratedIndex('AllowanceRecord') into In_AllowanceSGSPGenId;
  insert into AllowanceRecord(AllowanceSGSPGenId,
    EmployeeSysId,
    PayRecYear,
    PayRecPeriod,
    PayRecSubPeriod,
    PayRecID,
    AllowanceFormulaId,
    AllowanceAmount,
    AllowanceRecurSysId,
    AllowancePreProcessRec,
    AllowanceCreatedBy,
    AllowanceDeclaredDate,
    AllowanceRemarks,
    AllowanceCustSysId,
    AllowanceAmountF,
    AllowanceExRateId,
    AllowanceExRate, 
    FullAmount,
    FullAmountF) values(
    In_AllowanceSGSPGenId,
    In_EmployeeSysId,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_PayRecID,
    In_AllowanceFormulaId,
    In_AllowanceAmount,
    In_AllowanceRecurSysId,
    In_AllowancePreProcessRec,
    In_AllowanceCreatedBy,
    In_AllowanceDeclaredDate,
    In_AllowanceRemarks,
    In_AllowanceCustSysId,
    In_AllowanceAmountF,
    In_AllowanceExRateId,
    In_AllowanceExRate,
    In_FullAmount,
    In_FullAmountF);
  commit work
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateAllowanceRecord') then
DROP PROCEDURE "DBA"."UpdateAllowanceRecord";
end if;
CREATE PROCEDURE "DBA"."UpdateAllowanceRecord"(
in In_AllowanceSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double,
in In_FullAmount double,
in In_FullAmountF double)
begin
  if exists(select* from AllowanceRecord where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    update AllowanceRecord set
      AllowanceSGSPGenId = In_AllowanceSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      AllowanceFormulaId = In_AllowanceFormulaId,
      AllowanceAmount = In_AllowanceAmount,
      AllowanceRecurSysId = In_AllowanceRecurSysId,
      AllowancePreProcessRec = In_AllowancePreProcessRec,
      AllowanceCreatedBy = In_AllowanceCreatedBy,
      AllowanceDeclaredDate = In_AllowanceDeclaredDate,
      AllowanceRemarks = In_AllowanceRemarks,
      AllowanceCustSysId = In_AllowanceCustSysId,
      AllowanceAmountF = In_AllowanceAmountF,
      AllowanceExRateId = In_AllowanceExRateId,
      AllowanceExRate = In_AllowanceExRate,
      FullAmount =  In_FullAmount,
      FullAmountF =  In_FullAmountF
      where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId;
    commit work
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewModifyPayElement') then
DROP PROCEDURE "DBA"."InsertNewModifyPayElement";
end if;
CREATE PROCEDURE "DBA"."InsertNewModifyPayElement"(
out Out_GenId char(30),
in In_IsFormula smallint,
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20),
in In_Formula char(255),
in In_FullAmount double,
in In_FullAmountF double)
begin
  call InsertNewAllowanceRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  In_PayRecID,
  In_AllowanceFormulaId,
  In_AllowanceAmount,
  In_AllowanceRecurSysId,
  In_AllowancePreProcessRec,
  In_AllowanceCreatedBy,
  In_AllowanceDeclaredDate,
  In_AllowanceRemarks,
  In_AllowanceCustSysId,
  In_AllowanceAmountF,
  In_AllowanceExRateId,
  In_AllowanceExRate,
  In_FullAmount,
  In_FullAmountF,
  Out_GenId);
  if(In_IsFormula = 1) then
    call InsertNewAllowanceHistoryRecord(Out_GenId,
    In_Constant1,
    In_Constant2,
    In_Constant3,
    In_Constant4,
    In_Constant5,
    In_Keywords1,
    In_Keywords2,
    In_Keywords3,
    In_Keywords4,
    In_Keywords5,
    In_Keywords6,
    In_Keywords7,
    In_Keywords8,
    In_Keywords9,
    In_Keywords10,
    In_UserDef1,
    In_UserDef2,
    In_UserDef3,
    In_UserDef4,
    In_UserDef5,
    In_UserDef1Value,
    In_UserDef2Value,
    In_UserDef3Value,
    In_UserDef4Value,
    In_UserDef5Value,
    In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
    In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,In_P10,
    In_Formula);
    commit work
  end if
end;

commit work;