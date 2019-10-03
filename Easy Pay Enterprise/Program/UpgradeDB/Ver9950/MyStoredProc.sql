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

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalPrevEmployer') then
   drop procedure InsertNewMalPrevEmployer
end if;

create procedure
DBA.InsertNewMalPrevEmployer(in In_EmployeeSysId integer,in In_CompanyName char(100),in In_CessationDate date,in In_YTDTaxWage double,in In_YTDEPFRelief double,in In_YTDZakatRelief double,in In_YTDTaxAmt double,out Out_ErrorCode integer)
begin
  if not exists(select* from MalPrevEmployer where
      EmployeeSysId = In_EmployeeSysId and
      CompanyName = In_CompanyName and
      CessationDate = In_CessationDate and
      YTDTaxWage = In_YTDTaxWage and
      YTDEPFRelief = In_YTDEPFRelief and
      YTDZakatRelief = In_YTDZakatRelief and
      YTDTaxAmt = In_YTDTaxAmt) then
    insert into MalPrevEmployer(EmployeeSysId,
      CompanyName,
      CessationDate,
      YTDTaxWage,
      YTDEPFRelief,
      YTDZakatRelief,
      YTDTaxAmt) values(
      In_EmployeeSysId,
      In_CompanyName,
      In_CessationDate,
      In_YTDTaxWage,
      In_YTDEPFRelief,
      In_YTDZakatRelief,
      In_YTDTaxAmt);
    commit work;
    if not exists(select* from MalPrevEmployer where
        EmployeeSysId = In_EmployeeSysId and
        CompanyName = In_CompanyName and
        CessationDate = In_CessationDate and
        YTDTaxWage = In_YTDTaxWage and
        YTDEPFRelief = In_YTDEPFRelief and
        YTDZakatRelief = In_YTDZakatRelief and
        YTDTaxAmt = In_YTDTaxAmt) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalRebateClaim') then
   drop procedure InsertNewMalRebateClaim
end if;

create procedure
DBA.InsertNewMalRebateClaim(in In_PersonalSysId integer,in In_RebateDate date,in In_ePortalStatus char(20),in In_CreatedBy char(1),in In_PayrollProcessDate date,in In_PayrollYear integer,in In_PayrollPeriod integer,out Out_ErrorCode integer)
begin
  if not exists(select* from RebateClaim where
      PersonalSysId = In_PersonalSysId and
      RebateDate = In_RebateDate and
      ePortalStatus = In_ePortalStatus and
      CreatedBy = In_CreatedBy and
      PayrollProcessDate = In_PayrollProcessDate and
      PayrollYear = In_PayrollYear and
      PayrollPeriod = In_PayrollPeriod) then
    insert into
      RebateClaim(PersonalSysId,
      RebateDate,
      ePortalStatus,
      CreatedBy,
      PayrollProcessDate,
      PayrollYear,
      PayrollPeriod) values(
      In_PersonalSysId,
      In_RebateDate,
      In_ePortalStatus,
      In_CreatedBy,
      In_PayrollProcessDate,
      In_PayrollYear,
      In_PayrollPeriod);
    commit work;
    if not exists(select* from RebateClaim where
        PersonalSysId = In_PersonalSysId and
        RebateDate = In_RebateDate and
        ePortalStatus = In_ePortalStatus and
        CreatedBy = In_CreatedBy and
        PayrollProcessDate = In_PayrollProcessDate and
        PayrollYear = In_PayrollYear and
        PayrollPeriod = In_PayrollPeriod) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalRebateClaimRecord') then
   drop procedure InsertNewMalRebateClaimRecord
end if;

create procedure
DBA.InsertNewMalRebateClaimRecord(in In_RebateSysId integer,in In_RebateID char(20),in In_RebateClaimAmt double,in In_RebateReferenceNo char(20),in In_RebateReceiptDate date,in In_RebateRemarks char(100),out Out_ErrorCode integer)
begin
  if not exists(select* from RebateClaimRecord where
      RebateSysId = In_RebateSysId and
      RebateID = In_RebateID and
      RebateClaimAmt = In_RebateClaimAmt and
      RebateReferenceNo = In_RebateReferenceNo and
      RebateReceiptDate = In_RebateReceiptDate and
      RebateRemarks = In_RebateRemarks) then
    if(In_RebateReceiptDate = '1899-12-30') then
      insert into RebateClaimRecord(RebateSysId,
        RebateID,
        RebateClaimAmt,
        RebateReferenceNo,
        RebateReceiptDate,
        RebateRemarks) values(
        In_RebateSysId,
        In_RebateID,
        In_RebateClaimAmt,
        In_RebateReferenceNo,
        null,
        In_RebateRemarks)
    else
      insert into RebateClaimRecord(RebateSysId,
        RebateID,
        RebateClaimAmt,
        RebateReferenceNo,
        RebateReceiptDate,
        RebateRemarks) values(
        In_RebateSysId,
        In_RebateID,
        In_RebateClaimAmt,
        In_RebateReferenceNo,
        In_RebateReceiptDate,
        In_RebateRemarks)
    end if;
    commit work;
    if not exists(select* from RebateClaimRecord where
        RebateSysId = In_RebateSysId and
        RebateID = In_RebateID and
        RebateClaimAmt = In_RebateClaimAmt and
        RebateReferenceNo = In_RebateReferenceNo and
        RebateRemarks = In_RebateRemarks) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalRebateGranted') then
   drop procedure InsertNewMalRebateGranted
