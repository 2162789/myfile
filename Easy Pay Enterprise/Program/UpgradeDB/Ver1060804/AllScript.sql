READ UpgradeDB\Ver1060804\entity.sql;
READ UpgradeDB\Ver1060804\StoredProc.sql;

if not exists(select * from registry where registryid = 'AttachmentStorage') then
   insert into registry(registryid,RegistryDesc) values('AttachmentStorage','Attachment Storage Setup');
end if;

if not exists(select * from subregistry where registryid = 'AttachmentStorage' and subregistryid = 'Path') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('AttachmentStorage','Path','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

IF NOT exists(select * FROM SubRegistry where SubRegistryId='TMSViewJobCode') THEN
    INSERT INTO Subregistry(RegistryId,SubRegistryId,RegProperty1) VALUES ('TMS Vendor','TMSViewJobCode','View_TMS_JobCode');
END IF;


/* Insert Formula for System Leave Encashment*/

if not exists(select * from Formula where FormulaId='Sys_ANLEncashment') then
 Insert into Formula Values('Sys_ANLEncashment',1,0,0,'PayElement','Allowance','Formula','','Annual Leave Encashment','',20,1);
 Insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5)
 Values('Sys_ANLEncashment',1,0,0,'U1 * K1 + U2 * K2;',0,0,0,0,0,'GRPHourRateAmt','GRPDayRateAmt','','','','','','','','','No of Hours','No of Days','','','');
 Insert into FormulaProperty(FormulaId,KeywordId)  Values('Sys_ANLEncashment','GRPCode');
 Insert into FormulaProperty (FormulaId,KeywordId)Values('Sys_ANLEncashment','GrossSalaryCode');
end if;



commit work;