if not exists (select 1 from sys.syscolumns where cname = 'MalTaxOtherAllowanceExGratuity' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxOtherAllowanceExGratuity double;
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPrecedingArrears') then
   drop PROCEDURE FGetPrecedingArrears;
end if;

CREATE FUNCTION "DBA"."FGetPrecedingArrears"(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare In_ArrearAmt double;
  select (if Year(AllowanceDeclaredDate) = AllowanceRecord.PayRecYear - 1 then
   SUM(AllowanceAmount) else sum(UserDef1Value) endif) into In_ArrearAmt 
  From (AllowanceRecord Left Outer Join AllowanceHistoryRecord)
  Join Formula on (FormulaId=AllowanceFormulaId) 
Join Employee on (AllowanceRecord.EmployeeSysId=Employee.EmployeeSysId)
where (Employee.personalsysid = In_PersonalSysId)  and
   Year(AllowanceDeclaredDate) < In_PayRecYear and
   PayRecYear = In_PayRecYear
   Group by  PayRecyear,Year(AllowanceDeclaredDate);
    
  if In_ArrearAmt is null then set In_ArrearAmt=0
  end if;
  return In_ArrearAmt
end;

commit work;