end if;

create procedure
DBA.InsertNewMalRebateGranted(in In_RebateID char(20),in In_PersonalSysId integer,in In_RebatePayrollYear integer,in In_RebatePayrollPeriod integer,in In_RebateDeclaredYear integer,in In_RebateAmt double,in In_TaxableAmt double,in In_AddTaxableAmt double,in In_CreatedBy char(1),out Out_ErrorCode integer)
begin
  if not exists(select* from RebateGranted where
      RebateID = In_RebateID and
      PersonalSysId = In_PersonalSysId and
      RebatePayrollYear = In_RebatePayrollYear and
      RebatePayrollPeriod = In_RebatePayrollPeriod and
      RebateDeclaredYear = In_RebateDeclaredYear and
      RebateAmt = In_RebateAmt and
      TaxableAmt = In_TaxableAmt and
      AddTaxableAmt = In_AddTaxableAmt and
      CreatedBy = In_CreatedBy) then
    insert into RebateGranted(RebateID,
      PersonalSysId,
      RebatePayrollYear,
      RebatePayrollPeriod,
      RebateDeclaredYear,
      RebateAmt,
      TaxableAmt,
      AddTaxableAmt,
      CreatedBy) values(
      In_RebateID,
      In_PersonalSysId,
      In_RebatePayrollYear,
      In_RebatePayrollPeriod,
      In_RebateDeclaredYear,
      In_RebateAmt,
      In_TaxableAmt,
      In_AddTaxableAmt,
      In_CreatedBy);
    commit work;
    if not exists(select* from RebateGranted where
        RebateID = In_RebateID and
        PersonalSysId = In_PersonalSysId and
        RebatePayrollYear = In_RebatePayrollYear and
        RebatePayrollPeriod = In_RebatePayrollPeriod and
        RebateDeclaredYear = In_RebateDeclaredYear and
        RebateAmt = In_RebateAmt and
        TaxableAmt = In_TaxableAmt and
        AddTaxableAmt = In_AddTaxableAmt and
        CreatedBy = In_CreatedBy) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalPrevEmployer') then
   drop procedure UpdateMalPrevEmployer
end if;

create procedure DBA.UpdateMalPrevEmployer(in In_MalPrevEmployerSysId integer,in In_EmployeeSysId integer,in In_CompanyName char(100),in In_CessationDate date,in In_YTDTaxWage double,in In_YTDEPFRelief double,in In_YTDZakatRelief double,in In_YTDTaxAmt double,out Out_ErrorCode integer)
begin
  if exists(select* from MalPrevEmployer where
      MalPrevEmployerSysId = In_MalPrevEmployerSysId) then
    update MalPrevEmployer set
      EmployeeSysId = In_EmployeeSysId,
      CompanyName = In_CompanyName,
      CessationDate = In_CessationDate,
      YTDTaxWage = In_YTDTaxWage,
      YTDEPFRelief = In_YTDEPFRelief,
      YTDZakatRelief = In_YTDZakatRelief,
      YTDTaxAmt = In_YTDTaxAmt where
      MalPrevEmployerSysId = In_MalPrevEmployerSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalRebateClaim') then
   drop procedure UpdateMalRebateClaim
end if;

