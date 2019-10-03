IF NOT exists(select * from SystemAttribute WHERE SysAttributeId='Ana_AUserDef1Value') THEN
Insert into SystemAttribute 
(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) 
Values('AllowanceRecord','Ana_AUserDef1Value','U1',1,'','','','','');
END IF;

IF NOT exists(select * from AnItemLookup WHERE AnlysLookupId='AUserDef1Value') THEN
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('AUserDef1Value','AllowanceRecord','Ana_AUserDef1Value','Allowance','AnlysAmount2','(AllowanceRecord Left Outer Join AllowanceHistoryRecord)JOIN Formula ON AllowanceFormulaId=FormulaId','sum(UserDef1Value)','FormulaSubCategory=''Allowance''','AnlysFAmount2','AnlysDoubleValue2');
END IF;