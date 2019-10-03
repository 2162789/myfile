READ UpgradeDB\Ver1060903\2015MY_PH.sql;

if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='SALARY' and formatname='Maybank 2E-RC') Then
   insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('Salary','Maybank 2E-RC','RMalayBankFormatMaybank2ERC.dll','InvokeSalaryFormatter',0);
end if;



commit work;