if not exists(Select * From Registry where RegistryId='Indonesia') then
insert into Registry values('Indonesia','Indonesia');
end if;

if not exists(Select * From SubRegistry where RegistryId='Indonesia' and SubRegistryId ='JamsoCessPayment') then
insert into SubRegistry (RegistryId,SubRegistryId,BooleanAttr) values('Indonesia','JamsoCessPayment',1);
else
update SubRegistry set BooleanAttr=1 where RegistryId = 'Indonesia' and SubRegistryId = 'JamsoCessPayment';
end if;

commit work;