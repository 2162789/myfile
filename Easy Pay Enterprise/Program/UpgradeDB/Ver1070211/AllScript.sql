/* ePortal Version */
if not exists(select * from ePortalVersion where EPE = '1070300') then
   insert into ePortalVersion(EPE,ePortal)
   values('1070300','1030000');
end if;

commit work;