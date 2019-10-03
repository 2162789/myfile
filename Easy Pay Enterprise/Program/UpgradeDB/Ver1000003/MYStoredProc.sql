if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEmployment') then
   drop procedure ASQLDeleteEmployment
end if
;

CREATE PROCEDURE "DBA"."ASQLDeleteEmployment"(
in In_EmployeeSysId integer)
begin
  declare In_EmployeeId char(30);
  declare In_PersonalSysId integer;
  declare Out_ErrorCode integer;
  call ASQLDeleteLeaveEmployee(In_EmployeeSysId);
  call ASQLDeleteEmployeePayRecords(In_EmployeeSysId);
  call ASQLDeleteEmployeeProgression(In_EmployeeSysId);
  call ASQLDeletePayEmployee(In_EmployeeSysId);
  call ASQLDeleteLeaveEmployee(In_EmployeeSysId);
  call DeleteCostingDetails(In_EmployeeSysId,Out_ErrorCode);
  call DeleteBenefitDetails(In_EmployeeSysId,Out_ErrorCode);
  /*
  Delete Competency
  */
  CompetencyLoop: for CompetencyFor as CompetencyCurs dynamic scroll cursor for
    select CompetencySysId as Out_CompetencySysId from Competency where
      Competency.EmployeeSysId = In_EmployeeSysId do
    call DeleteCompetency(Out_CompetencySysId,Out_ErrorCode) end for;
  /*
  Other Tables
  */
  delete from Succession where EmployeeSysId = In_EmployeeSysId;
  delete from JobRespon where EmployeeSysId = In_EmployeeSysId;
  delete from OtherBankInfo where OtherBankInfo.EmployeeSysId = In_EmployeeSysId;
  delete from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId;
  delete from ContractProgression where ContractProgression.EmployeeSysId = In_EmployeeSysId;
  delete from ShiftCalendar where ShiftCalendar.EmployeeSysId = In_EmployeeSysId;
  select EmployeeId into In_EmployeeId from Employee where EmployeeSysId = In_EmployeeSysId;
  select PersonalSysId into In_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  /*
  Delete Malaysia Tax Record
  */
  if(FGetDBCountry(*) = 'Malaysia') then
    DeleteMalTaxRecordLoop: for MalTaxRecordFor as curs dynamic scroll cursor for
      select MalTaxYear as Out_MalTaxYear from
        MalTaxRecord where PersonalSysId = In_PersonalSysId and
        FGetMalTaxRecordEmployeeSysId(PersonalSysId,MalTaxYear) = In_EmployeeSysId do
      call DeleteMalTaxRecord(In_PersonalSysId,In_EmployeeSysId,Out_MalTaxYear,Out_ErrorCode) end for
  end if;
  call DeleteEmployeeRecord(In_EmployeeSysId,In_EmployeeId)
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'IsMalAllowanceHasRebateProperty') then
   drop procedure IsMalAllowanceHasRebateProperty
end if
;

CREATE FUNCTION "DBA"."IsMalAllowanceHasRebateProperty"(in In_FormulaId char(20))
returns integer
begin
  declare Out_result integer;
  select Count(*) into Out_result from FormulaProperty where FormulaId = In_FormulaId and KeywordId = any(select distinct RebateProperty from RebateItem);
  if Out_result >= 1 then return 1
  end if;
  return 0
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxEmployer') then
   drop procedure DeleteMalTaxEmployer
end if
;

create procedure
dba.DeleteMalTaxEmployer(in In_MalTaxEmployerId char(20),out ErrorCode integer)
begin
  if exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
	delete from MalTaxReceipt where MalTaxEmployerId = In_MalTaxEmployerId;
	delete from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId;
    commit work;
    if exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
      set ErrorCode=0
    else
      set ErrorCode=1
    end if
  else
    set ErrorCode=0
  end if;
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxRecordEmployeeSysId2') then
   drop procedure FGetMalTaxRecordEmployeeSysId2
end if
;

create function
dba.FGetMalTaxRecordEmployeeSysId2(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_PayRecPeriod integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  select distinct MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
    PersonalSysId = In_PersonalSysId and
    FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear and
    In_PayRecPeriod between FromPayRecPeriod and ToPayRecPeriod;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  return(Out_EmployeeSysId)
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxExemptFromEr') then
   drop procedure FGetMalTaxExemptFromEr
end if
;

create function
dba.FGetMalTaxExemptFromEr(
in In_RebateID char(20))
returns integer
begin
  declare Out_result integer;
  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication',
				'Employer Goods','Employer Service','Loan Interest','Other Medical','Innovation',
				'Gift New Computer','Lve Passage','Lve Passage Overseas','Foreign Insurance','Group Insurance') then
      1 else 0 endif) into Out_result;
  return(Out_result)
end
;
