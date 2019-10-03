READ UpgradeDB\Ver1061007\ID_BPJSTKGrp1Policy.sql;
READ UpgradeDB\Ver1061007\ID_BPJSTKGrp2Policy.sql;
READ UpgradeDB\Ver1061007\ID_BPJSTKGrp3Policy.sql;
READ UpgradeDB\Ver1061007\ID_BPJSTKGrp4Policy.sql;
READ UpgradeDB\Ver1061007\ID_BPJSTKGrp5Policy.sql;

if not exists (select 1 from DBA.BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Citibank GDFF V7.0') then
  insert into DBA.BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Citibank GDFF V7.0', 'RIndoBankFormatCitibankVer70.dll', 'InvokeSalaryFormatter', 0)
end if; 

commit work;