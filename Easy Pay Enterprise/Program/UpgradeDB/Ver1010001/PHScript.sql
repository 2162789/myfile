if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'StatRptOpts' and SubRegistryId = 'MCRF')
then
insert into SubRegistry (
RegistryId,
SubRegistryId,
DoubleAttr,
IntegerAttr,
BooleanAttr,
DateAttr,
DateTimeAttr) 
values ('StatRptOpts','MCRF',0,0,0,'1899-12-30','1899-12-30 00:00:00');
end if;
commit work;