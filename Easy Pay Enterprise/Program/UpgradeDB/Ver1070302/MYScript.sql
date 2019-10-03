if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecEISWage') then
   drop procedure ASQLCalPayRecEISWage
end if;
Create PROCEDURE "DBA"."ASQLCalPayRecEISWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_EISWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_EISWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  if(IsWageElementInUsed('SubjEIS','EISWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_EISWage=Out_EISWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','EISWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_EISWage=Out_EISWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','EISWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_EISWage=Out_EISWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','EISWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_EISWage=Out_EISWage+Out_TotalWageAmt
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodEISWage') then
   drop procedure ASQLCalPayPeriodEISWage
end if;
Create PROCEDURE "DBA"."ASQLCalPayPeriodEISWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_EISWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_EISWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_OTBackPayAmt=0;
  if(IsWageElementInUsed('SubjEIS','EISWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjSOCSO') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Back Pay
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjEIS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_EISWage=Out_EISWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','EISWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_EISWage=Out_EISWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','EISWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_EISWage=Out_EISWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','EISWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_EISWage=Out_EISWage+Out_TotalWageAmt
  end if
end
;

/*-------------------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Non-Resident 2018 (For TaxPolicyId = NonResidentDefault) */
/*-------------------------------------------------------------------------------------*/

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy') then
   drop PROCEDURE PatchMalaysiaTaxPolicy
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
  /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return;
  end if;

  /* Check Tax Policy */
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'NonResidentDefault') then 
	return;
  end if;

  /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2018-01-01' and MalTaxPolicyId = 'NonResidentDefault') then
    return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select * from MalSTDPolicy where MalSTDPolicyId = 'NonResYear2018') then
    insert into MalSTDPolicy values('NonResYear2018','Year 2018 MTD Formula for Non Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'NonResYear2018',0,999999999,0,28,0,0);
  end if;


  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg(
	MalTaxPolicyProgSysId, 
	MalTaxPolicyId, 
	MalSTDPolicyId, 
	MalTaxPolicyEffDate, 
	MalChildOutside, 
	MalChildInside,
	MalChildDisabled, 
	MalCat1Relief, 
	MalCat2ChildRelief, 
	MalCat2Relief, 
	MalCat3ChildRelief, 
	MalCat3Relief, 
	EPFCappingOption, 
	EPFCappingYearly, 
	EPFCappingMOnthly, 
	MalTaxCompenPerYr, 
	MalTaxMinTaxAmt)  
    values(In_MalTaxPolicyProgSysId+1,'NonResidentDefault','NonResYear2018','2018-01-01',0,0,0,0,0,0,0,0,0,0,0,0,0);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;

/*----------------------------------------------------------------------------*/
/* To insert Malaysia Tax for Resident 2018 (For TaxPolicyId = DefaultPolicy) */
/*----------------------------------------------------------------------------*/

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy1') then
   drop PROCEDURE PatchMalaysiaTaxPolicy1
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy1"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
  /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return
  end if;


  /* Check Tax Policy */
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'DefaultPolicy') then 
	return;
  end if;

  /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2018-01-01' and MalTaxPolicyId = 'DefaultPolicy') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ResYear2018') then
    insert into MalSTDPolicy values('ResYear2018','Year 2018 MTD Formula for Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'ResYear2018',5001,20000,5000,1,-400,-800);
    insert into MalSTDPolicyTable values(MaxID+2,'ResYear2018',20001,35000,20000,3,-250,-650);
    insert into MalSTDPolicyTable values(MaxID+3,'ResYear2018',35001,50000,35000,8,600,600);
    insert into MalSTDPolicyTable values(MaxID+4,'ResYear2018',50001,70000,50000,14,1800,1800);
    insert into MalSTDPolicyTable values(MaxID+5,'ResYear2018',70001,100000,70000,21,4600,4600);
    insert into MalSTDPolicyTable values(MaxID+6,'ResYear2018',100001,250000,100000,24,10900,10900);
    insert into MalSTDPolicyTable values(MaxID+7,'ResYear2018',250001,400000,250000,24.5,46900,46900);
    insert into MalSTDPolicyTable values(MaxID+8,'ResYear2018',400001,600000,400000,25,83650,83650);
    insert into MalSTDPolicyTable values(MaxID+9,'ResYear2018',600001,1000000,600000,26,133650,133650);
    insert into MalSTDPolicyTable values(MaxID+10,'ResYear2018',1000001,999999999,1000000,28,237650,237650);
  end if;

  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg(
	MalTaxPolicyProgSysId, 
	MalTaxPolicyId, 
	MalSTDPolicyId, 
	MalTaxPolicyEffDate, 
	MalChildOutside, 
	MalChildInside,
	MalChildDisabled, 
	MalCat1Relief, 
	MalCat2ChildRelief, 
	MalCat2Relief, 
	MalCat3ChildRelief, 
	MalCat3Relief, 
	EPFCappingOption, 
	EPFCappingYearly, 
	EPFCappingMOnthly, 
	MalTaxCompenPerYr, 
	MalTaxMinTaxAmt)  
    values(In_MalTaxPolicyProgSysId+1,'DefaultPolicy','ResYear2018','2018-01-01',4,4,3,0,0,0,0,0,0,0,0,0,10);

  /* Create Rebate Setup - no change, use 2017 rebate */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Individual',9000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Child',2000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parent Medical',5000,1,0);

  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Medical (Father)',1500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Medical (Mother)',1500,1,0);

  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Supporting Equip',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Person',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Self Education',7000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Serious Medical',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Books',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Computer',3000,3,1);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SSPN',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Spouse',4000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Educ Med Insurance',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Spouse',3500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Sports Equip',300,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Petrol Official',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parking',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Meal',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Childcare',2400,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Communication',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Goods',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Service',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Loan Interest',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Other Medical',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Innovation',2000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Compensation',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Alimony',4000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Annuity',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SOCSO Payment',250,1,0);

  /* Create Other Tax Formula - no change in rate, use 2013 formula */
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'REP','REPYear2013');
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'ISKANDAR','ISKANDARYear2013');

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy1();
drop procedure dba.PatchMalaysiaTaxPolicy1;

