if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Bank Islam (EFT)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Bank Islam (EFT)', 'RMalayBankFormatBankIslamEFT.dll', 'InvokeSalaryFormatter', 0);
end if;


if exists (select 1 from sys.sysprocedure where proc_name = 'FGetPrecedingArrears') then
  drop FUNCTION FGetPrecedingArrears;
end if;

CREATE FUNCTION "DBA"."FGetPrecedingArrears"(
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare In_ArrearAmt double;

  if(In_PayRecYear>=2016) Then
    select 
    SUM(AllowanceAmount)  into In_ArrearAmt 
    From (AllowanceRecord Left Outer Join AllowanceHistoryRecord)
    Join Formula on (FormulaId=AllowanceFormulaId) 
    Join Employee on (AllowanceRecord.EmployeeSysId=Employee.EmployeeSysId)
    where (Employee.personalsysid = In_PersonalSysId)  and
    Year(AllowanceDeclaredDate) < In_PayRecYear and
    PayRecYear = In_PayRecYear;
  
  else
    select Sum(if Year(AllowanceDeclaredDate) = AllowanceRecord.PayRecYear - 1 then
    AllowanceAmount else UserDef1Value endif) into In_ArrearAmt 
    From (AllowanceRecord Left Outer Join AllowanceHistoryRecord)
    Join Formula on (FormulaId=AllowanceFormulaId) 
    Join Employee on (AllowanceRecord.EmployeeSysId=Employee.EmployeeSysId)
    where (Employee.personalsysid = In_PersonalSysId)  and
    Year(AllowanceDeclaredDate) < In_PayRecYear and
    PayRecYear = In_PayRecYear;
    
end if;
    
  if In_ArrearAmt is null then set In_ArrearAmt=0
  end if;
  return In_ArrearAmt
end;


commit work;