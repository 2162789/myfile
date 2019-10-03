if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'JPMorgan Access (G-ACH)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'JPMorgan Access (G-ACH)', 'RHKBankFormatJPMorganAccessGACH.dll', 'InvokeSalaryFormatter');
end if;
commit work;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020208, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;