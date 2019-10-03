
if exists(select 1 from sys.sysviews where viewname = 'View_SYSCOLUMNS') then
    DROP VIEW View_SYSCOLUMNS;
end if;
  
if NOT exists(select 1 from sys.sysviews where viewname = 'View_SYSCOLUMNS') then
  /* ============================================================ */
  /*   View: View_SYSCOLUMNS */
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSCOLUMNS"
    AS
  SELECT 
  SYS.SYSCOLUMNS.ColType AS ColType,  
  SYS.SYSCOLUMNS.tname AS tname,
  SYS.SYSCOLUMNS.cname AS cname,
  SYS.SYSCOLUMNS.Length AS Length,
  SYS.SYSCOLUMNS.SysLength AS SysLength,
  SYS.SYSCOLUMNS.ColNo AS ColNo
  FROM SYS.SYSCOLUMNS;

end if;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAnlysItemRecordAmt') then
   drop procedure FGetAnlysItemRecordAmt
end if
;

create function DBA.FGetAnlysItemRecordAmt(
in In_AnlysIPAddress char(20),
in In_AnlysProjectId char(20),
in In_Basis1Id char(20),
in In_Basis2Id char(20),
in In_Basis3Id char(20),
in In_AnlysItemRecYear integer,
in In_AnlysItemRecPeriodMonth integer,
in In_AnlysItemRecSubPeriod integer,
in In_AnlysPayRecBasis char(20),
in In_AnlysItem1Id char(50),
in In_AnlysItem2Id char(50),
in In_AnlysItem3Id char(50),
in In_AnlysItem4Id char(50),
in In_AnlysItem5Id char(50),
in In_ReturnAmt char(20))
returns double
begin
  declare Out_AnlysItemAmount double;
  declare Out_AnlysAmount1 double;
  declare Out_AnlysAmount2 double;
  declare Out_AnlysAmount3 double;
  declare Out_AnlysAmount4 double;
  declare Out_AnlysAmount5 double;
  declare Out_AnlysAmount6 double;
  declare Out_AnlysAmount7 double;
  declare Out_AnlysAmount8 double;
  declare Out_AnlysAmount9 double;
  declare Out_AnlysAmount10 double;
  declare Out_AnlysFAmount1 double;
  declare Out_AnlysFAmount2 double;
  declare Out_AnlysFAmount3 double;
  declare Out_AnlysFAmount4 double;
  declare Out_AnlysFAmount5 double;
  declare Out_AnlysFAmount6 double;
  declare Out_AnlysFAmount7 double;
  declare Out_AnlysFAmount8 double;
  declare Out_AnlysFAmount9 double;
  declare Out_AnlysFAmount10 double;
  declare Out_AnlysDAmount1 double;
  declare Out_AnlysDAmount2 double;
  declare Out_AnlysDAmount3 double;
  declare Out_AnlysDAmount4 double;
  declare Out_AnlysDAmount5 double;
  declare Out_AnlysDAmount6 double;
  declare Out_AnlysDAmount7 double;
  declare Out_AnlysDAmount8 double;
  declare Out_AnlysDAmount9 double;
  declare Out_AnlysDAmount10 double;
  if(In_AnlysPayRecBasis = '') then
    select sum(AnlysAmount1),sum(AnlysAmount2),sum(AnlysAmount3),sum(AnlysAmount4),sum(AnlysAmount5),
      sum(AnlysAmount6),sum(AnlysAmount7),sum(AnlysAmount8),sum(AnlysAmount9),sum(AnlysAmount10),
      Sum(AnlysFAmount1),Sum(AnlysFAmount2),Sum(AnlysFAmount3),Sum(AnlysFAmount4),Sum(AnlysFAmount5),
      Sum(AnlysFAmount6),Sum(AnlysFAmount7),Sum(AnlysFAmount8),Sum(AnlysFAmount9),Sum(AnlysFAmount10),
      Sum(AnlysDoubleValue1),Sum(AnlysDoubleValue2),Sum(AnlysDoubleValue3),Sum(AnlysDoubleValue4),Sum(AnlysDoubleValue5),
      Sum(AnlysDoubleValue6),Sum(AnlysDoubleValue7),Sum(AnlysDoubleValue8),Sum(AnlysDoubleValue9),Sum(AnlysDoubleValue10) into Out_AnlysAmount1,
      Out_AnlysAmount2,Out_AnlysAmount3,Out_AnlysAmount4,Out_AnlysAmount5,
      Out_AnlysAmount6,Out_AnlysAmount7,Out_AnlysAmount8,Out_AnlysAmount9,Out_AnlysAmount10,
      Out_AnlysFAmount1,Out_AnlysFAmount2,Out_AnlysFAmount3,Out_AnlysFAmount4,Out_AnlysFAmount5,
      Out_AnlysFAmount6,Out_AnlysFAmount7,Out_AnlysFAmount8,Out_AnlysFAmount9,Out_AnlysFAmount10,
      Out_AnlysDAmount1,Out_AnlysDAmount2,Out_AnlysDAmount3,Out_AnlysDAmount4,Out_AnlysDAmount5,
      Out_AnlysDAmount6,Out_AnlysDAmount7,Out_AnlysDAmount8,Out_AnlysDAmount9,
      Out_AnlysDAmount10 from AnlysItemRecord where
      AnlysIPAddress = In_AnlysIPAddress and
      AnlysProjectId = In_AnlysProjectId and
      Basis1Id = In_Basis1Id and
      Basis2Id = In_Basis2Id and
      Basis3Id = In_Basis3Id and
      AnlysItemRecYear = In_AnlysItemRecYear and
      AnlysItemRecPeriodMonth = In_AnlysItemRecPeriodMonth and
      AnlysItemRecSubPeriod = In_AnlysItemRecSubPeriod and
      AnlysItem1Id = In_AnlysItem1Id and
      AnlysItem2Id = In_AnlysItem2Id and
      AnlysItem3Id = In_AnlysItem3Id and
      AnlysItem4Id = In_AnlysItem4Id and
      AnlysItem5Id = In_AnlysItem5Id
  else
    select sum(AnlysAmount1),sum(AnlysAmount2),sum(AnlysAmount3),sum(AnlysAmount4),sum(AnlysAmount5),
      sum(AnlysAmount6),sum(AnlysAmount7),sum(AnlysAmount8),sum(AnlysAmount9),sum(AnlysAmount10),
      Sum(AnlysFAmount1),Sum(AnlysFAmount2),Sum(AnlysFAmount3),Sum(AnlysFAmount4),Sum(AnlysFAmount5),
      Sum(AnlysFAmount6),Sum(AnlysFAmount7),Sum(AnlysFAmount8),Sum(AnlysFAmount9),Sum(AnlysFAmount10),
      Sum(AnlysDoubleValue1),Sum(AnlysDoubleValue2),Sum(AnlysDoubleValue3),Sum(AnlysDoubleValue4),Sum(AnlysDoubleValue5),
      Sum(AnlysDoubleValue6),Sum(AnlysDoubleValue7),Sum(AnlysDoubleValue8),Sum(AnlysDoubleValue9),Sum(AnlysDoubleValue10) into Out_AnlysAmount1,
      Out_AnlysAmount2,Out_AnlysAmount3,Out_AnlysAmount4,Out_AnlysAmount5,
      Out_AnlysAmount6,Out_AnlysAmount7,Out_AnlysAmount8,Out_AnlysAmount9,Out_AnlysAmount10,
      Out_AnlysFAmount1,Out_AnlysFAmount2,Out_AnlysFAmount3,Out_AnlysFAmount4,Out_AnlysFAmount5,
      Out_AnlysFAmount6,Out_AnlysFAmount7,Out_AnlysFAmount8,Out_AnlysFAmount9,Out_AnlysFAmount10,
      Out_AnlysDAmount1,Out_AnlysDAmount2,Out_AnlysDAmount3,Out_AnlysDAmount4,Out_AnlysDAmount5,
      Out_AnlysDAmount6,Out_AnlysDAmount7,Out_AnlysDAmount8,Out_AnlysDAmount9,
      Out_AnlysDAmount10 from AnlysItemRecord where
      AnlysIPAddress = In_AnlysIPAddress and
      AnlysProjectId = In_AnlysProjectId and
      Basis1Id = In_Basis1Id and
      Basis2Id = In_Basis2Id and
      Basis3Id = In_Basis3Id and
      AnlysItemRecYear = In_AnlysItemRecYear and
      AnlysItemRecPeriodMonth = In_AnlysItemRecPeriodMonth and
      AnlysItemRecSubPeriod = In_AnlysItemRecSubPeriod and
      AnlysItem1Id = In_AnlysItem1Id and
      AnlysItem2Id = In_AnlysItem2Id and
      AnlysItem3Id = In_AnlysItem3Id and
      AnlysItem4Id = In_AnlysItem4Id and
      AnlysItem5Id = In_AnlysItem5Id and
      AnlysPayRecBasis = In_AnlysPayRecBasis
  end if;
  if(In_ReturnAmt = 'AnlysAmount1') then
    if Out_AnlysAmount1 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount1
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount2') then
    if Out_AnlysAmount2 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount2
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount3') then
    if Out_AnlysAmount3 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount3
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount4') then
    if Out_AnlysAmount4 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount4
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount5') then
    if Out_AnlysAmount5 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount5
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount6') then
    if Out_AnlysAmount6 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount6
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount7') then
    if Out_AnlysAmount7 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount7
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount8') then
    if Out_AnlysAmount8 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount8
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount9') then
    if Out_AnlysAmount9 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount9
    end if
  end if;
  if(In_ReturnAmt = 'AnlysAmount10') then
    if Out_AnlysAmount10 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysAmount10
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount1') then
    if Out_AnlysFAmount1 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount1
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount2') then
    if Out_AnlysFAmount2 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount2
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount3') then
    if Out_AnlysFAmount3 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount3
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount4') then
    if Out_AnlysFAmount4 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount4
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount5') then
    if Out_AnlysFAmount5 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount5
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount6') then
    if Out_AnlysFAmount6 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount6
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount7') then
    if Out_AnlysFAmount7 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount7
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount8') then
    if Out_AnlysFAmount8 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount8
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount9') then
    if Out_AnlysFAmount9 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount9
    end if
  end if;
  if(In_ReturnAmt = 'AnlysFAmount10') then
    if Out_AnlysFAmount10 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysFAmount10
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue1') then
    if Out_AnlysDAmount1 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount1
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue2') then
    if Out_AnlysDAmount2 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount2
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue3') then
    if Out_AnlysDAmount3 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount3
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue4') then
    if Out_AnlysDAmount4 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount4
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue5') then
    if Out_AnlysDAmount5 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount5
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue6') then
    if Out_AnlysDAmount6 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount6
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue7') then
    if Out_AnlysDAmount7 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount7
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue8') then
    if Out_AnlysDAmount8 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount8
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue9') then
    if Out_AnlysDAmount9 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount9
    end if
  end if;
  if(In_ReturnAmt = 'AnlysDoubleValue10') then
    if Out_AnlysDAmount10 is null then set Out_AnlysItemAmount=0
    else set Out_AnlysItemAmount=Out_AnlysDAmount10
    end if
  end if;
  return Out_AnlysItemAmount
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodBasisValue') then
   drop procedure FGetPeriodBasisValue
