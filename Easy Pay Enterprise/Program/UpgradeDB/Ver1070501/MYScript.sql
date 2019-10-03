/*
	Add in an option for Auto Socso computation for every sub period
*/
if not exists(select * from Subregistry where Subregistryid = 'PeriodSocso') then
    INSERT INTO SubRegistry (RegistryId, SubRegistryId, DoubleAttr, IntegerAttr, BooleanAttr, DateAttr, DateTimeAttr) VALUES ('PayOption', 'PeriodSocso',0,0,0, '1899-12-30','1899-12-30 00:00:00');
end if;

commit work;