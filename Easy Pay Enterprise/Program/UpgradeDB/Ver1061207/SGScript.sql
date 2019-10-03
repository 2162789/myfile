delete from reportaccess where ReportExportID='key employment terms';
delete from reportexport where ReportExportID='key employment terms';
Read UpgradeDB\Ver1061207\ReportExport.sql;

if not exists(select * from ReportAccess where ReportExportID='Key Employment Terms') then
   insert into ReportAccess(ReportExportID,UserGroupId) values('Key Employment Terms','MAG');
end if;

/* HSBC New Bank Code */
if not exists (select 1 from Bank where BankId = '9548') then
  insert into Bank (BankId,BankName) values ('9548','HSBC Bank (Singapore) Limited');
end if;

if exists (select 1 from Bank where BankId = '9548') then
  insert into BankBranch (BankId,BankBranchId,BankBranchDesc,BankAddress,BankPCode,BankCity,BankState,BankCountry,BankBranchString1)
  select '9548',BB1.BankBranchId,BB1.BankBranchDesc,BB1.BankAddress,BB1.BankPCode,BB1.BankCity,BB1.BankState,BB1.BankCountry,'HSBCSGS2XXX'
  from BankBranch BB1 left join BankBranch BB2 on BB1.BankBranchId = BB2.BankBranchId and BB2.BankId = '9548' where BB1.BankId = '7232' and BB2.BankBranchId is null;
  update BankBranch set BankBranchString1 = 'HSBCSGS2XXX' where BankId = '9548';
end if;

commit work;