if not exists (select 1 from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'CheckBox_UserDefinedParameter') then
  insert into SystemRptComp (SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey)
  values ('Payslip - CS 2','CheckBox_UserDefinedParameter','User Defined Parameter','int',0);
end if;

if not exists (select 1 from RptCompConfig where RptCompSysId = 'Sys_122') then
  insert into RptCompConfig (RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
  values ('Sys_122','_Payslip - CS 2','Payslip - CS 2','CheckBox_UserDefinedParameter');
  if not exists (select 1 from RptCompItemConfig where RptCompSysId = 'Sys_122') then
    insert into RptCompItemConfig (RptCompSysId,RptCompItemSysId,ItemValue) values ('Sys_122',1,'0');
  end if;
end if;

if not exists (select 1 from SystemRptComp where SysRptId = 'Payslip - CS 2 Laser' and SysRptCompName = 'CheckBox_UserDefinedParameter') then
  insert into SystemRptComp (SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey)
  values ('Payslip - CS 2 Laser','CheckBox_UserDefinedParameter','User Defined Parameter','int',0);
end if;

if not exists (select 1 from RptCompConfig where RptCompSysId = 'Sys_123') then
  insert into RptCompConfig (RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
  values ('Sys_123','_Payslip - CS 2 Laser','Payslip - CS 2 Laser','CheckBox_UserDefinedParameter');
  if not exists (select 1 from RptCompItemConfig where RptCompSysId = 'Sys_123') then
    insert into RptCompItemConfig (RptCompSysId,RptCompItemSysId,ItemValue) values ('Sys_123',1,'0');
  end if;
end if;

commit work;