end if
;

create function DBA.FGetPeriodBasisValue(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in BasisId char(20))
returns char(20)
begin
  declare Out_Value char(20);
  if BasisId = 'PaySectionId' then
    select FGetSectionDesc(PaySectionId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayCostCenterId' then
    select FGetCostCentreDesc(PayCostCenterId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayCategoryId' then
    select FGetCategoryDesc(PayCategoryId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayDepartmentId' then
    select FGetDepartmentDesc(PayDepartmentID) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayBranchId' then
    select FGetBranchName(PayCostCenterId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayPositionId' then
    select FGetPositionDesc(PayPositionId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayPayGroupId' then
    select PayPayGroupId into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayWTCalendarId' then
    select WTCalendarDesc into Out_Value
      from PayPeriodRecord left outer join LeaveGroup on WTCalendarId = PayWTCalendarId where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayLeaveGroupId' then
    select LeaveGroupDesc into Out_Value
      from PayPeriodRecord left outer join LeaveGroup on LeaveGroupId = PayLeaveGroupId where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PaySalaryGradeId' then
    select FGetSalaryGradeDesc(PaySalaryGradeId) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayClassification' then
    select FGetClassificationDesc(PayClassification) into Out_Value
      from PayPeriodRecord where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayEmpCode1Id' then
    select CustCodeDesc into Out_Value
      from PayPeriodRecord left outer join EmpCode1 on EmpCode1Id = PayEmpCode1Id where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayEmpCode2Id' then
    select CustCodeDesc into Out_Value
      from PayPeriodRecord left outer join EmpCode2 on EmpCode2Id = PayEmpCode2Id where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayEmpCode3Id' then
    select CustCodeDesc into Out_Value
      from PayPeriodRecord left outer join EmpCode3 on EmpCode3Id = PayEmpCode3Id where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayEmpCode4Id' then
    select CustCodeDesc into Out_Value
      from PayPeriodRecord left outer join EmpCode4 on EmpCode4Id = PayEmpCode4Id where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if BasisId = 'PayEmpCode5Id' then
    select CustCodeDesc into Out_Value
      from PayPeriodRecord left outer join EmpCode5 on EmpCode5Id = PayEmpCode5Id where
      EmployeeSysID = In_EmployeeSysID and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if Out_Value is null then set Out_Value=''
  end if;
  return Out_Value
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeShift') then
   drop procedure ASQLTimeSheetDistributeShift
end if
;

CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeShift"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20))
begin
  declare In_CostingAmount double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Accu_CostingAmount double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Loop through Shift Record 
  */
  ShiftRecordLoop: for ShiftRecordFor as ShiftRecordCurs dynamic scroll cursor for
    select ShiftFormulaId as In_ShiftFormulaId,
      ShiftFrequency as In_TotalShiftFrequency,
      ShiftAmount as In_TotalShiftAmount from
      ShiftRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      PayRecId = In_TMSPayRecId and
      ShiftCreatedBy = 'TimeSheet' do
    message '' type info to client;
    message In_ShiftFormulaId type info to client;
    message '-------------------------------' type info to client;
    message 'Freq : '+cast(In_TotalShiftFrequency as char(20)) type info to client;
    message 'Amt : '+cast(In_TotalShiftAmount as char(20)) type info to client;
    /*
    Get TMS Shift Records 
    */
    select Count(*) into In_TotalRecord from
      TimeSheet join TMSShift where EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = In_TMSPayRecId and
      FormulaId = In_ShiftFormulaId;
    message 'No Of Time Sheet Records '+cast(In_TotalRecord as char(20)) type info to client;
    /*
    Loop through Shift Record 
    */
    set Accu_CostingAmount=0;
    TMSShiftLoop: for TMSShiftFor as TMSShiftCurs dynamic scroll cursor for
      select TMSShift.TMSSGSPGenId as In_TMSSGSPGenId,
        ShiftFrequency as In_ShiftFrequency from
        TimeSheet join TMSShift where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_ShiftFormulaId do
      if(In_TotalRecord = 1) then
        set In_CostingAmount=Round(In_TotalShiftAmount-Accu_CostingAmount,In_DecimalPlace)
      else
        if(In_TotalShiftFrequency = 0) then
          set In_CostingAmount=0
        else
          set In_CostingAmount=Round(In_TotalShiftAmount/In_TotalShiftFrequency*In_ShiftFrequency,In_DecimalPlace);
          if(In_CostingAmount+Accu_CostingAmount > In_TotalShiftAmount) then
            set In_CostingAmount=Round(In_TotalShiftAmount-Accu_CostingAmount,In_DecimalPlace)
          end if
        end if;
        set Accu_CostingAmount=Accu_CostingAmount+In_CostingAmount;
        set In_TotalRecord=In_TotalRecord-1
      end if;
      message '' type info to client;
      message '     '+In_TMSSGSPGenId type info to client;
      message '--------------------' type info to client;
      message '     Amt : '+cast(In_CostingAmount as char(20)) type info to client;
      update TMSShift set CostingAmount = In_CostingAmount where 
        TMSSGSPGenId = In_TMSSGSPGenId and FormulaId = In_ShiftFormulaId;
      end for end for;
  commit work
end;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeOT') then
   drop procedure ASQLTimeSheetDistributeOT
end if
;

CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeOT"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20))
begin
  declare In_CurrentCostingAmt double;
  declare In_LastCostingAmt double;
  declare In_BackPayCostingAmt double;
  declare Accu_CurrentCostingAmt double;
  declare Accu_LastCostingAmt double;
  declare Accu_BackPayCostingAmt double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Set all Costing Amount zero
  */
  update TMSOvertime set
    CurrentCostingAmt = 0,
    LastOTCostingAmt = 0,
    BackPayOTCostingAmt = 0 where
    TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = In_TMSPayRecId);
  /*
  Loop through Overtime Record 
  */
  OTRecordLoop: for OTRecordFor as OTRecordCurs dynamic scroll cursor for
    select OTFormulaId as In_OTFormulaId,
      CurrentOTFreq as In_TotalCurrentOTFreq,
      LastOTFreq as In_TotalLastOTFreq,
      BackPayOTFreq as In_TotalBackPayOTFreq,
      CurrentOTAmount as In_TotalCurrentOTAmount,
      LastOTAmount as In_TotalLastOTAmount,
      BackPayOTAmount as In_TotalBackPayOTAmount from
      OTRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      PayRecId = In_TMSPayRecId and
      OTCreatedBy = 'TimeSheet' do
    message '' type info to client;
    message In_OTFormulaId type info to client;
    message '-------------------------------' type info to client;
    message 'Current Freq : '+cast(In_TotalCurrentOTFreq as char(20)) type info to client;
    message 'Last Freq : '+cast(In_TotalLastOTFreq as char(20)) type info to client;
    message 'Back Pay Freq : '+cast(In_TotalBackPayOTFreq as char(20)) type info to client;
    message 'Current Amt : '+cast(In_TotalCurrentOTAmount as char(20)) type info to client;
    message 'Last Amt : '+cast(In_TotalLastOTAmount as char(20)) type info to client;
    message 'Back Pay Amt : '+cast(In_TotalBackPayOTAmount as char(20)) type info to client;
    message '' type info to client;
    //
    // Current OT
    //
    if(In_TotalCurrentOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        CurrentOTFreq <> 0;
      message 'No Of Current OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_CurrentCostingAmt=0;
      CurrentOTLoop: for CurrentOTFor as CurrentOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          CurrentOTFreq as In_CurrentOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          CurrentOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount-Accu_CurrentCostingAmt,In_DecimalPlace)
        else
          set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount/In_TotalCurrentOTFreq*In_CurrentOTFreq,In_DecimalPlace);
          if(In_CurrentCostingAmt+Accu_CurrentCostingAmt > In_TotalCurrentOTAmount) then
            set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount-Accu_CurrentCostingAmt,In_DecimalPlace)
          end if;
          set Accu_CurrentCostingAmt=Accu_CurrentCostingAmt+In_CurrentCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_CurrentCostingAmt as char(20)) type info to client;
        update TMSOvertime set
            CurrentCostingAmt = In_CurrentCostingAmt where 
            TMSSGSPGenId = In_TMSSGSPGenId and
            FormulaId = In_OTFormulaId end for
    end if;
    //
    // Last OT
    //
    if(In_TotalLastOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        LastOTFreq <> 0;
      message 'No Of Last OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_LastCostingAmt=0;
      LastOTLoop: for LastOTFor as LastOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          LastOTFreq as In_LastOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          LastOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_LastCostingAmt=Round(In_TotalLastOTAmount-Accu_LastCostingAmt,In_DecimalPlace)
        else
          set In_LastCostingAmt=Round(In_TotalLastOTAmount/In_TotalLastOTFreq*In_LastOTFreq,In_DecimalPlace);
          if(In_LastCostingAmt+Accu_LastCostingAmt > In_TotalLastOTAmount) then
            set In_LastCostingAmt=Round(In_TotalLastOTAmount-Accu_LastCostingAmt,In_DecimalPlace)
          end if;
          set Accu_LastCostingAmt=Accu_LastCostingAmt+In_LastCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_LastCostingAmt as char(20)) type info to client;
        update TMSOvertime set
          LastOTCostingAmt = In_LastCostingAmt where 
          TMSSGSPGenId = In_TMSSGSPGenId and
          FormulaId = In_OTFormulaId end for;
    end if;
    //
    // Back Pay OT
    //
    if(In_TotalBackPayOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        BackPayOTFreq <> 0;
      message 'No Of Back Pay OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_BackPayCostingAmt=0;
      BackPayOTLoop: for BackPayOTFor as BackPayOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          BackPayOTFreq as In_BackPayOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          BackPayOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount-Accu_BackPayCostingAmt,In_DecimalPlace)
        else
          set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount/In_TotalBackPayOTFreq*In_BackPayOTFreq,In_DecimalPlace);
          if(In_BackPayCostingAmt+Accu_BackPayCostingAmt > In_TotalBackPayOTAmount) then
            set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount-Accu_BackPayCostingAmt,In_DecimalPlace)
          end if;
          set Accu_BackPayCostingAmt=Accu_BackPayCostingAmt+In_BackPayCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_BackPayCostingAmt as char(20)) type info to client;
        update TMSOvertime set
          BackPayOTCostingAmt = In_BackPayCostingAmt where 
          TMSSGSPGenId = In_TMSSGSPGenId and
          FormulaId = In_OTFormulaId end for;
    end if end for;
  commit work
