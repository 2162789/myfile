/* Purpose is to Upgrade 1070300 Blank DB - To insert a row for 'ConsentToUseData' */
if not exists(select * from Subregistry where Subregistryid = 'ConsentToUseData') then
    INSERT INTO SubRegistry (RegistryId, SubRegistryId, DoubleAttr, IntegerAttr, BooleanAttr, DateAttr, DateTimeAttr) VALUES ('System', 'ConsentToUseData',0,0,'1', '1899-12-30','1899-12-30 00:00:00');
end if;

commit work;