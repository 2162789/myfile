if not exists (select 1 from ePortalVersion where EPE = '1070000') then
  insert into ePortalVersion (EPE, ePortal)
  values ('1070000', '1030000')
end if;

commit work;