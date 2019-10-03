
create procedure DBA.ASQLCalPayPeriodJamsoWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_JamsoWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_JamsoWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjJamsostek','JamsostekWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjJamsostek') = 1 and
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
    set Out_JamsoWage=Out_JamsoWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','JamsostekWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_JamsoWage=Out_JamsoWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','JamsostekWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_JamsoWage=Out_JamsoWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','JamsostekWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_JamsoWage=Out_JamsoWage+Out_TotalWageAmt
  end if
end
;


create procedure DBA.ASQLCalPayRecJamsoWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_JamsoWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_JamsoWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjJamsostek','JamsostekWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjJamsostek') = 1 and
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
    set Out_JamsoWage=Out_JamsoWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','JamsostekWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_JamsoWage=Out_JamsoWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','JamsostekWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_JamsoWage=Out_JamsoWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','JamsostekWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_JamsoWage=Out_JamsoWage+Out_TotalWageAmt
  end if
end
;


create procedure dba.ASQLIndoTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_TaxGrossSalary double,
out Out_NonTaxIncome double,
out Out_Expense double,
out Out_TaxIncome double,
out Out_TaxAmount double)
begin
  declare MaritalStatus char(20);
  declare Jamsostek double;
  declare Gender char(1);
  /*
  Non Tax Income
  */
  select MaritalStatusCode into MaritalStatus from Employee where EmployeeSysId = In_EmployeeSysId;
  select Gender into Gender from Employee where EmployeeSysId = In_EmployeeSysId;
  if(Out_Gender = '1') then
	 case MaritalStatus when 'S' then
		set Out_NonTaxIncome=240000 when 'M0' then
		set Out_NonTaxIncome=360000 when 'M1' then
		set Out_NonTaxIncome=480000 when 'M2' then
		set Out_NonTaxIncome=600000 when 'M3' then
		set Out_NonTaxIncome=720000
	 else
		set Out_NonTaxIncome=240000
	 end case
  else
	 set Out_NonTaxIncome=240000
  end if;
  /*
  Expense
  */
  set Out_Expense=In_TaxGrossSalary*.05;
  if(Out_Expense > 240000) then set Out_Expense=240000
  end if;
  /*
  Tax Income
  */
  select ContriOrdEECPF into Jamsostek from PeriodPolicySummary where
	 EmployeeSysId = In_EmployeeSysId and
	 PayRecYear = In_PayRecYear and
	 PayRecPeriod = In_PayRecPeriod;
  set Out_TaxIncome=12*(In_TaxGrossSalary-Out_NonTaxIncome-Out_Expense-Jamsostek);
  /*
  Tax Amount
  */
  if(Out_TaxIncome <= 25000000) then set Out_TaxAmount=Out_TaxIncome*.05/12
  elseif(Out_TaxIncome <= 50000000) then set Out_TaxAmount=((Out_TaxIncome-25000000)*.1/12)+104166
  elseif(Out_TaxIncome <= 100000000) then set Out_TaxAmount=((Out_TaxIncome-50000000)*.15/12)+312499
  elseif(Out_TaxIncome <= 200000000) then set Out_TaxAmount=((Out_TaxIncome-100000000)*.2/12)+937499
  else set Out_TaxAmount=((Out_TaxIncome-200000000)*.35/12)+2604165
  end if
end
;


create procedure dba.ASQLProcessIndoTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_TaxGrossSalary double,
out Out_NonTaxIncome double,
out Out_Expense double,
out Out_TaxIncome double,
out Out_TaxAmount double)
begin
  declare MaritalStatus char(20);
  declare Gender char(1);
  declare Jamsostek double;
  select MaritalStatusCode into MaritalStatus from Employee where EmployeeSysId = In_EmployeeSysId;
  select Gender into Gender from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
  if(Gender = '0' and MaritalStatus = 'S') then set Out_NonTaxIncome=240000
  elseif(Gender = '1' and MaritalStatus = 'M0') then set Out_NonTaxIncome=360000
  elseif(Gender = '1' and MaritalStatus = 'M1') then set Out_NonTaxIncome=480000
  elseif(Gender = '1' and MaritalStatus = 'M2') then set Out_NonTaxIncome=600000
  elseif(Gender = '1' and MaritalStatus = 'M3') then set Out_NonTaxIncome=720000
  else set Out_NonTaxIncome=240000
  end if;
  set Out_Expense=In_TaxGrossSalary*.05;
  if(Out_Expense > 240000) then set Out_Expense=240000
  end if;
  select ContriOrdEECPF into Jamsostek from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  set Out_TaxIncome=12*(In_TaxGrossSalary-Out_NonTaxIncome-Out_Expense-Jamsostek);
  if(Out_TaxIncome <= 25000000) then set Out_TaxAmount=Out_TaxIncome*.05/12
  elseif(Out_TaxIncome <= 50000000) then set Out_TaxAmount=((Out_TaxIncome-25000000)*.1/12)+104166
  elseif(Out_TaxIncome <= 100000000) then set Out_TaxAmount=((Out_TaxIncome-50000000)*.15/12)+312499
  elseif(Out_TaxIncome <= 200000000) then set Out_TaxAmount=((Out_TaxIncome-100000000)*.2/12)+937499
  else set Out_TaxAmount=((Out_TaxIncome-200000000)*.35/12)+2604165
  end if;
  set Out_TaxAmount="Truncate"(Out_TaxAmount,0)
