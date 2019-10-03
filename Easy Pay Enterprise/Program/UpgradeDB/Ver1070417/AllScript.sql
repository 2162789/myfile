if not exists (select * from usageitem where usageitemid='ePortalVersion') then
	insert into usageitem (usageitemid, UsageGrpId, ItemDesc, FieldLoc, query, QueryCond) values ( 'ePortalVersion', 'System', 'ePortal Version', 'StringValue', 'SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, datetimeattr as ModDateTime, StringAttr as RetValue FROM SubRegistry WHERE SubRegistryID=''ePortalVersion''', '')
end if;

if not exists (select * from subregistry where SubRegistryId='ePortalVersion') then
	insert into subregistry(RegistryId, SubRegistryId, DoubleAttr, IntegerAttr, BooleanAttr, StringAttr, DateAttr, DateTimeAttr) values('System', 'ePortalVersion', 0, 0, 0,'', '1899-12-30', '1899-12-30 00:00:00.000')
end if;

commit work;