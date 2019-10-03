if not exists(select * from ePortalVersion where EPE = '1060600') then
  insert into ePortalVersion(EPE,ePortal)
  Values('1060600','1030000');
end if;

commit work;