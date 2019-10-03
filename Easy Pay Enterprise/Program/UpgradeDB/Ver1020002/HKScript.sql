/*Begin of head for every patch*/
if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then  
   Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/

if not exists (select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'JPMorgan Chase Bank') then
   INSERT INTO BankSubmitFormat 
      (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
   VALUES
      ('Salary','JPMorgan Chase Bank','RHKBankFormatJPMorganChase.dll','InvokeSalaryFormatter',0);
end if;

commit work;

/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/