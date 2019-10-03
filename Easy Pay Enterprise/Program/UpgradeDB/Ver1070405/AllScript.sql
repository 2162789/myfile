READ UpgradeDB\Ver1070405\Entity.sql;

/*==============================================================*/
/* Report Export                                                */
/*==============================================================*/
if not exists(select * from Keyword where KeyWordId = 'EX_Contact_HandPhone') then
   insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                     KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)									 
   values('EX_Contact_HandPhone','Contact Number (Handphone)','Contact Number (Handphone)','EXPORT',0,0,0,'HandphoneContact',621,5,0,'');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceAutoCreate' and SubRegistryId = 'PassportIssue') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
	                         RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('InterfaceAutoCreate','PassportIssue','iPersonal','','','','Country','CountryId','PassportIssue','iCountry','iCountryId','CountryName',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/*==============================================================*/
/* Contract Progression                                         */
/*==============================================================*/
/* ImportFieldName */
if not exists(select * from ImportFieldName where TableNamePhysical = 'iContractProgression' and FieldNamePhysical = 'ContractCurrent') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iContractProgression','ContractCurrent','Current','Numeric',0);
end if;

commit work;