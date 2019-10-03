/* eProtalVersion */
if not exists(select * from ePortalVersion where EPE = '1060300') then
  insert into ePortalVersion(EPE,ePortal) Values ('1060300','1030000');
end if; 

if not exists(select * from ePortalVersion where EPE = '1060400') then
  insert into ePortalVersion(EPE,ePortal) Values ('1060400','1030000');
end if; 

if not exists(select * from ePortalVersion where EPE = '1060500') then
  insert into ePortalVersion(EPE,ePortal) Values ('1060500','1030000');
end if; 

Update DBA.SubRegistry set BooleanAttr = 1 where SubRegistryID='TaskOn' ;

commit work;