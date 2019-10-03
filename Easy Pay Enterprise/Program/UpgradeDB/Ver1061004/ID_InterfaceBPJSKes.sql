/* Interface */
if not exists(select * from Subregistry Where RegistryId = 'InterfaceAttribute' and SubRegistryId = 'PersonalName') then
   Insert into Subregistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('InterfaceAttribute','PersonalName','Personal','','','','','','PersonalName','Name','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from Subregistry Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDBPJSKesStatus') then
   Insert into Subregistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('InterfaceCodeTable','YTDBPJSKesStatus','YTD Process','','','','','','SELECT KeyWordId AS EPEID, KeyWordUserDefinedName AS EPEIDDesc FROM KeyWord WHERE KeyWordCategory = ''BPJSKSStatus''','BPJS Kesehatan Status','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from Subregistry Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDBPJSKesMarStatus') then
   Insert into Subregistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('InterfaceCodeTable','YTDBPJSKesMarStatus','YTD Process','','','','','','SELECT KeyWordId AS EPEID, KeyWordUserDefinedName AS EPEIDDesc FROM KeyWord WHERE KeyWordCategory = ''BPJSKSMarStatus''','BPJS Kesehatan Marital Status','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Import Designer -> YTD Policy */
Update ImportFieldName Set FieldType = 'String' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'JamsostekStatus';

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'BPJSKesStatus') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','BPJSKesStatus','BPJS Kesehatan Status','String',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'BPJSKesMarStatus') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','BPJSKesMarStatus','BPJS Kesehatan Marital Status','String',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployeeBPJSKes') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','EmployeeBPJSKes','Employee BPJS Kesehatan','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployerBPJSKes') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','EmployerBPJSKes','Employer BPJS Kesehatan','Numeric',0);
end if;

commit work;