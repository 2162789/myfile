READ UpgradeDB\Ver9930\Entity.sql;
READ UpgradeDB\Ver9930\SpecialRequest.sql;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxRecordEmployeeSysId' and user_name(creator) = 'DBA') then
   drop procedure DBA.FGetMalTaxRecordEmployeeSysId
end if;


CREATE FUNCTION "DBA"."FGetMalTaxRecordEmployeeSysId"(
in In_PersonalSysId integer,
in In_MalTaxYear integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare TaxEmploymentCount integer;
  select Count(*) into TaxEmploymentCount from MalTaxEmployee where
    PersonalSysId = In_PersonalSysId and
    MalTaxYear = In_MalTaxYear;
  /*
  Only 1 Employment (No Rejoin)
  */
  if(TaxEmploymentCount = 1) then
    select MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  else
    /*
    Assume the latest especially for Histroical Records that are not fixed
    User should split the current year records
    */
    select first MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear order by ToPayRecYear desc,ToPayRecPeriod desc
  end if;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  return(Out_EmployeeSysId)
end;


UPDATE "DBA"."subRegistry" SET IntegerAttr=9930, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;