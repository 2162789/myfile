BEGIN
declare newGeneratedIndex char(30);

/*==============================================================*/
/* Thailand Laser Payslip - Include Pay Element Remarks         */
/*==============================================================*/

/* Include Pay element Remarks component in Report Configuration */
if not exists(Select * from SystemRptComp where SysRptCompName = 'ShowRemark_CheckBox') then
	INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey, RptKeyIndex) VALUES ('Payslip - Laser','ShowRemark_CheckBox','Include Pay Element Remarks','int',0,NULL);
	INSERT INTO RptCompConfig (RptCompSysId, RptConfigId, SysRptId, SysRptCompName) VALUES ('Sys_75','_Payslip - Laser','Payslip - Laser','ShowRemark_CheckBox');
	INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysId, ItemValue) VALUES ('Sys_75','1','1');
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