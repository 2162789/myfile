create procedure dba.ASQLAnalysisProcessBank(
in In_AnlysProjectId char(30),
in In_IPAddress char(100),
out Out_Error integer)
begin
  AnlysBank: for AnlysBankFor as AnlysBankCurs dynamic scroll cursor for
    select distinct A.AnlysDisplaySysId as In_AnlysDisplaySysId,
      AnlysItemRecYear as In_AnlysItemRecYear,
      AnlysItemRecPeriodMonth as In_AnlysItemRecPeriodMonth,
      AnlysItemRecSubPeriod as In_AnlysItemRecSubPeriod,
      AnlysPayRecBasis as In_AnlysPayRecBasis,
      Basis1Id as In_Basis1Id,
      Basis2Id as In_Basis2Id,
      Basis3Id as In_Basis3Id,
      AnlysItem5Id as In_AnlysItem5Id from
      AnlysItemRecord as A join AnlysDispSection join AnItemLookup where
      AnlysItemTypeId = 'BankRecord' and AnlysProjectId = In_AnlysProjectId and AnlysIPAddress = In_IPAddress do
    update AnlysItemRecord set AnlysItem5Id = AnlysItem5Id+'_'+STRING(Number(*)) where
      AnlysProjectId = In_AnlysProjectId and AnlysIPAddress = In_IPAddress and
      AnlysDisplaySysId = In_AnlysDisplaySysId and
      AnlysItemRecYear = In_AnlysItemRecYear and
      AnlysItemRecPeriodMonth = In_AnlysItemRecPeriodMonth and
      AnlysItemRecSubPeriod = In_AnlysItemRecSubPeriod and
      AnlysPayRecBasis = In_AnlysPayRecBasis and
      Basis1Id = In_Basis1Id and
      Basis2Id = In_Basis2Id and
      Basis3Id = In_Basis3Id and
      AnlysItem5Id = In_AnlysItem5Id;
    commit work end for;
  set Out_Error=1
end
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
  declare Out_AnlysFAmount1 double;
  declare Out_AnlysFAmount2 double;
  declare Out_AnlysFAmount3 double;
  declare Out_AnlysFAmount4 double;
  declare Out_AnlysFAmount5 double;
  declare Out_AnlysDAmount1 double;
  declare Out_AnlysDAmount2 double;
  declare Out_AnlysDAmount3 double;
  declare Out_AnlysDAmount4 double;
  declare Out_AnlysDAmount5 double;
  if(In_AnlysPayRecBasis = '') then
    select sum(AnlysAmount1),sum(AnlysAmount2),sum(AnlysAmount3),sum(AnlysAmount4),sum(AnlysAmount5),
      Sum(AnlysFAmount1),Sum(AnlysFAmount2),Sum(AnlysFAmount3),Sum(AnlysFAmount4),Sum(AnlysFAmount5),
      Sum(AnlysDoubleValue1),Sum(AnlysDoubleValue2),Sum(AnlysDoubleValue3),Sum(AnlysDoubleValue4),Sum(AnlysDoubleValue5) into Out_AnlysAmount1,
      Out_AnlysAmount2,Out_AnlysAmount3,Out_AnlysAmount4,Out_AnlysAmount5,
      Out_AnlysFAmount1,Out_AnlysFAmount2,Out_AnlysFAmount3,Out_AnlysFAmount4,Out_AnlysFAmount5,
      Out_AnlysDAmount1,Out_AnlysDAmount2,Out_AnlysDAmount3,Out_AnlysDAmount4,
      Out_AnlysDAmount5 from AnlysItemRecord where
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
      Sum(AnlysFAmount1),Sum(AnlysFAmount2),Sum(AnlysFAmount3),Sum(AnlysFAmount4),Sum(AnlysFAmount5),
      Sum(AnlysDoubleValue1),Sum(AnlysDoubleValue2),Sum(AnlysDoubleValue3),Sum(AnlysDoubleValue4),Sum(AnlysDoubleValue5) into Out_AnlysAmount1,
      Out_AnlysAmount2,Out_AnlysAmount3,Out_AnlysAmount4,Out_AnlysAmount5,
      Out_AnlysFAmount1,Out_AnlysFAmount2,Out_AnlysFAmount3,Out_AnlysFAmount4,Out_AnlysFAmount5,
      Out_AnlysDAmount1,Out_AnlysDAmount2,Out_AnlysDAmount3,Out_AnlysDAmount4,
      Out_AnlysDAmount5 from AnlysItemRecord where
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
  return Out_AnlysItemAmount
end
;

