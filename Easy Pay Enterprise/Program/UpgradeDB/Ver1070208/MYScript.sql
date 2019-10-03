/* SubRegistry */
if not exists(select * from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'MalTaxDetailsViewer') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('Viewer','MalTaxDetailsViewer','Income Tax Details Viewer','CoreModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Interface Code Table */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalTaxPolicyId') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalTaxPolicyId','Employment Process','','','','','','SELECT MalTaxPolicyId as EPEID, MalTaxPolicyDesc as EPEIDDesc FROM MalTaxPolicy','Tax Policy','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalTaxEmployerId') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalTaxEmployerId','Employment Process','','','','','','SELECT MalTaxEmployerId as EPEID,MalTaxEmployerDesc as EPEIDDesc FROM MalTaxEmployer','Tax Employer','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalTaxMethod') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalTaxMethod','Employment Process','','','','','','SELECT KeyWordId as EPEID, KeyWordUserDefinedName as EPEIDDesc FROM Keyword WHERE KeyWordCategory = ''TaxMethod''','Tax Method','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalTaxSpouseBranchId') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalTaxSpouseBranchId','Employment Process','','','','','','SELECT MalTaxBranchId as EPEID, MalTaxBranchDesc as EPEIDDesc FROM MalTaxBranch','Spouse Tax Branch','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalTaxScheme') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalTaxScheme','Employment Process','','','','','','SELECT CoreKeyWordId as EPEID, CoreUserDefinedName as EPEIDDesc FROM CoreKeyword WHERE CoreKeyWordCategory = ''MalTaxScheme'' AND CoreKeyWordId <> ''STD''','Tax Scheme','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Interface Process Selection */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceSelection' and SubRegistryId = 'iMalTaxDetails') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceSelection','iMalTaxDetails','Employment','','','','','','Income Tax Details','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* ImportFieldTable */
if not exists(select * from ImportFieldTable where TableNamePhysical = 'iMalTaxDetails') then 
   insert into ImportFieldTable(TableNamePhysical,TableNameUserDefined)
   values('iMalTaxDetails','Income Tax Details');
end if;

/* ImportFieldName */
if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxDetailsIdentityNo') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxDetailsIdentityNo','Identity No','String',1);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxPolicyId') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxPolicyId','Tax Policy','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxEmployerId') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxEmployerId','Tax Employer','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxEETaxRefNo') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxEETaxRefNo','Tax Ref No','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxMethod') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxMethod','Tax Method','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxChildRelief') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxChildRelief','Child Relief Point','Numeric',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxNoChildRelief') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxNoChildRelief','No of Children Eligible for Relief','Integer',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxNoChildBelow18') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxNoChildBelow18','No of Children Below 18','Integer',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxSpouseTaxRefNo') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxSpouseTaxRefNo','Spouse Tax Ref No','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxSpouseWorking') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxSpouseWorking','Spouse Working','Numeric',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxSpouseTaxBranchId') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxSpouseTaxBranchId','Spouse Tax Branch','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxPriority') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxPriority','Tax Priority','Numeric',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'MalTaxScheme') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','MalTaxScheme','Tax Scheme','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalTaxDetails' and FieldNamePhysical = 'IsHandicapped') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalTaxDetails','IsHandicapped','Is Handicapped','Numeric',0);
end if;

--OCBC Bank
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'OCBC Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('SOCSO', 'OCBC Bank', 'RMalayBankFormatOCBC.dll', 'InvokeSOCSOFormatter', 0);
end if;
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'CP39' and FormatName = 'OCBC Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('CP39', 'OCBC Bank', 'RMalayBankFormatOCBC.dll', 'InvokeCP39Formatter', 0);
end if;

commit work;