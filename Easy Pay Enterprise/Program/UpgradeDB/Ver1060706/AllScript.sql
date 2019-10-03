READ UpgradeDB\Ver1060706\Entity.sql;

if not exists(select * from ePortalVersion where EPE = '1060800') then
   insert into ePortalVersion (EPE,ePortal)
   values('1060800','1030000');
end if;

Commit work;