create function DBA.FGetAnlysItemRecordStr(
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
returns char(100)
begin
  declare Out_AnlysStringValue char(100);
  declare Out_AnlysStringValue1 char(100);
  declare Out_AnlysStringValue2 char(100);
  declare Out_AnlysStringValue3 char(100);
  declare Out_AnlysStringValue4 char(100);
  declare Out_AnlysStringValue5 char(100);
  if(In_AnlysPayRecBasis = '') then
    select Max(AnlysStringValue1),Max(AnlysStringValue2),Max(AnlysStringValue3),Max(AnlysStringValue4),Max(AnlysStringValue5) into Out_AnlysStringValue1,
      Out_AnlysStringValue2,Out_AnlysStringValue3,Out_AnlysStringValue4,
      Out_AnlysStringValue5 from AnlysItemRecord where
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
    select Max(AnlysStringValue1),Max(AnlysStringValue2),Max(AnlysStringValue3),Max(AnlysStringValue4),Max(AnlysStringValue5) into Out_AnlysStringValue1,
      Out_AnlysStringValue2,Out_AnlysStringValue3,Out_AnlysStringValue4,
      Out_AnlysStringValue5 from AnlysItemRecord where
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
  if(In_ReturnAmt = 'AnlysStringValue1') then
    if Out_AnlysStringValue1 is null then set Out_AnlysStringValue=''
    else set Out_AnlysStringValue=Out_AnlysStringValue1
    end if
  end if;
  if(In_ReturnAmt = 'AnlysStringValue2') then
    if Out_AnlysStringValue2 is null then set Out_AnlysStringValue=''
    else set Out_AnlysStringValue=Out_AnlysStringValue2
    end if
  end if;
  if(In_ReturnAmt = 'AnlysStringValue3') then
    if Out_AnlysStringValue3 is null then set Out_AnlysStringValue=''
    else set Out_AnlysStringValue=Out_AnlysStringValue3
    end if
  end if;
  if(In_ReturnAmt = 'AnlysStringValue4') then
    if Out_AnlysStringValue4 is null then set Out_AnlysStringValue=''
    else set Out_AnlysStringValue=Out_AnlysStringValue4
    end if
  end if;
  if(In_ReturnAmt = 'AnlysStringValue5') then
    if Out_AnlysStringValue5 is null then set Out_AnlysStringValue=''
    else set Out_AnlysStringValue=Out_AnlysStringValue5
    end if
  end if;
  return Out_AnlysStringValue
end
;

create function dba.FGetFormulaKeyWordUserDefinedName(
in In_FormulaId char(20))
returns char(100)
begin
  //CP38Code,WP39Code,ZakatCode
  declare Out_KeyWordUserDefinedName char(100);
  select KeyWordUserDefinedName into Out_KeyWordUserDefinedName
    from Formula join FormulaProperty join Keyword where Formula.FormulaId = In_FormulaId and
    KeyWordPropertySelection = 1 and(Keyword.KeyWordId = 'CP38Code' or Keyword.KeyWordId = 'WP39Code' or Keyword.KeyWordId = 'ZakatCode');
  if(Out_KeyWordUserDefinedName is null or Out_KeyWordUserDefinedName = '') then
    return('')
  else return(Out_KeyWordUserDefinedName)
  end if
end
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
    select FGetClassificationDesc(PayClassificationCode) into Out_Value
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

create procedure dba.DeleteAnlysDispSection(
in In_AnlysDisplaySysId char(30),
out Out_ErrorCode integer)
begin
  declare Del_DisplaySubSection integer;
  declare Del_AnlysItemSysId char(30);
  if exists(select* from AnlysDispSection where AnlysDisplaySysId = In_AnlysDisplaySysId) then
    select DisplaySubSection,AnlysItemSysId into Del_DisplaySubSection,Del_AnlysItemSysId from AnlysDispSection where AnlysDisplaySysId = In_AnlysDisplaySysId;
    delete from AnlysItemRecord where AnlysItemRecord.AnlysDisplaySysId = In_AnlysDisplaySysId;
    commit work;
    delete from AnlysDispSection where AnlysDispSection.AnlysDisplaySysId = In_AnlysDisplaySysId;
    commit work;
    if exists(select* from AnlysDispSection where AnlysDisplaySysId = In_AnlysDisplaySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      AnlysDisplaySysIdLoop: for AnlysDisplaySysIdFor as Cur_AnlysDisplaySysId dynamic scroll cursor for
        select AnlysDispSection.DisplaySubSection as Get_DisplaySubSection,AnlysDispSection.AnlysDisplaySysId as Get_AnlysDisplaySysId from
          AnlysDispSection where
          AnlysDispSection.AnlysItemSysId = Del_AnlysItemSysId and
          AnlysDispSection.DisplaySubSection > Del_DisplaySubSection do
        update AnlysDispSection set
          AnlysDispSection.DisplaySubSection = (Get_DisplaySubSection-1) where
          AnlysDispSection.AnlysDisplaySysId = Get_AnlysDisplaySysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAnlysItemSetup(
in In_AnlysItemSysId char(30),
out Out_ErrorCode integer)
begin
  declare Del_DisplaySection integer;
  declare Del_AnlysSetupId char(30);
  if exists(select* from AnlysItemSetup where AnlysItemSysId = In_AnlysItemSysId) then
    select DisplaySection,AnlysSetupId into Del_DisplaySection,Del_AnlysSetupId from AnlysItemSetup where AnlysItemSysId = In_AnlysItemSysId;
    /* Delete AnlysDispSection*/
    AnlysDispSectionLoop: for AnlysDisplaySysIdFor as Cur_AnlysDisplaySysId dynamic scroll cursor for
      select AnlysDispSection.AnlysDisplaySysId as Get_AnlysDisplaySysId from AnlysDispSection where AnlysDispSection.AnlysItemSysId = In_AnlysItemSysId do
      call DeleteAnlysDispSection(Get_AnlysDisplaySysId,Out_ErrorCode) end for;
    delete from AnlysItemSetup where AnlysItemSetup.AnlysItemSysId = In_AnlysItemSysId;
    commit work;
    if exists(select* from AnlysItemSetup where AnlysItemSysId = In_AnlysItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder */
      AnlysItemSysIdLoop: for AnlysItemSysIdFor as Cur_AnlysItemSysId dynamic scroll cursor for
        select AnlysItemSetup.DisplaySection as Get_DisplaySection,AnlysItemSetup.AnlysItemSysId as Get_AnlysItemSysId from
          AnlysItemSetup where
          AnlysItemSetup.AnlysSetupId = Del_AnlysSetupId and
          AnlysItemSetup.DisplaySection > Del_DisplaySection do
        update AnlysItemSetup set
          AnlysItemSetup.DisplaySection = (Get_DisplaySection-1) where
          AnlysItemSetup.AnlysItemSysId = Get_AnlysItemSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAnlysProject(
in In_AnlysProjectId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysProject where AnlysProjectId = In_AnlysProjectId) then
    delete from AnlysItemRecord where AnlysProjectId = In_AnlysProjectId;
    commit work;
    delete from AnlysProject where AnlysProjectId = In_AnlysProjectId;
    commit work;
    if exists(select* from AnlysProject where AnlysProjectId = In_AnlysProjectId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteAnlysSetup(
in In_AnlysSetupId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysSetup where AnlysSetupId = In_AnlysSetupId) then
    if exists(select* from AnlysProject where AnlysSetupId = In_AnlysSetupId) then
      set Out_ErrorCode=-1
    end if;
    /* Delete AnlysItemSetup*/
    AnlysAnlysItemSetupLoop: for AnlysItemSysIdFor as Cur_AnlysItemSysId dynamic scroll cursor for
      select AnlysItemSetup.AnlysItemSysId as Get_AnlysItemSysId from AnlysItemSetup where AnlysItemSetup.AnlysSetupId = In_AnlysSetupId do
      call DeleteAnlysItemSetup(Get_AnlysItemSysId,Out_ErrorCode) end for;
    delete from AnlysSetup where AnlysSetup.AnlysSetupId = In_AnlysSetupId;
    commit work;
    if exists(select* from AnlysSetup where AnlysSetupId = In_AnlysSetupId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateAnlysDispSection(
in In_AnlysDisplaySysId char(30),
in In_AnlysItemSysId char(30),
in In_AnlysLookupId char(50),
in In_DisplaySubSection integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysDispSection where
      AnlysDispSection.AnlysDisplaySysId = In_AnlysDisplaySysId) then
    if In_AnlysItemSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_AnlysLookupId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_DisplaySubSection <= 0 then set Out_ErrorCode=-3;
      return
    end if;
    update AnlysDispSection set
      AnlysDispSection.AnlysItemSysId = In_AnlysItemSysId,
      AnlysDispSection.AnlysLookupId = In_AnlysLookupId,
      AnlysDispSection.DisplaySubSection = In_DisplaySubSection where
      AnlysDispSection.AnlysDisplaySysId = In_AnlysDisplaySysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAnlysItemSetup(
in In_AnlysItemSysId char(30),
in In_AnlysSetupId char(30),
in In_AnlysItemTypeId char(20),
in In_DisplaySection integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysItemSetup where
      AnlysItemSetup.AnlysItemSysId = In_AnlysItemSysId) then
    if In_AnlysSetupId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_AnlysItemTypeId is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_DisplaySection <= 0 then set Out_ErrorCode=-3;
      return
    end if;
    update AnlysItemSetup set
      AnlysItemSetup.AnlysSetupId = In_AnlysSetupId,
      AnlysItemSetup.AnlysItemTypeId = In_AnlysItemTypeId,
      AnlysItemSetup.DisplaySection = In_DisplaySection where
      AnlysItemSetup.AnlysItemSysId = In_AnlysItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAnlysProject(
in In_AnlysProjectId char(30),
in In_AnlysSetupId char(30),
in In_AnlysProjectDesc char(100),
in In_AnlysProjectType char(20),
in In_Basis1 char(20),
in In_Basis2 char(20),
in In_Basis3 char(20),
in In_CycleMethod char(20),
in In_CycleGroupBy char(20),
in In_CycleSubGroupBy char(20),
in In_SummaryLevel char(20),
in In_IsSystemProject smallint,
in In_AnlysProjectSubType char(20),
in In_BasisPolicyId1 char(20),
in In_BasisPolicyId2 char(20),
in In_BasisPolicyId3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysProject where
      AnlysProjectId = In_AnlysProjectId) then
    if In_AnlysProjectId is null then set Out_ErrorCode=-1;
      return
    end if;
    update AnlysProject set
      AnlysSetupId = In_AnlysSetupId,
      AnlysProjectDesc = In_AnlysProjectDesc,
      AnlysProjectType = In_AnlysProjectType,
      Basis1 = In_Basis1,
      Basis2 = In_Basis2,
      Basis3 = In_Basis3,
      CycleMethod = In_CycleMethod,
      CycleGroupBy = In_CycleGroupBy,
      CycleSubGroupBy = In_CycleSubGroupBy,
      SummaryLevel = In_SummaryLevel,
      IsSystemProject = In_IsSystemProject,
      AnlysProjectSubType = In_AnlysProjectSubType,
      BasisPolicyId1 = In_BasisPolicyId1,
      BasisPolicyId2 = In_BasisPolicyId2,
      BasisPolicyId3 = In_BasisPolicyId3 where
      AnlysProjectId = In_AnlysProjectId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAnlysSetup(
in In_AnlysSetupId char(30),
in In_AnlysSetupDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysSetup where
      AnlysSetup.AnlysSetupId = In_AnlysSetupId) then
    if In_AnlysSetupId is null then set Out_ErrorCode=-1;
      return
    end if;
    update AnlysSetup set
      AnlysSetup.AnlysSetupDesc = In_AnlysSetupDesc where
      AnlysSetup.AnlysSetupId = In_AnlysSetupId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAnlysDispSection(
in In_AnlysItemSysId char(30),
in In_AnlysLookupId char(50),
out Out_AnlysDisplaySysId char(30),
out Out_ErrorCode integer)
begin
  declare Out_DisplaySubSection integer;
  if In_AnlysItemSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_AnlysLookupId is null then set Out_ErrorCode=-2;
    return
  end if;
  select max(DisplaySubSection) into Out_DisplaySubSection from AnlysDispSection where
    AnlysDispSection.AnlysItemSysId = In_AnlysItemSysId;
  if(Out_DisplaySubSection is null) then
    set Out_DisplaySubSection=1
  else
    set Out_DisplaySubSection=Out_DisplaySubSection+1
  end if;
  if not exists(select* from AnlysDispSection where AnlysItemSysId = In_AnlysItemSysId and AnlysLookupId = In_AnlysLookupId) then
    insert into AnlysDispSection(AnlysDisplaySysId,
      AnlysItemSysId,
      AnlysLookupId,
      DisplaySubSection) values(
      FGetNewSGSPGeneratedIndex('AnlysDispSection'),
      In_AnlysItemSysId,
      In_AnlysLookupId,
      Out_DisplaySubSection);
    commit work;
    if not exists(select* from AnlysDispSection where AnlysItemSysId = In_AnlysItemSysId and AnlysLookupId = In_AnlysLookupId and DisplaySubSection = Out_DisplaySubSection) then
      set Out_ErrorCode=0
    else
      select max(AnlysDisplaySysId) into Out_AnlysDisplaySysId from AnlysDispSection where AnlysItemSysId = In_AnlysItemSysId and AnlysLookupId = In_AnlysLookupId and DisplaySubSection = Out_DisplaySubSection;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-3
  end if
end
;

create procedure dba.InsertNewAnlysItemSetup(
in In_AnlysSetupId char(30),
in In_AnlysItemTypeId char(20),
out Out_AnlysItemSysId char(30),
out Out_ErrorCode integer)
begin
  declare Out_DisplaySection integer;
  if In_AnlysSetupId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_AnlysItemTypeId is null then set Out_ErrorCode=-2;
    return
  end if;
  select max(DisplaySection) into Out_DisplaySection from AnlysItemSetup where
    AnlysItemSetup.AnlysSetupId = In_AnlysSetupId;
  if(Out_DisplaySection is null) then
    set Out_DisplaySection=1
  else
    set Out_DisplaySection=Out_DisplaySection+1
  end if;
  if not exists(select* from AnlysItemSetup where AnlysSetupId = In_AnlysSetupId and AnlysItemTypeId = In_AnlysItemTypeId and DisplaySection = Out_DisplaySection) then
    insert into AnlysItemSetup(AnlysItemSysId,
      AnlysSetupId,
      AnlysItemTypeId,
      DisplaySection) values(
      FGetNewSGSPGeneratedIndex('AnlysItemSetup'),
      In_AnlysSetupId,
      In_AnlysItemTypeId,
      Out_DisplaySection);
    commit work;
    if not exists(select* from AnlysItemSetup where AnlysSetupId = In_AnlysSetupId and AnlysItemTypeId = In_AnlysItemTypeId and DisplaySection = Out_DisplaySection) then
      set Out_ErrorCode=0
    else
      select max(AnlysItemSysId) into Out_AnlysItemSysId from AnlysItemSetup where AnlysSetupId = In_AnlysSetupId and AnlysItemTypeId = In_AnlysItemTypeId and DisplaySection = Out_DisplaySection;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAnlysProject(
in In_AnlysProjectId char(30),
in In_AnlysSetupId char(30),
in In_AnlysProjectDesc char(100),
in In_AnlysProjectType char(20),
in In_Basis1 char(20),
in In_Basis2 char(20),
in In_Basis3 char(20),
in In_CycleMethod char(20),
in In_CycleGroupBy char(20),
in In_CycleSubGroupBy char(20),
in In_SummaryLevel char(20),
in In_IsSystemProject smallint,
in In_AnlysProjectSubType char(20),
in In_BasisPolicyId1 char(20)
,in In_BasisPolicyId2 char(20)
,in In_BasisPolicyId3 char(20),
out Out_ErrorCode integer)
begin
  if In_AnlysProjectId is null then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from AnlysProject where AnlysProjectId = In_AnlysProjectId) then
    insert into AnlysProject(AnlysProjectId,
      AnlysSetupId,
      AnlysProjectDesc,
      AnlysProjectType,
      Basis1,
      Basis2,
      Basis3,
      CycleMethod,
      CycleGroupBy,
      CycleSubGroupBy,
      SummaryLevel,
      IsSystemProject,
      AnlysProjectSubType,
      BasisPolicyId1,
      BasisPolicyId2,
      BasisPolicyId3) values(
      In_AnlysProjectId,
      In_AnlysSetupId,
      In_AnlysProjectDesc,
      In_AnlysProjectType,
      In_Basis1,
      In_Basis2,
      In_Basis3,
      In_CycleMethod,
      In_CycleGroupBy,
      In_CycleSubGroupBy,
      In_SummaryLevel,
      In_IsSystemProject,
      In_AnlysProjectSubType,
      In_BasisPolicyId1,
      In_BasisPolicyId2,
      In_BasisPolicyId3);
    commit work;
    if not exists(select* from AnlysProject where AnlysProjectId = In_AnlysProjectId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAnlysSetup(
in In_AnlysSetupId char(30),
in In_AnlysSetupDesc char(100),
out Out_ErrorCode integer)
begin
  if In_AnlysSetupId is null then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from AnlysSetup where AnlysSetupId = In_AnlysSetupId) then
    insert into AnlysSetup(AnlysSetupId,
      AnlysSetupDesc) values(
      In_AnlysSetupId,
      In_AnlysSetupDesc);
    commit work;
    if not exists(select* from AnlysSetup where AnlysSetupId = In_AnlysSetupId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetMaxSubPeriodCurrLveEntitlement(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Period integer,
in In_SubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Out_CurrLveEntitlement double;
  declare Out_MaxPeriod integer;
  set Out_CurrLveEntitlement=0;
  set Out_MaxPeriod=0;
  if In_Period = 0 then
    select Max(PayRecPeriod) into Out_MaxPeriod from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType;
    if Out_MaxPeriod > 0 then
      select CurrLveEntitlement into Out_CurrLveEntitlement from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecPeriod = Out_MaxPeriod and
        PayRecSubPeriod = 
        (select Max(PayRecSubPeriod) from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
          PayRecPeriod = Out_MaxPeriod and PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType)
    end if
  else if In_SubPeriod = 0 then
      select CurrLveEntitlement into Out_CurrLveEntitlement from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecPeriod = In_Period and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecSubPeriod = 
        (select Max(PayRecSubPeriod) from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
          PayRecPeriod = In_Period and PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType)
    else
      select CurrLveEntitlement into Out_CurrLveEntitlement from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecPeriod = In_Period and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecPeriod = In_Period and
        PayRecSubPeriod = In_SubPeriod
    end if
  end if;
  return Out_CurrLveEntitlement
end
;

create function DBA.FGetMaxSubPeriodLveBroughtForward(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Period integer,
in In_SubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Out_LveBroughtForward double;
  declare Out_MaxPeriod integer;
  set Out_LveBroughtForward=0;
  set Out_MaxPeriod=0;
  if In_Period = 0 then
    select Max(PayRecPeriod) into Out_MaxPeriod from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType;
    if Out_MaxPeriod > 0 then
      select LveBroughtForward into Out_LveBroughtForward from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecPeriod = Out_MaxPeriod and
        PayRecSubPeriod = 
        (select Max(PayRecSubPeriod) from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
          PayRecPeriod = Out_MaxPeriod and PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType)
    end if
  else if In_SubPeriod = 0 then
      select LveBroughtForward into Out_LveBroughtForward from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecPeriod = In_Period and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecSubPeriod = 
        (select Max(PayRecSubPeriod) from LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
          PayRecPeriod = In_Period and PayRecYear = In_Year and LeaveTypeFunctCode = In_LeaveType)
    else
      select LveBroughtForward into Out_LveBroughtForward from
        LeaveInfoRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecPeriod = In_Period and
        PayRecYear = In_Year and
        LeaveTypeFunctCode = In_LeaveType and
        PayRecPeriod = In_Period and
        PayRecSubPeriod = In_SubPeriod
    end if
  end if;
  return Out_LveBroughtForward
end
;

create function dba.FGetCostPeriodYearToCalenMthYear(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
in In_RetYear integer)
returns integer
begin
  declare CalenYear integer;
  declare CalenMonth integer;
  declare Out_Period1StartMonth integer;
  //
  // Convert Cost Period/year to Calen Month/year
  // 
  select Period1StartMonth into Out_Period1StartMonth
    from CostingDetails join CostGroup where EmployeeSysId = In_EmployeeSysId;
  set CalenYear=In_CostYear;
  set CalenMonth=Out_Period1StartMonth+In_CostPeriod;
  if(CalenMonth > 12) then
    set CalenYear=CalenYear+1;
    set CalenMonth=CalenMonth-12
  end if;
  if(In_RetYear = 1) then
    return(CalenYear)
  else
    return(CalenMonth)
  end if
end
;

create function dba.FGetCostPeriodYearToPayPeriodYear(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
in In_RetYear integer)
returns integer
begin
  declare PayRecYear integer;
  declare PayRecPeriod integer;
  declare Out_MapPayGroupYear char(20);
  declare Out_MapPayGroupPeriod integer;
  //
  // Convert Cost Period/year to Payroll Period/year
  //
  select MapPayGroupYear,MapPayGroupPeriod into Out_MapPayGroupYear,
    Out_MapPayGroupPeriod from CostingDetails join CostGroup where EmployeeSysId = In_EmployeeSysId;
  if(Out_MapPayGroupYear = 'CurrentYr') then
    set PayRecYear=In_CostYear
  else
    set PayRecYear=In_CostYear-1
  end if;
  set PayRecPeriod=Out_MapPayGroupPeriod+(In_CostPeriod-1);
  if(PayRecPeriod > 12) then
    set PayRecYear=PayRecYear+1;
    set PayRecPeriod=PayRecPeriod-12
  end if;
  if(In_RetYear = 1) then
    return(PayRecYear)
  else
    return(PayRecPeriod)
  end if
end
;

create function dba.FGetPayPeriodYearToCostPeriodYear(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_RetYear integer)
returns integer
begin
  declare CostYear integer;
  declare CostPeriod integer;
  declare Out_MapPayGroupYear char(20);
  declare Out_MapPayGroupPeriod integer;
  //
  // Convert Payroll Period/year to Cost Period/year
  //
  select MapPayGroupYear,MapPayGroupPeriod into Out_MapPayGroupYear,
    Out_MapPayGroupPeriod from CostingDetails join CostGroup where EmployeeSysId = In_EmployeeSysId;
  if(Out_MapPayGroupYear = 'CurrentYr') then
    set CostYear=In_PayRecYear
  else
    set CostYear=In_PayRecYear+1
  end if;
  set CostPeriod=(In_PayRecPeriod-Out_MapPayGroupPeriod)+1;
  if(CostPeriod < 1) then
    set CostYear=CostYear-1;
    set CostPeriod=12+CostPeriod
  end if;
  if(In_RetYear = 1) then
    return(CostYear)
  else
    return(CostPeriod)
  end if
end
;

create function dba.FGetEmployeeCareerAttributeValue(
in In_EmployeeSysId integer,
in In_CareerAttributeID char(20),
in In_AsOfDate date)
returns char(100)
begin
  declare Out_CareerNewValue char(100);
  select first CareerNewValue into Out_CareerNewValue from CareerAttribute where
    CareerAttributeID = In_CareerAttributeID and EmployeeSysId = In_EmployeeSysId and CareerEffectiveDate <= In_AsOfDate order by CareerEffectiveDate desc;
  return(Out_CareerNewValue)
end
;

create function
dba.FGetLastInitPayPeriod(
in In_EmployeeSysId integer,
in In_FromYear integer,
in In_FromPeriod integer,
in In_ToYear integer,
in In_ToPeriod integer,
in In_RetYear integer)
returns integer
begin
  declare Out_PayRecYear integer;
  declare Out_PayRecPeriod integer;
  if In_FromPeriod > 0 then
    select first PayRecYear,PayRecPeriod into Out_PayRecYear,
      Out_PayRecPeriod from SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
      IsPeriodWithin(PayRecYear,PayRecPeriod,In_FromYear,In_FromPeriod,In_ToYear,In_ToPeriod) = 1 order by SubPeriodEndDate desc
  else
    select first PayRecYear,PayRecPeriod into Out_PayRecYear,
      Out_PayRecPeriod from SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear between In_FromYear and In_ToYear order by SubPeriodEndDate desc
  end if;
  if(In_RetYear = 1) then
    return(Out_PayRecYear)
  else
    return(Out_PayRecPeriod)
  end if
end
;

create function dba.FGetLastInitSubPeriodEndDate(
in In_EmployeeSysId integer,
in In_FromYear integer,
in In_FromPeriod integer,
in In_ToYear integer,
in In_ToPeriod integer)
returns date
begin
  declare Out_SubPeriodEndDate date;
  if In_FromPeriod > 0 then
    select first SubPeriodEndDate into Out_SubPeriodEndDate from
      SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
      IsPeriodWithin(PayRecYear,PayRecPeriod,In_FromYear,In_FromPeriod,In_ToYear,In_ToPeriod) = 1 order by SubPeriodEndDate desc
  else
    select first SubPeriodEndDate into Out_SubPeriodEndDate from SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear between In_FromYear and In_ToYear order by SubPeriodEndDate desc
  end if;
  return(Out_SubPeriodEndDate)
end
;

create function dba.FGetLeaveCycleCrossCycTaken(
in In_EmployeeSysId integer,
in In_LveYearRpt integer,
in In_LvePeriodRpt integer,
in In_LeaveTypeId char(20))
returns double
begin
  declare Out_CycCrossCycTaken integer;
  set Out_CycCrossCycTaken=0;
  if In_LvePeriodRpt = 12 then
    select CycCrossCycTaken into Out_CycCrossCycTaken from LeaveCycleRpt where
      EmployeeSysId = In_EmployeeSysId and LveYearRpt = In_LveYearRpt and LeaveTypeId = In_LeaveTypeId
  end if;
  return Out_CycCrossCycTaken
end
;

create function dba.FGetLeaveCycleCrossCycTakenAmt(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveYearRpt integer,
in In_LvePeriodRpt integer)
returns double
begin
  declare Out_CrossCycTakenAmt double;
  select(FGetLveCosting(In_EmployeeSysId,In_LeaveTypeId,In_LveYearRpt,
    FGetLeaveCycleCrossCycTaken(In_EmployeeSysId,In_LveYearRpt,In_LvePeriodRpt,In_LeaveTypeId))) into Out_CrossCycTakenAmt;
  if(Out_CrossCycTakenAmt is null) then set Out_CrossCycTakenAmt=0
  end if;
  return Out_CrossCycTakenAmt
end
;

create function dba.FGetLeavePeriodToPayPeriod(
in In_EmployeeSysId integer,
in In_PeriodStartDate date,
in In_PeriodEndDate date,
in In_RetYear integer)
returns integer
begin
  declare Out_PayRecYear integer;
  declare Out_PayRecPeriod integer;
  select first PayRecYear,PayRecPeriod into Out_PayRecYear,
    Out_PayRecPeriod from SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
    SubPeriodEndDate between In_PeriodStartDate and In_PeriodEndDate order by PayRecYear asc,PayRecPeriod asc;
  if(In_RetYear = 1) then
    return(Out_PayRecYear)
  else
    return(Out_PayRecPeriod)
  end if
end
;

create function dba.FGetLveCreditBalance(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalBalance double;
  select(FGetLveCreditEarned(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)-
    FGetLveCreditExpired(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)-
    FGetLveCreditTaken(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)) into Out_TotalBalance;
  if(Out_TotalBalance is null) then set Out_TotalBalance=0
  end if;
  return Out_TotalBalance
end
;

create function dba.FGetLveCreditFutureBalance(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_EffectiveDate date)
returns double
begin
  declare Out_TotalFutureBalance double;
  select(FGetLveCreditEarned(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)-
    FGetLveCreditExpired(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)-
    FGetLveCreditTaken(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)+
    FGetLveCreditNotEarned(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)-
    FGetLveCreditFutureTaken(In_EmployeeSysId,In_LeaveTypeId,In_EffectiveDate)) into Out_TotalFutureBalance;
  if(Out_TotalFutureBalance is null) then set Out_TotalFutureBalance=0
  end if;
  return Out_TotalFutureBalance
end
;

create function
dba.FGetSubPeriodStartDate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns date
begin
  declare Out_SubPeriodStartDate date;
  select first SubPeriodStartDate into Out_SubPeriodStartDate from
    SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod order by SubPeriodStartDate desc;
  return(Out_SubPeriodStartDate)
end
;

create function dba.FGetSubPeriodEndDate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns date
begin
  declare Out_SubPeriodEndDate date;
  select first SubPeriodEndDate into Out_SubPeriodEndDate from
    SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod order by SubPeriodEndDate desc;
  return(Out_SubPeriodEndDate)
end
;

create function dba.IsLvePeriodBalRptLastInitPayPeriod(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns integer
begin
  declare Out_PayRecPeriod integer;
  select Max(PayRecPeriod) into Out_PayRecPeriod from SubPeriodRecord where EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear;
  if In_PayRecPeriod = Out_PayRecPeriod then
    return 1
  end if;
  return 0
end
;

create procedure
dba.ASQLUpdateAnlysSystemAttribute()
begin
  declare EmpCode1_Id char(100);
  declare EmpCode2_Id char(100);
  declare EmpCode3_Id char(100);
  declare EmpCode4_Id char(100);
  declare EmpCode5_Id char(100);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  if exists(select* from SystemAttribute where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode1Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode1_Id where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode1Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode2Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode2_Id where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode2Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode3Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode3_Id where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode3Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode4Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode4_Id where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode4Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode5Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode5_Id where
      SysTableId = 'LvePeriodBalRpt' and SysAttributeId = 'Ana_FLveCareerEmpCode5Id'
  end if;
  commit work
end
;

create procedure dba.ASQLAnalysisBasis(
in In_EmployeeSysId integer,
in In_Basis char(20),
in In_BasisPolicyId char(20),
in In_BasisTable char(20),
in In_CurStartDate date,
in In_CurEndDate date,
in In_PrevStartDate date,
in In_PrevEndDate date,
in In_CessationDate date,
in In_DebugMode integer)
begin
  declare Out_PrevEffectiveDate date;
  declare Out_CurEffectiveDate date;
  declare Out_PrevBasisValue char(20);
  declare Out_CurBasisValue char(20);
  declare CurValue double;
  declare PrevValue double;
  if In_DebugMode = 1 then
    message '' type info to client;
    message '   '+In_Basis+' : ' type info to client
  end if;
  //============================================
  // Basis : Employee (Personal)
  //============================================
  if In_Basis = 'BasisPersonalTypeId' then
    select Personal.PersonalTypeId,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee join Personal where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
  end if;
  if In_Basis = 'BasisBloodGroupId' then
    select Personal.BloodGroupId,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee join Personal where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  //============================================
  // Basis : Employee 
  //============================================
  if In_Basis = 'BasisIdentityTypeId' then
    select Employee.IdentityTypeCode,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisMaritalStatusId' then
    select Employee.MaritalStatusCode,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisGenderId' then
    select Employee.Gender,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisReligionId' then
    select Employee.ReligionID,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisRaceId' then
    select Employee.RaceId,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisCurResStatusId' then
    select Employee.ResidenceStatus,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisHighEduId' then
    select Employee.HighestEduCode,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisHighEduLevelId' then
    select Education.EduLevelId,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee left outer join Education on Employee.HighestEduCode = Education.EducationId where
      Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisNationalityId' then
    select Employee.Nationality,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisCoOfBirthId' then
    select Employee.CountryOfBirth,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  //============================================
  // Basis : Pay Employee
  //============================================
  if In_Basis = 'PayPayGroupId' then
    select PayGroupId,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from PayEmployee join Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  if In_Basis = 'BasisSalaryTypeId' then
    select CurrentBasicRateType,Employee.HireDate into Out_CurBasisValue,
      Out_CurEffectiveDate from PayEmployee join Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,Out_CurEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_CurBasisValue+' '+cast(Out_CurEffectiveDate as char(10)) type info to client
    end if
  end if;
  //============================================
  // Basis : Employee Numeric
  //============================================
  if In_Basis in('BasisAgeByMth','BasisAgeByYr','BasisSrvcYrByMth','BasisSrvcYrByYr') then
    call ASQLAnalysisBasisAge_ServiceYear(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode)
  end if;
  //============================================
  // Basis : Career Progression
  //============================================
  if In_Basis = 'PayDepartmentId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerDepartment')
  end if;
  if In_Basis = 'PaySectionId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerSection')
  end if;
  if In_Basis = 'PayCategoryId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerCategory')
  end if;
  if In_Basis = 'PayBranchId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerBranch')
  end if;
  if In_Basis = 'PayPositionId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerPosition')
  end if;
  if In_Basis = 'PayWTCalendarId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerWTCalendar')
  end if;
  if In_Basis = 'PayLeaveGroupId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'CareerLeaveGroup')
  end if;
  if In_Basis = 'PaySalaryGradeId' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'SalaryGradeId')
  end if;
  if In_Basis = 'PayClassification' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'ClassificationCode')
  end if;
  if In_Basis = 'PayEmpCode1Id' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'EmpCode1Id')
  end if;
  if In_Basis = 'PayEmpCode2Id' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'EmpCode2Id')
  end if;
  if In_Basis = 'PayEmpCode3Id' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'EmpCode3Id')
  end if;
  if In_Basis = 'PayEmpCode4Id' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'EmpCode4Id')
  end if;
  if In_Basis = 'PayEmpCode5Id' then
    call ASQLAnalysisBasisCareerProg(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode,'EmpCode5Id')
  end if;
  //============================================
  // Basis : Basic Rate Progression
  //============================================
  if In_Basis = 'BasisExchangeRateId' then
    //--------------------------------------------
    // Get and insert previous progression 
    //--------------------------------------------
    select first BRProgEffectiveDate,(case when BRProgExRateId is null then '' else BRProgExRateId
      end) into Out_PrevEffectiveDate,Out_PrevBasisValue from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and
      BRProgEffectiveDate <= In_PrevEndDate and
      (BRProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
      BRProgEffectiveDate desc;
    //
    // Record exists
    //
    if Out_PrevEffectiveDate is not null then
      execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
      if In_DebugMode = 1 then
        message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10)) type info to client
      end if;
      set Out_CurBasisValue=Out_PrevBasisValue
    end if;
    //--------------------------------------------
    // Get and insert current progression 
    //--------------------------------------------
    BasisExchangeRateLoop: for BasisExchangeRateForLoop as Cur_BasisExchangeRate dynamic scroll cursor for
      select BRProgEffectiveDate as In_EffectiveDate,(case when BRProgExRateId is null then '' else BRProgExRateId
        end) as In_BasisValue from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and
        BRProgEffectiveDate between In_CurStartDate and In_CurEndDate and
        (BRProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
        BRProgEffectiveDate asc do
      //
      // Check for duplicate record
      //
      if(Out_CurBasisValue is null or Out_CurBasisValue <> In_BasisValue) then
        execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (In_BasisValue,In_EffectiveDate)');
        if In_DebugMode = 1 then
          message '   '+In_BasisValue+' '+cast(In_EffectiveDate as char(10)) type info to client
        end if
      end if;
      set Out_CurBasisValue=In_BasisValue end for
  end if;
  //============================================
  // Basis : Basic Rate Progression (Numeric)
  //============================================
  if In_Basis = 'BasisTotalWage' then
    call ASQLAnalysisBasisTotalWage(In_EmployeeSysId,In_Basis,In_BasisPolicyId,In_BasisTable,In_CurStartDate,In_CurEndDate,In_PrevStartDate,In_PrevEndDate,In_CessationDate,In_DebugMode)
  end if;
  //============================================
  // Basis : Cost Progression
  //============================================
  if In_Basis = 'PayCostCenterId' then
    //--------------------------------------------
    // Get and insert previous progression 
    //--------------------------------------------
    select first CostProgEffectiveDate,(case when CostCentreId is null then '' else CostCentreId
      end) into Out_PrevEffectiveDate,Out_PrevBasisValue from CostProgression join EmployeeCostCentre where EmployeeSysId = In_EmployeeSysId and KeyCostCentre = 1 and
      CostProgEffectiveDate <= In_PrevEndDate and
      (CostProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
      CostProgEffectiveDate desc;
    //
    // Record exists
    //
    if Out_PrevEffectiveDate is not null then
      execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
      if In_DebugMode = 1 then
        message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10)) type info to client
      end if;
      set Out_CurBasisValue=Out_PrevBasisValue
    end if;
    //--------------------------------------------
    // Get and insert current progression 
    //--------------------------------------------
    PayCostCenterIdLoop: for PayCostCenterIdForLoop as Cur_PayCostCenterId dynamic scroll cursor for
      select CostProgEffectiveDate as In_EffectiveDate,(case when CostCentreId is null then '' else CostCentreId
        end) as In_BasisValue from CostProgression join EmployeeCostCentre where EmployeeSysId = In_EmployeeSysId and KeyCostCentre = 1 and
        CostProgEffectiveDate between In_CurStartDate and In_CurEndDate and
        (CostProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
        CostProgEffectiveDate asc do
      //
      // Check for duplicate record
      //
      if(Out_CurBasisValue is null or Out_CurBasisValue <> In_BasisValue) then
        execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (In_BasisValue,In_EffectiveDate)');
        if In_DebugMode = 1 then
          message '   '+In_BasisValue+' '+cast(In_EffectiveDate as char(10)) type info to client
        end if
      end if;
      set Out_CurBasisValue=In_BasisValue end for
  end if
end
;

create procedure dba.ASQLAnalysisBasisAge_ServiceYear(
in In_EmployeeSysId integer,
in In_Basis char(20),
in In_BasisPolicyId char(20),
in In_BasisTable char(20),
in In_CurStartDate date,
in In_CurEndDate date,
in In_PrevStartDate date,
in In_PrevEndDate date,
in In_CessationDate date,
in In_DebugMode integer)
begin
  declare Out_PrevEffectiveDate date;
  declare Out_CurEffectiveDate date;
  declare Out_PrevBasisValue char(20);
  declare Out_CurBasisValue char(20);
  declare CurValue double;
  declare PrevValue double;
  declare RefDate date;
  //============================================
  // Basis : BasisAgeByMth or BasisSrvcYrByMth
  //============================================
  if In_Basis in('BasisAgeByMth','BasisSrvcYrByMth') then
    //--------------------------------------------
    // Get Employee Age/ Service Years by Month start off point date
    // Check for Hire and Cessation date within range to determine StartDate and End EndDate
    //--------------------------------------------
    select(case when Employee.HireDate between In_PrevStartDate and In_CurEndDate then
        Employee.HireDate else In_PrevStartDate end) as StartMonth,
      (case when Employee.CessationDate between In_PrevStartDate and In_CurEndDate then
        Employee.CessationDate else In_CurEndDate end) as EndMonth,
      (case when In_Basis = 'BasisAgeByMth' then
        (Months(Employee.DateOfBirth,StartMonth)/12.0)
      when In_Basis = 'BasisSrvcYrByMth' then
        (Months(Employee.HireDate,StartMonth)/12.0)
      end),(case when In_Basis = 'BasisAgeByMth' then
        Employee.DateOfBirth
      when In_Basis = 'BasisSrvcYrByMth' then
        Employee.HireDate
      end) into Out_PrevEffectiveDate,Out_CurEffectiveDate,PrevValue,RefDate from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId and
      Employee.HireDate <= In_CurEndDate and
      (Employee.CessationDate >= In_PrevStartDate or Employee.CessationDate = '1899-12-30');
    //
    // Record exists
    //
    if PrevValue is not null then
      //
      // Locate Basis Policy Range and insert into BasisTable
      //
      select first AnlysPolicyRangeCode,AnlysRangeUpTo into Out_PrevBasisValue,CurValue from AnlysPolicyRange where AnlysBasisPolicyId = In_BasisPolicyId and AnlysRangeUpTo >= PrevValue order by AnlysRangeUpTo asc;
      //
      // Basis Policy Range Exists
      //
      if Out_PrevBasisValue is not null then
        execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
        if In_DebugMode = 1 then
          message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(5)) type info to client
        end if;
        //--------------------------------------------
        // Loop Policy Range to compute and insert Progression Date
        //--------------------------------------------
        BasisByMthLoop: for BasisByMthForLoop as Cur_BasisByMth dynamic scroll cursor for
          select AnlysPolicyRangeCode as In_BasisValue,
            dateadd(month,AnlysRangeUpTo*12,RefDate) as In_EffectiveDate from
            AnlysPolicyRange where
            AnlysBasisPolicyId = In_BasisPolicyId and
            AnlysRangeUpTo > CurValue and In_EffectiveDate <= Out_CurEffectiveDate order by
            AnlysRangeUpTo asc do
          execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (In_BasisValue,In_EffectiveDate)');
          if In_DebugMode = 1 then
            message '   '+In_BasisValue+' '+cast(In_EffectiveDate as char(10)) type info to client
          end if end for
      else
        if In_DebugMode = 1 then
          message '   '+'Invalid Basis Policy Range!'+' '+In_BasisPolicyId+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(5)) type info to client
        end if
      end if
    end if
  end if;
  //============================================
  // Basis : BasisAgeByMth or BasisSrvcYrByMth
  //============================================
  if In_Basis in('BasisAgeByYr','BasisSrvcYrByYr') then
    //--------------------------------------------
    // Get Employee Age / Service Years by Year start off point date
    // StartDate = Out_PrevEffectiveDate, EndDate = Out_CurEffectiveDate
    //--------------------------------------------
    select(case when Employee.HireDate between In_PrevStartDate and In_CurEndDate then
        Employee.HireDate else In_PrevStartDate end) as StartMonth,
      (case when Employee.CessationDate between In_PrevStartDate and In_CurEndDate then
        Employee.CessationDate else In_CurEndDate end) as EndMonth,
      (case when In_Basis = 'BasisAgeByYr' then
        Year(StartMonth)-Year(Employee.DateOfBirth)
      when In_Basis = 'BasisSrvcYrByYr' then
        Year(StartMonth)-Year(Employee.HireDate)
      end),(case when In_Basis = 'BasisAgeByYr' then
        Employee.DateOfBirth
      when In_Basis = 'BasisSrvcYrByYr' then
        Employee.HireDate
      end) into Out_PrevEffectiveDate,Out_CurEffectiveDate,PrevValue,RefDate from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId and
      Employee.HireDate <= In_CurEndDate and
      (Employee.CessationDate >= In_PrevStartDate or Employee.CessationDate = '1899-12-30');
    //
    // Record exists
    //
    if PrevValue is not null then
      //
      // Locate Basis Policy Range and insert into BasisTable
      //
      select first AnlysPolicyRangeCode,AnlysRangeUpTo into Out_PrevBasisValue,CurValue from AnlysPolicyRange where AnlysBasisPolicyId = In_BasisPolicyId and AnlysRangeUpTo >= PrevValue order by AnlysRangeUpTo asc;
      //
      // Basis Policy Range Exists
      //
      if Out_PrevBasisValue is not null then
        execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
        if In_DebugMode = 1 then
          message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(5)) type info to client
        end if;
        //--------------------------------------------
        // Loop Policy Range to compute and insert Progression Date
        //--------------------------------------------
        BasisByYrLoop: for BasisByYrForLoop as Cur_BasisByYr dynamic scroll cursor for
          select AnlysPolicyRangeCode as In_BasisValue,
            dateadd(year,AnlysRangeUpTo,RefDate) as In_EffectiveDate from AnlysPolicyRange where
            AnlysBasisPolicyId = In_BasisPolicyId and
            AnlysRangeUpTo > CurValue and year(In_EffectiveDate) <= year(Out_CurEffectiveDate) order by
            AnlysRangeUpTo asc do
          execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (In_BasisValue,In_EffectiveDate)');
          if In_DebugMode = 1 then
            message '   '+In_BasisValue+' '+cast(In_EffectiveDate as char(10)) type info to client
          end if end for
      else
        if In_DebugMode = 1 then
          message '   '+'Invalid Basis Policy Range!'+' '+In_BasisPolicyId+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(5)) type info to client
        end if
      end if
    end if
  end if;
  execute immediate('DELETE FROM '+In_BasisTable+' WHERE BasisEffectiveDate < (SELECT MAX(BasisEffectiveDate) FROM '+In_BasisTable+' WHERE BasisEffectiveDate BETWEEN '''+cast(In_PrevStartDate as char(10))+''' and '''+cast(In_PrevEndDate as char(10))+''')')
end
;

create procedure dba.ASQLAnalysisBasisCareerProg(
in In_EmployeeSysId integer,
in In_Basis char(20),
in In_BasisPolicyId char(20),
in In_BasisTable char(20),
in In_CurStartDate date,
in In_CurEndDate date,
in In_PrevStartDate date,
in In_PrevEndDate date,
in In_CessationDate date,
in In_DebugMode integer,
in In_CareerAttributeID char(20))
begin
  declare Out_CurBasisValue char(20);
  declare Out_PrevBasisValue char(20);
  declare Out_PrevEffectiveDate date;
  //--------------------------------------------
  // Get and insert previous progression 
  //--------------------------------------------
  select first CareerProgression.CareerEffectiveDate,(case when CareerNewValue is null then '' else CareerNewValue
    end) into Out_PrevEffectiveDate,
    Out_PrevBasisValue from
    CareerProgression join CareerAttribute where
    CareerProgression.EmployeeSysId = In_EmployeeSysId and
    CareerAttributeID = In_CareerAttributeID and
    CareerProgression.CareerEffectiveDate <= In_PrevEndDate and
    (CareerProgression.CareerEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
    CareerProgression.CareerEffectiveDate desc;
  //
  // Record exists
  //
  if Out_PrevEffectiveDate is not null then
    execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
    if In_DebugMode = 1 then
      message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10)) type info to client
    end if;
    set Out_CurBasisValue=Out_PrevBasisValue
  end if;
  //--------------------------------------------
  // Get and insert current progression 
  //--------------------------------------------
  ProgressionLoop: for ProgressionForLoop as Cur_Progression dynamic scroll cursor for
    select CareerProgression.CareerEffectiveDate as In_EffectiveDate,(case when CareerNewValue is null then '' else CareerNewValue
      end) as In_BasisValue from
      CareerProgression join CareerAttribute where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerAttributeID = In_CareerAttributeID and
      CareerProgression.CareerEffectiveDate between In_CurStartDate and In_CurEndDate and
      (CareerProgression.CareerEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
      CareerProgression.CareerEffectiveDate asc do
    //  
    // Check for duplicated record
    //
    if(Out_CurBasisValue is null or Out_CurBasisValue <> In_BasisValue) then
      execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (In_BasisValue,In_EffectiveDate)');
      if In_DebugMode = 1 then
        message '   '+In_BasisValue+' '+cast(In_EffectiveDate as char(10)) type info to client
      end if
    end if;
    set Out_CurBasisValue=In_BasisValue end for
end
;

create procedure dba.ASQLAnalysisBasisTotalWage(
in In_EmployeeSysId integer,
in In_Basis char(20),
in In_BasisPolicyId char(20),
in In_BasisTable char(20),
in In_CurStartDate date,
in In_CurEndDate date,
in In_PrevStartDate date,
in In_PrevEndDate date,
in In_CessationDate date,
in In_DebugMode integer)
begin
  declare Out_PrevEffectiveDate date;
  declare Out_CurEffectiveDate date;
  declare Out_PrevBasisValue char(20);
  declare Out_CurBasisValue char(20);
  declare CurValue double;
  declare PrevValue double;
  declare ConvRate double;
  //--------------------------------------------
  // Get Previous Total Wage
  //--------------------------------------------
  select first(case when BRProgExRateId is null or BRProgExRateId = '' then 1
    else(FGetBasicRateProgressionForeignLocalRate(BasicRateProgression.BRProgEffectiveDate,BRProgExRateId))
    end),
    BRProgNewBasicRate+(case when
    IsWageElementInUsed('MVC','TotalWage') = 1 then MVCNewRate else 0 end)+(case when
    IsWageElementInUsed('NWC','TotalWage') = 1 then NWCNewRate else 0 end),
    BasicRateProgression.BRProgEffectiveDate into ConvRate,
    PrevValue,
    Out_PrevEffectiveDate from BasicRateProgression join PolicyProgression where
    BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
    BasicRateProgression.BRProgEffectiveDate <= In_PrevEndDate and
    (BasicRateProgression.BRProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
    BasicRateProgression.BRProgEffectiveDate desc;
  //
  // Check if record exists
  //
  if PrevValue is not null then
    //
    // Check if Exchange Rate exists
    //
    if ConvRate is not null then
      set PrevValue=PrevValue*ConvRate;
      //
      // Locate Basis Policy Range and insert into BasisTable
      //
      select first AnlysPolicyRangeCode into Out_PrevBasisValue from AnlysPolicyRange where AnlysBasisPolicyId = In_BasisPolicyId and AnlysRangeUpTo >= PrevValue order by AnlysRangeUpTo asc;
      if Out_PrevBasisValue is not null then
        execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_PrevBasisValue,Out_PrevEffectiveDate)');
        if In_DebugMode = 1 then
          message '   '+Out_PrevBasisValue+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(5)) type info to client
        end if
      else
        if In_DebugMode = 1 then
          message '   '+'Invalid Basis Policy Range!'+' '+In_BasisPolicyId+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(20)) type info to client
        end if
      end if
    else
      if In_DebugMode = 1 then
        message '   '+'Invalid Exchange Rate!'+' '+cast(Out_PrevEffectiveDate as char(10))+' '+cast(PrevValue as char(20)) type info to client
      end if
    end if
  end if;
  //--------------------------------------------
  // Get Current Total Wage
  //--------------------------------------------
  BasisSalaryTypeLoop: for BasisSalaryTypeForLoop as Cur_BasisSalaryType dynamic scroll cursor for
    select(case when BRProgExRateId is null or BRProgExRateId = '' then 1
      else(FGetBasicRateProgressionForeignLocalRate(BasicRateProgression.BRProgEffectiveDate,BRProgExRateId))
      end) as In_ConvRate,
      BasicRateProgression.BRProgEffectiveDate as In_EffectiveDate,
      BRProgNewBasicRate,(case when IsWageElementInUsed('MVC','TotalWage') = 1 then MVCNewRate else 0 end) as mvc,(case when
      IsWageElementInUsed('NWC','TotalWage') = 1 then NWCNewRate else 0 end) as nwc,
      (BRProgNewBasicRate+mvc+nwc) as In_BasisValue from
      BasicRateProgression join PolicyProgression where
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
      BasicRateProgression.BRProgEffectiveDate between In_CurStartDate and In_CurEndDate and
      (BasicRateProgression.BRProgEffectiveDate <= In_CessationDate or In_CessationDate = '1899-12-30' or In_CessationDate is null) order by
      BasicRateProgression.BRProgEffectiveDate desc do
    //
    // Check if Exchange Rate exists
    //
    if In_ConvRate is not null then
      set In_BasisValue=In_BasisValue*In_ConvRate;
      //  
      // Check for duplicated record
      //
      if PrevValue is null or PrevValue <> In_BasisValue then
        //  
        // Locate Basis Policy Range and insert into BasisTable
        //
        select first AnlysPolicyRangeCode into Out_CurBasisValue from AnlysPolicyRange where AnlysBasisPolicyId = In_BasisPolicyId and AnlysRangeUpTo >= In_BasisValue order by AnlysRangeUpTo asc;
        if Out_CurBasisValue is not null then
          //  
          // Check for duplicated record
          //
          if Out_PrevBasisValue is null or Out_PrevBasisValue <> Out_CurBasisValue then
            execute immediate('INSERT INTO '+In_BasisTable+' (BasisValue, BasisEffectiveDate) VALUES (Out_CurBasisValue,In_EffectiveDate)');
            if In_DebugMode = 1 then
              message '   '+Out_CurBasisValue+' '+cast(In_EffectiveDate as char(10))+' '+cast(In_BasisValue as char(5)) type info to client
            end if
          end if
        else
          if In_DebugMode = 1 then
            message '   '+'Invalid Basis Policy Range!'+' '+In_BasisPolicyId+' '+cast(In_EffectiveDate as char(10))+' '+cast(In_BasisValue as char(20)) type info to client
          end if
        end if
      end if;
      set PrevValue=CurValue;
      set Out_PrevBasisValue=Out_CurBasisValue
    else
      if In_DebugMode = 1 then
        message '   '+'Invalid Exchange Rate!'+' '+cast(In_EffectiveDate as char(10))+' '+cast(In_BasisValue as char(20)) type info to client
      end if
    end if end for
end
;

create procedure DBA.ASQLAnalysisDriveBasis1(
in NoOfBasis integer,
in In_EmployeeSysId integer,
in In_HireDate date,
in In_CessationDate date,
in CurStartDate date,
in CurEndDate date,
in PrevStartDate date,
in PrevEndDate date,
in LatestBasis1Value char(20),
in LatestBasis1EffectiveDate date,
in LatestBasis2Value char(20),
in LatestBasis2EffectiveDate date,
in LatestBasis3Value char(20),
in LatestBasis3EffectiveDate date,
inout Out_Error integer)
begin
  declare In_Basis2Value char(20);
  declare In_Basis2EffectiveDate date;
  declare In_Basis3Value char(20);
  declare In_Basis3EffectiveDate date;
  /*------------------------------------------------------
  Drive Basis1
  ------------------------------------------------------*/
  Basis1Loop: for Basis1For as Basis1Curs dynamic scroll cursor for
    select BasisValue as In_Basis1Value,BasisEffectiveDate as In_Basis1EffectiveDate from AnlysBasis1 do
    /*------------------------------------------------------
    Initialise
    ------------------------------------------------------*/
    set In_Basis2Value='';
    set In_Basis3Value='';
    set In_Basis2EffectiveDate='1899-12-30';
    set In_Basis3EffectiveDate='1899-12-30';
    /*------------------------------------------------------
    Get Best Match Basis 2
    ------------------------------------------------------*/
    if(NoOfBasis >= 2) then
      select first BasisValue,BasisEffectiveDate into In_Basis2Value,In_Basis2EffectiveDate from AnlysBasis2 where
        BasisEffectiveDate <= In_Basis1EffectiveDate order by BasisEffectiveDate desc
    end if;
    /*------------------------------------------------------
    Get Best Match Basis 3
    ------------------------------------------------------*/
    if(NoOfBasis >= 3) then
      select first BasisValue,BasisEffectiveDate into In_Basis3Value,In_Basis3EffectiveDate from AnlysBasis3 where
        BasisEffectiveDate <= In_Basis1EffectiveDate order by BasisEffectiveDate desc
    end if;
    if
      ((NoOfBasis = 3 and
      In_Basis2EffectiveDate <> '1899-12-30' and
      In_Basis3EffectiveDate <> '1899-12-30') or
      (NoOfBasis = 2 and
      In_Basis2EffectiveDate <> '1899-12-30') or
      (NoOfBasis = 1)) then
      call ASQLAnalysisDriveBasisCommon(1,NoOfBasis,In_EmployeeSysId,
      In_HireDate,
      In_CessationDate,
      CurStartDate,
      CurEndDate,
      PrevStartDate,
      PrevEndDate,
      LatestBasis1Value,
      LatestBasis1EffectiveDate,
      LatestBasis2Value,
      LatestBasis2EffectiveDate,
      LatestBasis3Value,
      LatestBasis3EffectiveDate,
      In_Basis1Value,
      In_Basis1EffectiveDate,
      In_Basis2Value,
      In_Basis2EffectiveDate,
      In_Basis3Value,
      In_Basis3EffectiveDate,
      Out_Error);
      if(Out_Error > 0) then return
      end if
    end if end for
end
;

create procedure DBA.ASQLAnalysisDriveBasis2(
in NoOfBasis integer,
in In_EmployeeSysId integer,
in In_HireDate date,
in In_CessationDate date,
in CurStartDate date,
in CurEndDate date,
in PrevStartDate date,
in PrevEndDate date,
in LatestBasis1Value char(20),
in LatestBasis1EffectiveDate date,
in LatestBasis2Value char(20),
in LatestBasis2EffectiveDate date,
in LatestBasis3Value char(20),
in LatestBasis3EffectiveDate date,
inout Out_Error integer)
begin
  declare In_Basis1Value char(20);
  declare In_Basis1EffectiveDate date;
  declare In_Basis3Value char(20);
  declare In_Basis3EffectiveDate date;
  /*------------------------------------------------------
  Drive Basis 2
  ------------------------------------------------------*/
  Basis1Loop: for Basis2For as Basis2Curs dynamic scroll cursor for
    select BasisValue as In_Basis2Value,BasisEffectiveDate as In_Basis2EffectiveDate from AnlysBasis2 do
    /*------------------------------------------------------
    Initialise
    ------------------------------------------------------*/
    set In_Basis1Value='';
    set In_Basis3Value='';
    set In_Basis1EffectiveDate='1899-12-30';
    set In_Basis3EffectiveDate='1899-12-30';
    /*------------------------------------------------------
    Get Best Match Basis 1
    ------------------------------------------------------*/
    select first BasisValue,BasisEffectiveDate into In_Basis1Value,In_Basis1EffectiveDate from AnlysBasis1 where
      BasisEffectiveDate <= In_Basis2EffectiveDate order by BasisEffectiveDate desc;
    /*------------------------------------------------------
    Get Best Match Basis 3
    ------------------------------------------------------*/
    if(NoOfBasis >= 3) then
      select first BasisValue,BasisEffectiveDate into In_Basis3Value,In_Basis3EffectiveDate from AnlysBasis3 where
        BasisEffectiveDate <= In_Basis2EffectiveDate order by BasisEffectiveDate desc
    end if;
    if
      ((NoOfBasis = 3 and
      In_Basis1EffectiveDate <> '1899-12-30' and
      In_Basis3EffectiveDate <> '1899-12-30') or
      (NoOfBasis = 2 and
      In_Basis1EffectiveDate <> '1899-12-30')) then
      call ASQLAnalysisDriveBasisCommon(2,NoOfBasis,In_EmployeeSysId,
      In_HireDate,
      In_CessationDate,
      CurStartDate,
      CurEndDate,
      PrevStartDate,
      PrevEndDate,
      LatestBasis1Value,
      LatestBasis1EffectiveDate,
      LatestBasis2Value,
      LatestBasis2EffectiveDate,
      LatestBasis3Value,
      LatestBasis3EffectiveDate,
      In_Basis1Value,
      In_Basis1EffectiveDate,
      In_Basis2Value,
      In_Basis2EffectiveDate,
      In_Basis3Value,
      In_Basis3EffectiveDate,
      Out_Error);
      if(Out_Error > 0) then return
      end if
    end if end for
end
;

create procedure DBA.ASQLAnalysisDriveBasis3(
in NoOfBasis integer,
in In_EmployeeSysId integer,
in In_HireDate date,
in In_CessationDate date,
in CurStartDate date,
in CurEndDate date,
in PrevStartDate date,
in PrevEndDate date,
in LatestBasis1Value char(20),
in LatestBasis1EffectiveDate date,
in LatestBasis2Value char(20),
in LatestBasis2EffectiveDate date,
in LatestBasis3Value char(20),
in LatestBasis3EffectiveDate date,
inout Out_Error integer)
begin
  declare In_Basis1Value char(20);
  declare In_Basis1EffectiveDate date;
  declare In_Basis2Value char(20);
  declare In_Basis2EffectiveDate date;
  /*------------------------------------------------------
  Drive Basis 3
  ------------------------------------------------------*/
  Basis1Loop: for Basis3For as Basis3Curs dynamic scroll cursor for
    select BasisValue as In_Basis3Value,BasisEffectiveDate as In_Basis3EffectiveDate from AnlysBasis3 do
    /*------------------------------------------------------
    Initialise
    ------------------------------------------------------*/
    set In_Basis1Value='';
    set In_Basis2Value='';
    set In_Basis1EffectiveDate='1899-12-30';
    set In_Basis2EffectiveDate='1899-12-30';
    /*------------------------------------------------------
    Get Best Match Basis 1
    ------------------------------------------------------*/
    select first BasisValue,BasisEffectiveDate into In_Basis1Value,In_Basis1EffectiveDate from AnlysBasis1 where
      BasisEffectiveDate <= In_Basis3EffectiveDate order by BasisEffectiveDate desc;
    /*------------------------------------------------------
    Get Best Match Basis 2
    ------------------------------------------------------*/
    select first BasisValue,BasisEffectiveDate into In_Basis2Value,In_Basis2EffectiveDate from AnlysBasis2 where
      BasisEffectiveDate <= In_Basis3EffectiveDate order by BasisEffectiveDate desc;
    if(In_Basis1EffectiveDate <> '1899-12-30' and
      In_Basis2EffectiveDate <> '1899-12-30') then
      call ASQLAnalysisDriveBasisCommon(3,NoOfBasis,In_EmployeeSysId,
      In_HireDate,
      In_CessationDate,
      CurStartDate,
      CurEndDate,
      PrevStartDate,
      PrevEndDate,
      LatestBasis1Value,
      LatestBasis1EffectiveDate,
      LatestBasis2Value,
      LatestBasis2EffectiveDate,
      LatestBasis3Value,
      LatestBasis3EffectiveDate,
      In_Basis1Value,
      In_Basis1EffectiveDate,
      In_Basis2Value,
      In_Basis2EffectiveDate,
      In_Basis3Value,
      In_Basis3EffectiveDate,
      Out_Error);
      if(Out_Error > 0) then return
      end if
    end if end for
end
;

create procedure DBA.ASQLAnalysisDriveBasisCommon(
in DriveBasis integer,
in NoOfBasis integer,
in In_EmployeeSysId integer,
in In_HireDate date,
in In_CessationDate date,
in CurStartDate date,
in CurEndDate date,
in PrevStartDate date,
in PrevEndDate date,
in LatestBasis1Value char(20),
in LatestBasis1EffectiveDate date,
in LatestBasis2Value char(20),
in LatestBasis2EffectiveDate date,
in LatestBasis3Value char(20),
in LatestBasis3EffectiveDate date,
in In_Basis1Value char(20),
in In_Basis1EffectiveDate date,
in In_Basis2Value char(20),
in In_Basis2EffectiveDate date,
in In_Basis3Value char(20),
in In_Basis3EffectiveDate date,
inout Out_Error integer)
begin
  declare Out_Basis_PREV integer;
  declare Out_Basis_IN integer;
  declare Out_Basis_OUT integer;
  declare Out_Basis_NEW integer;
  declare Out_Basis_RESIGN integer;
  declare Out_Basis_TOTAL integer;
  declare msg1 char(200);
  /*------------------------------------------------------
  Check in MOVEMENT LIST
  ------------------------------------------------------*/
  set Out_Basis_PREV=0;
  set Out_Basis_IN=0;
  set Out_Basis_OUT=0;
  set Out_Basis_NEW=0;
  set Out_Basis_RESIGN=0;
  set Out_Basis_TOTAL=0;
  if exists(select* from AnlysMovement where
      EmployeeSysId = In_EmployeeSysId and
      Basis1Value = In_Basis1Value and
      Basis1EffectiveDate = In_Basis1EffectiveDate and
      Basis2Value = In_Basis2Value and
      Basis2EffectiveDate = In_Basis2EffectiveDate and
      Basis3Value = In_Basis3Value and
      Basis3EffectiveDate = In_Basis3EffectiveDate) then return
  end if;
  if(NoOfBasis = 1) then
    set msg1=' ['+
      In_Basis1Value+space(5)+
      cast(In_Basis1EffectiveDate as char(10))+']'
  elseif(NoOfBasis = 2) then
    set msg1=' ['+
      In_Basis1Value+space(5)+
      cast(In_Basis1EffectiveDate as char(10))+space(5)+
      In_Basis2Value+space(5)+
      cast(In_Basis2EffectiveDate as char(10))+']'
  elseif(NoOfBasis = 3) then
    set msg1=' ['+
      In_Basis1Value+space(5)+
      cast(In_Basis1EffectiveDate as char(10))+space(5)+
      In_Basis2Value+space(5)+
      cast(In_Basis2EffectiveDate as char(10))+space(5)+
      In_Basis3Value+space(5)+
      cast(In_Basis3EffectiveDate as char(10))+']'
  end if;
  /*------------------------------------------------------
  PREVIOUS
  ------------------------------------------------------*/
  if(In_Basis1EffectiveDate < CurStartDate and
    (In_Basis2EffectiveDate < CurStartDate or In_Basis2EffectiveDate = '1899-12-30') and
    (In_Basis3EffectiveDate < CurStartDate or In_Basis3EffectiveDate = '1899-12-30') and
    (In_CessationDate >= CurStartDate or In_CessationDate = '1899-12-30')) then
    set Out_Basis_PREV=1
  else
    /*------------------------------------------------------
    NEW    
    ------------------------------------------------------*/
    if((In_Basis1EffectiveDate = In_HireDate and In_Basis1EffectiveDate between CurStartDate and CurEndDate) and
      ((In_Basis2EffectiveDate = In_HireDate and In_Basis2EffectiveDate between CurStartDate and CurEndDate) or In_Basis2EffectiveDate = '1899-12-30') and
      ((In_Basis3EffectiveDate = In_HireDate and In_Basis3EffectiveDate between CurStartDate and CurEndDate) or In_Basis3EffectiveDate = '1899-12-30')) then
      set Out_Basis_NEW=1
    else
      /*------------------------------------------------------
      IN
      ------------------------------------------------------*/
      set Out_Basis_IN=1
    end if
  end if;
  /*------------------------------------------------------
  Current RESIGN
  ------------------------------------------------------*/
  if(LatestBasis1Value = In_Basis1Value and
    LatestBasis1EffectiveDate = In_Basis1EffectiveDate and
    LatestBasis2Value = In_Basis2Value and
    LatestBasis2EffectiveDate = In_Basis2EffectiveDate and
    LatestBasis3Value = In_Basis3Value and
    LatestBasis3EffectiveDate = In_Basis3EffectiveDate and
    In_CessationDate between CurStartDate and CurEndDate) then
    set Out_Basis_RESIGN=1
  /*------------------------------------------------------
  OUT
  ------------------------------------------------------*/
  elseif(LatestBasis1Value <> In_Basis1Value or
  LatestBasis1EffectiveDate <> In_Basis1EffectiveDate or
  LatestBasis2Value <> In_Basis2Value or
  LatestBasis2EffectiveDate <> In_Basis2EffectiveDate or
  LatestBasis3Value <> In_Basis3Value or
  LatestBasis3EffectiveDate <> In_Basis3EffectiveDate) then
    set Out_Basis_OUT=1
  end if;
  /*------------------------------------------------------
  Compute TOTAL
  ------------------------------------------------------*/
  set Out_Basis_TOTAL=Out_Basis_PREV-Out_Basis_RESIGN+Out_Basis_IN-Out_Basis_OUT+Out_Basis_NEW;
  if(Out_Basis_TOTAL < 0 or Out_Basis_TOTAL > 1) then
    set Out_Error=In_EmployeeSysId;
    message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has invalid TOTAL' type info to client;
    return
  end if;
  insert into AnlysMovement values(In_EmployeeSysId,
    In_Basis1Value,
    In_Basis1EffectiveDate,
    In_Basis2Value,
    In_Basis2EffectiveDate,
    In_Basis3Value,
    In_Basis3EffectiveDate,
    Out_Basis_PREV,
    Out_Basis_IN,
    Out_Basis_OUT,
    Out_Basis_NEW,
    Out_Basis_RESIGN,
    Out_Basis_TOTAL);
  message '      Drive '+cast(DriveBasis as char(1))+msg1+space(5)+'Previous : '+
    cast(Out_Basis_PREV as char(20))+space(5)+'Resign : '+
    cast(Out_Basis_RESIGN as char(20))+space(5)+'In : '+
    cast(Out_Basis_IN as char(20))+space(5)+'Out : '+
    cast(Out_Basis_OUT as char(20))+space(5)+'New : '+
    cast(Out_Basis_NEW as char(20))+space(5)+'Total : '+
    cast(Out_Basis_TOTAL as char(20)) type info to client
end
;

create procedure dba.ASQLAnalysisLookup(
in In_AnlysProjectId char(30),
in In_AnlysItemTypeId char(20),
in In_AnlysLookupId char(50),
out Out_AnlysDisplaySysId char(30),
out Out_AnlysItemDesc char(50),
out Out_AnlysMapField char(100))
begin
  /*
  To get the Item Sys Id so as to locate the Display Section
  */
  declare Out_AnlysItemSysId char(30);
  declare Out_SysTableId char(100);
  declare Out_SysAttributeId char(100);
  set Out_AnlysDisplaySysId=null;
  set Out_AnlysItemDesc='';
  set Out_AnlysMapField='';
  select AnlysItemSysId into Out_AnlysItemSysId from AnlysItemSetup where
    AnlysItemTypeId = In_AnlysItemTypeId and
    AnlysSetupId = (select AnlysSetupId from AnlysProject where AnlysProjectId = In_AnlysProjectId);
  if Out_AnlysItemSysId is null then return
  end if;
  /*
  Extract Display Sys Id
  */
  select AnlysDisplaySysId into Out_AnlysDisplaySysId from AnlysDispSection where
    AnlysLookupId = In_AnlysLookupId and
    AnlysItemSysId = Out_AnlysItemSysId;
  if Out_AnlysDisplaySysId is null then return
  end if;
  /*
  Get Mapping Field
  */
  select AnlysMapField,SysTableId,SysAttributeId into Out_AnlysMapField,
    Out_SysTableId,
    Out_SysAttributeId from AnItemLookup where AnlysLookupId = In_AnlysLookupId;
  /*
  Get Description
  */
  select SysUserdefinedName into Out_AnlysItemDesc from SystemAttribute where
    SysAttributeId = Out_SysAttributeId and
    SysTableId = Out_SysTableId
end
;


CREATE PROCEDURE "DBA"."ASQLAnalysisMovement"(
in In_AnlysProjectId char(30),
in In_Year integer,
in In_Month integer,
in In_Basis1 char(20),
in In_Basis2 char(20),
in In_Basis3 char(20),
in In_IPAddress char(100),
in In_ViewTable char(100),
out Out_Error integer)
begin
  declare NoOfBasis integer;
  declare In_CycleGroupBy char(20);
  declare In_BasisPolicyId1 char(20);
  declare In_BasisPolicyId2 char(20);
  declare In_BasisPolicyId3 char(20);
  declare CurStartDate date;
  declare CurEndDate date;
  declare PrevStartDate date;
  declare PrevEndDate date;
  declare LatestBasis1Value char(20);
  declare LatestBasis1EffectiveDate date;
  declare LatestBasis2Value char(20);
  declare LatestBasis2EffectiveDate date;
  declare LatestBasis3Value char(20);
  declare LatestBasis3EffectiveDate date;
  declare Out_Basis_TOTAL integer;
  declare Out_Basis_PREV integer;
  declare Out_Basis_NEW integer;
  declare Out_Basis_RESIGN integer;
  declare Out_AnlysDisplaySysId char(30);
  declare Out_AnlysItemDesc char(50);
  declare Out_AnlysMapField char(100);
  declare SQL1 char(200);
  declare SQL2 char(200);
  declare SQL3 char(200);
  declare SQL4 char(200);
  declare SQL5 char(200);
  declare SQL6 char(200);
  declare SQL7 char(200);
  declare msg1 char(200);
  declare msg2 char(200);
  declare StartTime time;
  declare EndTime time;
  declare AnalysisBasisDebug integer;
  /*------------------------------------------------------
  Intialise
  ------------------------------------------------------*/
  set AnalysisBasisDebug=1;
  set StartTime=now(*);
  message 'Movement Engine' type info to client;
  message '------------------------------------------------------' type info to client;
  set Out_Error=0;
  /*------------------------------------------------------
  Extract Information from Analysis Project
  ------------------------------------------------------*/
  select CycleGroupBy,BasisPolicyId1,BasisPolicyId2,BasisPolicyId3 into In_CycleGroupBy,
    In_BasisPolicyId1,In_BasisPolicyId2,
    In_BasisPolicyId3 from AnlysProject where AnlysProjectId = In_AnlysProjectId;
  /*------------------------------------------------------
  Compute No Of Basis
  ------------------------------------------------------*/
  if(In_Basis2 is null or In_Basis2 = '') then set NoOfBasis=1
  elseif(In_Basis3 is null or In_Basis3 = '') then set NoOfBasis=2
  else set NoOfBasis=3
  end if;
  /*------------------------------------------------------
  Compute Date
  ------------------------------------------------------*/
  if(In_CycleGroupBy = 'CalenGrpYr') then
    set CurStartDate=cast(cast(In_Year as char(4))+'-'+cast(In_Month as char(2))+'-01' as date);
    set CurEndDate=DateAdd(month,1,CurStartDate)-1;
    set CurStartDate=DateAdd(month,1,DateAdd(year,-1,CurStartDate));
    set PrevEndDate=CurStartDate-1;
    set PrevStartDate=DateAdd(year,-1,CurStartDate)
  else
    set CurStartDate=cast(cast(In_Year as char(4))+'-'+cast(In_Month as char(2))+'-01' as date);
    set CurEndDate=DateAdd(month,1,CurStartDate)-1;
    set PrevStartDate=DateAdd(month,-1,CurStartDate);
    set PrevEndDate=CurStartDate-1
  end if;
  message '' type info to client;
  message 'Previous Date Range : '+cast(PrevStartDate as char(10))+' to '+cast(PrevEndDate as char(10)) type info to client;
  message 'Current Date Range : '+cast(CurStartDate as char(10))+' to '+cast(CurEndDate as char(10)) type info to client;
  message '' type info to client;
  /*------------------------------------------------------
  Create Temporary Table to contain Basis 1,2,3 Information
  ------------------------------------------------------*/
  message 'View Table Updated' type info to client;
  if not exists(select* from View_Systable where Table_name = 'AnlysBasis1') then
    create global temporary table dba.AnlysBasis1(
      BasisValue char(20) not null,
      BasisEffectiveDate date not null,
      primary key(BasisValue,
      BasisEffectiveDate),
      ) on commit delete rows;
    message 'Basis 1 Table Created' type info to client
  else
    delete from AnlysBasis1
  end if;
  if not exists(select* from View_Systable where Table_name = 'AnlysBasis2') then
    create global temporary table dba.AnlysBasis2(
      BasisValue char(20) not null,
      BasisEffectiveDate date not null,
      primary key(BasisValue,
      BasisEffectiveDate),
      ) on commit delete rows;
    message 'Basis 2 Table Created' type info to client
  else
    delete from AnlysBasis2
  end if;
  if not exists(select* from View_Systable where Table_name = 'AnlysBasis3') then
    create global temporary table dba.AnlysBasis3(
      BasisValue char(20) not null,
      BasisEffectiveDate date not null,
      primary key(BasisValue,
      BasisEffectiveDate),
      ) on commit delete rows;
    message 'Basis 3 Table Created' type info to client
  else
    delete from AnlysBasis3
  end if;
  /*------------------------------------------------------
  Create Movement List
  ------------------------------------------------------*/
  if not exists(select* from View_Systable where Table_name = 'AnlysMovement') then
    create global temporary table dba.AnlysMovement(
      EmployeeSysId integer not null,
      Basis1Value char(20) not null,
      Basis1EffectiveDate date not null,
      Basis2Value char(20) not null,
      Basis2EffectiveDate date not null,
      Basis3Value char(20) not null,
      Basis3EffectiveDate date not null,
      Basis_PREV integer not null,
      Basis_IN integer not null,
      Basis_OUT integer not null,
      Basis_NEW integer not null,
      Basis_RESIGN integer not null,
      Basis_TOTAL integer not null,
      primary key(EmployeeSysId,
      Basis1Value,
      Basis1EffectiveDate,
      Basis2Value,
      Basis2EffectiveDate,
      Basis3Value,
      Basis3EffectiveDate),
      ) on commit delete rows;
    message 'Movement Table Created' type info to client
  else
    delete from AnlysMovement
  end if;
  /*------------------------------------------------------
  Create Temporary Table to contain ViewTable Information
  ------------------------------------------------------*/
  if not exists(select* from View_Systable where Table_name = 'AnlysViewTable') then
    create global temporary table dba.AnlysViewTable(
      EmployeeSysId integer not null,
      primary key(EmployeeSysId),
      ) on commit delete rows
  end if;
  execute immediate('DELETE From AnlysViewTable');
  execute immediate('INSERT INTO AnlysViewTable (EmployeeSysId) Select EmployeeSysId FROM '+In_ViewTable+' Where EmployeeSysId is not null');
  if not exists(select* from AnlysViewTable) then
    message 'No Employee to process' type info to client;
    return
  end if;
  /*------------------------------------------------------
  Process each Employee in the View Table
  ------------------------------------------------------*/
  ViewTableLoop: for ViewTableFor as curs dynamic scroll cursor for
    select EmployeeSysId as In_EmployeeSysId,
      EmployeeID as In_EmployeeID,
      HireDate as In_HireDate,
      CessationDate as In_CessationDate from
      Employee where
      EmployeeSysId = any(select EmployeeSysId from AnlysViewTable) and
      HireDate <= CurEndDate and
      (CessationDate >= CurStartDate or CessationDate = '1899-12-30' or CessationDate is null) order by
      EmployeeID asc do
    /*------------------------------------------------------
    Extract Hire / Cessation Date
    ------------------------------------------------------*/
    message '' type info to client;
    if(In_CessationDate = '1899-12-30') then
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+')  Hire Date : '+cast(In_HireDate as char(10)) type info to client
    else
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+')  Hire Date : '+cast(In_HireDate as char(10))+'   Cessation Date : '+cast(In_CessationDate as char(10)) type info to client
    end if;
    /*------------------------------------------------------
    Initialise
    ------------------------------------------------------*/
    set LatestBasis2Value='';
    set LatestBasis3Value='';
    set LatestBasis2EffectiveDate='1899-12-30';
    set LatestBasis3EffectiveDate='1899-12-30';
    /*------------------------------------------------------
    Prepare Basis 1 Table and Extract the latest record
    ------------------------------------------------------*/
    delete from AnlysBasis1;
    call ASQLAnalysisBasis(In_EmployeeSysId,In_Basis1,In_BasisPolicyId1,'AnlysBasis1',CurStartDate,CurEndDate,PrevStartDate,PrevEndDate,In_CessationDate,AnalysisBasisDebug);
    if not exists(select* from AnlysBasis1) then
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has no records in Basis 1' type info to client;
      set Out_Error=In_EmployeeSysId;
      return
    end if;
    select first BasisValue,BasisEffectiveDate into LatestBasis1Value,
      LatestBasis1EffectiveDate from AnlysBasis1 order by BasisEffectiveDate desc;
    /*------------------------------------------------------
    Prepare Basis 2 Table and Extract the latest record
    ------------------------------------------------------*/
    if(NoOfBasis >= 2) then
      delete from AnlysBasis2;
      call ASQLAnalysisBasis(In_EmployeeSysId,In_Basis2,In_BasisPolicyId2,'AnlysBasis2',CurStartDate,CurEndDate,PrevStartDate,PrevEndDate,In_CessationDate,AnalysisBasisDebug);
      if not exists(select* from AnlysBasis2) then
        message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has no records in Basis 2' type info to client;
        set Out_Error=In_EmployeeSysId;
        return
      end if;
      select first BasisValue,BasisEffectiveDate into LatestBasis2Value,
        LatestBasis2EffectiveDate from AnlysBasis2 order by BasisEffectiveDate desc
    end if;
    /*------------------------------------------------------
    Prepare Basis 3 Table and Extract the latest record
    ------------------------------------------------------*/
    if(NoOfBasis >= 3) then
      delete from AnlysBasis3;
      call ASQLAnalysisBasis(In_EmployeeSysId,In_Basis3,In_BasisPolicyId3,'AnlysBasis3',CurStartDate,CurEndDate,PrevStartDate,PrevEndDate,In_CessationDate,AnalysisBasisDebug);
      if not exists(select* from AnlysBasis3) then
        message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has no records in Basis 3' type info to client;
        set Out_Error=In_EmployeeSysId;
        return
      end if;
      select first BasisValue,BasisEffectiveDate into LatestBasis3Value,
        LatestBasis3EffectiveDate from AnlysBasis3 order by BasisEffectiveDate desc
    end if;
    /*------------------------------------------------------
    Output Latest
    ------------------------------------------------------*/
    set msg1=LatestBasis1Value+space(5)+cast(LatestBasis1EffectiveDate as char(10));
    if(NoOfBasis >= 2) then
      set msg1=msg1+space(5)+LatestBasis2Value+space(5)+cast(LatestBasis2EffectiveDate as char(10))
    end if;
    if(NoOfBasis >= 3) then
      set msg1=msg1+space(5)+LatestBasis3Value+space(5)+cast(LatestBasis3EffectiveDate as char(10))
    end if;
    message '' type info to client;
    message '   Latest : '+msg1 type info to client;
    /*------------------------------------------------------
    Drive Basis 1
    ------------------------------------------------------*/
    call ASQLAnalysisDriveBasis1(NoOfBasis,
    In_EmployeeSysId,
    In_HireDate,
    In_CessationDate,
    CurStartDate,
    CurEndDate,
    PrevStartDate,
    PrevEndDate,
    LatestBasis1Value,
    LatestBasis1EffectiveDate,
    LatestBasis2Value,
    LatestBasis2EffectiveDate,
    LatestBasis3Value,
    LatestBasis3EffectiveDate,Out_Error);
    if(Out_Error > 0) then return
    end if;
    /*------------------------------------------------------
    Drive Basis 2
    ------------------------------------------------------*/
    if(NoOfBasis >= 2) then
      call ASQLAnalysisDriveBasis2(NoOfBasis,
      In_EmployeeSysId,
      In_HireDate,
      In_CessationDate,
      CurStartDate,
      CurEndDate,
      PrevStartDate,
      PrevEndDate,
      LatestBasis1Value,
      LatestBasis1EffectiveDate,
      LatestBasis2Value,
      LatestBasis2EffectiveDate,
      LatestBasis3Value,
      LatestBasis3EffectiveDate,Out_Error);
      if(Out_Error > 0) then return
      end if
    end if;
    /*------------------------------------------------------
    Drive Basis 3
    ------------------------------------------------------*/
    if(NoOfBasis >= 3) then
      call ASQLAnalysisDriveBasis3(NoOfBasis,
      In_EmployeeSysId,
      In_HireDate,
      In_CessationDate,
      CurStartDate,
      CurEndDate,
      PrevStartDate,
      PrevEndDate,
      LatestBasis1Value,
      LatestBasis1EffectiveDate,
      LatestBasis2Value,
      LatestBasis2EffectiveDate,
      LatestBasis3Value,
      LatestBasis3EffectiveDate,Out_Error);
      if(Out_Error > 0) then return
      end if
    end if;
    /*------------------------------------------------------
    Ensure the Employee has 0 or 1 count in Total only and Previous <=1
    ------------------------------------------------------*/
    select sum(Basis_TOTAL),
      sum(Basis_PREV),
      sum(Basis_NEW),
      sum(Basis_RESIGN) into Out_Basis_TOTAL,
      Out_Basis_PREV,
      Out_Basis_NEW,
      Out_Basis_RESIGN from AnlysMovement where EmployeeSysId = In_EmployeeSysId;
    if(Out_Basis_TOTAL < 0 or Out_Basis_TOTAL > 1) then
      set Out_Error=In_EmployeeSysId;
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has invalid TOTAL' type info to client;
      return
    end if;
    if(Out_Basis_PREV > 1) then
      set Out_Error=In_EmployeeSysId;
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has invalid PREVIOUS' type info to client;
      return
    end if;
    if(Out_Basis_NEW > 1) then
      set Out_Error=In_EmployeeSysId;
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has invalid NEW' type info to client;
      return
    end if;
    if(Out_Basis_RESIGN > 1) then
      set Out_Error=In_EmployeeSysId;
      message 'Employee : '+In_EmployeeID+'('+cast(In_EmployeeSysId as char(20))+') has invalid RESIGN' type info to client;
      return
    end if end for;
  // Employee Loop
  /*------------------------------------------------------
  Perform Group By on Movement List
  ------------------------------------------------------*/
  message '' type info to client;
  GroupByLoop: for GroupByFor as GroupByCurs dynamic scroll cursor for
    select Basis1Value as Out_Basis1Value,
      Basis2Value as Out_Basis2Value,
      Basis3Value as Out_Basis3Value,
      Sum(Basis_PREV) as TotalBasis_PREV,
      Sum(Basis_IN) as TotalBasis_IN,
      Sum(Basis_OUT) as TotalBasis_OUT,
      Sum(Basis_NEW) as TotalBasis_NEW,
      Sum(Basis_RESIGN) as TotalBasis_RESIGN,
      Sum(Basis_TOTAL) as TotalBasis_TOTAL from AnlysMovement
      group by Basis1Value,
      Basis2Value,
      Basis3Value do
    /*------------------------------------------------------
    Update to Analsysis Table
    ------------------------------------------------------*/
    set SQL1='Insert into AnlysItemRecord(AnlysItemRecSGSPGenId,AnlysItemRecIndex,AnlysProjectId,AnlysIPAddress,';
    set SQL2='AnlysItemRecYear,AnlysItemRecPeriodMonth,AnlysItemRecSubPeriod,AnlysPayRecBasis,';
    set SQL3='Basis1Id,Basis2Id,Basis3Id,AnlysItem1Id,AnlysItemDesc,AnlysDisplaySysId,';
    set SQL4=') values( FGetNewSGSPGeneratedIndex(''AnlysItemRecord''),1,'''+In_AnlysProjectId+''','''+In_IPAddress+''',';
    set SQL5=cast(In_Year as char(4))+','+cast(In_Month as char(2))+',0,'''',';
    set SQL6=''''+Out_Basis1Value+''','''+Out_Basis2Value+''','''+Out_Basis3Value+''',';
    /*------------------------------------------------------
    Store Previous
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvPrevTotal',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvPrevTotal'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_PREV as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if;
    /*------------------------------------------------------
    Store Current Resign
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvCurResign',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvCurResign'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_RESIGN as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if;
    /*------------------------------------------------------
    Store Current In
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvCurIn',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvCurIn'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_IN as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if;
    /*------------------------------------------------------
    Store Current Out
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvCurOut',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvCurOut'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_OUT as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if;
    /*------------------------------------------------------
    Store Current New
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvCurNew',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvCurNew'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_NEW as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if;
    /*------------------------------------------------------
    Store Current Total
    ------------------------------------------------------*/
    call ASQLAnalysisLookup(In_AnlysProjectId,'Movement','FMvCurTotal',
    Out_AnlysDisplaySysId,
    Out_AnlysItemDesc,
    Out_AnlysMapField);
    if(Out_AnlysMapField <> '') then
      set SQL7='''FMvCurTotal'','''+Out_AnlysItemDesc+''','''+Out_AnlysDisplaySysId+''','+cast(TotalBasis_TOTAL as char(12))+')';
      execute immediate(SQL1+SQL2+SQL3+Out_AnlysMapField+SQL4+SQL5+SQL6+SQL7)
    end if end for;
  commit work;
  /*------------------------------------------------------
  To clear temporary tables
  ------------------------------------------------------*/
  /*
  if exists(select* from View_Systable where Table_name = 'AnlysViewTable') then
  drop table AnlysViewTable
  end if;
  if exists(select* from View_Systable where Table_name = 'AnlysBasis1') then
  drop table AnlysBasis1
  end if;
  if exists(select* from View_Systable where Table_name = 'AnlysBasis2') then
  drop table AnlysBasis2
  end if;
  if exists(select* from View_Systable where Table_name = 'AnlysBasis3') then
  drop table AnlysBasis3
  end if;
  if exists(select* from View_Systable where Table_name = 'AnlysMovement') then
  drop table AnlysMovement
  end if;
  */
  set EndTime=now(*);
  message '' type info to client;
  message 'Time Taken (min) : '+cast(datediff(minute,StartTime,EndTime) as char(50)) type info to client
end
;

create procedure DBA.DeleteAnlysBasisPolicy(
in In_AnlysBasisPolicyId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AnlysProject where
      BasisPolicyId1 = In_AnlysBasisPolicyId or
      BasisPolicyId2 = In_AnlysBasisPolicyId or
      BasisPolicyId3 = In_AnlysBasisPolicyId) then
    if exists(select* from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
      delete from AnlysPolicyRange where AnlysBasisPolicyId = In_AnlysBasisPolicyId;
      delete from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId;
      commit work;
      if exists(select* from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewAnlysBasisPolicy(
in In_AnlysBasisPolicyId char(20),
in In_AnlysBasis char(20),
in In_AnlysBasisPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
    insert into AnlysBasisPolicy(AnlysBasisPolicyId,AnlysBasis,AnlysBasisPolicyDesc) values(
      In_AnlysBasisPolicyId,In_AnlysBasis,In_AnlysBasisPolicyDesc);
    commit work;
    if not exists(select* from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateAnlysBasisPolicy(
in In_AnlysBasisPolicyId char(20),
in In_AnlysBasis char(20),
in In_AnlysBasisPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysBasisPolicy where AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
    update AnlysBasisPolicy set
      AnlysBasis = In_AnlysBasis,
      AnlysBasisPolicyDesc = In_AnlysBasisPolicyDesc where
      AnlysBasisPolicyId = In_AnlysBasisPolicyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetBasicRateProgressionForeignLocalRate(
in In_EffectiveDate date,
in In_ExchangeRateId char(20))
returns double
begin
  declare Out_ForeignLocalRate double;
  select first ForeignLocalRate into Out_ForeignLocalRate from ExchangeRateProg where
    ExchangeRateId = In_ExchangeRateId and ExChgRateEffectiveDate <= In_EffectiveDate order by
    ExChgRateEffectiveDate desc;
  return(Out_ForeignLocalRate)
end
;

create procedure DBA.DeleteAnlysPolicyRange(
in In_AnlysPolicyRangeCode char(20),
in In_AnlysBasisPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysPolicyRange where
      AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
      AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
    delete from AnlysPolicyRange where
      AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
      AnlysBasisPolicyId = In_AnlysBasisPolicyId;
    commit work;
    if exists(select* from AnlysPolicyRange where
        AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
        AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure DBA.InsertNewAnlysPolicyRange(
in In_AnlysPolicyRangeCode char(20),
in In_AnlysBasisPolicyId char(20),
in In_AnlysRangeUpTo double,
out Out_ErrorCode integer)
begin
  if not exists(select* from AnlysPolicyRange where
      AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
      AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
    insert into AnlysPolicyRange(AnlysPolicyRangeCode,AnlysBasisPolicyId,AnlysRangeUpTo) values(
      In_AnlysPolicyRangeCode,In_AnlysBasisPolicyId,In_AnlysRangeUpTo);
    commit work;
    if not exists(select* from AnlysPolicyRange where
        AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
        AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateAnlysPolicyRange(
in In_AnlysPolicyRangeCode char(20),
in In_AnlysBasisPolicyId char(20),
in In_AnlysRangeUpTo double,
out Out_ErrorCode integer)
begin
  if exists(select* from AnlysPolicyRange where
      AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
      AnlysBasisPolicyId = In_AnlysBasisPolicyId) then
    update AnlysPolicyRange set
      AnlysBasisPolicyId = In_AnlysBasisPolicyId,
      AnlysRangeUpTo = In_AnlysRangeUpTo where
      AnlysPolicyRangeCode = In_AnlysPolicyRangeCode and
      AnlysBasisPolicyId = In_AnlysBasisPolicyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