create procedure DBA.UpdateMalRebateClaim(in In_RebateSysId integer,in In_PersonalSysId integer,in In_RebateDate date,in In_ePortalStatus char(20),in In_CreatedBy char(1),in In_PayrollProcessDate date,in In_PayrollYear integer,in In_PayrollPeriod integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaim where RebateSysId = In_RebateSysId) then
    update RebateClaim set
      PersonalSysId = In_PersonalSysId,
      RebateDate = In_RebateDate,
      ePortalStatus = In_ePortalStatus,
      CreatedBy = In_CreatedBy,
      PayrollProcessDate = In_PayrollProcessDate,
      PayrollYear = In_PayrollYear,
      PayrollPeriod = In_PayrollPeriod where
      RebateSysId = In_RebateSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalRebateClaimRecord') then
   drop procedure UpdateMalRebateClaimRecord
end if;

create procedure DBA.UpdateMalRebateClaimRecord(in In_RebateClaimRecordSysId integer,in In_RebateSysId integer,in In_RebateID char(20),in In_RebateClaimAmt double,in In_RebateReferenceNo char(20),in In_RebateReceiptDate date,in In_RebateRemarks char(100),out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaimRecord where RebateClaimRecordSysId = In_RebateClaimRecordSysId) then
    if(In_RebateReceiptDate = '1899-12-30') then
      update RebateClaimRecord set
        RebateSysId = In_RebateSysId,
        RebateID = In_RebateID,
        RebateClaimAmt = In_RebateClaimAmt,
        RebateReferenceNo = In_RebateReferenceNo,
        RebateReceiptDate = null,
        RebateRemarks = In_RebateRemarks where
        RebateClaimRecordSysId = In_RebateClaimRecordSysId
    else
      update RebateClaimRecord set
        RebateSysId = In_RebateSysId,
        RebateID = In_RebateID,
        RebateClaimAmt = In_RebateClaimAmt,
        RebateReferenceNo = In_RebateReferenceNo,
        RebateReceiptDate = In_RebateReceiptDate,
        RebateRemarks = In_RebateRemarks where
        RebateClaimRecordSysId = In_RebateClaimRecordSysId
    end if;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalRebateGranted') then
   drop procedure UpdateMalRebateGranted
end if;

create procedure DBA.UpdateMalRebateGranted(in In_RebateGrantSysId integer,in In_RebateID char(20),in In_PersonalSysId integer,in In_RebatePayrollYear integer,in In_RebatePayrollPeriod integer,in In_RebateDeclaredYear integer,in In_RebateAmt double,in In_TaxableAmt double,in In_AddTaxableAmt double,in In_CreatedBy char(1),out Out_ErrorCode integer)
begin
  if exists(select* from RebateGranted where
      RebateGrantSysId = In_RebateGrantSysId) then
    update RebateGranted set
      RebateID = In_RebateID,
      PersonalSysId = In_PersonalSysId,
      RebatePayrollYear = In_RebatePayrollYear,
      RebatePayrollPeriod = In_RebatePayrollPeriod,
      RebateDeclaredYear = In_RebateDeclaredYear,
      RebateAmt = In_RebateAmt,
      TaxableAmt = In_TaxableAmt,
      AddTaxableAmt = In_AddTaxableAmt,
      CreatedBy = In_CreatedBy where
      RebateGrantSysId = In_RebateGrantSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalPrevEmployer') then
   drop procedure DeleteMalPrevEmployer
end if;

