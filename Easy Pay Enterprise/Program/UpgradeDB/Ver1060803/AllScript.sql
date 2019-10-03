READ UpgradeDB\Ver1060803\entity.sql;
READ UpgradeDB\Ver1060803\StoredProc.sql;

if not exists(select * from Subregistry where RegistryId = 'PaySetupDataLv' and SubRegistryid = 'AnnualLvEncash') then
Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr) 
Values ('PaySetupDataLv','AnnualLvEncash','Check','Annual Leave Balance Encashment upon Cessation','BooleanAttr','N','','','','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from Subregistry where RegistryId = 'PaySetupDataLv' and SubRegistryid = 'EncashPayElementID') then
Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
Values ('PaySetupDataLv','EncashPayElementID','Combo','Annual Leave Balance Encashment Pay Element ID','ShortStringAttr','Y','Formula','FormulaID','SELECT FormulaID, FormulaDesc FROM Formula WHERE FormulaSubCategory IN (''Allowance'', ''Deduction'') AND FormulaId IN (Select FormulaId FROM FormulaProperty where KeywordID=''GRPCode'');','FormulaId\x0920\x09Formula\x09F','FormulaDesc\x0980\x09Description\x09F','',0.0,0,'',0,'Sys_ANLEncashment','','1899-12-30','1899-12-30 00:00:00.000');
end if;

commit work;