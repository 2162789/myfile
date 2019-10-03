/* SystemRptComp */

Begin
declare newGeneratedIndex char(30);

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'ConsolidatePayElement_CheckBox') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - Laser','ConsolidatePayElement_CheckBox','Consolidate Identical Pay Element','int',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'DateOfPayment_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - Laser','DateOfPayment_wwDBDateTimePicker','Date of Payment','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'OTPeriodFrom_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - Laser','OTPeriodFrom_wwDBDateTimePicker','OT Payment Period(s) From','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'OTPeriodTo_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - Laser','OTPeriodTo_wwDBDateTimePicker','OT Payment Period(s) To','Date',0,NULL);
end if;

/* Default RptCompConfig & RptCompItemConfig*/
if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_187' and RptConfigId = '_Payslip - Laser') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_187','_Payslip - Laser','Payslip - Laser','ConsolidatePayElement_CheckBox');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_187' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_187','1','0');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_188' and RptConfigId = '_Payslip - Laser') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_188','_Payslip - Laser','Payslip - Laser','DateOfPayment_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_188' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_188','1','1899-12-30');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_189' and RptConfigId = '_Payslip - Laser') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_189','_Payslip - Laser','Payslip - Laser','OTPeriodFrom_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_189' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_189','1','1899-12-30');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_190' and RptConfigId = '_Payslip - Laser') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_190','_Payslip - Laser','Payslip - Laser','OTPeriodTo_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_190' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_190','1','1899-12-30');
end if;
    
/* Add values for user-defined configuration */ 
RptConfigConsoLoop: FOR RptConfigConso AS Dynamic Scroll Cursor FOR 
   SELECT RptConfigId AS OUT_RptConfigId FROM RptConfig 
   WHERE SysRptId = 'Payslip - Laser' and Substr(RptConfigId,1,1) <> '_'
   DO  
	  if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'ConsolidatePayElement_CheckBox') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,'Payslip - Laser','ConsolidatePayElement_CheckBox');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','1899-12-30');
	      end if;
	  end if;
	  
	 if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'DateOfPayment_wwDBDateTimePicker') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,'Payslip - Laser','DateOfPayment_wwDBDateTimePicker');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','1899-12-30');
	      end if;
	  end if;
	  
	 if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'OTPeriodFrom_wwDBDateTimePicker') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,'Payslip - Laser','OTPeriodFrom_wwDBDateTimePicker');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','1899-12-30');
	      end if;
	  end if;

	 if not exists(select * from RptCompConfig where RptConfigId = OUT_RptConfigId and SysRptCompName = 'OTPeriodTo_wwDBDateTimePicker') then
	      set newGeneratedIndex = FGetNewSGSPGeneratedIndex('RptCompConfig');
		  
	      insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	      values(newGeneratedIndex,OUT_RptConfigId,'Payslip - Laser','OTPeriodTo_wwDBDateTimePicker');
		  
		  if not exists(select * from RptCompItemConfig where RptCompSysId = newGeneratedIndex and RptCompItemSysId = 1) then
	          insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	          values(newGeneratedIndex,'1','1899-12-30');
	      end if;
	  end if;	  	  
   END FOR;

end;   


update SystemRpt set SysRptAvailSummLevel = 'RptSummEmployee, RptSummPersonal' 
where SysRptId in ('Current IR8A','Supplementary IR8A','IR8S','IR21','IR21 Appendix 1','IR21 Appendix 2','IR21 Appendix 3','Appendix 8A','Appendix 8B');


/* Insert Formula Property for System Leave Deduction*/
if not exists(select * from FormulaProperty where FormulaId='Sys_ANLDeduction' AND KeywordId='SubjAdditional') then
 Insert into FormulaProperty (FormulaId,KeywordId) Values('Sys_ANLDeduction','SubjAdditional');
end if;

if not exists(select * from FormulaProperty where FormulaId='Sys_ANLDeduction' AND KeywordId='SubjSDF') then
 Insert into FormulaProperty (FormulaId,KeywordId) Values('Sys_ANLDeduction','SubjSDF');
end if;


commit work;

	