create procedure DBA.DeleteMalPrevEmployer(in In_MalPrevEmployerSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId) then
    delete from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId;
    commit work;
    if exists(select* from MalPrevEmployer where MalPrevEmployerSysId = In_MalPrevEmployerSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalPrevEmployerByEmployeeSysId') then
   drop procedure DeleteMalPrevEmployerByEmployeeSysId
end if;

create procedure DBA.DeleteMalPrevEmployerByEmployeeSysId(in In_EmployeeSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from MalPrevEmployer where EmployeeSysId = In_EmployeeSysId) then
    delete from MalPrevEmployer where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from MalPrevEmployer where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateClaim') then
   drop procedure DeleteMalRebateClaim
end if;

create procedure DBA.DeleteMalRebateClaim(in In_RebateSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaim where RebateSysId = In_RebateSysId) then
    if exists(select* from RebateClaimRecord where RebateSysId = In_RebateSysId) then
      call DeleteMalRebateClaimRecordByRebateSysId(In_RebateSysId)
    end if;
    delete from RebateClaim where RebateSysId = In_RebateSysId;
    commit work;
    if exists(select* from RebateClaim where RebateSysId = In_RebateSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateClaimByPersonalSysId') then
   drop procedure DeleteMalRebateClaimByPersonalSysId
end if;

create procedure DBA.DeleteMalRebateClaimByPersonalSysId(in In_PersonalSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaim where PersonalSysId = In_PersonalSysId) then
    DeleteRebateSetupLoop: for RebateSetupFor as RebateSetupcurs dynamic scroll cursor for
      select RebateClaimRecordSysId as In_RebateClaimRecordSysId from RebateClaimRecord where
        RebateSysId = RebateSysId do
      call DeleteMalRebateClaimRecord(RebateClaimRecordSysId) end for;
    delete from RebateClaim where PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from RebateClaim where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateClaimRecord') then
   drop procedure DeleteMalRebateClaimRecord
end if;

create procedure DBA.DeleteMalRebateClaimRecord(in In_RebateClaimRecordSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaimRecord where RebateClaimRecordSysId = In_RebateClaimRecordSysId) then
    delete from RebateClaimRecord where RebateClaimRecordSysId = In_RebateClaimRecordSysId;
    commit work;
    if exists(select* from RebateClaimRecord where RebateClaimRecordSysId = In_RebateClaimRecordSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateClaimRecordByRebateSysId') then
   drop procedure DeleteMalRebateClaimRecordByRebateSysId
end if;

create procedure DBA.DeleteMalRebateClaimRecordByRebateSysId(in In_RebateSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateClaimRecord where RebateSysId = In_RebateSysId) then
    delete from RebateClaimRecord where RebateSysId = In_RebateSysId;
    commit work;
    if exists(select* from RebateClaimRecord where RebateSysId = In_RebateSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateGranted') then
   drop procedure DeleteMalRebateGranted
end if;

create procedure DBA.DeleteMalRebateGranted(in In_RebateGrantSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateGranted where RebateGrantSysId = In_RebateGrantSysId) then
    delete from RebateGranted where RebateGrantSysId = In_RebateGrantSysId;
    commit work;
    if exists(select* from RebateGranted where RebateGrantSysId = In_RebateGrantSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalRebateGrantedByPersonalSysId') then
   drop procedure DeleteMalRebateGrantedByPersonalSysId
end if;

create procedure DBA.DeleteMalRebateGrantedByPersonalSysId(in In_PersonalSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from RebateGranted where PersonalSysId = In_PersonalSysId) then
    delete from RebateGranted where PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from RebateGranted where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalRecord') then
   drop procedure DeletePersonalRecord
end if;

create procedure
dba.DeletePersonalRecord(in In_PersonalSysId integer)
begin
  if exists(select* from Personal where Personal.PersonalSysId = In_PersonalSysId) then
    EmployeeLoop: for EmployeeFor as Employeecurs dynamic scroll cursor for
      select Employee.EmployeeSysId as Out_EmployeeSysId from Employee where
        Employee.PersonalSysID = In_PersonalSysId do
      call ASQLDeleteEmployment(Out_EmployeeSysId);
      commit work end for;
    /*Standard deletion for all countries*/
    call DeletePersonalEmailAll(In_PersonalSysId);
    call DeletePersonalContactAll(In_PersonalSysId);
    call DeletePersonalAddressAll(In_PersonalSysId);
    call DeleteResStatusRecordBySysId(In_PersonalSysId);
    call DeleteHRDetails(In_PersonalSysId);
    delete from ProjContractWorker where
      ProjContractWorker.PersonalSysId = In_PersonalSysId;
    delete from InterfaceDetails where
      InterfaceDetails.PersonalSysId = In_PersonalSysId;
    delete from Attachment where
      Attachment.PersonalSysId = In_PersonalSysId;
    /*Income Tax Deletion*/
    if FGetDBCountry(*) = 'Singapore' then
      call DeleteYEEmployeeByPersonalSysID(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Indonesia' then
      call DeleteIndoTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalTaxDetails(In_PersonalSysId);
      call DeleteMalRebateGrantedByPersonalSysId(In_PersonalSysId);
      call DeleteMalRebateClaimByPersonalSysId(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Philippines' then
      call DeletePhTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Vietnam' then
      call DeleteVnTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Thailand' then
      call DeleteThTaxDetails(In_PersonalSysId)
    end if;
    /*Delete Personal*/
    delete from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmployeeRecord') then
   drop procedure DeleteEmployeeRecord
end if;

create procedure
dba.DeleteEmployeeRecord(in In_EmployeeSysId integer,in In_EmployeeId char(30))
begin
  declare Int_PersonalSysId integer;
  declare Char_EmployeeId char(30);
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeesysId) then
    select Employee.PersonalSysId into Int_PersonalSysId from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    select first EmployeeId into Char_EmployeeId from Employee where
      PersonalSysId = Int_PersonalSysId and
      EmployeesysId <> In_EmployeeSysId order by HireDate desc;
    update Personal set
      Personal.EmployeeId = Char_EmployeeId where
      Personal.PersonalSysId = Int_PersonalSysId;
    call DeleteEmpeeWkCalenEmp(In_EmployeeSysId);
    call DeletePaymentBankInfoEmp(In_EmployeeSysId);
    call DeleteLoanEmployeeEmp(In_EmployeeSysId);
    call DeleteCETmsExportEmpEmp(In_EmployeeSysId);
    call DeleteIntercorpTmsExportEmpEmp(In_EmployeeSysId);
    if FGetDBCountry(*) = 'HongKong' then
      call DeleteHKTaxDetails(In_EmployeeSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalPrevEmployerByEmployeeSysId(In_EmployeeSysId)
    end if;
    delete from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxPolicy') then
   drop procedure DeleteMalTaxPolicy
end if;

create procedure
dba.DeleteMalTaxPolicy(in In_MalTaxPolicyId char(20),out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    /*
    if exists(select* from MalTaxPolicyAssignMalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;
    if exists(select* from MalTaxPolicyBAssgn where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;*/
    DeleteRebateSetupLoop: for RebateSetupFor as RebateSetupcurs dynamic scroll cursor for
      select MalTaxPolicyProgSysId as In_MalTaxPolicyProgSysId from MalTaxPolicyProg where
        MalTaxPolicyId = In_MalTaxPolicyId do
      call DeleteMalTaxPolicyProg(In_MalTaxPolicyProgSysId) end for;
    //delete from MalTaxPolicyProg where MalTaxPolicyId = In_MalTaxPolicyId;
    delete from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId;
    commit work;
    if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxPolicyProg') then
   drop procedure DeleteMalTaxPolicyProg
end if;

create procedure
dba.DeleteMalTaxPolicyProg(in In_MalTaxPolicyProgSysId integer,out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    if exists(select* from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
      commit work
    end if;
    delete from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalMalPayPeriodTaxWage') then
   drop procedure ASQLCalMalPayPeriodTaxWage
end if;

create procedure
DBA.ASQLCalMalPayPeriodTaxWage(in In_EmployeeSysId integer,in In_PayRecYear integer,in In_PayRecPeriod integer,out Out_CurrentNonAllowance double,out Out_CurrentAllowance double,out Out_CurrentAdditional double,out Out_CurrentCompensation double,out Out_PreviousNonAllowance double,out Out_PreviousAllowance double,out Out_PreviousAdditional double,out Out_PreviousCompensation double,out Out_CurrentNonAllowanceEPF double,out Out_CurrentAllowanceEPF double,out Out_CurrentAdditionalEPF double,out Out_PreviousNonAllowanceEPF double,out Out_PreviousAllowanceEPF double,out Out_PreviousAdditionalEPF double)
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
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Current Allowance Subject to EPF          
  */
  if(Out_CurrentAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
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
    AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
    Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Previous Allowance Subject to EPF
  */
  if(Out_PreviousAllowance <> 0) then
    select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAllowanceEPF from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      (IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjEEVolEPF') = 1) and
      AllowanceFormulaId = any(select FormulaId as AllowanceFormulaId from Formula where FormulaSubCategory = 'Allowance' or FormulaSubCategory = 'Deduction') and
      Year(AllowanceDeclaredDate) = In_PayRecYear-1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
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
    PayRecPeriod = In_PayRecPeriod
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalMalPayRecTaxWage') then
   drop procedure ASQLCalMalPayRecTaxWage
end if;

create procedure
DBA.ASQLCalMalPayRecTaxWage(in In_EmployeeSysId integer,in In_PayRecYear integer,in In_PayRecPeriod integer,in In_PayRecSubPeriod integer,in In_PayRecID char(20),out Out_CurrentNonAllowance double,out Out_CurrentAllowance double,out Out_CurrentAdditional double,out Out_CurrentCompensation double,out Out_PreviousNonAllowance double,out Out_PreviousAllowance double,out Out_PreviousAdditional double,out Out_PreviousCompensation double,out Out_CurrentNonAllowanceEPF double,out Out_CurrentAllowanceEPF double,out Out_CurrentAdditionalEPF double,out Out_PreviousNonAllowanceEPF double,out Out_PreviousAllowanceEPF double,out Out_PreviousAdditionalEPF double)
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
  if(Out_CurrentAllowance <> 0) then
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
      PayRecId = In_PayRecId
  end if;
  /*
  Current Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_CurrentAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
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
  if(Out_PreviousAllowance <> 0) then
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
      PayRecId = In_PayRecId
  end if;
  /*
  Previous Additional
  */
  select FConvertNull(Sum(AllowanceAmount)) into Out_PreviousAdditional from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,'NonTaxableCode') = 0 and
    IsFormulaIdHasProperty(AllowanceFormulaId,'CompensationCode') = 0 and
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
    PayRecId = In_PayRecId
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodEPFNonAddWage') then
   drop procedure ASQLCalPayPeriodEPFNonAddWage
end if;

create procedure
DBA.ASQLCalPayPeriodEPFNonAddWage(in In_EmployeeSysId char(20),in In_PayRecYear integer,in In_PayRecPeriod integer,in In_EPFWageType char(20),out Out_EPFWage double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  declare Out_AllowanceTotal double;
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  declare Out_OTBackPayAmt double;
  declare Out_LveDeductAmt double;
  declare Out_TotalWageAmt double;
  declare Out_BackPayAmt double;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_LveDeductAmt=0;
  set Out_TotalWageAmt=0;
  set Out_BackPayAmt=0;
  set Out_EPFWage=0;
  /*
  Setting Declared Date and Property
  */
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Back Pay 
  */
  if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
    (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
    (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
    (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
    select Sum(CalBackPay) into Out_BackPayAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Property Based Items
  */
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Allowance
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      Shift Amount
      */
      select Sum(ShiftAmount) into Out_ShiftTotal from
        ShiftRecord where
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(ShiftFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
      (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  end if;
  if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
  end if;
  if Out_OTTotal is null then set Out_OTTotal=0
  end if;
  if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
  end if;
  if Out_ShiftTotal is null then set Out_ShiftTotal=0
  end if;
  set Out_EPFWage=Out_TotalWageAmt+
    Out_LveDeductAmt+
    Out_BackPayAmt+
    Out_AllowanceTotal+
    Out_OTTotal+
    Out_OTBackPayAmt+
    Out_ShiftTotal
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecEPFNonAddWage') then
   drop procedure ASQLCalPayRecEPFNonAddWage
end if;

create procedure
DBA.ASQLCalPayRecEPFNonAddWage(in In_EmployeeSysId char(20),in In_PayRecYear integer,in In_PayRecPeriod integer,in In_PayRecSubPeriod integer,in In_PayRecID char(20),in In_EPFWageType char(20),out Out_EPFWage double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  declare Out_AllowanceTotal double;
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  declare Out_OTBackPayAmt double;
  declare Out_LveDeductAmt double;
  declare Out_TotalWageAmt double;
  declare Out_BackPayAmt double;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_LveDeductAmt=0;
  set Out_TotalWageAmt=0;
  set Out_BackPayAmt=0;
  set Out_EPFWage=0;
  /*
  Setting Declared Date and Property
  */
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select CalTotalWage into Out_TotalWageAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  /*
  Back Pay 
  */
  if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
    (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
    (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
    (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
    select CalBackPay into Out_BackPayAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  /*
  Property Based Items
  */
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Allowance
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
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
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(ShiftFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
      (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  end if;
  if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
  end if;
  if Out_OTTotal is null then set Out_OTTotal=0
  end if;
  if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
  end if;
  if Out_ShiftTotal is null then set Out_ShiftTotal=0
  end if;
  set Out_EPFWage=Out_TotalWageAmt+
    Out_LveDeductAmt+
    Out_BackPayAmt+
    Out_AllowanceTotal+
    Out_OTTotal+
    Out_OTBackPayAmt+
    Out_ShiftTotal
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayRecords') then
   drop procedure ASQLDeletePayRecords
end if;

create procedure
DBA.ASQLDeletePayRecords(In_EmployeeSysId integer,In_PayRecYear integer,In_PayRecPeriod integer,In_PayRecSubPeriod integer,In_PayRecID char(20))
begin
  declare CountPayRecord integer;
  select count(*) into CountPayRecord from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  if(CountPayRecord = 1) then
    call ASQLDeleteSubPeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod);
    if(FGetDBCountry(*) = 'Malaysia') then
      delete from RebateGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
        RebatePayrollYear = In_PayRecYear and
        RebatePayrollPeriod = In_PayRecPeriod
    end if
  else
    delete from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from OTRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from ShiftRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
      select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
      if(EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID) then
        delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
        delete from AllowanceRecord where AllowanceSGSPGenId = GenId
      end if end for
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'IsMalCheckClaimRebateCap') then
   drop procedure IsMalCheckClaimRebateCap
end if
;

create function
dba.IsMalCheckClaimRebateCap(
in In_PersonalSysId integer,
in In_RebateId char(20),
in In_ProcessingDate date,
in In_ClaimAmount double)
returns smallint
// Error
// -1 - No Income Tax Policy found according to processing date
// -2 - Multiple Claim w/ duration > 1 Year 
// -3 - Only allow 1 claim in x year(s)
// Warning
// 0 - Total Claimed Amount is greater than Rebate Capping Amount.
// 1 - Pass
begin
  declare In_MalTaxPolicyEffDate date;
  declare In_RebatePaymentOption integer;
  declare In_RebateCapDuration integer;
  declare In_RebateCapAmt double;
  declare In_TotalClaimedAmt double;
  //
  // Get Personal IncomeTax Policy, look for nearest effective date using processing date
  //
  select max(MalTaxPolicyEffDate) into In_MalTaxPolicyEffDate
    from MalTaxDetails join MalTaxPolicy join MalTaxPolicyProg where PersonalSysId = In_PersonalSysId and
    MalTaxPolicyEffDate <= In_ProcessingDate;
  if In_MalTaxPolicyEffDate is null then
    return-1
  end if;
  //
  // Get RebateCapAmt,RebateCapDuration,RebatePaymentOption
  //
  select RebateCapAmt,RebateCapDuration,RebatePaymentOption into In_RebateCapAmt,
    In_RebateCapDuration,
    In_RebatePaymentOption from MalTaxDetails join MalTaxPolicy join MalTaxPolicyProg join RebateSetup where
    PersonalSysId = In_PersonalSysId and
    MalTaxPolicyEffDate = In_MalTaxPolicyEffDate and
    RebateId = In_RebateId;
  //
  // Validate
  //
  //
  // Fully Exempted
  //
  if(In_RebateCapAmt = 0) then
    return 1
  //
  // Not Fully Exempted
  //
  elseif(In_RebateCapAmt > 0) then
    //
    // Multiple claim
    //
    if(In_RebatePaymentOption = 0) then
      //
      // Duration 1 year
      //
      if(In_RebateCapDuration = 1) then
        // Get Total Claimed Amount for particular rebate id from RebateGranted table
        select SUM(RebateAmt)+In_ClaimAmount as TotalClaimedAmt into In_TotalClaimedAmt from RebateGranted where
          PersonalSysId = In_PersonalSysId and
          RebateId = In_RebateId and
          RebateDeclaredYear = DATEFORMAT(In_ProcessingDate,'yyyy')
          group by RebateId;
        // Compare with rebate capping amount
        if(In_TotalClaimedAmt > In_RebateCapAmt) then
          return 0
        else
          return 1
        end if
      else //
        //Duration not equal to 1 Year  
        //
        return-2
      end if
    //
    // 1 claim
    //
    elseif(In_RebatePaymentOption = 1) then
      //
      // No previous claim record exist
      //
      if not exists(select 1 from
          RebateClaim join RebateClaimRecord where
          PersonalSysId = In_PersonalSysId and
          RebateId = In_RebateId and
          ePortalStatus = 1) then
        // Compare with rebate capping amount
        if(In_ClaimAmount > In_RebateCapAmt) then
          return 0
        else
          return 1
        end if
      else //
        // Previous claim record exist
        //
        //
        //  Previous claim record not exist within the duration
        //
        if not exists(select 1 from
            RebateClaim join RebateClaimRecord where
            PersonalSysId = In_PersonalSysId and
            RebateId = In_RebateId and
            ePortalStatus = 1 and
            RebateDate between dateadd(year,-3,In_ProcessingDate)+1 and dateadd(year,3,In_ProcessingDate)-1) then
          if(In_ClaimAmount > In_RebateCapAmt) then
            return 0
          else
            return 1
          end if
        else
          //
          //  Previous claim record exist within the duration
          //
          return-3
        end if
      end if
    end if
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxPolicy') then
   drop procedure DeleteMalTaxPolicy
end if
;

create procedure
dba.DeleteMalTaxPolicy(
in In_MalTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    /*
    if exists(select* from MalTaxPolicyAssignMalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;
    if exists(select* from MalTaxPolicyBAssgn where MalTaxPolicyId = In_MalTaxPolicyId) then
    set Out_ErrorCode=-1;
    return
    end if;*/
    DeleteRebateSetupLoop: for RebateSetupFor as RebateSetupcurs dynamic scroll cursor for
      select MalTaxPolicyProgSysId as In_MalTaxPolicyProgSysId from MalTaxPolicyProg where
        MalTaxPolicyId = In_MalTaxPolicyId do
      message '1' type info to console;
      call DeleteMalTaxPolicyProg(In_MalTaxPolicyProgSysId) end for;
    //delete from MalTaxPolicyProg where MalTaxPolicyId = In_MalTaxPolicyId;
    delete from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId;
    commit work;
    if exists(select* from MalTaxPolicy where MalTaxPolicyId = In_MalTaxPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxPolicyProg') then
   drop procedure DeleteMalTaxPolicyProg
end if
;

create procedure
dba.DeleteMalTaxPolicyProg(
in In_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    if exists(select* from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
      commit work
    end if;
    delete from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

//
// CP38 Changes
//
if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPCBTax') then
   drop procedure FGetPeriodPCBTax
end if;

create function
DBA.FGetPeriodPCBTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Tax double;
  select Sum(PaidCurrentTaxAmt+TotalSINDA+PaidPreviousTaxAmt) into Out_Tax
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_Tax)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalPCBTax') then
   drop procedure FGetPeriodTotalPCBTax
end if;

create function
DBA.FGetPeriodTotalPCBTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare Out_Tax double;
  select Sum(PaidCurrentTaxAmt+TotalSINDA+PaidPreviousTaxAmt) into Out_Tax
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_Tax)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodCP38Tax') then
   drop procedure FGetPeriodCP38Tax
end if;

create function
DBA.FGetPeriodCP38Tax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Tax double;
  select Sum(TotalEUCF) into Out_Tax
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_Tax)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodTotalCP38Tax') then
   drop procedure FGetPeriodTotalCP38Tax
end if;

create function
DBA.FGetPeriodTotalCP38Tax(
in In_EmployeeSysId integer,
in In_PayRecYear integer)
returns double
begin
  declare Out_Tax double;
  select Sum(TotalEUCF) into Out_Tax
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_Tax)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxCP38ReceiptDate') then
   drop procedure FGetMalTaxCP38ReceiptDate
end if;

create function
DBA.FGetMalTaxCP38ReceiptDate(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(20)
begin
  declare Out_ReceiptDate char(20);
  select MalTaxCP38ReceiptDate into Out_ReceiptDate
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptDate)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxCP38ReceiptNo') then
   drop procedure FGetMalTaxCP38ReceiptNo
end if;

create function
DBA.FGetMalTaxCP38ReceiptNo(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(30)
begin
  declare Out_ReceiptNo char(30);
  select MalTaxCP38ReceiptNo into Out_ReceiptNo
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptNo)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxPrevYearReceiptDate') then
   drop procedure FGetMalTaxPrevYearReceiptDate
end if;

create function
DBA.FGetMalTaxPrevYearReceiptDate(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(20)
begin
  declare Out_ReceiptDate char(20);
  select MalTaxPrevYearReceiptDate into Out_ReceiptDate
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptDate)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxPrevYearReceiptNo') then
   drop procedure FGetMalTaxPrevYearReceiptNo
end if;

create function
DBA.FGetMalTaxPrevYearReceiptNo(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(30)
begin
  declare Out_ReceiptNo char(30);
  select MalTaxPrevYearReceiptNo into Out_ReceiptNo
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_ReceiptNo)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxPrevYearIncomeType') then
   drop procedure FGetMalTaxPrevYearIncomeType
end if;

create function
DBA.FGetMalTaxPrevYearIncomeType(
in In_EmployerID char(20),
in In_ReceiptYear integer,
in In_ReceiptPeriod char(20))
returns char(30)
begin
  declare Out_IncomeType char(30);
  select MalTaxPrevYearIncomeType into Out_IncomeType
    from MalTaxReceipt where MalTaxReceiptYear = In_ReceiptYear and
    MalTaxMonth = In_ReceiptPeriod and
    MalTaxEmployerId = In_EmployerID;
  return(Out_IncomeType)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxPrevYearDeclaredDate') then
   drop procedure FGetMalTaxPrevYearDeclaredDate
end if;

create function
DBA.FGetMalTaxPrevYearDeclaredDate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod int)
returns date
begin
  declare Out_Date Date;
  select max(AllowanceDeclaredDate) into Out_Date
    from AllowanceRecord where EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    datepart(year, AllowanceDeclaredDate) < In_PayRecYear;
  return(Out_Date)
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodPrevYearPCBTax') then
   drop procedure FGetPeriodPrevYearPCBTax
end if;

create function
DBA.FGetPeriodPrevYearPCBTax(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Tax double;
  select Sum(PaidPreviousTaxAmt) into Out_Tax
    from PeriodPolicySummary where PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
  return(Out_Tax)
end
;
