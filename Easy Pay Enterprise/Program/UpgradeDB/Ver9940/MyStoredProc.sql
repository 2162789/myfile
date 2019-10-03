if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormDifference') then
   drop procedure FGetEAFormDifference
end if
;

create function
dba.FGetEAFormDifference(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Month integer)
returns double
begin
  declare total double;
  // obtain the total of EA Form's editable values
  // the value will be used in CP159 form, appended into December's gross wage.
  if(In_Month <> 12) then
    return 0
  end if;
  select(MalTaxMotorCarFuel+MalTaxDriver+
    MalTaxUtility+MalTaxFurniture+MalTaxFullKitchenEquip+
    MalTaxFittings+MalTaxKitchenEquip+MalTaxHandphone+
    MalTaxServant+MalTaxHolidays+MalTaxOtherFoodCloth+
    MalTaxAccomdation+MalTaxRefundPension+MalTaxAnnuity) into total
    from MalTaxRecord join MalTaxEmployee where
    MalTaxEESysId = In_EmployeeSysId and FGetMalTaxRecordYear(MalTaxRecord.MalTaxYear) = In_Year;
  return total
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxPolicyProg') then
   drop procedure InsertNewMalTaxPolicyProg
end if
;

create procedure
dba.InsertNewMalTaxPolicyProg(
in In_MalTaxPolicyId char(20),
in In_MalSTDPolicyId char(20),
in In_MalTaxPolicyEffDate date,
in In_MalChildOutside integer,
in In_MalChildInside integer,
in In_MalChildDisabled integer,
in In_MalCat1Relief double,
in In_MalCat2ChildRelief double,
in In_MalCat2Relief double,
in In_MalCat3ChildRelief double,
in In_MalCat3Relief double,
in In_EPFCappingOption smallint,
in In_EPFCappingYearly double,
in In_EPFCappingMonthly double,
in In_MalTaxCompenPerYr double,
in In_MalTaxMinTaxAmt double,
in In_PetrolOCappingOption smallint,
in In_PetrolOCappingYearly double,
in In_PetrolOCappingMonthly double,
in In_PetrolNOCappingOption smallint,
in In_PetrolNOCappingYearly double,
in In_PetrolNOCappingMonthly double,
out Out_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  select max(MalTaxPolicyProgSysId) into Out_MalTaxPolicyProgSysId from MalTaxPolicyProg;
  if(Out_MalTaxPolicyProgSysId is null) then
    set Out_MalTaxPolicyProgSysId=0
  end if;
  if not exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
    insert into MalTaxPolicyProg(MalTaxPolicyProgSysId,
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
      EPFCappingMonthly,
      MalTaxCompenPerYr,
      MalTaxMinTaxAmt,
      PetrolOCappingOption,
      PetrolOCappingYearly,
      PetrolOCappingMonthly,
      PetrolNOCappingOption,
      PetrolNOCappingYearly,
      PetrolNOCappingMonthly) values(
      Out_MalTaxPolicyProgSysId+1,
      In_MalTaxPolicyId,
      In_MalSTDPolicyId,
      In_MalTaxPolicyEffDate,
      In_MalChildOutside,
      In_MalChildInside,
      In_MalChildDisabled,
      In_MalCat1Relief,
      In_MalCat2ChildRelief,
      In_MalCat2Relief,
      In_MalCat3ChildRelief,
      In_MalCat3Relief,
      In_EPFCappingOption,
      In_EPFCappingYearly,
      In_EPFCappingMonthly,
      In_MalTaxCompenPerYr,
      In_MalTaxMinTaxAmt,
      In_PetrolOCappingOption,
      In_PetrolOCappingYearly,
      In_PetrolOCappingMonthly,
      In_PetrolNOCappingOption,
      In_PetrolNOCappingYearly,
      In_PetrolNOCappingMonthly);
    commit work;
    if not exists(select* from MalTaxPolicyProg where
        MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
      set Out_MalTaxPolicyProgSysId=null;
      set Out_ErrorCode=0
    else
      set Out_MalTaxPolicyProgSysId=Out_MalTaxPolicyProgSysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_MalTaxPolicyProgSysId=null;
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalTaxPolicyProg') then
   drop procedure UpdateMalTaxPolicyProg
end if
;

create procedure
dba.UpdateMalTaxPolicyProg(
in In_MalTaxPolicyProgSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalSTDPolicyId char(20),
in In_MalTaxPolicyEffDate date,
in In_MalChildOutside integer,
in In_MalChildInside integer,
in In_MalChildDisabled integer,
in In_MalCat1Relief double,
in In_MalCat2ChildRelief double,
in In_MalCat2Relief double,
in In_MalCat3ChildRelief double,
in In_MalCat3Relief double,
in In_EPFCappingOption smallint,
in In_EPFCappingYearly double,
in In_EPFCappingMonthly double,
in In_MalTaxCompenPerYr double,
in In_MalTaxMinTaxAmt double,
in In_PetrolOCappingOption smallint,
in In_PetrolOCappingYearly double,
in In_PetrolOCappingMonthly double,
in In_PetrolNOCappingOption smallint,
in In_PetrolNOCappingYearly double,
in In_PetrolNOCappingMonthly double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    update MalTaxPolicyProg set
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalSTDPolicyId = In_MalSTDPolicyId,
      MalTaxPolicyEffDate = In_MalTaxPolicyEffDate,
      MalChildOutside = In_MalChildOutside,
      MalChildInside = In_MalChildInside,
      MalChildDisabled = In_MalChildDisabled,
      MalCat1Relief = In_MalCat1Relief,
      MalCat2ChildRelief = In_MalCat2ChildRelief,
      MalCat2Relief = In_MalCat2Relief,
      MalCat3ChildRelief = In_MalCat3ChildRelief,
      MalCat3Relief = In_MalCat3Relief,
      EPFCappingOption = In_EPFCappingOption,
      EPFCappingYearly = In_EPFCappingYearly,
      EPFCappingMonthly = In_EPFCappingMonthly,
      MalTaxCompenPerYr = In_MalTaxCompenPerYr,
      MalTaxMinTaxAmt = In_MalTaxMinTaxAmt,
      PetrolOCappingOption = In_PetrolOCappingOption,
      PetrolOCappingYearly = In_PetrolOCappingYearly,
      PetrolOCappingMonthly = In_PetrolOCappingMonthly,
      PetrolNOCappingOption = In_PetrolNOCappingOption,
      PetrolNOCappingYearly = In_PetrolNOCappingYearly,
      PetrolNOCappingMonthly = In_PetrolNOCappingMonthly where
      MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalMthNonOfficialPetrolRelief') then
   drop procedure FGetMalMthNonOfficialPetrolRelief
end if
;

create function 
dba.FGetMalMthNonOfficialPetrolRelief(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare NonTaxablePetrol double;
  declare PetrolRelief double;
  /*
  Non Taxable Petrol Allowance
  */
  select FConvertNull(Sum(AllowanceAmount)) into NonTaxablePetrol from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 1 and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Petrol Relief
  */
  select FConvertNull(Sum(TotalMOSQ)) into PetrolRelief from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  return PetrolRelief+NonTaxablePetrol
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalMthOfficialPetrolRelief') then
   drop procedure FGetMalMthOfficialPetrolRelief
end if
;

create function 
dba.FGetMalMthOfficialPetrolRelief(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare NonTaxablePetrol double;
  declare PetrolRelief double;
  /*
  Non Taxable Petrol Allowance
  */
  select FConvertNull(Sum(AllowanceAmount)) into NonTaxablePetrol from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 1 and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Petrol Relief
  */
  select FConvertNull(Sum(TotalYMF)) into PetrolRelief from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  return PetrolRelief+NonTaxablePetrol
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalYTDNonOfficialPetrolRelief') then
   drop procedure FGetMalYTDNonOfficialPetrolRelief
end if
;

create function 
dba.FGetMalYTDNonOfficialPetrolRelief(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare NonTaxablePetrol double;
  declare PetrolRelief double;
  /*
  Non Taxable Petrol Allowance
  */
  select FConvertNull(Sum(AllowanceAmount)) into NonTaxablePetrol from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 1 and
    PayRecYear = In_PayRecYear;
  /*
  Petrol Relief
  */
  select FConvertNull(Sum(TotalMOSQ)) into PetrolRelief from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear;
  return PetrolRelief+NonTaxablePetrol
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalYTDOfficialPetrolRelief') then
   drop procedure FGetMalYTDOfficialPetrolRelief
end if
;

create function 
dba.FGetMalYTDOfficialPetrolRelief(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare NonTaxablePetrol double;
  declare PetrolRelief double;
  /*
  Non Taxable Petrol Allowance
  */
  select FConvertNull(Sum(AllowanceAmount)) into NonTaxablePetrol from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 1 and
    PayRecYear = In_PayRecYear;
  /*
  Petrol Relief
  */
  select FConvertNull(Sum(TotalYMF)) into PetrolRelief from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear;
  return PetrolRelief+NonTaxablePetrol
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalMalPayPeriodTaxWage') then
   drop procedure ASQLCalMalPayPeriodTaxWage
end if
;

create procedure
DBA.ASQLCalMalPayPeriodTaxWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurrentNonAllowance double,
out Out_CurrentAllowance double,
out Out_CurrentAdditional double,
out Out_CurrentCompensation double,
out Out_PreviousNonAllowance double,
out Out_PreviousAllowance double,
out Out_PreviousAdditional double,
out Out_PreviousCompensation double,
out Out_CurrentNonAllowanceEPF double,
out Out_CurrentAllowanceEPF double,
out Out_CurrentAdditionalEPF double,
out Out_PreviousNonAllowanceEPF double,
out Out_PreviousAllowanceEPF double,
out Out_PreviousAdditionalEPF double,
out Out_CurrentOffPetrol double,
out Out_CurrentNonOffPetrol double,
out Out_PreviousOffPetrol double,
out Out_PreviousNonOffPetrol double)
begin
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  set Out_CurrentNonAllowance=0;
  set Out_CurrentAllowance=0;
  set Out_CurrentAdditional=0;
  set Out_CurrentCompensation=0;
  set Out_PreviousNonAllowance=0;
  set Out_PreviousAllowance=0;
  set Out_PreviousAdditional=0;
  set Out_PreviousCompensation=0;
  set Out_CurrentNonAllowanceEPF=0;
  set Out_CurrentAllowanceEPF=0;
  set Out_CurrentAdditionalEPF=0;
  set Out_PreviousNonAllowanceEPF=0;
  set Out_PreviousAllowanceEPF=0;
  set Out_PreviousAdditionalEPF=0;
  set Out_CurrentOffPetrol=0;
  set Out_CurrentNonOffPetrol=0;
  set Out_PreviousOffPetrol=0;
  set Out_PreviousNonOffPetrol=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  /*

  Period 1 will then consider Back Pay and OT Back Pay as Previous Year
  */
  if(In_PayRecPeriod > 1) then
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt+CalOTBackPay+CalBackPay)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Current Non Allowance Subject to EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt+CalBackPay)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  else
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Current Non Allowance Subject to EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  end if;
  /*
  Shift Amount
  */
  if(Out_CurrentNonAllowance <> 0) then
    select FConvertNull(Sum(ShiftAmount)) into Out_ShiftTotal from
      ShiftRecord where
      (IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEVolEPF') = 1) and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Non Allowance Subject to EPF
  */
  set Out_CurrentNonAllowanceEPF=Out_CurrentNonAllowanceEPF+Out_OTTotal+Out_ShiftTotal;
  /*
  Non Taxabale Pay Element:
  ZakatCode
  EPFDedCode
  SOCSODedCode
  WP39Code
  CP38Code
  All Reimbursement
  */
  /*
  Subject Tax Additional Wage
  Compensation Code
  Official Petrol Code
  Non Official Petrol Code    
  are not included as there is capping to apply
  */
  /*
  Current Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Allowance Subject to EPF          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowanceEPF from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Additional Subject to EPF
  */
  if(Out_CurrentAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Non Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentNonOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Period 1 Back Pay and Back Pay OT is considered as Previous Allowance
  */
  if(In_PayRecPeriod = 1) then
    /*
    Previous Non Allowance
    */
    select FConvertNull(Sum(CalOTBackPay+CalBackPay)) into Out_PreviousNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Previous Non Allowance Subject to EPF
    */
    if(Out_PreviousNonAllowance <> 0) then
      select FConvertNull(Sum(CalBackPay)) into Out_PreviousNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      OT Amount
      */
      select FConvertNull(Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      set Out_PreviousNonAllowanceEPF=Out_PreviousNonAllowanceEPF+Out_OTTotal
    end if
  end if;
  /*
  Previous Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Allowance Subject to EPF
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowanceEPF from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Additional Subject to EPF
  */
  if(Out_PreviousAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Previous Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Non Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousNonOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalMalPayRecTaxWage') then
   drop procedure ASQLCalMalPayRecTaxWage
end if
;

create procedure
DBA.ASQLCalMalPayRecTaxWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_CurrentNonAllowance double,
out Out_CurrentAllowance double,
out Out_CurrentAdditional double,
out Out_CurrentCompensation double,
out Out_PreviousNonAllowance double,
out Out_PreviousAllowance double,
out Out_PreviousAdditional double,
out Out_PreviousCompensation double,
out Out_CurrentNonAllowanceEPF double,
out Out_CurrentAllowanceEPF double,
out Out_CurrentAdditionalEPF double,
out Out_PreviousNonAllowanceEPF double,
out Out_PreviousAllowanceEPF double,
out Out_PreviousAdditionalEPF double,
out Out_CurrentOffPetrol double,
out Out_CurrentNonOffPetrol double,
out Out_PreviousOffPetrol double,
out Out_PreviousNonOffPetrol double)
begin
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  set Out_CurrentNonAllowance=0;
  set Out_CurrentAllowance=0;
  set Out_CurrentAdditional=0;
  set Out_CurrentCompensation=0;
  set Out_PreviousNonAllowance=0;
  set Out_PreviousAllowance=0;
  set Out_PreviousAdditional=0;
  set Out_PreviousCompensation=0;
  set Out_CurrentNonAllowanceEPF=0;
  set Out_CurrentAllowanceEPF=0;
  set Out_CurrentAdditionalEPF=0;
  set Out_PreviousNonAllowanceEPF=0;
  set Out_PreviousAllowanceEPF=0;
  set Out_PreviousAdditionalEPF=0;
  set Out_CurrentOffPetrol=0;
  set Out_CurrentNonOffPetrol=0;
  set Out_PreviousOffPetrol=0;
  set Out_PreviousNonOffPetrol=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  /*

  Period 1 will then consider Back Pay and OT Back Pay as Previous Year
  */
  if(In_PayRecPeriod > 1) then
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt+CalOTBackPay+CalBackPay)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Current Non Allowance Subject to EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt+CalBackPay)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId
    end if
  else
    /*
    Current Non Allowance

    */
    select FConvertNull(Sum(CalTotalWage+CalOTAmount+CalShiftAmount+CalLveDeductAmt)) into Out_CurrentNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Current Non Allowance Subject to EPF
    */
    if(Out_CurrentNonAllowance <> 0) then
      select FConvertNull(Sum(CalTotalWage+CalLveDeductAmt)) into Out_CurrentNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(CurrentOTAmount)+Sum(LastOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId
    end if
  end if;
  /*
  Shift Amount
  */
  if(Out_CurrentNonAllowance <> 0) then
    select FConvertNull(Sum(ShiftAmount)) into Out_ShiftTotal from
      ShiftRecord where
      (IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjEEVolEPF') = 1) and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Current Non Allowance Subject to EPF
  */
  set Out_CurrentNonAllowanceEPF=Out_CurrentNonAllowanceEPF+Out_OTTotal+Out_ShiftTotal;
  /*
  Non Taxabale Pay Element:
  ZakatCode
  EPFDedCode
  SOCSODedCode
  WP39Code
  CP38Code
  All Reimbursement
  */
  /*
  Subject Tax Additional Wage
  Compensation Code
  Official Petrol Code
  Non Official Petrol Code    
  are not included as there is capping to apply
  */
  /*
  Current Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Allowance Subject to EPF          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowanceEPF from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Additional Subject to EPF
  */
  if(Out_CurrentAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Current Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Current Non Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentNonOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Period 1 Back Pay and Back Pay OT is considered as Previous Allowance
  */
  if(In_PayRecPeriod = 1) then
    /*
    Previous Non Allowance
    */
    select FConvertNull(Sum(CalOTBackPay+CalBackPay)) into Out_PreviousNonAllowance from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId;
    /*
    Previous Non Allowance Subject to EPF
    */
    if(Out_PreviousNonAllowance <> 0) then
      select FConvertNull(Sum(CalBackPay)) into Out_PreviousNonAllowanceEPF from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      /*
      OT Amount
      */
      select FConvertNull(Sum(BackPayOTAmount)) into Out_OTTotal from
        OTRecord where
        (IsFormulaIdHasProperty(OTFormulaId,'SubjEEManEPF') = 1 or
        IsFormulaIdHasProperty(OTFormulaId,'SubjEEVolEPF') = 1) and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecId = In_PayRecId;
      set Out_PreviousNonAllowanceEPF=Out_PreviousNonAllowanceEPF+Out_OTTotal
    end if
  end if;
  /*
  Previous Allowance          
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowance from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'ZakatCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'EPFDedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SOCSODedCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'WP39Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CP38Code') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Allowance Subject to EPF
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowanceEPF from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
    (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Additional Subject to EPF
  */
  if(Out_PreviousAdditional <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditionalEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 1 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId
  end if;
  /*
  Previous Compensation
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousCompensation from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'OffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId;
  /*
  Previous Non Official Petrol
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousNonOffPetrol from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonOffPetrolCode') = 1 and
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxRecordEmployeeSysId' and user_name(creator) = 'DBA') then
   drop procedure DBA.FGetMalTaxRecordEmployeeSysId
end if;


CREATE FUNCTION "DBA"."FGetMalTaxRecordEmployeeSysId"(
in In_PersonalSysId integer,
in In_MalTaxYear integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare TaxEmploymentCount integer;
  select Count(*) into TaxEmploymentCount from MalTaxEmployee where
    PersonalSysId = In_PersonalSysId and
    MalTaxYear = In_MalTaxYear;
  /*
  Only 1 Employment (No Rejoin)
  */
  if(TaxEmploymentCount = 1) then
    select MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  else
    /*
    Assume the latest especially for Histroical Records that are not fixed
    User should split the current year records
    */
    select first MalTaxEESysId into Out_EmployeeSysId from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear order by ToPayRecYear desc,ToPayRecPeriod desc
  end if;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  return(Out_EmployeeSysId)
end
;
