if not exists (select * from Registry where RegistryId = 'MalTbhjInfo') then
  insert into Registry (RegistryId, RegistryDesc)
  values ('MalTbhjInfo', 'MalTbhjInfo');
end if;

if not exists (select * from SubRegistry where RegistryId = 'MalTbhjInfo' and SubRegistryId = 'TbhjInfo') then
  insert into SubRegistry (RegistryId, SubRegistryId)
  values ('MalTbhjInfo', 'TbhjInfo');
end if;

commit work;