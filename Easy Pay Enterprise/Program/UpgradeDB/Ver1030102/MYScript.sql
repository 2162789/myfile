if not exists (select * from BranchGov where BranchGov.BranchGovCategory = 'ZAKAT') then 

insert into BranchGov (
CompanyId, 
BranchId, 
BranchSystem, 
BranchGovCode, 
BranchGovDesc, 
BranchGovCategory) 
SELECT 
'001', 
Branch.BranchId,
1, 
'ZAKAT No', 
'Zakat Employer Reference', 
'ZAKAT'
FROM Branch 

end if;

commit work;

if not exists (select 1 from SubRegistry where RegistryId = 'BranchGov' and SubRegistryId = 'ZAKATNo') then
   insert into SubRegistry values ('BranchGov','ZAKATNo','ZAKAT No','Zakat Employer Reference','ZAKAT','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;