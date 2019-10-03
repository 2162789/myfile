if not Exists(Select 1 From SubRegistry where RegistryId ='InterfaceCodeTable' and SubRegistryId ='YTDBIKId')  then

Insert into SubRegistry 
(RegistryId,
SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
Values
('InterfaceCodeTable','YTDBIKId','YTD Process','','','','','','SELECT MALBIKItemId AS EPEID, MALBIKItemDesc AS EPEIDDesc from MALBIKItem','Tax Status','','',0
,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');

end if;

if not Exists(Select 1 From SubRegistry where RegistryId ='Viewer' and SubRegistryId ='YTDBIKRecordViewer')  then

Insert into SubRegistry 
(RegistryId,
SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
Values
('Viewer','YTDBIKRecordViewer','YTD BIK Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');

end if;

if not Exists(Select 1 From ModuleScreenGroup where ModuleScreenId='YTDBIKRecordViewer' and Mod_ModuleScreenId = 'InterfaceViewer')  then

Insert into ModuleScreenGroup
Values
('YTDBIKRecordViewer','InterfaceViewer','YTD BIK Record Viewer','InterfaceViewer',0,0,0,'EC_YTDBIKRecViewer');

end if;

Update Subregistry
Set RegProperty7 = 'SELECT KeyWordId AS EPEID, KeyWordUserDefinedName AS EPEIDDesc FROM KeyWord WHERE KeyWordCategory = ''CPFStatus'''
Where
RegistryId = 'InterfaceCodeTable' And
SubRegistryId = 'YTDTaxStatus';


UPDATE subregistry SET RegProperty3 = 'Current Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'CurrentTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Additional Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'CurrentAddTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'PreviousTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Additional Tax Gross Wage' where  registryid='PayRecordPolicy' and SubRegistryId = 'PreviousAddTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'CurrentTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Additional Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'CurrentAddTaxWage';UPDATE subregistry SET RegProperty3 = 'Previous Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'PreviousTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Additional Tax Gross Wage' where  registryid='PayPeriodPolicy' and SubRegistryId = 'PreviousAddTaxWage';


Update MalBIKItem set MalBIKAddTax=0;


If not Exists(Select TableNamePhysical From ImportFieldTable Where TableNamePhysical = 'iYTDBIKRecord') 
then
Insert into ImportFieldTable (TableNamePhysical,TableNameUserDefined)
Values('iYTDBIKRecord','YTD BIK Record');

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','YTDBIKEmployeeId','Employee ID','String',1);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','YTDBIKYear','Year','Integer',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','YTDBIKPeriod','Period','Integer',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','YTDBIKId','BIK Item ID','String',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','BIKAmount','BIK Amount','Numeric',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDBIKRecord','RecurBIKId','Recurring BIK Item ID','String',0);

end If;

commit work;

