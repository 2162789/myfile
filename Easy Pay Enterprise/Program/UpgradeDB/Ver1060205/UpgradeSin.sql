READ UpgradeDB\Ver1060205\AllScript.sql;

if not exists (Select * from BankSubmitFormat Where FormatName='BOA (IPS)' and DllName='RSingBankFormatBOAIPS.dll') then
   Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
   Values('Salary','BOA (IPS)','RSingBankFormatBOAIPS.dll','InvokeSalaryFormatter')
end if
;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060205, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;