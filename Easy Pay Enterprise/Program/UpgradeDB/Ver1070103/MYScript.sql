
if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxCategory') then
   drop PROCEDURE FGetMalTaxCategory;
end if;

CREATE FUNCTION "DBA"."FGetMalTaxCategory"(
in in_PersonalSysId integer,
in in_PayRecYear integer)
returns char(50)
begin
  declare Out_TaxCategory char(50);
  select TOP 1 TaxCategory into Out_TaxCategory from PeriodPolicySummary where
    EmployeeSysId in(select EmployeeSysId from employee where Personalsysid  = in_PersonalSysId) and
    PayRecYear = in_PayRecYear order by PayRecPeriod DESC;
  if Out_TaxCategory is null then set Out_TaxCategory=''
  end if;
  return Out_TaxCategory
end ;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxNoChildRelief') then
   drop PROCEDURE FGetMalTaxNoChildRelief;
end if;

CREATE FUNCTION "DBA"."FGetMalTaxNoChildRelief"(
in in_PersonalSysId integer,
in in_MalTaxYear integer)
returns integer
begin
  declare Out_TaxNoChidlRelief char(50);
  select TOP 1 MalTaxNoChildRelief into Out_TaxNoChidlRelief from MalTaxrecord where
    Personalsysid  = in_PersonalSysId and
    FGetMalTaxRecordYear(MalTaxYear) = in_MalTaxYear order by MalTaxHireDate DESC;
  if Out_TaxNoChidlRelief is null then set Out_TaxNoChidlRelief=0
  end if;
  return Out_TaxNoChidlRelief
end;




commit work;