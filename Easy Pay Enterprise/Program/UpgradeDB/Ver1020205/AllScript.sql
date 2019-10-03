if not exists(select * from ePortalVersion where EPE='8400') then 
	insert into ePortalVersion values('8400', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8402') then 
	insert into ePortalVersion values('8402', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8420') then 
	insert into ePortalVersion values('8420', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8500') then 
	insert into ePortalVersion values('8500', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8510') then 
	insert into ePortalVersion values('8510', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8520') then 
	insert into ePortalVersion values('8520', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='8530') then 
	insert into ePortalVersion values('8530', '7600');
end if;

if not exists(select * from ePortalVersion where EPE='1020000') then 
	insert into ePortalVersion values('1020000', '1020000');
end if;


if not exists(select * from ePortalVersion where EPE='1020100') then 
	insert into ePortalVersion values('1020100', '1020000');
end if;

if not exists(select * from ePortalVersion where EPE='1020200') then 
	insert into ePortalVersion values('1020200', '1020000');
end if;

if not exists(select * from ePortalVersion where EPE='1030000') then 
	insert into ePortalVersion values('1030000', '1030000');
end if;

commit work;

if not exists (select 1 from SubRegistry where RegistryId = 'Application' and SubRegistryId = 'CustomInterface') then
   insert into SubRegistry values ('Application','CustomInterface','CustomInterface','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceAutoCreate' and SubRegistryId = 'ResStatusCareerId') then
   insert into SubRegistry values ('InterfaceAutoCreate','ResStatusCareerId','iResidenceStatusRecord','','','','Career','CareerId','ResStatusCareerId','iCareer','iCareerId','CareerDesc',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Update AnItemLookup set AnlysFunction='sum(CurrERManWage+PrevERManWage)'  where AnlysLookupId='EmperEPFManWage';
Update AnItemLookup set AnlysFunction='sum(CurrERVolWage+PrevERVolWage)' where AnlysLookupId='EmperEPFVolWage';

Update ModuleScreenGroup 
Set HideScreenForWage = 1
where ModuleScreenId = 'ProcExcelExpDetails';

commit work;