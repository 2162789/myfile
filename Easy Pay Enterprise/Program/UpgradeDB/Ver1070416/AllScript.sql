if not exists(select * from ePortalVersion where EPE = '1070500') then
  insert into ePortalVersion(EPE,ePortal) values('1070500','1030000');
end if;

commit work;