if not exists(select * from Registry where RegistryId = 'YEProcess') then
   insert into Registry(RegistryId, RegistryDesc) values('YEProcess','Income Tax Wizard');
end if;

if not exists(select * from SubRegistry where RegistryId = 'YEProcess' and SubRegistryId = 'Step') then
   insert into SubRegistry(RegistryId,SubRegistryId,IntegerAttr) values('YEProcess','Step',0); 
end if;

commit work;