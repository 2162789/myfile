BEGIN
declare newGeneratedIndex char(30);
/* SystemRptComp */
if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'YTDFullYearLeave_ComboBox') then
   insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
   values('Payslip - Laser','YTDFullYearLeave_ComboBox','YTD / Full Year Leave','ItemIndex',0,NULL);
end if;

/* RptCompConfig */
if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_125') then
   insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
   values('Sys_125','_Payslip - Laser','Payslip - Laser','YTDFullYearLeave_ComboBox');
end if;

/* RptCompItemConfig */
if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_125' and RptCompItemSysId = '1') then
  insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
  values('Sys_125','1','YTD Leave');
end if;

/* Add values for user-defined configuration */ 
RptConfigConsoLoop: FOR RptConfigConso AS Scroll Cursor FOR 
   SELECT RptConfigId AS OUT_RptConfigId,SysRptId AS OUT_SysRptId FROM RptConfig 
   WHERE SysRptId in ('Payslip - Laser') and Substr(RptConfigId,1,1) <> '_'
   DO  
	  if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'YTDFullYearLeave_ComboBox') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,OUT_SysRptId,'YTDFullYearLeave_ComboBox');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','YTD Leave');
	      end if;
	  end if;  	  	  
   END FOR; 
END;

commit work;