end;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeLeave') then
   drop procedure ASQLTimeSheetDistributeLeave
end if
;

CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeLeave"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer)
begin
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare In_CostingCurDayAmt double;
  declare In_CostingCurHourAmt double;
  declare In_CostingPrevDayAmt double;
  declare In_CostingPrevHourAmt double;
  declare In_TotalCurDayAmt double;
  declare In_TotalCurHourAmt double;
  declare In_TotalPrevDayAmt double;
  declare In_TotalPrevHourAmt double;
  declare Accu_CostingCurDayAmt double;
  declare Accu_CostingCurHourAmt double;
  declare Accu_CostingPrevDayAmt double;
  declare Accu_CostingPrevHourAmt double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Set all costing amount to be zero
  */
  update TMSLeaveDeduction set
    CurrentCostingAmt = 0,
    PreviousCostingAmt = 0 where
    TMSSGSPGenId = 
    any(select TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = 'Normal Time Sheet');
  commit work;
  /*
  Loop through Pay Leave Deduction Record for NPL, Absent and Late
  */
  LeaveDeductionLoop: for LeaveDeductionFor as curs dynamic scroll cursor for
    select LeaveTypeFunctCode as In_LeaveTypeFunctCode,
      CurrentLveDays as In_TotalCurDay,
      CurrentLveHours as In_TotalCurHour,
      PreviousLveIncDays as In_TotalPrevDay,
      PreviousLveIncHours as In_TotalPrevHour,
      CurrentDayRateAmt as In_CurrentDayRateAmt,
      CurrentHourRateAmt as In_CurrentHourRateAmt,
      PreviousDayRateAmt as In_PreviousDayRateAmt,
      PreviousHourRateAmt as In_PreviousHourRateAmt from
      LeaveDeductionRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      LveDedCreatedBy = 'TimeSheet' do
    /*
    Compute Total for Current / Previous Day / Hour
    */
    set In_TotalCurDayAmt=Round(In_TotalCurDay*In_CurrentDayRateAmt,In_DecimalPlace);
    set In_TotalCurHourAmt=Round(In_TotalCurHour*In_CurrentHourRateAmt,In_DecimalPlace);
    set In_TotalPrevDayAmt=Round(In_TotalPrevDay*In_PreviousDayRateAmt,In_DecimalPlace);
    set In_TotalPrevHourAmt=Round(In_TotalPrevHour*In_PreviousHourRateAmt,In_DecimalPlace);
    message '' type info to client;
    message In_LeaveTypeFunctCode type info to client;
    message '--------------------------' type info to client;
    /*
    Current Days   
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Absent') and In_TotalCurDay <> 0) then
      /*
      Get TMS Leave Deduction Records that has Current Days
      */
      message 'Total Current Day Amount : '+cast(In_TotalCurDayAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        CurrentLveDays <> 0;
      /*
      Distribution
      */
      set Accu_CostingCurDayAmt=0;
      CurrentDayLoop: for CurrentDayFor as CurrentDayCurs dynamic scroll cursor for
        select CurrentLveDays as In_CurDay,
          TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId from         
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          CurrentLveDays <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingCurDayAmt=Round(In_TotalCurDayAmt-Accu_CostingCurDayAmt,In_DecimalPlace)
        else
          set In_CostingCurDayAmt=Round(In_TotalCurDayAmt/In_TotalCurDay*In_CurDay,In_DecimalPlace);
          if(In_CostingCurDayAmt+Accu_CostingCurDayAmt < In_TotalCurDayAmt) then
            set In_CostingCurDayAmt=Round(In_TotalCurDayAmt-Accu_CostingCurDayAmt,In_DecimalPlace)
          end if;
          set Accu_CostingCurDayAmt=Accu_CostingCurDayAmt+In_CostingCurDayAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message 'Distributed Current Day Amount : '+cast(In_CostingCurDayAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          CurrentCostingAmt = In_CostingCurDayAmt 
          where 
          TMSSGSPGenId = In_TMSSGSPGenId and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode   
          end for;
      commit work
    end if;
    /*
    Current Hour
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Late') and In_TotalCurHour <> 0) then
      /*
      Get TMS Leave Deduction Records that has Current Hour
      */
      message 'Total Current Hour Amount : '+cast(In_TotalCurHourAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        CurrentLveHours <> 0;
      set Accu_CostingCurHourAmt=0;
      /*
      Distribution
      */
      CurrentHourLoop: for CurrentHourFor as CurrentHourCurs dynamic scroll cursor for
        select CurrentLveHours as In_CurHour,
          TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          CurrentLveHours <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingCurHourAmt=Round(In_TotalCurHourAmt-Accu_CostingCurHourAmt,In_DecimalPlace)
        else
          set In_CostingCurHourAmt=Round(In_TotalCurHourAmt/In_TotalCurHour*In_CurHour,In_DecimalPlace);
          if(In_CostingCurHourAmt+Accu_CostingCurHourAmt < In_TotalCurHourAmt) then
            set In_CostingCurHourAmt=Round(In_TotalCurHourAmt-Accu_CostingCurHourAmt,In_DecimalPlace)
          end if;
          set Accu_CostingCurHourAmt=Accu_CostingCurHourAmt+In_CostingCurHourAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        /*
        To append Hour value to Day if any
        */
        message 'Distributed Current Hour Amount : '+cast(In_CostingCurHourAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          CurrentCostingAmt = CurrentCostingAmt+In_CostingCurHourAmt where
          TMSSGSPGenId = In_TMSSGSPGenId and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode   
          end for;  
      commit work
    end if;
    /*
    Previous Days   
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Absent') and In_TotalPrevDay <> 0) then
      /*
      Get TMS Leave Deduction Records that has Previous Days
      */
      message 'Total Previous Day Amount : '+cast(In_TotalPrevDayAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        PreviousLveIncDays <> 0;
      /*
      Distribution
      */
      set Accu_CostingPrevDayAmt=0;
      PreviousDayLoop: for PreviousDayFor as PreviousDayCurs dynamic scroll cursor for
        select PreviousLveIncDays as In_PrevDay,
          TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          PreviousLveIncDays <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt-Accu_CostingPrevDayAmt,In_DecimalPlace)
        else
          set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt/In_TotalPrevDay*In_PrevDay,In_DecimalPlace);
          if(In_CostingPrevDayAmt+Accu_CostingPrevDayAmt < In_TotalPrevDayAmt) then
            set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt-Accu_CostingPrevDayAmt,In_DecimalPlace)
          end if;
          set Accu_CostingPrevDayAmt=Accu_CostingPrevDayAmt+In_CostingPrevDayAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message 'Distributed Previous Day Amount : '+cast(In_CostingPrevDayAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          PreviousCostingAmt = In_CostingPrevDayAmt where 
          TMSSGSPGenId = In_TMSSGSPGenId and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode 
          end for;
      commit work
    end if;
    /*
    Previous Hour
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Late') and In_TotalPrevHour <> 0) then
      /*
      Get TMS Leave Deduction Records that has Previous Hour
      */
      message 'Total Previous Hour Amount : '+cast(In_TotalPrevHourAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        PreviousLveIncHours <> 0;
      set Accu_CostingPrevHourAmt=0;
      PreviousHourLoop: for PreviousHourFor as PreviousHourCurs dynamic scroll cursor for
        select PreviousLveIncHours as In_PrevHour, 
          TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          PreviousLveIncHours <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt-Accu_CostingPrevHourAmt,In_DecimalPlace)
        else
          set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt/In_TotalPrevHour*In_PrevHour,In_DecimalPlace);
          if(In_CostingPrevHourAmt+Accu_CostingPrevHourAmt < In_TotalPrevHourAmt) then
            set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt-Accu_CostingPrevHourAmt,In_DecimalPlace)
          end if;
          set Accu_CostingPrevHourAmt=Accu_CostingPrevHourAmt+In_CostingPrevHourAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        /*
        To append Hour value to Day if any
        */
        message 'Distributed Previous Hour Amount : '+cast(In_CostingPrevHourAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          PreviousCostingAmt = PreviousCostingAmt+In_CostingPrevHourAmt where 
          TMSSGSPGenId = In_TMSSGSPGenId and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode end for;
      commit work
    end if end for
end;


