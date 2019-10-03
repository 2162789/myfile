IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='FGetIRASEmployeeBank') THEN
   drop function FGetIRASEmployeeBank
end if;

create function DBA.FGetIRASEmployeeBank(
in In_EmployeeSysId integer)
returns char(1)
begin
  declare Out_IRASEmployeeBank char(1);
  declare Out_BankId char(20);
  select first BankId into Out_BankId from PaymentBankInfo where EmployeeSysId = In_EmployeeSysId order by PaymentValue desc;
  case Out_BankId when '7171' then
    set Out_IRASEmployeeBank='1' when '7348' then
    set Out_IRASEmployeeBank='2' when '7375' then
    set Out_IRASEmployeeBank='2' when '7339' then
    set Out_IRASEmployeeBank='3' when '7986' then 
    set Out_IRASEmployeeBank='5' when '7214' then
    set Out_IRASEmployeeBank='6' when '7232' then 
    set Out_IRASEmployeeBank='7' when '7302' then
    set Out_IRASEmployeeBank='8' when '7144' then
    set Out_IRASEmployeeBank='9'
  else
    set Out_IRASEmployeeBank='4'
  end case
  ;
  return(Out_IRASEmployeeBank)
end
;

if not exists(select 1 from functiondefinerecord where ProductName = 'Easy Pay Enterprise' and SubProductName = 'Main' and FunctionName = 'Sage HRIS') then 
insert into functiondefinerecord(ProductName,SubProductName,FunctionName,Category)
Values('Easy Pay Enterprise','Main','Sage HRIS',NULL);
end if;

if not exists(select 1 from functiondefinerecord where ProductName = 'Easy Pay Enterprise' and SubProductName = 'Main' and FunctionName = 'Sage Pay Export') then
insert into functiondefinerecord(ProductName,SubProductName,FunctionName,Category)
Values('Easy Pay Enterprise','Main','Sage Pay Export',NULL);
end if;

Update YeKeyword Set YEkeyWordUserDefinedName = 'Others(See paragraph 16 of the Explanatory Notes)',
YEKeywordDefaultName = 'Others(See paragraph 16 of the Explanatory Notes)'
where YEkeywordid = 'OthersFurniture';

Update YeKeyword Set YEkeyWordUserDefinedName = 'Add:2% x (Basic salary p.a. x period provided/366)',
YEKeywordDefaultName = 'Add:2% x (Basic salary p.a. x period provided/366)'
where YEkeywordid = 'plus2%';

commit work;