end
;


create function DBA.FGetIndoEmpJamsostekACC(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Out_JamsoAccountNo char(20);
  declare Out_Date date;
  declare Out_PayGroupId char(20);
  select paypaygroupId into Out_PayGroupId from payperiodRecord where Employeesysid = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
  if(Out_PayGroupId = null) then
    select PayGroupId into Out_PayGroupId from PayEmployee where Employeesysid = In_EmployeeSysId
  end if;
  select first subperiodEnddate into Out_Date from
    PayGroupPeriod where PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PayRecYear and PayGroupPeriod = In_PayRecPeriod order by SubPeriodEndDate desc;
  select first CPFProgAccountNo into Out_JamsoAccountNo
    from CPFProgression where
    EmployeeSysId = In_EmployeeSysId and
    CPFEffectiveDate <= Out_Date order by
    CPFEffectivedate desc;
  return(Out_JamsoAccountNo)
end
;


create function DBA.FGetGikenJamsostekNo(
in In_EmployeeSysId integer)
returns char(11)
begin
  declare fResult char(11);
  select first CPFProgAccountNo into fResult from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFEffectiveDate <= today(*) order by CPFEffectiveDate desc;
  if fResult is null then set fResult=''
  end if;
  return(fResult)
end
;


create function dba.FGetIndonCPFFormula(
in In_OrdFormulaId char(20),
in In_AddFormulaId char(20))
returns char(255)
begin
  declare Out_AddDesc char(255);
  declare Out_OrdDesc char(255);
  declare OrdFormulaType char(20);
  declare AddFormulaType char(20);
  declare OrdC1 double;
  declare OrdC2 double;
  declare OrdC3 double;
  declare OrdC4 double;
  declare OrdC5 double;
  declare OrdK1 char(20);
  declare AddC1 double;
  declare AddC2 double;
  declare AddC3 double;
  declare AddC4 double;
  declare AddC5 double;
  /*
  To Get Ordinary Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    FGetKeyWordUserDefinedName(Keywords1) into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5,
    OrdK1 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  /*
  To Get Additional Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5 into AddFormulaType,
    AddC1,
    AddC2,
    AddC3,
    AddC4,
    AddC5 from Formula join FormulaRange where Formula.FormulaId = In_AddFormulaId;
  set Out_OrdDesc=null;
  set Out_AddDesc=null;
  /*
  To check the formula type
  */
  set Out_OrdDesc=LTrim(Str(OrdC1,8,2))+'% of the employee''s '+OrdK1+' for the month';
  return Out_OrdDesc+Out_AddDesc
end
;

/* ============================================================ */
/*   Database name:  Model_2                                    */
/*   DBMS name:      Sybase AS Anywhere 6                       */
/*   Created on:     8/10/2004  10:53 AM                        */
/* ============================================================ */


create procedure dba.DeleteIndoTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
    if exists(select* from IndoTaxRecord where IndoTaxRecord.PersonalSysId = In_PersonalSysId) then
      call DeleteIndoTaxRecordByPersonalSysId(In_PersonalSysId);
      commit work
    end if;
    delete from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.DeleteIndoTaxEmployee(
in In_IndoTaxRecSysId integer,
in In_IndoTaxEESysId integer,
out Out_Code integer)
begin
  if exists(select* from IndoTaxEmployee where
      IndoTaxRecSysId = In_IndoTaxRecSysId and IndoTaxEESysId = In_IndoTaxEESysId) then
    delete from IndoTaxEmployee where
      IndoTaxRecSysId = In_IndoTaxRecSysId and IndoTaxEESysId = In_IndoTaxEESysId;
    commit work;
    set Out_Code=1
  end if
end
;



create procedure dba.DeleteIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if not exists(select* from IndoTaxRecord where IndoTaxRecord.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      if not exists(select* from IndoTaxDetails where IndoTaxDetails.IndoTaxEmployerId = In_IndoTaxEmployerId) then
        delete from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId;
        commit work
      end if
    end if;
    if exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteIndoTaxMonthly(
in In_IndoTaxMonthlyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxMonthly where IndoTaxMonthlyId = In_IndoTaxMonthlyId) then
    delete from IndoTaxPolicyProg where IndoTaxMonthlyId = In_IndoTaxMonthlyId;
    commit work;
    delete from IndoTaxMthFormula where IndoTaxMonthlyId = In_IndoTaxMonthlyId;
    commit work;
    delete from IndoTaxMonthly where IndoTaxMonthlyId = In_IndoTaxMonthlyId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;


create procedure dba.DeleteIndoTaxPolicy(
in In_IndoTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxPolicy where IndoTaxPolicyId = In_IndoTaxPolicyId) then
    delete from IndoTaxPolicyProg where IndoTaxPolicyId = In_IndoTaxPolicyId;
    commit work;
    delete from IndoTaxEmployee where IndoTaxRecSysId = any(select IndoTaxRecSysId from IndoTaxRecord where IndoTaxPolicyId = In_IndoTaxPolicyId);
    commit work;
    delete from IndoTaxRecord where IndoTaxPolicyId = In_IndoTaxPolicyId;
    commit work;
    delete from IndoTaxDetails where IndoTaxPolicyId = In_IndoTaxPolicyId;
    commit work;
    delete from IndoTaxPolicy where IndoTaxPolicyId = In_IndoTaxPolicyId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;


create procedure dba.DeleteIndoTaxPolicyProg(
in In_IndoTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxPolicyProg where IndoTaxPolicyProgSysId = In_IndoTaxPolicyProgSysId) then
    delete from IndoTaxPolicyProg where IndoTaxPolicyProgSysId = In_IndoTaxPolicyProgSysId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;


create procedure dba.DeleteIndoTaxRecord(
in In_IndoTaxRecSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxRecord where IndoTaxRecSysId = In_IndoTaxRecSysId) then
    delete from IndoTaxEmployee where IndoTaxRecSysId = In_IndoTaxRecSysId;
    commit work;
    delete from IndoTaxRecord where IndoTaxRecSysId = In_IndoTaxRecSysId;
    commit work
  end if
end
;



create procedure dba.DeleteIndoTaxRegion(
in In_IndoTaxRegionId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxRegion where IndoTaxRegion.IndoTaxRegionId = In_IndoTaxRegionId) then
    if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyProg.IndoTaxRegionId = In_IndoTaxRegionId) then
      if exists(select* from IndoTaxRegionIndex where IndoTaxRegionIndex.IndoTaxRegionId = In_IndoTaxRegionId) then
        delete from IndoTaxRegionIndex where IndoTaxRegionIndex.IndoTaxRegionId = In_IndoTaxRegionId;
        commit work
      end if;
      delete from IndoTaxRegion where IndoTaxRegion.IndoTaxRegionId = In_IndoTaxRegionId;
      commit work
    end if;
    if exists(select* from IndoTaxRegion where IndoTaxRegion.IndoTaxRegionId = In_IndoTaxRegionId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.InsertNewIndoTaxDetails(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoEETaxNo char(30),
in In_NoOfDependent integer,
in In_IndoTaxMethod char(20),
in In_PensionWorker smallint,
in In_TaxCategory char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
    insert into IndoTaxDetails(PersonalSysId,
      IndoTaxPolicyId,
      IndoTaxEmployerId,
      IndoEETaxNo,
      NoOfDependent,
      IndoTaxMethod,
      PensionWorker,
      TaxCategory) values(
      In_PersonalSysId,
      In_IndoTaxPolicyId,
      In_IndoTaxEmployerId,
      In_IndoEETaxNo,
      In_NoOfDependent,
      In_IndoTaxMethod,
      In_PensionWorker,
      In_TaxCategory);
    commit work;
    if not exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewIndoTaxEmployee(
in In_IndoTaxRecSysId integer,
in In_IndoTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_IndoTaxLastProcessed integer,
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_IndoTaxRecSysId is null then set Out_Code=-1;
    return
  end if;
  if In_FromPayRecYear is null then set Out_Code=-2;
    return
  end if;
  if In_FromPayRecPeriod is null then set Out_Code=-3;
    return
  end if;
  if In_FromPayRecSubPeriod is null then set Out_Code=-4;
    return
  end if;
  if In_ToPayRecYear is null then set Out_Code=-5;
    return
  end if;
  if In_ToPayRecPeriod is null then set Out_Code=-6;
    return
  end if;
  if In_ToPayRecSubPeriod is null then set Out_Code=-7;
    return
  end if;
  if In_PayRecID is null then set Out_Code=-8;
    return
  end if;
  if exists(select* from IndoTaxEmployee) then
    select max(IndoTaxEESysId) into MaxSysId from IndoTaxEmployee;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into IndoTaxEmployee(IndoTaxRecSysId,
    IndoTaxEESysId,
    FromPayRecYear,
    FromPayRecPeriod,
    FromPayRecSubPeriod,
    ToPayRecYear,
    ToPayRecPeriod,
    ToPayRecSubPeriod,
    PayRecID,
    IndoTaxLastProcessed) values(
    In_IndoTaxRecSysId,
    In_IndoTaxEESysId,
    In_FromPayRecYear,
    In_FromPayRecPeriod,
    In_FromPayRecSubPeriod,
    In_ToPayRecYear,
    In_ToPayRecPeriod,
    In_ToPayRecSubPeriod,
    In_PayRecID,
    In_IndoTaxLastProcessed);
  commit work
end
;

create procedure DBA.InsertNewIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(20),
in In_IndoTaxAuthoriseTaxRefNo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(20),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    insert into IndoTaxEmployer(IndoTaxEmployerId,
      IndoTaxEmployerDesc,
      IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo,
      Address1,Address2,Address3,
      State,City,PostalCode,
      TelephoneNo,
      TypeOfBusiness,
      RegistrationNo,
      IndoOldAgeOption,
      Signature) values(
      In_IndoTaxEmployerId,
      In_IndoTaxEmployerDesc,
      In_IndoTaxAuthoriseName,
      In_IndoTaxERTaxRefNo,
      In_IndoTaxAuthoriseTaxRefNo,
      In_Address1,In_Address2,In_Address3,
      In_State,In_City,In_PostalCode,
      In_TelephoneNo,
      In_TypeOfBusiness,
      In_RegistrationNo,
      In_IndoOldAgeOption,
      In_Signature);
    commit work;
    if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewIndoTaxMonthly(
in In_IndoTaxMonthlyId char(20),
in In_IndoTaxMonthlyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_IndoTaxMonthlyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from IndoTaxMonthly where IndoTaxMonthlyId = In_IndoTaxMonthlyId) then
    insert into IndoTaxMonthly(IndoTaxMonthlyId,
      IndoTaxMonthlyDesc) values(
      In_IndoTaxMonthlyId,
      In_IndoTaxMonthlyDesc);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-2
  end if
end
;


create procedure dba.InsertNewIndoTaxPolicy(
in In_IndoTaxPolicyId char(20),
in In_IndoTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_IndoTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from IndoTaxPolicy where IndoTaxPolicyId = In_IndoTaxPolicyId) then
    insert into IndoTaxPolicy(IndoTaxPolicyId,
      IndoTaxPolicyDesc) values(
      In_IndoTaxPolicyId,
      In_IndoTaxPolicyDesc);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-2
  end if
end
;


create procedure dba.InsertNewIndoTaxPolicyProg(
in In_IndoTaxPolicyId char(20),
in In_IndoTaxRegionId char(20),
in In_IndoTaxMonthlyId char(20),
in In_IndoTaxEffectiveDate date,
in In_IndoTaxFullBorneGovt double,
in In_IndoTaxOccuPercent double,
in In_IndoTaxOccuCapping double,
in In_IndoTaxPensionPercent double,
in In_IndoTaxPensionCapping double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxDependent double,
in In_IndoTaxDependentCap integer,
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_IndoTaxPolicyId is null then
    set Out_Code=-1;
    return
  end if;
  if In_IndoTaxRegionId is null then
    set Out_Code=-2;
    return
  end if;
  if In_IndoTaxMonthlyId is null then
    set Out_Code=-3;
    return
  end if;
  if exists(select* from IndoTaxPolicyProg) then
    select Max(IndoTaxPolicyProgSysId) into MaxSysId from IndoTaxPolicyProg;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into IndoTaxPolicyProg(IndoTaxPolicyProgSysId,
    IndoTaxPolicyId,
    IndoTaxRegionId,
    IndoTaxMonthlyId,
    IndoTaxEffectiveDate,
    IndoTaxFullBorneGovt,
    IndoTaxOccuPercent,
    IndoTaxOccuCapping,
    IndoTaxPensionPercent,
    IndoTaxPensionCapping,
    IndoTaxPersonal,
    IndoTaxMarriage,
    IndoTaxDependent,
    IndoTaxDependentCap) values(
    Out_Code,
    In_IndoTaxPolicyId,
    In_IndoTaxRegionId,
    In_IndoTaxMonthlyId,
    In_IndoTaxEffectiveDate,
    In_IndoTaxFullBorneGovt,
    In_IndoTaxOccuPercent,
    In_IndoTaxOccuCapping,
    In_IndoTaxPensionPercent,
    In_IndoTaxPensionCapping,
    In_IndoTaxPersonal,
    In_IndoTaxMarriage,
    In_IndoTaxDependent,
    In_IndoTaxDependentCap);
  commit work
end
;


create procedure dba.InsertNewIndoTaxRecord(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoTaxSerialNo integer,
in In_IndoTaxYear integer,
in In_IndoTaxFromPeriod integer,
in In_IndoTaxToPeriod integer,
in In_IndoTaxPermanent integer,
in In_IndoTaxBelowGovtBorne integer,
in In_IndoTaxSalary double,
in In_IndoTaxBenefit double,
in In_IndoTaxOtherAllowance double,
in In_IndoTaxOT double,
in In_IndoTaxHonoraria double,
in In_IndoTaxInsurance double,
in In_IndoTaxOtherBenefit double,
in In_IndoTaxBonus double,
in In_IndoTaxOccu double,
in In_IndoTaxOccuBonus double,
in In_IndoTaxPension double,
in In_IndoTaxCurrentTaxable double,
in In_IndoTaxAnnualTaxable double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxNoDependent integer,
in In_IndoTaxDependent double,
in In_IndoTaxTotalTaxable double,
in In_IndoTaxPrevTaxable double,
in In_IndoTaxPrevTaxAmt double,
in In_IndoTaxBorneGovt double,
in In_IndoTaxBalPayableTax double,
in In_IndoTaxAnnualAmt double,
in In_IndoTaxActualTaxAmt double,
in In_IndoTaxPaidTaxAmt double,
in In_IndoTaxBalance double,
in In_IndoTaxExcess double,
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_IndoTaxPolicyId is null then
    set Out_Code=-1;
    return
  end if;
  if In_IndoTaxEmployerId is null then
    set Out_Code=-2;
    return
  end if;
  if In_IndoTaxFromPeriod > In_IndoTaxToPeriod then
    set Out_Code=-3;
    return
  end if;
  if exists(select* from IndoTaxRecord) then
    select Max(IndoTaxRecSysId) into MaxSysId from IndoTaxRecord;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into IndoTaxRecord(IndoTaxRecSysId,
    PersonalSysId,
    IndoTaxPolicyId,
    IndoTaxEmployerId,
    IndoTaxSerialNo,
    IndoTaxYear,
    IndoTaxFromPeriod,
    IndoTaxToPeriod,
    IndoTaxPermanent,
    IndoTaxBelowGovtBorne,
    IndoTaxSalary,
    IndoTaxBenefit,
    IndoTaxOtherAllowance,
    IndoTaxOT,
    IndoTaxHonoraria,
    IndoTaxInsurance,
    IndoTaxOtherBenefit,
    IndoTaxBonus,
    IndoTaxOccu,
    IndoTaxOccuBonus,
    IndoTaxPension,
    IndoTaxCurrentTaxable,
    IndoTaxAnnualTaxable,
    IndoTaxPersonal,
    IndoTaxMarriage,
    IndoTaxNoDependent,
    IndoTaxDependent,
    IndoTaxTotalTaxable,
    IndoTaxPrevTaxable,
    IndoTaxPrevTaxAmt,
    IndoTaxBorneGovt,
    IndoTaxBalPayableTax,
    IndoTaxAnnualAmt,
    IndoTaxActualTaxAmt,
    IndoTaxPaidTaxAmt,
    IndoTaxBalance,
    IndoTaxExcess) values(
    Out_Code,
    In_PersonalSysId,
    In_IndoTaxPolicyId,
    In_IndoTaxEmployerId,
    In_IndoTaxSerialNo,
    In_IndoTaxYear,
    In_IndoTaxFromPeriod,
    In_IndoTaxToPeriod,
    In_IndoTaxPermanent,
    In_IndoTaxBelowGovtBorne,
    In_IndoTaxSalary,
    In_IndoTaxBenefit,
    In_IndoTaxOtherAllowance,
    In_IndoTaxOT,
    In_IndoTaxHonoraria,
    In_IndoTaxInsurance,
    In_IndoTaxOtherBenefit,
    In_IndoTaxBonus,
    In_IndoTaxOccu,
    In_IndoTaxOccuBonus,
    In_IndoTaxPension,
    In_IndoTaxCurrentTaxable,
    In_IndoTaxAnnualTaxable,
    In_IndoTaxPersonal,
    In_IndoTaxMarriage,
    In_IndoTaxNoDependent,
    In_IndoTaxDependent,
    In_IndoTaxTotalTaxable,
    In_IndoTaxPrevTaxable,
    In_IndoTaxPrevTaxAmt,
    In_IndoTaxBorneGovt,
    In_IndoTaxBalPayableTax,
    In_IndoTaxAnnualAmt,
    In_IndoTaxActualTaxAmt,
    In_IndoTaxPaidTaxAmt,
    In_IndoTaxBalance,
    In_IndoTaxExcess);
  commit work
end
;


create procedure dba.InsertNewIndoTaxRegion(
in In_IndoTaxRegionId char(20),
in In_IndoTaxRegionDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxRegion where IndoTaxRegion.IndoTaxRegionId = In_IndoTaxRegionId) then
    insert into IndoTaxRegion(IndoTaxRegionId,IndoTaxRegionDesc) values(In_IndoTaxRegionId,In_IndoTaxRegionDesc);
    commit work;
    if not exists(select* from IndoTaxRegion where IndoTaxRegion.IndoTaxRegionId = In_IndoTaxRegionId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.PatchIndoTaxDetails()
begin
  declare Out_NoOfDependent integer;
  CreateIndoTaxDetailsLoop: for CreateIndoTaxDetailsFor as curs dynamic scroll cursor for
    select PersonalSysId as Out_PersonalSysId from Personal where EmployeeId <> '' do
    select Count(*) into Out_NoOfDependent
      from Family where
      PersonalSysId = Out_PersonalSysId and
      RelationshipId in('Son','Step Son','Daughter','Step Daughter');
    if not exists(select* from IndoTaxDetails where PersonalSysId = Out_PersonalSysId) then
      insert into IndoTaxDetails(PersonalSysId,
        NoOfDependent,
        IndoTaxMethod,
        IndoTaxPolicyId,
        IndoTaxEmployerId,
        IndoEETaxNo,
        PensionWorker) values(
        Out_PersonalSysId,
        Out_NoOfDependent,'TaxBenefit',null,null,'',0)
    end if end for;
  commit work
end
;

create procedure dba.UpdateIndoTaxDetails(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoEETaxNo char(30),
in In_NoOfDependent integer,
in In_IndoTaxMethod char(20),
in In_PensionWorker smallint,
in In_TaxCategory char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxDetails where IndoTaxDetails.PersonalSysId = In_PersonalSysId) then
    update IndoTaxDetails set
      IndoTaxPolicyId = In_IndoTaxPolicyId,
      IndoTaxEmployerId = In_IndoTaxEmployerId,
      IndoEETaxNo = In_IndoEETaxNo,
      NoOfDependent = In_NoOfDependent,
      IndoTaxMethod = In_IndoTaxMethod,
      PensionWorker = In_PensionWorker,
      TaxCategory = In_TaxCategory where
      PersonalSysId = In_PersonalSysId;
    if(select IdentityTypeId from Personal where PersonalSysId = In_PersonalSysId) = 'NPWP' then
      update Personal set IdentityNo = In_IndoEETaxNo where PersonalSysId = In_PersonalSysId
    end if;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateIndoTaxEmployee(
in In_IndoTaxRecSysId integer,
in In_IndoTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_IndoTaxLastProcessed integer,
out Out_Code integer)
begin
  if In_FromPayRecYear is null then set Out_Code=-1;
    return
  end if;
  if In_FromPayRecPeriod is null then set Out_Code=-2;
    return
  end if;
  if In_FromPayRecSubPeriod is null then set Out_Code=-3;
    return
  end if;
  if In_ToPayRecYear is null then set Out_Code=-4;
    return
  end if;
  if In_ToPayRecPeriod is null then set Out_Code=-5;
    return
  end if;
  if In_ToPayRecSubPeriod is null then set Out_Code=-6;
    return
  end if;
  if In_PayRecID is null then set Out_Code=-7;
    return
  end if;
  if exists(select* from IndoTaxEmployee where
      IndoTaxRecSysId = In_IndoTaxRecSysId and IndoTaxEESysId = In_IndoTaxEESysId) then
    if(In_IndoTaxLastProcessed = 1) then
      update IndoTaxEmployee set
        IndoTaxLastProcessed = 0 where
        IndoTaxRecSysId = In_IndoTaxRecSysId
    end if;
    update IndoTaxEmployee set
      FromPayRecYear = In_FromPayRecYear,
      FromPayRecPeriod = In_FromPayRecPeriod,
      FromPayRecSubPeriod = In_FromPayRecSubPeriod,
      ToPayRecYear = In_ToPayRecYear,
      ToPayRecPeriod = In_ToPayRecPeriod,
      ToPayRecSubPeriod = In_ToPayRecSubPeriod,
      PayRecID = In_PayRecID,
      IndoTaxLastProcessed = In_IndoTaxLastProcessed where
      IndoTaxRecSysId = In_IndoTaxRecSysId and IndoTaxEESysId = In_IndoTaxEESysId;
    commit work;
    set Out_Code=1
  end if
end
;

create procedure DBA.UpdateIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(20),
in In_IndoTaxAuthoriseTaxRefNo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(20),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
out Out_ErrorCode 
integer)
begin
  if exists(select* from IndoTaxEmployer where IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    update IndoTaxEmployer set
      IndoTaxEmployerDesc = In_IndoTaxEmployerDesc,
      IndoTaxAuthoriseName = In_IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo = In_IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo = In_IndoTaxAuthoriseTaxRefNo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      TypeOfBusiness = In_TypeOfBusiness,
      RegistrationNo = In_RegistrationNo,
      IndoOldAgeOption = In_IndoOldAgeOption,
      Signature = In_Signature where
      IndoTaxEmployerId = In_IndoTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateIndoTaxMonthly(
in In_IndoTaxMonthlyId char(20),
in In_IndoTaxMonthlyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_IndoTaxMonthlyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from IndoTaxMonthly where IndoTaxMonthlyId = In_IndoTaxMonthlyId) then
    update IndoTaxMonthly set
      IndoTaxMonthlyDesc = In_IndoTaxMonthlyDesc where
      IndoTaxMonthlyId = In_IndoTaxMonthlyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateIndoTaxPolicy(
in In_IndoTaxPolicyId char(20),
in In_IndoTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_IndoTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from IndoTaxPolicy where IndoTaxPolicyId = In_IndoTaxPolicyId) then
    update IndoTaxPolicy set
      IndoTaxPolicyDesc = In_IndoTaxPolicyDesc where
      IndoTaxPolicyId = In_IndoTaxPolicyId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateIndoTaxPolicyProg(
in In_IndoTaxPolicyProgSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxRegionId char(20),
in In_IndoTaxMonthlyId char(20),
in In_IndoTaxEffectiveDate date,
in In_IndoTaxFullBorneGovt double,
in In_IndoTaxOccuPercent double,
in In_IndoTaxOccuCapping double,
in In_IndoTaxPensionPercent double,
in In_IndoTaxPensionCapping double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxDependent double,
in In_IndoTaxDependentCap integer,
out Out_ErrorCode integer)
begin
  if In_IndoTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if In_IndoTaxRegionId is null then
    set Out_ErrorCode=-2;
    return
  end if;
  if In_IndoTaxMonthlyId is null then
    set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from IndoTaxPolicyProg where IndoTaxPolicyProgSysId = In_IndoTaxPolicyProgSysId) then
    update IndoTaxPolicyProg set
      IndoTaxPolicyId = In_IndoTaxPolicyId,
      IndoTaxRegionId = In_IndoTaxRegionId,
      IndoTaxMonthlyId = In_IndoTaxMonthlyId,
      IndoTaxEffectiveDate = In_IndoTaxEffectiveDate,
      IndoTaxFullBorneGovt = In_IndoTaxFullBorneGovt,
      IndoTaxOccuPercent = In_IndoTaxOccuPercent,
      IndoTaxOccuCapping = In_IndoTaxOccuCapping,
      IndoTaxPensionPercent = In_IndoTaxPensionPercent,
      IndoTaxPensionCapping = In_IndoTaxPensionCapping,
      IndoTaxPersonal = In_IndoTaxPersonal,
      IndoTaxMarriage = In_IndoTaxMarriage,
      IndoTaxDependent = In_IndoTaxDependent,
      IndoTaxDependentCap = In_IndoTaxDependentCap where
      IndoTaxPolicyProgSysId = In_IndoTaxPolicyProgSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateIndoTaxRecord(
in In_IndoTaxRecSysId integer,
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoTaxSerialNo integer,
in In_IndoTaxYear integer,
in In_IndoTaxFromPeriod integer,
in In_IndoTaxToPeriod integer,
in In_IndoTaxPermanent integer,
in In_IndoTaxBelowGovtBorne integer,
in In_IndoTaxSalary double,
in In_IndoTaxBenefit double,
in In_IndoTaxOtherAllowance double,
in In_IndoTaxOT double,
in In_IndoTaxHonoraria double,
in In_IndoTaxInsurance double,
in In_IndoTaxOtherBenefit double,
in In_IndoTaxBonus double,
in In_IndoTaxOccu double,
in In_IndoTaxOccuBonus double,
in In_IndoTaxPension double,
in In_IndoTaxCurrentTaxable double,
in In_IndoTaxAnnualTaxable double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxNoDependent integer,
in In_IndoTaxDependent double,
in In_IndoTaxTotalTaxable double,
in In_IndoTaxPrevTaxable double,
in In_IndoTaxPrevTaxAmt double,
in In_IndoTaxBorneGovt double,
in In_IndoTaxBalPayableTax double,
in In_IndoTaxAnnualAmt double,
in In_IndoTaxActualTaxAmt double,
in In_IndoTaxPaidTaxAmt double,
in In_IndoTaxBalance double,
in In_IndoTaxExcess double,
out Out_ErrorCode integer)
begin
  if In_IndoTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if In_IndoTaxEmployerId is null then
    set Out_ErrorCode=-2;
    return
  end if;
  if In_IndoTaxFromPeriod > In_IndoTaxToPeriod then
    set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from IndoTaxRecord where
      IndoTaxRecSysId = In_IndoTaxRecSysId) then
    update IndoTaxRecord set
      PersonalSysId = In_PersonalSysId,
      IndoTaxPolicyId = In_IndoTaxPolicyId,
      IndoTaxEmployerId = In_IndoTaxEmployerId,
      IndoTaxSerialNo = In_IndoTaxSerialNo,
      IndoTaxYear = In_IndoTaxYear,
      IndoTaxFromPeriod = In_IndoTaxFromPeriod,
      IndoTaxToPeriod = In_IndoTaxToPeriod,
      IndoTaxPermanent = In_IndoTaxPermanent,
      IndoTaxBelowGovtBorne = In_IndoTaxBelowGovtBorne,
      IndoTaxSalary = In_IndoTaxSalary,
      IndoTaxBenefit = In_IndoTaxBenefit,
      IndoTaxOtherAllowance = In_IndoTaxOtherAllowance,
      IndoTaxOT = In_IndoTaxOT,
      IndoTaxHonoraria = In_IndoTaxHonoraria,
      IndoTaxInsurance = In_IndoTaxInsurance,
      IndoTaxOtherBenefit = In_IndoTaxOtherBenefit,
      IndoTaxBonus = In_IndoTaxBonus,
      IndoTaxOccu = In_IndoTaxOccu,
      IndoTaxOccuBonus = In_IndoTaxOccuBonus,
      IndoTaxPension = In_IndoTaxPension,
      IndoTaxCurrentTaxable = In_IndoTaxCurrentTaxable,
      IndoTaxAnnualTaxable = In_IndoTaxAnnualTaxable,
      IndoTaxPersonal = In_IndoTaxPersonal,
      IndoTaxMarriage = In_IndoTaxMarriage,
      IndoTaxNoDependent = In_IndoTaxNoDependent,
      IndoTaxDependent = In_IndoTaxDependent,
      IndoTaxTotalTaxable = In_IndoTaxTotalTaxable,
      IndoTaxPrevTaxable = In_IndoTaxPrevTaxable,
      IndoTaxPrevTaxAmt = In_IndoTaxPrevTaxAmt,
      IndoTaxBorneGovt = In_IndoTaxBorneGovt,
      IndoTaxBalPayableTax = In_IndoTaxBalPayableTax,
      IndoTaxAnnualAmt = In_IndoTaxAnnualAmt,
      IndoTaxActualTaxAmt = In_IndoTaxActualTaxAmt,
      IndoTaxPaidTaxAmt = In_IndoTaxPaidTaxAmt,
      IndoTaxBalance = In_IndoTaxBalance,
      IndoTaxExcess = In_IndoTaxExcess where
      IndoTaxRecSysId = In_IndoTaxRecSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-4
  end if
end
;


create procedure dba.UpdateIndoTaxRegion(
in In_IndoTaxRegionId char(20),
in In_IndoTaxRegionDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from IndoTaxRegion where IndoTaxRegionId = In_IndoTaxRegionId) then
    update IndoTaxRegion set
      IndoTaxRegionDesc = In_IndoTaxRegionDesc where
      IndoTaxRegionId = In_IndoTaxRegionId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.FGetIndoMonthName(
in In_MonthNumber integer)
returns char(10)
begin
  if In_MonthNumber = 1 then return 'Januari'
  elseif In_MonthNumber = 2 then return 'Februari'
  elseif In_MonthNumber = 3 then return 'Maret'
  elseif In_MonthNumber = 4 then return 'April'
  elseif In_MonthNumber = 5 then return 'Mei'
  elseif In_MonthNumber = 6 then return 'Juni'
  elseif In_MonthNumber = 7 then return 'Juli'
  elseif In_MonthNumber = 8 then return 'Agustus'
  elseif In_MonthNumber = 9 then return 'September'
  elseif In_MonthNumber = 10 then return 'Oktober'
  elseif In_MonthNumber = 11 then return 'November'
  elseif In_MonthNumber = 12 then return 'Desember'
  end if
end
;

create procedure dba.DeleteIndoTaxRecordByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from IndoTaxRecord where PersonalSysId = In_PersonalSysId) then
    IndoTaxRecLoop: for IndoTaxRecFor as IndoTaxRecCurs dynamic scroll cursor for
      select IndoTaxRecord.IndoTaxRecSysId as Out_IndoTaxRecSysId from IndoTaxRecord where
        IndoTaxRecord.PersonalSysId = In_PersonalSysId do
      delete from IndoTaxEmployee where IndoTaxEmployee.IndoTaxRecSysId = Out_IndoTaxRecSysId;
      commit work end for;
    delete from IndoTaxRecord where PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create function DBA.FGetCompanyCity(
in In_CompanyId char(20))
returns char(100)
begin
  declare Out_CompanyCity char(60);
  select FGetCityName(Company.CompanyCity) into Out_CompanyCity
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyCity)
end
;

