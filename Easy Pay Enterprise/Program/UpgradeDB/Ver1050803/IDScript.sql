if not exists(Select * From Registry where RegistryId='Indonesia') then
insert into Registry values('Indonesia','Indonesia');
end if;

if not exists(Select * From SubRegistry where RegistryId='Indonesia' and SubRegistryId ='JamsoCessPayment') then
insert into SubRegistry (RegistryId,SubRegistryId,BooleanAttr) values('Indonesia','JamsoCessPayment',0);
end if;

commit work;
