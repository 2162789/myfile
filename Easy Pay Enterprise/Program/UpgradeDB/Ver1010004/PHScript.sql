if not Exists(Select 1 From SubRegistry where RegistryId ='InterfaceCodeTable' and SubRegistryId ='YTDDMBId')  then

Insert into SubRegistry 
(RegistryId,
SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
Values
('InterfaceCodeTable','YTDDMBId','YTD Process','','','','','','SELECT DMBItemId AS EPEID, DMBDesc AS EPEIDDesc from DeminimisItem','DMB Item','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not Exists(Select 1 From SubRegistry where RegistryId ='Viewer' and SubRegistryId ='YTDDMBRecordViewer')  then

Insert into SubRegistry 
(RegistryId,
SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
Values
('Viewer','YTDDMBRecordViewer','YTD DMB Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');

end if;

if not Exists(Select 1 From ModuleScreenGroup where ModuleScreenId='YTDDMBRecordViewer' and Mod_ModuleScreenId = 'InterfaceViewer')  then

Insert into ModuleScreenGroup
Values
('YTDDMBRecordViewer','InterfaceViewer','YTD DMB Record Viewer','InterfaceViewer',0,0,0,'EC_YTDDMBRecViewer');

end if;

If not Exists(Select TableNamePhysical From ImportFieldTable Where TableNamePhysical = 'iYTDDMBRecord') then

Insert into ImportFieldTable (TableNamePhysical,TableNameUserDefined)
Values('iYTDDMBRecord','YTD DMB Record');

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','YTDDMBEmployeeId','Employee ID','String',1);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','YTDDMBYear','Year','Integer',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','YTDDMBPeriod','Period','Integer',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','YTDDMBId','DMB Item ID','String',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','DMBAmount','DMB Amount','Numeric',0);

Insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
Values('iYTDDMBRecord','RecurDMBId','Recurring DMB Item ID','String',0);

end If;

Update LoanFrom set LoanFromDesc = 'Home Development Mutual Fund Loan' Where LoanFromID = 'HDMF';
commit work;