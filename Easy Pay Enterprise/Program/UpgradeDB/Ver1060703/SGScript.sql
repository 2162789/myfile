READ UpgradeDB\Ver1060703\AllScript.sql;

if not exists(select * from SystemRptComp where SysRptId = 'Appendix 8A' and SysRptCompName = 'A8AExcludeZeroRecord_CheckBox') then
   insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey) values('Appendix 8A','A8AExcludeZeroRecord_CheckBox','Exclude Zero Appendix 8A Records','Checked',0);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Appendix 8B' and SysRptCompName = 'A8AExcludeZeroRecord_CheckBox') then
   insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey) values('Appendix 8B','A8AExcludeZeroRecord_CheckBox','Exclude Zero Appendix 8B Records','Checked',0);
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_185') then
   insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) values('Sys_185','_Appendix 8A','Appendix 8A','A8AExcludeZeroRecord_CheckBox');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_186') then
   insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName) values('Sys_186','_Appendix 8B','Appendix 8B','A8AExcludeZeroRecord_CheckBox');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_185' and RptCompItemSysId = '1') then
   insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) values('Sys_185','1','0');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_186' and RptCompItemSysId = '1') then
   insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue) values('Sys_186','1','0');
end if;


if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCPFContriWage') then
   drop procedure ASQLCalPayRecCPFContriWage;
end if;

CREATE PROCEDURE "DBA"."ASQLCalPayRecCPFContriWage"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LeaveDeductAmt double,
out Out_BackPay double,
out Out_TotalWage double,
out Out_CPFAllowance double,
out Out_CPFDeduction double,
out Out_CPFContriWage double)
begin
  declare CPFContriWage double;
  set CPFContriWage=0;
  set Out_OTAmount=0;
  set Out_OTBackPay=0;
  set Out_ShiftAmount=0;
  set Out_LeaveDeductAmt=0;
  set Out_BackPay=0;
  set Out_TotalWage=0;
  set Out_CPFAllowance=0;
  set Out_CPFDeduction=0;

  // Compute OT Amount
    select Sum(CalOTAmount) into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTAmount;

  // Compute OT Back Pay    
    select Sum(CalOTBackPay) into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTBackPay;

  // Compute Shift Amount    
    select Sum(CalShiftAmount) into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_ShiftAmount;

  // Compute Leave Deduction Amount  
    select Sum(CalLveDeductAmt) into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set CPFContriWage=CPFContriWage+Out_LeaveDeductAmt;

  // Compute Back Pay  
    select Sum(CalBackPay) into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_BackPay;

  // Compute Total Wage  
    select Sum(CalTotalWage) into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set CPFContriWage=CPFContriWage+Out_TotalWage;

  // Compute CPF Allowance  
    select FGetPayRecCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,'') into Out_CPFAllowance;
    set CPFContriWage=CPFContriWage+Out_CPFAllowance;

  // Compute CPF Deduction  
    select FGetPayRecCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,'') into Out_CPFDeduction;
    set CPFContriWage=CPFContriWage+Out_CPFDeduction;

  // Compute CPF Contribution Wage  
  set Out_CPFContriWage=Round(CPFContriWage,FGetDBPayDecimal(*));
end;
commit work;