
create procedure DBA.ASQLCalPayPeriodTAPWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_TAPType integer,
out Out_TAPWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare In_SubjTAP char(20);
  declare In_TAPWage char(20);
  set Out_TAPWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  case In_TAPType when 1 then
    set In_SubjTAP='SubjTAP1';
    set In_TAPWage='TAP1Wage' when 2 then
    set In_SubjTAP='SubjTAP2';
    set In_TAPWage='TAP2Wage' when 3 then
    set In_SubjTAP='SubjTAP3';
    set In_TAPWage='TAP3Wage'
  end case
  ;
  if(IsWageElementInUsed(In_SubjTAP,In_TAPWage) = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjTAP) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,In_SubjTAP) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,In_SubjTAP) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,In_SubjTAP) = 1 and
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
    set Out_TAPWage=Out_TAPWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt',In_TAPWage) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_TAPWage=Out_TAPWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay',In_TAPWage) = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_TAPWage=Out_TAPWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage',In_TAPWage) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_TAPWage=Out_TAPWage+Out_TotalWageAmt
  end if
end
;


create procedure DBA.ASQLCalPayRecTAPWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_TAPType integer,
out Out_TAPWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare In_SubjTAP char(20);
  declare In_TAPWage char(20);
  set Out_TAPWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  case In_TAPType when 1 then
    set In_SubjTAP='SubjTAP1';
    set In_TAPWage='TAP1Wage' when 2 then
    set In_SubjTAP='SubjTAP2';
    set In_TAPWage='TAP2Wage' when 3 then
    set In_SubjTAP='SubjTAP3';
    set In_TAPWage='TAP3Wage'
  end case
  ;
  if(IsWageElementInUsed(In_SubjTAP,In_TAPWage) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjTAP) = 1 and
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
      IsFormulaIdHasProperty(OTFormulaId,In_SubjTAP) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,In_SubjTAP) = 1 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,In_SubjTAP) = 1 and
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
    set Out_TAPWage=Out_TAPWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_TAPWage) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_TAPWage=Out_TAPWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',In_TAPWage) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_TAPWage=Out_TAPWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_TAPWage) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_TAPWage=Out_TAPWage+Out_TotalWageAmt
  end if
end
;


create function DBA.FGetBruneiEmpTAPACC(
in In_EmployeeSysId integer,
in In_TAPScheme char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Out_TAPAccountNo char(20);
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
  select first CPFProgAccountNo into Out_TAPAccountNo
    from CPFProgression where
    EmployeeSysId = In_EmployeeSysId and
    CPFProgSchemeId = In_TAPScheme and
    CPFEffectiveDate <= Out_Date order by
    CPFEffectivedate desc;
  return(Out_TAPAccountNo)
end
;



create function DBA.FGetBruneiPaymentMode(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
returns char(20)
begin
  declare Out_PaymentMode char(20);
  declare Out_Count integer;
  declare Out_PaymentCategory char(20);
  set Out_PaymentMode='';
  if(In_PayRecSubPeriod <> 0) then
    if exists(select* from Bankrecord join PaymentBankInfo on
        (Bankrecord.PaymentBankCode = PaymentBankInfo.BankId and
        BankRecord.PaymentBankBrCode = PaymentBankInfo.BankBranchId and
        PaymentBankInfo.EmployeeSysId = BankRecord.EmployeeSysId) where Bankrecord.employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod = In_PayRecSubPeriod and
        PaymentCategory = 'ByBank' and(PaymentMode = '' or PaymentMode is null)) then
      set Out_PaymentMode=Out_PaymentMode+'B,'
    end if;
    if exists(select* from Bankrecord join PaymentBankInfo on
        (Bankrecord.PaymentBankCode = PaymentBankInfo.BankId and
        BankRecord.PaymentBankBrCode = PaymentBankInfo.BankBranchId and
        PaymentBankInfo.EmployeeSysId = BankRecord.EmployeeSysId) where Bankrecord.employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod = In_PayRecSubPeriod and
        PaymentCategory = 'ByBank' and PaymentMode = 'Telegraphic') then
      set Out_PaymentMode=Out_PaymentMode+'T,'
    end if;
    if exists(select* from BankRecord where employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod = In_PayRecSubPeriod and
        (PaymentCategory = 'ByCash' or PaymentCategory = 'ByCheque')) then
      set Out_PaymentMode=Out_PaymentMode+'C,'
    end if
  else
    if exists(select* from Bankrecord join PaymentBankInfo on
        (Bankrecord.PaymentBankCode = PaymentBankInfo.BankId and
        BankRecord.PaymentBankBrCode = PaymentBankInfo.BankBranchId and
        PaymentBankInfo.EmployeeSysId = BankRecord.EmployeeSysId) where Bankrecord.employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and
        PaymentCategory = 'ByBank' and(PaymentMode = '' or PaymentMode is null)) then
      set Out_PaymentMode=Out_PaymentMode+'B,'
    end if;
    if exists(select* from Bankrecord join PaymentBankInfo on
        (Bankrecord.PaymentBankCode = PaymentBankInfo.BankId and
        BankRecord.PaymentBankBrCode = PaymentBankInfo.BankBranchId and
        PaymentBankInfo.EmployeeSysId = BankRecord.EmployeeSysId) where Bankrecord.employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and
        PaymentCategory = 'ByBank' and PaymentMode = 'Telegraphic') then
      set Out_PaymentMode=Out_PaymentMode+'T,'
    end if;
    if exists(select PaymentCategory into Out_PaymentCategory from BankRecord where Bankrecord.employeesysid = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod and
        (PaymentCategory = 'ByCash' or PaymentCategory = 'ByCheque')) then
      set Out_PaymentMode=Out_PaymentMode+'C,'
    end if
  end if;
  set Out_PaymentMode=SUBSTRING(Out_PaymentMode,1,Length(Out_PaymentMode)-1);
  return(Out_PaymentMode)
end
;


create function dba.FGetBruneiCPFFormula(
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
  if(OrdFormulaType = 'T1') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,2))+'% of the employee''s '+OrdK1+' for the month'
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc+' and ';
    select FDecodeFormula(In_AddFormulaId) into Out_AddDesc
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

