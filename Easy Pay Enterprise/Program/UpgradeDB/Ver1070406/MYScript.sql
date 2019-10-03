BEGIN
declare newGeneratedIndex char(30);
/*==============================================================*/
/* Process Rebate Claim                                         */
/*==============================================================*/
Update ImportFieldName Set IsKey = 1
where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical in ('RebateDate', 'RebateePortalStatus');

/* Interface Selection */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceSelection' and SubRegistryId = 'iRebateClaimRecord') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceSelection','iRebateClaimRecord','Rebate Claim Process','','','','','','Rebate Claim Record','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* KeyWord */
if not exists(select * from KeyWord where KeyWordId = 'RebateAppP') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('RebateAppP','Pending','Pending','RebateAppStatus',0,0,0,'',0,0,0,'0');
end if;

if not exists(select * from KeyWord where KeyWordId = 'RebateAppA') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('RebateAppA','Approved','Approved','RebateAppStatus',0,0,0,'',0,0,0,'1');
end if;

if not exists(select * from KeyWord where KeyWordId = 'RebateAppC') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('RebateAppC','Cancelled','Cancelled','RebateAppStatus',0,0,0,'',0,0,0,'2');
end if;

if not exists(select * from KeyWord where KeyWordId = 'RebateAppR') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('RebateAppR','Rejected','Rejected','RebateAppStatus',0,0,0,'',0,0,0,'3');
end if;

if not exists(select * from KeyWord where KeyWordId = 'RebateAppRC') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('RebateAppRC','Request For Change','Request For Change','RebateAppStatus',0,0,0,'',0,0,0,'4');
end if;

Update SubRegistry 
Set RegProperty6 = '', RegProperty7 = 'SELECT KeyWordGroup as EPEID, KeyWordUserDefinedName as EPEIDDesc FROM KeyWord WHERE KeyWordCategory = ''RebateAppStatus'''
Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'RebateePortalStatus';

/*==============================================================*/
/* Malaysia Laser Payslip - Include Pay Element Remarks         */
/*==============================================================*/

/* Include Pay element Remarks component in Report Configuration */
if not exists(Select * from SystemRptComp where SysRptCompName = 'ShowRemark_CheckBox') then
	INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey, RptKeyIndex) VALUES ('Payslip - Laser','ShowRemark_CheckBox','Include Pay Element Remarks','int',0,NULL);
	INSERT INTO RptCompConfig (RptCompSysId, RptConfigId, SysRptId, SysRptCompName) VALUES ('Sys_124','_Payslip - Laser','Payslip - Laser','ShowRemark_CheckBox');
	INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysId, ItemValue) VALUES ('Sys_124','1','1');
end if;

/* Add values for user-defined configuration */ 
RptConfigConsoLoop: FOR RptConfigConso AS Scroll Cursor FOR 
   SELECT RptConfigId AS OUT_RptConfigId,SysRptId AS OUT_SysRptId FROM RptConfig 
   WHERE SysRptId in ('Payslip - Laser') and Substr(RptConfigId,1,1) <> '_'
   DO  
	  if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'ShowRemark_CheckBox') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,OUT_SysRptId,'ShowRemark_CheckBox');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','1');
	      end if;
	  end if;  	  	  
   END FOR;  
END;
commit work;