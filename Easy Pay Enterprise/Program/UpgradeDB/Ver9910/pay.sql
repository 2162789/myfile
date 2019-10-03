create procedure DBA.ASQLBRProgCurrentUpdate(
in In_EmployeeSysId integer,
in In_BRProgPayGroup char(20),
in In_BRProgBasicRateType char(20))
begin
  call DeletePayAllocation(In_EmployeeSysId);
  DefaultPayAllocLoop: for DefPayAllocFor as Cur_DefaultPayAllocationSubPeriod dynamic scroll cursor for
    select DefaultPayAllocation.DefaultPayAllocSubPeriod as PayAllocSubPeriod,
      DefaultPayAllocation.DefaultPayAllocValue as PayAllocVal,
      DefaultPayAllocation.DefaultPayAllocTypeId as PayAllocTypeId from
      DefaultPayAllocation where
      DefaultPayAllocation.PayGroupId = In_BRProgPayGroup and
      DefaultPayAllocation.DefaultPayBasicRateType = In_BRProgBasicRateType do
    call InsertNewPayAllocation(In_EmployeeSysId,PayAllocSubPeriod,PayAllocVal,PayAllocTypeId);
    commit work end for;
  call DeleteCPFPayment(In_EmployeeSysId);
  DefaultCPFPaymentLoop: for DefCPFPaymentFor as Cur_DefaultCPFPaymentSubPeriod dynamic scroll cursor for
    select DefaultCPFPayment.DefaultCPFPaymentSubPeriod as CPFPaymentSubPeriod,
      DefaultCPFPayment.CPFPaymentOption as CPFPaymentOpt,
      DefaultCPFPayment.PayGroupId as CPFPaymentPayGroupId from
      DefaultCPFPayment where
      DefaultCPFPayment.PayGroupId = In_BRProgPayGroup do
    call InsertNewCPFPayment(In_EmployeeSysId,CPFPaymentSubPeriod,CPFPaymentOpt);
    commit work end for
end
;

create procedure dba.ASQLCalCurrentPayPeriod(
in In_PayGroupId char(20),
out Out_CurrentYear integer,
out Out_CurrentPeriod integer,
out Out_CurrentSubPeriod integer)
begin
  declare Out_NoSubPeriod integer;
  declare Out_PeriodStartYear integer;
  select NoSubPeriod into Out_NoSubPeriod from PayGroup where PayGroupId = In_PayGroupId;
  select PeriodStartYear into Out_PeriodStartYear from PayGroup where PayGroupId = In_PayGroupId;
  select max(PayGroupYear) into Out_CurrentYear from PayGroupPeriod where PayGroupId = In_PayGroupId;
  if(Out_CurrentYear is null) then
    set Out_CurrentYear=0;
    set Out_CurrentPeriod=0;
    set Out_CurrentSubPeriod=0
  else
    select max(PayGroupPeriod) into Out_CurrentPeriod from PayGroupPeriod where
      PayGroupId = In_PayGroupId and
      PayGroupYear = Out_CurrentYear;
    select max(PayGroupSubPeriod) into Out_CurrentSubPeriod from PayGroupPeriod where
      PayGroupId = In_PayGroupId and
      PayGroupYear = Out_CurrentYear and
      PayGroupPeriod = Out_CurrentPeriod
  end if
end
;

create procedure dba.ASQLCalNextPayPeriod(
in In_PayGroupId char(20),
out Out_NextYear integer,
out Out_NextPeriod integer,
out Out_NextSubPeriod integer)
begin
  declare Out_NoSubPeriod integer;
  declare Out_PeriodStartYear integer;
  select NoSubPeriod into Out_NoSubPeriod from PayGroup where PayGroupId = In_PayGroupId;
  select PeriodStartYear into Out_PeriodStartYear from PayGroup where PayGroupId = In_PayGroupId;
  select max(PayGroupYear) into Out_NextYear from PayGroupPeriod where PayGroupId = In_PayGroupId;
  select max(PayGroupPeriod) into Out_NextPeriod from PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = Out_NextYear;
  select max(PayGroupSubPeriod) into Out_NextSubPeriod from PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = Out_NextYear and
    PayGroupPeriod = Out_NextPeriod;
  if(Out_NextYear is null or Out_NextPeriod is null or Out_NextSubPeriod is null) then
    set Out_NextYear=Out_PeriodStartYear;
    set Out_NextPeriod=1;
    set Out_NextSubPeriod=1
  else
    set Out_NextSubPeriod=Out_NextSubPeriod+1;
    if(Out_NextSubPeriod > Out_NoSubPeriod) then
      set Out_NextSubPeriod=1;
      set Out_NextPeriod=Out_NextPeriod+1
    end if;
    if(Out_NextPeriod > 12) then
      set Out_NextPeriod=1;
      set Out_NextYear=Out_NextYear+1
    end if
  end if
end
;

create procedure DBA.ASQLCalPayPeriodBalCPF(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_ContriOrdEECPF double,
out Out_ContriAddEECPF double,
out Out_ContriOrdERCPF double,
out Out_ContriAddERCPF double)
begin
  declare Tmp_ContriOrdEECPF double;
  declare Tmp_ContriAddEECPF double;
  declare Tmp_ContriOrdERCPF double;
  declare Tmp_ContriAddERCPF double;
  select sum(ContriOrdEECPF),sum(ContriAddEECPF),Sum(ContriOrdERCPF),sum(ContriAddERCPF) into Out_ContriOrdEECPF,
    Out_ContriAddEECPF,Out_ContriOrdERCPF,
    Out_ContriAddERCPF from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  if Out_ContriOrdEECPF is null then set Out_ContriOrdEECPF=0
  end if;
  if Out_ContriAddEECPF is null then set Out_ContriAddEECPF=0
  end if;
  if Out_ContriOrdERCPF is null then set Out_ContriOrdERCPF=0
  end if;
  if Out_ContriAddERCPF is null then set Out_ContriAddERCPF=0
  end if;
  /*
  Get the specified Record
  */
  select sum(ContriOrdEECPF),sum(ContriAddEECPF),Sum(ContriOrdERCPF),sum(ContriAddERCPF) into Tmp_ContriOrdEECPF,
    Tmp_ContriAddEECPF,Tmp_ContriOrdERCPF,
    Tmp_ContriAddERCPF from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Deduct away from the specified
  */
  set Out_ContriOrdEECPF=Out_ContriOrdEECPF-Tmp_ContriOrdEECPF;
  set Out_ContriAddEECPF=Out_ContriAddEECPF-Tmp_ContriAddEECPF;
  set Out_ContriOrdERCPF=Out_ContriOrdERCPF-Tmp_ContriOrdERCPF;
  set Out_ContriAddERCPF=Out_ContriAddERCPF-Tmp_ContriAddERCPF
end
;

create procedure DBA.ASQLCalPayPeriodCPF(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
out Out_ContriOrdEECPF double,
out Out_ContriAddEECPF double,
out Out_ContriOrdERCPF double,
out Out_ContriAddERCPF double)
begin
  select sum(ContriOrdEECPF),sum(ContriAddEECPF),Sum(ContriOrdERCPF),sum(ContriAddERCPF) into Out_ContriOrdEECPF,
    Out_ContriAddEECPF,Out_ContriOrdERCPF,
    Out_ContriAddERCPF from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod < In_PayRecSubPeriod;
  if Out_ContriOrdEECPF is null then set Out_ContriOrdEECPF=0
  end if;
  if Out_ContriAddEECPF is null then set Out_ContriAddEECPF=0
  end if;
  if Out_ContriOrdERCPF is null then set Out_ContriOrdERCPF=0
  end if;
  if Out_ContriAddERCPF is null then set Out_ContriAddERCPF=0
  end if end
;

create procedure DBA.ASQLCalPayPeriodCPFWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurOrdinaryWage double,
out Out_CurAdditionalWage double,
out Out_PrevOrdinaryWage double,
out Out_PrevAdditionalWage double,
out Out_CPFWage double)
begin
  select sum(CurOrdinaryWage),sum(CurAdditionalWage),Sum(PrevOrdinaryWage),sum(PrevAdditionalWage),sum(CPFWage) into Out_CurOrdinaryWage,
    Out_CurAdditionalWage,Out_PrevOrdinaryWage,Out_PrevAdditionalWage,
    Out_CPFWage from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod
end
;

create procedure DBA.ASQLCalPayPeriodCurAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurAddWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurAddWage=Out_CurAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','AddWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurAddWage=Out_CurAddWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','AddWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurAddWage=Out_CurAddWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','AddWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurAddWage=Out_CurAddWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayPeriodCurOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurOrdWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurOrdWage=Out_CurOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','OrdWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurOrdWage=Out_CurOrdWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','OrdWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurOrdWage=Out_CurOrdWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','OrdWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_CurOrdWage=Out_CurOrdWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayPeriodPrevAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_PrevAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_PrevAddWage=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevAddWage=Out_PrevAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end
;

create procedure DBA.ASQLCalPayPeriodPrevOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_PrevOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_PrevOrdWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevOrdWage=Out_PrevOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end
;

create procedure DBA.ASQLCalPayPeriodSDFWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_SDFWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPay double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_NSPay double)
begin
  declare SubjProperty char(20);
  declare WageProperty char(20);
  set Out_SDFWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_OTBackPay=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_NSPay=0;
  if FGetDBCountry(*) = 'Malaysia' then
    set SubjProperty='SubjHRDLevy';
    set WageProperty='HRDLWage'
  else
    set SubjProperty='SubjSDF';
    set WageProperty='SDFWage'
  end if;
  if(IsWageElementInUsed(SubjProperty,WageProperty) = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    select Sum(ShiftAmount) into Out_ShiftTotal from ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    select Sum(CurrentOTAmount+LastOTAmount),Sum(BackPayOTAmount) into Out_OTTotal,Out_OTBackPay from OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set Out_SDFWage=Out_SDFWage+Out_OTTotal+Out_OTBackPay+Out_ShiftTotal+Out_AllowanceTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SDFWage=Out_SDFWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SDFWage=Out_SDFWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_SDFWage=Out_SDFWage+Out_TotalWageAmt
  end if;
  if(IsWageElementInUsed('NSPay',WageProperty) = 1) then
    select Sum(AllowanceAmount) into Out_NSPay from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'NSCode') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_NSPay is null then set Out_NSPay=0
    end if;
    set Out_SDFWage=Out_SDFWage+Out_NSPay
  end if
end
;

create procedure DBA.ASQLCalPayRecCurAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,in In_PayRecID char(20),out Out_CurAddWage double,out Out_AllowanceTotal double,out Out_OTTotal double,out Out_ShiftTotal double,out Out_LveDeductAmt double,out Out_BackPayAmt double,out Out_TotalWageAmt double,out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurAddWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurAddWage=Out_CurAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','AddWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','AddWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','AddWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecCurOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_CurOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurOrdWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurOrdWage=Out_CurOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','OrdWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','OrdWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','OrdWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_TotalWageAmt
  end if
end
;

create procedure dba.ASQLCalPayRecGrossWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LeaveDeductAmt double,
out Out_BackPay double,
out Out_TotalWage double,
out Out_NonCPFAllowance double,
out Out_CPFAllowance double,
out Out_NonCPFDeduction double,
out Out_CPFDeduction double,
out Out_AllAllowance double,
out Out_AllDeduction double)
begin
  declare GrossWage double;
  set GrossWage=0;
  set Out_OTAmount=0;
  set Out_OTBackPay=0;
  set Out_ShiftAmount=0;
  set Out_LeaveDeductAmt=0;
  set Out_BackPay=0;
  set Out_TotalWage=0;
  set Out_NonCPFAllowance=0;
  set Out_CPFAllowance=0;
  set Out_NonCPFDeduction=0;
  set Out_CPFDeduction=0;
  set Out_AllAllowance=0;
  set Out_AllDeduction=0;
  if(IsWageElementInUsed('OTAmount','GrossWage') = 1) then
    select CalOTAmount into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set GrossWage=GrossWage+Out_OTAmount
  end if;
  if(IsWageElementInUsed('OTBackPay','GrossWage') = 1) then
    select CalOTBackPay into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set GrossWage=GrossWage+Out_OTBackPay
  end if;
  if(IsWageElementInUsed('ShiftAmount','GrossWage') = 1) then
    select CalShiftAmount into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set GrossWage=GrossWage+Out_ShiftAmount
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','GrossWage') = 1) then
    select CalLveDeductAmt into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set GrossWage=GrossWage+Out_LeaveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','GrossWage') = 1) then
    select CalBackPay into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set GrossWage=GrossWage+Out_BackPay
  end if;
  if(IsWageElementInUsed('TotalWage','GrossWage') = 1) then
    select CalTotalWage into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set GrossWage=GrossWage+Out_TotalWage
  end if;
  if(IsWageElementInUsed('AllAllowance','GrossWage') = 1) then
    select FGetPayRecAllAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllAllowance;
    set GrossWage=GrossWage+Out_AllAllowance
  end if;
  if(IsWageElementInUsed('AllDeduction','GrossWage') = 1) then
    select FGetPayRecAllDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllDeduction;
    set GrossWage=GrossWage+Out_AllDeduction
  end if;
  if(IsWageElementInUsed('NonCPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonMPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonContriAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonTAPAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonEPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonJamsoAllowance','GrossWage') = 1 or
    IsWageElementInUsed('NonPFSSAllowance','GrossWage') = 1) then
    select FGetPayRecNonCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFAllowance;
    set GrossWage=GrossWage+Out_NonCPFAllowance
  end if;
  if(IsWageElementInUsed('CPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('MPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('ManContriAllowance','GrossWage') = 1 or
    IsWageElementInUsed('TAPAllowance','GrossWage') = 1 or
    IsWageElementInUsed('EPFAllowance','GrossWage') = 1 or
    IsWageElementInUsed('JamsoAllowance','GrossWage') = 1 or
    IsWageElementInUsed('PFSSAllowance','GrossWage') = 1) then
    select FGetPayRecCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFAllowance;
    set GrossWage=GrossWage+Out_CPFAllowance
  end if;
  if(IsWageElementInUsed('NonCPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonMPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonContriDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonTAPDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonEPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonJamsoDeduction','GrossWage') = 1 or
    IsWageElementInUsed('NonPFSSDeduction','GrossWage') = 1) then
    select FGetPayRecNonCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFDeduction;
    set GrossWage=GrossWage+Out_NonCPFDeduction
  end if;
  if(IsWageElementInUsed('CPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('MPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('ManContriDeduction','GrossWage') = 1 or
    IsWageElementInUsed('TAPDeduction','GrossWage') = 1 or
    IsWageElementInUsed('EPFDeduction','GrossWage') = 1 or
    IsWageElementInUsed('JamsoDeduction','GrossWage') = 1 or
    IsWageElementInUsed('PFSSDeduction','GrossWage') = 1) then
    select FGetPayRecCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFDeduction;
    set GrossWage=GrossWage+Out_CPFDeduction
  end if;
  set GrossWage=Round(GrossWage,FGetDBPayDecimal(*));
  update detailrecord set
    CalGrossWage = GrossWage where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  commit work
end
;

create procedure dba.ASQLCalPayRecNetWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_NetWageExRate double,
in In_NetWageExRateId char(20))
begin
  declare In_NetWage double;
  declare In_CalTotalWage double;
  declare In_CalOTAmount double;
  declare In_CalOTBackPay double;
  declare In_CalShiftAmount double;
  declare In_CalLveDeductAmt double;
  declare In_CalBackPay double;
  declare In_TotalContriEECPF double;
  declare In_TaxAmt double;
  declare In_TaxMethod char(20);
  declare In_ECOLA double;
  declare In_NetWageContriDiff double;
  declare In_NetWageP double;
  /*
  Set initial Tax Amount
  */
  set In_TaxAmt=0;
  set In_TotalContriEECPF=0;
  select CalTotalWage into In_CalTotalWage
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalOTAmount into In_CalOTAmount
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalOTBackPay into In_CalOTBackPay
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalShiftAmount into In_CalShiftAmount
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalLveDeductAmt into In_CalLveDeductAmt from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalBackPay into In_CalBackPay from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Brunei consider EE TAP 1,2 and 3
  */
  if(FGetDBCountry(*) = 'Brunei') then
    select TotalContriEECPF+ContriOrdEECPF+ContriAddEECPF into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Indonesia consider EE Jamsostek & Tax Amt (For Gross To Net)
  */
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select ContriOrdEECPF into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Check for Gross To Net    
    */
    select IndoTaxMethod into In_TaxMethod from IndoTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'GrossToNet') then
      select CurAdditionalWage into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  /*
  Malaysia consider EPF, SOCSO & Tax Amt
  */
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri+PrevEEManContri+PrevEEVolContri into In_TotalContriEECPF
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Check for Employee Pay Tax
    */
    select MalTaxMethod into In_TaxMethod from MalTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'EEPayTax') then
      select PaidCurrentTaxAmt+PaidPreviousTaxAmt into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  /*
  Singapore consider CPF
  */
  elseif(FGetDBCountry(*) = 'Singapore') then
    select TotalContriEECPF into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Philippines consider PHIC / HDMF / SSS / ECOLA / Tax
  */
  elseif(FGetDBCountry(*) = 'Philippines') then
    select ContriOrdEECPF+ContriAddEECPF+CurrEEManContri into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select ContriSDF into In_ECOLA from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set In_TotalContriEECPF=In_TotalContriEECPF-In_ECOLA;
    /*
    Check for Employee Pay Tax
    */
    select PhTaxMethod into In_TaxMethod from PhTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'EEPayTax') then
      select PaidCurrentTaxAmt into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  /*
  Vietnam consider HI / SI / Tax
  */
  elseif(FGetDBCountry(*) = 'Vietnam') then
    select CurrEEVolContri+PrevEEVolContri+CurrEEVolWage+PrevEEVolWage+ContriAddEECPF,PreviousTaxAmount+CurNWCHrDaysRate into In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Hongkong consider MPF
  */
  elseif(FGetDBCountry(*) = 'HongKong') then
    select PrevEEVolContri+PrevEEManContri into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Thailand consider PF / Tax
  */
  elseif(FGetDBCountry(*) = 'Thailand') then
    select ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+CurrEEManWage+PrevEEManWage,PaidCurrentTaxAmt into In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  set In_NetWage
    =In_CalTotalWage+
    In_CalOTAmount+
    In_CalOTBackPay+
    In_CalShiftAmount+
    In_CalBackPay+
    FGetPayRecAllPayElement(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID)+
    In_CalLveDeductAmt-
    In_TotalContriEECPF-
    In_TaxAmt;
  set In_NetWage=Round(In_NetWage,FGetDBPayDecimal(*));
  set In_NetWageP=Round(In_NetWage*In_NetWageExRate,FGetDBPayDecimal(*));
  update DetailRecord set
    CalNetWage = In_NetWage,
    NetWageP = In_NetWageP,
    NetWageExRate = In_NetWageExRate,
    NetWageExRateId = In_NetWageExRateId where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  commit work
end
;

create procedure DBA.ASQLCalPayRecPrevAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PrevAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_PrevAddWage=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevAddWage=Out_PrevAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end
;

create procedure DBA.ASQLCalPayRecPrevOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PrevOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_PrevOrdWage=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevOrdWage=Out_PrevOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end
;

create procedure dba.ASQLCalPayRecTotalGrossWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LeaveDeductAmt double,
out Out_BackPay double,
out Out_TotalWage double,
out Out_NonCPFAllowance double,
out Out_CPFAllowance double,
out Out_NonCPFDeduction double,
out Out_CPFDeduction double,
out Out_AllAllowance double,
out Out_AllDeduction double,
out Out_Reimbursement double)
begin
  declare TotalGrossWage double;
  set TotalGrossWage=0;
  set Out_OTAmount=0;
  set Out_OTBackPay=0;
  set Out_ShiftAmount=0;
  set Out_LeaveDeductAmt=0;
  set Out_BackPay=0;
  set Out_TotalWage=0;
  set Out_NonCPFAllowance=0;
  set Out_CPFAllowance=0;
  set Out_NonCPFDeduction=0;
  set Out_CPFDeduction=0;
  set Out_AllAllowance=0;
  set Out_AllDeduction=0;
  set Out_Reimbursement=0;
  if(IsWageElementInUsed('OTAmount','TotalGrossWage') = 1) then
    select CalOTAmount into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_OTAmount
  end if;
  if(IsWageElementInUsed('OTBackPay','TotalGrossWage') = 1) then
    select CalOTBackPay into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_OTBackPay
  end if;
  if(IsWageElementInUsed('ShiftAmount','TotalGrossWage') = 1) then
    select CalShiftAmount into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_ShiftAmount
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','TotalGrossWage') = 1) then
    select CalLveDeductAmt into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_LeaveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','TotalGrossWage') = 1) then
    select CalBackPay into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_BackPay
  end if;
  if(IsWageElementInUsed('TotalWage','TotalGrossWage') = 1) then
    select CalTotalWage into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set TotalGrossWage=TotalGrossWage+Out_TotalWage
  end if;
  if(IsWageElementInUsed('NonCPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonMPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonContriAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonTAPAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonEPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonJamsoAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonPFSSAllowance','TotalGrossWage') = 1) then
    select FGetPayRecNonCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFAllowance;
    set TotalGrossWage=TotalGrossWage+Out_NonCPFAllowance
  end if;
  if(IsWageElementInUsed('CPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('MPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('ManContriAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('TAPAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('EPFAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('JamsoAllowance','TotalGrossWage') = 1 or
    IsWageElementInUsed('PFSSAllowance','TotalGrossWage') = 1) then
    select FGetPayRecCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFAllowance;
    set TotalGrossWage=TotalGrossWage+Out_CPFAllowance
  end if;
  if(IsWageElementInUsed('NonCPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonMPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonContriDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonTAPDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonEPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonJamsoDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('NonPFSSDeduction','TotalGrossWage') = 1) then
    select FGetPayRecNonCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFDeduction;
    set TotalGrossWage=TotalGrossWage+Out_NonCPFDeduction
  end if;
  if(IsWageElementInUsed('CPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('MPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('ManContriDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('TAPDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('EPFDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('JamsoDeduction','TotalGrossWage') = 1 or
    IsWageElementInUsed('PFSSDeduction','TotalGrossWage') = 1) then
    select FGetPayRecCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFDeduction;
    set TotalGrossWage=TotalGrossWage+Out_CPFDeduction
  end if;
  if(IsWageElementInUsed('AllAllowance','TotalGrossWage') = 1) then
    select FGetPayRecAllAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllAllowance;
    set TotalGrossWage=TotalGrossWage+Out_AllAllowance
  end if;
  if(IsWageElementInUsed('AllDeduction','TotalGrossWage') = 1) then
    select FGetPayRecAllDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllDeduction;
    set TotalGrossWage=TotalGrossWage+Out_AllDeduction
  end if;
  if(IsWageElementInUsed('Reimbursement','TotalGrossWage') = 1) then
    select FGetPayRecAllReimbursement(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_Reimbursement;
    set TotalGrossWage=TotalGrossWage+Out_Reimbursement
  end if;
  set TotalGrossWage=Round(TotalGrossWage,FGetDBPayDecimal(*));
  update detailrecord set
    CalTotalGrossWage = TotalGrossWage where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  commit work
end
;

create procedure DBA.ASQLClearBankRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  delete from BankRecord where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecId and
    EmployeeSysId = In_EmployeeSysId and
    PaymentAmt = 0;
  commit work
end
;

create procedure DBA.ASQLClearBonusReport(
in In_BonusReportId char(20))
begin
  delete from BonusReport where
    BonusReportId = In_BonusReportId;
  commit work
end
;

create procedure dba.ASQLCloneCPFFormulaRecord(
in In_FormulaId char(20),
in In_FromFormulaId char(20))
begin
  declare In_FormulaActive integer;
  declare In_FormulaPreprocess integer;
  declare In_FormulaRecurring integer;
  declare In_FormulaCategory char(20);
  declare In_FormulaSubCategory char(20);
  declare In_FormulaType char(20);
  declare In_FormulaRangeBasis char(20);
  declare In_FormulaDesc char(255);
  declare In_Maximum double;
  declare In_Minimum double;
  declare In_Formula char(255);
  declare In_Constant1 double;
  declare In_Constant2 double;
  declare In_Constant3 double;
  declare In_Constant4 double;
  declare In_Constant5 double;
  declare In_Keywords1 char(20);
  declare In_Keywords2 char(20);
  declare In_Keywords3 char(20);
  declare In_Keywords4 char(20);
  declare In_Keywords5 char(20);
  declare In_Keywords6 char(20);
  declare In_Keywords7 char(20);
  declare In_Keywords8 char(20);
  declare In_Keywords9 char(20);
  declare In_Keywords10 char(20);
  declare In_UserDef1 char(20);
  declare In_UserDef2 char(20);
  declare In_UserDef3 char(20);
  declare In_UserDef4 char(20);
  declare In_UserDef5 char(20);
  declare In_F1 char(20);
  declare In_F2 char(20);
  declare In_F3 char(20);
  declare In_F4 char(20);
  declare In_F5 char(20);
  declare In_F6 char(20);
  declare In_F7 char(20);
  declare In_F8 char(20);
  declare In_F9 char(20);
  declare In_F10 char(20);
  declare In_P1 char(20);
  declare In_P2 char(20);
  declare In_P3 char(20);
  declare In_P4 char(20);
  declare In_P5 char(20);
  declare In_P6 char(20);
  declare In_P7 char(20);
  declare In_P8 char(20);
  declare In_P9 char(20);
  declare In_P10 char(20);
  /*
  Create Formula Record
  */
  select FormulaActive,
    FormulaPreprocess,
    FormulaRecurring,
    FormulaCategory,
    FormulaSubCategory,
    FormulaType,
    FormulaRangeBasis,
    FormulaDesc into In_FormulaActive,
    In_FormulaPreprocess,
    In_FormulaRecurring,
    In_FormulaCategory,
    In_FormulaSubCategory,
    In_FormulaType,
    In_FormulaRangeBasis,
    In_FormulaDesc from Formula where
    FormulaId = In_FromFormulaId;
  call InsertNewFormula(In_FormulaId,
  In_FormulaActive,
  In_FormulaPreprocess,
  In_FormulaRecurring,
  In_FormulaCategory,
  In_FormulaSubCategory,
  In_FormulaType,
  In_FormulaRangeBasis,
  In_FormulaDesc,'');
  /*
  Create Formula Range Record
  */
  select Maximum as In_Maximum,
    Minimum as Minimum,
    Formula as Formula,
    Constant1 as Constant1,
    Constant2 as Constant2,
    Constant3 as Constant3,
    Constant4 as Constant4,
    Constant5 as Constant5,
    Keywords1 as Keywords1,
    Keywords2 as Keywords2,
    Keywords3 as Keywords3,
    Keywords4 as Keywords4,
    Keywords5 as Keywords5,
    Keywords6 as Keywords6,
    Keywords7 as Keywords7,
    Keywords8 as Keywords8,
    Keywords9 as Keywords9,
    Keywords10 as Keywords10,
    UserDef1 as UserDef1,
    UserDef2 as UserDef2,
    UserDef2 as UserDef3,
    UserDef4,
    UserDef5,
    F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,
    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10 into In_Maximum,
    In_Minimum,
    In_Formula,
    In_Constant1,
    In_Constant2,
    In_Constant3,
    In_Constant4,
    In_Constant5,
    In_Keywords1,
    In_Keywords2,
    In_Keywords3,
    In_Keywords4,
    In_Keywords5,
    In_Keywords6,
    In_Keywords7,
    In_Keywords8,
    In_Keywords9,
    In_Keywords10,
    In_UserDef1,
    In_UserDef2,
    In_UserDef3,
    In_UserDef4,
    In_UserDef5,
    In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
    In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,
    In_P10 from
    FormulaRange where
    FormulaRangeId = 1 and FormulaId = In_FromFormulaId;
  call InsertNewFormulaRange(
  1,
  In_FormulaId,
  In_Maximum,
  In_Minimum,
  In_Formula,
  In_Constant1,
  In_Constant2,
  In_Constant3,
  In_Constant4,
  In_Constant5,
  In_Keywords1,
  In_Keywords2,
  In_Keywords3,
  In_Keywords4,
  In_Keywords5,
  In_Keywords6,
  In_Keywords7,
  In_Keywords8,
  In_Keywords9,
  In_Keywords10,
  In_UserDef1,
  In_UserDef2,
  In_UserDef3,
  In_UserDef4,
  In_UserDef5,
  In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
  In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,In_P10)
end
;

create procedure dba.ASQLCloneCPFTable(
in In_CPFTableCodeId char(20),
in In_FromCPFTableCodeId char(20),
out Out_ErrorMessage char(100))
begin
  declare In_CPFResidenceTypeId char(20);
  declare In_CPFSchemeId char(20);
  declare In_CPFTableDesc char(100);
  declare In_EEOrdCPFFormula char(20);
  declare In_EROrdCPFFormula char(20);
  declare In_EEAddCPFFormula char(20);
  declare In_ERAddCPFFormula char(20);
  declare In_CPFPeriodCapping double;
  declare In_CPFLessThanCapping double;
  declare In_CPFGreaterThanCapping double;
  /*
  Check CPF Table Code Id exist
  */
  if exists(select* from CPFTableCode where
      CPFTableCodeId = In_CPFTableCodeId) then
    set Out_ErrorMessage='New CPF Table already exist';
    return
  end if;
  if not exists(select* from CPFTableCode where
      CPFTableCodeId = In_FromCPFTableCodeId) then
    set Out_ErrorMessage='CPF Table to clone from does not exist';
    return
  end if;
  select CPFResidenceTypeId,CPFSchemeId,
    CPFPeriodCapping,
    CPFLessThanCapping,
    CPFGreaterThanCapping,
    CPFTableDesc into In_CPFResidenceTypeId,
    In_CPFSchemeId,
    In_CPFPeriodCapping,
    In_CPFLessThanCapping,
    In_CPFGreaterThanCapping,
    In_CPFTableDesc from
    CPFTableCode where
    CPFTableCodeId = In_FromCPFTableCodeId;
  /*
  Clone the CPF Table record
  */
  call InsertNewCPFTableCode(In_CPFTableCodeId,
  In_CPFResidenceTypeId,
  In_CPFSchemeId,
  In_CPFPeriodCapping,
  In_CPFLessThanCapping,
  In_CPFGreaterThanCapping,
  In_CPFTableDesc);
  /*
  Clone the CPF Table Component
  */
  InsertCPFTableComponent: for InsertCPFTableComponentFor as InsertCPFTableComponentCurs dynamic scroll cursor for
    select MinSalary as In_MinSalary,
      MinCPFAge as In_MinCPFAge,
      MaxSalary as In_MaxSalary,
      MaxCPFAge as In_MaxCPFAge from CPFTableComponent where CPFTableCodeId = In_FromCPFTableCodeId do
    call InsertNewCPFTableComponent(In_CPFTableCodeId,In_MinSalary,In_MinCPFAge,In_MaxSalary,In_MaxCPFAge) end for;
  /*
  Clone the CPF Formula Record
  */
  LoopCPFTableComponent: for LoopCPFTableComponentFor as LoopCPFTableComponentCurs dynamic scroll cursor for
    select EEOrdCPFFormula as In_FromEEOrdCPFFormula,
      EROrdCPFFormula as In_FromEROrdCPFFormula,
      EEAddCPFFormula as In_FromEEAddCPFFormula,
      ERAddCPFFormula as In_FromERAddCPFFormula,
      MinSalary as In_FromMinSalary,
      MinCPFAge as In_FromMinCPFAge from
      CPFTableComponent where CPFTableCodeId = In_FromCPFTableCodeId do
    select EEOrdCPFFormula,
      EROrdCPFFormula,
      EEAddCPFFormula,
      ERAddCPFFormula into In_EEOrdCPFFormula,
      In_EROrdCPFFormula,
      In_EEAddCPFFormula,
      In_ERAddCPFFormula from CPFTableComponent where CPFTableCodeId = In_CPFTableCodeId and
      MinSalary = In_FromMinSalary and
      MinCPFAge = In_FromMinCPFAge;
    call ASQLCloneCPFFormulaRecord(In_EEOrdCPFFormula,In_FromEEOrdCPFFormula);
    call ASQLCloneCPFFormulaRecord(In_EROrdCPFFormula,In_FromEROrdCPFFormula);
    call ASQLCloneCPFFormulaRecord(In_EEAddCPFFormula,In_FromEEAddCPFFormula);
    call ASQLCloneCPFFormulaRecord(In_ERAddCPFFormula,In_FromERAddCPFFormula) end for;
  set Out_ErrorMessage=''
end
;

create procedure DBA.ASQLConvertPayAllocation(
in In_EmployeeSysId integer,
in In_PayGroupId char(20),
in In_BasicRateType char(20))
begin
  delete from PayAllocation where EmployeeSysId = In_EmployeeSysId;
  ConversionLoop: for ConversionFor as curs dynamic scroll cursor for
    select DefaultPayAllocSubPeriod,DefaultPayAllocTypeId,DefaultPayAllocValue from DefaultPayAllocation where
      PayGroupId = In_PayGroupId and DefaultPayBasicRateType = In_BasicRateType do
    call InsertNewPayAllocation(In_EmployeeSysId,DefaultPayAllocSubPeriod,DefaultPayAllocValue,DefaultPayAllocTypeId) end for;
  commit work
end
;

create procedure DBA.ASQLCreateLeaveDeductionRecord(
In_EmployeeSysId integer,
In_PayRecYear integer,
In_PayRecPeriod integer,
In_PayRecSubPeriod integer)
begin
  declare DayRateId char(20);
  declare HourRateId char(20);
  declare SubPeriodGenId char(30);
  declare AutoOption smallint;
  select LveDayRateId,
    LveHourRateId,
    LveAutoOption into DayRateId,
    HourRateId,
    AutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'NPL';
  call InsertNewLeaveDeductionRecord(In_EmployeeSysId,'NPL',
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,0,0,0,0,AutoOption,0,
  DayRateId,
  HourRateId,0,0,0,0,'');
  select LveDayRateId,
    LveAutoOption into DayRateId,
    AutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'Absent';
  call InsertNewLeaveDeductionRecord(In_EmployeeSysId,'Absent',
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,0,0,0,0,AutoOption,0,
  DayRateId,
  null,0,0,0,0,'');
  select LveHourRateId,
    LveAutoOption into HourRateId,
    AutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'Late';
  call InsertNewLeaveDeductionRecord(In_EmployeeSysId,'Late',
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,0,0,0,0,AutoOption,0,
  null,
  HourRateId,0,0,0,0,'')
end
;

create procedure DBA.ASQLCreateLeaveInfoRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare SubPeriodGenId char(30);
  declare AnnualLveBroughtForward double;
  declare AnnualCurrLveEntitlement double;
  declare SickCurrLveEntitlement double;
  select SickLveEntitlement,
    ANNLveBroughtForward,
    ANNLveEntitlement into SickCurrLveEntitlement,
    AnnualLveBroughtForward,
    AnnualCurrLveEntitlement from PayEmployee where
    EmployeeSysId = In_EmployeeSysId;
  call InsertNewLeaveInfoRecord(
  In_EmployeeSysId,'Annual',
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  AnnualLveBroughtForward,
  AnnualCurrLveEntitlement,
  0,'');
  call InsertNewLeaveInfoRecord(
  In_EmployeeSysId,'Sick',
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  0,
  SickCurrLveEntitlement,
  0,'')
end
;

create procedure dba.ASQLCreateOTRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CalOTDayRate double,
in In_CalOTHourRate double,
in In_CalOTLastDayRate double,
in In_CalOTLastHourRate double,
in In_BackPayDayRate double,
in In_BackPayHourRate double)
begin
  declare In_OTTableId char(20);
  declare In_CurrentOTRate double;
  declare In_LastOTRate double;
  declare In_BackPayOTRate double;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBOTDecimal(*);
  select OTTableid into In_OTTableId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  CreateOTRecLoop: for CreateOTRecFor as curs dynamic scroll cursor for
    select FormulaRange.Formulaid as In_OTRateId,
      Constant1 as In_OTRate,
      Constant2 as In_MaxFreq,
      Constant3 as In_MinRateAmt,
      Constant4 as In_MaxRateAmt,
      FormulaExRateId as In_FormulaExRateId,
      FormulaSubCategory as In_OTType from
      OTMember join Formula join FormulaRange where OTTableId = In_OTTableId do
    /*      
    Day Rate
    */
    if(In_OTType = 'OTDayRate') then
      set In_CurrentOTRate=round(cast(In_OTRate*In_CalOTDayRate as MONEY),In_DecimalPlace);
      set In_LastOTRate=round(cast(In_OTRate*In_CalOTLastDayRate as MONEY),In_DecimalPlace);
      set In_BackPayOTRate=round(cast(In_OTRate*In_BackPayDayRate as MONEY),In_DecimalPlace);
      if(In_CurrentOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_CurrentOTRate=In_MaxRateAmt
      end if;
      if(In_CurrentOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_CurrentOTRate=In_MinRateAmt
      end if;
      if(In_LastOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_LastOTRate=In_MaxRateAmt
      end if;
      if(In_LastOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_LastOTRate=In_MinRateAmt
      end if;
      if(In_BackPayOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_BackPayOTRate=In_MaxRateAmt
      end if;
      if(In_BackPayOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_BackPayOTRate=In_MinRateAmt
      end if;
      call InsertNewOTRecord(In_EmployeeSysId,
      In_OTRateId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_OTType,
      In_OTRate,
      In_MaxFreq,
      In_CurrentOTRate,0,0,
      In_LastOTRate,0,0,
      In_BackPayOTRate,0,0,'',0,'',1)
    /*      
    Fixed Rate
    */
    elseif(In_OTType = 'OTFixedRate') then
      set In_CurrentOTRate=In_OTRate;
      call InsertNewOTRecord(In_EmployeeSysId,
      In_OTRateId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_OTType,
      In_OTRate,
      In_MaxFreq,
      In_CurrentOTRate,0,0,
      0,0,0,
      0,0,0,'',0,In_FormulaExRateId,1)
    /*      
    Hour Rate
    */
    elseif(In_OTType = 'OTHourRate') then
      set In_CurrentOTRate=round(cast(In_OTRate*In_CalOTHourRate as MONEY),In_DecimalPlace);
      set In_LastOTRate=round(cast(In_OTRate*In_CalOTLastHourRate as MONEY),In_DecimalPlace);
      set In_BackPayOTRate=round(cast(In_OTRate*In_BackPayHourRate as MONEY),In_DecimalPlace);
      if(In_CurrentOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_CurrentOTRate=In_MaxRateAmt
      end if;
      if(In_CurrentOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_CurrentOTRate=In_MinRateAmt
      end if;
      if(In_LastOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_LastOTRate=In_MaxRateAmt
      end if;
      if(In_LastOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_LastOTRate=In_MinRateAmt
      end if;
      if(In_BackPayOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_BackPayOTRate=In_MaxRateAmt
      end if;
      if(In_BackPayOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_BackPayOTRate=In_MinRateAmt
      end if;
      call InsertNewOTRecord(In_EmployeeSysId,
      In_OTRateId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_OTType,
      In_OTRate,
      In_MaxFreq,
      In_CurrentOTRate,0,0,
      In_LastOTRate,0,0,
      In_BackPayOTRate,0,0,'',0,'',1)
    end if end for
end
;

create procedure DBA.ASQLCreatePayPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  declare In_SectionId char(20);
  declare In_CostCenterId char(20);
  declare In_CategoryId char(20);
  declare In_DepartmentId char(20);
  declare In_BranchId char(20);
  declare In_PositionId char(20);
  declare In_PayGroupId char(20);
  declare In_WorkCalendarId char(20);
  declare In_LeaveGroupId char(20);
  declare In_SalaryGradeId char(20);
  declare In_ClassificationCode char(20);
  declare In_WTCalendarId char(20);
  declare In_EmpCode1Id char(20);
  declare In_EmpCode2Id char(20);
  declare In_EmpCode3Id char(20);
  declare In_EmpCode4Id char(20);
  declare In_EmpCode5Id char(20);
  select BranchId,
    CategoryId,
    DepartmentId,
    SectionId,
    PositionId,
    SalaryGradeId,
    ClassificationCode,
    EmpCode1Id,
    EmpCode2Id,
    EmpCode3Id,
    EmpCode4Id,
    EmpCode5Id into In_BranchId,
    In_CategoryId,
    In_DepartmentId,
    In_SectionId,
    In_PositionId,
    In_SalaryGradeId,
    In_ClassificationCode,
    In_EmpCode1Id,
    In_EmpCode2Id,
    In_EmpCode3Id,
    In_EmpCode4Id,
    In_EmpCode5Id from Employee where EmployeeSysId = In_EmployeeSysId;
  select LeaveGroupId,
    WTCalendarId into In_LeaveGroupId,
    In_WTCalendarId from LeaveEmployee where EmployeeSysId = In_EmployeeSysId;
  select PayGroupId into In_PayGroupId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  select CalendarId into In_WorkCalendarId from EmpeeWkCalen where EmployeeSysId = In_EmployeeSysId;
  select CostCentreId into In_CostCenterId
    from CostProgression join EmployeeCostCentre where
    EmployeeSysId = In_EmployeeSysId and
    CostCentreCurrent = 1 and KeyCostCentre = 1;
  //
  // Converts null into empty string
  //
  if In_CostCenterId is null then set In_CostCenterId=''
  end if;
  if In_BranchId is null then set In_BranchId=''
  end if;
  if In_PositionId is null then set In_PositionId=''
  end if;
  if In_PayGroupId is null then set In_PayGroupId=''
  end if;
  if In_WorkCalendarId is null then set In_WorkCalendarId=''
  end if;
  if In_LeaveGroupId is null then set In_LeaveGroupId=''
  end if;
  if In_SalaryGradeId is null then set In_SalaryGradeId=''
  end if;
  if In_ClassificationCode is null then set In_ClassificationCode=''
  end if;
  if In_WTCalendarId is null then set In_WTCalendarId=''
  end if;
  if In_EmpCode1Id is null then set In_EmpCode1Id=''
  end if;
  if In_EmpCode2Id is null then set In_EmpCode2Id=''
  end if;
  if In_EmpCode3Id is null then set In_EmpCode3Id=''
  end if;
  if In_EmpCode4Id is null then set In_EmpCode4Id=''
  end if;
  if In_EmpCode5Id is null then set In_EmpCode5Id=''
  end if;
  call InsertNewPayPeriodRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_SectionId,
  In_CostCenterId,
  In_CategoryId,
  In_DepartmentId,
  In_BranchId,
  In_PositionId,
  In_PayGroupId,
  In_WorkCalendarId,
  In_LeaveGroupId,
  In_SalaryGradeId,
  In_ClassificationCode,
  In_WTCalendarId,
  In_EmpCode1Id,
  In_EmpCode2Id,
  In_EmpCode3Id,
  In_EmpCode4Id,
  In_EmpCode5Id)
end
;

create procedure DBA.ASQLCreatePayRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(20))
begin
  call InsertNewPayRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  In_PayRecID,
  In_PayRecType,'Active','S',
  now(*),
  In_PayDesc,
  In_PayInterfaceProjectId)
end
;

create procedure DBA.ASQLCreatePeriodPolicySummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
In_PayRecPeriod integer)
begin
  declare In_PayPeriodSGSPGenId char(30);
  select PayPeriodSGSPGenId into In_PayPeriodSGSPGenId from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  insert into PeriodPolicySummary(EmployeeSysId,
    PayPeriodSGSPGenId,
    PayRecYear,
    PayRecPeriod) values(
    In_EmployeeSysId,
    In_PayPeriodSGSPGenId,
    In_PayRecYear,
    In_PayRecPeriod)
end
;

create procedure dba.ASQLCreateShiftRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare In_ShiftTableId char(20);
  select ShiftTableid into In_ShiftTableId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  CreateShiftRecLoop: for CreateShiftRecFor as curs dynamic scroll cursor for
    select FormulaRange.Formulaid as In_ShiftRateId,Constant1 as In_ShiftRate from ShiftMember join Formula join FormulaRange where ShiftTableId = In_ShiftTableId do
    call InsertNewShiftRecord(In_EmployeeSysId,In_ShiftRateId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID,In_ShiftRate,0,0,'',0,'',1) end for
end
;

create procedure DBA.ASQLCreateSubPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_StartDate date,
in In_EndDate date)
begin
  declare In_PaySuspense smallint;
  select PaySuspense into In_PaySuspense from Payemployee where EmployeeSysId = In_EmployeeSysId;
  call InsertNewSubPeriodRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,'Active',
  In_StartDate,
  In_EndDate,
  In_PaySuspense)
end
;

create procedure DBA.ASQLCreateSubPeriodSetting(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare SubPeriodGenId char(30);
  declare EEOTDayRateId char(20);
  declare EEOTHourRateId char(20);
  declare EEOTTableId char(20);
  declare EEShiftTableId char(20);
  declare EELateInformation double;
  declare EEAbsentInformation double;
  declare EEBRPDayRateId char(20);
  declare EEBRPHourRateId char(20);
  declare EEGRPDayRateId char(20);
  declare EEGRPHourRateId char(20);
  select OTDayRateId,
    OTHourRateId,
    OTTableId,
    ShiftTableId,
    LateInformation,
    AbsentInformation,
    BRPDayRateId,
    BRPHourRateId,
    GRPDayRateId,
    GRPHourRateId into EEOTDayRateId,
    EEOTHourRateId,
    EEOTTableId,
    EEShiftTableId,
    EELateInformation,
    EEAbsentInformation,
    EEBRPDayRateId,
    EEBRPHourRateId,
    EEGRPDayRateId,
    EEGRPHourRateId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  call InsertNewSubPeriodSetting(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  EEOTDayRateId,
  EEOTHourRateId,
  0,0,0,0,
  EEOTTableId,
  EEShiftTableId,
  EELateInformation,
  EEAbsentInformation,
  EEBRPDayRateId,
  EEBRPHourRateId,
  0,0,
  EEGRPDayRateId,
  EEGRPHourRateId,
  0,0)
end
;

create procedure DBA.ASQLCurrentLeaveDeductionRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare In_LveDayRateId char(20);
  declare In_LveHourRateId char(20);
  declare In_LveAutoOption smallint;
  select LveDayRateId,
    LveHourRateId,
    LveAutoOption into In_LveDayRateId,
    In_LveHourRateId,
    In_LveAutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'NPL';
  update LeaveDeductionRecord set
    LveAutoOption = In_LveAutoOption,
    LveDayRateId = In_LveDayRateId,
    LveHourRateId = In_LveHourRateId where
    LeaveTypeFunctCode = 'NPL' and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  select LveDayRateId,
    LveAutoOption into In_LveDayRateId,
    In_LveAutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'Absent';
  update LeaveDeductionRecord set
    LveAutoOption = In_LveAutoOption,
    LveDayRateId = In_LveDayRateId where
    LeaveTypeFunctCode = 'Absent' and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  select LveHourRateId,
    LveAutoOption into In_LveHourRateId,
    In_LveAutoOption from PayLeaveSetting where EmployeeSysId = In_EmployeeSysId and PayLeaveTypeId = 'Late';
  update LeaveDeductionRecord set
    LveAutoOption = In_LveAutoOption,
    LveHourRateId = In_LveHourRateId where
    LeaveTypeFunctCode = 'Late' and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  commit work
end
;

create procedure DBA.ASQLCurrentLeaveInfoRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare AnnualLveBroughtForward double;
  declare AnnualCurrLveEntitlement double;
  declare SickCurrLveEntitlement double;
  select SickLveEntitlement,
    ANNLveBroughtForward,
    ANNLveEntitlement into SickCurrLveEntitlement,
    AnnualLveBroughtForward,
    AnnualCurrLveEntitlement from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  update LeaveInfoRecord set
    LveBroughtForward = AnnualLveBroughtForward,
    CurrLveEntitlement = AnnualCurrLveEntitlement where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeFunctCode = 'Annual' and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  update LeaveInfoRecord set
    CurrLveEntitlement = SickCurrLveEntitlement where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeFunctCode = 'Sick' and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  commit work
end
;

create procedure DBA.ASQLCurrentPayPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  declare In_SectionId char(20);
  declare In_CostCenterId char(20);
  declare In_CategoryId char(20);
  declare In_DepartmentId char(20);
  declare In_BranchId char(20);
  declare In_PositionId char(20);
  declare In_PayGroupId char(20);
  declare In_WorkCalendarId char(20);
  declare In_LeaveGroupId char(20);
  declare In_SalaryGradeId char(20);
  declare In_ClassificationCode char(20);
  declare In_WTCalendarId char(20);
  declare In_EmpCode1Id char(20);
  declare In_EmpCode2Id char(20);
  declare In_EmpCode3Id char(20);
  declare In_EmpCode4Id char(20);
  declare In_EmpCode5Id char(20);
  select BranchId,
    CategoryId,
    DepartmentId,
    SectionId,
    PositionId,
    SalaryGradeId,
    ClassificationCode,
    EmpCode1Id,
    EmpCode2Id,
    EmpCode3Id,
    EmpCode4Id,
    EmpCode5Id into In_BranchId,
    In_CategoryId,
    In_DepartmentId,
    In_SectionId,
    In_PositionId,
    In_SalaryGradeId,
    In_ClassificationCode,
    In_EmpCode1Id,
    In_EmpCode2Id,
    In_EmpCode3Id,
    In_EmpCode4Id,
    In_EmpCode5Id from Employee where EmployeeSysId = In_EmployeeSysId;
  select LeaveGroupId,
    WTCalendarId into In_LeaveGroupId,
    In_WTCalendarId from LeaveEmployee where EmployeeSysId = In_EmployeeSysId;
  select PayGroupId into In_PayGroupId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  select CalendarId into In_WorkCalendarId from EmpeeWkCalen where EmployeeSysId = In_EmployeeSysId;
  select CostCentreId into In_CostCenterId
    from CostProgression join EmployeeCostCentre where
    EmployeeSysId = In_EmployeeSysId and
    CostCentreCurrent = 1 and KeyCostCentre = 1;
  //
  // Converts null into empty string
  //
  if In_CostCenterId is null then set In_CostCenterId=''
  end if;
  if In_BranchId is null then set In_BranchId=''
  end if;
  if In_PositionId is null then set In_PositionId=''
  end if;
  if In_PayGroupId is null then set In_PayGroupId=''
  end if;
  if In_WorkCalendarId is null then set In_WorkCalendarId=''
  end if;
  if In_LeaveGroupId is null then set In_LeaveGroupId=''
  end if;
  if In_SalaryGradeId is null then set In_SalaryGradeId=''
  end if;
  if In_ClassificationCode is null then set In_ClassificationCode=''
  end if;
  if In_WTCalendarId is null then set In_WTCalendarId=''
  end if;
  if In_EmpCode1Id is null then set In_EmpCode1Id=''
  end if;
  if In_EmpCode2Id is null then set In_EmpCode2Id=''
  end if;
  if In_EmpCode3Id is null then set In_EmpCode3Id=''
  end if;
  if In_EmpCode4Id is null then set In_EmpCode4Id=''
  end if;
  if In_EmpCode5Id is null then set In_EmpCode5Id=''
  end if;
  call UpdatePayPeriodRecord(In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_SectionId,
  In_CostCenterId,
  In_CategoryId,
  In_DepartmentId,
  In_BranchId,
  In_PositionId,
  In_PayGroupId,
  In_WorkCalendarId,
  In_LeaveGroupId,
  In_SalaryGradeId,
  In_ClassificationCode,
  In_WTCalendarId,
  In_EmpCode1Id,
  In_EmpCode2Id,
  In_EmpCode3Id,
  In_EmpCode4Id,
  In_EmpCode5Id)
end
;

create procedure DBA.ASQLCurrentPayRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  update PayRecord set
    LastProcessed = now(*) where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID
end
;

create procedure DBA.ASQLCurrentSubPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_StartDate date,
in In_EndDate date)
begin
  declare In_PaySuspense smallint;
  select PaySuspense into In_PaySuspense from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  update SubPeriodRecord set
    SubPeriodStartDate = In_StartDate,
    SubPeriodEndDate = In_EndDate,
    PaySuspense = In_PaySuspense where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  commit work
end
;

create procedure DBA.ASQLCurrentSubPeriodSetting(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare Out_OTDayRateId char(20);
  declare Out_OTHourRateId char(20);
  declare Out_OTTableId char(20);
  declare Out_ShiftTableId char(20);
  declare Out_LateInformation double;
  declare Out_AbsentInformation double;
  declare Out_BRPDayRateId char(20);
  declare Out_BRPHourRateId char(20);
  declare Out_GRPDayRateId char(20);
  declare Out_GRPHourRateId char(20);
  select OTDayRateId,
    OTHourRateId,
    OTTableId,
    ShiftTableId,
    LateInformation,
    AbsentInformation,
    BRPDayRateId,
    BRPHourRateId,
    GRPDayRateId,
    GRPHourRateId into Out_OTDayRateId,
    Out_OTHourRateId,
    Out_OTTableId,
    Out_ShiftTableId,
    Out_LateInformation,
    Out_AbsentInformation,
    Out_BRPDayRateId,
    Out_BRPHourRateId,
    Out_GRPDayRateId,
    Out_GRPHourRateId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  update SubPeriodSetting set
    OTDayRateId = Out_OTDayRateId,
    OTHourRateId = Out_OTHourRateId,
    EEOTTableId = Out_OTTableId,
    EEShiftTableId = Out_ShiftTableId,
    LateInformation = Out_LateInformation,
    AbsentInformation = Out_AbsentInformation,
    BRPDayRateId = Out_BRPDayRateId,
    BRPHourRateId = Out_BRPHourRateId,
    GRPDayRateId = Out_GRPDayRateId,
    GRPHourRateId = Out_GRPHourRateId where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  commit work
end
;

create procedure DBA.ASQLDeleteAndNewCPFPayment(
in In_EmployeeSysId integer,
in In_PayGroupId char(20))
begin
  if exists(select* from CPFPayment where CPFPayment.EmployeeSysId = In_EmployeeSysId) then
    delete from CPFPayment where
      CPFPayment.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  call ASQLNewCPFPayment(In_EmployeeSysId,In_PayGroupId)
end
;

create procedure DBA.ASQLDeleteAndNewPayAllocation(
in In_EmployeeSysId integer,
in In_PayGroupId char(20),
in In_BasicRateType char(20))
begin
  declare In_PayBalLastSubPeriod smallint;
  if exists(select* from PayAllocation where PayAllocation.EmployeeSysId = In_EmployeeSysId) then
    delete from PayAllocation where
      PayAllocation.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  call ASQLNewPayAllocation(In_EmployeeSysId,In_PayGroupId,In_BasicRateType);
  select PayBalLastSubPeriod into In_PayBalLastSubPeriod from PayGroup where
    PayGroupId = In_PayGroupId;
  update PayEmployee set
    PayAllocationBalance = In_PayBalLastSubPeriod where
    EmployeeSysId = In_EmployeeSysId
end
;

create procedure DBA.ASQLDeleteEmployeePayRecords(
in In_EmployeeSysId integer)
begin
  delete from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId;
  delete from HKOrdinance where PayPeriodSGSPGenId = 
    any(select PayPeriodSGSPGenId from PayPeriodRecord where EmployeeSysId = In_EmployeeSysId);
  delete from HKPeriodDisregard where OrdinSGSPGenId = 
    any(select OrdinSGSPGenId from HKPeriodOrdinance where EmployeeSysId = In_EmployeeSysId);
  delete from HKPeriodOrdinance where
    EmployeeSysId = In_EmployeeSysId;
  delete from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId;
  delete from SubPeriodRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from PayRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from OTRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from ShiftRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from BankRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId;
  delete from DetailRecord where
    EmployeeSysId = In_EmployeeSysId;
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId from AllowanceRecord left outer join AllowanceHistoryRecord do
    if(EmployeeSysId = In_EmployeeSysId) then
      delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
      delete from AllowanceRecord where AllowanceSGSPGenId = GenId
    end if end for;
  commit work
end
;

create procedure DBA.ASQLDeleteEmployeeProgression(
in In_EmployeeSysId integer)
begin
  //
  //    Delete Policy Progression
  //    
  call DeletePolicyProgression(In_EmployeeSysId);
  //
  //    Delete Basic Rate Progression
  //  
  call DeleteBasicRateProgression(In_EmployeeSysId);
  //
  //    Delete CPF Progression
  //  
  call DeleteCPFProgression(In_EmployeeSysId);
  //
  //    Delete EPF, SOCSO Progression
  //
  if FGetDBCountry(*) = 'Malaysia' then
    call DeleteEPFProgression(In_EmployeeSysId);
    call DeleteSOCSOProgression(In_EmployeeSysId)
  end if;
  //
  //    Delete Mandatory Contribution Progression
  //
  if FGetDBCountry(*) = 'Philippines' then
    DeleteMandatoryContributeProgressionLoop: for MandatoryContributeProgressionFor as MandatoryContributeProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete VnC45 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC45Loop: for VnC45For as VnC45curs dynamic scroll cursor for
      select VnC45SGSPGenId as In_VnC45SGSPGenId from VnC45Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC45Record(In_VnC45SGSPGenId) end for
  end if;
  //
  //    Delete VnC47 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47Loop: for VnC47For as VnC47curs dynamic scroll cursor for
      select VnC47SGSPGenId as In_VnC47SGSPGenId from VnC47Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47Record(In_VnC47SGSPGenId) end for
  end if;
  //
  //    Delete VnC04 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC04Loop: for VnC04For as VnC04curs dynamic scroll cursor for
      select VnC04SGSPGenId as In_VnC04SGSPGenId from VnC04Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC04Record(In_VnC04SGSPGenId) end for
  end if;
  //
  //    Delete VnC47a Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47aLoop: for VnC47aFor as VnC47acurs dynamic scroll cursor for
      select VnC47aSGSPGenId as In_VnC47aSGSPGenId from VnC47aRecord where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47aRecord(In_VnC47aSGSPGenId) end for
  end if;
  //
  //    Delete SI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteSIProgressionLoop: for SIProgressionFor as SIProgressioncurs dynamic scroll cursor for
      select SIProgSysId as In_SIProgSysId from SIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteSIProgression(In_SIProgSysId) end for
  end if;
  //
  //    Delete HI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteHIProgressionLoop: for HIProgressionFor as HIProgressioncurs dynamic scroll cursor for
      select HIProgSysId as In_HIProgSysId from HIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteHIProgression(In_HIProgSysId) end for
  end if;
  //
  //    Delete MPF Progression
  //
  if FGetDBCountry(*) = 'HongKong' then
    DeleteMPFProgressionLoop: for MPFProgressionFor as MPFProgressioncurs dynamic scroll cursor for
      select MPFProgSysId as In_MPFProgSysId from MPFProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMPFProgression(In_MPFProgSysId) end for
  end if;
  //
  //Delete Mandatory Contribution
  //
  if FGetDBCountry(*) = 'Thailand' then
    DeletePFSSProgressionLoop: for PFSSProgressionFor as PFSSProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete Career Progression
  //
  DeleteCareerProgressionLoop: for CareerProgressionFor as CareerProgressioncurs dynamic scroll cursor for
    select CareerEffectiveDate as In_CareerEffectiveDate from CareerProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteCareerProgression(In_EmployeeSysId,In_CareerEffectiveDate) end for;
  //
  //    Delete Contract Progression
  //
  DeleteContractProgressionLoop: for ContractProgressionFor as ContractProgressioncurs dynamic scroll cursor for
    select ContractStartDate as In_ContractStartDate from ContractProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteContractProgression(In_EmployeeSysId,In_ContractStartDate) end for;
  //
  // Delete FWL Progression
  //
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  //
  // Delete EP Progression
  //
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  commit work
end
;

create procedure DBA.ASQLDeleteEmployment(
in In_EmployeeSysId integer)
begin
  declare In_EmployeeId char(30);
  declare Out_ErrorCode integer;
  call ASQLDeleteLeaveEmployee(In_EmployeeSysId);
  call ASQLDeleteEmployeePayRecords(In_EmployeeSysId);
  call ASQLDeleteEmployeeProgression(In_EmployeeSysId);
  call ASQLDeletePayEmployee(In_EmployeeSysId);
  call ASQLDeleteLeaveEmployee(In_EmployeeSysId);
  call DeleteCostingDetails(In_EmployeeSysId,Out_ErrorCode);
  call DeleteBenefitDetails(In_EmployeeSysId,Out_ErrorCode);
  /*
  Delete Competency
  */
  CompetencyLoop: for CompetencyFor as CompetencyCurs dynamic scroll cursor for
    select CompetencySysId as Out_CompetencySysId from Competency where
      Competency.EmployeeSysId = In_EmployeeSysId do
    call DeleteCompetency(Out_CompetencySysId,Out_ErrorCode) end for;
  /*
  Other Tables
  */
  delete from Succession where EmployeeSysId = In_EmployeeSysId;
  delete from JobRespon where EmployeeSysId = In_EmployeeSysId;
  delete from OtherBankInfo where OtherBankInfo.EmployeeSysId = In_EmployeeSysId;
  delete from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId;
  delete from ContractProgression where ContractProgression.EmployeeSysId = In_EmployeeSysId;
  delete from ShiftCalendar where ShiftCalendar.EmployeeSysId = In_EmployeeSysId;
  select EmployeeId into In_EmployeeId from Employee where EmployeeSysId = In_EmployeeSysId;
  call DeleteEmployeeRecord(In_EmployeeSysId,In_EmployeeId)
end
;

create procedure DBA.ASQLDeletePayEmployee(
in In_EmployeeSysId integer)
begin
  call DeletePayEmployeePolicy(In_EmployeeSysId);
  call DeleteCPFPayment(In_EmployeeSysId);
  call DeletePayAllocation(In_EmployeeSysId);
  call DeletePayLeaveSetting(In_EmployeeSysId);
  call DeleteBalPayElementId(In_EmployeeSysId);
  call DeleteLoanEmployeeEmp(In_EmployeeSysId);
  delete from EmployeeRecurAllowance where EmployeeSysId = In_EmployeeSysId;
  /*
  Delete NS Pay Records
  */
  DeleteNSPayCaseLoop: for NSPayCaseFor as NSPayCaseCurs dynamic scroll cursor for
    select NSPaySysId as In_NSPaySysId from NSPayCase where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteNSPayCase(In_NSPaySysId) end for;
  /*
  Delete Casual Records
  */
  DeleteNSPayCaseLoop: for CasualFor as CasualCurs dynamic scroll cursor for
    select CasualSGSPGenId as In_CasualSGSPGenId from CasRecord where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteCasRecord(In_CasualSGSPGenId) end for;
  /*
  Delete Time Sheet Records
  */
  TimeSheetLoop: for TimeSheetFor as TimeSheetcurs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteTimeSheet(In_TMSSGSPGenId) end for;
  /*
  Delete Certification Records
  */
  delete from EmpCertification where EmployeeSysId = In_EmployeeSysId;
  /*
  Delete HKPeriodOrdinance Records (HongKong only)
  */
  if FGetDBCountry(*) = 'HongKong' then call DeleteHKPeriodOrdinanceByEmployeeSysId(In_EmployeeSysId)
  end if;
  call DeletePayEmployee(In_EmployeeSysId);
  commit work
end
;

create procedure DBA.ASQLDeletePayRecords(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare CountPayRecord integer;
  select count(*) into CountPayRecord from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  if(CountPayRecord = 1) then
    call ASQLDeleteSubPeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod)
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

create procedure DBA.ASQLDeletePeriodRecords(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  delete from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from HKOrdinance where PayPeriodSGSPGenId = 
    (select PayPeriodSGSPGenId from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod);
  delete from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from SubPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from OTRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from ShiftRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  delete from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
    if(EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod) then
      delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
      delete from AllowanceRecord where AllowanceSGSPGenId = GenId
    end if end for;
  commit work
end
;

create procedure DBA.ASQLDeleteRecurring(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      AllowanceRecurSysId from AllowanceRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (AllowanceRecurSysId <> '0' and AllowanceRecurSysId <> '') do
    delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
    delete from AllowanceRecord where AllowanceSGSPGenId = GenId end for;
  commit work
end
;

create procedure DBA.ASQLDeleteSubPeriodRecords(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare CountSubPeriod integer;
  select count(*) into CountSubPeriod from SubPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if(CountSubPeriod = 1) then
    call ASQLDeletePeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)
  else
    delete from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from SubPeriodSetting where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from SubPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from OTRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from ShiftRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    delete from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
      select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId from AllowanceRecord left outer join AllowanceHistoryRecord do
      if(EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod) then
        delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
        delete from AllowanceRecord where AllowanceSGSPGenId = GenId
      end if end for
  end if;
  commit work
end
;

create procedure DBA.ASQLDropIndex()
begin
  /* Pay Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PayRecord') then
    drop index PayRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'PayRecord') then
    drop index PayRecord.General_Index_YPSI
  end if;
  /*  Detail Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'DetailRecord') then
    drop index DetailRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'DetailRecord') then
    drop index DetailRecord.General_Index_YPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'DetailRecord') then
    drop index DetailRecord.General_Index_YPS
  end if;
  /*  Policy Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PolicyRecord') then
    drop index PolicyRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'PolicyRecord') then
    drop index PolicyRecord.General_Index_YPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'PolicyRecord') then
    drop index PolicyRecord.General_Index_YPS
  end if;
  /* Bank Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'BankRecord') then
    drop index BankRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'BankRecord') then
    drop index BankRecord.General_Index_YPSI
  end if;
  /* Shift Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'ShiftRecord') then
    drop index ShiftRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'ShiftRecord') then
    drop index ShiftRecord.General_Index_EYPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'ShiftRecord') then
    drop index ShiftRecord.General_Index_YPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'ShiftRecord') then
    drop index ShiftRecord.General_Index_YPSIF
  end if;
  /* OT Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'OTRecord') then
    drop index OTRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'OTRecord') then
    drop index OTRecord.General_Index_EYPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'OTRecord') then
    drop index OTRecord.General_Index_YPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'OTRecord') then
    drop index OTRecord.General_Index_YPSIF
  end if;
  /* Allowance Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'AllowanceRecord') then
    drop index AllowanceRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'AllowanceRecord') then
    drop index AllowanceRecord.General_Index_EYPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'AllowanceRecord') then
    drop index AllowanceRecord.General_Index_YPSI
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'AllowanceRecord') then
    drop index AllowanceRecord.General_Index_YPSIF
  end if;
  /* Sub Period Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'SubPeriodRecord') then
    drop index SubPeriodRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'SubPeriodRecord') then
    drop index SubPeriodRecord.General_Index_YPS
  end if;
  /* Sub Period Setting */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'SubPeriodSetting') then
    drop index SubPeriodSetting.Key_Index
  end if;
  /* Leave Info Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'LeaveInfoRecord') then
    drop index LeaveInfoRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSL' and T.table_name = 'LeaveInfoRecord') then
    drop index LeaveInfoRecord.General_Index_YPSL
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPL' and T.table_name = 'LeaveInfoRecord') then
    drop index LeaveInfoRecord.General_Index_EYPL
  end if;
  /* Leave Deduction Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'LeaveDeductionRecord') then
    drop index LeaveDeductionRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSL' and T.table_name = 'LeaveDeductionRecord') then
    drop index LeaveDeductionRecord.General_Index_YPSL
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPL' and T.table_name = 'LeaveInfoRecord') then
    drop index LeaveDeductionRecord.General_Index_EYPL
  end if;
  /* Pay Period Record */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PayPeriodRecord') then
    drop index PayPeriodRecord.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YP' and T.table_name = 'PayPeriodRecord') then
    drop index PayPeriodRecord.General_Index_YP
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYP' and T.table_name = 'PayPeriodRecord') then
    drop index PayPeriodRecord.General_Index_EYP
  end if;
  /* Period Policy Summary */
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PeriodPolicySummary') then
    drop index PeriodPolicySummary.Key_Index
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YP' and T.table_name = 'PeriodPolicySummary') then
    drop index PeriodPolicySummary.General_Index_YP
  end if;
  if exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYP' and T.table_name = 'PeriodPolicySummary') then
    drop index PeriodPolicySummary.General_Index_EYP
  end if
end
;

create procedure DBA.ASQLGetEmpCurrentPayRecord(
in In_EmployeeSysId integer,
out Out_PayRecYear integer,
out Out_PayRecPeriod integer,
out Out_PayRecSubPeriod integer)
begin
  select max(PayRecYear) into Out_PayRecYear from PayRecord where EmployeeSysId = In_EmployeeSysId;
  if(Out_PayRecYear is null) then
    set Out_PayRecYear=0;
    set Out_PayRecPeriod=0;
    set Out_PayRecSubPeriod=0
  else
    select max(PayRecPeriod) into Out_PayRecPeriod from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = Out_PayRecYear;
    select max(PayRecSubPeriod) into Out_PayRecSubPeriod from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = Out_PayRecYear and
      PayRecPeriod = Out_PayRecPeriod
  end if
end
;

create procedure dba.ASQLGetNextPayPeriod(
in In_PayGroupId char(20))
begin
  declare Out_CurrentYear integer;
  declare Out_CurrentPeriod integer;
  declare Out_CurrentSubPeriod integer;
  declare Out_NoSubPeriod integer;
  declare Out_PeriodStartYear integer;
  select NoSubPeriod into Out_NoSubPeriod from PayGroup where PayGroupId = In_PayGroupId;
  select PeriodStartYear into Out_PeriodStartYear from PayGroup where PayGroupId = In_PayGroupId;
  select max(PayGroupYear) into Out_CurrentYear from PayGroupPeriod where PayGroupId = In_PayGroupId;
  select max(PayGroupPeriod) into Out_CurrentPeriod from PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = Out_CurrentYear;
  select max(PayGroupSubPeriod) into Out_CurrentSubPeriod from PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = Out_CurrentYear and
    PayGroupPeriod = Out_CurrentPeriod;
  if(Out_CurrentYear is null or Out_CurrentPeriod is null or Out_CurrentSubPeriod is null) then
    set Out_CurrentYear=Out_PeriodStartYear;
    set Out_CurrentPeriod=1;
    set Out_CurrentSubPeriod=1
  else
    set Out_CurrentSubPeriod=Out_CurrentSubPeriod+1;
    if(Out_CurrentSubPeriod > Out_NoSubPeriod) then
      set Out_CurrentSubPeriod=1;
      set Out_CurrentPeriod=Out_CurrentPeriod+1
    end if;
    if(Out_CurrentPeriod > 12) then
      set Out_CurrentPeriod=1;
      set Out_CurrentYear=Out_CurrentYear+1
    end if
  end if;
  select Out_CurrentYear as Year,Out_CurrentPeriod as Period,Out_CurrentSubPeriod as SubPeriod
end
;

create procedure DBA.ASQLGetPeriodLastOTDayHourRate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_LastOTDayRateAmt double,
out Out_LastOTHourRateAmt double)
begin
  declare In_PayRecSubPeriod integer;
  if In_PayRecPeriod = 1 then
    set In_PayRecYear=In_PayRecYear-1;
    set In_PayRecPeriod=12
  else
    set In_PayRecPeriod=In_PayRecPeriod-1
  end if;
  select max(PayRecSubPeriod) into In_PayRecSubPeriod from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_PayRecSubPeriod is null then
    set Out_LastOTDayRateAmt=0;
    set Out_LastOTHourRateAmt=0;
    return
  end if;
  select CurrentOTDayRateAmt,CurrentOTHourRateAmt into Out_LastOTDayRateAmt,
    Out_LastOTHourRateAmt from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod
end
;

create procedure DBA.ASQLLockAllPayGroupPeriod(
in In_PayGroupId char(20))
begin
  update PayGroupPeriod set SubPeriodStatus = 'Locked' where PayGroupId = In_PayGroupId;
  commit work
end
;

create procedure DBA.ASQLNewCPFPayment(
in In_EmployeeSysId integer,
in In_PayGroupId char(20))
begin
  CreateCPFPayment: for CPFPayment as curs dynamic scroll cursor for
    select DefaultCPFPayment.DefaultCPFPaymentSubPeriod as SubPeriod,CPFPaymentOption as PayOption from DefaultCPFPayment where
      DefaultCPFPayment.PayGroupId = In_PayGroupId do
    insert into CPFPayment(EmployeeSysId,CPFPaymentSubPeriod,CPFPaymentOption) values(
      In_EmployeeSysId,SubPeriod,PayOption) end for;
  commit work
end
;

create procedure DBA.ASQLNewPayAllocation(
in In_EmployeeSysId integer,
in In_PayGroupId char(20),
in In_BasicRateType char(20))
begin
  CreateCPFPayment: for PayAllocation as curs dynamic scroll cursor for
    select DefaultPayAllocation.DefaultPayAllocSubPeriod as SubPeriod,DefaultPayAllocTypeId as TypeId,DefaultPayAllocValue as AllocValue from DefaultPayAllocation where
      DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayBasicRateType = In_BasicRateType do
    insert into PayAllocation(EmployeeSysId,PayAllocationSubPeriod,PayAllocationTypeId,PayAllocationValue) values(
      In_EmployeeSysId,SubPeriod,TypeId,AllocValue) end for;
  commit work
end
;

create procedure DBA.ASQLPayEmployeeConversion(
in In_EmployeeSysId integer,
in In_PayGroupId char(20),
in In_BasicRateType char(20),
in In_NewBasicRate double,
in In_PreviousBasicRate double,
in In_NewNWC double,
in In_PreviousNWC double,
in In_NewMVC double,
in In_PreviousMVC double)
begin
  declare In_Balance smallint;
  declare In_CurrentPayGroup char(20);
  select PayGroupId into In_CurrentPayGroup from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  update PayEmployee set
    CurrentBasicRate = In_NewBasicRate,
    PreviousBasicRate = In_PreviousBasicRate,
    CurrentBasicRateType = In_BasicRateType,
    PreviousBasicRateType = In_BasicRateType,
    PayGroupId = In_PayGroupId where
    EmployeeSysId = In_EmployeeSysId;
  update PayEmployeePolicy set
    CurrentNWC = In_NewNWC,
    PreviousNWC = In_PreviousNWC,
    CurrentMVC = In_NewMVC,
    PreviousMVC = In_PreviousMVC where
    EmployeeSysId = In_EmployeeSysId;
  if(In_CurrentPayGroup <> In_PayGroupId) then
    select PayBalLastSubPeriod into In_Balance from PayGroup where PayGroupid = In_PayGroupId;
    update PayEmployee set
      PayAllocationBalance = In_Balance where
      EmployeeSysId = In_EmployeeSysId;
    call ASQLConvertPayAllocation(In_EmployeeSysId,In_PayGroupId,In_BasicRateType)
  end if;
  commit work
end
;

create procedure DBA.ASQLPayEmployeeProgression(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_NewBasicRate_F double,
in In_PreviousBasicRate_F double,
in In_NewNWC_F double,
in In_PreviousNWC_F double,
in In_NewMVC_F double,
in In_PreviousMVC_F double,
in In_NewBasicRate double,
in In_PreviousBasicRate double,
in In_NewNWC double,
in In_PreviousNWC double,
in In_NewMVC double,
in In_PreviousMVC double,
in In_ExRateId char(20),
in In_ExRate double)
begin
  update PayEmployee set
    CurrentBasicRate = In_NewBasicRate_F,
    PreviousBasicRate = In_PreviousBasicRate_F,
    BasicRateExchangeId = In_ExRateId where
    EmployeeSysId = In_EmployeeSysId;
  update PayEmployeePolicy set
    CurrentNWC = In_NewNWC_F,
    PreviousNWC = In_PreviousNWC_F,
    CurrentMVC = In_NewMVC_F,
    PreviousMVC = In_PreviousMVC_F where
    EmployeeSysId = In_EmployeeSysId;
  update DetailRecord set
    CurrentBasicRate = In_NewBasicRate,
    PreviousBasicRate = In_PreviousBasicRate,
    CurrentBasicRateF = In_NewBasicRate_F,
    PreviousBasicRateF = In_PreviousBasicRate_F,
    CurrentBRExRateId = In_ExRateId,
    CurrentBRExRate = In_ExRate where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  update PolicyRecord set
    CurrentNWC = In_NewNWC,
    PreviousNWC = In_PreviousNWC,
    CurrentMVC = In_NewMVC,
    PreviousMVC = In_PreviousMVC,
    CurrentNWCF = In_NewNWC_F,
    PreviousNWCF = In_PreviousNWC_F,
    CurrentMVCF = In_NewMVC_F,
    PreviousMVCF = In_PreviousMVC_F where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID
end
;

create procedure DBA.ASQLPeriodFundSummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CDAC double,
out Out_SINDA double,
out Out_MBMF double,
out Out_EUCF double,
out Out_COMC double,
out Out_YMF double,
out Out_MOSQ double)
begin
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'CDACCode') into Out_CDAC;
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'SINDACode') into Out_SINDA;
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'EUCFCode') into Out_EUCF;
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'COMCCode') into Out_COMC;
  /*
  Property MBMFCode is actually for MOSQ
  */
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'MBMFCode') into Out_MOSQ;
  select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'YMFCode') into Out_YMF;
  set Out_CDAC=Out_CDAC*-1;
  set Out_SINDA=Out_SINDA*-1;
  set Out_MOSQ=Out_MOSQ*-1;
  set Out_EUCF=Out_EUCF*-1;
  set Out_COMC=Out_COMC*-1;
  set Out_YMF=Out_YMF*-1;
  /*
  This is for CPF Submission
  */
  set Out_MBMF=Out_MOSQ+Out_YMF;
  update PeriodPolicySummary set
    TotalCDAC = Out_CDAC,
    TotalSINDA = Out_SINDA,
    TotalEUCF = Out_EUCF,
    TotalMBMF = Out_MBMF,
    TotalCOMM = Out_COMC,
    TotalYMF = Out_YMF,
    TotalMOSQ = Out_MOSQ where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod
end
;

create procedure DBA.ASQLPeriodLeaveSummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_AnnLveBroughtForward double,
out Out_AnnLveEntitlement double,
out Out_AnnualLeaveTaken double,
out Out_AnnualYTDTaken double,
out Out_AnnBalance double,
out Out_SickLveEntitlement double,
out Out_SickLeaveTaken double,
out Out_SickYTDTaken double,
out Out_SickBalance double)
begin
  select FGetPeriodAnnualLeaveTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_AnnualLeaveTaken;
  select FGetPeriodSickLeaveTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_SickLeaveTaken;
  select FGetPeriodYTDTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod-1,'Annual') into Out_AnnualYTDTaken;
  select FGetPeriodYTDTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod-1,'Sick') into Out_SickYTDTaken;
  select SickLveEntitlement,AnnLveBroughtForward,AnnLveEntitlement into Out_SickLveEntitlement,
    Out_AnnLveBroughtForward,Out_AnnLveEntitlement from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  set Out_AnnBalance=Out_AnnLveBroughtForward+Out_AnnLveEntitlement-Out_AnnualLeaveTaken-Out_AnnualYTDTaken;
  set Out_SickBalance=Out_SickLveEntitlement-Out_SickLeaveTaken-Out_SickYTDTaken
end
;

create procedure DBA.ASQLPeriodSummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurrentHrDays double,
out Out_PreviousHrDays double,
out Out_BasicRate double,
out Out_TotalWage double,
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LveDeductAmt double,
out Out_BackPay double,
out Out_Allowance double,
out Out_Deduction double,
out Out_Reimbursement double,
out Out_GrossWage double,
out Out_NetWage double,
out Out_TotalGrossWage double,
out Out_Bonus double)
begin
  select FGetPeriodCurrentHrDays(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_CurrentHrDays;
  select FGetPeriodPreviousHrDays(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_PreviousHrDays;
  select FGetPeriodBasicRate(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_BasicRate;
  select FGetPeriodTotalWage(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_TotalWage;
  select FGetPeriodOTAmount(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_OTAmount;
  select FGetPeriodOTBackPay(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_OTBackPay;
  select FGetPeriodShiftAmount(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_ShiftAmount;
  select FGetPeriodLveDeductAmt(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_LveDeductAmt;
  select FGetPeriodBackPay(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_BackPay;
  select FGetPeriodAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_Allowance;
  select FGetPeriodDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_Deduction;
  select FGetPeriodReimbursement(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_Reimbursement;
  select FGetPeriodGrossWage(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_GrossWage;
  select FGetPeriodNetWage(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_NetWage;
  select FGetPeriodTotalGrossWage(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_TotalGrossWage;
  select FGetPeriodBonus(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_Bonus
end
;

create procedure DBA.ASQLRecalLeaveDeductionRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  declare In_LveAmount double;
  RecalLveLoop: for CreateLveRecFor as curs dynamic scroll cursor for
    select LeaveTypeFunctCode as In_LeaveId,
      CurrentLveDays as In_CurrentLveDays,
      CurrentLveHours as In_CurrentLveHours,
      PreviousLveIncDays as In_PerviousLveIncDays,
      PreviousLveIncHours as In_PerviousLveIncHours,
      CurrentDayRateAmt as In_CurrentDayRateAmt,
      CurrentHourRateAmt as In_CurrentHourRateAmt,
      PreviousDayRateAmt as In_PreviousDayRateAmt,
      PreviousHourRateAmt as In_PreviousHourRateAmt from
      LeaveDeductionRecord where
      EmployeeSysid = In_employeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod do
    set In_LveAmount=Round(In_CurrentDayRateAmt*In_CurrentLveDays,FGetDBPayDecimal(*))+
      Round(In_CurrentHourRateAmt*In_CurrentLveHours,FGetDBPayDecimal(*))+
      Round(In_PreviousDayRateAmt*In_PerviousLveIncDays,FGetDBPayDecimal(*))+
      Round(In_PreviousHourRateAmt*In_PerviousLveIncHours,FGetDBPayDecimal(*));
    update LeaveDeductionRecord set LveAmount = In_LveAmount where current of curs end for;
  commit work
end
;

create procedure DBA.ASQLRecalOTRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare In_CurrentOTAmount double;
  declare In_LastOTAmount double;
  declare In_BackPayOTAmount double;
  declare In_OTAmountF double;
  RecalOTRecLoop: for CreateOTRecFor as curs dynamic scroll cursor for
    select OTType as In_OTType,
      MaxFreq as In_MaxFreq,
      CurrentOTRate as In_CurrentOTRate,
      CurrentOTFreq as In_CurrentOTFreq,
      LastOTRate as In_LastOTRate,
      LastOTFreq as In_LastOTFreq,
      BackPayOTRate as In_BackPayOTRate,
      BackPayOTFreq as In_BackPayOTFreq,
      OTExRateId as In_OTExRateId,
      OTExRate as In_OTExRate,
      OTFormulaSGSPGenId as In_OTFormulaSGSPGenId from
      OTRecord where
      EmployeeSysid = In_employeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecID do
    if(In_MaxFreq <> 0) then
      if(In_CurrentOTFreq > In_MaxFreq) then
        set In_CurrentOTFreq=In_MaxFreq
      end if;
      if(In_LastOTFreq > In_MaxFreq) then
        set In_LastOTFreq=In_MaxFreq
      end if;
      if(In_BackPayOTFreq > In_MaxFreq) then
        set In_BackPayOTFreq=In_MaxFreq
      end if
    end if;
    /*
    Day Rate
    */
    if(In_OTType = 'OTDayRate') then
      set In_CurrentOTAmount=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as MONEY),FGetDBPayDecimal(*));
      set In_LastOTAmount=Round(cast(In_LastOTFreq*In_LastOTRate as MONEY),FGetDBPayDecimal(*));
      set In_BackPayOTAmount=Round(cast(In_BackPayOTFreq*In_BackPayOTRate as MONEY),FGetDBPayDecimal(*));
      set In_OTAmountF=0
    /*
    Hour Rate
    */
    elseif(In_OTType = 'OTHourRate') then
      set In_CurrentOTAmount=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as MONEY),FGetDBPayDecimal(*));
      set In_LastOTAmount=Round(cast(In_LastOTFreq*In_LastOTRate as MONEY),FGetDBPayDecimal(*));
      set In_BackPayOTAmount=Round(cast(In_BackPayOTFreq*In_BackPayOTRate as MONEY),FGetDBPayDecimal(*));
      set In_OTAmountF=0
    /*
    Fixed Rate
    */
    elseif(In_OTType = 'OTFixedRate') then
      set In_OTAmountF=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as MONEY),FGetDBPayDecimal(*));
      if(In_OTAmountF > In_MaxFreq and In_MaxFreq <> 0) then
        set In_OTAmountF=Round(In_MaxFreq,FGetDBPayDecimal(*))
      end if;
      set In_CurrentOTAmount=Round(cast(In_OTAmountF*In_OTExRate as MONEY),FGetDBPayDecimal(*));
      set In_LastOTAmount=0;
      set In_BackPayOTAmount=0
    end if;
    update OTRecord set
      CurrentOTAmount = In_CurrentOTAmount,
      LastOTAmount = In_LastOTAmount,
      BackPayOTAmount = In_BackPayOTAmount,
      CurrentOTFreq = In_CurrentOTFreq,
      LastOTFreq = In_LastOTFreq,
      BackPayOTFreq = In_BackPayOTFreq,
      OTAmountF = In_OTAmountF where current of curs end for;
  commit work
end
;

create procedure dba.ASQLRecalShiftRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare In_ShiftAmount double;
  declare In_ShiftAmountF double;
  RecalShiftRecLoop: for CreateShiftRecFor as curs dynamic scroll cursor for
    select ShiftFrequency as In_ShiftFrequency,
      ShiftRate as In_ShiftRate,
      ShiftExRateId as In_ShiftExRateId,
      ShiftExRate as In_ShiftExRate,
      ShiftFormulaSGSPGenId as In_ShiftFormulaSGSPGenId from ShiftRecord where
      EmployeeSysid = In_employeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod do
    set In_ShiftAmountF=Round(In_ShiftFrequency*In_ShiftRate,FGetDBPayDecimal(*));
    set In_ShiftAmount=Round(In_ShiftAmountF*In_ShiftExRate,FGetDBPayDecimal(*));
    update ShiftRecord set
      ShiftAmount = In_ShiftAmount,
      ShiftAmountF = In_ShiftAmountF where
      ShiftRecord.ShiftFormulaSGSPGenId = In_ShiftFormulaSGSPGenId end for;
  commit work
end
;

create procedure DBA.ASQLRemovePayElement(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_FormulaID char(20),
in In_AllOption smallint,
out Out_Success integer)
begin
  declare AllowanceCount integer;
  select count(AllowanceSGSPGenId) into AllowanceCount from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID and
    AllowanceFormulaId = In_FormulaID;
  if(AllowanceCount = 0) then
    set Out_Success=1;
    return
  end if;
  if(In_AllOption = 0 and AllowanceCount > 1) then
    set Out_Success=0;
    return
  end if;
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId,AllowanceFormulaId from AllowanceRecord left outer join AllowanceHistoryRecord do
    if(EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      AllowanceFormulaId = In_FormulaID) then
      delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
      delete from AllowanceRecord where AllowanceSGSPGenId = GenId
    end if end for;
  commit work;
  set Out_Success=1
end
;

create procedure dba.ASQLResetBankRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentType char(20))
begin
  if(In_PaymentType = 'All') then
    update BankRecord set
      PaymentAmt = 0 where
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      EmployeeSysId = In_EmployeeSysId;
    commit work
  else
    update BankRecord set
      PaymentAmt = 0 where
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      EmployeeSysId = In_EmployeeSysId and
      PaymentType = In_PaymentType;
    commit work
  end if
end
;

create procedure DBA.ASQLUpdateLeaveDeductionRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_NPL_CurrentDayRate double,
in In_NPL_CurrentHourRate double,
in In_NPL_PreviousDayRate double,
in In_NPL_PreviousHourRate double,
in In_Absent_CurrentDayRate double,
in In_Absent_PreviousDayRate double,
in In_Late_CurrentHourRate double,
in In_Late_PreviousHourRate double)
begin
  update LeaveDeductionRecord set
    CurrentDayRateAmt = In_NPL_CurrentDayRate,
    CurrentHourRateAmt = In_NPL_CurrentHourRate,
    PreviousDayRateAmt = In_NPL_PreviousDayRate,
    PreviousHourRateAmt = In_NPL_PreviousHourRate where
    LeaveTypeFunctCode = 'NPL' and
    EmployeeSysid = In_employeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  update LeaveDeductionRecord set
    CurrentDayRateAmt = 0,
    CurrentHourRateAmt = In_Late_CurrentHourRate,
    PreviousDayRateAmt = 0,
    PreviousHourRateAmt = In_Late_PreviousHourRate where
    LeaveTypeFunctCode = 'Late' and
    EmployeeSysid = In_employeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  update LeaveDeductionRecord set
    CurrentDayRateAmt = In_Absent_CurrentDayRate,
    CurrentHourRateAmt = 0,
    PreviousDayRateAmt = In_Absent_PreviousDayRate,
    PreviousHourRateAmt = 0 where
    LeaveTypeFunctCode = 'Absent' and
    EmployeeSysid = In_employeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  commit work
end
;

create procedure DBA.ASQLUpdateOTRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SubPeriodEndDate date,
in In_BackPayDayRate double,
in In_BackPayHourRate double)
begin
  declare In_CalOTDayRate double;
  declare In_CalOTHourRate double;
  declare In_CalOTLastDayRate double;
  declare In_CalOTLastHourRate double;
  declare In_OTType char(20);
  declare In_FormulaExRateId char(20);
  declare In_OTRate double;
  declare In_MaxFreq double;
  declare In_MaxRateAmt double;
  declare In_MinRateAmt double;
  declare In_ForeignLocalRate double;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBOTDecimal(*);
  /*
  Get the Day and Hour Rate Amount from Sub Period Setting  
  */
  select CurrentOTDayRateAmt,CurrentOTHourRateAmt,LastOTDayRateAmt,LastOTHourRateAmt into In_CalOTDayRate,
    In_CalOTHourRate,In_CalOTLastDayRate,In_CalOTLastHourRate from SubPeriodSetting where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    EmployeeSysId = In_EmployeeSysId;
  /*
  Update the Rate Amount for each OT Record
  */
  CreateOTRecLoop: for CreateOTRecFor as curs dynamic scroll cursor for
    select OTFormulaId as In_OTRateId,
      CurrentOTRate as In_CurrentOTRate,
      LastOTRate as In_LastOTRate,
      BackPayOTRate as In_BackPayOTRate from
      OTRecord where
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      EmployeeSysId = In_EmployeeSysId do
    /*
    Get the Setup
    */
    select FormulaSubCategory,FormulaExRateId into In_OTType,In_FormulaExRateId from Formula where FormulaId = In_OTRateId;
    select Constant1,Constant2,Constant3,Constant4 into In_OTRate,In_MaxFreq,In_MinRateAmt,
      In_MaxRateAmt from Formula join FormulaRange where Formula.FormulaId = In_OTRateId;
    if(In_FormulaExRateId <> '') then
      select first ForeignLocalRate into In_ForeignLocalRate
        from ExchangeRateProg where ExchangeRateId = In_FormulaExRateId and ExChgRateEffectiveDate <= In_SubPeriodEndDate order by
        ExChgRateEffectiveDate desc
    else
      set In_ForeignLocalRate=1
    end if;
    /*   
    Day Rate
    */
    if(In_OTType = 'OTDayRate') then
      set In_CurrentOTRate=Round(cast(In_OTRate*In_CalOTDayRate as MONEY),In_DecimalPlace);
      set In_LastOTRate=Round(cast(In_OTRate*In_CalOTLastDayRate as MONEY),In_DecimalPlace);
      set In_BackPayOTRate=Round(cast(In_OTRate*In_BackPayDayRate as MONEY),In_DecimalPlace);
      if(In_CurrentOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_CurrentOTRate=In_MaxRateAmt
      end if;
      if(In_CurrentOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_CurrentOTRate=In_MinRateAmt
      end if;
      if(In_LastOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_LastOTRate=In_MaxRateAmt
      end if;
      if(In_LastOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_LastOTRate=In_MinRateAmt
      end if;
      if(In_BackPayOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_BackPayOTRate=In_MaxRateAmt
      end if;
      if(In_BackPayOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_BackPayOTRate=In_MinRateAmt
      end if;
      update OTRecord set
        OTRate = In_OTRate,
        MaxFreq = In_MaxFreq,
        CurrentOTRate = In_CurrentOTRate,
        LastOTRate = In_LastOTRate,
        BackPayOTRate = In_BackPayOTRate where current of curs
    /*
    Fixed Rate
    */
    elseif(In_OTType = 'OTFixedRate') then
      set In_CurrentOTRate=In_OTRate;
      update OTRecord set
        OTRate = In_OTRate,
        MaxFreq = In_MaxFreq,
        CurrentOTRate = In_CurrentOTRate,
        OTExRateId = In_FormulaExRateId,
        OTExRate = In_ForeignLocalRate where current of curs
    /*
    Hour Rate
    */
    elseif(In_OTType = 'OTHourRate') then
      set In_CurrentOTRate=Round(cast(In_OTRate*In_CalOTHourRate as MONEY),In_DecimalPlace);
      set In_LastOTRate=Round(cast(In_OTRate*In_CalOTLastHourRate as MONEY),In_DecimalPlace);
      set In_BackPayOTRate=Round(cast(In_OTRate*In_BackPayHourRate as MONEY),In_DecimalPlace);
      if(In_CurrentOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_CurrentOTRate=In_MaxRateAmt
      end if;
      if(In_CurrentOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_CurrentOTRate=In_MinRateAmt
      end if;
      if(In_LastOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_LastOTRate=In_MaxRateAmt
      end if;
      if(In_LastOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_LastOTRate=In_MinRateAmt
      end if;
      if(In_BackPayOTRate > In_MaxRateAmt and In_MaxRateAmt <> 0) then
        set In_BackPayOTRate=In_MaxRateAmt
      end if;
      if(In_BackPayOTRate < In_MinRateAmt and In_MinRateAmt <> 0) then
        set In_BackPayOTRate=In_MinRateAmt
      end if;
      update OTRecord set
        OTRate = In_OTRate,
        MaxFreq = In_MaxFreq,
        CurrentOTRate = In_CurrentOTRate,
        LastOTRate = In_LastOTRate,
        BackPayOTRate = In_BackPayOTRate where current of curs
    end if end for;
  commit work
end
;

create procedure dba.ASQLUpdateShiftRecord(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SubPeriodEndDate date)
begin
  declare In_ShiftRate double;
  declare In_FormulaExRateId char(20);
  declare In_ForeignLocalRate double;
  CreateShiftRecLoop: for UpdateShiftRecFor as curs dynamic scroll cursor for
    select ShiftFormulaId from
      ShiftRecord where
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      EmployeeSysId = In_EmployeeSysId do
    /*
    Get the Setup
    */
    select Constant1,FormulaExRateId into In_ShiftRate,In_FormulaExRateId from Formula join FormulaRange where Formula.FormulaId = ShiftFormulaId;
    if(In_FormulaExRateId <> '') then
      select first ForeignLocalRate into In_ForeignLocalRate
        from ExchangeRateProg where ExchangeRateId = In_FormulaExRateId and ExChgRateEffectiveDate <= In_SubPeriodEndDate order by
        ExChgRateEffectiveDate desc
    else
      set In_ForeignLocalRate=1
    end if;
    update ShiftRecord set
      ShiftRate = In_ShiftRate,
      ShiftExRateId = In_FormulaExRateId,
      ShiftExRate = In_ForeignLocalRate where current of curs end for;
  commit work
end
;

create procedure dba.DeleteAllowanceHistoryRecord(
in In_AllowanceSGSPGenId char(30))
begin
  if exists(select* from AllowanceHistoryRecord where
      AllowanceHistoryRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    delete from AllowanceHistoryRecord where
      AllowanceHistoryRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId;
    commit work
  end if
end
;

create procedure dba.DeleteAllowanceRecord(
in In_AllowanceSGSPGenId char(30))
begin
  if exists(select* from AllowanceRecord where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    call DeleteAllowanceHistoryRecord(In_AllowanceSGSPGenId);
    if FGetDBCountry(*) = 'Philippines' then
      delete from PhTaxATC where PhTaxATCSGSPGenId = In_AllowanceSGSPGenId
    end if;
    delete from AllowanceRecord where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId;
    commit work
  end if
end
;

create procedure dba.DeleteBalPayElement(
in In_EmployeeSysId char(20),
in in_FormulaId char(20))
begin
  if exists(select* from BalancePayElement where
      FormulaId = In_FormulaId and
      EmployeeSysId = In_EmployeeSysId) then
    delete from BalancePayElement where
      FormulaId = In_FormulaId and
      EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteBalPayElementId(
in In_EmployeeSysId char(20))
begin
  if exists(select* from BalancePayElement where
      EmployeeSysId = In_EmployeeSysId) then
    delete from BalancePayElement where
      EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteBankFilter(
in In_BankFilterId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from BankFilter where BankFilterId = In_BankFilterId) then
    delete from BankFilterItem where BankFilterId = In_BankFilterId;
    delete from BankFilter where BankFilterId = In_BankFilterId;
    commit work;
    if exists(select* from BankFilter where BankFilterId = In_BankFilterId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteBankRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentBankCode char(20),
in In_PaymentBankBrCode char(20),
in In_PaymentBankAccNo char(20))
begin
  if exists(select* from BankRecord where
      BankRecord.EmployeeSysId = In_EmployeeSysId and
      BankRecord.PayRecYear = In_PayRecYear and
      BankRecord.PayRecPeriod = In_PayRecPeriod and
      BankRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BankRecord.PayRecID = In_PayRecID and
      BankRecord.PaymentBankCode = In_PaymentBankCode and
      BankRecord.PaymentBankBrCode = In_PaymentBankBrCode and
      BankRecord.PaymentBankAccNo = In_PaymentBankAccNo) then
    delete from BankRecord where
      BankRecord.EmployeeSysId = In_EmployeeSysId and
      BankRecord.PayRecYear = In_PayRecYear and
      BankRecord.PayRecPeriod = In_PayRecPeriod and
      BankRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BankRecord.PayRecID = In_PayRecID and
      BankRecord.PaymentBankCode = In_PaymentBankCode and
      BankRecord.PaymentBankBrCode = In_PaymentBankBrCode and
      BankRecord.PaymentBankAccNo = In_PaymentBankAccNo;
    commit work
  end if
end
;

create procedure DBA.DeleteBasicRatePolicyProgressionRec(
in In_EmployeeSysId integer,
in In_BRProgDate date)
begin
  call DeletePolicyProgressionRec(In_EmployeeSysId,In_BRProgDate);
  call DeleteBasicRateProgressionRec(In_EmployeeSysId,In_BRProgDate)
end
;

create procedure DBA.DeleteBasicRateProgression(
in In_EmployeeSysId integer)
begin
  if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from BasicRateProgression where
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteBasicRateProgressionRec(
in In_EmployeeSysId integer,
in In_BRProgDate date)
begin
  if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
      BasicRateProgression.BRProgDate = In_BRProgDate) then
    delete from BasicRateProgression where
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
      BasicRateProgression.BRProgDate = In_BRProgDate;
    commit work
  end if
end
;

create procedure DBA.DeleteBonusProcess(
in In_BonusReportId char(20))
begin
  if exists(select* from BonusProcess where BonusProcess.BonusReportId = In_BonusReportId) then
    delete from BonusProcess where
      BonusProcess.BonusReportId = In_BonusReportId;
    commit work
  end if
end
;

create procedure dba.DeleteBonusRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from BonusRecord where
      BonusRecord.EmployeeSysId = In_EmployeeSysId and
      BonusRecord.PayRecYear = In_PayRecYear and
      BonusRecord.PayRecPeriod = In_PayRecPeriod and
      BonusRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BonusRecord.PayRecID = In_PayRecID) then
    delete from BonusRecord where
      BonusRecord.EmployeeSysId = In_EmployeeSysId and
      BonusRecord.PayRecYear = In_PayRecYear and
      BonusRecord.PayRecPeriod = In_PayRecPeriod and
      BonusRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BonusRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure DBA.DeleteBonusReport(
in In_BonusReportId char(20))
begin
  if exists(select* from BonusReport where BonusReport.BonusReportId = In_BonusReportId) then
    delete from BonusReport where
      BonusReport.BonusReportId = In_BonusReportId;
    commit work
  end if
end
;

create procedure DBA.DeleteBonusReportRec(
in In_BonusReportId char(20),
in In_BonusEmployeeSysId integer)
begin
  if exists(select* from BonusReport where BonusReport.BonusReportId = In_BonusReportId and
      BonusReport.BonusEmployeeSysId = In_BonusEmployeeSysId) then
    delete from BonusReport where
      BonusReport.BonusReportId = In_BonusReportId and
      BonusReport.BonusEmployeeSysId = In_BonusEmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCareer(
in In_CareerId char(20))
begin
  if exists(select* from Career where CareerId = In_CareerId) then
    delete from Career where
      CareerId = In_CareerId;
    commit work
  end if
end
;

create procedure dba.DeleteCPFAgeGroup(
in In_AgeGroupId char(20))
begin
  if exists(select* from CPFAgeGroup where
      CPFAgeGroup.AgeGroupId = In_AgeGroupId) then
    delete from CPFAgeGroup where
      CPFAgeGroup.AgeGroupId = In_AgeGroupId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date)
begin
  if exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate) then
    delete from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteCPFPayment(
in In_EmployeeSysId integer)
begin
  if exists(select* from CPFPayment where
      CPFPayment.EmployeeSysId = In_EmployeeSysId) then
    delete from CPFPayment where
      CPFPayment.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFPolicy(
in In_CPFPolicyId char(20))
begin
  if exists(select* from CPFPolicy where
      CPFPolicy.CPFPolicyId = In_CPFPolicyId) then
    delete from CPFPolicy where
      CPFPolicy.CPFPolicyId = In_CPFPolicyId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFPolicyMember(
in In_CPFPolicyId char(20),
in In_CPFTableCodeId char(20))
begin
  if exists(select* from CPFPolicyMember where
      CPFPolicyMember.CPFPolicyId = In_CPFPolicyId and
      CPFPolicyMember.CPFTableCodeId = In_CPFTableCodeId) then
    delete from CPFPolicyMember where
      CPFPolicyMember.CPFPolicyId = In_CPFPolicyId and
      CPFPolicyMember.CPFTableCodeId = In_CPFTableCodeId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFPolicyMemberById(
in In_CPFPolicyId char(20))
begin
  if exists(select* from CPFPolicyMember where
      CPFPolicyMember.CPFPolicyId = In_CPFPolicyId) then
    delete from CPFPolicyMember where
      CPFPolicyMember.CPFPolicyId = In_CPFPolicyId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFProgression(
in In_EmployeeSysId integer)
begin
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from CPFProgression where
      CPFProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteCPFProgressionRec(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date)
begin
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    delete from CPFProgression where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteCPFSalaryGroup(
in In_SalaryGroupId char(20))
begin
  if exists(select* from CPFSalaryGroup where
      CPFSalaryGroup.SalaryGroupId = In_SalaryGroupId) then
    delete from CPFSalaryGroup where
      CPFSalaryGroup.SalaryGroupId = In_SalaryGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteCPFTableCode(
in In_CPFTableCodeId char(20))
begin
  if not exists(select* from CPFPolicyMember where CPFTableCodeId = In_CPFTableCodeId) then
    if exists(select* from CPFTableCode where
        CPFTableCode.CPFTableCodeId = In_CPFTableCodeId) then
      DeleteCPFTableComponentLoop: for DeleCPFRecFor as curs dynamic scroll cursor for
        select CPFTableCodeId,MinSalary,MinCPFAge from CPFTableComponent where
          CPFTableCodeId = In_CPFTableCodeId do
        call DeleteCPFTableComponent(CPFTableCodeId,MinSalary,MinCPFAge) end for;
      delete from CPFTableCode where
        CPFTableCode.CPFTableCodeId = In_CPFTableCodeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCPFTableComponent(
in In_CPFTableCodeId char(20),
in In_MinSalary double,
in In_MinCPFAge double)
begin
  declare In_EEOrdCPFFormula char(20);
  declare In_EROrdCPFFormula char(20);
  declare In_EEAddCPFFormula char(20);
  declare In_ERAddCPFFormula char(20);
  if exists(select* from CPFTableComponent where
      CPFTableComponent.CPFTableCodeId = In_CPFTableCodeId and
      CPFTableComponent.MinSalary = In_MinSalary and
      CPFTableComponent.MinCPFAge = In_MinCPFAge) then
    select EEOrdCPFFormula,
      EROrdCPFFormula,
      EEAddCPFFormula,
      ERAddCPFFormula into In_EEOrdCPFFormula,
      In_EROrdCPFFormula,
      In_EEAddCPFFormula,
      In_ERAddCPFFormula from CPFTableComponent where
      CPFTableCodeId = In_CPFTableCodeId and
      MinSalary = In_MinSalary and
      MinCPFAge = In_MinCPFAge;
    call DeleteFormulaRangeById(In_EEOrdCPFFormula);
    call DeleteFormulaRangeById(In_EROrdCPFFormula);
    call DeleteFormulaRangeById(In_EEAddCPFFormula);
    call DeleteFormulaRangeById(In_ERAddCPFFormula);
    call DeleteFormula(In_EEOrdCPFFormula);
    call DeleteFormula(In_EROrdCPFFormula);
    call DeleteFormula(In_EEAddCPFFormula);
    call DeleteFormula(In_ERAddCPFFormula);
    delete from CPFTableComponent where
      CPFTableComponent.CPFTableCodeId = In_CPFTableCodeId and
      CPFTableComponent.MinSalary = In_MinSalary and
      CPFTableComponent.MinCPFAge = In_MinCPFAge;
    commit work
  end if
end
;

create procedure dba.DeleteDefaultCPFPayment(
in In_PayGroupId char(20),
in In_DefaultCPFPaymentSubPeriod integer)
begin
  if exists(select* from DefaultCPFPayment where DefaultCPFPayment.PayGroupId = In_PayGroupId and
      DefaultCPFPayment.DefaultCPFPaymentSubPeriod = In_DefaultCPFPaymentSubPeriod) then
    delete from DefaultCPFPayment where
      DefaultCPFPayment.PayGroupId = In_PayGroupId and
      DefaultCPFPayment.DefaultCPFPaymentSubPeriod = In_DefaultCPFPaymentSubPeriod;
    commit work
  end if
end
;

create procedure dba.DeleteDefaultCPFPaymentGrp(
in In_PayGroupId char(20))
begin
  if exists(select* from DefaultCPFPayment where DefaultCPFPayment.PayGroupId = In_PayGroupId) then
    delete from DefaultCPFPayment where
      DefaultCPFPayment.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteDefaultPayAllocation(
in In_PayGroupId char(20),
in In_DefaultPayAllocSubPeriod integer,
in In_DefaultPayBasicRateType char(20))
begin
  if exists(select* from DefaultPayAllocation where DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod and
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType) then
    delete from DefaultPayAllocation where
      DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod and
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType;
    commit work
  end if
end
;

create procedure dba.DeleteDefaultPayAllocationGrp(
in In_PayGroupId char(20))
begin
  if exists(select* from DefaultPayAllocation where
      DefaultPayAllocation.PayGroupId = In_PayGroupId) then
    delete from DefaultPayAllocation where
      DefaultPayAllocation.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteDetailRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from OTRecord where
      DetailRecord.EmployeeSysId = In_EmployeeSysId and
      DetailRecord.PayRecYear = In_PayRecYear and
      DetailRecord.PayRecPeriod = In_PayRecPeriod and
      DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      DetailRecord.PayRecID = In_PayRecID) then
    delete from DetailRecord where
      DetailRecord.EmployeeSysId = In_EmployeeSysId and
      DetailRecord.PayRecYear = In_PayRecYear and
      DetailRecord.PayRecPeriod = In_PayRecPeriod and
      DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      DetailRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure DBA.DeleteEmployPassProgression(
in In_EmployeeSysId integer,
in In_EPEffectiveDate date)
begin
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate) then
    delete from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteEmpRecurAllow(
in In_RecurAlloSGSPGenId char(30))
/* RESULT ( column-name,... ) */
begin
  if exists(select* from EmployeeRecurAllowance where
      EmployeeRecurAllowance.RecurAlloSGSPGenId = In_RecurAlloSGSPGenId) then
    delete from EmployeeRecurAllowance where
      EmployeeRecurAllowance.RecurAlloSGSPGenId = In_RecurAlloSGSPGenId;
    commit work
  end if
end
;

create procedure DBA.DeleteEPByEmpSysId(
in In_EmployeeSysId integer)
begin
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteFormula(
in In_FormulaId char(20))
begin
  if exists(select* from Formula where
      Formula.FormulaId = In_FormulaId) then
    delete from FormulaProperty where
      FormulaProperty.FormulaId = In_FormulaId;
    delete from Formula where
      Formula.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteFormulaProperty(
in In_KeyWordId char(20),
in In_FormulaId char(20))
begin
  if exists(select* from FormulaProperty where
      FormulaProperty.KeyWordId = In_KeyWordId and
      FormulaProperty.FormulaId = In_FormulaId) then
    delete from FormulaProperty where
      FormulaProperty.KeyWordId = In_KeyWordId and
      FormulaProperty.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteFormulaPropertyById(
in In_FormulaId char(20))
begin
  if exists(select* from FormulaProperty where
      FormulaProperty.FormulaId = In_FormulaId) then
    delete from FormulaProperty where
      FormulaProperty.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteFormulaRange(
in In_FormulaRangeId integer,
in In_FormulaId char(20))
begin
  if exists(select* from FormulaRange where
      FormulaRange.FormulaId = In_FormulaId and
      FormulaRange.FormulaRangeId = In_FormulaRangeId) then
    delete from FormulaRange where
      FormulaRange.FormulaId = In_FormulaId and
      FormulaRange.FormulaRangeId = In_FormulaRangeId;
    commit work
  end if
end
;

create procedure dba.DeleteFormulaRangeById(
in In_FormulaId char(20))
begin
  if exists(select* from FormulaRange where
      FormulaRange.FormulaId = In_FormulaId) then
    delete from FormulaRange where
      FormulaRange.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteFWLProgression(
in In_EmployeeSysId integer,
in In_FWLEffectiveDate date)
begin
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate) then
    delete from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteKeyWord(
in In_KeyWordId char(20))
begin
  if exists(select* from KeyWord where
      KeyWord.KeyWordId = In_KeyWordId) then
    delete from KeyWord where
      KeyWord.KeyWordId = In_KeywordId;
    commit work
  end if
end
;

create procedure dba.DeleteLicenseRecord(
in In_ProductName char(100),
in In_SubProductName char(100))
begin
  if exists(select* from LicenseRecord where LicenseRecord.ProductName = In_ProductName and
      LicenseRecord.SubProductName = In_SubProductName) then
    delete from LicenseRecord where
      LicenseRecord.ProductName = In_ProductName and
      LicenseRecord.SubProductName = In_SubProductName;
    commit work
  end if
end
;

create procedure dba.DeleteOTMember(
in In_OTTableId char(20))
begin
  if exists(select* from OTMember where
      OTMember.OTTableId = In_OTTableId) then
    delete from OTMember where
      OTMember.OTTableId = In_OTTableId;
    commit work
  end if
end
;

create procedure dba.DeleteOTRecord(
in In_EmployeeSysId integer,
in In_OTFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from OTRecord where
      OTRecord.EmployeeSysId = In_EmployeeSysId and
      OTRecord.OTFormulaId = In_OTFormulaId and
      OTRecord.PayRecYear = In_PayRecYear and
      OTRecord.PayRecPeriod = In_PayRecPeriod and
      OTRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      OTRecord.PayRecID = In_PayRecID) then
    delete from OTRecord where
      OTRecord.EmployeeSysId = In_EmployeeSysId and
      OTRecord.OTFormulaId = In_OTFormulaId and
      OTRecord.PayRecYear = In_PayRecYear and
      OTRecord.PayRecPeriod = In_PayRecPeriod and
      OTRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      OTRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure dba.DeleteOverTime(
in In_OTTableId char(20))
begin
  if not exists(select* from PayEmployee where PayEmployee.OTTableId = In_OTTableId) then
    if exists(select* from OverTime where
        OverTime.OTTableId = In_OTTableId) then
      delete from OverTime where
        OverTime.OTTableId = In_OTTableId;
      commit work
    end if
  end if
end
;

create procedure dba.DeletePayAllocation(
in In_EmployeeSysId integer)
begin
  if exists(select* from PayAllocation where
      PayAllocation.EmployeeSysId = In_EmployeeSysId) then
    delete from PayAllocation where
      PayAllocation.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeletePayEmployee(
in In_EmployeeSysId integer)
begin
  if exists(select* from PayEmployee where PayEmployee.EmployeeSysId = In_EmployeeSysId) then
    delete from PayEmployee where
      PayEmployee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeletePayEmployeePolicy(
in In_EmployeeSysId integer)
begin
  if exists(select* from PayEmployeePolicy where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId) then
    delete from PayEmployeePolicy where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeletePayGroup(
in In_PayGroupId char(20))
begin
  if exists(select* from PayGroup where PayGroup.PayGroupId = In_PayGroupId) then
    if exists(select* from PeriodMessage where PeriodMessage.PayGroupId = In_PayGroupId) then
      delete from PeriodMessage where
        PeriodMessage.PayGroupId = In_PayGroupId
    end if;
    delete from PayGroup where
      PayGroup.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.DeletePayGroupGrp(
in In_PayGroupId char(20))
begin
  call DeleteLeaveCutOffDateGrp(In_PayGroupId);
  call DeleteSubPeriodTemplateGrp(In_PayGroupId);
  call DeleteDefaultCPFPaymentGrp(In_PayGroupId);
  call DeleteDefaultPayAllocationGrp(In_PayGroupId);
  call DeletePayGroupPeriodGrp(In_PayGroupId);
  call DeletePayGroup(In_PayGroupId)
end
;

create procedure dba.DeletePayGroupPeriod(
in In_PayGroupId char(20),
in In_PayGroupYear integer,
in In_PayGroupPeriod integer,
in In_PayGroupSubPeriod integer)
begin
  if exists(select* from PayGroupPeriod where
      PayGroupPeriod.PayGroupId = In_PayGroupId and
      PayGroupPeriod.PayGroupYear = In_PayGroupYear and
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod and
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod) then
    delete from PayGroupPeriod where
      PayGroupPeriod.PayGroupId = In_PayGroupId and
      PayGroupPeriod.PayGroupYear = In_PayGroupYear and
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod and
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod;
    commit work
  end if
end
;

create procedure dba.DeletePayGroupPeriodGrp(
in In_PayGroupId char(20))
begin
  if exists(select* from PayGroupPeriod where
      PayGroupPeriod.PayGroupId = In_PayGroupId) then
    delete from PayGroupPeriod where
      PayGroupPeriod.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.DeletePayLeaveSetting(
in In_EmployeeSysId integer)
begin
  if exists(select* from PayLeaveSetting where
      PayLeaveSetting.EmployeeSysId = In_EmployeeSysId) then
    delete from PayLeaveSetting where
      PayLeaveSetting.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeletePayPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  if exists(select* from PayPeriodRecord where
      PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      PayPeriodRecord.PayRecYear = In_PayRecYear and
      PayPeriodRecord.PayRecPeriod = In_PayRecPeriod) then
    delete from PayPeriodRecord where
      PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      PayPeriodRecord.PayRecYear = In_PayRecYear and
      PayPeriodRecord.PayRecPeriod = In_PayRecPeriod;
    commit work
  end if
end
;

create procedure dba.DeletePayRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from PayRecord where
      PayRecord.EmployeeSysId = In_EmployeeSysId and
      PayRecord.PayRecYear = In_PayRecYear and
      PayRecord.PayRecPeriod = In_PayRecPeriod and
      PayRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecord.PayRecID = In_PayRecID) then
    delete from PayRecord where
      PayRecord.EmployeeSysId = In_EmployeeSysId and
      PayRecord.PayRecYear = In_PayRecYear and
      PayRecord.PayRecPeriod = In_PayRecPeriod and
      PayRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure dba.DeletePeriodEEHistory(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  if exists(select* from PeriodEEHistory where
      PeriodEEHistory.EmployeeSysId = In_EmployeeSysId and
      PeriodEEHistory.PayRecYear = In_PayRecYear and
      PeriodEEHistory.PayRecPeriod = In_PayRecPeriod) then
    delete from PeriodEEHistory where
      PeriodEEHistory.EmployeeSysId = In_EmployeeSysId and
      PeriodEEHistory.PayRecYear = In_PayRecYear and
      PeriodEEHistory.PayRecPeriod = In_PayRecPeriod;
    commit work
  end if
end
;

create procedure dba.DeletePeriodMessage(
in In_PayGroupId char(20),
in In_PeriodId integer,
in In_PeriodIdType char(20))
begin
  if exists(select* from PeriodMessage where
      PeriodMessage.PayGroupId = In_PayGroupId and
      PeriodMessage.PeriodId = In_PeriodId and
      PeriodMessage.PeriodIdType = In_PeriodIdType) then
    delete from PeriodMessage where
      PeriodMessage.PayGroupId = In_PayGroupId and
      PeriodMessage.PeriodId = In_PeriodId and
      PeriodMessage.PeriodIdType = In_PeriodIdType;
    commit work
  end if
end
;

create procedure dba.DeletePeriodPolicySetting(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  if exists(select* from PeriodPolicySetting where
      PeriodPolicySetting.EmployeeSysId = In_EmployeeSysId and
      PeriodPolicySetting.PayRecYear = In_PayRecYear and
      PeriodPolicySetting.PayRecPeriod = In_PayRecPeriod) then
    delete from PeriodPolicySetting where
      PeriodPolicySetting.EmployeeSysId = In_EmployeeSysId and
      PeriodPolicySetting.PayRecYear = In_PayRecYear and
      PeriodPolicySetting.PayRecPeriod = In_PayRecPeriod;
    commit work
  end if
end
;

create procedure dba.DeletePeriodPolicySummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
begin
  if exists(select* from PeriodPolicySummary where
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId and
      PeriodPolicySummary.PayRecYear = In_PayRecYear and
      PeriodPolicySummary.PayRecPeriod = In_PayRecPeriod) then
    delete from PeriodPolicySummary where
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId and
      PeriodPolicySummary.PayRecYear = In_PayRecYear and
      PeriodPolicySummary.PayRecPeriod = In_PayRecPeriod;
    commit work
  end if
end
;

create procedure DBA.DeletePolicyProgression(
in In_EmployeeSysId integer)
begin
  if exists(select* from PolicyProgression where PolicyProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from PolicyProgression where
      PolicyProgression.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.DeletePolicyProgressionRec(
in In_EmployeeSysId integer,
in In_BRProgDate date)
begin
  if exists(select* from PolicyProgression where PolicyProgression.EmployeeSysId = In_EmployeeSysId and
      PolicyProgression.BRProgDate = In_BRProgDate) then
    delete from PolicyProgression where
      PolicyProgression.EmployeeSysId = In_EmployeeSysId and
      PolicyProgression.BRProgDate = In_BRProgDate;
    commit work
  end if
end
;

create procedure dba.DeletePolicyRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from PolicyRecord where
      PolicyRecord.EmployeeSysId = In_EmployeeSysId and
      PolicyRecord.PayRecYear = In_PayRecYear and
      PolicyRecord.PayRecPeriod = In_PayRecPeriod and
      PolicyRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PolicyRecord.PayRecID = In_PayRecID) then
    delete from PolicyRecord where
      PolicyRecord.EmployeeSysId = In_EmployeeSysId and
      PolicyRecord.PayRecYear = In_PayRecYear and
      PolicyRecord.PayRecPeriod = In_PayRecPeriod and
      PolicyRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PolicyRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure DBA.DeleteRegistry(
in In_RegistryId char(20))
begin
  if exists(select* from Registry where Registry.RegistryId = In_RegistryId) then
    delete from Registry where
      Registry.RegistryId = In_RegistryId;
    commit work
  end if
end
;

create procedure DBA.DeleteResStatusRecordBySysId(
in In_PersonalSysId integer)
begin
  delete from ResidenceStatusRecord where
    ResidenceStatusRecord.PersonalSysId = In_PersonalSysId;
  commit work
end
;

create procedure dba.DeleteSDFProgression(
in In_SDFEffectiveDate date)
begin
  if exists(select* from SDFProgression where
      SDFProgression.SDFEffectiveDate = In_SDFEffectiveDate) then
    delete from SDFProgression where
      SDFProgression.SDFEffectiveDate = In_SDFEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteShift(
in In_ShiftTableId char(20))
begin
  if not exists(select* from PayEmployee where PayEmployee.ShiftTableId = In_ShiftTableId) then
    if exists(select* from Shift where Shift.ShiftTableId = In_ShiftTableId) then
      delete from Shift where
        Shift.ShiftTableId = In_ShiftTableId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteShiftMember(
in In_ShiftTableId char(20),
in In_FormulaId char(20))
begin
  if exists(select* from ShiftMember where
      ShiftMember.ShiftTableId = In_ShiftTableId and
      ShiftMember.FormulaId = In_FormulaId) then
    delete from ShiftMember where
      ShiftMember.ShiftTableId = In_ShiftTableId and
      ShiftMember.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteShiftMemberByShiftId(
in In_ShiftTableId char(20))
begin
  if exists(select* from ShiftMember where
      ShiftMember.ShiftTableId = In_ShiftTableId) then
    delete from ShiftMember where
      ShiftMember.ShiftTableId = In_ShiftTableId;
    commit work
  end if
end
;

create procedure dba.DeleteShiftRecord(
in In_EmployeeSysId integer,
in In_ShiftFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  if exists(select* from ShiftRecord where
      ShiftRecord.EmployeeSysId = In_EmployeeSysId and
      ShiftRecord.ShiftFormulaId = In_ShiftFormulaId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecID = In_PayRecID) then
    delete from ShiftRecord where
      ShiftRecord.EmployeeSysId = In_EmployeeSysId and
      ShiftRecord.ShiftFormulaId = In_ShiftFormulaId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecID = In_PayRecID;
    commit work
  end if
end
;

create procedure dba.DeleteSubPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  if exists(select* from PayPeriodRecord where
      SubPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      SubPeriodRecord.PayRecYear = In_PayRecYear and
      SubPeriodRecord.PayRecPeriod = In_PayRecPeriod and
      SubPeriodRecord.PayRecSubPeriod = In_PayRecSubPeriod) then
    delete from PayPeriodRecord where
      SubPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      SubPeriodRecord.PayRecYear = In_PayRecYear and
      SubPeriodRecord.PayRecPeriod = In_PayRecPeriod and
      SubPeriodRecord.PayRecSubPeriod = In_PayRecSubPeriod;
    commit work
  end if
end
;

create procedure dba.DeleteSubPeriodSetting(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
begin
  if exists(select* from SubPeriodSetting where
      SubPeriodSetting.EmployeeSysId = In_EmployeeSysId and
      SubPeriodSetting.PayRecYear = In_PayRecYear and
      SubPeriodSetting.PayRecPeriod = In_PayRecPeriod and
      SubPeriodSetting.PayRecSubPeriod = In_PayRecSubPeriod) then
    delete from SubPeriodSetting where
      SubPeriodSetting.EmployeeSysId = In_EmployeeSysId and
      SubPeriodSetting.PayRecYear = In_PayRecYear and
      SubPeriodSetting.PayRecPeriod = In_PayRecPeriod and
      SubPeriodSetting.PayRecSubPeriod = In_PayRecSubPeriod;
    commit work
  end if
end
;

create procedure dba.DeleteSubPeriodTemplate(
in In_PayGroupId char(20),
in In_SubPeriod integer)
begin
  if exists(select* from LeaveCutOffDate where
      LeaveCutOffDate.PayGroupId = In_PayGroupId and
      LeaveCutOffDate.SubPeriod = In_SubPeriod) then
    call DeleteLeaveCutOffDateSubPeriod(In_PayGroupId,In_SubPeriod)
  end if;
  if exists(select* from SubPeriodTemplate where SubPeriodTemplate.PayGroupId = In_PayGroupId and
      SubPeriodTemplate.SubPeriod = In_SubPeriod) then
    delete from SubPeriodTemplate where
      SubPeriodTemplate.PayGroupId = In_PayGroupId and
      SubPeriodTemplate.SubPeriod = In_SubPeriod;
    commit work
  end if
end
;

create procedure dba.DeleteSubPeriodTemplateGrp(
in In_PayGroupId char(20))
begin
  if exists(select* from SubPeriodTemplate where
      SubPeriodTemplate.PayGroupId = In_PayGroupId) then
    delete from SubPeriodTemplate where
      SubPeriodTemplate.PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure DBA.DeleteSubRegistry(
in In_RegistryId char(20),
in In_SubRegistryId char(20))
begin
  if exists(select* from SubRegistry where SubRegistry.RegistryId = In_RegistryId and
      SubRegistry.SubRegistryId = In_SubRegistryId) then
    delete from SubRegistry where
      SubRegistry.RegistryId = In_RegistryId and
      SubRegistry.SubRegistryId = In_SubRegistryId;
    commit work
  end if
end
;

create procedure dba.DeleteWageProperty(
in In_KeyWordId char(20),
in In_WageId char(20))
begin
  if exists(select* from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId and
      WageProperty.WageId = In_WageId) then
    delete from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId and
      WageProperty.WageId = In_WageId;
    commit work
  end if
end
;

create procedure dba.DeleteWagePropertyById(
in In_KeyWordId char(20))
begin
  if exists(select* from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId) then
    delete from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId;
    commit work
  end if
end
;

create function DBA.FAddZero(
in In_Amount integer,
in In_Length integer,
in In_pos char(1))
returns TEXT
begin
  declare fResult TEXT;
  declare difference integer;
  set difference=In_Length-Length(Trim(in_Amount));
  if In_Pos = 'L' then
    set fResult=Repeat('0',difference)+Trim(in_Amount)
  else if In_Pos = 'R' then
      set fResult=Trim(in_Amount)+Repeat('0',difference)
    end if
  end if;
  return(fResult)
end
;

create function DBA.FCheckIsPaymentBalance(
in In_PayBankSGSPGenId char(20))
returns integer
begin
  declare Type char(20);
  select PaymentType into Type from PaymentBankInfo where PayBankSGSPGenId = In_PayBankSGSPGenId;
  if(Type = 'BankBalance') then
    return 1
  else
    return 0
  end if
end
;

create function DBA.FChkEmpPaymentBankValue(
in In_EmployeeSysId integer,
in In_PayBankSGSPGenId char(20),
in In_PaymentType char(20),
in In_BankAllocGpId char(20))
returns numeric(10,2)
begin
  declare result numeric(10,2);
  select sum(paymentValue) into result from paymentbankinfo where
    employeesysid = In_EmployeeSysId and
    PaymentType = In_PaymentType and
    BankAllocGpId = In_BankAllocGpId and
    PayBankSGSPGenId <> In_PayBankSGSPGenId;
  if(result is null) then
    set result=0
  end if;
  return result
end
;

create function DBA.FClearPaymentBankBalance(
in In_EmployeeSysId integer,
in In_BankAllocGpId char(20))
returns integer
begin
  declare CountBalance integer;
  declare TotalCount integer;
  select count(*) into TotalCount from PaymentBankinfo where
    EmployeeSysId = In_EmployeeSysId and BankAllocGpId = In_BankAllocGpId;
  select count(*) into CountBalance from PaymentBankinfo where
    EmployeeSysId = In_EmployeeSysId and BankAllocGpId = In_BankAllocGpId and
    PaymentType = 'BankBalance';
  if CountBalance = 1 and TotalCount = 1 then
    update PaymentBankinfo set PaymentType = 'BankPercent',PaymentValue = 100 where
      EmployeeSysId = In_EmployeeSysId and BankAllocGpId = In_BankAllocGpId;
    commit work;
    return 1
  end if;
  return 0
end
;

create function DBA.FConvertNRIC(
in In_IdentityNo char(30))
returns char(30)
begin
  declare Out_ConvertedNRIC char(30);
  declare Letter char(2);
  select Upper("right"(In_IdentityNo,1)) into Letter;
  case Letter when 'A' then
    set Letter='.1' when 'B' then
    set Letter='.2' when 'C' then
    set Letter='.3' when 'D' then
    set Letter='.4' when 'E' then
    set Letter='.5' when 'F' then
    set Letter='.6' when 'G' then
    set Letter='.7' when 'H' then
    set Letter='.8' when 'I' then
    set Letter='.9' when 'J' then
    set Letter='.0'
  else
    set Letter='.-'
  end case
  ;
  select SubString(In_IdentityNo,1,Length(In_IdentityNo)-1) into Out_ConvertedNRIC;
  select Out_ConvertedNRIC+Letter into Out_ConvertedNRIC;
  return Out_ConvertedNRIC
end
;

create function dba.FConvertNull(
in in_value double)
returns double
begin
  declare convertedValue double;
  if in_value is null then set convertedValue=0
  else set convertedValue=in_Value
  end if;
  return(convertedValue)
end
;

create function dba.FConvertNullString(
in in_value char(20))
returns char(20)
begin
  declare convertedValue char(20);
  if in_value is null then set convertedValue=''
  else set convertedValue=in_Value
  end if;
  return(convertedValue)
end
;

create function Dba.FCPFAccNumberWithoutDot(
in in_CPFAccNo char(20))
returns char(7)
begin
  declare fResult char(7);
  declare lastDigit char(1);
  declare cpfAccNo char(9);
  declare cpfAccNo_temp char(9);
  if Trim(in_CPFAccNo) <> '' then
    set cpfAccNo=in_CPFAccNo;
    set cpfAccNo_temp=cpfAccNo;
    set lastdigit=SUBSTR(cpfAccNo_temp,8,1);
    set fResult=FSetBlank(SUBSTR(cpfAccNo,1,6)+lastdigit,7,'R')
  else
    set fResult=FSetBlank(' ',7,'R')
  end if;
  return(fResult)
end
;

create function dba.FCPFConvertNegativeToZero(
in In_InputValue double,
in In_ConvertNegativeToZero smallint)
returns double
begin
  declare Out_OutputValue double;
  if(In_ConvertNegativeToZero = 1) then
    if(In_InputValue < 0) then
      set Out_OutputValue=0
    else
      set Out_OutputValue=In_InputValue
    end if
  else
    set Out_OutputValue=In_InputValue
  end if;
  return(Out_OutputValue)
end
;

create function DBA.FDecodeFormula(
in In_FormulaId char(20))
returns char(255)
begin
  declare cont integer;
  declare In_String char(255);
  select Formula into In_String from FormulaRange where FormulaId = In_FormulaId;
  select Upper(In_String) into In_String;
  set cont=1;
  // K10
  while cont = 1 loop
    if(select PATINDEX('%K10%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K10%',In_String)),3,(select FGetKeyWordUserDefinedName(keywords10) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K1
  while cont = 1 loop
    if(select PATINDEX('%K1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K1%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords1) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K2
  while cont = 1 loop
    if(select PATINDEX('%K2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K2%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords2) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K3
  while cont = 1 loop
    if(select PATINDEX('%K3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K3%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords3) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K4
  while cont = 1 loop
    if(select PATINDEX('%K4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K4%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords4) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K5
  while cont = 1 loop
    if(select PATINDEX('%K5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K5%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords5) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K6
  while cont = 1 loop
    if(select PATINDEX('%K6%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K6%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords6) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K7
  while cont = 1 loop
    if(select PATINDEX('%K7%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K7%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords7) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K8
  while cont = 1 loop
    if(select PATINDEX('%K8%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K8%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords8) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K9
  while cont = 1 loop
    if(select PATINDEX('%K9%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K9%',In_String)),2,(select FGetKeyWordUserDefinedName(keywords9) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U1
  while cont = 1 loop
    if(select PATINDEX('%U1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U1%',In_String)),2,(select UserDef1 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U2
  while cont = 1 loop
    if(select PATINDEX('%U2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U2%',In_String)),2,(select UserDef2 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U3
  while cont = 1 loop
    if(select PATINDEX('%U3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U3%',In_String)),2,(select UserDef3 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U4
  while cont = 1 loop
    if(select PATINDEX('%U4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U4%',In_String)),2,(select UserDef4 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U5
  while cont = 1 loop
    if(select PATINDEX('%U5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U5%',In_String)),2,(select UserDef5 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C1
  while cont = 1 loop
    if(select PATINDEX('%C1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C1%',In_String)),2,(select Constant1 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C2
  while cont = 1 loop
    if(select PATINDEX('%C2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C2%',In_String)),2,(select Constant2 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C3
  while cont = 1 loop
    if(select PATINDEX('%C3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C3%',In_String)),2,(select Constant3 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C4
  while cont = 1 loop
    if(select PATINDEX('%C4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C4%',In_String)),2,(select Constant4 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C5
  while cont = 1 loop
    if(select PATINDEX('%C5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C5%',In_String)),2,(select Constant5 from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F1
  while cont = 1 loop
    if(select PATINDEX('%F1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F1%',In_String)),2,(select FGetFormulaDesc(F1) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F2
  while cont = 1 loop
    if(select PATINDEX('%F2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F2%',In_String)),2,(select FGetFormulaDesc(F2) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F3
  while cont = 1 loop
    if(select PATINDEX('%F3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F3%',In_String)),2,(select FGetFormulaDesc(F3) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F4
  while cont = 1 loop
    if(select PATINDEX('%F4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F4%',In_String)),2,(select FGetFormulaDesc(F4) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F5
  while cont = 1 loop
    if(select PATINDEX('%F5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F5%',In_String)),2,(select FGetFormulaDesc(F5) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F6
  while cont = 1 loop
    if(select PATINDEX('%F6%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F6%',In_String)),2,(select FGetFormulaDesc(F6) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F7
  while cont = 1 loop
    if(select PATINDEX('%F7%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F7%',In_String)),2,(select FGetFormulaDesc(F7) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F8
  while cont = 1 loop
    if(select PATINDEX('%F8%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F8%',In_String)),2,(select FGetFormulaDesc(F8) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F9
  while cont = 1 loop
    if(select PATINDEX('%F9%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F9%',In_String)),2,(select FGetFormulaDesc(F9) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // F10
  while cont = 1 loop
    if(select PATINDEX('%F10%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%F10%',In_String)),2,(select FGetFormulaDesc(F10) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  // P1
  while cont = 1 loop
    if(select PATINDEX('%P1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P1%',In_String)),2,(select FGetKeyWordUserDefinedName(P1) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P2
  while cont = 1 loop
    if(select PATINDEX('%P2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P2%',In_String)),2,(select FGetKeyWordUserDefinedName(P2) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P3
  while cont = 1 loop
    if(select PATINDEX('%P3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P3%',In_String)),2,(select FGetKeyWordUserDefinedName(P3) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P4
  while cont = 1 loop
    if(select PATINDEX('%P4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P4%',In_String)),2,(select FGetKeyWordUserDefinedName(P4) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P5
  while cont = 1 loop
    if(select PATINDEX('%P5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P5%',In_String)),2,(select FGetKeyWordUserDefinedName(P5) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P6
  while cont = 1 loop
    if(select PATINDEX('%P6%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P6%',In_String)),2,(select FGetKeyWordUserDefinedName(P6) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P7
  while cont = 1 loop
    if(select PATINDEX('%P7%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P7%',In_String)),2,(select FGetKeyWordUserDefinedName(P7) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P8
  while cont = 1 loop
    if(select PATINDEX('%P8%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P8%',In_String)),2,(select FGetKeyWordUserDefinedName(P8) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P9
  while cont = 1 loop
    if(select PATINDEX('%P9%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P9%',In_String)),2,(select FGetKeyWordUserDefinedName(P9) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // P10
  while cont = 1 loop
    if(select PATINDEX('%P10%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%P10%',In_String)),3,(select FGetKeyWordUserDefinedName(P10) from formularange where formulaid = In_FormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  return(In_String)
end
;

create function DBA.FGetAccumulatedMVCPercent(
in In_EmployeeSysId integer,
in In_CurrentBRProgDate date)
returns double
begin
  declare Out_AccumulatedMVCPercent double;
  select sum(PolicyProgression.MVCPercentage) into Out_AccumulatedMVCPercent
    from PolicyProgression where
    PolicyProgression.EmployeeSysId = In_EmployeeSysId and
    PolicyProgression.BRProgDate <= In_CurrentBRProgDate;
  if(Out_AccumulatedMVCPercent is null) then set Out_AccumulatedMVCPercent=0
  end if;
  return(Out_AccumulatedMVCPercent)
end
;

create function DBA.FGetAllowanceElementYTD(
in In_DepartmentID char(20),
in In_AllowanceFormulaID char(20),
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer)
returns double
begin
  declare fresult double;
  declare YTDamount double;
  declare YTDamountTotal double;
  set YTDamountTotal=0;
  if In_DepartmentID = 'Company' then
    if(YTDFromYear = YTDToYear) then
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        D.PayRecYear = YTDFromYear and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  end if;
  return(fresult)
end
;

create function dba.FGetAllowanceVarianceCount(
in In_EmployeeSysID integer,
in In_YearA integer,
in In_PeriodA integer,
in In_YearB integer,
in In_PeriodB integer,
in In_SubPeriod integer,
in In_PayRecType char(30))
returns integer
begin
  declare Out_AllowanceVarianceCount integer;
  set Out_AllowanceVarianceCount=0;
  if(In_SubPeriod = 0) then
    if(In_PayRecType = 'All') then
      AllowanceVarianceLoopA: for AllowanceVarianceForA as Cur_AllowanceVarianceA dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearA and
            PayRecPeriod = In_PeriodA and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearB and
            PayRecPeriod = In_PeriodB and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          EmployeeSysID = In_EmployeeSysID and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    else
      AllowanceVarianceLoopB: for AllowanceVarianceForB as Cur_AllowanceVarianceB dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearA and
            PayRecPeriod = In_PeriodA and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearB and
            PayRecPeriod = In_PeriodB and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          EmployeeSysID = In_EmployeeSysID and
          AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory,PayRecID order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    end if
  else
    if(In_PayRecType = 'All') then
      AllowanceVarianceLoopC: for AllowanceVarianceForC as Cur_AllowanceVarianceC dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearA and
            PayRecPeriod = In_PeriodA and
            PayRecSubPeriod = In_SubPeriod and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearB and
            PayRecPeriod = In_PeriodB and
            PayRecSubPeriod = In_SubPeriod and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          PayRecSubPeriod = In_SubPeriod and
          EmployeeSysID = In_EmployeeSysID and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    else
      AllowanceVarianceLoopD: for AllowanceVarianceForD as Cur_AllowanceVarianceD dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearA and
            PayRecPeriod = In_PeriodA and
            PayRecSubPeriod = In_SubPeriod and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord where
            PayRecYear = In_YearB and
            PayRecPeriod = In_PeriodB and
            PayRecSubPeriod = In_SubPeriod and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          PayRecSubPeriod = In_SubPeriod and
          EmployeeSysID = In_EmployeeSysID and
          AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory,PayRecID order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    end if
  end if;
  return(Out_AllowanceVarianceCount)
end
;

create function DBA.FGetBackPayOT(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare Out_BackPayOT double;
  select Sum(BackPayOTAmount) into Out_BackPayOT from OTRecord where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId and
    EmployeeSysId = In_EmployeeSysId;
  return(Out_BackPayOT)
end
;

create function DBA.FGetBankCity(
in In_BankId char(20),
in In_BankBranchId char(20)) 
returns char(60)
begin
  declare Out_BankCity char(60);
  select BankBranch.BankCity into Out_BankCity
    from BankBranch where
    BankBranch.BankId = In_BankId and
    BankBranch.BankBranchId = In_BankBranchId;
  return(Out_BankCity)
end
;

create function DBA.FGetBankState(
in In_BankId char(20),
in In_BankBranchId char(20)) 
returns char(60)
begin
  declare Out_BankState char(60);
  select BankBranch.BankState into Out_BankState
    from BankBranch where
    BankBranch.BankId = In_BankId and
    BankBranch.BankBranchId = In_BankBranchId;
  return(Out_BankState)
end
;

create function dba.FGetBankBranchDesc(
in In_BankId char(20),
in In_BankBranchId char(20))
returns char(80)
begin
  declare Out_BankBranchDesc char(80);
  select BankBranch.BankBranchDesc into Out_BankBranchDesc
    from BankBranch where
    BankBranch.BankId = In_BankId and BankBranch.BankBranchId = In_BankBranchId;
  return(Out_BankBranchDesc)
end
;

create function DBA.FGetBankName(
in In_PaymentBankCode char(20))
returns char(100)
begin
  declare Out_BankName char(100);
  select Bank.BankName into Out_BankName
    from Bank where Bank.BankId = In_PaymentBankCode;
  return(Out_BankName)
end
;

create function dba.FGetBranchName(
in In_BranchId char(20))
returns char(80)
begin
  declare Out_BranchName char(80);
  select Branch.BranchName into Out_BranchName
    from Branch where
    Branch.BranchId = In_BranchId;
  return(Out_BranchName)
end
;

create function DBA.FGetBRProgPrevBasicRate(
in In_EmployeeSysId integer,
in In_BRProgDate date)
returns double
begin
  declare Out_PrevBRProgDate date;
  declare Out_BRProgNewBasicRate double;
  select max(BRProgDate) into Out_PrevBRProgDate from BasicRateProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate <= in_BRProgDate;
  if Out_PrevBRProgDate is null then return 0
  end if;
  select BRProgNewBasicRate into Out_BRProgNewBasicRate from BasicRateProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate = Out_PrevBRProgDate;
  return Out_BRProgNewBasicRate
end
;

create function DBA.FGetBRProgPreviousProgDate(
in In_EmployeeSysId integer,
in In_BRProgDate date)
returns date
begin
  declare Out_PrevBRProgDate date;
  select max(BRProgDate) into Out_PrevBRProgDate from BasicRateProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate < in_BRProgDate;
  if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
      BRProgDate = Out_PrevBRProgDate) then
    update BasicRateProgression set
      BasicRateProgression.BRProgCurrent = 1 where
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BRProgDate = Out_PrevBRProgDate;
    commit work
  end if;
  return(Out_PrevBRProgDate)
end
;

create function DBA.FGetCategorySameCodeAllowanceAmount(
in In_AllowanceFormulaid char(20),
in In_Categoryid char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(a.AllowanceAmount) into TotalAmount from AllowanceRecord as a join Payemployee as p join employee as e where
    a.AllowanceFormulaid = In_AllowanceFormulaid and
    e.Categoryid = In_Categoryid and
    a.PayRecYear = In_PayRecYear and
    a.PayRecPeriod = In_PayRecPeriod and
    a.PayRecSubPeriod = In_PayRecSubPeriod and
    a.PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetClassificationDesc(
in In_ClassificationCode char(20))
returns char(80)
begin
  declare Out_ClassificationDesc char(80);
  select Classification.ClassificationDesc into Out_ClassificationDesc
    from Classification where
    Classification.ClassificationCode = In_ClassificationCode;
  return(Out_ClassificationDesc)
end
;

create function
DBA.FGetCompanyAddress(in In_CompanyId char(20))
returns char(100)
begin
  declare Out_FullCompanyAddress char(550);
  select Company.CompanyAddress+' '+
    Company.CompanyAddress2+' '+
    Company.CompanyAddress3+' '+
    CompanyCountry+' '+
    CompanyPCode into Out_FullCompanyAddress from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_FullCompanyAddress)
end
;

create function DBA.FGetCompCodeDesc(
in In_EmployeeSysId integer,
in In_CompCode char(20))
returns char(100)
begin
  declare Out_CodeDesc char(100);
  if(In_CompCode = 'departmentid') then
    select Department.departmentDesc into Out_CodeDesc
      from Department join Employee where
      Employee.EmployeeSysId = In_EmployeeSysId
  elseif(In_CompCode = 'categoryid') then
    select Category.CategoryDesc into Out_CodeDesc
      from Category join Employee where
      Employee.EmployeeSysId = In_EmployeeSysId
  elseif(In_CompCode = 'positionid') then
    select PositionCode.PositionDesc into Out_CodeDesc
      from PositionCode join Employee where
      Employee.EmployeeSysId = In_EmployeeSysId
  elseif(In_CompCode = 'sectionid') then
    select Section.SectionDesc into Out_CodeDesc
      from Section join Employee where
      Employee.EmployeeSysId = In_EmployeeSysId
  end if;
  return(Out_CodeDesc)
end
;

create function DBA.FGetComSameCodeAllowanceAmount(
in In_AllowanceFormulaid char(20),
in In_Companyid char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(a.AllowanceAmount) into TotalAmount from AllowanceRecord as a join Payemployee as p join employee as e where
    a.AllowanceFormulaid = In_AllowanceFormulaid and
    e.Companyid = In_Companyid and
    a.PayRecYear = In_PayRecYear and
    a.PayRecPeriod = In_PayRecPeriod and
    a.PayRecSubPeriod = In_PayRecSubPeriod and
    a.PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetCoreKeyWordUserDefinedName(
in In_CoreKeyWordId char(20))
returns char(100)
begin
  declare Out_CoreKeyWordUserDefinedName char(100);
  select CoreUserDefinedName into Out_CoreKeyWordUserDefinedName from CoreKeyWord where
    CoreKeyWordId = In_CoreKeyWordId;
  if(Out_CoreKeyWordUserDefinedName is null or Out_CoreKeyWordUserDefinedName = '') then
    return(In_CoreKeyWordId)
  else return(Out_CoreKeyWordUserDefinedName)
  end if
end
;

create function DBA.FGetCPFAccNoFormat(
in In_Employeesysid integer)
returns char(9)
begin
  declare fResult char(9);
  declare lastDigit char(1);
  declare cpfAccNo char(10);
  declare cpfAccNo_temp char(10);
  select first CPFProgAccountNo into cpfAccNo from CPFProgression 
	where EmployeeSysId = In_EmployeeSysId and CPFProgCurrent = 1 order by CPFEffectiveDate desc;
  if cpfAccNo <> '' then
    set cpfAccNo_temp=cpfAccNo;
    set lastdigit=SUBSTR(cpfAccNo_temp,10,1);
    set fResult=FSetBlank(SUBSTR(cpfAccNo,1,8)+lastdigit,9,'R')
  else
    set fResult=FSetBlank(' ',9,'R')
  end if;
  return(fResult)
end
;

create function DBA.FGetCPFDetailLine(
in In_Type char(9),
in in_EmployeeSysID integer,
in in_Year integer,
in in_Period integer,
in in_AdviceCode char(2),
in In_NegativeToZero smallint)
returns char(100)
begin
  declare result char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare relevantMonth char(6);
  declare relevantPeriodMonth integer;
  declare code char(2);
  declare cpfAccNo char(9);
  declare amount double;
  declare ordWages double;
  declare empStatus char(1);
  declare eeName char(30);
  declare addWages double;
  set company_cpfAccNo=FGetEmployerRefNo(*);
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  select FGetPeriodMonth(PayPayGroupID,in_Period) into relevantPeriodMonth from PayPeriodRecord where employeesysid = in_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
  set relevantMonth=Trim(Str(in_Year))+Trim(FAddZero(relevantPeriodMonth,2,'L'));
  select FGetCPFAccNoFormat(in_EmployeeSySId) into cpfAccNo;
  if In_Type = 'CPF' then
    select '01',FCPFConvertNegativeToZero(totalContrieeCPF+totalContriErCPF,In_NegativeToZero),FCPFConvertNegativeToZero(CurOrdinaryWage,In_NegativeToZero),FCPFConvertNegativeToZero(CurAdditionalWage,In_NegativeToZero) into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'MBMF' then
    select '02',(totalMBMF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'SINDA' then
    select '03',(totalSINDA),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CDAC' then
    select '04',(totalCDAC),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'EUCF' then
    select '05',(totalEUCF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  select(case when CPFStatus = 'CPFExisting' then 'E'
    when CPFStatus = 'CPFCessation' then 'L'
    when CPFStatus = 'CPFNewJoin' then 'N'
    when CPFStatus = 'CPFJoinLeave' then 'O' else ' '
    end) into empStatus from PeriodPolicySummary where
    payRecPeriod = In_Period and
    payRecYear = In_Year and
    employeeSysId = In_EmployeeSysID;
  select distinct EmployeeName into eeName from employee where EmployeeSysId = In_EmployeeSysId;
  if amount <> 0 then
    set result=FSetBlank('1'+
      FSetBlank(company_cpfAccNo,7,'R')+' '+
      adviceCode+
      relevantMonth+
      code+
      cpfAccNo+
      FAddZero(FRemoveDecimal(amount),8,'L')+
      FAddZero(FRemoveDecimal(ordWages),10,'L')+
      empStatus+
      FSetBlank(Upper(SubStr(eeName,1,22)),22,'R')+
      FAddZero(FRemoveDecimal(addWages),10,'L'),
      100,'R');
    return(result)
  else
    return('')
  end if
end
;

create function dba.FGetCPFFormula(
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
    Constant5 into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
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
    set Out_OrdDesc=LTrim(Str(OrdC1,8,1))+'% of TW'
  elseif(OrdFormulaType = 'T2') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,1))+'% of TW '+
      LTrim(Str(OrdC2,8,1))+'/'+LTrim(Str(OrdC3,8,1))+' (TW - '+LTrim(Str(OrdC4,8,0))+')'
  elseif(OrdFormulaType = 'T3') then
    set Out_OrdDesc=LTrim(Str(OrdC1,8,1))+'% of OW MAX $'+LTrim(Str(OrdC2,8,2))+' and '
  elseif(OrdFormulaType = 'T4') then
    set Out_OrdDesc=LTrim(Str(OrdC3,8,3))+' + '+LTrim(Str(OrdC1,8,4))+'(TW - '+LTrim(Str(OrdC2,8,0))+')'
  end if;
  if(AddFormulaType = 'T3') then
    set Out_AddDesc=LTrim(Str(AddC1,8,1))+'% of AW'
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc+' and ';
    select FDecodeFormula(In_AddFormulaId) into Out_AddDesc
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

create function DBA.FGetCPFHeaderLine(
in in_AdviceCode char(2))
returns char(100)
begin
  declare fResult char(100);
  declare adviceCode char(2);
  declare creationDate char(8);
  declare creationTime char(6);
  if in_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set creationDate=DateFormat(Now(*),'yyyymmdd');
  set creationTime=DateFormat(Now(*),'hhmmss');
  set fResult=' '+FGetEmployerRefNo(*)+' '+
    adviceCode+
    FSetBlank(
    creationDate+
    creationTime+'DISKETTE.DTL',
    91,'R');
  return(fResult)
end
;

create function DBA.FGetCPFLineDetailLine(
in In_Type char(9),
in in_EmployeeSysID integer,
in in_Year integer,
in in_Period integer,
in In_NegativeToZero smallint)
returns char(255)
begin
  declare result char(255);
  declare termdate char(10);
  declare code char(3);
  declare cpfAccNo char(9);
  declare amount double;
  declare ordWages double;
  declare empStatus char(1);
  declare eeName char(30);
  declare addWages double;
  declare cpfclass char(20);
  declare cpfstatus char(20);
  select distinct EmployeeName into eeName from employee where EmployeeSysId = In_EmployeeSysId;
  // Changed - test based on CPF win
  //select FGetCPFAccNoFormat(in_EmployeeSySId) into cpfAccNo;
  select FGetIdentityNo(in_EmployeeSySId) into cpfAccNo;
  select CPFClass into cpfclass from periodpolicysummary where employeesysid = in_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
  if In_Type = 'CPF' then
    if(cpfclass = 'FW' or cpfclass = 'EP') then
      set result=''
    else
      select 'AV2',FCPFConvertNegativeToZero(totalContrieeCPF+totalContriErCPF,In_NegativeToZero) into code,
        amount from PeriodPolicySummary where
        payRecPeriod = In_Period and
        payRecYear = In_Year and
        employeeSysId = In_EmployeeSysID;
      set result=FSetBlank('MOA  '+code+Trim(Str(Round(amount,0))),255,'R')
    end if
  end if;
  if In_Type = 'MBMF' then
    select 'AV6',(totalMBMF) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'SINDA' then
    select 'AVB',(totalSINDA) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'OrWages' then
    select 'AVC',FCPFConvertNegativeToZero(CurOrdinaryWage,In_NegativeToZero) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'AdWages' then
    select 'AVD',FCPFConvertNegativeToZero(CurAdditionalWage,In_NegativeToZero) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'CDAC' then
    select 'AVF',(totalCDAC) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'EUCF' then
    select 'AVH',(totalEUCF) into code,
      amount from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID;
    if amount <> 0 then
      set result=FSetBlank('MOA  '+code+Trim(STR(amount,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'NAD' then
    set result=FSetBlank('NAD  PE '+FSetBlank(FGetIdentityNo(In_EmployeeSysID),41,'R')+SubStr(eeName,1,22),255,'R')
  end if;
  if In_Type = 'DTM' then
    select FGetInvalidDate(CessationDate) into termDate from Employee where employeesysid = In_EmployeeSysID;
    select CPFStatus into cpfstatus from PeriodPolicySummary where employeesysid = In_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
    if termDate <> '' and(cpfstatus = 'CPFCessation' or cpfstatus = 'CPFJoinLeave') then
      //set termDate=DateFormat(termDate,'yyyymmDD');
      set termDate=DateFormat(cast(FGetInvalidDate(termDate) as date),'yyyymmdd');
      set result=FSetBlank('DTM  337'+termDate,255,'R')
    else set result=''
    end if
  end if;
  return(result)
end
;

create function dba.FGetCPFLineSummaryLine(
in In_Type char(20),
in In_PayGroup char(20),
in In_Year integer,
in In_Period integer,
in In_Input double,
in in_AdviceCode char(2))
returns char(255)
begin
  declare result char(255);
  declare company_cpfAccNo char(7);
  declare company_name char(35);
  declare adviceCode char(2);
  declare creationDate char(8);
  declare relevantMonth char(6);
  declare code char(3);
  // Changed because error when testing using CPF Win
  //set company_cpfAccNo=FGetEmployerRefNo(*);
  select CompanyGovACCNo into company_cpfAccNo from DBA.CompanyGov where CompanyGovCode = 'Employer CPF No';
  select CompanyName into company_name from Company;
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set relevantMonth=Trim(Str(In_Year))+Trim(FAddZero(FGetPeriodMonth(In_PayGroup,In_Period),2,'L'));
  set creationDate=DateFormat(Now(*),'yyyymmdd');
  if In_Type = 'UNB' then
    set result=FSetBlank(FSetBlank('UNB',156,'R')+'CPFPAY',255,'R')
  end if;
  if In_Type = 'UNH' then
    set result=FSetBlank(FSetBlank('UNH',19,'R')+'CPFPAY20',255,'R')
  end if;
  if In_Type = 'BGM' then
    set result=FSetBlank('BGM  450',255,'R')
  end if;
  if In_Type = 'DTM1' then
    set result=FSetBlank('DTM  137'+creationDate,255,'R')
  end if;
  if In_Type = 'DTM2' then
    set result=FSetBlank('DTM  335'+relevantMonth,255,'R')
  end if;
  if In_Type = 'MOA_CPF' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV1'+Trim(STR(Round(In_Input,0))),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_Community' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV3'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_SDF' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV4'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_MBMF' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV5'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_FWL' then
    set result=FSetBlank('MOA  '+'AV7'+Trim(STR(In_Input,15,2)),255,'R')
  end if;
  if In_Type = 'MOA_FWLPenalty' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV8'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_CPFPenalty' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AV9'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_SINDA' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AVA'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_CDAC' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AVE'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'MOA_EUCF' then
    if In_Input <> 0 then
      set result=FSetBlank('MOA  '+'AVG'+Trim(STR(In_Input,15,2)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'NAD' then
    set result=FSetBlank('NAD  BG '+FSetBlank(company_cpfAccNo,41,'R')+SubStr(company_name,1,35),255,'R')
  end if;
  if In_Type = 'RFF' then
    set result=FSetBlank('RFF  ALL'+adviceCode,255,'R')
  end if;
  if In_Type = 'QTY_MBMF' then
    if In_Input <> 0 then
      set result=FSetBlank('QTY  MUS'+Trim(STR(In_Input)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'QTY_Community' then
    if In_Input <> 0 then
      set result=FSetBlank('QTY  SHA'+Trim(STR(In_Input)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'QTY_SIN' then
    if In_Input <> 0 then
      set result=FSetBlank('QTY  SIN'+Trim(STR(In_Input)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'QTY_CDAC' then
    if In_Input <> 0 then
      set result=FSetBlank('QTY  CDA'+Trim(STR(In_Input)),255,'R')
    else set result=''
    end if
  end if;
  if In_Type = 'QTY_EUCF' then
    if In_Input <> 0 then
      set result=FSetBlank('QTY  ECF'+Trim(STR(In_Input)),255,'R')
    else set result=''
    end if
  end if;
  return(result)
end
;

create function dba.FGetCPFLineTotalLine(
in In_Year integer,
in In_Period integer,
in In_Input double)
returns char(255)
begin
  declare result char(255);
  declare amount double;
  if In_Input <> 0 then
    set result=FSetBlank('CNT  128'+Trim(Str(In_Input,15,2)),255,'R')
  else
    set result=''
  end if;
  return(result)
end
;

create function DBA.FGetCPFPalDetailLine(
in In_Type char(20),
in in_EmployeeSysID integer,
in in_Year integer,
in in_Period integer,
in in_AdviceCode char(2),
in in_company_cpfAccNo char(7),
in In_NegativeToZero smallint)
returns char(100)
begin
  declare result char(200);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare relevantMonth char(6);
  declare relevantPeriodMonth integer;
  declare code char(2);
  declare cpfAccNo char(9);
  declare amount double;
  declare ordWages double;
  declare empStatus char(1);
  declare eeName char(30);
  declare addWages double;
  declare cpfclass char(20);
  set company_cpfAccNo=in_company_cpfAccNo;
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  select FGetPeriodMonth(PayPayGroupID,in_Period) into relevantPeriodMonth from PayPeriodRecord where employeesysid = in_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
  set relevantMonth=Trim(Str(in_Year))+Trim(FAddZero(relevantPeriodMonth,2,'L'));
  select FGetCPFAccNoFormat(in_EmployeeSySId) into cpfAccNo;
  select CPFClass into cpfclass from periodpolicysummary where employeesysid = in_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
  if In_Type = 'CPFCompulsory' then
    select '01',FCPFConvertNegativeToZero((totalContrieeCPF+totalContriErCPF)-(VolOrdEECPF+VolOrdERCPF+VolAddEECPF+VolAddERCPF),In_NegativeToZero),FCPFConvertNegativeToZero(CurOrdinaryWage,In_NegativeToZero),FCPFConvertNegativeToZero(CurAdditionalWage,In_NegativeToZero) into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CPFVoluntary' then
    select '01',FCPFConvertNegativeToZero(VolOrdEECPF+VolOrdERCPF+VolAddEECPF+VolAddERCPF,In_NegativeToZero),FCPFConvertNegativeToZero(CurOrdinaryWage,In_NegativeToZero),FCPFConvertNegativeToZero(CurAdditionalWage,In_NegativeToZero) into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'MBMF' then
    select '02',(totalMBMF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'SINDA' then
    select '03',(totalSINDA),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CDAC' then
    select '04',(totalCDAC),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'EUCF' then
    select '05',(totalEUCF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CPFCompulsory' or In_Type = 'CPFVoluntary' then select(case when CPFStatus = 'CPFExisting' then 'E'
      when CPFStatus = 'CPFCessation' then 'L'
      when CPFStatus = 'CPFNewJoin' then 'N'
      when CPFStatus = 'CPFJoinLeave' then 'O' else ' '
      end) into empStatus from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  else set empStatus=' '
  end if;
  select distinct EmployeeName into eeName from employee where EmployeeSysId = In_EmployeeSysId;
  set result='F1'+FSetBlank(company_cpfAccNo,7,'R')+' '+
    adviceCode+
    relevantMonth+
    code+
    cpfAccNo+
    FAddZero(FRemoveDecimal(amount),12,'L')+
    FAddZero(FRemoveDecimal(ordWages),10,'L')+FAddZero(FRemoveDecimal(addWages),10,'L')+
    empStatus+FSetBlank(Upper(SubStr(eeName,1,22)),22,'R');
  if(In_Type = 'CPFCompulsory' or In_Type = 'CPFVoluntary') then
    if(cpfclass = 'FW' or cpfclass = 'EP') then
      if amount <> 0 then
        return(result)
      else
        return('')
      end if
    else
      if In_Type = 'CPFCompulsory' then
        return(result)
      else if amount <> 0 then
          return(result)
        else
          return('')
        end if
      end if
    end if
  else
    if(amount <> 0) then
      return(result)
    else
      return('')
    end if
  end if
end
;

create function DBA.FGetCPFPalHeaderLine(
in in_AdviceCode char(2),
in in_company_cpfAccNo char(7))
returns char(100)
begin
  declare fResult char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare creationDate char(8);
  declare creationTime char(6);
  /* Get Company CPF Account No */
  set company_cpfAccNo=in_company_cpfAccNo;
  /* Set Advice Code */
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set creationDate=DateFormat(Now(*),'yyyymmdd');
  set creationTime=DateFormat(Now(*),'hhmmss');
  set fResult=FSetBlank('F '+FSetBlank(company_cpfAccNo,7,'R')+' '+adviceCode+creationDate+creationTime+'FTP.DTL',100,'R');
  return(fResult)
end
;

create function dba.FGetCPFPalSummaryLine(
in In_Type char(10),
in In_PayGroup char(20),
in In_Year integer,
in In_Period integer,
in In_Amount double,
in In_Count double,
in in_AdviceCode char(2),
in in_company_cpfAccNo char(7))
returns char(100)
begin
  declare result char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare relevantMonth char(6);
  declare code char(2);
  /* Get Company CPF Account No */
  set company_cpfAccNo=in_company_cpfAccNo;
  /* Set Advice Code */
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  /* Set The Relevant Month */
  set relevantMonth=Trim(Str(In_Year))+Trim(FAddZero(FGetPeriodMonth(In_PayGroup,In_Period),2,'L'));
  /* Set the code, amount and donor code */
  if In_Type = 'CPF' then set code='01'
  end if;
  if In_Type = 'MBMF' then set code='02'
  end if;
  if In_Type = 'SINDA' then set code='03'
  end if;
  if In_Type = 'CDAC' then set code='04'
  end if;
  if In_Type = 'EUCF' then set code='05'
  end if;
  if In_Type = 'CPFPenalty' then set code='07'
  end if;
  if In_Type = 'FWLPenalty' then set code='09'
  end if;
  if In_Type = 'Community' then set code='10'
  end if;
  if In_Type = 'FWL' then set code='08'
  end if;
  if In_Type = 'SDF' then set code='11'
  end if;
  if(In_Amount <> 0) then
    set result=FSetBlank('F0'+
      FSetBlank(company_cpfAccNo,7,'R')+' '+
      adviceCode+
      relevantMonth+
      code+
      FAddZero(FRemoveDecimal(In_Amount),12,'L')+
      FAddZero(In_Count,7,'L'),
      100,'R');
    return(result)
  else
    return('')
  end if
end
;

create function DBA.FGetCPFPalTrailerLine(
in in_AdviceCode char(2),
in in_company_cpfAccNo char(7))
returns char(12)
begin
  declare fResult char(12);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  /* Get Company CPF Account No */
  set company_cpfAccNo=in_company_cpfAccNo;
  /* Set Advice Code */
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set fResult=FSetBlank('F9'+FSetBlank(company_cpfAccNo,7,'R')+' '+adviceCode,12,'R');
  return(fResult)
end
;

create function DBA.FGetCPFPaymentDetails(
in in_EmployeeSysID integer,
in In_Year integer,
in In_Period integer)
returns char(248)
begin
  declare fResult char(248);
  declare eeName TEXT;
  declare cpfAccNo char(11);
  declare cpfStatus char(20);
  declare amount double;
  declare prevAmount double;
  declare prevAmountChar char(17);
  declare ordWages double;
  declare dateLeft TEXT;
  declare addWages double;
  declare mbmf double;
  declare sinda double;
  declare cdac double;
  declare eucf double;
  select distinct EmployeeName into eeName from employee where EmployeeSysId = In_EmployeeSysId;
  select(totalContrieeCPF+totalContriErCPF),CurOrdinaryWage,CurAdditionalWage,totalMbmf,totalSinda,totalCDAC,totalEucf,CPFStatus into amount,
    ordWages,
    addWages,mbmf,sinda,cdac,
    eucf,cpfStatus from PeriodPolicySummary where
    payRecPeriod = In_Period and
    payRecYear = In_Year and
    employeeSysId = In_EmployeeSysID;
  set prevAmount=FGetCPFPreviousContrib(in_EmployeeSysID,In_Year,In_Period);
  if prevAmount = 0 and cpfStatus = 'CPFNewJoin' then
    set prevAmountChar='New Join'
  else set prevAmountChar=Str(prevAmount,8,2)
  end if;
  //select FGetCPFAccNoFormat(in_EmployeeSysID) into cpfAccNo;
  select distinct CPFProgAccountNo into cpfAccNo from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFProgCurrent = 1;
  if cpfAccNo is null then set cpfAccNo='          '
  end if;
  select FGetDateFormat(CessationDate) into dateLeft from employee where EmployeeSysId = In_EmployeeSysId;
  set fResult
    =FSetBlank(SubStr(eeName,1,28),29,'R')+
    FSetBlank(cpfAccNo,11,'R')+
    FSetBlank(Str(amount,10,2),16,'L')+
    FSetBlank(prevAmountChar,17,'L')+
    FSetBlank(Str(mbmf,10,2),19,'L')+
    FSetBlank(Str(sinda,10,2),11,'L')+
    FSetBlank(Str(cdac,10,2),11,'L')+
    FSetBlank(Str(eucf,10,2),11,'L')+
    FSetBlank(dateLeft,15,'L')+
    FSetBlank(Str(ordWages,10,2),12,'L')+
    FSetBlank(Str(addWages,10,2),12,'L');
  if amount <> 0 or mbmf <> 0 or sinda <> 0 or cdac <> 0 or eucf <> 0 then
    return(fResult)
  else
    return('')
  end if
end
;

create function DBA.FGetCPFPaymentTotalLine(
in In_amount double,
in In_prevAmount double,
in In_mbmf double,
in In_sinda double,
in In_cdac double,
in In_eucf double,
in In_ordWages double,
in In_addWages double)
returns char(248)
begin
  declare fResult char(248);
  set fresult=' '+FSetBlank('Total : ',39,'R')+
    FSetBlank(Str(In_amount,10,2),16,'L')+
    FSetBlank(Str(In_prevAmount,10,2),17,'L')+
    FSetBlank(Str(In_mbmf,10,2),19,'L')+
    FSetBlank(Str(In_sinda,10,2),11,'L')+
    FSetBlank(Str(In_cdac,10,2),11,'L')+
    FSetBlank(Str(In_eucf,10,2),11,'L')+
    FSetBlank(' ',15,'L')+
    FSetBlank(Str(In_ordWages,10,2),12,'L')+
    FSetBlank(Str(In_addWages,10,2),12,'L');
  return(fResult)
end
;

create function dba.FGetCPFPreviousContrib(
in in_EmployeeSysID integer,
in In_Year integer,
in In_Period integer,
in In_NegativeToZero smallint,
in In_CPFType integer)
returns double
begin
  declare fresult double;
  declare prevYear integer;
  declare prevPeriod integer;
  if In_Period = 1 then
    set prevPeriod=12;
    set prevYear=In_Year-1
  else
    set prevPeriod=In_Period-1;
    set prevYear=In_Year
  end if;
  if(In_CPFType = 0) then
    if exists(select* from
        PeriodPolicySummary where
        payRecPeriod = prevPeriod and
        payRecYear = prevYear and
        employeeSysId = In_EmployeeSysID) then
      (select FCPFConvertNegativeToZero((case when CPFStatus <> 'CPFNone' then(totalContrieeCPF+totalContriErCPF-(VolOrdEECPF+VolOrdERCPF+VolAddEECPF+VolAddERCPF)) else 0 end),In_NegativeToZero) into fresult
        from PeriodPolicySummary where
        payRecPeriod = prevPeriod and
        payRecYear = prevYear and
        employeeSysId = In_EmployeeSysID)
    else
      set fresult=0
    end if
  else
    if exists(select* from
        PeriodPolicySummary where
        payRecPeriod = prevPeriod and
        payRecYear = prevYear and
        employeeSysId = In_EmployeeSysID) then
      (select FCPFConvertNegativeToZero((case when CPFStatus <> 'CPFNone' then(VolOrdEECPF+VolOrdERCPF+VolAddEECPF+VolAddERCPF) else 0 end),In_NegativeToZero) into fresult
        from PeriodPolicySummary where
        payRecPeriod = prevPeriod and
        payRecYear = prevYear and
        employeeSysId = In_EmployeeSysID)
    else
      set fresult=0
    end if
  end if;
  return(fresult)
end
;

create function DBA.FGetCPFProgAccountNo(
in In_Employeesysid integer)
returns char(10)
begin
  declare fResult char(10);
  select distinct CPFProgAccountNo into fResult from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFProgCurrent = 1;
  if fResult is null then set fResult=''
  end if;
  return(fResult)
end
;

create function DBA.FGetCPFProgPreviousProgDate(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date)
returns date
begin
  declare Out_PrevCPFEffectiveDate date;
  select max(CPFEffectiveDate) into Out_PrevCPFEffectiveDate from CPFProgression where EmployeeSysId = in_EmployeeSysId and
    CPFEffectiveDate < In_CPFEffectiveDate;
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFEffectiveDate = Out_PrevCPFEffectiveDate) then
    update CPFProgression set
      CPFProgression.CPFProgCurrent = 1 where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFEffectiveDate = Out_PrevCPFEffectiveDate;
    commit work
  end if;
  return(Out_PrevCPFEffectiveDate)
end
;

create function dba.FGetCPFSummaryLine(
in In_Type char(10),
in In_PayGroup char(20),
in In_Year integer,
in In_Period integer,
in In_Amount double,
in In_Count double,
in in_AdviceCode char(2))
returns char(100)
begin
  declare result char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare relevantMonth char(6);
  declare code char(2);
  /* Get Company CPF Account No */
  set company_cpfAccNo=FGetEmployerRefNo(*);
  /* Set Advice Code */
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  /* Set The Relevant Month */
  set relevantMonth=Trim(Str(In_Year))+Trim(FAddZero(FGetPeriodMonth(In_PayGroup,In_Period),2,'L'));
  /* Set the code, amount and donor code */
  if In_Type = 'CPF' then set code='01'
  end if;
  if In_Type = 'MBMF' then set code='02'
  end if;
  if In_Type = 'SINDA' then set code='03'
  end if;
  if In_Type = 'CDAC' then set code='04'
  end if;
  if In_Type = 'EUCF' then set code='05'
  end if;
  if In_Type = 'CPFPenalty' then set code='07'
  end if;
  if In_Type = 'FWLPenalty' then set code='09'
  end if;
  if In_Type = 'Community' then set code='10'
  end if;
  if In_Type = 'FWL' then set code='08'
  end if;
  if In_Type = 'SDF' then set code='11'
  end if;
  if(In_Amount <> 0) then
    set result=FSetBlank('0'+
      FSetBlank(company_cpfAccNo,7,'R')+' '+
      adviceCode+
      relevantMonth+
      code+
      FAddZero(FRemoveDecimal(In_Amount),12,'L')+
      FAddZero(In_Count,7,'L'),
      100,'R');
    return(result)
  else
    return('')
  end if
end
;

create function DBA.FGetCPFTrailerLine(
in in_AdviceCode char(2))
returns char(11)
begin
  declare fResult char(11);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  /* Get Company CPF Account No */
  set company_cpfAccNo=FGetEmployerRefNo(*);
  /* Set Advice Code */
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set fResult=FSetBlank('9'+FSetBlank(company_cpfAccNo,7,'R')+' '+adviceCode,11,'R');
  return(fResult)
end
;

create function dba.FGetCurrentBasicRateProgressionDate(
in in_EmployeeSysID integer)
returns date
begin
  declare output_BRProgDate date;
  select distinct BRProgDate into output_BRProgDate from BasicRateProgression where EmployeeSysID = in_EmployeeSysID and
    BRProgCurrent = 1;
  return(output_BRProgDate)
end
;

create function DBA.FGetCurrentBRProgDate(
in In_EmployeeSysId integer)
returns date
begin
  declare Out_CurrentBRProgDate date;
  select BasicRateProgression.BRProgDate into Out_CurrentBRProgDate
    from BasicRateProgression where
    BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgCurrent = 1;
  return(Out_CurrentBRProgDate)
end
;

create function DBA.FGetCurrentCPFPolicyTable(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_CPFScheme char(30);
  select CPFProgPolicyId into Out_CPFScheme
    from cpfprogression where
    cpfprogression.EmployeeSysId = In_EmployeeSysId and
    cpfprogcurrent = 1;
  return(Out_CPFScheme)
end
;

create function DBA.FGetCurrentCPFScheme(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_CPFScheme char(30);
  select CPFProgSchemeId into Out_CPFScheme
    from cpfprogression where
    cpfprogression.EmployeeSysId = In_EmployeeSysId and
    cpfprogcurrent = 1;
  return(Out_CPFScheme)
end
;

create function DBA.FGetCurrentFWLClass(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_FWLClass char(30);
  select FWLformulaid into Out_FWLClass
    from fwlprogression where
    fwlprogression.EmployeeSysId = In_EmployeeSysId and
    fwlcurrent = 1;
  return(Out_FWLClass)
end
;

create function DBA.FGetCurrentResStatus(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_ResStatus char(30);
  select residenceTypeId into Out_ResStatus
    from residencestatusrecord where
    residencestatusrecord.PersonalSysId = In_PersonalSysId and
    Residencestatusrecord.ResStatusCurrent = 1;
  return(Out_ResStatus)
end
;

create function DBA.FGetDateFormat(
in In_Date date)
returns char(10)
begin
  declare out_DateFormat char(10);
  declare invalid_date char(10);
  select shortstringattr into out_DateFormat from subregistry where registryid = 'system' and subregistryid = 'dateformat';
  select FGetInvalidDate(In_Date) into invalid_date;
  if(invalid_date = '') then
    return ''
  end if;
  return dateformat(In_Date,out_DateFormat)
end
;

create function DBA.FGetDateTimeFormat(
in In_DateTime timestamp)
returns char(20)
begin
  declare out_DateTimeFormat char(20);
  declare invalid_date char(20);
  set out_DateTimeFormat='dd-mm-yyyy hh:nn:ss';
  select FGetInvalidDate(In_DateTime) into invalid_date;
  if(invalid_date = '') then
    return ''
  end if;
  return dateformat(In_DateTime,out_DateTimeFormat)
end
;

create function dba.FGetDBCountry()
returns char(20)
begin
  declare Out_DBCountry char(20);
  select RegProperty1 into Out_DBCountry from SubRegistry where
    RegistryId = 'System' and SubRegistryId = 'DBCountry';
  return Out_DBCountry
end
;

create function DBA.FGetDBPayDecimal()
returns integer
begin
  declare Out_IntegerAttr integer;
  select IntegerAttr into Out_IntegerAttr from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBPayDecimal';
  return Out_IntegerAttr
end
;

create function dba.FGetDepartmentAllowanceVarianceCount(
in In_DepartmentID char(100),
in In_EmployeeSysID integer,
in In_YearA integer,
in In_PeriodA integer,
in In_YearB integer,
in In_PeriodB integer,
in In_SubPeriod integer,
in In_PayRecType char(30))
returns integer
begin
  declare Out_AllowanceVarianceCount integer;
  set Out_AllowanceVarianceCount=0;
  if(In_SubPeriod = 0) then
    if(In_PayRecType = 'All') then
      AllowanceVarianceLoopA: for AllowanceVarianceForA as Cur_AllowanceVarianceA dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearA and
            AR.PayRecPeriod = In_PeriodA and
            AR.AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            AR.PayRecYear = In_YearB and
            AR.PayRecPeriod = In_PeriodB and
            AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          AR.EmployeeSysID = In_EmployeeSysID and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    else
      AllowanceVarianceLoopB: for AllowanceVarianceForB as Cur_AllowanceVarianceB dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearA and
            AR.PayRecPeriod = In_PeriodA and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearB and
            AR.PayRecPeriod = In_PeriodB and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AR.AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          AR.EmployeeSysID = In_EmployeeSysID and
          AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    end if
  else
    if(In_PayRecType = 'All') then
      AllowanceVarianceLoopC: for AllowanceVarianceForC as Cur_AllowanceVarianceC dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearA and
            AR.PayRecPeriod = In_PeriodA and
            PayRecSubPeriod = In_SubPeriod and
            AR.AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearB and
            AR.PayRecPeriod = In_PeriodB and
            AR.PayRecSubPeriod = In_SubPeriod and
            AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          PayRecSubPeriod = In_SubPeriod and
          AR.EmployeeSysID = In_EmployeeSysID and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    else
      AllowanceVarianceLoopD: for AllowanceVarianceForD as Cur_AllowanceVarianceD dynamic scroll cursor for
        select distinct
          FGetFormulaDesc(AllowanceFormulaID) as FormulaID,
          (case when FormulaSubCategory = 'Allowance' then 'Allowance'
          when FormulaSubCategory = 'Deduction' then 'Deduction'
          when FormulaSubCategory = 'Reimbursement' then 'Reimbursement'
          end) as Type,AllowanceFormulaID as AlFormulaID,In_EmployeeSysID as AlEESysID,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearA and
            AR.PayRecPeriod = In_PeriodA and
            AR.PayRecSubPeriod = In_SubPeriod and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AR.AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_a,
          (select Sum(AllowanceAmount) from AllowanceRecord as AR,PayPeriodRecord as PPR where
            AR.EmployeeSysID = PPR.EmployeeSysID and
            AR.PayRecYear = PPR.PayRecYear and
            AR.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            AR.PayRecYear = In_YearB and
            AR.PayRecPeriod = In_PeriodB and
            AR.PayRecSubPeriod = In_SubPeriod and
            AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
            AllowanceFormulaID = AlFormulaID and
            AR.EmployeeSysID = AlEESysID) as Allowance_b,
          (case when Allowance_a is null then 0 else Allowance_a end) as AllowanceA,
          (case when Allowance_b is null then 0 else Allowance_b end) as AllowanceB,
          (AllowanceB-AllowanceA) as AllowanceVariance from
          AllowanceRecord as AR,Formula as F where
          AR.AllowanceFormulaID = F.FormulaID and
          ((PayRecYear = In_YearA and PayRecPeriod = In_PeriodA) or
          (PayRecYear = In_YearB and PayRecPeriod = In_PeriodB)) and
          AR.PayRecSubPeriod = In_SubPeriod and
          AR.EmployeeSysID = In_EmployeeSysID and
          AR.PayRecID = any(select distinct PayRecID from PayRecord where PayRecType = In_PayRecType) and
          AllowanceVariance <> 0
          group by AllowanceFormulaID,FormulaSubCategory order by
          Type asc,FormulaID asc do
        set Out_AllowanceVarianceCount=Out_AllowanceVarianceCount+1 end for
    end if
  end if;
  return(Out_AllowanceVarianceCount)
end
;

create function DBA.FGetDosPayslipPeriodMessage(
in in_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
returns char(14)
begin
  declare Out_PeriodMessage char(14);
  declare In_PayGroupID char(20);
  declare PeriodMessage char(5);
  declare SubPeriodMessage char(5);
  declare YearString char(4);
  select PayPeriodRecord.PayPayGroupID into In_PayGroupID from PayPeriodRecord where
    PayPeriodRecord.EmployeeSysID = in_EmployeeSysId and
    PayPeriodRecord.PayRecYear = In_PayRecYear and
    PayPeriodRecord.PayRecPeriod = In_PayRecPeriod;
  select FGetPeriodShortMessage(In_PayGroupID,In_PayRecPeriod) into PeriodMessage;
  select FGetSubPeriodShortMessage(In_PayGroupID,In_PayRecSubPeriod) into SubPeriodMessage;
  set YearString=In_PayRecYear;
  if In_PayRecSubPeriod = 0 then
    set Out_PeriodMessage=PeriodMessage+' '+SUBSTRING(YearString,3,2)
  else
    set Out_PeriodMessage=PeriodMessage+' '+SubPeriodMessage+' '+SUBSTRING(YearString,3,2)
  end if;
  return Out_PeriodMessage
end
;

create function DBA.FGetEasyToReachContact(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_EasyToReachContact char(30);
  declare Out_Office char(30);
  declare Out_Handphone char(30);
  select first ContactNumber into Out_Office
    from PersonalContact where
    PersonalSysId = In_PersonalSysId and
    ContactLocationId = 'Office' order by PersonalContactId;
  select first ContactNumber into Out_Handphone
    from PersonalContact where
    PersonalSysId = In_PersonalSysId and
    ContactLocationId = 'Handphone' order by PersonalContactId;
  if(Out_Office <> '') then
    set Out_EasyToReachContact=Out_Office
  elseif(Out_Handphone <> '') then
    set Out_EasyToReachContact=Out_Handphone
  end if;
  return(Out_EasyToReachContact)
end
;

create function dba.FGetEEPropertyAllowanceAmt(
in In_EmployeeId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecId char(20),
in In_Property char(20))
returns double
begin
  declare Out_TotalAmount double;
  declare iEmployeeSysId integer;
  set Out_TotalAmount=0;
  select EmployeeSysId into iEmployeeSysId from Employee where EmployeeId = In_EmployeeId;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecYear = In_PayRecYear and
      AllowanceRecord.PayRecPeriod = In_PayRecPeriod and
      AllowanceRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      AllowanceRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId = '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecYear = In_PayRecYear and
      AllowanceRecord.PayRecPeriod = In_PayRecPeriod and
      AllowanceRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecYear = In_PayRecYear and
      AllowanceRecord.PayRecPeriod = In_PayRecPeriod and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecYear = In_PayRecYear and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId <> '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      AllowanceRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(AllowanceAmount) into Out_TotalAmount from AllowanceRecord,(
      Formula join FormulaProperty) where
      AllowanceRecord.AllowanceFormulaId = Formula.FormulaId and
      AllowanceRecord.EmployeeSysId = iEmployeeSysId and
      AllowanceRecord.PayRecPeriod = In_PayRecPeriod and
      AllowanceRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      AllowanceRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  return(Out_TotalAmount)
end
;

create function dba.FGetEEPropertyShiftAmt(
in In_EmployeeId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecId char(20),
in In_Property char(20))
returns double
begin
  declare Out_TotalAmount double;
  declare iEmployeeSysId integer;
  set Out_TotalAmount=0;
  select EmployeeSysId into iEmployeeSysId from Employee where EmployeeId = In_EmployeeId;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId = '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear > 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId = '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod = 0 and
    In_PayRecId <> '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod = 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  if In_PayRecYear = 0 and
    In_PayRecPeriod > 0 and
    In_PayRecSubPeriod > 0 and
    In_PayRecId <> '' then
    select SUM(ShiftAmount) into Out_TotalAmount from ShiftRecord,(
      Formula join FormulaProperty) where
      ShiftRecord.ShiftFormulaId = Formula.FormulaId and
      ShiftRecord.EmployeeSysId = iEmployeeSysId and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecId = In_PayRecId and
      FormulaProperty.KeywordId = In_Property;
    return(Out_TotalAmount)
  end if;
  return(Out_TotalAmount)
end
;

create function DBA.FGetEmpCompleteMailAddress(
in In_PersonalSysId integer)
returns char(220)
begin
  declare Out_Address1 char(30);
  declare Out_Address2 char(30);
  declare Out_Address3 char(30);
  declare Out_City char(30);
  declare Out_State char(30);
  declare Out_Country char(30);
  declare Out_PostalCode char(20);
  declare Out_JointAddress char(220);
  select PersonalAddAddress,
    PersonalAddAddress2,
    PersonalAddAddress3,
    PersonalAddCity,
    PersonalAddState,
    PersonalAddCountry,
    PersonalAddPCode into Out_Address1,
    Out_Address2,
    Out_Address3,
    Out_City,
    Out_State,
    Out_Country,
    Out_PostalCode from PersonalAddress where PersonalSysId = In_PersonalSysId and
    PersonalAddMailing = 1;
  if(Out_Address1 <> '') then
    set Out_JointAddress=trim(Out_Address1)+' '+trim(Out_Address2)+' '+trim(Out_Address3)+' '+
      trim(Out_City)+' '+trim(Out_State)+' '+trim(Out_Country)+' Poskod '+trim(Out_PostalCode)
  else
    set Out_JointAddress=''
  end if;
  return(Out_JointAddress)
end
;

create function DBA.FGetEmpCompleteResAddress(
in In_PersonalSysId integer)
returns char(220)
begin
  declare Out_ResAddress1 char(30);
  declare Out_ResAddress2 char(30);
  declare Out_ResAddress3 char(30);
  declare Out_ResCity char(30);
  declare Out_ResState char(30);
  declare Out_ResCountry char(30);
  declare Out_ResPostalCode char(20);
  declare Out_MailAddress1 char(30);
  declare Out_MailAddress2 char(30);
  declare Out_MailAddress3 char(30);
  declare Out_MailCity char(30);
  declare Out_MailState char(30);
  declare Out_MailCountry char(30);
  declare Out_MailPostalCode char(20);
  declare Out_JointMailAddress char(220);
  declare Out_JointResAddress char(220);
  declare Out_JointAddress char(220);
  select PersonalAddAddress,
    PersonalAddAddress2,
    PersonalAddAddress3,
    PersonalAddCity,
    PersonalAddState,
    PersonalAddCountry,
    PersonalAddPCode into Out_ResAddress1,
    Out_ResAddress2,
    Out_ResAddress3,
    Out_ResCity,
    Out_ResState,
    Out_ResCountry,
    Out_ResPostalCode from PersonalAddress where PersonalSysId = In_PersonalSysId and
    ContactLocationId = 'Residential';
  select PersonalAddAddress,
    PersonalAddAddress2,
    PersonalAddAddress3,
    PersonalAddCity,
    PersonalAddState,
    PersonalAddCountry,
    PersonalAddPCode into Out_MailAddress1,
    Out_MailAddress2,
    Out_MailAddress3,
    Out_MailCity,
    Out_MailState,
    Out_MailCountry,
    Out_MailPostalCode from PersonalAddress where PersonalSysId = In_PersonalSysId and
    PersonalAddMailing = 1;
  set Out_JointResAddress=trim(Out_ResAddress1)+' '+trim(Out_ResAddress2)+' '+trim(Out_ResAddress3)+' '+
    trim(Out_ResCity)+' '+trim(Out_ResState)+' '+trim(Out_ResCountry)+' Poskod '+trim(Out_ResPostalCode);
  set Out_JointMailAddress=trim(Out_MailAddress1)+' '+trim(Out_MailAddress2)+' '+trim(Out_MailAddress3)+' '+
    trim(Out_MailCity)+' '+trim(Out_MailState)+' '+trim(Out_MailCountry)+' Poskod '+trim(Out_MailPostalCode);
  if(Out_ResAddress1 <> '') then
    if(Out_JointResAddress = Out_JointMailAddress) then
      set Out_JointAddress=''
    else
      set Out_JointAddress=Out_JointResAddress
    end if
  else
    set Out_JointAddress=''
  end if;
  return(Out_JointAddress)
end
;

create function DBA.FGetEmpCountOnFund(
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_FundType char(20))
returns double
begin
  declare EmpCount double;
  set EmpCount=0;
  //EmpCountLoop: for EmpCounFor as curs dynamic scroll cursor for
  if In_FundType = 'TotalCDAC' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where TotalCDAC <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'TotalMBMF' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where TotalMBMF <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'TotalSINDA' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where TotalSINDA <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'TotalCOMM' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where TotalCOMM <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'TotalEUCF' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where TotalEUCF <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'ContriSDF' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where ContriSDF <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'ContriFWL' then
    select count(In_FundType) into EmpCount from PeriodPolicySummary where ContriFWL <> 0 and PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  elseif In_FundType = 'TotalCPF' then
    select count('TotalContriEECPF') into EmpCount from PeriodPolicySummary where(TotalContriEECPF+TotalContriERCPF) <> 0 and
      PayRecPeriod = In_PayRecPeriod and PayRecYear = In_PayRecYear
  end if;
  return(EmpCount)
end
;

create function DBA.FGetEmployeeCalendarId(
in In_EmployeeSysId char(30))
returns char(20)
begin
  declare Out_CalendarId char(20);
  select CalendarId into Out_CalendarId from EmpeeWkCalen where
    EmployeeSysId = In_EmployeeSysId;
  return Out_CalendarId
end
;

create function DBA.FGetEmployeeCategory(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_CategoryId char(30);
  select Employee.CategoryId into Out_CategoryId
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_CategoryId)
end
;

create function DBA.FGetEmployeeCessationDate(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_EmployeeCessationDate char(40);
  select FGetDateFormat(Employee.CessationDate) into Out_EmployeeCessationDate
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeCessationDate)
end
;

create function DBA.FGetEmployeeCompanyName(
in In_EmployeeSysId char(20))
returns char(100)
begin
  declare Out_CompanyName char(100);
  select Company.CompanyName into Out_CompanyName
    from Company,Employee where Employee.EmployeeSysId = In_EmployeeSysId and
    Company.CompanyId = Employee.CompanyId;
  return(Out_CompanyName)
end
;

create function DBA.FGetEmployeeConfirmationDate(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_EmployeeConfirmationDate char(40);
  select FGetDateFormat(Employee.ConfirmationDate) into Out_EmployeeConfirmationDate
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeConfirmationDate)
end
;

create function DBA.FGetEmployeeCPFAge(
in in_EmployeeSysId integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer,
in in_PayRecSubPeriod integer)
returns double
begin
  declare in_StartDate date;
  declare in_DateOfBirth date;
  declare in_PayGroupId char(20);
  declare in_PersonalSysId integer;
  declare iEmpeeCPFAge double;
  declare TempAge double;
  select PayPayGroupId into in_PayGroupId from PayPeriodRecord where
    EmployeeSysId = in_EmployeeSysId and
    PayRecYear = in_PayRecYear and
    PayRecPeriod = in_PayRecPeriod;
  select PersonalSysId into in_PersonalSysId from Employee where
    EmployeeSysId = in_EmployeeSysId;
  select DateOfBirth into in_DateOfBirth from Personal where PersonalSysId = in_PersonalSysId;
  select SubPeriodStartDate into in_StartDate from PayGroupPeriod where
    PayGroupId = in_PayGroupId and
    PayGroupYear = in_PayRecYear and
    PayGroupPeriod = in_PayRecPeriod and
    PayGroupSubPeriod = 1;
  set TempAge=Months(in_DateOfBirth,in_StartDate);
  set iEmpeeCPFAge=Round(TempAge/12,2);
  return(iEmpeeCPFAge)
end
;

create function DBA.FGetEmployeeCurrentTotalWage(
in In_EmployeeSysId integer)
returns double
begin
  declare TotalWage double;
  declare Amount double;
  set TotalWage=0;
  select CurrentBasicRate into Amount from PayEmployee where
    EmployeeSysId = In_EmployeeSysId;
  set TotalWage=TotalWage+Amount;
  set Amount=0;
  if(IsWageElementInUsed('MVC','TotalWage') = 1) then
    select CurrentMVC into Amount from PayEmployeePolicy where
      EmployeeSysId = In_EmployeeSysId;
    if(Amount is null) then set Amount=0
    end if;
    set TotalWage=TotalWage+Amount
  end if;
  set Amount=0;
  if(IsWageElementInUsed('NWC','TotalWage') = 1) then
    select CurrentNWC into Amount from PayEmployeePolicy where
      EmployeeSysId = In_EmployeeSysId;
    if(Amount is null) then set Amount=0
    end if;
    set TotalWage=TotalWage+Amount
  end if;
  if(TotalWage is null) then
    set TotalWage=0
  end if;
  return TotalWage
end
;

create function DBA.FGetEmployeeDepartment(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_DepartmentId char(30);
  select Employee.DepartmentId into Out_DepartmentId
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_DepartmentId)
end
;

create function DBA.FGetEmployeeHireDate(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_EmployeeHireDate char(40);
  select FGetDateFormat(Employee.HireDate) into Out_EmployeeHireDate
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeHireDate)
end
;

create function DBA.FGetEmployeeId(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_EmployeeId char(30);
  select Employee.EmployeeId into Out_EmployeeId
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeId)
end
;

create function DBA.FGetEmployeeName(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_EmployeeName char(40);
  select Employee.EmployeeName into Out_EmployeeName
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeName)
end
;

create function DBA.FGetEmployeePersonalAddress(
in In_EmployeeId char(30),
in In_AddressLine integer)
returns char(40)
begin
  declare Out_PersonalAddress char(40);
  if(In_AddressLine = 1) then
    select PersonalAddress.PersonalAddAddress into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 2) then
    select PersonalAddress.PersonalAddAddress2 into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 3) then
    select PersonalAddress.PersonalAddAddress3 into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 4) then
    select PersonalAddress.PersonalAddCountry into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 5) then
    select PersonalAddress.PersonalAddState into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 6) then
    select PersonalAddress.PersonalAddCity into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  elseif(In_AddressLine = 7) then
    select PersonalAddress.PersonalAddPCode into Out_PersonalAddress
      from PersonalAddress join Personal where
      Personal.EmployeeId = In_EmployeeId and PersonalAddMailing = 1
  end if;
  return(Out_PersonalAddress)
end
;

create function DBA.FGetEmployeePosition(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_PositionId char(30);
  select Employee.PositionId into Out_PositionId
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_PositionId)
end
;

create function DBA.FGetEmployeePreviousTotalWage(
in In_EmployeeSysId integer)
returns double
begin
  declare TotalWage double;
  declare Amount double;
  set TotalWage=0;
  select PreviousBasicRate into Amount from PayEmployee where
    EmployeeSysId = In_EmployeeSysId;
  set TotalWage=TotalWage+Amount;
  set Amount=0;
  if(IsWageElementInUsed('MVC','TotalWage') = 1) then
    select PreviousMVC into Amount from PayEmployeePolicy where
      EmployeeSysId = In_EmployeeSysId;
    if(Amount is null) then set Amount=0
    end if;
    set TotalWage=TotalWage+Amount
  end if;
  set Amount=0;
  if(IsWageElementInUsed('NWC','TotalWage') = 1) then
    select PreviousNWC into Amount from PayEmployeePolicy where
      EmployeeSysId = In_EmployeeSysId;
    if(Amount is null) then set Amount=0
    end if;
    set TotalWage=TotalWage+Amount
  end if;
  if(TotalWage is null) then
    set TotalWage=0
  end if;
  return TotalWage
end
;

create function DBA.FGetEmployeeSection(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_SectionId char(30);
  select Employee.SectionId into Out_SectionId
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_SectionId)
end
;

create function dba.FGetEmployeeServiceYear(
in In_EmployeeSysId integer)
returns double
begin
  declare In_PayGroupId char(20);
  declare Out_CurrentYear integer;
  declare Out_CurrentPeriod integer;
  declare Out_CurrentSubPeriod integer;
  select PayGroupId into In_PayGroupId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  call ASQLCalCurrentPayPeriod(In_PayGroupId,Out_CurrentYear,Out_CurrentPeriod,Out_CurrentSubPeriod);
  return FGetPayServiceYear(In_EmployeeSysId,Out_CurrentYear,Out_CurrentPeriod,Out_CurrentSubPeriod)
end
;

create function Dba.FGetEmployerRefNo()
returns char(7)
begin
  declare fResult char(7);
  declare lastDigit char(1);
  declare cpfAccNo char(9);
  declare cpfAccNo_temp char(9);
  if exists(select CompanyGovACCNo from DBA.CompanyGov where CompanyGovCode = 'Employer CPF No') then
    select CompanyGovACCNo into cpfAccNo from DBA.CompanyGov where CompanyGovCode = 'Employer CPF No';
    set cpfAccNo_temp=cpfAccNo;
    set lastdigit=SUBSTR(cpfAccNo_temp,8,1);
    set fResult=FSetBlank(SUBSTR(cpfAccNo,1,6)+lastdigit,7,'R')
  else
    set fResult=FSetBlank(' ',7,'R')
  end if;
  return(fResult)
end
;

create function DBA.FGetEmpPaymentBankCount(
in In_EmployeeSysId char(20),
in In_PayBankSGSPGenId char(30),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30))
returns integer
begin
  declare count integer;
  set count=0;
  if(In_PayBankSGSPGenId = 'XX') then
    select count(*) into count from paymentbankinfo where employeesysid = In_EmployeeSysId and
      bankid = In_BankId and
      bankbranchid = In_BankBranchId and
      bankaccountno = In_BankAccountNo
  else
    select count(*) into count from paymentbankinfo where employeesysid = In_EmployeeSysId and
      bankid = In_BankId and
      bankbranchid = In_BankBranchId and
      bankaccountno = In_BankAccountNo and
      PayBankSGSPGenId <> In_PayBankSGSPGenId
  end if;
  return(count)
end
;

create function DBA.FGetEPProgPrevProgDate(
in In_EmployeeSysId integer,
in In_EPEffectiveDate date)
returns date
begin
  declare Out_PrevEPEffectiveDate date;
  select max(EPEffectiveDate) into Out_PrevEPEffectiveDate from EmployPassProgression where
    EmployeeSysId = In_EmployeeSysId and
    EPEffectiveDate < In_EPEffectiveDate;
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EPEffectiveDate = Out_PrevEPEffectiveDate) then
    update EmployPassProgression set
      EmployPassProgression.EPCurrent = 1 where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = Out_PrevEPEffectiveDate;
    commit work
  end if;
  return(Out_PrevEPEffectiveDate)
end
;

create function DBA.FGetFormulaCategory(
in In_FormulaID char(20))
returns char(20)
begin
  declare fresult char(20);
  select Formulacategory into fresult from Formula where FormulaID = In_FormulaID;
  return(fresult)
end
;

create function DBA.FGetFormulaDesc(
in In_FormulaID char(20))
returns char(100)
begin
  declare fresult char(100);
  select FormulaDesc into fresult from Formula where FormulaID = In_FormulaID;
  if fresult is null then set fresult=''
  end if;
  return(fresult)
end
;

create function dba.FGetFormulaIDProperty(
in In_FormulaID char(20))
returns char(1)
begin
  declare formulaIDProperty char(1);
  if IsFormulaIdHasProperty(In_FormulaID,'SubjAdditional') = 1 then
    set formulaIDProperty='A'
  elseif IsFormulaIdHasProperty(In_FormulaID,'SubjOrdinary') = 1 then set formulaIDProperty='O'
  else set formulaIDProperty='N'
  end if;
  return(formulaIDProperty)
end
;

create function dba.FGetFormulaRange(
in In_FormulaId char(20),
in In_RangeValue double)
returns double
begin
  declare FormulaValue double;
  select Constant1 into FormulaValue from Formula join Formularange where
    FormulaType = 'Tabulated' and
    Formula.FormulaId = In_FormulaId and
    In_RangeValue >= Minimum and
    In_RangeValue < Maximum;
  return FormulaValue
end
;

create function DBA.FGetFormulaSubCategory(
in In_FormulaID char(20))
returns char(20)
begin
  declare fresult char(20);
  select FormulaSubcategory into fresult from Formula where FormulaID = In_FormulaID;
  return(fresult)
end
;

create function dba.FGetFWLProgPrevProgDate(
in In_EmployeeSysId integer,
in In_FWLEffectiveDate date)
returns date
begin
  declare Out_PrevFWLEffectiveDate date;
  select max(FWLEffectiveDate) into Out_PrevFWLEffectiveDate from FWLProgression where
    EmployeeSysId = In_EmployeeSysId and
    FWLEffectiveDate < In_FWLEffectiveDate;
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLEffectiveDate = Out_PrevFWLEffectiveDate) then
    update FWLProgression set
      FWLProgression.FWLCurrent = 1 where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = Out_PrevFWLEffectiveDate;
    commit work
  end if;
  return(Out_PrevFWLEffectiveDate)
end
;

create function DBA.FGetIdentityNo(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_IdentityNo char(30);
  select Employee.IdentityNo into Out_IdentityNo
    from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_IdentityNo)
end
;

create function DBA.FGetInvalidDate(
in In_CheckDate date)
returns char(30)
begin
  declare Out_Date char(30);
  if(In_CheckDate = '1899/12/30') then
    return ''
  end if;
  return(In_CheckDate)
end
;

create function dba.FGetKeyWordUserDefinedName(
in In_KeyWordId char(20))
returns char(100)
begin
  declare Out_KeyWordUserDefinedName char(100);
  select KeyWordUserDefinedName into Out_KeyWordUserDefinedName from keyword where
    KeyWordId = In_KeyWordId;
  if(Out_KeyWordUserDefinedName is null or Out_KeyWordUserDefinedName = '') then
    return(In_KeyWordId)
  else return(Out_KeyWordUserDefinedName)
  end if
end
;

create function DBA.FGetLastPayDate(
in in_EmployeeSysId integer)
returns date
begin
  declare Out_LastPayDate date;
  select LastPayDate into Out_LastPayDate from PayEmployee where
    EmployeeSysId = in_EmployeeSysId;
  return Out_LastPayDate
end
;

create function DBA.FGetMasnetDetailLine(
in In_Type char(9),
in in_EmployeeSysID integer,
in in_Year integer,
in in_Period integer,
in in_AdviceCode char(2),
in In_NegativeToZero smallint)
returns char(100)
begin
  declare result char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare relevantMonth char(6);
  declare code char(2);
  declare cpfAccNo char(9);
  declare amount double;
  declare ordWages double;
  declare empStatus char(1);
  declare eeName char(30);
  declare addWages double;
  declare cpfclass char(20);
  set company_cpfAccNo=FGetEmployerRefNo(*);
  if In_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(In_AdviceCode,2,'L')
  end if;
  set relevantMonth=Trim(Str(in_Year))+Trim(FAddZero(in_Period,2,'L'));
  select FGetCPFAccNoFormat(in_EmployeeSySId) into cpfAccNo;
  select CPFClass into cpfclass from periodpolicysummary where employeesysid = in_EmployeeSysID and payrecyear = in_Year and payrecperiod = in_Period;
  if In_Type = 'CPF' then
    select '01',FCPFConvertNegativeToZero(totalContrieeCPF+totalContriErCPF,In_NegativeToZero),FCPFConvertNegativeToZero(CurOrdinaryWage,In_NegativeToZero),FCPFConvertNegativeToZero(CurAdditionalWage,In_NegativeToZero) into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'MBMF' then
    select '02',(totalMBMF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'SINDA' then
    select '03',(totalSINDA),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CDAC' then
    select '04',(totalCDAC),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'EUCF' then
    select '05',(totalEUCF),0,0 into code,
      amount,ordWages,
      addWages from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  end if;
  if In_Type = 'CPF' then select(case when CPFStatus = 'CPFExisting' then 'E'
      when CPFStatus = 'CPFCessation' then 'L'
      when CPFStatus = 'CPFNewJoin' then 'N'
      when CPFStatus = 'CPFJoinLeave' then 'O' else ' '
      end) into empStatus from PeriodPolicySummary where
      payRecPeriod = In_Period and
      payRecYear = In_Year and
      employeeSysId = In_EmployeeSysID
  else set empStatus=' '
  end if;
  select distinct EmployeeName into eeName from employee where EmployeeSysId = In_EmployeeSysId;
  set result=FSetBlank('1'+
    FSetBlank(company_cpfAccNo,7,'R')+' '+
    adviceCode+
    relevantMonth+
    code+
    cpfAccNo+
    FAddZero(FRemoveDecimal(amount),8,'L')+
    FAddZero(FRemoveDecimal(ordWages),10,'L')+
    empStatus+
    FSetBlank(Upper(SubStr(eeName,1,22)),22,'R')+
    FAddZero(FRemoveDecimal(addWages),10,'L'),
    100,'R');
  if(In_Type = 'CPF') then
    if(cpfclass = 'FW' or cpfclass = 'EP') then
      if amount <> 0 then
        return(result)
      else
        return('')
      end if
    else return(result)
    end if
  else
    if(amount <> 0) then
      return(result)
    else
      return('')
    end if
  end if
end
;

create function DBA.FGetMasnetHeaderLine(
in in_AdviceCode char(2),
in In_mailBoxId char(8))
returns char(100)
begin
  declare fResult char(100);
  declare company_cpfAccNo char(7);
  declare adviceCode char(2);
  declare creationDate char(8);
  declare creationTime char(6);
  set company_cpfAccNo=FGetEmployerRefNo(*);
  if in_AdviceCode = '' then set adviceCode='  '
  else set adviceCode=FAddZero(in_AdviceCode,2,'L')
  end if;
  set creationDate=DateFormat(Now(*),'yyyymmdd');
  set creationTime=DateFormat(Now(*),'hhmmss');
  set fResult=' '+FSetBlank(FGetEmployerRefNo(*),7,'R')+' '+
    adviceCode+
    FSetBlank(creationDate+
    creationTime+'MASNET-CPFPMT'+
    In_MailBoxId,
    91,'R');
  return(fResult)
end
;

create function DBA.FGetMasnetNJEHeaderLine(
in In_mailBoxId char(8),
in In_BankCode char(4),
in In_DocID char(28))
returns char(100)
begin
  declare fResult char(100);
  declare creationDate char(8);
  declare creationTime char(6);
  set creationDate=DateFormat(Now(*),'yyyymmdd');
  set creationTime=DateFormat(Now(*),'hhmmss');
  set fResult=FSetBlank('HEADER'+
    FSetBlank(In_mailBoxId,8,'R')+'C1  '+
    FSetBlank(In_BankCode,4,'R')+'0100'+
    creationDate+
    creationTime+'0001'+
    FSetBlank(In_DocID,28,'R'),
    100,'R');
  return(fResult)
end
;

create function DBA.FGetMaxPeriod(
in In_EmployeeSysId integer,
in In_Year integer)
returns integer
begin
  declare Out_MaxPeriod integer;
  select Max(PayRecPeriod) into Out_MaxPeriod from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_Year;
  return Out_MaxPeriod
end
;

create function DBA.FGetMinPeriod(
in In_EmployeeSysId integer,
in In_Year integer)
returns integer
begin
  declare Out_MinPeriod integer;
  select Min(PayRecPeriod) into Out_MinPeriod from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_Year;
  return Out_MinPeriod
end
;

create function DBA.FGetMVCCurrentAccPercent(
in In_EmployeeSysId integer)
returns double
begin
  declare Out_BRProgDate date;
  declare Out_AccMVC double;
  select BRProgDate into Out_BRProgDate from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and
    BRProgCurrent = 1;
  if(Out_BRProgDate is null) then return 0
  end if;
  select sum(MVCPercentage) into Out_AccMVC from PolicyProgression where EmployeeSysId = In_EmployeeSysId and
    BRProgDate <= Out_BRProgDate;
  if(Out_AccMVC is null) then return 0
  end if;
  return Out_AccMVC
end
;

create function DBA.FGetMVCPrevRate(
in In_EmployeeSysId integer,
in In_BRProgDate date)
returns double
begin
  declare Out_PrevBRProgDate date;
  declare Out_MVCNewRate double;
  select max(BRProgDate) into Out_PrevBRProgDate from PolicyProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate <= in_BRProgDate;
  if Out_PrevBRProgDate is null then return 0
  end if;
  select MVCNewRate into Out_MVCNewRate from PolicyProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate = Out_PrevBRProgDate;
  return Out_MVCNewRate
end
;

create function dba.FGetNewCPFGeneratedIndex(
in In_SGSPIndexGeneratorTbl char(5))
returns char(20)
begin
  declare Char_SGSPIndexGenCurrPreFix char(2);
  declare Int_SGSPIndexGenLastNum integer;
  declare Char_GeneratedIndex char(30);
  declare Char_PreFix char(20);
  if not exists(select* from SGSPIndexGenerator where
      SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix='A';
    set Char_PreFix=INSERTSTR(0,'-'+Char_SGSPIndexGenCurrPreFix,In_SGSPIndexGeneratorTbl);
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),Char_PreFix);
    insert into SGSPIndexGenerator(SGSPIndexGeneratorTbl,SGSPIndexGenCurrPreFix,SGSPIndexGenLastNum) values(
      In_SGSPIndexGeneratorTbl,Char_SGSPIndexGenCurrPreFix,Int_SGSPIndexGenLastNum);
    return(Char_GeneratedIndex)
  end if;
  select SGSPIndexGenCurrPreFix,SGSPIndexGenLastNum into Char_SGSPIndexGenCurrPreFix,
    Int_SGSPIndexGenLastNum from SGSPIndexGenerator where
    SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  if(Int_SGSPIndexGenLastNum > 2147483646) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix="CHAR"(ASCII(Char_SGSPIndexGenCurrPreFix)+1)
  else
    set Int_SGSPIndexGenLastNum=Int_SGSPIndexGenLastNum+1
  end if;
  set Char_PreFix=INSERTSTR(0,'-'+Char_SGSPIndexGenCurrPreFix,In_SGSPIndexGeneratorTbl);
  set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),Char_PreFix);
  update SGSPIndexGenerator set
    SGSPIndexGenCurrPreFix = Char_SGSPIndexGenCurrPreFix,
    SGSPIndexGenLastNum = Int_SGSPIndexGenLastNum where
    SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  return(Char_GeneratedIndex)
end
;

create function DBA.FGetNWCPrevRate(
in In_EmployeeSysId integer,
in In_BRProgDate date)
returns double
begin
  declare Out_PrevBRProgDate date;
  declare Out_NWCNewRate double;
  select max(BRProgDate) into Out_PrevBRProgDate from PolicyProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate <= in_BRProgDate;
  if Out_PrevBRProgDate is null then return 0
  end if;
  select NWCNewRate into Out_NWCNewRate from PolicyProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate = Out_PrevBRProgDate;
  return Out_NWCNewRate
end
;

create function DBA.FGetOTElementYTD(
in In_DepartmentID char(20),
in In_OTFormulaID char(20),
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer)
returns double
begin
  declare fresult double;
  declare YTDamount double;
  declare YTDamountTotal double;
  set YTDamountTotal=0;
  if In_DepartmentID = 'Company' then
    if(YTDFromYear = YTDToYear) then
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        D.PayRecYear = YTDFromYear and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  end if;
  return(fresult)
end
;

create function DBA.FGetOTOvertimeAmount(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_OvertimeAmount double)
returns double
begin
  declare In_OTTableId char(20);
  declare In_MaxOvertimeAmount double;
  declare In_MinOvertimeAmount double;
  declare Out_OTOvertimeAmount double;
  set Out_OTOvertimeAmount=In_OvertimeAmount;
  select EEOTTableId into In_OTTableId from SubPeriodSetting where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    EmployeeSysId = In_EmployeeSysId;
  select MaxOvertimeAmount,MinOvertimeAmount into In_MaxOvertimeAmount,In_MinOvertimeAmount from Overtime where OTTableId = In_OTTableId;
  if(Out_OTOvertimeAmount > In_MaxOvertimeAmount and In_MaxOvertimeAmount <> 0) then set Out_OTOvertimeAmount=In_MaxOvertimeAmount
  end if;
  if(Out_OTOvertimeAmount < In_MinOvertimeAmount and In_MinOvertimeAmount <> 0 and Out_OTOvertimeAmount <> 0) then
    set Out_OTOvertimeAmount=In_MinOvertimeAmount
  end if;
  return(Out_OTOvertimeAmount)
end
;

create function DBA.FGetOTTotalWage(
in In_EmployeeSysId char(20),
in In_TotalWage double)
returns double
begin
  declare In_OTTableId char(20);
  declare In_MaxTotalWage double;
  declare In_MinTotalWage double;
  declare Out_OTTotalWage double;
  set Out_OTTotalWage=In_TotalWage;
  select OTTableId into In_OTTableId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  select MaxTotalWage into In_MaxTotalWage from Overtime where OTTableId = In_OTTableId;
  select MinTotalWage into In_MinTotalWage from Overtime where OTTableId = In_OTTableId;
  if(Out_OTTotalWage > In_MaxTotalWage and In_MaxTotalWage <> 0) then set Out_OTTotalWage=In_MaxTotalWage
  end if;
  if(Out_OTTotalWage < In_MinTotalWage and In_MinTotalWage <> 0) then set Out_OTTotalWage=In_MinTotalWage
  end if;
  return(Out_OTTotalWage)
end
;

create function DBA.FGetOTType(
in In_FormulaID char(20))
returns char(20)
begin
  declare fresult char(20);
  select distinct FGetKeywordUSerDefinedName(OTType) into fresult from OTRecord where OTFormulaID = In_FormulaID;
  return(fresult)
end
;

create function DBA.FGetPayAllocationTypeID(
in In_EmployeeSysId char(20),
in In_PayAllocationSubPeriod integer)
returns char(20)
begin
  declare Out_PayAllocationTypeId char(20);
  select PayAllocation.PayAllocationTypeId into Out_PayAllocationTypeId from
    PayAllocation where PayAllocation.EmployeeSysId = In_EmployeeSysId and
    PayAllocation.PayAllocationSubPeriod = In_PayAllocationSubPeriod;
  return(Out_PayAllocationTypeId)
end
;

create function DBA.FGetPayAllocationValue(
in In_EmployeeSysId char(20),
in In_PayAllocationSubPeriod integer)
returns double
begin
  declare Out_PayAllocationValue double;
  select PayAllocation.PayAllocationValue into Out_PayAllocationValue from
    PayAllocation where PayAllocation.EmployeeSysId = In_EmployeeSysId and
    PayAllocation.PayAllocationSubPeriod = In_PayAllocationSubPeriod;
  return(Out_PayAllocationValue)
end
;

create function DBA.FGetPayDepartmentID(
in in_EmployeeSysId integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer)
returns char(100)
begin
  declare Out_PayDepartmentID char(100);
  select PayDepartmentId into Out_PayDepartmentId from PayPeriodRecord where
    EmployeeSysId = in_EmployeeSysId and
    PayRecYear = in_PayRecYear and
    PayRecPeriod = in_PayRecPeriod;
  if Out_PayDepartmentID is null then set Out_PayDepartmentID=''
  end if;
  return Out_PayDepartmentID
end
;

create function DBA.FGetPayEmployeeAge(
in in_EmployeeSysId integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer,
in in_PayRecSubPeriod integer)
returns double
begin
  declare in_StartDate date;
  declare in_DateOfBirth date;
  declare in_PayGroupId char(20);
  declare in_PersonalSysId integer;
  select PayGroupId into in_PayGroupId from PayEmployee where
    EmployeeSysId = in_EmployeeSysId;
  select PersonalSysId into in_PersonalSysId from Employee where
    EmployeeSysId = in_EmployeeSysId;
  select DateOfBirth into in_DateOfBirth from Personal where PersonalSysId = in_PersonalSysId;
  select SubPeriodStartDate into in_StartDate from PayGroupPeriod where
    PayGroupId = in_PayGroupId and
    PayGroupYear = in_PayRecYear and
    PayGroupPeriod = in_PayRecPeriod and
    PayGroupSubPeriod = in_PayRecSubPeriod;
  return round(cast(Months(in_DateOfBirth,in_StartDate) as double)/12,2)
end
;

create function DBA.FGetPayGroupID(
in in_EmployeeSysId integer)
returns char(100)
begin
  declare Out_PayGroupID char(100);
  select PayGroupId into Out_PayGroupId from PayEmployee where
    EmployeeSysId = in_EmployeeSysId;
  return Out_PayGroupID
end
;

create function dba.FGetPayIncrementDesc(
in In_PayIncrementId char(20))
returns char(80)
begin
  declare Out_PayIncrementDesc char(80);
  select PayIncrementCode.PayIncrementDesc into Out_PayIncrementDesc
    from PayIncrement where
    PayIncrement.PayIncrementId = In_PayIncrementId;
  return(Out_PayIncrementDesc)
end
;

create function DBA.FGetPaymentMethod(
in In_BankRecSGSPGenId char(30))
returns char(100)
begin
  declare Out_PaymentCategory char(20);
  declare Out_BankId char(20);
  declare Out_BankBrId char(20);
  declare Out_AccountNo char(30);
  select PaymentCategory,
    PaymentBankCode,
    PaymentBankBrCode,
    PaymentBankAccNo into Out_PaymentCategory,
    Out_BankId,
    Out_BankBrId,
    Out_AccountNo from BankRecord where BankRecord.BankRecSGSPGenId = In_BankRecSGSPGenId;
  if(Out_PaymentCategory = 'ByBank') then
    return substr(Out_BankId,1,10)+'-'+substr(Out_BankBrId,1,10)+'-'+substr(Out_AccountNo,1,30)
  elseif(Out_PaymentCategory = 'ByCash') then
    return 'Cash'
  elseif(Out_PaymentCategory = 'ByCheque') then
    return 'Cheque : '+substr(Out_AccountNo,1,30)
  end if
end
;

create function dba.FGetPayPeriodBank1AccNo(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankAccNo into BankName,
    BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankAccNo is null then set BankAccNo=''
  end if;
  return BankAccNo
end
;

create function dba.FGetPayPeriodBank1Amount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns double
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare TotalAmount double;
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set TotalAmount=0
  else
    set TotalAmount=null;
    select Sum(PaymentAmt) into TotalAmount from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo and
    (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if TotalAmount is null then set TotalAmount=0
    end if
  end if;
  return TotalAmount
end
;

create function dba.FGetPayPeriodBank1Branch(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankBrCode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankBrCode into BankName,
    BankBrCode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankBrCode is null then set BankBrCode=''
  end if;
  return BankBrCode
end
;

create function dba.FGetPayPeriodBank1Code(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankCode into BankName,
    BankCode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then set BankCode=''
  end if;
  return BankCode
end
;

create function dba.FGetPayPeriodBank1Name(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  select first FGetBankName(PaymentBankCode) into BankName from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then set BankName=''
  end if;
  return BankName
end
;

create function dba.FGetPayPeriodBank1PaymentMode(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankMode char(20);
  select first FGetBankName(PaymentBankCode),PaymentMode into BankName,
    BankMode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankMode is null then set BankMode=''
  end if;
  return BankMode
end
;

create function dba.FGetPayPeriodBank2AccNo(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankAccNo is null then
    set BankAccNo=''
  else
    set BankAccNo=null;
    select first FGetBankName(PaymentBankCode),PaymentBankAccNo into BankName,BankAccNo from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankAccNo is null then set BankAccNo=''
    end if
  end if;
  return BankAccNo
end
;

create function dba.FGetPayPeriodBank2Amount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns double
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare BankName2 char(60);
  declare BankCode2 char(20);
  declare BankBrCode2 char(20);
  declare BankAccNo2 char(30);
  declare TotalAmount double;
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set TotalAmount=0
  else
    set TotalAmount=0;
    select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
      PaymentBankAccNo into BankName2,BankCode2,BankBrCode2,BankAccNo2 from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankName2 is null then
      set TotalAmount=0
    else
      select Sum(PaymentAmt) into TotalAmount from BankRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PaymentBankCode = BankCode2 and PaymentBankBrCode = BankBrCode2 and PaymentBankAccNo = BankAccNo2 and
        (((select first PayRecType from PayRecord where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_PayRecYear and
          PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_PayRecYear and
          PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_PayRecYear and
          PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_PayRecYear and
          PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
        BankName asc;
      if BankName is null then
        set TotalAmount=0
      end if
    end if
  end if;
  return TotalAmount
end
;

create function dba.FGetPayPeriodBank2Branch(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankBrCode is null then
    set BankBrCode=''
  else
    set BankBrCode=null;
    select first FGetBankName(PaymentBankCode),PaymentBankBrCode into BankName,BankBrCode from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankBrCode is null then set BankBrCode=''
    end if
  end if;
  return BankBrCode
end
;

create function dba.FGetPayPeriodBank2Code(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankCode is null then
    set BankCode=''
  else
    set BankCode=null;
    select first FGetBankName(PaymentBankCode),PaymentBankCode into BankName,BankCode from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankCode is null then set BankCode=''
    end if
  end if;
  return BankCode
end
;

create function dba.FGetPayPeriodBank2Name(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set BankName=''
  else
    set BankName=null;
    select first FGetBankName(PaymentBankCode) into BankName from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankName is null then set BankName=''
    end if
  end if;
  return BankName
end
;

create function dba.FGetPayPeriodBank2PaymentMode(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare BankMode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set BankMode=''
  else
    set BankMode=null;
    select first FGetBankName(PaymentBankCode),PaymentMode into BankName,BankMode from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankMode is null then set BankMode=''
    end if
  end if;
  return BankMode
end
;

create function Dba.FGetPayPeriodPayGroupId(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare PayGroupID char(20);
  select PayPayGroupID into PayGroupID
    from PayPeriodRecord where
    EmployeeSysID = In_EmployeeSysID and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if PayGroupID is null then set PayGroupID=''
  end if;
  return PayGroupID
end
;

create function dba.FGetPayRecAllAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Allowance' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecAllDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Deduction' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecAllPayElement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecAllReimbursement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Reimbursement' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPayRecBackPayOT(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare Out_BackPayOT double;
  select Sum(BackPayOTAmount) into Out_BackPayOT from OTRecord where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId and
    EmployeeSysId = In_EmployeeSysId;
  if Out_BackPayOT is null then set Out_BackPayOT=0
  end if;
  return(Out_BackPayOT)
end
;

create function dba.FGetPayRecCPFAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') = 1)
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') = 1)
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') = 1)
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') = 1)
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') = 1)
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPayRecCPFAmountYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  if(In_PayRecID = 'All') then
    YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
      select TotalContriEECPF,TotalContriERCPF,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+TotalContriEECPF+TotalContriERCPF
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+TotalContriEECPF+TotalContriERCPF
      end if end for
  else
    YTDTakenLoop: for YTDTakenFor as curs1 dynamic scroll cursor for
      select TotalContriEECPF,TotalContriERCPF,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecID = In_PayRecID and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+TotalContriEECPF+TotalContriERCPF
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+TotalContriEECPF+TotalContriERCPF
      end if end for
  end if;
  return YTDTaken
end
;

create function dba.FGetPayRecCPFDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') = 1)
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') = 1)
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') = 1)
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') = 1)
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') = 1)
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPayRecCPFWageYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  if(In_PayRecID = 'All') then
    YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
      select CPFWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CPFWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CPFWage
      end if end for
  else
    YTDTakenLoop: for YTDTakenFor as curs1 dynamic scroll cursor for
      select CPFWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecID = In_PayRecID and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CPFWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CPFWage
      end if end for
  end if;
  return YTDTaken
end
;

create function DBA.FGetPayRecGrossWageYTD(in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  if(In_PayRecID = 'All') then
    YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
      select CalGrossWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalGrossWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalGrossWage
      end if end for
  else
    YTDTakenLoop: for YTDTakenFor as curs1 dynamic scroll cursor for
      select CalGrossWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecId = In_PayRecID and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalGrossWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalGrossWage
      end if end for
  end if;
  return YTDTaken
end
;

create function DBA.FGetPayRecLeaveBalance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare In_LveBroughtForward double;
  declare In_CurrLveEntitlement double;
  declare In_LvePeriodTaken double;
  select LveBroughtForward into In_LveBroughtForward from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeFunctCode = In_LeaveType and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  select CurrLveEntitlement into In_CurrLveEntitlement from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeFunctCode = In_LeaveType and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  select CurrLvePeriodTaken into In_LvePeriodTaken from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    LeaveTypeFunctCode = In_LeaveType and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod;
  return In_LveBroughtForward+
    In_CurrLveEntitlement-
    FGetPayRecYTDTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_LeaveType)-
    In_LvePeriodTaken
end
;

create function DBA.FGetPayRecLveDedYTDDayTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrentLveDays,PayRecPeriod,PayRecSubPeriod from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = In_LeaveType and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CurrentLveDays
    elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod < In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CurrentLveDays
    end if end for;
  return YTDTaken
end
;

create function DBA.FGetPayRecLveDedYTDHoursTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrentLveHours,PayRecPeriod,PayRecSubPeriod from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = In_LeaveType and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CurrentLveHours
    elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod < In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CurrentLveHours
    end if end for;
  return YTDTaken
end
;

create function DBA.FGetPayRecNetWageYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  if(In_PayRecID = 'All') then
    YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
      select CalNetWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalNetWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalNetWage
      end if end for
  else
    YTDTakenLoop: for YTDTakenFor as curs1 dynamic scroll cursor for
      select CalNetWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecId = In_PayRecID and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalNetWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalNetWage
      end if end for
  end if;
  return YTDTaken
end
;

create function dba.FGetPayRecNonCPFAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') <> 1
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') <> 1
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') <> 1
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') <> 1
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') <> 1
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') <> 1
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') <> 1
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecNonCPFDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') <> 1
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') <> 1
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') <> 1
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') <> 1
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') <> 1
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') <> 1
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') <> 1
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecPayGroup(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Out_PayGroup char(20);
  select PayPayGroupId into Out_PayGroup from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  return Out_PayGroup
end
;

create function DBA.FGetPayRecTotalGrossWageYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  if(In_PayRecID = 'All') then
    YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
      select CalTotalGrossWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalTotalGrossWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalTotalGrossWage
      end if end for
  else
    YTDTakenLoop: for YTDTakenFor as curs1 dynamic scroll cursor for
      select CalTotalGrossWage,PayRecPeriod,PayRecSubPeriod,PayRecYear,PayRecID,EmployeeSysId from DetailRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecId = In_PayRecID and
        PayRecYear = In_PayRecYear and
        PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
      if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CalTotalGrossWage
      elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CalTotalGrossWage
      end if end for
  end if;
  return YTDTaken
end
;

create function DBA.FGetPayRecTotalOT(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare Out_TotalOT double;
  declare Out_TotalFreq double;
  declare In_MaxOTAmount double;
  declare In_MinOTAmount double;
  declare In_OTTableId char(20);
  select EEOTTableId into In_OTTableId from SubPeriodSetting where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    EmployeeSysId = In_EmployeeSysId;
  if In_OTTableId is null then set Out_TotalOT=0
  else
    select MaxOvertimeAmount,MinOvertimeAmount into In_MaxOTAmount,In_MinOTAmount from Overtime where OTTableId = In_OTTableId;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount),Sum(CurrentOTFreq)+Sum(LastOTFreq) into Out_TotalOT,Out_TotalFreq from OTRecord where
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecId = In_PayRecId and
      EmployeeSysId = In_EmployeeSysId;
    if Out_TotalOT is null then set Out_TotalOT=0
    end if;
    if Out_TotalFreq is null then set Out_TotalFreq=0
    end if;
    if(Out_TotalOT > In_MaxOTAmount and In_MaxOTAmount <> 0) then set Out_TotalOT=In_MaxOTAmount
    end if;
    if(Out_TotalOT < In_MinOTAmount and In_MinOTAmount <> 0 and Out_TotalFreq <> 0) then set Out_TotalOT=In_MinOTAmount
    end if
  end if;
  return(Round(Out_TotalOT,FGetDBPayDecimal(*)))
end
;

create function DBA.FGetPayRecType(
in in_EmployeeSysID integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer,
in in_PayRecSubPeriod integer,
in in_PayRecID char(100))
returns char(100)
begin
  declare out_PayRecType char(100);
  select distinct PayRecType into out_PayRecType from PayRecord where
    EmployeeSysID = in_EmployeeSysID and
    PayRecYear = in_PayRecYear and
    PayRecPeriod = in_PayRecPeriod and
    PayRecSubPeriod = in_PayRecSubPeriod and
    PayRecID = in_PayRecID;
  return out_PayRecType
end
;

create function DBA.FGetPayRecYTDLeaveTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrLvePeriodTaken,PayRecPeriod,PayRecSubPeriod from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = In_LeaveType and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CurrLvePeriodTaken
    elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod <= In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CurrLvePeriodTaken
    end if end for;
  return YTDTaken
end
;

create function DBA.FGetPayRecYTDTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrLvePeriodTaken,PayRecPeriod,PayRecSubPeriod from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = In_LeaveType and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod < In_PayRecPeriod) then set YTDTaken=YTDTaken+CurrLvePeriodTaken
    elseif(PayRecPeriod = In_PayRecPeriod and PayRecSubPeriod < In_PayRecSubPeriod) then set YTDTaken=YTDTaken+CurrLvePeriodTaken
    end if end for;
  return YTDTaken
end
;

create function DBA.FGetPayServiceYear(
in in_EmployeeSysId integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer,
in in_PayRecSubPeriod integer)
returns double
begin
  declare in_HireDate date;
  declare in_EndDate date;
  declare in_PayGroupId char(20);
  declare in_PreviousSvcYear double;
  declare Out_ServiceYear double;
  select PayGroupId into in_PayGroupId from PayEmployee where EmployeeSysId = in_EmployeeSysId;
  select HireDate into in_HireDate from Employee where EmployeeSysId = in_EmployeeSysId;
  select SubPeriodEndDate into in_EndDate from PayGroupPeriod where
    PayGroupId = in_PayGroupId and
    PayGroupYear = in_PayRecYear and
    PayGroupPeriod = in_PayRecPeriod and
    PayGroupSubPeriod = in_PayRecSubPeriod;
  select PreviousSvcYear into in_PreviousSvcYear from Employee where EmployeeSysId = in_EmployeeSysId;
  set Out_ServiceYear=round(cast(Months(in_HireDate,in_EndDate) as double)/12,2)+in_PreviousSvcYear;
  if(Out_ServiceYear < 0) then set Out_ServiceYear=0
  end if;
  return Out_ServiceYear
end
;

create function dba.FGetPayTypeAllAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Allowance' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayTypeAllDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Deduction' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayTypeAllReimbursement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Reimbursement' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayTypeBank1AccNo(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankAccNo into BankName,
    BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankAccNo is null then set BankAccNo=''
  end if;
  return BankAccNo
end
;

create function dba.FGetPayTypeBank1Amount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns double
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare TotalAmount double;
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set TotalAmount=0
  else
    set TotalAmount=null;
    select Sum(PaymentAmt) into TotalAmount from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if TotalAmount is null then set TotalAmount=0
    end if
  end if;
  return TotalAmount
end
;

create function dba.FGetPayTypeBank1Branch(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankBrCode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankBrCode into BankName,
    BankBrCode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankBrCode is null then set BankBrCode=''
  end if;
  return BankBrCode
end
;

create function dba.FGetPayTypeBank1Code(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankCode into BankName,
    BankCode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then set BankCode=''
  end if;
  return BankCode
end
;

create function dba.FGetPayTypeBank1Name(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  select first FGetBankName(PaymentBankCode) into BankName from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then set BankName=''
  end if;
  return BankName
end
;

create function dba.FGetPayTypeBank1PaymentMode(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankMode char(20);
  select first FGetBankName(PaymentBankCode),PaymentMode into BankName,
    BankMode from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankMode is null then set BankMode=''
  end if;
  return BankMode
end
;

create function dba.FGetPayTypeBank2AccNo(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare BankAccNo2 char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankAccNo is null then
    set BankAccNo2=''
  else
    set BankAccNo2=null;
    select first FGetBankName(PaymentBankCode),PaymentBankAccNo into BankName,BankAccNo2 from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankAccNo2 is null then set BankAccNo2=''
    end if
  end if;
  return BankAccNo2
end
;

create function dba.FGetPayTypeBank2Amount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns double
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare BankName2 char(60);
  declare BankCode2 char(20);
  declare BankBrCode2 char(20);
  declare BankAccNo2 char(30);
  declare TotalAmount double;
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankCode is null then
    set TotalAmount=0
  else
    set TotalAmount=0;
    select first PaymentAmt,FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
      PaymentBankAccNo into TotalAmount,BankName2,BankCode2,BankBrCode2,BankAccNo2 from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if TotalAmount is null then
      set TotalAmount=0
    end if
  end if;
  return TotalAmount
end
;

create function dba.FGetPayTypeBank2Branch(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankBrCode2 char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankBrCode is null then
    set BankBrCode2=''
  else
    set BankBrCode2=null;
    select first FGetBankName(PaymentBankCode),PaymentBankBrCode into BankName,BankBrCode2 from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankBrCode2 is null then set BankBrCode2=''
    end if
  end if;
  return BankBrCode2
end
;

create function dba.FGetPayTypeBank2Code(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankCode2 char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankCode is null then
    set BankCode2=''
  else
    set BankCode2=null;
    select first FGetBankName(PaymentBankCode),PaymentBankCode into BankName,BankCode2 from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankCode2 is null then set BankCode2=''
    end if
  end if;
  return BankCode2
end
;

create function dba.FGetPayTypeBank2Name(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankCode is null then
    set BankName=''
  else
    set BankName=null;
    select first FGetBankName(PaymentBankCode) into BankName from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankName is null then set BankName=''
    end if
  end if;
  return BankName
end
;

create function dba.FGetPayTypeBank2PaymentMode(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecType1 char(20),
in In_PayRecType2 char(20),
in In_PayRecType3 char(20),
in In_PayRecType4 char(20))
returns char(60)
begin
  declare BankName char(60);
  declare BankCode char(20);
  declare BankBrCode char(20);
  declare BankAccNo char(30);
  declare BankMode char(20);
  select first FGetBankName(PaymentBankCode),PaymentBankCode,PaymentBankBrCode,
    PaymentBankAccNo into BankName,BankCode,BankBrCode,BankAccNo from BankRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    (((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
    BankName asc;
  if BankName is null then
    set BankMode=''
  else
    set BankMode=null;
    select first FGetBankName(PaymentBankCode),PaymentMode into BankName,BankMode from BankRecord where
      EmployeeSysId = In_EmployeeSysId and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (not(PaymentBankCode = BankCode and PaymentBankBrCode = BankBrCode and PaymentBankAccNo = BankAccNo)) and
      (((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType1) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType2) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType3) or
	((select first PayRecType from PayRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = BankRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType4)) order by
      BankName asc;
    if BankMode is null then set BankMode=''
    end if
  end if;
  return BankMode
end
;

create function DBA.FGetPeriodAbsentTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Absent double;
  select sum(CurrentLveDays)+sum(PreviousLveIncDays) into Out_Absent
    from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Absent';
  if Out_Absent is null then set Out_Absent=0
  end if;
  return Out_Absent
end
;

create function DBA.FGetPeriodAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Allowance' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPeriodAllowanceElement(
in In_AllowanceFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(AllowanceAmount) into amount from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    AllowanceFormulaID = In_AllowanceFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function DBA.FGetPeriodAnnualLeaveBalance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  return FGetPeriodAnnualLeaveEntitle(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)-FGetPeriodAnnualLeaveTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)-FGetPeriodAnnualLeaveYTD(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)
end
;

create function DBA.FGetPeriodAnnualLeaveEntitle(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_AnnualLeave double;
  select sum(CurrLveEntitlement)+sum(LveBroughtForward) into Out_AnnualLeave from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Annual';
  if Out_AnnualLeave is null then set Out_AnnualLeave=0
  end if;
  return Out_AnnualLeave
end
;

create function DBA.FGetPeriodAnnualLeaveTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_AnnualLeave double;
  select sum(CurrLvePeriodTaken) into Out_AnnualLeave from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Annual';
  if Out_AnnualLeave is null then set Out_AnnualLeave=0
  end if;
  return Out_AnnualLeave
end
;

create function DBA.FGetPeriodAnnualLeaveYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_YTDTaken double;
  set Out_YTDTaken=0;
  YTDTakenLoop: for Out_YTDTakenFor as curs dynamic scroll cursor for
    select CurrLvePeriodTaken,PayRecPeriod from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = 'Annual' and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod <= In_PayRecPeriod) then set Out_YTDTaken=Out_YTDTaken+CurrLvePeriodTaken
    end if end for;
  return Out_YTDTaken
end
;

create function DBA.FGetPeriodBackPay(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_BackPay double;
  select Sum(CalBackPay) into In_BackPay from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_BackPay is null then set In_BackPay=0
  end if;
  return In_BackPay
end
;

create function DBA.FGetPeriodBasicRate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_AllocatedBasicRate double;
  select Sum(AllocatedBasicRate) into In_AllocatedBasicRate from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_AllocatedBasicRate is null then set In_AllocatedBasicRate=0
  end if;
  return In_AllocatedBasicRate
end
;

create function DBA.FGetPeriodBonus(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    IsFormulaIdHasProperty(AllowanceFormulaId,'BonusCode') = 1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPeriodCategory(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Category_ID char(20);
  select FGetCategoryDesc(PayCategoryID) into Category_ID
    from PayPeriodRecord where
    EmployeeSysID = In_EmployeeSysID and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Category_ID is null then set Category_ID=''
  end if;
  return Category_ID
end
;

create function DBA.FGetPeriodCPFWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select Sum(CPFWage) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodCurBasicRateType(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Out_CurBasicRateType char(20);
  select distinct DetailRecord.CurrentBasicRateType into Out_CurBasicRateType
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecID = 'Normal';
  return(Out_CurBasicRateType)
end
;

create function DBA.FGetPeriodCurrentHrDays(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CurrentHrDays double;
  select Sum(CurrentHrDays) into In_CurrentHrDays from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CurrentHrDays is null then set In_CurrentHrDays=0
  end if;
  return In_CurrentHrDays
end
;

create function DBA.FGetPeriodDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Deduction' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPeriodEECount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns integer
begin
  declare fresult integer;
  select Sum(case when EmployeeSysID = In_EmployeeSysID then 1 else 0 end) into fresult from PayPeriodRecord where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  return fresult
end
;

create function DBA.FGetPeriodEECPF(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select-Sum(TotalContriEECPF) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodERCPF(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select Sum(TotalContriERCPF) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodFund(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_FundType char(20))
returns double
begin
  declare Out_FundAmount double;
  select Sum(AllowanceAmount) into Out_FundAmount from AllowanceRecord where
    IsFormulaIdHasProperty(AllowanceFormulaId,In_FundType) = 1 and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Out_FundAmount is null then set Out_FundAmount=0
  end if;
  return Out_FundAmount
end
;

create function DBA.FGetPeriodFWL(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select Sum(ContriFWL) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodGrossWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalGrossWage double;
  select Sum(CalGrossWage) into In_CalGrossWage from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalGrossWage is null then set In_CalGrossWage=0
  end if;
  return In_CalGrossWage
end
;

create function DBA.FGetPeriodLateHours(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Late double;
  select sum(CurrentLveHours)+sum(PreviousLveIncHours) into Out_Late
    from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Late';
  if Out_Late is null then set Out_Late=0
  end if;
  return Out_Late
end
;

create function dba.FGetPeriodLongMessage(
in In_PayGroupId char(20),
in In_PayGroupPeriod integer)
returns char(20)
begin
  declare Out_PeriodLongMessage char(20);
  select PeriodMessage.PeriodLongMessage into Out_PeriodLongMessage
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupPeriod and
    PeriodMessage.PeriodIdType = 'Period';
  return(Out_PeriodLongMessage)
end
;

create function DBA.FGetPeriodLveDeductAmt(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_LveDeductAmt double;
  select Sum(CalLveDeductAmt) into In_LveDeductAmt from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_LveDeductAmt is null then set In_LveDeductAmt=0
  end if;
  return In_LveDeductAmt
end
;

create function DBA.FGetPeriodMonth(
in in_PayGroupId char(20),
in in_Period integer)
returns integer
begin
  declare month integer;
  declare out_Month char(20);
  select PeriodStartPRMonth into month from PayGroup where PayGroupId = in_PayGroupId;
  set month=(in_Period-1)+month;
  return month
end
;

create function DBA.FGetPeriodMonthWord(
in in_PayGroupId char(20),
in in_Period integer)
returns char(20)
begin
  declare month integer;
  declare out_Month char(20);
  select PeriodStartPRMonth into month from PayGroup where PayGroupId = in_PayGroupId;
  set month=MOD(((in_Period-1)+month),12);
  if month = 0 then set month=12
  end if;
  select MonthName('2000-'+str(month)+'-02') into out_Month;
  return out_Month
end
;

create function DBA.FGetPeriodMVC(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_AllocatedMVC double;
  select Sum(AllocatedMVC) into In_AllocatedMVC from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_AllocatedMVC is null then set In_AllocatedMVC=0
  end if;
  return In_AllocatedMVC
end
;

create function DBA.FGetPeriodNetWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalNetWage double;
  select Sum(CalNetWage) into In_CalNetWage from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalNetWage is null then set In_CalNetWage=0
  end if;
  return In_CalNetWage
end
;

create function DBA.FGetPeriodNPLDaysTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_NPL double;
  select sum(CurrentLveDays)+sum(PreviousLveIncDays) into Out_NPL
    from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'NPL';
  if Out_NPL is null then set Out_NPL=0
  end if;
  return Out_NPL
end
;

create function DBA.FGetPeriodNPLDaysYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_YTDTaken double;
  set Out_YTDTaken=0;
  YTDTakenLoop: for Out_YTDTakenFor as curs dynamic scroll cursor for
    select CurrentLveDays,PayRecPeriod,PayRecSubPeriod from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = 'NPL' and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod <= In_PayRecPeriod) then set Out_YTDTaken=Out_YTDTaken+CurrentLveDays
    end if end for;
  return Out_YTDTaken
end
;

create function DBA.FGetPeriodNPLHoursTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_NPL double;
  select sum(CurrentLveHours)+sum(PreviousLveIncHours) into Out_NPL
    from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'NPL';
  if Out_NPL is null then set Out_NPL=0
  end if;
  return Out_NPL
end
;

create function DBA.FGetPeriodNPLHoursYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_YTDTaken double;
  set Out_YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrentLveHours,PayRecPeriod,PayRecSubPeriod from LeaveDeductionRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = 'NPL' and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod <= In_PayRecPeriod) then set Out_YTDTaken=Out_YTDTaken+CurrentLveHours
    end if end for;
  return Out_YTDTaken
end
;

create function DBA.FGetPeriodNPLTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_NPL double;
  select sum(CurrentLveDays)+sum(PreviousLveIncDays) into Out_NPL
    from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'NPL';
  if Out_NPL is null then set Out_NPL=0
  end if;
  return Out_NPL
end
;

create function DBA.FGetPeriodNWC(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_AllocatedNWC double;
  select Sum(AllocatedNWC) into In_AllocatedNWC from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_AllocatedNWC is null then set In_AllocatedNWC=0
  end if;
  return In_AllocatedNWC
end
;

create function DBA.FGetPeriodOTAmount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_OTAmount double;
  select Sum(CalOTAmount) into In_OTAmount from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_OTAmount is null then set In_OTAmount=0
  end if;
  return In_OTAmount
end
;

create function DBA.FGetPeriodOTBackPay(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_OTBackPay double;
  select Sum(CalOTBackPay) into In_OTBackPay from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_OTBackPay is null then set In_OTBackPay=0
  end if;
  return In_OTBackPay
end
;

create function DBA.FGetPeriodOTElement(
in In_OTFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into amount from OTRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    OTFormulaID = In_OTFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function dba.FGetPeriodPayTypeAllAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Allowance' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPeriodPayTypeAllDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Deduction' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPeriodPayTypeAllReimbursement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecType char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Reimbursement' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    (select first PayRecType from PayRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and PayRecord.PayRecID = AllowanceRecord.PayRecID order by PayRecSGSPGenId) = In_PayRecType;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPeriodPreviousHrDays(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_PreviousHrDays double;
  select Sum(PreviousHrDays) into In_PreviousHrDays from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_PreviousHrDays is null then set In_PreviousHrDays=0
  end if;
  return In_PreviousHrDays
end
;

create function DBA.FGetPeriodReimbursement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Reimbursement' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetPeriodSDF(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select Sum(ContriSDF) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodShiftAmount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_ShiftAmount double;
  select Sum(CalShiftAmount) into In_ShiftAmount from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_ShiftAmount is null then set In_ShiftAmount=0
  end if;
  return In_ShiftAmount
end
;

create function DBA.FGetPeriodShiftElement(
in In_ShiftFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(ShiftFrequency) into amount from ShiftRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    ShiftFormulaID = In_ShiftFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function dba.FGetPeriodShortMessage(
in In_PayGroupId char(20),
in In_PayGroupPeriod integer)
returns char(20)
begin
  declare Out_PeriodShortMessage char(20);
  select PeriodMessage.PeriodShortMessage into Out_PeriodShortMessage
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupPeriod and
    PeriodMessage.PeriodIdType = 'Period';
  return(Out_PeriodShortMessage)
end
;

create function DBA.FGetPeriodSickLeaveBalance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  return FGetPeriodSickLeaveEntitle(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)-FGetPeriodSickLeaveTaken(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)-FGetPeriodSickLeaveYTD(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod)
end
;

create function DBA.FGetPeriodSickLeaveEntitle(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_SickLeave double;
  select sum(CurrLveEntitlement)+sum(LveBroughtForward) into Out_SickLeave from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Sick';
  if Out_SickLeave is null then set Out_SickLeave=0
  end if;
  return Out_SickLeave
end
;

create function DBA.FGetPeriodSickLeaveTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_SickLeave double;
  select sum(CurrLvePeriodTaken) into Out_SickLeave from LeaveInfoRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    LeaveTypeFunctCode = 'Sick';
  if Out_SickLeave is null then set Out_SickLeave=0
  end if;
  return Out_SickLeave
end
;

create function DBA.FGetPeriodSickLeaveYTD(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_YTDTaken double;
  set Out_YTDTaken=0;
  YTDTakenLoop: for Out_YTDTakenFor as curs dynamic scroll cursor for
    select CurrLvePeriodTaken,PayRecPeriod from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = 'Sick' and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod <= In_PayRecPeriod) then set Out_YTDTaken=Out_YTDTaken+CurrLvePeriodTaken
    end if end for;
  return Out_YTDTaken
end
;

create function DBA.FGetPeriodTotalCPF(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalCPFWage double;
  select Sum(TotalContriERCPF+TotalContriEECPF) into In_CalCPFWage from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalCPFWage is null then set In_CalCPFWage=0
  end if;
  return In_CalCPFWage
end
;

create function DBA.FGetPeriodTotalGrossWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalTotalGrossWage double;
  select Sum(CalTotalGrossWage) into In_CalTotalGrossWage from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalTotalGrossWage is null then set In_CalTotalGrossWage=0
  end if;
  return In_CalTotalGrossWage
end
;

create function DBA.FGetPeriodTotalWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalTotalWage double;
  select Sum(CalTotalWage) into In_CalTotalWage from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalTotalWage is null then set In_CalTotalWage=0
  end if;
  return In_CalTotalWage
end
;

create function DBA.FGetPeriodYTDTaken(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare YTDTaken double;
  set YTDTaken=0;
  YTDTakenLoop: for YTDTakenFor as curs dynamic scroll cursor for
    select CurrLvePeriodTaken,PayRecPeriod from LeaveInfoRecord where
      EmployeeSysId = In_EmployeeSysId and
      LeaveTypeFunctCode = In_LeaveType and
      PayRecYear = In_PayRecYear and
      PayRecPeriod <= In_PayRecPeriod order by PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc do
    if(PayRecPeriod <= In_PayRecPeriod) then set YTDTaken=YTDTaken+CurrLvePeriodTaken
    end if end for;
  return YTDTaken
end
;

create function DBA.FGetPersonalIdentityTypeId(
in In_PersonalSysId integer)
returns char(20)
begin
  declare Out_IdentityTypeId char(20);
  select Personal.IdentityTypeId into Out_IdentityTypeId
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_IdentityTypeId)
end
;

create function dba.FGetPersonalTypeDesc(
in In_PersonalTypeId char(20))
returns char(100)
begin
  declare Out_PersonalTypeDesc char(100);
  select PersonalTypeDesc into Out_PersonalTypeDesc from PersonalType where
    PersonalTypeId = In_PersonalTypeId;
  if(Out_PersonalTypeDesc is null or Out_PersonalTypeDesc = '') then
    return(In_PersonalTypeId)
  else return(Out_PersonalTypeDesc)
  end if
end
;

create function DBA.FGetPersonalTypeId(
in In_PersonalSysId integer)
returns char(20)
begin
  declare Out_PersonalTypeId char(20);
  select Personal.PersonalTypeId into Out_PersonalTypeId
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_PersonalTypeId)
end
;

create function DBA.FGetPosSameCodeAllowanceAmount(
in In_AllowanceFormulaid char(20),
in In_Positionid char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(a.AllowanceAmount) into TotalAmount from AllowanceRecord as a join Payemployee as p join employee as e where
    a.AllowanceFormulaid = In_AllowanceFormulaid and
    e.Positionid = In_Positionid and
    a.PayRecYear = In_PayRecYear and
    a.PayRecPeriod = In_PayRecPeriod and
    a.PayRecSubPeriod = In_PayRecSubPeriod and
    a.PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetRecurBalanceAmount(
in In_RecurAlloSGSPGenId char(30))
returns double
begin
  declare Out_BalanceAmount double;
  select sum(AllowanceAmountF) into Out_BalanceAmount from AllowanceRecord where
    AllowanceRecurSysId = In_RecurAlloSGSPGenId;
  if Out_BalanceAmount is null then set Out_BalanceAmount=0
  end if;
  return Out_BalanceAmount
end
;

create function dba.FGetRecurBalanceCounter(
in In_RecurAlloSGSPGenId char(30))
returns integer
begin
  declare Out_BalanceCounter integer;
  select count(*) into Out_BalanceCounter from AllowanceRecord where
    AllowanceRecurSysId = In_RecurAlloSGSPGenId;
  if Out_BalanceCounter is null then set Out_BalanceCounter=0
  end if;
  return Out_BalanceCounter
end
;

create function dba.FGetRecurKeyWordUserDefinedName(
in In_RecurKeyword char(100))
returns char(100)
begin
  case In_RecurKeyword when 'I' then return 'Interface' when 'S' then
    return 'System' when 'B' then
    return 'Basic Rate Progression' when 'C' then
    return 'Confirmation' when 'P' then
    return 'Package' when 'E' then
    return 'Employment' when 'M' then
    return 'Career Movement'
  else
    return In_RecurKeyword
  end case
end
;

create function DBA.FGetResidentialPhone(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_ResidentialPhone char(30);
  select ContactNumber into Out_ResidentialPhone
    from PersonalContact where
    PersonalSysId = In_PersonalSysId and
    ContactLocationId = 'Residential';
  return(Out_ResidentialPhone)
end
;

create function dba.FGetSalaryGradeDesc(
in In_SalaryGradeId char(20))
returns char(100)
begin
  declare Out_SalaryGradeDesc char(100);
  select SalaryGradeDesc into Out_SalaryGradeDesc from SalaryGrade where
    SalaryGradeId = In_SalaryGradeId;
  if(Out_SalaryGradeDesc is null or Out_SalaryGradeDesc = '') then
    return(In_SalaryGradeId)
  else return(Out_SalaryGradeDesc)
  end if
end
;

create function DBA.FGetSameCodeAllowanceAmount(
in In_AllowanceFormulaid char(20),
in In_Departmentid char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(a.AllowanceAmount) into TotalAmount from AllowanceRecord as a join Payemployee as p join employee as e where
    a.AllowanceFormulaid = In_AllowanceFormulaid and
    e.Departmentid = In_Departmentid and
    a.PayRecYear = In_PayRecYear and
    a.PayRecPeriod = In_PayRecPeriod and
    a.PayRecSubPeriod = In_PayRecSubPeriod and
    a.PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetSecSameCodeAllowanceAmount(
in In_AllowanceFormulaid char(20),
in In_Sectionid char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(a.AllowanceAmount) into TotalAmount from AllowanceRecord as a join Payemployee as p join employee as e where
    a.AllowanceFormulaid = In_AllowanceFormulaid and
    e.Sectionid = In_Sectionid and
    a.PayRecYear = In_PayRecYear and
    a.PayRecPeriod = In_PayRecPeriod and
    a.PayRecSubPeriod = In_PayRecSubPeriod and
    a.PayRecID = In_PayRecID;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function DBA.FGetShiftElementYTD(
in In_DepartmentID char(20),
in In_ShiftFormulaID char(20),
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer)
returns double
begin
  declare fresult double;
  declare YTDamount double;
  declare YTDamountTotal double;
  set YTDamountTotal=0;
  if In_DepartmentID = 'Company' then
    if(YTDFromYear = YTDToYear) then
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        D.PayRecYear = YTDFromYear and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
        D.EmployeeSysID = S.EmployeeSysID and
        D.EmployeeSysID = PPR.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = PPR.PayRecYear and
        D.PayRecPeriod = PPR.PayRecPeriod and
        PPR.PayDepartmentID = In_DepartmentID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=YTDamountTotal
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticAbsentTakenElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Absent Taken',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodAbsentTaken(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodAbsentTaken(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodAbsentTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodAbsentTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodAbsentTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticAllowanceRecordDetails(
in In_DepartmentID char(20),
in In_AllowanceFormulaID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  declare formulaIDProperty char(1);
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  if IsFormulaIdHasProperty(In_AllowanceFormulaID,'SubjAdditional') = 1 then
    set formulaIDProperty='A'
  elseif IsFormulaIdHasProperty(In_AllowanceFormulaID,'SubjOrdinary') = 1 then set formulaIDProperty='O'
  else set formulaIDProperty='N'
  end if;
  set fresult=FSetBlank(SubStr(FGetFormulaDesc(In_AllowanceFormulaID),1,16),16,'R')+' '+FormulaIDProperty;
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      //==
      if In_DepartmentID = 'Company' then
        select Sum(FGetStatisticPeriodAllowanceElement(In_AllowanceFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetStatisticPeriodAllowanceElement(In_AllowanceFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if; //==
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.AllowanceFormulaID = In_AllowanceFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(AllowanceAmount) into YTDAmount from AllowanceRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.AllowanceFormulaID = In_AllowanceFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticAnnualLeaveElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Annual Leave',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodAnnualLeaveTaken(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodAnnualLeaveTaken(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodAnnualLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodAnnualLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodAnnualLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticBackPayElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Back Pay',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodBackPay(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodBackPay(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticCPFWageElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('CPF Wage',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodCPFWage(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodCPFWage(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CPFWage) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticDescriptionLine(
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set fresult=FSetBlank('Description',18,'R');
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      set fresult=fresult+FSetBlank('Pd '+Trim(Str(fPeriod))+','+Trim(Str(fYear)),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      set fresult=fresult+FSetBlank('YTD Total',13,'L')+' '
    end if
  else
    set fresult=fresult+FSetBlank('YTD Total',13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticEECPFElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Employee CPF',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodEECPF(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodEECPF(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(TotalContriEECPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticEmployeeCountElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set fresult=FSetBlank('Latest # Employee',18,'R');
  while(looping = 1) loop
    if In_DepartmentID = 'Company' then
      select Count(EmployeeSysID) into amount from PayPeriodRecord where
        payrecyear = fYear and payrecperiod = fPeriod and
        PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
    else
      select Count(EmployeeSysID) into amount from PayPeriodRecord where
        PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
        PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
    end if;
    if amount is null then set amount=0
    end if;
    set fresult=fresult+FSetBlank(STR(amount,13),13,'L')+' ';
    if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
    end if;
    set fPeriod=fPeriod+1;
    if fPeriod = 13 then
      set fPeriod=1;
      set fYear=fYear+1
    end if
  end loop;
  return(fresult)
end
;

create function DBA.FGetStatisticERCPFElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Employer CPF',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodERCPF(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodERCPF(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(TotalContriERCPF) into YTDAmount from PolicyRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticGrossWageElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Gross Wage',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodGrossWage(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodGrossWage(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticLateHoursElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Late Hours',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodLateHours(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodLateHours(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodLateHours(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodLateHours(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodLateHours(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticLveDeductElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Leave Deduction',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodLveDeductAmt(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodLveDeductAmt(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalLveDeductAmt) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticNetWageElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('NET Wage',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodNetWage(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodNetWage(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalNetwage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticNPLDaysElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('NPL Days',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodNPLDaysTaken(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodNPLDaysTaken(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodNPLDaysTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodNPLDaysTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodNPLDaysTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticNPLHoursElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('NPL Hours',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodNPLHoursTaken(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodNPLHoursTaken(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodNPLHoursTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodNPLHoursTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodNPLHoursTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticOTRecordDetails(
in In_DepartmentID char(20),
in In_OTFormulaID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  declare OTType char(20);
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  select distinct FGetKeywordUSerDefinedName(OTType) into OTType from OTRecord where OTFormulaID = In_OTFormulaID;
  set fresult=FSetBlank(SubStr(FGetFormulaDesc(In_OTFormulaID),1,7)+' '+OTType,18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      //==
      if In_DepartmentID = 'Company' then
        select Sum(FGetStatisticPeriodOTElement(In_OTFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetStatisticPeriodOTElement(In_OTFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if; //==
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.OTFormulaID = In_OTFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into YTDAmount from OTRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.OTFormulaID = In_OTFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticPeriodAllowanceElement(
in In_AllowanceFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(AllowanceAmount) into amount from AllowanceRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    AllowanceFormulaID = In_AllowanceFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function DBA.FGetStatisticPeriodOTElement(
in In_OTFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(CurrentOTFreq+LastOTFreq+BackPayOTFreq) into amount from OTRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    OTFormulaID = In_OTFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function DBA.FGetStatisticPeriodShiftElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total Shift Amount',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodShiftAmount(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodShiftAmount(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalShiftAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticPeriodShiftFreqElement(
in In_ShiftFormulaID char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare amount double;
  select Sum(ShiftFrequency) into amount from ShiftRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    ShiftFormulaID = In_ShiftFormulaID;
  if amount is null then set amount=0
  end if;
  return amount
end
;

create function DBA.FGetStatisticSDFElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total SDF',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodSDF(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodSDF(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(ContriSDF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticSeparatorLine(
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in includeDescription integer,
in includeYTD integer)
returns char(120)
begin
  declare fresult char(120);
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  if includeDescription = 1 then
    set fresult=FSetBlank('------------------',18,'R')
  else set fresult=FSetBlank(' ',18,'R')
  end if;
  if includeYTD < 2 then
    while(looping = 1) loop
      set fresult=fresult+FSetBlank('-------------',13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if includeYTD = 1 then
      set fresult=fresult+FSetBlank('-------------',13,'L')+' '
    end if
  else
    set fresult=fresult+FSetBlank('-------------',13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticShiftRecordDetails(
in In_DepartmentID char(20),
in In_ShiftFormulaID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank(FGetFormulaDesc(In_ShiftFormulaID),18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetStatisticPeriodShiftFreqElement(In_ShiftFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else //==
        select Sum(FGetStatisticPeriodShiftFreqElement(In_ShiftFormulaID,EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.ShiftFormulaID = In_ShiftFormulaID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(ShiftFrequency) into YTDAmount from ShiftRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.ShiftFormulaID = In_ShiftFormulaID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticSickLeaveElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Sick Leave',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodSickLeaveTaken(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodSickLeaveTaken(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop;
    if YTDInOrNot = 1 then
      while(YTDlooping = 1) loop
        if In_DepartmentID = 'Company' then
          select Sum(FGetPeriodSickLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable
        else
          select Sum(FGetPeriodSickLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from PayPeriodRecord where
            PaydepartmentID = In_DepartmentID and payrecyear = YTDfYear and payrecperiod = YTDfPeriod and
            PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
        end if;
        if YTDamount is null then set YTDamount=0
        end if;
        set YTDamountTotal=YTDamountTotal+YTDamount;
        if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
        end if;
        set YTDfPeriod=YTDfPeriod+1;
        if YTDfPeriod = 13 then
          set YTDfPeriod=1;
          set YTDfYear=YTDfYear+1
        end if
      end loop;
      set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
    end if
  else
    while(YTDlooping = 1) loop
      select Sum(FGetPeriodSickLeaveTaken(EmployeeSysID,YTDfYear,YTDfPeriod)) into YTDamount from StatisticTempTable;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      if(YTDfYear = YTDToYear and YTDfPeriod = YTDToPeriod) then set YTDlooping=0
      end if;
      set YTDfPeriod=YTDfPeriod+1;
      if YTDfPeriod = 13 then
        set YTDfPeriod=1;
        set YTDfYear=YTDfYear+1
      end if
    end loop;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticTotalCPFElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total CPF',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodTotalCPF(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodTotalCPF(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(TotalContriERCPF+TotalContriEECPF) into YTDAmount from PeriodPolicySummary as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticTotalGrossWageElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total Gross Wage',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodTotalGrossWage(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodTotalGrossWage(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalTotalGrossWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticTotalOTBackPayElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total OT BackPay',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodOTBackPay(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodOTBackPay(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalOTBackPay) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticTotalOTElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total OT',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodOTAmount(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodOTAmount(EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalOTAmount) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function DBA.FGetStatisticTotalWageElement(
in In_DepartmentID char(20),
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer,
in YTDFromYear integer,
in YTDFromPeriod integer,
in YTDToYear integer,
in YTDToPeriod integer,
in YTDInOrNot integer)
returns char(120)
begin
  declare fresult char(120);
  declare amount double;
  declare fPeriod integer;
  declare fYear integer;
  declare looping integer;
  declare YTDamount double;
  declare YTDamountTotal double;
  declare YTDfPeriod integer;
  declare YTDfYear integer;
  declare YTDlooping integer;
  set fPeriod=FromPeriod;
  set fYear=FromYear;
  set looping=1;
  set YTDfPeriod=YTDFromPeriod;
  set YTDfYear=YTDFromYear;
  set YTDlooping=1;
  set fresult=FSetBlank('Total Wage',18,'R');
  set YTDamountTotal=0;
  if YTDInOrNot < 2 then
    while(looping = 1) loop
      if In_DepartmentID = 'Company' then
        select Sum(FGetPeriodTotalWage(EmployeeSysID,fYear,fPeriod)) into amount from StatisticTempTable
      else
        select Sum(FGetPeriodTotalWage(PayPeriodRecord.EmployeeSysID,fYear,fPeriod)) into amount from PayPeriodRecord where
          PaydepartmentID = In_DepartmentID and payrecyear = fYear and payrecperiod = fPeriod and
          PayPeriodRecord.employeesysid = any(select StatisticTempTable.employeesysid from StatisticTempTable)
      end if;
      if amount is null then set amount=0
      end if;
      set fresult=fresult+FSetBlank(STR(amount,11,2),13,'L')+' ';
      if(fYear = ToYear and fPeriod = ToPeriod) then set looping=0
      end if;
      set fPeriod=fPeriod+1;
      if fPeriod = 13 then
        set fPeriod=1;
        set fYear=fYear+1
      end if
    end loop; //=============================
    // NEW YTD CODE
    //=============================
    if YTDInOrNot = 1 then
      if In_DepartmentID = 'Company' then
        if(YTDFromYear = YTDToYear) then
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
            D.EmployeeSysID = S.EmployeeSysID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      else
        if(YTDFromYear = YTDToYear) then
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            D.PayRecYear = YTDFromYear and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        else
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDFromYear and
            D.PayRecPeriod between YTDFromPeriod and 12;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount;
          select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S,PayPeriodRecord as PPR where
            D.EmployeeSysID = S.EmployeeSysID and
            D.EmployeeSysID = PPR.EmployeeSysID and
            D.PayRecYear = PPR.PayRecYear and
            D.PayRecPeriod = PPR.PayRecPeriod and
            PPR.PayDepartmentID = In_DepartmentID and
            D.PayRecYear = YTDToYear and
            D.PayRecPeriod between 1 and YTDToPeriod;
          if YTDamount is null then set YTDamount=0
          end if;
          set YTDamountTotal=YTDamountTotal+YTDamount
        end if;
        set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
      end if
    end if
  else
    if(YTDFromYear = YTDToYear) then
      select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    else
      select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDFromYear and
        D.PayRecPeriod between YTDFromPeriod and 12;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount;
      select Sum(CalTotalWage) into YTDAmount from DetailRecord as D,StatisticTempTable as S where
        D.EmployeeSysID = S.EmployeeSysID and
        D.PayRecYear = YTDToYear and
        D.PayRecPeriod between 1 and YTDToPeriod;
      if YTDamount is null then set YTDamount=0
      end if;
      set YTDamountTotal=YTDamountTotal+YTDamount
    end if;
    set fresult=fresult+FSetBlank(STR(YTDamountTotal,11,2),13,'L')+' '
  end if;
  return(fresult)
end
;

create function dba.FGetSubPeriodLongMessage(
in In_PayGroupId char(20),
in In_PayGroupSubPeriod integer)
returns char(20)
begin
  declare Out_PeriodLongMessage char(20);
  select PeriodMessage.PeriodLongMessage into Out_PeriodLongMessage
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupSubPeriod and
    PeriodMessage.PeriodIdType = 'SubPeriod';
  return(Out_PeriodLongMessage)
end
;

create function dba.FGetSubPeriodShortMessage(
in In_PayGroupId char(20),
in In_PayGroupSubPeriod integer)
returns char(5)
begin
  declare Out_PeriodShortMessage char(5);
  select PeriodMessage.PeriodShortMessage into Out_PeriodShortMessage
    from PeriodMessage where
    PeriodMessage.PayGroupId = In_PayGroupId and
    PeriodMessage.PeriodId = In_PayGroupSubPeriod and
    PeriodMessage.PeriodIdType = 'SubPeriod';
  return(Out_PeriodShortMessage)
end
;

create function DBA.FGetTotalOT(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare Out_TotalOT double;
  declare In_MaxOTAmount double;
  declare In_MinOTAmount double;
  declare In_OTTableId char(20);
  select OTTableId into In_OTTableId from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  select MaxOvertimeAmount into In_MaxOTAmount from Overtime where OTTableId = In_OTTableId;
  select MinOvertimeAmount into In_MinOTAmount from Overtime where OTTableId = In_OTTableId;
  select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_TotalOT from OTRecord where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecId = In_PayRecId and
    EmployeeSysId = In_EmployeeSysId;
  if(Out_TotalOT > In_MaxOTAmount and In_MaxOTAmount <> 0) then set Out_TotalOT=In_MaxOTAmount
  end if;
  if(Out_TotalOT < In_MinOTAmount and In_MinOTAmount <> 0) then set Out_TotalOT=In_MinOTAmount
  end if;
  return(Out_TotalOT)
end
;

create function DBA.FGetWageElementTotal(
in in_BasicRate double,
in in_MVC double,
in in_NWC double)
returns double
begin
  declare TotalWage double;
  if(in_BasicRate is null) then set in_BasicRate=0
  end if;
  set TotalWage=in_BasicRate;
  if(IsWageElementInUsed('MVC','TotalWage') = 1) then
    if(in_MVC is null) then set in_MVC=0
    end if;
    set TotalWage=TotalWage+in_MVC
  end if;
  if(IsWageElementInUsed('NWC','TotalWage') = 1) then
    if(in_NWC is null) then set in_NWC=0
    end if;
    set TotalWage=TotalWage+in_NWC
  end if;
  if(TotalWage is null) then
    set TotalWage=0
  end if;
  return TotalWage
end
;

create function DBA.FGetYTDLeaveDeductionDaysFreq(
in In_EmployeeSysID integer,
in In_LeaveType char(20),
in FromYear integer,
in FromPeriod integer,
in FromSubPeriod integer,
in ToYear integer,
in ToPeriod integer,
in ToSubPeriod integer)
returns double
begin
  declare fresult double;
  if(FromYear = ToYear) then
    select Sum(CurrentLveDays+PreviousLveIncDays) into fresult
      from LeaveDeductionRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      (PayRecYear = FromYear and PayRecPeriod between FromPeriod and ToPeriod) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  else
    select Sum(CurrentLveDays+PreviousLveIncDays) into fresult
      from LeaveDeductionRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      ((PayRecYear = FromYear and(PayRecPeriod between FromPeriod and 12)) or
      (PayRecYear = ToYear and(PayRecPeriod between 1 and ToPeriod))) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  end if;
  if fresult is null then set fresult=0
  end if;
  return(fresult)
end
;

create function DBA.FGetYTDLeaveDeductionHoursFreq(
in In_EmployeeSysID integer,
in In_LeaveType char(20),
in FromYear integer,
in FromPeriod integer,
in FromSubPeriod integer,
in ToYear integer,
in ToPeriod integer,
in ToSubPeriod integer)
returns double
begin
  declare fresult double;
  if(FromYear = ToYear) then
    select Sum(CurrentLveHours+PreviousLveIncHours) into fresult
      from LeaveDeductionRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      (PayRecYear = FromYear and PayRecPeriod between FromPeriod and ToPeriod) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  else
    select Sum(CurrentLveHours+PreviousLveIncHours) into fresult
      from LeaveDeductionRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      ((PayRecYear = FromYear and(PayRecPeriod between FromPeriod and 12)) or
      (PayRecYear = ToYear and(PayRecPeriod between 1 and ToPeriod))) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  end if;
  if fresult is null then set fresult=0
  end if;
  return(fresult)
end
;

create function DBA.FGetYTDLeaveInfoDaysFreq(
in In_EmployeeSysID integer,
in In_LeaveType char(20),
in FromYear integer,
in FromPeriod integer,
in FromSubPeriod integer,
in ToYear integer,
in ToPeriod integer,
in ToSubPeriod integer)
returns double
begin
  declare fresult double;
  if(FromYear = ToYear) then
    select Sum(CurrLvePeriodTaken) into fresult
      from LeaveInfoRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      (PayRecYear = FromYear and PayRecPeriod between FromPeriod and ToPeriod) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  else
    select Sum(CurrLvePeriodTaken) into fresult
      from LeaveInfoRecord where
      EmployeeSysID = In_EmployeeSysID and
      LeaveTypeFunctCode = In_LeaveType and
      ((PayRecYear = FromYear and(PayRecPeriod between FromPeriod and 12)) or
      (PayRecYear = ToYear and(PayRecPeriod between 1 and ToPeriod))) and
      PayRecSubPeriod between FromSubperiod and ToSubPeriod
  end if;
  if fresult is null then set fresult=0
  end if;
  return(fresult)
end
;

create function DBA.FRemoveDecimal(in In_amount double)
returns integer
begin
  declare fresult integer;
  set fresult=Round(In_amount*100,0);
  return(fresult)
end
;

create function DBA.FSetBlank(
in In_text TEXT,
in In_Length integer,
in In_pos char(1))
returns TEXT
begin
  declare fResult TEXT;
  declare difference integer;
  set difference=In_Length-Length(Trim(In_Text));
  if In_Pos = 'L' then
    set fResult=Repeat(' ',difference)+Trim(In_Text)
  else if In_Pos = 'R' then
      set fResult=Trim(In_Text)+Repeat(' ',difference)
    end if
  end if;
  return(fResult)
end
;

create function dba.FSetNewSGSPGeneratedIndex(
in In_SGSPIndexGeneratorTbl char(200),
in In_PreFix char(2),
in In_LastNum integer)
returns char(30)
begin
  declare Char_SGSPIndexGenCurrPreFix char(2);
  declare Int_SGSPIndexGenLastNum integer;
  declare Char_GeneratedIndex char(30);
  if not exists(select* from SGSPIndexGenerator where
      SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl) then
    set Int_SGSPIndexGenLastNum=In_LastNum;
    set Char_SGSPIndexGenCurrPreFix=In_PreFix;
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
      Char_SGSPIndexGenCurrPreFix);
    insert into SGSPIndexGenerator(SGSPIndexGeneratorTbl,SGSPIndexGenCurrPreFix,SGSPIndexGenLastNum) values(
      In_SGSPIndexGeneratorTbl,Char_SGSPIndexGenCurrPreFix,Int_SGSPIndexGenLastNum);
    return(Char_GeneratedIndex)
  else
    update SGSPIndexGenerator set
      SGSPIndexGenerator.SGSPIndexGenCurrPreFix = In_PreFix,
      SGSPIndexGenerator.SGSPIndexGenLastNum = In_LastNum where
      SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
      Char_SGSPIndexGenCurrPreFix);
    return(Char_GeneratedIndex)
  end if
end
;

create function DBA.FStringWrap(
in In_Text char(150))
returns char(150)
begin
  declare fresult char(150);
  set fresult=In_Text;
  return(fresult)
end
;

create function DBA.FUpdatePaymentBankBalance(
in In_EmployeeSysId integer,
in In_BankAllocGpId char(20))
returns numeric(10,2) // dummy
begin
  declare balance numeric(10,2);
  declare totalWage numeric(10,2);
  declare total numeric(10,2);
  if exists(select* from PaymentBankinfo where EmployeeSysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'Bankbalance') then
    select FGetEmployeeCurrentTotalWage(In_EmployeeSysId) into balance;
    update paymentbankinfo set
      PaymentValue = balance where EmployeeSysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'Bankbalance'
  end if;
  if exists(select* from PaymentBankinfo where EmployeeSysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'Bankfixedamt') then
    select sum(paymentValue) into total from paymentbankinfo where employeesysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'Bankfixedamt';
    if exists(select* from PaymentBankinfo where EmployeeSysid = In_EmployeeSysId and
        BankAllocGpId = In_BankAllocGpId and
        PaymentType = 'Bankbalance') then
      select FGetEmployeeCurrentTotalWage(In_EmployeeSysId) into totalWage;
      set balance=totalWage-total;
      update paymentbankinfo set
        PaymentValue = balance where EmployeeSysid = In_EmployeeSysId and
        BankAllocGpId = In_BankAllocGpId and
        PaymentType = 'Bankbalance'
    end if
  end if;
  if exists(select* from PaymentBankinfo where EmployeeSysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'BankPercent') then
    select sum(paymentValue) into total from paymentbankinfo where employeesysid = In_EmployeeSysId and
      BankAllocGpId = In_BankAllocGpId and
      PaymentType = 'BankPercent';
    if exists(select* from PaymentBankinfo where EmployeeSysid = In_EmployeeSysId and
        BankAllocGpId = In_BankAllocGpId and
        PaymentType = 'Bankbalance') then
      select FGetEmployeeCurrentTotalWage(In_EmployeeSysId) into totalWage;
      set balance=100-total;
      update paymentbankinfo set
        PaymentValue = balance where EmployeeSysid = In_EmployeeSysId and
        BankAllocGpId = In_BankAllocGpId and
        PaymentType = 'Bankbalance'
    end if
  end if;
  return balance
end
;

create procedure dba.InsertNewAllowanceHistoryRecord(
in In_AllowanceSGSPGenId char(30),
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20),
in In_Formula char(255))
begin
  if not exists(select* from AllowanceHistoryRecord where
      AllowanceHistoryRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    insert into AllowanceHistoryRecord(AllowanceSGSPGenId,
      Constant1,
      Constant2,
      Constant3,
      Constant4,
      Constant5,
      Keywords1,
      Keywords2,
      Keywords3,
      Keywords4,
      Keywords5,
      Keywords6,
      Keywords7,
      Keywords8,
      Keywords9,
      Keywords10,
      UserDef1,
      UserDef2,
      UserDef3,
      UserDef4,
      UserDef5,
      UserDef1Value,
      UserDef2Value,
      UserDef3Value,
      UserDef4Value,
      UserDef5Value,
      F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,
      P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,
      Formula) values(
      In_AllowanceSGSPGenId,
      In_Constant1,
      In_Constant2,
      In_Constant3,
      In_Constant4,
      In_Constant5,
      In_Keywords1,
      In_Keywords2,
      In_Keywords3,
      In_Keywords4,
      In_Keywords5,
      In_Keywords6,
      In_Keywords7,
      In_Keywords8,
      In_Keywords9,
      In_Keywords10,
      In_UserDef1,
      In_UserDef2,
      In_UserDef3,
      In_UserDef4,
      In_UserDef5,
      In_UserDef1Value,
      In_UserDef2Value,
      In_UserDef3Value,
      In_UserDef4Value,
      In_UserDef5Value,
      In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
      In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,In_P10,
      In_Formula);
    commit work
  end if
end
;

create procedure dba.InsertNewAllowanceRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double,
out In_AllowanceSGSPGenId char(30))
begin
  select FGetNewSGSPGeneratedIndex('AllowanceRecord') into In_AllowanceSGSPGenId;
  insert into AllowanceRecord(AllowanceSGSPGenId,
    EmployeeSysId,
    PayRecYear,
    PayRecPeriod,
    PayRecSubPeriod,
    PayRecID,
    AllowanceFormulaId,
    AllowanceAmount,
    AllowanceRecurSysId,
    AllowancePreProcessRec,
    AllowanceCreatedBy,
    AllowanceDeclaredDate,
    AllowanceRemarks,
    AllowanceCustSysId,
    AllowanceAmountF,
    AllowanceExRateId,
    AllowanceExRate) values(
    In_AllowanceSGSPGenId,
    In_EmployeeSysId,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_PayRecID,
    In_AllowanceFormulaId,
    In_AllowanceAmount,
    In_AllowanceRecurSysId,
    In_AllowancePreProcessRec,
    In_AllowanceCreatedBy,
    In_AllowanceDeclaredDate,
    In_AllowanceRemarks,
    In_AllowanceCustSysId,
    In_AllowanceAmountF,
    In_AllowanceExRateId,
    In_AllowanceExRate);
  commit work
end;

create procedure dba.InsertNewBalancePayElement(
in In_EmployeeSysId integer,
in In_FormulaId char(20))
begin
  if not exists(select* from BalancePayElement where
      EmployeeSysId = In_EmployeeSysId and
      FormulaId = In_FormulaId) then
    insert into BalancePayElement(EmployeeSysId,
      FormulaId) values(In_EmployeeSysId,
      In_FormulaId);
    commit work
  end if
end
;

create procedure DBA.InsertNewBankDiskRecord(
in In_BankDiskName char(50),
in In_OrderReference char(2),
in In_FieldDescription char(50),
In_FieldLength integer,In_ValidationCheck integer)
begin
  if exists(select* from BankDiskRecord where BankDiskRecord.BankDiskName = In_BankDiskName and BankDiskRecord.OrderReference = In_OrderReference) then
    update BankDiskRecord set
      BankDiskRecord.FieldDescription = In_FieldDescription,BankDiskRecord.FieldLength = In_FieldLength,BankDiskRecord.ValidationCheck = In_ValidationCheck where
      BankDiskRecord.BankDiskName = In_BankDiskName and BankDiskRecord.OrderReference = In_OrderReference
  else
    insert into BankDiskRecord(BankDiskName,OrderReference,FieldDescription,FieldLength,ValidationCheck) values(
      In_BankDiskName,In_OrderReference,In_FieldDescription,In_FieldLength,In_ValidationCheck)
  end if;
  commit work
end
;

create procedure dba.InsertNewBankFilter(
in In_BankFilterId char(20),
in In_BankFilterDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankFilter where BankFilter.BankFilterId = In_BankFilterId) then
    insert into BankFilter(BankFilterId,
      BankFilterDesc) values(
      In_BankFilterId,
      In_BankFilterDesc);
    if not exists(select* from BankFilter where BankFilter.BankFilterId = In_BankFilterId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewBankRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentBankCode char(20),
in In_PaymentBankBrCode char(20),
in In_PaymentBankAccNo char(30),
in In_PaymentAmt double,
in In_PaymentCategory char(20),
in In_PaymentType char(20),
in In_PaymentValue double,
in In_PaymentBankAccType char(20),
in In_PaymentMode char(20),
in In_BeneficiaryName char(150))
begin
  if not exists(select* from BankRecord where
      BankRecord.EmployeeSysId = In_EmployeeSysId and
      BankRecord.PayRecYear = In_PayRecYear and
      BankRecord.PayRecPeriod = In_PayRecPeriod and
      BankRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BankRecord.PayRecID = In_PayRecID and
      BankRecord.PaymentBankCode = In_PaymentBankCode and
      BankRecord.PaymentBankBrCode = In_PaymentBankBrCode and
      BankRecord.PaymentBankAccNo = In_PaymentBankAccNo and
      BankRecord.BeneficiaryName = In_BeneficiaryName) then
    insert into BankRecord(BankRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      PaymentBankCode,
      PaymentBankBrCode,
      PaymentBankAccNo,
      PaymentAmt,
      PaymentCategory,
      PaymentType,
      PaymentValue,
      PaymentBankAccType,
      PaymentMode,
      BeneficiaryName) values(
      FGetNewSGSPGeneratedIndex('BankRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_PaymentBankCode,
      In_PaymentBankBrCode,
      In_PaymentBankAccNo,
      In_PaymentAmt,
      In_PaymentCategory,
      In_PaymentType,
      In_PaymentValue,
      In_PaymentBankAccType,
      In_PaymentMode,
      In_BeneficiaryName);
    commit work
  end if
end
;

create procedure DBA.InsertNewBasicRateProgression(
in In_EmployeeSysId integer,
in In_BRProgDate date,
in In_BRProgRemarks char(255),
in In_BRProgEffectiveDate date,
in In_BRProgBasicRateType char(20),
in In_BRProgNewBasicRate double,
in In_BRProgPercentage double,
in In_BRProgressionCode char(20),
in In_BRProgCareerId char(20),
in In_BRProgPrevBasicRate double,
in In_BRProgIncrementAmt double,
in In_BRProgPayGroup char(20),
in In_BRProgCurrent smallint,
in In_BRProgNextIncDate date,
in In_BRProgExRateId char(20))
begin
  if(In_BRProgCurrent = 1) then
    if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgCurrent = In_BRProgCurrent) then
      update BasicRateProgression set
        BasicRateProgression.BRProgCurrent = 0 where
        BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgCurrent = In_BRProgCurrent;
      commit work
    end if
  end if;
  if not exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgDate = In_BRProgDate) then
    insert into BasicRateProgression(EmployeeSysId,BRProgRemarks,BRProgDate,BRProgEffectiveDate,BRProgBasicRateType,BRProgNewBasicRate,
      BRProgPercentage,BRProgressionCode,BRProgCareerId,BRProgPrevBasicRate,BRProgIncrementAmt,BRProgPayGroup,BRProgCurrent,BRProgNextIncDate,BRProgExRateId) values(
      In_EmployeeSysId,In_BRProgRemarks,In_BRProgDate,In_BRProgEffectiveDate,In_BRProgBasicRateType,In_BRProgNewBasicRate,
      In_BRProgPercentage,In_BRProgressionCode,In_BRProgCareerId,In_BRProgPrevBasicRate,In_BRProgIncrementAmt,
      In_BRProgPayGroup,In_BRProgCurrent,In_BRProgNextIncDate,In_BRProgExRateId);
    commit work
  end if
end
;

create procedure DBA.InsertNewBonusProcess(
in In_BonusReportId char(20),
in In_BonusDescription char(100),
in In_BonusPayGroup char(20),
in In_BonusCode char(20),
in In_BonusFromYear integer,
in In_BonusFromMonth integer,
in In_BonusToYear integer,
in In_BonusToMonth integer,
in In_BonusTrialRun smallint,
in In_BonusFactorOpt smallint,
in In_BonusSysFactor double,
in In_BonusTerminated smallint,
in In_BonusFutureTerminated smallint,
in In_BonusConfirmed smallint,
in In_BonusCPFDeduct smallint,
in In_BonusWageOpt char(20),
in In_BonusFixedWage double,
in In_BonusDaysOpt char(20),
in In_BonusCutOffDay integer,
in In_BonusNPL smallint,
in In_BonusSick smallint,
in In_BonusAnnual smallint,
in In_BonusAbsent smallint,
in In_BonusCessation smallint,
in In_BonusHire smallint,
in In_BonusDeclaredDate date,
in In_BonusCutOffSvcMth double,
in In_BonusApprDateFrom date,
in In_BonusApprDateTo date,
in In_BonusApprMethod smallint,
in In_BonusRoundAmount smallint)
begin
  if not exists(select* from BonusProcess where BonusProcess.BonusReportId = In_BonusReportId) then
    insert into BonusProcess(BonusReportId,BonusDescription,BonusPayGroup,BonusCode,
      BonusFromYear,BonusFromMonth,BonusToYear,BonusToMonth,BonusTrialRun,BonusFactorOpt,
      BonusSysFactor,BonusTerminated,BonusFutureTerminated,BonusConfirmed,BonusCPFDeduct,BonusWageOpt,
      BonusFixedWage,BonusDaysOpt,BonusCutOffDay,BonusNPL,BonusSick,BonusAnnual,
      BonusAbsent,BonusCessation,BonusHire,BonusDeclaredDate,
      BonusCutOffSvcMth,
      BonusApprDateFrom,
      BonusApprDateTo,
      BonusApprMethod,
      BonusRoundAmount) values(
      In_BonusReportId,
      In_BonusDescription,
      In_BonusPayGroup,
      In_BonusCode,
      In_BonusFromYear,
      In_BonusFromMonth,
      In_BonusToYear,
      In_BonusToMonth,
      In_BonusTrialRun,
      In_BonusFactorOpt,
      In_BonusSysFactor,
      In_BonusTerminated,
      In_BonusFutureTerminated,
      In_BonusConfirmed,
      In_BonusCPFDeduct,
      In_BonusWageOpt,
      In_BonusFixedWage,
      In_BonusDaysOpt,
      In_BonusCutOffDay,
      In_BonusNPL,
      In_BonusSick,
      In_BonusAnnual,
      In_BonusAbsent,
      In_BonusCessation,
      In_BonusHire,
      In_BonusDeclaredDate,
      In_BonusCutOffSvcMth,
      In_BonusApprDateFrom,
      In_BonusApprDateTo,
      In_BonusApprMethod,
      In_BonusRoundAmount);
    commit work
  end if
end
;

create procedure dba.InsertNewBonusRecord(
in In_BonusRecordSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BonusBaseWage double,
in In_BonusDaysWorked double,
in In_BonusNPL double,
in In_BonusAnnual double,
in In_BonusSick double,
in In_BonusAmt double,
in In_BonusFactor numeric(8,5))
begin
  if not exists(select* from BonusRecord where
      BonusRecord.EmployeeSysId = In_EmployeeSysId and
      BonusRecord.PayRecYear = In_PayRecYear and
      BonusRecord.PayRecPeriod = In_PayRecPeriod and
      BonusRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BonusRecord.PayRecID = In_PayRecID) then
    insert into BonusRecord(BonusRecordSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      BonusBaseWage,
      BonusDaysWorked,
      BonusNPL,
      BonusAnnual,
      BonusSick,
      BonusAmt,
      BonusFactor) values(
      FGetNewSGSPGeneratedIndex('BonusRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_BonusBaseWage,
      In_BonusDaysWorked,
      In_BonusNPL,
      In_BonusAnnual,
      In_BonusSick,
      In_BonusAmt,
      In_BonusFactor);
    commit work
  end if
end
;

create procedure DBA.InsertNewBonusReport(
in In_BonusReportId char(20),
in In_BonusEmployeeSysId integer,
in In_BonusAmount double,
in In_BonusWage double,
in In_BonusDayMonth double,
in In_BonusEENPL double,
in In_BonusEESick double,
in In_BonusEEAnnual double,
in In_BonusEEAbsent double,
in In_BonusFactor double,
in In_BonusProrateFactor double,
in In_BonusWageF double,
in In_BonusExRateId char(20),
in In_BonusExRate double)
begin
  if not exists(select* from BonusReport where
      BonusReport.BonusReportId = In_BonusReportId and BonusReport.BonusEmployeeSysId = In_BonusEmployeeSysId) then
    insert into BonusReport(BonusReportId,
      BonusEmployeeSysId,
      BonusAmount,
      BonusWage,
      BonusDayMonth,
      BonusEENPL,
      BonusEESick,
      BonusEEAnnual,
      BonusEEAbsent,
      BonusFactor,
      BonusProrateFactor,
      BonusWageF,
      BonusExRateId,
      BonusExRate) values(
      In_BonusReportId,
      In_BonusEmployeeSysId,
      In_BonusAmount,
      In_BonusWage,
      In_BonusDayMonth,
      In_BonusEENPL,
      In_BonusEESick,
      In_BonusEEAnnual,
      In_BonusEEAbsent,
      In_BonusFactor,
      In_BonusProrateFactor,
      In_BonusWageF,
      In_BonusExRateId,
      In_BonusExRate);
    commit work
  end if
end
;

create procedure dba.InsertNewCareer(
in In_CareerId char(20),
in In_CareerDesc char(100))
begin
  if not exists(select* from Career where Career.CareerId = In_CareerId) then
    insert into Career(CareerId,CareerDesc) values(
      In_CareerId,In_CareerDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCPFAgeGroup(
in In_AgeGroupId char(20),
in In_AgeGroupDesc char(100),
in In_MinCPFAge integer,
in In_MaxCPFAge integer)
begin
  if not exists(select* from CPFAgeGroup where
      CPFAgeGroup.AgeGroupId = In_AgeGroupId) then
    insert into CPFAgeGroup(AgeGroupId,
      AgeGroupDesc,MinCPFAge,
      MaxCPFAge) values(In_AgeGroupId,
      In_AgeGroupDesc,In_MinCPFAge,
      In_MaxCPFAge);
    commit work
  end if
end
;

create procedure DBA.InsertNewCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date,
in In_CPFGovtPolicyId char(20),
in In_CPFGovtCurrent smallint,
in In_CPFGovtRemarks char(255))
begin
  if not exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate) then
    insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtPolicyId,CPFGovtCurrent,
      CPFGovtRemarks) values(In_CPFGovtEffectiveDate,In_CPFGovtPolicyId,In_CPFGovtCurrent,
      In_CPFGovtRemarks);
    commit work
  end if
end
;

create procedure dba.InsertNewCPFPayment(
in In_EmployeeSysId integer,
in In_CPFPaymentSubPeriod integer,
in In_CPFPaymentOption integer)
begin
  if not exists(select* from CPFPayment where
      CPFPayment.EmployeeSysId = In_EmployeeSysId and CPFPayment.CPFPaymentSubPeriod = In_CPFPaymentSubPeriod) then
    insert into CPFPayment(EmployeeSysId,CPFPaymentSubPeriod,CPFPaymentOption) values(
      In_EmployeeSysId,In_CPFPaymentSubPeriod,In_CPFPaymentOption);
    commit work
  end if
end
;

create procedure DBA.InsertNewCPFPolicy(
in In_CPFPolicyId char(20),
in In_CPFGovernment smallint,
in In_CPFPolicyDesc char(100))
begin
  if not exists(select* from CPFPolicy where
      CPFPolicy.CPFPolicyId = In_CPFPolicyId) then
    insert into CPFPolicy(CPFPolicyId,CPFGovernment,
      CPFPolicyDesc) values(In_CPFPolicyId,In_CPFGovernment,
      In_CPFPolicyDesc);
    commit work
  end if
end
;

create procedure DBA.InsertNewCPFPolicyMember(
in In_CPFPolicyId char(20),
in In_CPFTableCodeId char(20))
begin
  if not exists(select* from CPFPolicyMember where
      CPFPolicyMember.CPFPolicyId = In_CPFPolicyId and
      CPFPolicyMember.CPFTableCodeId = In_CPFTableCodeId) then
    insert into CPFPolicyMember(CPFPolicyId,
      CPFTableCodeId) values(In_CPFPolicyId,
      In_CPFTableCodeId);
    commit work
  end if
end
;

create procedure DBA.InsertNewCPFProgression(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFProgRemarks char(255))
begin
  if not exists(select* from CPFProgression where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    insert into CPFProgression(EmployeeSysId,
      CPFEffectiveDate,
      CPFProgCurrent,
      CPFCareerId,
      CPFProgPolicyId,
      CPFProgAccountNo,
      CPFProgSchemeId,
      CPFMAWOption,
      CPFMAWLimit,
      CPFMAWPeriodOrdWage,
      CPFMedisavePaidByER,
      CPFProgRemarks) values(
      In_EmployeeSysId,
      In_CPFEffectiveDate,
      In_CPFProgCurrent,
      In_CPFCareerId,
      In_CPFProgPolicyId,
      In_CPFProgAccountNo,
      In_CPFProgSchemeId,
      In_CPFMAWOption,
      In_CPFMAWLimit,
      In_CPFMAWPeriodOrdWage,
      In_CPFMedisavePaidByER,
      In_CPFProgRemarks);
    commit work
  end if
end
;

create procedure dba.InsertNewCPFSalaryGroup(
in In_SalaryGroupId char(20),
in In_SalaryGroupDesc char(100),
in In_MinSalary numeric(10,2),
in In_MaxSalary numeric(10,2))
begin
  if not exists(select* from CPFSalaryGroup where
      CPFSalaryGroup.SalaryGroupId = In_SalaryGroupId) then
    insert into CPFSalaryGroup(SalaryGroupId,
      SalaryGroupDesc,MinSalary,
      MaxSalary) values(In_SalaryGroupId,
      In_SalaryGroupDesc,In_MinSalary,In_MaxSalary);
    commit work
  end if
end
;

create procedure dba.InsertNewCPFTableCode(
in In_CPFTableCodeId char(20),
in In_CPFResidenceTypeId char(20),
in In_CPFSchemeId char(20),
in In_CPFPeriodCapping double,
in In_CPFLessThanCapping double,
in In_CPFGreaterThanCapping double,
in In_CPFTableDesc char(100))
begin
  if not exists(select* from CPFTableCode where
      CPFTableCode.CPFTableCodeId = In_CPFTableCodeId) then
    insert into CPFTableCode(CPFTableCodeId,CPFResidenceTypeId,
      CPFSchemeId,CPFPeriodCapping,
      CPFLessThanCapping,
      CPFGreaterThanCapping,
      CPFTableDesc) values(In_CPFTableCodeId,In_CPFResidenceTypeId,
      In_CPFSchemeId,In_CPFPeriodCapping,
      In_CPFLessThanCapping,
      In_CPFGreaterThanCapping,
      In_CPFTableDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCPFTableComponent(
in In_CPFTableCodeId char(20),
in In_MinSalary double,
in In_MinCPFAge double,
in In_MaxSalary double,
in In_MaxCPFAge double)
begin
  if not exists(select* from CPFTableComponent where
      CPFTableComponent.CPFTableCodeId = In_CPFTableCodeId and
      CPFTableComponent.MinSalary = In_MinSalary and
      CPFTableComponent.MinCPFAge = In_MinCPFAge) then
    if(FGetDBCountry(*) = 'Indonesia') then
      insert into CPFTableComponent(CPFTableCodeId,
        MinSalary,
        MinCPFAge,
        MaxSalary,
        MaxCPFAge,
        EEOrdCPFFormula,
        EROrdCPFFormula,
        EEAddCPFFormula,
        ERAddCPFFormula) values(
        In_CPFTableCodeId,
        In_MinSalary,
        In_MinCPFAge,
        In_MaxSalary,
        In_MaxCPFAge,
        FGetNewCPFGeneratedIndex('JEE'),
        FGetNewCPFGeneratedIndex('JOLD'),
        FGetNewCPFGeneratedIndex('JACC'),
        FGetNewCPFGeneratedIndex('JDTH'))
    else
      insert into CPFTableComponent(CPFTableCodeId,
        MinSalary,
        MinCPFAge,
        MaxSalary,
        MaxCPFAge,
        EEOrdCPFFormula,
        EROrdCPFFormula,
        EEAddCPFFormula,
        ERAddCPFFormula) values(
        In_CPFTableCodeId,
        In_MinSalary,
        In_MinCPFAge,
        In_MaxSalary,
        In_MaxCPFAge,
        FGetNewCPFGeneratedIndex('CEEO'),
        FGetNewCPFGeneratedIndex('CERO'),
        FGetNewCPFGeneratedIndex('CEEA'),
        FGetNewCPFGeneratedIndex('CERA'))
    end if;
    commit work
  end if
end
;

create procedure dba.InsertNewDefaultCPFPayment(
in In_PayGroupId char(20),
in In_DefaultCPFPaymentSubPeriod integer,
in In_CPFPaymentOption integer)
begin
  if not exists(select* from DefaultCPFPayment where DefaultCPFPayment.PayGroupId = In_PayGroupId and
      DefaultCPFPayment.DefaultCPFPaymentSubPeriod = In_DefaultCPFPaymentSubPeriod) then
    insert into DefaultCPFPayment(PayGroupId,DefaultCPFPaymentSubPeriod,CPFPaymentOption) values(
      In_PayGroupId,In_DefaultCPFPaymentSubPeriod,In_CPFPaymentOption);
    commit work
  end if
end
;

create procedure dba.InsertNewDefaultPayAllocation(
in In_PayGroupId char(20),
in In_DefaultPayAllocSubPeriod integer,
in In_DefaultPayBasicRateType char(20),
in In_DefaultPayAllocTypeId char(20),
in In_DefaultPayAllocValue numeric(14,2))
begin
  if not exists(select* from DefaultPayAllocation where DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod and
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType) then
    insert into DefaultPayAllocation(PayGroupId,DefaultPayAllocSubPeriod,
      DefaultPayBasicRateType,DefaultPayAllocTypeId,
      DefaultPayAllocValue) values(
      In_PayGroupId,In_DefaultPayAllocSubPeriod,
      In_DefaultPayBasicRateType,In_DefaultPayAllocTypeId,
      In_DefaultPayAllocValue);
    commit work
  end if
end
;

create procedure dba.InsertNewDetailRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_PreviousHrDays double,
in In_CurrentHrDays double,
in In_PreviousHrDaysRate double,
in In_CurrentHrDaysRate double,
in In_PayAllocationType char(20),
in In_PayAllocationValue double,
in In_CalTotalWage double,
in In_CalOTAmount double,
in In_CalOTBackPay double,
in In_CalShiftAmount double,
in In_CalLveDeductAmt double,
in In_CalBackPay double,
in In_CalGrossWage double,
in In_CalTotalGrossWage double,
in In_CalNetWage double,
in In_AllocatedBasicRate double,
in In_CurBackPayBasicRate double,
in In_PrevBackPayBasicRate double,
in In_FullBackPayFreq double,
in In_ProratedBackPayFreq double,
in In_BackPayProgressionDate date,
in In_CurrentBasicRateF double,
in In_CurrentBRExRateId char(20),
in In_CurrentBRExRate double,
in In_PreviousBasicRateF double,
in In_AllocatedBasicRateF double,
in In_CalTotalWageF double,
in In_CalBackPayF double,
in In_CurBackPayBasicRateF double,
in In_PrevBackPayBasicRateF double,
in In_FreeNumeric1 double,
in In_FreeNumeric2 double,
in In_FreeNumeric3 double,
in In_FreeNumeric4 double,
in In_FreeNumeric5 double,
in In_FreeString1 char(200),
in In_FreeString2 char(200),
in In_FreeString3 char(200),
in In_FreeString4 char(200),
in In_FreeString5 char(200),
in In_NetWageP double,
in In_NetWageExRateId char(20),
in In_NetWageExRate double,
in In_NetWageBankAllocGpId char(20))
begin
  if not exists(select* from DetailRecord where
      DetailRecord.EmployeeSysId = In_EmployeeSysId and
      DetailRecord.PayRecYear = In_PayRecYear and
      DetailRecord.PayRecPeriod = In_PayRecPeriod and
      DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      DetailRecord.PayRecID = In_PayRecID) then
    insert into DetailRecord(DetailRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      CurrentBasicRate,
      PreviousBasicRate,
      CurrentBasicRateType,
      PreviousBasicRateType,
      PreviousHrDays,
      CurrentHrDays,
      PreviousHrDaysRate,
      CurrentHrDaysRate,
      PayAllocationType,
      PayAllocationValue,
      CalTotalWage,
      CalOTAmount,
      CalOTBackPay,
      CalShiftAmount,
      CalLveDeductAmt,
      CalBackPay,
      CalGrossWage,
      CalTotalGrossWage,
      CalNetWage,
      AllocatedBasicRate,
      CurBackPayBasicRate,
      PrevBackPayBasicRate,
      FullBackPayFreq,
      ProratedBackPayFreq,
      BackPayProgressionDate,
      CurrentBasicRateF,
      CurrentBRExRateId,
      CurrentBRExRate,
      PreviousBasicRateF,
      AllocatedBasicRateF,
      CalTotalWageF,
      CalBackPayF,
      CurBackPayBasicRateF,
      PrevBackPayBasicRateF,
      FreeNumeric1,
      FreeNumeric2,
      FreeNumeric3,
      FreeNumeric4,
      FreeNumeric5,
      FreeString1,
      FreeString2,
      FreeString3,
      FreeString4,
      FreeString5,
      NetWageP,
      NetWageExRateId,
      NetWageExRate,
      NetWageBankAllocGpId) values(
      FGetNewSGSPGeneratedIndex('DetailRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_CurrentBasicRate,
      In_PreviousBasicRate,
      In_CurrentBasicRateType,
      In_PreviousBasicRateType,
      In_PreviousHrDays,
      In_CurrentHrDays,
      In_PreviousHrDaysRate,
      In_CurrentHrDaysRate,
      In_PayAllocationType,
      In_PayAllocationValue,
      In_CalTotalWage,
      In_CalOTAmount,
      In_CalOTBackPay,
      In_CalShiftAmount,
      In_CalLveDeductAmt,
      In_CalBackPay,
      In_CalGrossWage,
      In_CalTotalGrossWage,
      In_CalNetWage,
      In_AllocatedBasicRate,
      In_CurBackPayBasicRate,
      In_PrevBackPayBasicRate,
      In_FullBackPayFreq,
      In_ProratedBackPayFreq,
      In_BackPayProgressionDate,
      In_CurrentBasicRateF,
      In_CurrentBRExRateId,
      In_CurrentBRExRate,
      In_PreviousBasicRateF,
      In_AllocatedBasicRateF,
      In_CalTotalWageF,
      In_CalBackPayF,
      In_CurBackPayBasicRateF,
      In_PrevBackPayBasicRateF,
      In_FreeNumeric1,
      In_FreeNumeric2,
      In_FreeNumeric3,
      In_FreeNumeric4,
      In_FreeNumeric5,
      In_FreeString1,
      In_FreeString2,
      In_FreeString3,
      In_FreeString4,
      In_FreeString5,
      In_NetWageP,
      In_NetWageExRateId,
      In_NetWageExRate,
      In_NetWageBankAllocGpId);
    commit work
  end if
end
;

create procedure DBA.InsertNewEmployPassProgression(
in In_EmployeeSysId integer,
in In_EPEffectiveDate date,
in In_EPCareerId char(20),
in In_EPExpiryDate date,
in In_EPApplicationDate date,
in In_EPArrivalDate date,
in In_EPCancellationDate date,
in In_EPIssueDate date,
in In_EPFIN char(20),
in In_EPRemarks char(255),
in In_EPCurrent smallint)
begin
  if not exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate) then
    if(In_EPCurrent = 1) then
      update EmployPassProgression set
        EmployPassProgression.EPCurrent = 0 where
        EmployPassProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    insert into EmployPassProgression(EmployeeSysId,
      EPEffectiveDate,
      EPCareerId,
      EPExpiryDate,
      EPApplicationDate,
      EPArrivalDate,
      EPCancellationDate,
      EPIssueDate,
      EPFIN,
      EPRemarks,
      EPCurrent) values(
      In_EmployeeSysId,
      In_EPEffectiveDate,
      In_EPCareerId,
      In_EPExpiryDate,
      In_EPApplicationDate,
      In_EPArrivalDate,
      In_EPCancellationDate,
      In_EPIssueDate,
      In_EPFIN,
      In_EPRemarks,
      In_EPCurrent);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpRecurAllow(
in In_RecurAlloDesc char(100),
in In_FormulaId char(20),
in In_RecurAlloFullAmount double,
in In_RecurAlloAmount double,
in In_RecurAlloSuspense integer,
in In_RecurAlloEndCounter integer,
in In_RecurAlloSubPeriod integer,
in In_RecurAlloStartPeriod integer,
in In_RecurAlloStartYear integer,
in In_RecurAlloEndPeriod integer,
in In_RecurAlloEndYear integer,
in In_EmployeeSysId integer,
in In_RecurCreated char(1),
in In_RecurAlloPayRecId char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
out Out_RecurAlloSGSPGenId char(30))
/* RESULT ( column-name,... ) */
begin
  set Out_RecurAlloSGSPGenId=FGetNewSGSPGeneratedIndex('EmployeeRecurAllowance');
  insert into EmployeeRecurAllowance(RecurAlloSGSPGenId,
    RecurAlloDesc,
    FormulaId,
    RecurAlloFullAmount,
    RecurAlloAmount,
    RecurAlloSuspense,
    RecurAlloEndCounter,
    RecurAlloSubPeriod,
    RecurAlloStartPeriod,
    RecurAlloStartYear,
    RecurAlloEndPeriod,
    RecurAlloEndYear,
    EmployeeSysId,
    RecurCreated,
    RecurAlloPayRecId,
    UserDef1Value,
    UserDef2Value,
    UserDef3Value,
    UserDef4Value,
    UserDef5Value) values(
    Out_RecurAlloSGSPGenId,
    In_RecurAlloDesc,
    In_FormulaId,
    In_RecurAlloFullAmount,
    In_RecurAlloAmount,
    In_RecurAlloSuspense,
    In_RecurAlloEndCounter,
    In_RecurAlloSubPeriod,
    In_RecurAlloStartPeriod,
    In_RecurAlloStartYear,
    In_RecurAlloEndPeriod,
    In_RecurAlloEndYear,
    In_EmployeeSysId,
    In_RecurCreated,
    In_RecurAlloPayRecId,
    In_UserDef1Value,
    In_UserDef2Value,
    In_UserDef3Value,
    In_UserDef4Value,
    In_UserDef5Value);
  commit work
end
;

create procedure dba.InsertNewFormula(
in In_FormulaId char(20),
in In_FormulaActive integer,
in In_FormulaPreprocess integer,
in In_FormulaRecurring integer,
in In_FormulaCategory char(20),
in In_FormulaSubCategory char(20),
in In_FormulaType char(20),
in In_FormulaRangeBasis char(20),
in In_FormulaDesc char(255),
in In_FormulaExRateId char(20))
begin
  if not exists(select* from Formula where
      Formula.FormulaId = In_FormulaId) then
    insert into Formula(FormulaId,
      FormulaActive,FormulaPreprocess,
      FormulaRecurring,FormulaCategory,
      FormulaSubCategory,FormulaType,
      FormulaRangeBasis,FormulaDesc,
      FormulaExRateId,FormulaStage,FormulaRank) values(
      In_FormulaId,
      In_FormulaActive,In_FormulaPreprocess,
      In_FormulaRecurring,In_FormulaCategory,
      In_FormulaSubCategory,In_FormulaType,
      In_FormulaRangeBasis,In_FormulaDesc,
      In_FormulaExRateId,0,0);
    commit work
  end if
end
;

create procedure dba.InsertNewFormulaProperty(
in In_KeyWordId char(20),
in In_FormulaId char(20))
begin
  if not exists(select* from FormulaProperty where
      FormulaProperty.KeyWordId = In_KeyWordId and
      FormulaProperty.FormulaId = In_FormulaId) then
    insert into FormulaProperty(KeyWordId,
      FormulaId) values(In_KeyWordId,
      In_FormulaId);
    commit work
  end if
end
;

create procedure dba.InsertNewFormulaRange(
out In_FormulaRangeId integer,
in In_FormulaId char(20),
in In_Maximum double,
in In_Minimum double,
in In_Formula char(255),
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20))
begin
  declare Max_FormulaRangeId integer;
  declare Count_FormulaRangeId integer;
  set Max_FormulaRangeId=0;
  set Count_FormulaRangeId=0;
  select MAX(FormulaRangeId),COUNT(FormulaRangeId) into Max_FormulaRangeId,
    Count_FormulaRangeId from FormulaRange where
    FormulaRange.FormulaId = In_FormulaId;
  if(Count_FormulaRangeId = 0) then
    set Max_FormulaRangeId=1
  else
    set Max_FormulaRangeId=Max_FormulaRangeId+1
  end if;
  insert into FormulaRange(FormulaRangeId,
    FormulaId,Maximum,
    Minimum,Formula,
    Constant1,Constant2,
    Constant3,Constant4,
    Constant5,Keywords1,
    Keywords2,Keywords3,
    Keywords4,Keywords5,
    Keywords6,Keywords7,
    Keywords8,Keywords9,
    Keywords10,UserDef1,
    UserDef2,UserDef3,
    UserDef4,UserDef5,
    F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,
    P1,P2,P3,P4,P5,P6,P7,P8,P9,P10) values(
    Max_FormulaRangeId,
    In_FormulaId,In_Maximum,
    In_Minimum,In_Formula,
    In_Constant1,In_Constant2,
    In_Constant3,In_Constant4,
    In_Constant5,In_Keywords1,
    In_Keywords2,In_Keywords3,
    In_Keywords4,In_Keywords5,
    In_Keywords6,In_Keywords7,
    In_Keywords8,In_Keywords9,
    In_Keywords10,In_UserDef1,
    In_UserDef2,In_UserDef3,
    In_UserDef4,In_UserDef5,
    In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
    In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,In_P10);
  set In_FormulaRangeId=Max_FormulaRangeId;
  commit work
end
;

create procedure dba.InsertNewFWLProgression(
in In_FWLExpiryDate date,
in In_FWLEffectiveDate date,
in In_FWLApplicationDate date,
in In_FWLArrivalDate date,
in In_FWLCancellationDate date,
in In_FWLIssueDate date,
in In_FWLPermitNumber char(30),
in In_FWLCareerId char(20),
in In_FWLFormulaId char(20),
in In_FWLRemarks char(255),
in In_EmployeeSysId integer,
in In_FWLCurrent integer)
begin
  if not exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate) then
    if(In_FWLCurrent = 1) then
      update FWLProgression set
        FWLProgression.FWLCurrent = 0 where
        FWLProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    insert into FWLProgression(FWLExpiryDate,
      FWLEffectiveDate,
      FWLApplicationDate,
      FWLArrivalDate,
      FWLCancellationDate,
      FWLIssueDate,
      FWLPermitNumber,
      FWLCareerId,
      FWLFormulaId,
      FWLRemarks,
      EmployeeSysId,
      FWLCurrent) values(
      In_FWLExpiryDate,
      In_FWLEffectiveDate,
      In_FWLApplicationDate,
      In_FWLArrivalDate,
      In_FWLCancellationDate,
      In_FWLIssueDate,
      In_FWLPermitNumber,
      In_FWLCareerId,
      In_FWLFormulaId,
      In_FWLRemarks,
      In_EmployeeSysId,
      In_FWLCurrent);
    commit work
  end if
end
;

create procedure dba.InsertNewKeyWord(
in In_KeyWordId char(20),
in In_KeyWordDefaultName char(20),
in In_KeyWordUserDefinedName char(20),
in In_KeyWordCategory char(20),
in In_KeyWordDesc char(100),
in In_KeyWordPropertySelection integer,
in In_KeyWordFormulaSelection integer,
in In_KeyWordRangeSelection integer)
begin
  if not exists(select* from KeyWord where
      KeyWord.KeyWordId = In_KeyWordId) then
    insert into KeyWord(KeyWordId,
      KeyWordDefaultName,KeyWordUserDefinedName,
      KeyWordCategory,KeyWordDesc,
      KeyWordPropertySelection,KeyWordFormulaSelection,
      KeyWordRangeSelection) values(In_KeyWordId,
      In_KeyWordDefaultName,In_KeyWordUserDefinedName,
      In_KeyWordCategory,In_KeyWordDesc,
      In_KeyWordPropertySelection,In_KeyWordFormulaSelection,
      In_KeyWordRangeSelection);
    commit work
  end if
end
;

create procedure dba.InsertNewLicenseRecord(
in In_SerialNo char(20),
in In_CompanyName char(200),
in In_LicenseExpiringDate date,
in In_SubSerialNo char(20),
in In_SubCompanyName char(200),
in In_ProductName char(100),
in In_SubProductName char(100),
in In_Functionlist varchar(2048),
in In_StrKey1 char(100),
in In_StrKey2 char(100),
in In_StrKey3 char(100),
in In_StrKey4 char(100),
in In_StrKey5 char(100),
in In_StrKey6 char(100),
in In_StrKey7 char(100),
in In_StrKey8 char(100),
in In_StrKey9 char(100),
in In_StrKey10 char(100),
in In_StrKey11 char(100),
in In_StrKey12 char(100),
in In_StrKey13 char(100),
in In_StrKey14 char(100),
in In_StrKey15 char(100),
in In_StrKey16 char(100),
in In_StrKey17 char(100),
in In_StrKey18 char(100),
in In_StrKey19 char(100),
in In_StrKey20 char(100),
in In_NumKey1 integer,
in In_NumKey2 integer,
in In_NumKey3 integer,
in In_NumKey4 integer,
in In_NumKey5 integer,
in In_NumKey6 integer,
in In_NumKey7 integer,
in In_NumKey8 integer,
in In_NumKey9 integer,
in In_NumKey10 integer,
in In_NumKey11 integer,
in In_NumKey12 integer,
in In_NumKey13 integer,
in In_NumKey14 integer,
in In_NumKey15 integer,
in In_NumKey16 integer,
in In_NumKey17 integer,
in In_NumKey18 integer,
in In_NumKey19 integer,
in In_NumKey20 integer,
in In_GenerateDate date,
in In_LicenseKey char(17))
begin
  if not exists(select* from LicenseRecord where LicenseRecord.ProductName = In_ProductName and
      LicenseRecord.SubProductName = In_SubProductName) then
    insert into LicenseRecord(SerialNo,
      CompanyName,
      LicenseExpiringDate,
      SubSerialNo,
      SubCompanyName,
      ProductName,
      SubProductName,
      Functionlist,
      StrKey1,
      StrKey2,
      StrKey3,
      StrKey4,
      StrKey5,
      StrKey6,
      StrKey7,
      StrKey8,
      StrKey9,
      StrKey10,
      StrKey11,
      StrKey12,
      StrKey13,
      StrKey14,
      StrKey15,
      StrKey16,
      StrKey17,
      StrKey18,
      StrKey19,
      StrKey20,
      NumKey1,
      NumKey2,
      NumKey3,
      NumKey4,
      NumKey5,
      NumKey6,
      NumKey7,
      NumKey8,
      NumKey9,
      NumKey10,
      NumKey11,
      NumKey12,
      NumKey13,
      NumKey14,
      NumKey15,
      NumKey16,
      NumKey17,
      NumKey18,
      NumKey19,
      NumKey20,
      GenerateDate,
      LicenseKey) values(
      In_SerialNo,
      In_CompanyName,
      In_LicenseExpiringDate,
      In_SubSerialNo,
      In_SubCompanyName,
      In_ProductName,
      In_SubProductName,
      In_Functionlist,
      In_StrKey1,
      In_StrKey2,
      In_StrKey3,
      In_StrKey4,
      In_StrKey5,
      In_StrKey6,
      In_StrKey7,
      In_StrKey8,
      In_StrKey9,
      In_StrKey10,
      In_StrKey11,
      In_StrKey12,
      In_StrKey13,
      In_StrKey14,
      In_StrKey15,
      In_StrKey16,
      In_StrKey17,
      In_StrKey18,
      In_StrKey19,
      In_StrKey20,
      In_NumKey1,
      In_NumKey2,
      In_NumKey3,
      In_NumKey4,
      In_NumKey5,
      In_NumKey6,
      In_NumKey7,
      In_NumKey8,
      In_NumKey9,
      In_NumKey10,
      In_NumKey11,
      In_NumKey12,
      In_NumKey13,
      In_NumKey14,
      In_NumKey15,
      In_NumKey16,
      In_NumKey17,
      In_NumKey18,
      In_NumKey19,
      In_NumKey20,
      In_GenerateDate,
      In_LicenseKey);
    commit work
  end if
end
;

create procedure dba.InsertNewModifyPayElement(
out Out_GenId char(30),
in In_IsFormula smallint,
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20),
in In_Formula char(255))
begin
  call InsertNewAllowanceRecord(
  In_EmployeeSysId,
  In_PayRecYear,
  In_PayRecPeriod,
  In_PayRecSubPeriod,
  In_PayRecID,
  In_AllowanceFormulaId,
  In_AllowanceAmount,
  In_AllowanceRecurSysId,
  In_AllowancePreProcessRec,
  In_AllowanceCreatedBy,
  In_AllowanceDeclaredDate,
  In_AllowanceRemarks,
  In_AllowanceCustSysId,
  In_AllowanceAmountF,
  In_AllowanceExRateId,
  In_AllowanceExRate,
  Out_GenId);
  if(In_IsFormula = 1) then
    call InsertNewAllowanceHistoryRecord(Out_GenId,
    In_Constant1,
    In_Constant2,
    In_Constant3,
    In_Constant4,
    In_Constant5,
    In_Keywords1,
    In_Keywords2,
    In_Keywords3,
    In_Keywords4,
    In_Keywords5,
    In_Keywords6,
    In_Keywords7,
    In_Keywords8,
    In_Keywords9,
    In_Keywords10,
    In_UserDef1,
    In_UserDef2,
    In_UserDef3,
    In_UserDef4,
    In_UserDef5,
    In_UserDef1Value,
    In_UserDef2Value,
    In_UserDef3Value,
    In_UserDef4Value,
    In_UserDef5Value,
    In_F1,In_F2,In_F3,In_F4,In_F5,In_F6,In_F7,In_F8,In_F9,In_F10,
    In_P1,In_P2,In_P3,In_P4,In_P5,In_P6,In_P7,In_P8,In_P9,In_P10,
    In_Formula);
    commit work
  end if
end
;

create procedure dba.InsertNewOTMember(
in In_OTTableId char(20),
in In_FormulaId char(20))
begin
  if not exists(select* from OTMember where
      OTMember.OTTableId = In_OTTableId and
      OTMember.FormulaId = In_FormulaId) then
    insert into OTMember(OTTableId,
      FormulaId) values(In_OTTableId,
      In_FormulaId);
    commit work
  end if
end
;

create procedure dba.InsertNewOTRecord(
in In_EmployeeSysId integer,
in In_OTFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_OTType char(20),
in In_OTRate double,
in In_MaxFreq double,
in In_CurrentOTRate double,
in In_CurrentOTFreq double,
in In_CurrentOTAmount double,
in In_LastOTRate double,
in In_LastOTFreq double,
in In_LastOTAmount double,
in In_BackPayOTRate double,
in In_BackPayOTFreq double,
in In_BackPayOTAmount double,
in In_OTCreatedBy char(20),
in In_OTAmountF double,
in In_OTExRateId char(20),
in In_OTExRate double)
begin
  if not exists(select* from OTRecord where
      OTRecord.EmployeeSysId = In_EmployeeSysId and
      OTRecord.OTFormulaId = In_OTFormulaId and
      OTRecord.PayRecYear = In_PayRecYear and
      OTRecord.PayRecPeriod = In_PayRecPeriod and
      OTRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      OTRecord.PayRecID = In_PayRecID) then
    insert into OTRecord(OTFormulaSGSPGenId,
      EmployeeSysId,
      OTFormulaId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      OTType,
      OTRate,
      MaxFreq,
      CurrentOTRate,
      CurrentOTFreq,
      CurrentOTAmount,
      LastOTRate,
      LastOTFreq,
      LastOTAmount,
      BackPayOTRate,
      BackPayOTFreq,
      BackPayOTAmount,
      OTCreatedBy,
      OTAmountF,
      OTExRateId,
      OTExRate) values(
      FGetNewSGSPGeneratedIndex('OTRecord'),
      In_EmployeeSysId,
      In_OTFormulaId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_OTType,
      In_OTRate,
      In_MaxFreq,
      In_CurrentOTRate,
      In_CurrentOTFreq,
      In_CurrentOTAmount,
      In_LastOTRate,
      In_LastOTFreq,
      In_LastOTAmount,
      In_BackPayOTRate,
      In_BackPayOTFreq,
      In_BackPayOTAmount,
      In_OTCreatedBy,
      In_OTAmountF,
      In_OTExRateId,
      In_OTExRate);
    commit work
  end if
end
;

create procedure dba.InsertNewOverTime(
in In_OTTableId char(20),
in In_OTTableDesc char(100),
in In_MaxTotalWage double,
in In_MinTotalWage double,
in In_MaxOverTimeAmount numeric(14,4),
in In_MinOverTimeAmount numeric(14,4),
in In_MaxDayRate double,
in In_MinDayRate double,
in In_MaxHourRate double,
in In_MinHourRate double)
begin
  if not exists(select* from OverTime where
      OverTime.OTTableId = In_OTTableId) then
    insert into OverTime(OTTableId,
      OTTableDesc,MaxTotalWage,
      MinTotalWage,MaxOverTimeAmount,
      MinOverTimeAmount,
      MaxDayRate,MinDayRate,MaxHourRate,
      MinHourRate) values(
      In_OTTableId,
      In_OTTableDesc,In_MaxTotalWage,
      In_MinTotalWage,In_MaxOverTimeAmount,
      In_MinOverTimeAmount,
      In_MaxDayRate,In_MinDayRate,In_MaxHourRate,In_MinHourRate);
    commit work
  end if
end
;

create procedure dba.InsertNewPayAllocation(
in In_EmployeeSysId integer,
in In_PayAllocationSubPeriod integer,
in In_PayAllocationValue double,
in In_PayAllocationTypeId char(20))
begin
  if not exists(select* from PayAllocation where PayAllocation.EmployeeSysId = In_EmployeeSysId and
      PayAllocation.PayAllocationSubPeriod = In_PayAllocationSubPeriod) then
    insert into PayAllocation(EmployeeSysId,PayAllocationSubPeriod,PayAllocationValue,PayAllocationTypeId) values(
      In_EmployeeSysId,In_PayAllocationSubPeriod,In_PayAllocationValue,In_PayAllocationTypeId);
    commit work
  end if
end
;

create procedure dba.InsertNewPayEmployee(
in In_EmployeeSysId integer,
in In_ShiftTableId char(20),
in In_OTTableId char(20),
in In_PayGroupId char(20),
in In_PaySuspense integer,
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_BonusFactor double,
in In_LastPayDate date,
in In_PaySlipMessage char(100),
in In_PaySlipMessage2 char(100),
in In_EEHoursperDay double,
in In_BRPDayRateId char(20),
in In_BRPHourRateId char(20),
in In_OTDayRateId char(20),
in In_OTHourRateId char(20),
in In_GRPDayRateId char(20),
in In_GRPHourRateId char(20),
in In_PayAllocationBalance integer,
in In_LateInformation integer,
in In_AbsentInformation integer,
in In_SickLveEntitlement double,
in In_ANNLveBroughtForward double,
in In_ANNLveEntitlement double,
in In_BasicRateExchangeId char(20),
in In_EECPFPaidByER integer,
in In_DefaultHourRate double,
in In_CasualPayment integer)
begin
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeeSysId) then
    if not exists(select* from PayEmployee where PayEmployee.EmployeeSysId = In_EmployeeSysId) then
      insert into PayEmployee(EmployeeSysId,
        ShiftTableId,
        OTTableId,
        PayGroupId,
        PaySuspense,
        CurrentBasicRate,
        PreviousBasicRate,
        CurrentBasicRateType,
        PreviousBasicRateType,
        BonusFactor,
        LastPayDate,
        PaySlipMessage,
        PaySlipMessage2,
        EEHoursperDay,
        BRPDayRateId,
        BRPHourRateId,
        OTDayRateId,
        OTHourRateId,
        GRPDayRateId,
        GRPHourRateId,
        PayAllocationBalance,
        LateInformation,
        AbsentInformation,
        SickLveEntitlement,
        ANNLveBroughtForward,
        ANNLveEntitlement,
        BasicRateExchangeId,
        EECPFPaidByER,
        DefaultHourRate,
        CasualPayment) values(
        In_EmployeeSysId,
        In_ShiftTableId,
        In_OTTableId,
        In_PayGroupId,
        In_PaySuspense,
        In_CurrentBasicRate,
        In_PreviousBasicRate,
        In_CurrentBasicRateType,
        In_PreviousBasicRateType,
        In_BonusFactor,
        In_LastPayDate,
        In_PaySlipMessage,
        In_PaySlipMessage2,
        In_EEHoursperDay,
        In_BRPDayRateId,
        In_BRPHourRateId,
        In_OTDayRateId,
        In_OTHourRateId,
        In_GRPDayRateId,
        In_GRPHourRateId,
        In_PayAllocationBalance,
        In_LateInformation,
        In_AbsentInformation,
        In_SickLveEntitlement,
        In_ANNLveBroughtForward,
        In_ANNLveEntitlement,
        In_BasicRateExchangeId,
        In_EECPFPaidByER,
        In_DefaultHourRate,
        In_CasualPayment);
      commit work
    end if
  end if
end
;

create procedure dba.InsertNewPayEmployeePolicy(
in In_EmployeeSysId integer,
in In_CurrentNWC double,
in In_PreviousNWC double,
in In_CurrentMVC double,
in In_PreviousMVC double,
in In_MVCCapping double)
begin
  if not exists(select* from PayEmployeePolicy where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId) then
    insert into PayEmployeePolicy(EmployeeSysId,
      CurrentNWC,
      PreviousNWC,
      CurrentMVC,
      PreviousMVC,
      MVCCapping) values(
      In_EmployeeSysId,
      In_CurrentNWC,
      In_PreviousNWC,
      In_CurrentMVC,
      In_PreviousMVC,
      In_MVCCapping);
    commit work
  end if
end
;

create procedure dba.InsertNewPayGroup(
in In_PayGroupId char(20),
in In_NoSubPeriod integer,
in In_PeriodStartYear integer,
in In_PeriodStartPRPeriod integer,
in In_PeriodStartPRMonth integer,
in In_PayGroupDesc char(100),
in In_PayBalLastSubPeriod integer,
in In_PayBankAllocGpId char(20),
in In_PaymentExRateId char(20))
begin
  if not exists(select* from PayGroup where PayGroup.PayGroupId = In_PayGroupId) then
    insert into PayGroup(PayGroupId,
      NoSubPeriod,
      PeriodStartYear,
      PeriodStartPRPeriod,
      PeriodStartPRMonth,
      PayGroupDesc,
      PayBalLastSubPeriod,
      PayBankAllocGpId,
      PaymentExRateId) values(
      In_PayGroupId,
      In_NoSubPeriod,
      In_PeriodStartYear,
      In_PeriodStartPRPeriod,
      In_PeriodStartPRMonth,
      In_PayGroupDesc,
      In_PayBalLastSubPeriod,
      In_PayBankAllocGpId,
      In_PaymentExRateId);
    commit work
  end if
end
;

create procedure dba.InsertNewPayGroupPeriod(
in In_PayGroupId char(20),
in In_PayGroupYear integer,
in In_PayGroupPeriod integer,
in In_PayGroupSubPeriod integer,
in In_SubPeriodStatus char(20),
in In_SubPeriodStartDate date,
in In_SubPeriodEndDate date)
begin
  if not exists(select* from PayGroupPeriod where PayGroupPeriod.PayGroupId = In_PayGroupId and
      PayGroupPeriod.PayGroupYear = In_PayGroupYear and
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod and
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod) then
    insert into PayGroupPeriod(PayGroupPeriodGenId,PayGroupId,PayGroupYear,
      PayGroupPeriod,PayGroupSubPeriod,
      SubPeriodStatus,SubPeriodStartDate,
      SubPeriodEndDate) values(FGetNewSGSPGeneratedIndex('PayGroupPeriod'),
      In_PayGroupId,In_PayGroupYear,
      In_PayGroupPeriod,In_PayGroupSubPeriod,
      In_SubPeriodStatus,In_SubPeriodStartDate,
      In_SubPeriodEndDate);
    commit work
  end if
end
;

create procedure dba.InsertNewPayLeaveSetting(
in In_EmployeeSysId integer,
in In_PayLeaveTypeId char(20),
in In_LveAutoOption integer,
in In_LveDayRateId char(20),
in In_LveHourRateId char(20))
begin
  if not exists(select* from PayLeaveSetting where PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and
      PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId) then
    insert into PayLeaveSetting(EmployeeSysId,PayLeaveTypeId,LveAutoOption,LveDayRateId,LveHourRateId) values(
      In_EmployeeSysId,In_PayLeaveTypeId,In_LveAutoOption,In_LveDayRateId,In_LveHourRateId);
    commit work
  end if
end
;

create procedure dba.InsertNewPayPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PaySectionId char(20),
in In_PayCostCenterId char(20),
in In_PayCategoryId char(20),
in In_PayDepartmentId char(20),
in In_PayBranchId char(20),
in In_PayPositionId char(20),
in In_PayPayGroupId char(20),
in In_PayWorkCalendarId char(20),
in In_PayLeaveGroupId char(20),
in In_PaySalaryGradeId char(20),
in In_PayClassificationCode char(20),
in In_PayWTCalendarId char(20),
in In_PayEmpCode1Id char(20),
in In_PayEmpCode2Id char(20),
in In_PayEmpCode3Id char(20),
in In_PayEmpCode4Id char(20),
in In_PayEmpCode5Id char(20))
begin
  if not exists(select* from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod) then
    insert into PayPeriodRecord(EmployeeSysId,
      PayPeriodSGSPGenId,
      PayRecYear,
      PayRecPeriod,
      PaySectionId,
      PayCostCenterId,
      PayCategoryId,
      PayDepartmentId,
      PayBranchId,
      PayPositionId,
      PayPayGroupId,
      PayWorkCalendarId,
      PayLeaveGroupId,
      PaySalaryGradeId,
      PayClassification,
      PayWTCalendarId,
      PayEmpCode1Id,
      PayEmpCode2Id,
      PayEmpCode3Id,
      PayEmpCode4Id,
      PayEmpCode5Id) values(
      In_EmployeeSysId,
      FGetNewSGSPGeneratedIndex('PayPeriodRecord'),
      In_PayRecYear,
      In_PayRecPeriod,
      In_PaySectionId,
      In_PayCostCenterId,
      In_PayCategoryId,
      In_PayDepartmentId,
      In_PayBranchId,
      In_PayPositionId,
      In_PayPayGroupId,
      In_PayWorkCalendarId,
      In_PayLeaveGroupId,
      In_PaySalaryGradeId,
      In_PayClassificationCode,
      In_PayWTCalendarId,
      In_PayEmpCode1Id,
      In_PayEmpCode2Id,
      In_PayEmpCode3Id,
      In_PayEmpCode4Id,
      In_PayEmpCode5Id);
    commit work
  end if
end
;

create procedure dba.InsertNewPayRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_Status char(20),
in In_CreatedBy char(1),
in In_LastProcessed timestamp,
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(20))
begin
  if not exists(select* from PayRecord where
      PayRecord.EmployeeSysId = In_EmployeeSysId and
      PayRecord.PayRecYear = In_PayRecYear and
      PayRecord.PayRecPeriod = In_PayRecPeriod and
      PayRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecord.PayRecID = In_PayRecID) then
    insert into PayRecord(PayRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      PayRecType,
      Status,
      CreatedBy,
      LastProcessed,
      PayDesc,
      PayInterfaceProjectId) values(
      FGetNewSGSPGeneratedIndex('PayRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_PayRecType,
      In_Status,
      In_CreatedBy,
      In_LastProcessed,
      In_PayDesc,
      In_PayInterfaceProjectId);
    commit work
  end if
end
;

create procedure dba.InsertNewPeriodEEHistory(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PaySectionId char(20),
in In_PayCostCenterId char(20),
in In_PayCategoryId char(20),
in In_PayDepartmentId char(20),
in In_PayBranchId char(20),
in In_PayPositionId char(20),
in In_PayPayGroupId char(20),
in In_PayWorkCalendarId char(20))
begin
  if not exists(select* from PeriodEEHistory where
      PeriodEEHistory.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodEEHistory.EmployeeSysId = In_EmployeeSysId) then
    insert into PeriodEEHistory(EmployeeSysId,
      PayPeriodSGSPGenId,
      PayRecYear,
      PayRecPeriod,
      PaySectionId,
      PayCostCenterId,
      PayCategoryId,
      PayDepartmentId,
      PayBranchId,
      PayPositionId,
      PayPayGroupId,
      PayWorkCalendarId) values(
      In_EmployeeSysId,
      In_PayPeriodSGSPGenId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PaySectionId,
      In_PayCostCenterId,
      In_PayCategoryId,
      In_PayDepartmentId,
      In_PayBranchId,
      In_PayPositionId,
      In_PayPayGroupId,
      In_PayWorkCalendarId);
    commit work
  end if
end
;

create procedure dba.InsertNewPeriodMessage(
in In_PayGroupId char(20),
in In_PeriodId integer,
in In_PeriodIdType char(20),
in In_PeriodLongMessage char(20),
in In_PeriodShortMessage char(5),
in In_PeriodMonth char(20))
begin
  if not exists(select* from PeriodMessage where
      PeriodMessage.PayGroupId = In_PayGroupId and
      PeriodMessage.PeriodId = In_PeriodId and
      PeriodMessage.PeriodIdType = In_PeriodIdType) then
    insert into PeriodMessage(PayGroupId,
      PeriodId,
      PeriodIdType,
      PeriodLongMessage,
      PeriodShortMessage,
      PeriodMonth) values(In_PayGroupId,
      In_PeriodId,
      In_PeriodIdType,
      In_PeriodLongMessage,
      In_PeriodShortMessage,
      In_PeriodMonth);
    commit work
  end if
end
;

create procedure dba.InsertNewPeriodPolicySetting(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CPFAge integer,
in In_MAWLimit double,
in In_MAWOption integer,
in In_EECPFTable char(20),
in In_EECPFCurFormulaId char(20),
in In_EECPFPrevFormulaId char(20),
in In_ERCPFCurFormulaId char(20),
in In_ERCPFPrevFormulaId char(20),
in In_FWLFormulaId char(20),
in In_SDFFormulaId char(20),
in In_MediSaveAddFormulaId char(20),
in In_MediSaveOrdFormulaId char(20))
begin
  if not exists(select* from PeriodPolicySetting where
      PeriodPolicySetting.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySetting.EmployeeSysId = In_EmployeeSysId) then
    insert into PeriodPolicySetting(EmployeeSysId,
      PayPeriodSGSPGenId,
      PayRecYear,
      PayRecPeriod,
      CPFAge,
      MAWLimit,
      MAWOption,
      EECPFTable,
      EECPFCurFormulaId,
      EECPFPrevFormulaId,
      ERCPFCurFormulaId,
      ERCPFPrevFormulaId,
      FWLFormulaId,
      SDFFormulaId,
      MediSaveAddFormulaId,
      MediSaveOrdFormulaId) values(
      In_EmployeeSysId,
      In_PayPeriodSGSPGenId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_CPFAge,
      In_MAWLimit,
      In_MAWOption,
      In_EECPFTable,
      In_EECPFCurFormulaId,
      In_EECPFPrevFormulaId,
      In_ERCPFCurFormulaId,
      In_ERCPFPrevFormulaId,
      In_FWLFormulaId,
      In_SDFFormulaId,
      In_MediSaveAddFormulaId,
      In_MediSaveOrdFormulaId);
    commit work
  end if
end
;

create procedure dba.InsertNewPeriodPolicySummary(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CalFWL double,
in In_CalSDF double,
in In_ContriFWL double,
in In_ContriSDF double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_VolOrdEECPF double,
in In_VolOrdERCPF double,
in In_VolAddEECPF double,
in In_VolAddERCPF double,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_CPFWage double,
in In_SDFWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_TotalCDAC double,
in In_TotalSINDA double,
in In_TotalEUCF double,
in In_TotalMBMF double,
in In_TotalComm double,
in In_TotalMOSQ double,
in In_TotalYMF double,
in In_MediSaveOrdinary double,
in In_MediSaveAdditional double,
in In_CPFClass char(20),
in In_CPFStatus char(20),
in In_SupIR8ACurOrdWage double,
in In_SupIR8ACurAddWage double,
in In_SupIR8APrevOrdWage double,
in In_SupIR8APrevAddWage double,
in In_SupIR8ACPFWage double,
in In_SupIR8AOrdEECPF double,
in In_SupIR8AAddEECPF double,
in In_SupIR8AOrdERCPF double,
in In_SupIR8AAddERCPF double,
in In_SupIR8AActOrdEECPF double,
in In_SupIR8AActAddEECPF double,
in In_SupIR8AActOrdERCPF double,
in In_SupIR8AActAddERCPF double,
in In_SupIR8AEECPF double,
in In_SupIR8AERCPF double,
in In_CompanyAddEECPF double,
in In_CompanyAddERCPF double,
in In_MAWContriCurAddWage double,
in In_MAWContriPrevAddWage double,
in In_MAWContriLimit double,
in In_MAWContriPOrdWage double,
in In_MAWContriOption double,
in In_MAWBalCurAddWage double,
in In_MAWBalPrevAddWage double,
in In_MAWBalLimit double,
in In_MAWBalPOrdWage double,
in In_MAWBalOption integer,
in In_TaxCategory char(20),
in In_TaxMaritalStatus char(20),
in In_TaxChildRelief double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_TaxEPFRelief double,
in In_TaxZakatRelief double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double)
begin
  declare In_PayPeriodSGSPGenId char(30);
  if not exists(select* from PeriodPolicySummary where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId) then
    select PayPeriodSGSPGenId into In_PayPeriodSGSPGenId from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if(In_PayPeriodSGSPGenId is not null) then
      insert into PeriodPolicySummary(EmployeeSysId,
        PayPeriodSGSPGenId,
        PayRecYear,
        PayRecPeriod,
        CalFWL,
        CalSDF,
        ContriFWL,
        ContriSDF,
        CurOrdinaryWage,
        CurAdditionalWage,
        PrevOrdinaryWage,
        PrevAdditionalWage,
        ContriOrdEECPF,
        ContriAddEECPF,
        ContriOrdERCPF,
        ContriAddERCPF,
        ActualOrdEECPF,
        ActualOrdERCPF,
        ActualAddEECPF,
        ActualAddERCPF,
        VolOrdEECPF,
        VolOrdERCPF,
        VolAddEECPF,
        VolAddERCPF,
        TotalContriEECPF,
        TotalContriERCPF,
        CPFWage,
        SDFWage,
        OverseasEECPF,
        OverseasERCPF,
        TotalCDAC,
        TotalSINDA,
        TotalEUCF,
        TotalMBMF,
        TotalComm,
        TotalMOSQ,
        TotalYMF,
        MediSaveOrdinary,
        MediSaveAdditional,
        CPFClass,
        CPFStatus,
        SupIR8ACurOrdWage,
        SupIR8ACurAddWage,
        SupIR8APrevOrdWage,
        SupIR8APrevAddWage,
        SupIR8ACPFWage,
        SupIR8AOrdEECPF,
        SupIR8AAddEECPF,
        SupIR8AOrdERCPF,
        SupIR8AAddERCPF,
        SupIR8AActOrdEECPF,
        SupIR8AActAddEECPF,
        SupIR8AActOrdERCPF,
        SupIR8AActAddERCPF,
        SupIR8AEECPF,
        SupIR8AERCPF,
        CompanyAddEECPF,
        CompanyAddERCPF,
        MAWContriCurAddWage,
        MAWContriPrevAddWage,
        MAWContriLimit,
        MAWContriPOrdWage,
        MAWContriOption,
        MAWBalCurAddWage,
        MAWBalPrevAddWage,
        MAWBalLimit,
        MAWBalPOrdWage,
        MAWBalOption,
        TaxCategory,
        TaxMaritalStatus,
        TaxChildRelief,
        CurrentTaxWage,
        PreviousTaxWage,
        CurrentAddTaxWage,
        PreviousAddTaxWage,
        CurrentTaxAmount,
        PreviousTaxAmount,
        TaxEPFRelief,
        TaxZakatRelief,
        PaidCurrentTaxAmt,
        PaidPreviousTaxAmt,
        TaxBenefit) values(
        In_EmployeeSysId,
        In_PayPeriodSGSPGenId,
        In_PayRecYear,
        In_PayRecPeriod,
        In_CalFWL,
        In_CalSDF,
        In_ContriFWL,
        In_ContriSDF,
        In_CurOrdinaryWage,
        In_CurAdditionalWage,
        In_PrevOrdinaryWage,
        In_PrevAdditionalWage,
        In_ContriOrdEECPF,
        In_ContriAddEECPF,
        In_ContriOrdERCPF,
        In_ContriAddERCPF,
        In_ActualOrdEECPF,
        In_ActualOrdERCPF,
        In_ActualAddEECPF,
        In_ActualAddERCPF,
        In_VolOrdEECPF,
        In_VolOrdERCPF,
        In_VolAddEECPF,
        In_VolAddERCPF,
        In_TotalContriEECPF,
        In_TotalContriERCPF,
        In_CPFWage,
        In_SDFWage,
        In_OverseasEECPF,
        In_OverseasERCPF,
        In_TotalCDAC,
        In_TotalSINDA,
        In_TotalEUCF,
        In_TotalMBMF,
        In_TotalComm,
        In_TotalMOSQ,
        In_TotalYMF,
        In_MediSaveOrdinary,
        In_MediSaveAdditional,
        In_CPFClass,
        In_CPFStatus,
        In_SupIR8ACurOrdWage,
        In_SupIR8ACurAddWage,
        In_SupIR8APrevOrdWage,
        In_SupIR8APrevAddWage,
        In_SupIR8ACPFWage,
        In_SupIR8AOrdEECPF,
        In_SupIR8AAddEECPF,
        In_SupIR8AOrdERCPF,
        In_SupIR8AAddERCPF,
        In_SupIR8AActOrdEECPF,
        In_SupIR8AActAddEECPF,
        In_SupIR8AActOrdERCPF,
        In_SupIR8AActAddERCPF,
        In_SupIR8AEECPF,
        In_SupIR8AERCPF,
        In_CompanyAddEECPF,
        In_CompanyAddERCPF,
        In_MAWContriCurAddWage,
        In_MAWContriPrevAddWage,
        In_MAWContriLimit,
        In_MAWContriPOrdWage,
        In_MAWContriOption,
        In_MAWBalCurAddWage,
        In_MAWBalPrevAddWage,
        In_MAWBalLimit,
        In_MAWBalPOrdWage,
        In_MAWBalOption,
        In_TaxCategory,
        In_TaxMaritalStatus,
        In_TaxChildRelief,
        In_CurrentTaxWage,
        In_PreviousTaxWage,
        In_CurrentAddTaxWage,
        In_PreviousAddTaxWage,
        In_CurrentTaxAmount,
        In_PreviousTaxAmount,
        In_TaxEPFRelief,
        In_TaxZakatRelief,
        In_PaidCurrentTaxAmt,
        In_PaidPreviousTaxAmt,
        In_TaxBenefit);
      commit work
    end if
  end if
end
;

create procedure DBA.InsertNewPolicyProgression(
in In_EmployeeSysId integer,
in In_BRProgDate date,
in In_NWCPrevRate double,
in In_NWCIncrementAmt double,
in In_NWCPercentage double,
in In_NWCNewRate double,
in In_MVCPrevRate double,
in In_MVCIncrementAmt double,
in In_MVCPercentage double,
in In_MVCNewRate double)
begin
  if not exists(select* from PolicyProgression where PolicyProgression.EmployeeSysId = In_EmployeeSysId and PolicyProgression.BRProgDate = In_BRProgDate) then
    insert into PolicyProgression(EmployeeSysId,
      BRProgDate,NWCPrevRate,NWCIncrementAmt,NWCPercentage,NWCNewRate,MVCPrevRate,
      MVCIncrementAmt,MVCPercentage,MVCNewRate) values(
      In_EmployeeSysId,In_BRProgDate,In_NWCPrevRate,In_NWCIncrementAmt,
      In_NWCPercentage,In_NWCNewRate,In_MVCPrevRate,In_MVCIncrementAmt,
      In_MVCPercentage,In_MVCNewRate);
    commit work
  end if
end
;

create procedure dba.InsertNewPolicyRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentMVC double,
in In_CurrentNWC double,
in In_PreviousMVC double,
in In_PreviousNWC double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_CPFWage double,
in In_CPFPaymentOption smallint,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_AllocatedNWC double,
in In_AllocatedMVC double,
in In_CurNWCHrDaysRate double,
in In_CurMVCHrDaysRate double,
in In_PrevNWCHrDaysRate double,
in In_PrevMVCHrDaysRate double,
in In_CurBackPayNWC double,
in In_PrevBackPayNWC double,
in In_CurBackPayMVC double,
in In_PrevBackPayMVC double,
in In_MVCCapping double,
in In_CurrEEManContri double,
in In_CurrERManContri double,
in In_PrevEEManContri double,
in In_PrevERManContri double,
in In_CurrEEVolContri double,
in In_CurrERVolContri double,
in In_PrevEEVolContri double,
in In_PrevERVolContri double,
in In_CurrEEManWage double,
in In_CurrERManWage double,
in In_PrevEEManWage double,
in In_PrevERManWage double,
in In_CurrEEVolWage double,
in In_CurrERVolWage double,
in In_PrevEEVolWage double,
in In_PrevERVolWage double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double,
in In_CurrentNWCF double,
in In_CurrentMVCF double,
in In_PreviousNWCF double,
in In_PreviousMVCF double,
in In_AllocatedNWCF double,
in In_AllocatedMVCF double,
in In_CurBackPayNWCF double,
in In_PrevBackPayNWCF double,
in In_CurBackPayMVCF double,
in In_PrevBackPayMVCF double)
begin
  if not exists(select* from PolicyRecord where
      PolicyRecord.EmployeeSysId = In_EmployeeSysId and
      PolicyRecord.PayRecYear = In_PayRecYear and
      PolicyRecord.PayRecPeriod = In_PayRecPeriod and
      PolicyRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      PolicyRecord.PayRecID = In_PayRecID) then
    insert into PolicyRecord(PolicyRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      CurrentMVC,
      CurrentNWC,
      PreviousMVC,
      PreviousNWC,
      CurOrdinaryWage,
      CurAdditionalWage,
      PrevOrdinaryWage,
      PrevAdditionalWage,
      ContriOrdEECPF,
      ContriAddEECPF,
      ContriOrdERCPF,
      ContriAddERCPF,
      CPFWage,
      CPFPaymentOption,
      TotalContriEECPF,
      TotalContriERCPF,
      AllocatedNWC,
      AllocatedMVC,
      CurNWCHrDaysRate,
      CurMVCHrDaysRate,
      PrevNWCHrDaysRate,
      PrevMVCHrDaysRate,
      CurBackPayNWC,
      PrevBackPayNWC,
      CurBackPayMVC,
      PrevBackPayMVC,
      MVCCapping,
      CurrEEManContri,
      CurrERManContri,
      PrevEEManContri,
      PrevERManContri,
      CurrEEVolContri,
      CurrERVolContri,
      PrevEEVolContri,
      PrevERVolContri,
      CurrEEManWage,
      CurrERManWage,
      PrevEEManWage,
      PrevERManWage,
      CurrEEVolWage,
      CurrERVolWage,
      PrevEEVolWage,
      PrevERVolWage,
      CurrentTaxWage,
      PreviousTaxWage,
      CurrentAddTaxWage,
      PreviousAddTaxWage,
      CurrentTaxAmount,
      PreviousTaxAmount,
      PaidCurrentTaxAmt,
      PaidPreviousTaxAmt,
      TaxBenefit,
      CurrentNWCF,
      CurrentMVCF,
      PreviousNWCF,
      PreviousMVCF,
      AllocatedNWCF,
      AllocatedMVCF,
      CurBackPayNWCF,
      PrevBackPayNWCF,
      CurBackPayMVCF,
      PrevBackPayMVCF) values(
      FGetNewSGSPGeneratedIndex('PolicyRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_CurrentMVC,
      In_CurrentNWC,
      In_PreviousMVC,
      In_PreviousNWC,
      In_CurOrdinaryWage,
      In_CurAdditionalWage,
      In_PrevOrdinaryWage,
      In_PrevAdditionalWage,
      In_ContriOrdEECPF,
      In_ContriAddEECPF,
      In_ContriOrdERCPF,
      In_ContriAddERCPF,
      In_CPFWage,
      In_CPFPaymentOption,
      In_TotalContriEECPF,
      In_TotalContriERCPF,
      In_AllocatedNWC,
      In_AllocatedMVC,
      In_CurNWCHrDaysRate,
      In_CurMVCHrDaysRate,
      In_PrevNWCHrDaysRate,
      In_PrevMVCHrDaysRate,
      In_CurBackPayNWC,
      In_PrevBackPayNWC,
      In_CurBackPayMVC,
      In_PrevBackPayMVC,
      In_MVCCapping,
      In_CurrEEManContri,
      In_CurrERManContri,
      In_PrevEEManContri,
      In_PrevERManContri,
      In_CurrEEVolContri,
      In_CurrERVolContri,
      In_PrevEEVolContri,
      In_PrevERVolContri,
      In_CurrEEManWage,
      In_CurrERManWage,
      In_PrevEEManWage,
      In_PrevERManWage,
      In_CurrEEVolWage,
      In_CurrERVolWage,
      In_PrevEEVolWage,
      In_PrevERVolWage,
      In_CurrentTaxWage,
      In_PreviousTaxWage,
      In_CurrentAddTaxWage,
      In_PreviousAddTaxWage,
      In_CurrentTaxAmount,
      In_PreviousTaxAmount,
      In_PaidCurrentTaxAmt,
      In_PaidPreviousTaxAmt,
      In_TaxBenefit,
      In_CurrentNWCF,
      In_CurrentMVCF,
      In_PreviousNWCF,
      In_PreviousMVCF,
      In_AllocatedNWCF,
      In_AllocatedMVCF,
      In_CurBackPayNWCF,
      In_PrevBackPayNWCF,
      In_CurBackPayMVCF,
      In_PrevBackPayMVCF);
    commit work
  end if
end
;

create procedure DBA.InsertNewRegistry(
in In_RegistryId char(20),
in In_RegistryDesc char(100))
begin
  if not exists(select* from Registry where Registry.RegistryId = In_RegistryId) then
    insert into Registry(RegistryId,RegistryDesc) values(
      In_RegistryId,In_RegistryDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewSDFProgression(
in In_SDFEffectiveDate date,
in In_SDFFormulaID char(20),
in In_SDFRemarks char(255),
in In_SDFCurrent smallint)
begin
  if not exists(select* from SDFProgression where
      SDFProgression.SDFEffectiveDate = In_SDFEffectiveDate) then
    insert into SDFProgression(SDFEffectiveDate,
      SDFFormulaId,SDFRemarks,SDFCurrent) values(
      In_SDFEffectiveDate,In_SDFFormulaID,In_SDFRemarks,In_SDFCurrent);
    commit work
  end if
end
;

create procedure dba.InsertNewShift(
in In_ShiftTableId char(20),
in In_ShiftTableDesc char(100),
in In_ShiftAveragePeriod integer)
begin
  if not exists(select* from Shift where Shift.ShiftTableId = In_ShiftTableId) then
    insert into Shift(ShiftTableId,ShiftTableDesc,ShiftAveragePeriod) values(
      In_ShiftTableId,In_ShiftTableDesc,In_ShiftAveragePeriod);
    commit work
  end if
end
;

create procedure dba.InsertNewShiftMember(
in In_ShiftTableId char(20),
in In_FormulaId char(20))
begin
  if not exists(select* from ShiftMember where
      ShiftMember.ShiftTableId = In_ShiftTableId and
      ShiftMember.FormulaId = In_FormulaId) then
    insert into ShiftMember(ShiftTableId,
      FormulaId) values(In_ShiftTableId,
      In_FormulaId);
    commit work
  end if
end
;

create procedure dba.InsertNewShiftRecord(
in In_EmployeeSysId integer,
in In_ShiftFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_ShiftRate double,
in In_ShiftFrequency double,
in In_ShiftAmount double,
in In_ShiftCreatedBy char(20),
in In_ShiftAmountF double,
in In_ShiftExRateId char(20),
in In_ShiftExRate double)
begin
  if not exists(select* from ShiftRecord where
      ShiftRecord.EmployeeSysId = In_EmployeeSysId and
      ShiftRecord.PayRecYear = In_PayRecYear and
      ShiftRecord.PayRecPeriod = In_PayRecPeriod and
      ShiftRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      ShiftRecord.PayRecID = In_PayRecID and
      ShiftRecord.ShiftFormulaId = In_ShiftFormulaId) then
    insert into ShiftRecord(ShiftFormulaSGSPGenId,
      EmployeeSysId,
      ShiftFormulaId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      ShiftRate,
      ShiftFrequency,
      ShiftAmount,
      ShiftCreatedBy,
      ShiftAmountF,
      ShiftExRateId,
      ShiftExRate) values(
      FGetNewSGSPGeneratedIndex('ShiftRecord'),
      In_EmployeeSysId,
      In_ShiftFormulaId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_ShiftRate,
      In_ShiftFrequency,
      In_ShiftAmount,
      In_ShiftCreatedBy,
      In_ShiftAmountF,
      In_ShiftExRateId,
      In_ShiftExRate);
    commit work
  end if
end
;

create procedure dba.InsertNewSubPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_SubPeriodStatus char(20),
in In_SubPeriodStartDate date,
in In_SubPeriodEndDate date,
in In_PaySuspense smallint)
begin
  if not exists(select* from SubPeriodRecord where
      SubPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      SubPeriodRecord.PayRecYear = In_PayRecYear and
      SubPeriodRecord.PayRecPeriod = In_PayRecPeriod and
      SubPeriodRecord.PayRecSubPeriod = In_PayRecSubPeriod) then
    insert into SubPeriodRecord(EmployeeSysId,
      PaySubPeriodSGSPGenId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      SubPeriodStatus,
      SubPeriodStartDate,
      SubPeriodEndDate,
      PaySuspense) values(
      In_EmployeeSysId,
      FGetNewSGSPGeneratedIndex('SubPeriodRecord'),
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_SubPeriodStatus,
      In_SubPeriodStartDate,
      In_SubPeriodEndDate,
      In_PaySuspense);
    commit work
  end if
end
;

create procedure dba.InsertNewSubPeriodSetting(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_OTDayRateId char(20),
in In_OTHourRateId char(20),
in In_CurrentOTDayRateAmt double,
in In_CurrentOTHourRateAmt double,
in In_LastOTDayRateAmt double,
in In_LastOTHourRateAmt double,
in In_EEOTTableId char(20),
in In_EEShiftTableId char(20),
in In_LateInformation smallint,
in In_AbsentInformation smallint,
in In_BRPDayRateId char(20),
in In_BRPHourRateId char(20),
in In_BRPDayRateAmt double,
in In_BRPHourRateAmt double,
in In_GRPDayRateId char(20),
in In_GRPHourRateId char(20),
in In_GRPDayRateAmt double,
in In_GRPHourRateAmt double)
begin
  declare In_PaySubPeriodSGSPGenId char(30);
  if not exists(select* from SubPeriodSetting where
      SubPeriodSetting.EmployeeSysId = In_EmployeeSysId and
      SubPeriodSetting.PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId) then
    select PaySubPeriodSGSPGenId into In_PaySubPeriodSGSPGenId from SubPeriodREcord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if(In_PaySubPeriodSGSPGenId is not null) then
      insert into SubPeriodSetting(EmployeeSysId,
        PaySubPeriodSGSPGenId,
        PayRecYear,
        PayRecPeriod,
        PayRecSubPeriod,
        OTDayRateId,
        OTHourRateId,
        CurrentOTDayRateAmt,
        CurrentOTHourRateAmt,
        LastOTDayRateAmt,
        LastOTHourRateAmt,
        EEOTTableId,
        EEShiftTableId,
        LateInformation,
        AbsentInformation,
        BRPDayRateId,
        BRPHourRateId,
        BRPDayRateAmt,
        BRPHourRateAmt,
        GRPDayRateId,
        GRPHourRateId,
        GRPDayRateAmt,
        GRPHourRateAmt) values(
        In_EmployeeSysId,
        In_PaySubPeriodSGSPGenId,
        In_PayRecYear,
        In_PayRecPeriod,
        In_PayRecSubPeriod,
        In_OTDayRateId,
        In_OTHourRateId,
        In_CurrentOTDayRateAmt,
        In_CurrentOTHourRateAmt,
        In_LastOTDayRateAmt,
        In_LastOTHourRateAmt,
        In_EEOTTableId,
        In_EEShiftTableId,
        In_LateInformation,
        In_AbsentInformation,
        In_BRPDayRateId,
        In_BRPHourRateId,
        In_BRPDayRateAmt,
        In_BRPHourRateAmt,
        In_GRPDayRateId,
        In_GRPHourRateId,
        In_GRPDayRateAmt,
        In_GRPHourRateAmt);
      commit work
    end if
  end if
end
;

create procedure dba.InsertNewSubPeriodTemplate(
in In_PayGroupId char(20),
in In_SubPeriod integer,
in In_StartDay char(20),
in In_StartMonth char(20),
in In_EndDay char(20),
in In_EndMonth char(20))
begin
  if not exists(select* from SubPeriodTemplate where SubPeriodTemplate.PayGroupId = In_PayGroupId and
      SubPeriodTemplate.SubPeriod = In_SubPeriod) then
    insert into SubPeriodTemplate(PayGroupId,SubPeriod,
      StartDay,StartMonth,
      EndDay,EndMonth) values(
      In_PayGroupId,In_SubPeriod,
      In_StartDay,In_StartMonth,
      In_EndDay,In_EndMonth);
    commit work
  end if
end
;

create procedure DBA.InsertNewSubRegistry(
in In_RegistryId char(20),
in In_SubRegistryId char(20),
in In_RegProperty1 char(100),
in In_RegProperty2 char(100),
in In_RegProperty3 char(100),
in In_RegProperty4 char(100),
in In_RegProperty5 char(100),
in In_RegProperty6 char(200),
in In_RegProperty7 char(200),
in In_RegProperty8 char(200),
in In_RegProperty9 char(200),
in In_RegProperty10 char(200),
in In_DoubleAttr double,
in In_IntegerAttr integer,
in In_CharAttr char(1),
in In_BooleanAttr smallint,
in In_ShortStringAttr char(20),
in In_StringAttr char(255),
in In_DateAttr date,
in In_DateTimeAttr timestamp)
begin
  if not exists(select* from SubRegistry where SubRegistry.RegistryId = In_RegistryId and
      SubRegistry.SubRegistryId = In_SubRegistryId) then
    insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,
      RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
      DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr) values(
      In_RegistryId,In_SubRegistryId,In_RegProperty1,In_RegProperty2,In_RegProperty3,
      In_RegProperty4,In_RegProperty5,In_RegProperty6,In_RegProperty7,In_RegProperty8,In_RegProperty9,In_RegProperty10,
      In_DoubleAttr,In_IntegerAttr,In_CharAttr,In_BooleanAttr,In_ShortStringAttr,In_StringAttr,In_DateAttr,In_DateTimeAttr);
    commit work
  end if
end
;

create procedure dba.InsertNewWageProperty(
in In_KeyWordId char(20),
in In_WageId char(20),
in In_WagePropertyUsed integer)
begin
  if not exists(select* from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId and
      WageProperty.WageId = In_WageId) then
    insert into WageProperty(KeyWordId,
      WageId,WagePropertyUsed) values(
      In_KeyWordId,
      In_WageId,In_WagePropertyUsed);
    commit work
  end if
end
;

create function dba.IsAllowanceRecordKeyWordsHas(
in In_AllowanceSGSPGenId char(20),
in In_Keyword char(20))
returns smallint
begin
  if exists(select* from AllowanceRecord join AllowanceHistoryRecord where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId and
      (keywords1 = In_Keyword or
      keywords2 = In_Keyword or
      keywords3 = In_Keyword or
      keywords4 = In_Keyword or
      keywords5 = In_Keyword or
      keywords6 = In_Keyword or
      keywords7 = In_Keyword or
      keywords8 = In_Keyword or
      keywords9 = In_Keyword or
      keywords10 = In_Keyword)) then
    return 1
  else return 0
  end if
end
;

create function dba.IsFormulaId(
in in_FormulaId char(20),
in in_FormulaSubCategory char(20))
returns smallint
begin
  /* Based on Formulasubcategory gives u the formulaid */
  if exists(select* from formula where
      FormulaId = in_FormulaId and
      FormulaSubCategory = in_FormulaSubCategory) then return 1
  end if;
  return 0
end
;

create function DBA.IsFormulaIdCanDelete(
in in_FormulaId char(20))
returns smallint
begin
  if exists(select* from SDFProgression where SDFProgression.SDFFormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from FWLProgression where FWLProgression.FWLFormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from CPFTableComponent where CPFTableComponent.EEOrdCPFFormula = in_FormulaId) then return 0
  end if;
  if exists(select* from CPFTableComponent where CPFTableComponent.EROrdCPFFormula = in_FormulaId) then return 0
  end if;
  if exists(select* from CPFTableComponent where CPFTableComponent.EEAddCPFFormula = in_FormulaId) then return 0
  end if;
  if exists(select* from CPFTableComponent where CPFTableComponent.ERAddCPFFormula = in_FormulaId) then return 0
  end if;
  if exists(select* from EmployeeRecurAllowance where EmployeeRecurAllowance.FormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from NSItemRecord where NSItemRecord.NSFormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from NSPayCase where NSPayCase.NSPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from EnCashmentProcess where EnCashmentProcess.EnCashPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from AllowanceRecord where AllowanceRecord.AllowanceFormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from MapRPayElement_mm where MapRPayElement_mm.FormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from Training where Training.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from TrainingBatch where TrainingBatch.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from AwardDisc where AwardDisc.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from Memship where Memship.PayrollPayElement = in_FormulaId) then return 0
  end if;
  if exists(select* from MClaimType where MClaimType.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from Insurance where Insurance.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from InsurProgDetails where InsurProgDetails.PayrollPayElementId = in_FormulaId) then return 0
  end if;
  if exists(select* from BalancePayElement where FormulaId = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F1 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F2 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F3 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F4 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F5 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F6 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F7 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F8 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F9 = in_FormulaId) then return 0
  end if;
  if exists(select* from FormulaRange where F10 = in_FormulaId) then return 0
  end if;
  return 1
end
;

create function dba.IsFormulaIdHasCategory(
in in_FormulaId char(20),
in in_FormulaCategory char(20))
returns smallint
begin
  /* Based on FormulaCategory gives u the formulaid */
  if exists(select* from formula where
      FormulaId = in_FormulaId and
      FormulaCategory = in_FormulaCategory) then return 1
  end if;
  return 0
end
;

create function dba.IsFormulaIdHasProperty(
in in_FormulaId char(20),
in in_Property char(20))
returns smallint
begin
  if(in_Property = '') then return 1
  end if;
  if exists(select* from FormulaProperty where
      FormulaId = in_FormulaId and
      Keywordid = in_Property) then return 1
  end if;
  return 0
end
;

create function dba.IsFormulaIdHasSelectedProperty(
in in_FormulaId char(20),
in in_Property char(20),
in in_All smallint)
returns smallint
begin
  if(in_All = 1) then
    if exists(select* from FormulaProperty join Keyword where
        FormulaId = in_FormulaId and
        Keyword.Keywordid = in_Property and
        keywordpropertyselection = 1) then return 1
    end if
  else
    if exists(select* from FormulaProperty join Keyword where
        FormulaId = in_FormulaId and
        keywordpropertyselection = 1) then return 1
    end if
  end if;
  return 0
end
;

create function DBA.IsHideWageRequire(
in In_UserGroupId char(20),
in In_ModuleScreenId char(20))
returns smallint
begin
  declare In_UserGroupHideWage smallint;
  declare In_HideOnlyWage smallint;
  select UserGroupHideWage into In_UserGroupHideWage from UserGroup where UserGroupId = In_UserGroupId;
  if In_UserGroupHideWage = 1 then
    select HideOnlyWage into In_HideOnlyWage from ModuleScreenGroup where ModuleScreenId = In_ModuleScreenId;
    if In_HideOnlyWage = 1 then return 1
    else return 0
    end if
  end if;
  return 0
end
;

create function DBA.IsHistoryRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
returns smallint
begin
  declare Out_CurrentYear integer;
  declare Out_CurrentPeriod integer;
  declare Out_CurrentSubPeriod integer;
  select max(PayRecYear) into Out_CurrentYear from PayRecord where EmployeeSysId = In_EmployeeSysId;
  if(Out_CurrentYear is null) then return 0
  end if;
  if(In_PayRecYear < Out_CurrentYear) then return 1
  end if;
  select max(PayRecPeriod) into Out_CurrentPeriod from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = Out_CurrentYear;
  select max(PayRecSubPeriod) into Out_CurrentSubPeriod from PayRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = Out_CurrentYear and
    PayRecPeriod = Out_CurrentPeriod;
  if(Out_CurrentPeriod is null or Out_CurrentSubPeriod is null) then return 0
  end if;
  if(Out_CurrentYear = In_PayRecYear and
    Out_CurrentPeriod = In_PayRecPeriod and
    Out_CurrentSubPeriod = In_PayRecSubPeriod) then return 0
  end if;
  if(Out_CurrentYear = In_PayRecYear and
    In_PayRecPeriod < Out_CurrentPeriod) then return 1
  end if;
  if(Out_CurrentYear = In_PayRecYear and
    Out_CurrentPeriod = In_PayRecPeriod and
    In_PayRecSubPeriod < Out_CurrentSubPeriod) then return 1
  end if;
  return 0
end
;

create function DBA.IsLastSubPeriod(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer)
returns smallint
begin
  declare Out_PayGroupId char(20);
  declare Out_SubPeriodStartDate date;
  declare Out_SubPeriodEndDate date;
  declare Out_NoSubPeriod integer;
  declare Out_LastPayDate date;
  select FGetPayRecPayGroup(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod) into Out_PayGroupId;
  select SubPeriodStartDate,SubPeriodEndDate into Out_SubPeriodStartDate,
    Out_SubPeriodEndDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PayRecYear and
    PayGroupPeriod = In_PayRecPeriod and
    PayGroupSubPeriod = In_PayRecSubPeriod;
  select NoSubPeriod into Out_NoSubPeriod from PayGroup where PayGroupId = Out_PayGroupId;
  select LastPayDate into Out_LastPayDate from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  if(Out_LastPayDate >= Out_SubPeriodStartDate and Out_LastPayDate <= Out_SubPeriodEndDate) then
    return 1
  end if;
  if(In_PayRecSubPeriod = Out_NoSubPeriod) then
    return 1
  end if;
  return 0
end
;

create function DBA.IsModuleAccessible(
in In_UserGroupId char(20),
in In_ModuleScreenId char(20))
returns smallint
begin
  if not exists(select* from UserModuleNoAccess where
      ModuleScreenId = In_ModuleScreenId and
      UserGroupId = In_UserGroupId) then
    return 1
  end if;
  return 0
end
;

create function DBA.IsMVCCappingOver(
in In_EmployeeSysId integer,
in In_CurrentBRProgDate date)
returns smallint
begin
  declare In_AccMVCPercent double;
  declare In_TotalCapping double;
  select FGetAccumulatedMVCPercent(In_EmployeeSysId,In_CurrentBRProgDate) into In_AccMVCPercent;
  select DoubleAttr into In_TotalCapping from SubRegistry where SubRegistryId = 'MVCCapping';
  if(In_AccMVCPercent < In_TotalCapping) then return 1
  else return 0
  end if end
;

create function dba.IsNoEmployment(
in in_PersonalSysId integer)
returns integer
begin
  declare out_Employment integer;
  select Count(*) into out_Employment from Employee where
    PersonalSysId = in_PersonalSysId;
  if(out_Employment >= 1) then return 0
  else return 1
  end if
end
;

create function dba.IsNonLoopingAllowance(
in in_AllowanceSGSPGenId char(20))
returns smallint
begin
  declare In_AllowanceFormulaId char(20);
  declare returnvalue smallint;
  select AllowanceFormulaId into In_AllowanceFormulaId from AllowanceRecord where
    AllowanceSGSPGenId = in_AllowanceSGSPGenId;
  select IsNonLoopingPayElement(In_AllowanceFormulaId) into returnvalue;
  return returnvalue
end
;

create function dba.IsNonLoopingPayElement(
in in_Formulaid char(20))
returns smallint
begin
  declare In_FormulaRangeBasis char(20);
  if IsPayElementKeyWordsHas(in_FormulaId,'CPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'SDFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'AddWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'OrdWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'CPFContriWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'TAP1Wage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'TAP2Wage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'TAP3Wage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'JamsostekWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'CurrEEManEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'CurrERManEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'CurrEEVolEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'CurrERVolEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PrevEEManEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PrevERManEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PrevEEVolEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PrevERVolEPFWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'SOCSOWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'ManOrdWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'ManAddWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'VolOrdWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'VolAddWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PFNormalWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'PFSpecialWage') = 1 then return 0
  end if;
  if IsPayElementKeyWordsHas(in_FormulaId,'SSWage') = 1 then return 0
  end if;
  select FormulaRangeBasis into In_FormulaRangeBasis from Formula where
    Formulaid = in_Formulaid;
  if In_FormulaRangeBasis = 'CPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'SDFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'AddWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'OrdWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'CPFContriWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'TAP1Wage' then return 0
  end if;
  if In_FormulaRangeBasis = 'TAP2Wage' then return 0
  end if;
  if In_FormulaRangeBasis = 'TAP3Wage' then return 0
  end if;
  if In_FormulaRangeBasis = 'JamsosteckWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'CurrEEManEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'CurrERManEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'CurrEEVolEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'CurrERVolEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PrevEEManEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PrevERManEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PrevEEVolEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PrevERVolEPFWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'SOCSOWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'ManOrdWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'ManAddWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'VolOrdWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'VolAddWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PFNormalWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'PFSpecialWage' then return 0
  end if;
  if In_FormulaRangeBasis = 'SSWage' then return 0
  end if;
  return 1
end
;

create function DBA.IsPayElementCanCalculate(
in In_Id char(20),
in in_NewRecord smallint)
returns smallint
begin
  if(in_NewRecord = 0) then
    if exists(select* from AllowanceRecord join AllowanceHistoryRecord where
        AllowanceRecord.AllowanceSGSPGenId = In_Id and
        (keywords1 is null or keywords1 = '') and
        (keywords2 is null or keywords2 = '') and
        (keywords3 is null or keywords3 = '') and
        (keywords4 is null or keywords4 = '') and
        (keywords5 is null or keywords5 = '') and
        (keywords6 is null or keywords6 = '') and
        (keywords7 is null or keywords7 = '') and
        (keywords8 is null or keywords8 = '') and
        (keywords9 is null or keywords9 = '') and
        (keywords10 is null or keywords10 = '')) then return 1
    end if
  else
    if exists(select* from Formula join FormulaRange where
        Formula.FormulaId = In_Id and
        (keywords1 is null or keywords1 = '') and
        (keywords2 is null or keywords2 = '') and
        (keywords3 is null or keywords3 = '') and
        (keywords4 is null or keywords4 = '') and
        (keywords5 is null or keywords5 = '') and
        (keywords6 is null or keywords6 = '') and
        (keywords7 is null or keywords7 = '') and
        (keywords8 is null or keywords8 = '') and
        (keywords9 is null or keywords9 = '') and
        (keywords10 is null or keywords10 = '')) then return 1
    end if
  end if;
  return 0
end
;

create function dba.IsPayElementKeyWordsHas(
in In_FormulaId char(20),
in In_Keyword char(20))
returns smallint
begin
  if exists(select* from formula join formularange where
      FormulaCategory = 'PayElement' and
      Formula.FormulaId = In_FormulaId and
      (keywords1 = In_Keyword or
      keywords2 = In_Keyword or
      keywords3 = In_Keyword or
      keywords4 = In_Keyword or
      keywords5 = In_Keyword or
      keywords6 = In_Keyword or
      keywords7 = In_Keyword or
      keywords8 = In_Keyword or
      keywords9 = In_Keyword or
      keywords10 = In_Keyword)) then
    return 1
  else return 0
  end if
end
;

create function dba.IsPayRecordExist(
in In_EmployeesysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayrecSubPeriod integer,
in In_PayRecID char(20))
returns smallint
begin
  if exists(select* from PayRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID) then
    return 1
  end if;
  return 0
end
;

create function dba.IsPayRecordWithin(
in SpecYear integer,
in SpecPeriod integer,
in SpecSubPeriod integer,
in FromYear integer,
in FromPeriod integer,
in FromSubPeriod integer,
in ToYear integer,
in ToPeriod integer,
in ToSubPeriod integer)
returns smallint
begin
  if(SpecYear >= FromYear and SpecYear <= ToYear) then
    if(SpecYear = FromYear and SpecPeriod < FromPeriod) then return 0
    end if;
    if(SpecYear = ToYear and SpecPeriod > ToPeriod) then return 0
    end if;
    if(SpecYear = FromYear and SpecPeriod = FromPeriod and SpecSubPeriod < FromSubPeriod) then return 0
    end if;
    if(SpecYear = ToYear and SpecPeriod = ToPeriod and SpecSubPeriod > ToSubPeriod) then return 0
    end if;
    return 1
  end if;
  return 0
end
;

create function dba.IsPeriodGreaterThan(
in SpecYear integer,
in SpecPeriod integer,
in FromYear integer,
in FromPeriod integer)
returns smallint
begin
  if(SpecYear >= FromYear) then
    if(SpecYear = FromYear and SpecPeriod < FromPeriod) then return 0
    end if;
    return 1
  end if;
  return 0
end
;

create function dba.IsPeriodLessThan(
in SpecYear integer,
in SpecPeriod integer,
in ToYear integer,
in ToPeriod integer)
returns smallint
begin
  if(SpecYear <= ToYear) then
    if(SpecYear = ToYear and SpecPeriod > ToPeriod) then return 0
    end if;
    return 1
  end if;
  return 0
end
;

create function dba.IsPeriodWithin(
in SpecYear integer,
in SpecPeriod integer,
in FromYear integer,
in FromPeriod integer,
in ToYear integer,
in ToPeriod integer)
returns smallint
begin
  if(SpecYear >= FromYear and SpecYear <= ToYear) then
    if(SpecYear = FromYear and SpecPeriod < FromPeriod) then return 0
    end if;
    if(SpecYear = ToYear and SpecPeriod > ToPeriod) then return 0
    end if;
    return 1
  end if;
  return 0
end
;

create function dba.IsSubPeriodWithin(
in SpecYear integer,
in SpecPeriod integer,
in SpecSubPeriod integer,
in FromYear integer,
in FromPeriod integer,
in FromSubPeriod integer,
in ToYear integer,
in ToPeriod integer,
in ToSubPeriod integer)
returns smallint
begin
  if(SpecYear >= FromYear and SpecYear <= ToYear) then
    if(SpecYear = FromYear and SpecPeriod < FromPeriod) then return 0
    end if;
    if(SpecYear = ToYear and SpecPeriod > ToPeriod) then return 0
    end if;
    if(SpecYear = FromYear and SpecPeriod = FromPeriod and SpecSubPeriod < FromSubPeriod) then return 0
    end if;
    if(SpecYear = ToYear and SpecPeriod = ToPeriod and SpecSubPeriod > ToSubPeriod) then return 0
    end if;
    return 1
  end if;
  return 0
end
;

create function dba.IsWageElementInUsed(
in In_WageElement char(20),
in In_WageId char(20))
returns smallint
begin
  declare In_InUsed smallint;
  select WagePropertyUsed into In_InUsed from Wageproperty where
    KeyWordId = In_WageElement and WageId = In_WageId;
  if In_InUsed is null then return 0
  end if;
  return In_InUsed
end
;

create procedure dba.UpdateAllowanceHistoryRecord(
in In_AllowanceSGSPGenId char(30),
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20),
in In_Formula char(255))
begin
  if exists(select* from AllowanceHistoryRecord where
      AllowanceHistoryRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    update AllowanceHistoryRecord set
      AllowanceSGSPGenId = In_AllowanceSGSPGenId,
      Constant1 = In_Constant1,
      Constant2 = In_Constant2,
      Constant3 = In_Constant3,
      Constant4 = In_Constant4,
      Constant5 = In_Constant5,
      Keywords1 = In_Keywords1,
      Keywords2 = In_Keywords2,
      Keywords3 = In_Keywords3,
      Keywords4 = In_Keywords4,
      Keywords5 = In_Keywords5,
      Keywords6 = In_Keywords6,
      Keywords7 = In_Keywords7,
      Keywords8 = In_Keywords8,
      Keywords9 = In_Keywords9,
      Keywords10 = In_Keywords10,
      UserDef1 = In_UserDef1,
      UserDef2 = In_UserDef2,
      UserDef3 = In_UserDef3,
      UserDef4 = In_UserDef4,
      UserDef5 = In_UserDef5,
      UserDef1Value = In_UserDef1Value,
      UserDef2Value = In_UserDef2Value,
      UserDef3Value = In_UserDef3Value,
      UserDef4Value = In_UserDef4Value,
      UserDef5Value = In_UserDef5Value,
      F1 = In_F1,
      F2 = In_F2,
      F3 = In_F3,
      F4 = In_F4,
      F5 = In_F5,
      F6 = In_F6,
      F7 = In_F7,
      F8 = In_F8,
      F9 = In_F9,
      F10 = In_F10,
      P1 = In_P1,
      P2 = In_P2,
      P3 = In_P3,
      P4 = In_P4,
      P5 = In_P5,
      P6 = In_P6,
      P7 = In_P7,
      P8 = In_P8,
      P9 = In_P9,
      P10 = In_P10,
      Formula = In_Formula where
      AllowanceHistoryRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateAllowanceRecord(
in In_AllowanceSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_AllowanceFormulaId char(20),
in In_AllowanceAmount double,
in In_AllowanceRecurSysId char(30),
in In_AllowancePreProcessRec smallint,
in In_AllowanceCreatedBy char(20),
in In_AllowanceDeclaredDate date,
in In_AllowanceRemarks char(100),
in In_AllowanceCustSysId integer,
in In_AllowanceAmountF double,
in In_AllowanceExRateId char(20),
in In_AllowanceExRate double)
begin
  if exists(select* from AllowanceRecord where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId) then
    update AllowanceRecord set
      AllowanceSGSPGenId = In_AllowanceSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      AllowanceFormulaId = In_AllowanceFormulaId,
      AllowanceAmount = In_AllowanceAmount,
      AllowanceRecurSysId = In_AllowanceRecurSysId,
      AllowancePreProcessRec = In_AllowancePreProcessRec,
      AllowanceCreatedBy = In_AllowanceCreatedBy,
      AllowanceDeclaredDate = In_AllowanceDeclaredDate,
      AllowanceRemarks = In_AllowanceRemarks,
      AllowanceCustSysId = In_AllowanceCustSysId,
      AllowanceAmountF = In_AllowanceAmountF,
      AllowanceExRateId = In_AllowanceExRateId,
      AllowanceExRate = In_AllowanceExRate where
      AllowanceRecord.AllowanceSGSPGenId = In_AllowanceSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateBalancePayElement(
in In_EmployeeSysId char(20),
in In_CurFormulaId char(20),
in In_FormulaId char(20))
begin
  if exists(select* from BalancePayElement where
      EmployeeSysId = In_EmployeeSysId and
      FormulaId = In_CurFormulaId) then
    update BalancePayElement set
      FormulaId = In_FormulaId where
      EmployeeSysId = In_EmployeeSysId and
      FormulaId = In_CurFormulaId;
    commit work
  end if
end
;

create procedure DBA.UpdateBankDiskRecord(
in In_BankDiskName char(50),
in In_OrderReference char(2),
in In_InputValue char(60))
begin
  if exists(select* from BankDiskRecord where BankDiskRecord.BankDiskName = In_BankDiskName and BankDiskRecord.OrderReference = In_OrderReference) then
    update BankDiskRecord set
      BankDiskRecord.InputValue = In_InputValue where
      BankDiskRecord.BankDiskName = In_BankDiskName and BankDiskRecord.OrderReference = In_OrderReference
  end if;
  commit work
end
;

create procedure dba.UpdateBankFilter(
in In_BankFilterId char(20),
in In_BankFilterDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from BankFilter where BankFilterId = In_BankFilterId) then
    update BankFilter set
      BankFilterDesc = In_BankFilterDesc where
      BankFilterId = In_BankFilterId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateBankRecord(
in In_BankRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentBankCode char(20),
in In_PaymentBankBrCode char(20),
in In_PaymentBankAccNo char(30),
in In_PaymentAmt double,
in In_PaymentCategory char(20),
in In_PaymentType char(20),
in In_PaymentValue double,
in In_PaymentBankAccType char(20),
in In_PaymentMode char(20),
in In_BeneficiaryName char(150))
begin
  if exists(select* from BankRecord where
      BankRecord.BankRecSGSPGenId = In_BankRecSGSPGenId) then
    update BankRecord set
      BankRecSGSPGenId = In_BankRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      PaymentBankCode = In_PaymentBankCode,
      PaymentBankBrCode = In_PaymentBankBrCode,
      PaymentBankAccNo = In_PaymentBankAccNo,
      PaymentAmt = In_PaymentAmt,
      PaymentCategory = In_PaymentCategory,
      PaymentType = In_PaymentType,
      PaymentValue = In_PaymentValue,
      PaymentBankAccType = In_PaymentBankAccType,
      PaymentMode = In_PaymentMode,
      BeneficiaryName = In_BeneficiaryName where
      BankRecord.BankRecSGSPGenId = In_BankRecSGSPGenId;
    commit work
  end if
end
;

create procedure DBA.UpdateBasicRateProgression(
in In_EmployeeSysId integer,
in In_BRProgDate date,
in In_BRProgRemarks char(255),
in In_BRProgEffectiveDate date,
in In_BRProgBasicRateType char(20),
in In_BRProgNewBasicRate double,
in In_BRProgPercentage double,
in In_BRProgressionCode char(20),
in In_BRProgCareerId char(20),
in In_BRProgPrevBasicRate double,
in In_BRProgIncrementAmt double,
in In_BRProgPayGroup char(20),
in In_BRProgCurrent smallint,
in In_BRProgNextIncDate date,
in In_BRProgExRateId char(20))
begin
  if(In_BRProgCurrent = 1) then
    if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgCurrent = In_BRProgCurrent) then
      update BasicRateProgression set
        BasicRateProgression.BRProgCurrent = 0 where
        BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgCurrent = In_BRProgCurrent;
      commit work
    end if
  end if;
  if exists(select* from BasicRateProgression where BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgDate = In_BRProgDate) then
    update BasicRateProgression set
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId,
      BasicRateProgression.BRProgDate = In_BRProgDate,
      BasicRateProgression.BRProgRemarks = In_BRProgRemarks,
      BasicRateProgression.BRProgEffectiveDate = In_BRProgEffectiveDate,
      BasicRateProgression.BRProgBasicRateType = In_BRProgBasicRateType,
      BasicRateProgression.BRProgNewBasicRate = In_BRProgNewBasicRate,
      BasicRateProgression.BRProgPercentage = In_BRProgPercentage,
      BasicRateProgression.BRProgressionCode = In_BRProgressionCode,
      BasicRateProgression.BRProgCareerId = In_BRProgCareerId,
      BasicRateProgression.BRProgPrevBasicRate = In_BRProgPrevBasicRate,
      BasicRateProgression.BRProgIncrementAmt = In_BRProgIncrementAmt,
      BasicRateProgression.BRProgPayGroup = In_BRProgPayGroup,
      BasicRateProgression.BRProgCurrent = In_BRProgCurrent,
      BasicRateProgression.BRProgNextIncDate = In_BRProgNextIncDate,
      BasicRateProgression.BRProgExRateId = In_BRProgExRateId where
      BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgDate = In_BRProgDate;
    commit work
  end if
end
;

create procedure DBA.UpdateBonusProcess(
in In_BonusReportId char(20),
in In_BonusDescription char(100),
in In_BonusPayGroup char(20),
in In_BonusCode char(20),
in In_BonusFromYear integer,
in In_BonusFromMonth integer,
in In_BonusToYear integer,
in In_BonusToMonth integer,
in In_BonusTrialRun smallint,
in In_BonusFactorOpt smallint,
in In_BonusSysFactor double,
in In_BonusTerminated smallint,
in In_BonusFutureTerminated smallint,
in In_BonusConfirmed smallint,
in In_BonusCPFDeduct smallint,
in In_BonusWageOpt char(20),
in In_BonusFixedWage double,
in In_BonusDaysOpt char(20),
in In_BonusCutOffDay integer,
in In_BonusNPL smallint,
in In_BonusSick smallint,
in In_BonusAnnual smallint,
in In_BonusAbsent smallint,
in In_BonusCessation smallint,
in In_BonusHire smallint,
in In_BonusDeclaredDate date,
in In_BonusCutOffSvcMth double,
in In_BonusApprDateFrom date,
in In_BonusApprDateTo date,
in In_BonusApprMethod smallint,
in In_BonusRoundAmount smallint)
begin
  if exists(select* from BonusProcess where
      BonusProcess.BonusReportId = In_BonusReportId) then
    update BonusProcess set
      BonusReportId = In_BonusReportId,
      BonusDescription = In_BonusDescription,
      BonusPayGroup = In_BonusPayGroup,
      BonusCode = In_BonusCode,
      BonusFromYear = In_BonusFromYear,
      BonusFromMonth = In_BonusFromMonth,
      BonusToYear = In_BonusToYear,
      BonusToMonth = In_BonusToMonth,
      BonusTrialRun = In_BonusTrialRun,
      BonusFactorOpt = In_BonusFactorOpt,
      BonusSysFactor = In_BonusSysFactor,
      BonusTerminated = In_BonusTerminated,
      BonusFutureTerminated = In_BonusFutureTerminated,
      BonusConfirmed = In_BonusConfirmed,
      BonusCPFDeduct = In_BonusCPFDeduct,
      BonusWageOpt = In_BonusWageOpt,
      BonusFixedWage = In_BonusFixedWage,
      BonusDaysOpt = In_BonusDaysOpt,
      BonusCutOffDay = In_BonusCutOffDay,
      BonusNPL = In_BonusNPL,
      BonusSick = In_BonusSick,
      BonusAnnual = In_BonusAnnual,
      BonusAbsent = In_BonusAbsent,
      BonusCessation = In_BonusCessation,
      BonusHire = In_BonusHire,
      BonusDeclaredDate = In_BonusDeclaredDate,
      BonusCutOffSvcMth = In_BonusCutOffSvcMth,
      BonusApprDateFrom = In_BonusApprDateFrom,
      BonusApprDateTo = In_BonusApprDateTo,
      BonusApprMethod = In_BonusApprMethod,
      BonusRoundAmount = In_BonusRoundAmount where
      BonusProcess.BonusReportId = In_BonusReportId;
    commit work
  end if
end
;

create procedure dba.UpdateBonusRecord(
in In_BonusRecordSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BonusBaseWage double,
in In_BonusDaysWorked double,
in In_BonusNPL double,
in In_BonusAnnual double,
in In_BonusSick double,
in In_BonusAmt double,
in In_BonusFactor numeric(8,5))
begin
  if exists(select* from BonusRecord where
      BonusRecord.BonusRecordSGSPGenId = In_BonusRecordSGSPGenId) then
    update BonusRecord set
      BonusRecordSGSPGenId = In_BonusRecordSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      BonusBaseWage = In_BonusBaseWage,
      BonusDaysWorked = In_BonusDaysWorked,
      BonusNPL = In_BonusNPL,
      BonusAnnual = In_BonusAnnual,
      BonusSick = In_BonusSick,
      BonusAmt = In_BonusAmt,
      BonusFactor = In_BonusFactor where
      BonusRecord.BonusRecordSGSPGenId = In_BonusRecordSGSPGenId;
    commit work
  end if
end
;

create procedure DBA.UpdateBonusReport(
in In_BonusReportId char(20),
in In_BonusEmployeeSysId integer,
in In_BonusAmount double,
in In_BonusWage double,
in In_BonusDayMonth double,
in In_BonusEENPL double,
in In_BonusEESick double,
in In_BonusEEAnnual double,
in In_BonusEEAbsent double,
in In_BonusFactor double,
in In_BonusProrateFactor double,
in In_BonusWageF double,
in In_BonusExRateId char(20),
in In_BonusExRate double)
begin
  if exists(select* from BonusReport where
      BonusReport.BonusReportId = In_BonusReportId and BonusReport.BonusEmployeeSysId = In_BonusEmployeeSysId) then
    update BonusReport set
      BonusReportId = In_BonusReportId,
      BonusEmployeeSysId = In_BonusEmployeeSysId,
      BonusAmount = In_BonusAmount,
      BonusWage = In_BonusWage,
      BonusDayMonth = In_BonusDayMonth,
      BonusEENPL = In_BonusEENPL,
      BonusEESick = In_BonusEESick,
      BonusEEAnnual = In_BonusEEAnnual,
      BonusEEAbsent = In_BonusEEAbsent,
      BonusFactor = In_BonusFactor,
      BonusProrateFactor = In_BonusProrateFactor,
      BonusWageF = In_BonusWageF,
      BonusExRateId = In_BonusExRateId,
      BonusExRate = In_BonusExRate where
      BonusReport.BonusReportId = In_BonusReportId and BonusReport.BonusEmployeeSysId = In_BonusEmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdateCareer(
in In_CareerId char(20),
in In_CareerDesc char(100))
begin
  if exists(select* from Career where
      CareerId = In_CareerId) then
    update Career set
      CareerDesc = In_CareerDesc where
      CareerId = In_CareerId;
    commit work
  end if
end
;

create procedure dba.UpdateCPFAgeGroup(
in In_AgeGroupId char(20),
in In_AgeGroupDesc char(100),
in In_MinCPFAge integer,
in In_MaxCPFAge integer)
begin
  if exists(select* from CPFAgeGroup where
      CPFAgeGroup.AgeGroupId = In_AgeGroupId) then
    update CPFAgeGroup set
      CPFAgeGroup.AgeGroupDesc = In_AgeGroupDesc,
      CPFAgeGroup.MinCPFAge = In_MinCPFAge,
      CPFAgeGroup.MaxCPFAge = In_MaxCPFAge where
      CPFAgeGroup.AgeGroupId = In_AgeGroupId;
    commit work
  end if
end
;

create procedure DBA.UpdateCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date,
in In_CPFGovtPolicyId char(20),
in In_CPFGovtCurrent smallint,
in In_CPFGovtRemarks char(255))
begin
  if exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate) then
    update CPFGovernmentProgression set
      CPFGovernmentProgression.CPFGovtPolicyId = In_CPFGovtPolicyId,
      CPFGovernmentProgression.CPFGovtCurrent = In_CPFGovtCurrent,
      CPFGovernmentProgression.CPFGovtRemarks = In_CPFGovtRemarks where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateCPFPayment(
in In_EmployeeSysId integer,
in In_CPFPaymentSubPeriod integer,
in In_CPFPaymentOption integer)
begin
  if exists(select* from CPFPayment where
      CPFPayment.EmployeeSysId = In_EmployeeSysId and
      CPFPayment.CPFPaymentSubPeriod = In_CPFPaymentSubPeriod) then
    update CPFPayment set
      CPFPayment.CPFPaymentOption = In_CPFPaymentOption where
      CPFPayment.EmployeeSysId = In_EmployeeSysId and
      CPFPayment.CPFPaymentSubPeriod = In_CPFPaymentSubPeriod;
    commit work
  end if
end
;

create procedure DBA.UpdateCPFPolicy(
in In_CPFPolicyId char(20),
in In_CPFGovernment smallint,
in In_CPFPolicyDesc char(100))
begin
  if exists(select* from CPFPolicy where
      CPFPolicy.CPFPolicyId = In_CPFPolicyId) then
    update CPFPolicy set
      CPFPolicy.CPFGovernment = In_CPFGovernment,
      CPFPolicy.CPFPolicyDesc = In_CPFPolicyDesc where
      CPFPolicy.CPFPolicyId = In_CPFPolicyId;
    commit work
  end if
end
;

create procedure DBA.UpdateCPFProgression(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFProgRemarks char(255))
begin
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    if(In_CPFProgCurrent = 1 and
      (FGetDBCountry(*) = 'Singapore' or
      FGetDBCountry(*) = 'Indonesia')) then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    if(In_CPFProgCurrent = 1 and FGetDBCountry(*) = 'Brunei') then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId and
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update CPFProgression set
      CPFProgression.EmployeeSysId = In_EmployeeSysId,
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate,
      CPFProgression.CPFProgCurrent = In_CPFProgCurrent,
      CPFProgression.CPFCareerId = In_CPFCareerId,
      CPFProgression.CPFProgPolicyId = In_CPFProgPolicyId,
      CPFProgression.CPFProgAccountNo = In_CPFProgAccountNo,
      CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId,
      CPFProgression.CPFMAWOption = In_CPFMAWOption,
      CPFProgression.CPFMAWLimit = In_CPFMAWLimit,
      CPFProgression.CPFMAWPeriodOrdWage = In_CPFMAWPeriodOrdWage,
      CPFProgression.CPFMedisavePaidByER = In_CPFMedisavePaidByER,
      CPFProgression.CPFProgRemarks = In_CPFProgRemarks where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateCPFSalaryGroup(
in In_SalaryGroupId char(20),
in In_SalaryGroupDesc char(100),
in In_MinSalary numeric(10,2),
in In_MaxSalary numeric(10,2))
begin
  if exists(select* from CPFSalaryGroup where
      CPFSalaryGroup.SalaryGroupId = In_SalaryGroupId) then
    update CPFSalaryGroup set
      CPFSalaryGroup.SalaryGroupDesc = In_SalaryGroupDesc,
      CPFSalaryGroup.MinSalary = In_MinSalary,
      CPFSalaryGroup.MaxSalary = In_MaxSalary where
      CPFSalaryGroup.SalaryGroupId = In_SalaryGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateCPFTableCode(
in In_CPFTableCodeId char(20),
in In_CPFResidenceTypeId char(20),
in In_CPFSchemeId char(20),
in In_CPFPeriodCapping double,
in In_CPFLessThanCapping double,
in In_CPFGreaterThanCapping double,
in In_CPFTableDesc char(100))
begin
  if exists(select* from CPFTableCode where
      CPFTableCode.CPFTableCodeId = In_CPFTableCodeId) then
    update CPFTableCode set
      CPFTableCode.CPFResidenceTypeId = In_CPFResidenceTypeId,
      CPFTableCode.CPFSchemeId = In_CPFSchemeId,
      CPFTableCode.CPFPeriodCapping = In_CPFPeriodCapping,
      CPFTableCode.CPFLessThanCapping = In_CPFLessThanCapping,
      CPFTableCode.CPFGreaterThanCapping = In_CPFGreaterThanCapping,
      CPFTableCode.CPFTableDesc = In_CPFTableDesc where
      CPFTableCode.CPFTableCodeId = In_CPFTableCodeId;
    commit work
  end if
end
;

create procedure dba.UpdateCPFTableComponent(
in In_CPFTableCodeId char(20),
in In_MinSalary double,
in In_MinCPFAge double,
in In_NewMinSalary double,
in In_NewMinCPFAge double,
in In_EEOrdCPFFormula char(20),
in In_EROrdCPFFormula char(20),
in In_MaxSalary double,
in In_MaxCPFAge double,
in In_EEAddCPFFormula char(20),
in In_ERAddCPFFormula char(20))
begin
  if exists(select* from CPFTableComponent where
      CPFTableComponent.CPFTableCodeId = In_CPFTableCodeId and
      CPFTableComponent.MinSalary = In_MinSalary and
      CPFTableComponent.MinCPFAge = In_MinCPFAge) then
    update CPFTableComponent set
      CPFTableComponent.MinSalary = In_NewMinSalary,
      CPFTableComponent.MinCPFAge = In_NewMinCPFAge,
      CPFTableComponent.EEOrdCPFFormula = In_EEOrdCPFFormula,
      CPFTableComponent.EROrdCPFFormula = In_EROrdCPFFormula,
      CPFTableComponent.MaxSalary = In_MaxSalary,
      CPFTableComponent.MaxCPFAge = In_MaxCPFAge,
      CPFTableComponent.EEAddCPFFormula = In_EEAddCPFFormula,
      CPFTableComponent.ERAddCPFFormula = In_ERAddCPFFormula where
      CPFTableComponent.CPFTableCodeId = In_CPFTableCodeId and
      CPFTableComponent.MinSalary = In_MinSalary and
      CPFTableComponent.MinCPFAge = In_MinCPFAge;
    commit work
  end if
end
;

create procedure dba.UpdateDefaultCPFPayment(
in In_PayGroupId char(20),
in In_DefaultCPFPaymentSubPeriod integer,
in In_CPFPaymentOption integer)
begin
  if exists(select* from DefaultCPFPayment where DefaultCPFPayment.PayGroupId = In_PayGroupId) then
    update DefaultCPFPayment set
      DefaultCPFPayment.PayGroupId = In_PayGroupId,
      DefaultCPFPayment.DefaultCPFPaymentSubPeriod = In_DefaultCPFPaymentSubPeriod,
      DefaultCPFPayment.CPFPaymentOption = In_CPFPaymentOption where
      DefaultCPFPayment.PayGroupId = In_PayGroupId and
      DefaultCPFPayment.DefaultCPFPaymentSubPeriod = In_DefaultCPFPaymentSubPeriod;
    commit work
  end if
end
;

create procedure dba.UpdateDefaultPayAllocation(
in In_PayGroupId char(20),
in In_DefaultPayAllocSubPeriod integer,
in In_DefaultPayBasicRateType char(20),
in In_DefaultPayAllocTypeId char(20),
in In_DefaultPayAllocValue numeric(14,2))
begin
  if exists(select* from DefaultPayAllocation where DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod and
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType) then
    update DefaultPayAllocation set
      DefaultPayAllocation.PayGroupId = In_PayGroupId,
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod,
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType,
      DefaultPayAllocation.DefaultPayAllocTypeId = In_DefaultPayAllocTypeId,
      DefaultPayAllocation.DefaultPayAllocValue = In_DefaultPayAllocValue where
      DefaultPayAllocation.PayGroupId = In_PayGroupId and
      DefaultPayAllocation.DefaultPayAllocSubPeriod = In_DefaultPayAllocSubPeriod and
      DefaultPayAllocation.DefaultPayBasicRateType = In_DefaultPayBasicRateType;
    commit work
  end if
end
;

create procedure dba.UpdateDetailRecord(
in In_DetailRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_PreviousHrDays double,
in In_CurrentHrDays double,
in In_PreviousHrDaysRate double,
in In_CurrentHrDaysRate double,
in In_PayAllocationType char(20),
in In_PayAllocationValue double,
in In_CalTotalWage double,
in In_CalOTAmount double,
in In_CalOTBackPay double,
in In_CalShiftAmount double,
in In_CalLveDeductAmt double,
in In_CalBackPay double,
in In_CalGrossWage double,
in In_CalTotalGrossWage double,
in In_CalNetWage double,
in In_AllocatedBasicRate double,
in In_CurBackPayBasicRate double,
in In_PrevBackPayBasicRate double,
in In_FullBackPayFreq double,
in In_ProratedBackPayFreq double,
in In_BackPayProgressionDate date,
in In_CurrentBasicRateF double,
in In_CurrentBRExRateId char(20),
in In_CurrentBRExRate double,
in In_PreviousBasicRateF double,
in In_AllocatedBasicRateF double,
in In_CalTotalWageF double,
in In_CalBackPayF double,
in In_CurBackPayBasicRateF double,
in In_PrevBackPayBasicRateF double,
in In_FreeNumeric1 double,
in In_FreeNumeric2 double,
in In_FreeNumeric3 double,
in In_FreeNumeric4 double,
in In_FreeNumeric5 double,
in In_FreeString1 char(200),
in In_FreeString2 char(200),
in In_FreeString3 char(200),
in In_FreeString4 char(200),
in In_FreeString5 char(200),
in In_NetWageP double,
in In_NetWageExRateId char(20),
in In_NetWageExRate double,
in In_NetWageBankAllocGpId char(20))
begin
  if exists(select* from DetailRecord where
      DetailRecord.DetailRecSGSPGenId = In_DetailRecSGSPGenId) then
    update DetailRecord set
      DetailRecSGSPGenId = In_DetailRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      CurrentBasicRate = In_CurrentBasicRate,
      PreviousBasicRate = In_PreviousBasicRate,
      CurrentBasicRateType = In_CurrentBasicRateType,
      PreviousBasicRateType = In_PreviousBasicRateType,
      PreviousHrDays = In_PreviousHrDays,
      CurrentHrDays = In_CurrentHrDays,
      PreviousHrDaysRate = In_PreviousHrDaysRate,
      CurrentHrDaysRate = In_CurrentHrDaysRate,
      PayAllocationType = In_PayAllocationType,
      PayAllocationValue = In_PayAllocationValue,
      CalTotalWage = In_CalTotalWage,
      CalOTAmount = In_CalOTAmount,
      CalOTBackPay = In_CalOTBackPay,
      CalShiftAmount = In_CalShiftAmount,
      CalLveDeductAmt = In_CalLveDeductAmt,
      CalBackPay = In_CalBackPay,
      CalGrossWage = In_CalGrossWage,
      CalTotalGrossWage = In_CalTotalGrossWage,
      CalNetWage = In_CalNetWage,
      AllocatedBasicRate = In_AllocatedBasicRate,
      CurBackPayBasicRate = In_CurBackPayBasicRate,
      PrevBackPayBasicRate = In_PrevBackPayBasicRate,
      FullBackPayFreq = In_FullBackPayFreq,
      ProratedBackPayFreq = In_ProratedBackPayFreq,
      BackPayProgressionDate = In_BackPayProgressionDate,
      CurrentBasicRateF = In_CurrentBasicRateF,
      CurrentBRExRateId = In_CurrentBRExRateId,
      CurrentBRExRate = In_CurrentBRExRate,
      PreviousBasicRateF = In_PreviousBasicRateF,
      AllocatedBasicRateF = In_AllocatedBasicRateF,
      CalTotalWageF = In_CalTotalWageF,
      CalBackPayF = In_CalBackPayF,
      CurBackPayBasicRateF = In_CurBackPayBasicRateF,
      PrevBackPayBasicRateF = In_PrevBackPayBasicRateF,
      FreeNumeric1 = In_FreeNumeric1,
      FreeNumeric2 = In_FreeNumeric2,
      FreeNumeric3 = In_FreeNumeric3,
      FreeNumeric4 = In_FreeNumeric4,
      FreeNumeric5 = In_FreeNumeric5,
      FreeString1 = In_FreeString1,
      FreeString2 = In_FreeString2,
      FreeString3 = In_FreeString3,
      FreeString4 = In_FreeString4,
      FreeString5 = In_FreeString5,
      NetWageP = In_NetWageP,
      NetWageExRateId = In_NetWageExRateId,
      NetWageExRate = In_NetWageExRate,
      NetWageBankAllocGpId = In_NetWageBankAllocGpId where
      DetailRecord.DetailRecSGSPGenId = In_DetailRecSGSPGenId;
    commit work
  end if
end
;

create procedure DBA.UpdateEmployPassProgression(
in In_EmployeeSysId integer,
in In_EPEffectiveDate date,
in In_EPCareerId char(20),
in In_EPExpiryDate date,
in In_EPApplicationDate date,
in In_EPArrivalDate date,
in In_EPCancellationDate date,
in In_EPIssueDate date,
in In_EPFIN char(20),
in In_EPRemarks char(255),
in In_EPCurrent smallint)
begin
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate) then
    if(In_EPCurrent = 1) then
      update EmployPassProgression set
        EmployPassProgression.EPCurrent = 0 where
        EmployPassProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update EmployPassProgression set
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId,
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate,
      EmployPassProgression.EPCareerId = In_EPCareerId,
      EmployPassProgression.EPExpiryDate = In_EPExpiryDate,
      EmployPassProgression.EPApplicationDate = In_EPApplicationDate,
      EmployPassProgression.EPArrivalDate = In_EPArrivalDate,
      EmployPassProgression.EPCancellationDate = In_EPCancellationDate,
      EmployPassProgression.EPIssueDate = In_EPIssueDate,
      EmployPassProgression.EPFIN = In_EPFIN,
      EmployPassProgression.EPRemarks = In_EPRemarks,
      EmployPassProgression.EPCurrent = In_EPCurrent where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId and
      EmployPassProgression.EPEffectiveDate = In_EPEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateEmpRecurAllow(
in In_RecurAlloSGSPGenId char(30),
in In_RecurAlloDesc char(100),
in In_FormulaId char(20),
in In_RecurAlloFullAmount double,
in In_RecurAlloAmount double,
in In_RecurAlloSuspense integer,
in In_RecurAlloEndCounter integer,
in In_RecurAlloSubPeriod integer,
in In_RecurAlloStartPeriod integer,
in In_RecurAlloStartYear integer,
in In_RecurAlloEndPeriod integer,
in In_RecurAlloEndYear integer,
in In_EmployeeSysId integer,
in In_RecurCreated char(1),
in In_RecurAlloPayRecId char(20),
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double)
begin
  if exists(select* from EmployeeRecurAllowance where
      EmployeeRecurAllowance.RecurAlloSGSPGenId = In_RecurAlloSGSPGenId) then
    update EmployeeRecurAllowance set
      EmployeeRecurAllowance.RecurAlloDesc = In_RecurAlloDesc,
      EmployeeRecurAllowance.FormulaId = In_FormulaId,
      EmployeeRecurAllowance.RecurAlloFullAmount = In_RecurAlloFullAmount,
      EmployeeRecurAllowance.RecurAlloAmount = In_RecurAlloAmount,
      EmployeeRecurAllowance.RecurAlloSuspense = In_RecurAlloSuspense,
      EmployeeRecurAllowance.RecurAlloEndCounter = In_RecurAlloEndCounter,
      EmployeeRecurAllowance.RecurAlloSubPeriod = In_RecurAlloSubPeriod,
      EmployeeRecurAllowance.RecurAlloStartPeriod = In_RecurAlloStartPeriod,
      EmployeeRecurAllowance.RecurAlloStartYear = In_RecurAlloStartYear,
      EmployeeRecurAllowance.RecurAlloEndPeriod = In_RecurAlloEndPeriod,
      EmployeeRecurAllowance.RecurAlloEndYear = In_RecurAlloEndYear,
      EmployeeRecurAllowance.EmployeeSysId = In_EmployeeSysId,
      EmployeeRecurAllowance.RecurCreated = In_RecurCreated,
      EmployeeRecurAllowance.RecurAlloPayRecId = In_RecurAlloPayRecId,
      EmployeeRecurAllowance.UserDef1Value = In_UserDef1Value,
      EmployeeRecurAllowance.UserDef2Value = In_UserDef2Value,
      EmployeeRecurAllowance.UserDef3Value = In_UserDef3Value,
      EmployeeRecurAllowance.UserDef4Value = In_UserDef4Value,
      EmployeeRecurAllowance.UserDef5Value = In_UserDef5Value where
      EmployeeRecurAllowance.RecurAlloSGSPGenId = In_RecurAlloSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateFormula(
in In_FormulaId char(20),
in In_FormulaActive integer,
in In_FormulaPreprocess integer,
in In_FormulaRecurring integer,
in In_FormulaCategory char(20),
in In_FormulaSubCategory char(20),
in In_FormulaType char(20),
in In_FormulaRangeBasis char(20),
in In_FormulaDesc char(255),
in In_FormulaExRateId char(20),
in In_FormulaStage integer,
in In_FormulaRank integer)
begin
  if exists(select* from Formula where
      Formula.FormulaId = In_FormulaId) then
    update Formula set
      Formula.FormulaActive = In_FormulaActive,
      Formula.FormulaPreprocess = In_FormulaPreprocess,
      Formula.FormulaRecurring = In_FormulaRecurring,
      Formula.FormulaCategory = In_FormulaCategory,
      Formula.FormulaSubCategory = In_FormulaSubCategory,
      Formula.FormulaType = In_FormulaType,
      Formula.FormulaRangeBasis = In_FormulaRangeBasis,
      Formula.FormulaDesc = In_FormulaDesc,
      Formula.FormulaExRateId = In_FormulaExRateId,
      Formula.FormulaStage = In_FormulaStage,
      Formula.FormulaRank = In_FormulaRank where
      Formula.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateFormulaProperty(
in In_KeyWordId char(20),
in In_FormulaId char(100),
in In_NewFormulaId char(20))
begin
  if exists(select* from FormulaProperty where
      FormulaProperty.KeyWordId = In_KeyWordId and
      FormulaProperty.FormulaId = In_FormulaId) then
    update FormulaProperty set
      FormulaProperty.FormulaId = In_NewFormulaId where
      FormulaProperty.KeyWordId = In_KeyWordId and
      FormulaProperty.FormulaId = In_FormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateFormulaRange(
in In_FormulaRangeId integer,
in In_FormulaId char(20),
in In_Maximum double,
in In_Minimum double,
in In_Formula char(255),
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20),
in In_F1 char(20),
in In_F2 char(20),
in In_F3 char(20),
in In_F4 char(20),
in In_F5 char(20),
in In_F6 char(20),
in In_F7 char(20),
in In_F8 char(20),
in In_F9 char(20),
in In_F10 char(20),
in In_P1 char(20),
in In_P2 char(20),
in In_P3 char(20),
in In_P4 char(20),
in In_P5 char(20),
in In_P6 char(20),
in In_P7 char(20),
in In_P8 char(20),
in In_P9 char(20),
in In_P10 char(20))
begin
  if exists(select* from FormulaRange where
      FormulaRange.FormulaId = In_FormulaId and
      FormulaRange.FormulaRangeId = In_FormulaRangeId) then
    update FormulaRange set
      FormulaRange.Maximum = In_Maximum,
      FormulaRange.Minimum = In_Minimum,
      FormulaRange.Formula = In_Formula,
      FormulaRange.Constant1 = In_Constant1,
      FormulaRange.Constant2 = In_Constant2,
      FormulaRange.Constant3 = In_Constant3,
      FormulaRange.Constant4 = In_Constant4,
      FormulaRange.Constant5 = In_Constant5,
      FormulaRange.Keywords1 = In_Keywords1,
      FormulaRange.Keywords2 = In_Keywords2,
      FormulaRange.Keywords3 = In_Keywords3,
      FormulaRange.Keywords4 = In_Keywords4,
      FormulaRange.Keywords5 = In_Keywords5,
      FormulaRange.Keywords6 = In_Keywords6,
      FormulaRange.Keywords7 = In_Keywords7,
      FormulaRange.Keywords8 = In_Keywords8,
      FormulaRange.Keywords9 = In_Keywords9,
      FormulaRange.Keywords10 = In_Keywords10,
      FormulaRange.UserDef1 = In_UserDef1,
      FormulaRange.UserDef2 = In_UserDef2,
      FormulaRange.UserDef3 = In_UserDef3,
      FormulaRange.UserDef4 = In_UserDef4,
      FormulaRange.UserDef5 = In_UserDef5,
      F1 = In_F1,
      F2 = In_F2,
      F3 = In_F3,
      F4 = In_F4,
      F5 = In_F5,
      F6 = In_F6,
      F7 = In_F7,
      F8 = In_F8,
      F9 = In_F9,
      F10 = In_F10,
      P1 = In_P1,
      P2 = In_P2,
      P3 = In_P3,
      P4 = In_P4,
      P5 = In_P5,
      P6 = In_P6,
      P7 = In_P7,
      P8 = In_P8,
      P9 = In_P9,
      P10 = In_P10 where
      FormulaRange.FormulaId = In_FormulaId and
      FormulaRange.FormulaRangeId = In_FormulaRangeId;
    commit work
  end if
end
;

create procedure dba.UpdateFWLProgression(
in In_FWLExpiryDate date,
in In_FWLEffectiveDate date,
in In_FWLApplicationDate date,
in In_FWLArrivalDate date,
in In_FWLCancellationDate date,
in In_FWLIssueDate date,
in In_FWLPermitNumber char(30),
in In_FWLCareerId char(20),
in In_FWLFormulaId char(20),
in In_FWLRemarks char(255),
in In_EmployeeSysId integer,
in In_FWLCurrent integer)
begin
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate) then
    if(In_FWLCurrent = 1) then
      update FWLProgression set
        FWLProgression.FWLCurrent = 0 where
        FWLProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update FWLProgression set
      FWLProgression.FWLExpiryDate = In_FWLExpiryDate,
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate,
      FWLProgression.FWLApplicationDate = In_FWLApplicationDate,
      FWLProgression.FWLArrivalDate = In_FWLArrivalDate,
      FWLProgression.FWLCancellationDate = In_FWLCancellationDate,
      FWLProgression.FWLIssueDate = In_FWLIssueDate,
      FWLProgression.FWLPermitNumber = In_FWLPermitNumber,
      FWLProgression.FWLCareerId = In_FWLCareerId,
      FWLProgression.FWLFormulaId = In_FWLFormulaId,
      FWLProgression.FWLRemarks = In_FWLRemarks,
      FWLProgression.EmployeeSysId = In_EmployeeSysId,
      FWLProgression.FWLCurrent = In_FWLCurrent where
      FWLProgression.EmployeeSysId = In_EmployeeSysId and
      FWLProgression.FWLEffectiveDate = In_FWLEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateKeyWord(
in In_KeyWordId char(20),
in In_KeyWordDefaultName char(20),
in In_KeyWordUserDefinedName char(20),
in In_KeyWordCategory char(20),
in In_KeyWordDesc char(100),
in In_KeyWordPropertySel integer,
in In_KeyWordFormulaSel integer,
in In_KeyWordRangeSel integer)
begin
  if exists(select* from KeyWord where
      KeyWord.KeyWordId = In_KeyWordId) then
    update KeyWord set
      KeyWord.KeyWordDefaultName = In_KeyWordDefaultName,
      KeyWord.KeyWordUserDefinedName = In_KeyWordUserDefinedName,
      KeyWord.KeyWordCategory = In_KeyWordCategory,
      KeyWord.KeyWordDesc = In_KeyWordDesc,
      KeyWord.KeyWordPropertySelection = In_KeyWordPropertySel,
      KeyWord.KeyWordFormulaSelection = In_KeyWordFormulaSel,
      KeyWord.KeyWordRangeSelection = In_KeyWordRangeSel where
      KeyWord.KeyWordId = In_KeyWordId;
    commit work
  end if
end
;

create procedure dba.UpdateLicenseRecord(
in In_SerialNo char(20),
in In_CompanyName char(200),
in In_LicenseExpiringDate date,
in In_SubSerialNo char(20),
in In_SubCompanyName char(200),
in In_ProductName char(100),
in In_SubProductName char(100),
in In_Functionlist char(2048),
in In_StrKey1 char(100),
in In_StrKey2 char(100),
in In_StrKey3 char(100),
in In_StrKey4 char(100),
in In_StrKey5 char(100),
in In_StrKey6 char(100),
in In_StrKey7 char(100),
in In_StrKey8 char(100),
in In_StrKey9 char(100),
in In_StrKey10 char(100),
in In_StrKey11 char(100),
in In_StrKey12 char(100),
in In_StrKey13 char(100),
in In_StrKey14 char(100),
in In_StrKey15 char(100),
in In_StrKey16 char(100),
in In_StrKey17 char(100),
in In_StrKey18 char(100),
in In_StrKey19 char(100),
in In_StrKey20 char(100),
in In_NumKey1 integer,
in In_NumKey2 integer,
in In_NumKey3 integer,
in In_NumKey4 integer,
in In_NumKey5 integer,
in In_NumKey6 integer,
in In_NumKey7 integer,
in In_NumKey8 integer,
in In_NumKey9 integer,
in In_NumKey10 integer,
in In_NumKey11 integer,
in In_NumKey12 integer,
in In_NumKey13 integer,
in In_NumKey14 integer,
in In_NumKey15 integer,
in In_NumKey16 integer,
in In_NumKey17 integer,
in In_NumKey18 integer,
in In_NumKey19 integer,
in In_NumKey20 integer,
in In_GenerateDate date,
in In_LicenseKey char(17))
begin
  if exists(select* from LicenseRecord where LicenseRecord.ProductName = In_ProductName and
      LicenseRecord.SubProductName = In_SubProductName) then
    update LicenseRecord set
      LicenseRecord.SerialNo = In_SerialNo,
      LicenseRecord.CompanyName = In_CompanyName,
      LicenseRecord.LicenseExpiringDate = In_LicenseExpiringDate,
      LicenseRecord.SubSerialNo = In_SubSerialNo,
      LicenseRecord.SubCompanyName = In_SubCompanyName,
      LicenseRecord.ProductName = In_ProductName,
      LicenseRecord.SubProductName = In_SubProductName,
      LicenseRecord.Functionlist = In_Functionlist,
      LicenseRecord.StrKey1 = In_StrKey1,
      LicenseRecord.StrKey2 = In_StrKey2,
      LicenseRecord.StrKey3 = In_StrKey3,
      LicenseRecord.StrKey4 = In_StrKey4,
      LicenseRecord.StrKey5 = In_StrKey5,
      LicenseRecord.StrKey6 = In_StrKey6,
      LicenseRecord.StrKey7 = In_StrKey7,
      LicenseRecord.StrKey8 = In_StrKey8,
      LicenseRecord.StrKey9 = In_StrKey9,
      LicenseRecord.StrKey10 = In_StrKey10,
      LicenseRecord.StrKey11 = In_StrKey11,
      LicenseRecord.StrKey12 = In_StrKey12,
      LicenseRecord.StrKey13 = In_StrKey13,
      LicenseRecord.StrKey14 = In_StrKey14,
      LicenseRecord.StrKey15 = In_StrKey15,
      LicenseRecord.StrKey16 = In_StrKey16,
      LicenseRecord.StrKey17 = In_StrKey17,
      LicenseRecord.StrKey18 = In_StrKey18,
      LicenseRecord.StrKey19 = In_StrKey19,
      LicenseRecord.StrKey20 = In_StrKey20,
      LicenseRecord.NumKey1 = In_NumKey1,
      LicenseRecord.NumKey2 = In_NumKey2,
      LicenseRecord.NumKey3 = In_NumKey3,
      LicenseRecord.NumKey4 = In_NumKey4,
      LicenseRecord.NumKey5 = In_NumKey5,
      LicenseRecord.NumKey6 = In_NumKey6,
      LicenseRecord.NumKey7 = In_NumKey7,
      LicenseRecord.NumKey8 = In_NumKey8,
      LicenseRecord.NumKey9 = In_NumKey9,
      LicenseRecord.NumKey10 = In_NumKey10,
      LicenseRecord.NumKey11 = In_NumKey11,
      LicenseRecord.NumKey12 = In_NumKey12,
      LicenseRecord.NumKey13 = In_NumKey13,
      LicenseRecord.NumKey14 = In_NumKey14,
      LicenseRecord.NumKey15 = In_NumKey15,
      LicenseRecord.NumKey16 = In_NumKey16,
      LicenseRecord.NumKey17 = In_NumKey17,
      LicenseRecord.NumKey18 = In_NumKey18,
      LicenseRecord.NumKey19 = In_NumKey19,
      LicenseRecord.NumKey20 = In_NumKey20,
      LicenseRecord.GenerateDate = In_GenerateDate,
      LicenseRecord.LicenseKey = In_LicenseKey where LicenseRecord.ProductName = In_ProductName and
      LicenseRecord.SubProductName = In_SubProductName;
    if not exists(select* from RegisteredSerialRecord where SerialNo = In_SerialNo) then
      insert into RegisteredSerialRecord(SerialNo,RegisterDate) values(In_SerialNo,Now(*));
      update SubRegistry set
        IntegerAttr = 0 where
        RegistryID = 'HRPLicense'
    end if;
    commit work
  end if
end
;

create procedure dba.UpdateLoginRecIPModule(
in In_UserId char(20),
in In_Module char(20),
in In_IPAddress char(20),
out Out_LoginSGSPGenId char(30))
begin
  declare TS_LogoutTimeStamp timestamp;
  set TS_LogoutTimeStamp=Now(*);
  update LoginRec set
    LoginRec.ModuleLogoutTime = TS_LogoutTimeStamp where
    LoginRec.UserId = In_UserId and
    LoginRec.Module = In_Module and
    LoginRec.IPAddress = In_IPAddress and
    LoginRec.ModuleLogoutTime is null;
  commit work;
  select Max(LoginSGSPGenId) into Out_LoginSGSPGenId from LoginRec where
    UserId = In_UserId and
    Module = In_Module and
    ModuleLogoutTime = TS_LogoutTimeStamp and
    IPAddress = In_IPAddress
end
;

create procedure dba.UpdateOTRecord(
in In_OTFormulaSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_OTFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_OTType char(20),
in In_OTRate double,
in In_MaxFreq double,
in In_CurrentOTRate double,
in In_CurrentOTFreq double,
in In_CurrentOTAmount double,
in In_LastOTRate double,
in In_LastOTFreq double,
in In_LastOTAmount double,
in In_BackPayOTRate double,
in In_BackPayOTFreq double,
in In_BackPayOTAmount double,
in In_OTCreatedBy char(20),
in In_OTAmountF double,
in In_OTExRateId char(20),
in In_OTExRate double)
begin
  if exists(select* from OTRecord where
      OTRecord.OTFormulaSGSPGenId = In_OTFormulaSGSPGenId) then
    update OTRecord set
      OTFormulaSGSPGenId = In_OTFormulaSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      OTFormulaId = In_OTFormulaId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      OTType = In_OTType,
      OTRate = In_OTRate,
      MaxFreq = In_MaxFreq,
      CurrentOTRate = In_CurrentOTRate,
      CurrentOTFreq = In_CurrentOTFreq,
      CurrentOTAmount = In_CurrentOTAmount,
      LastOTRate = In_LastOTRate,
      LastOTFreq = In_LastOTFreq,
      LastOTAmount = In_LastOTAmount,
      BackPayOTRate = In_BackPayOTRate,
      BackPayOTFreq = In_BackPayOTFreq,
      BackPayOTAmount = In_BackPayOTAmount,
      OTCreatedBy = In_OTCreatedBy,
      OTAmountF = In_OTAmountF,
      OTExRateId = In_OTExRateId,
      OTExRate = In_OTExRate where
      OTRecord.OTFormulaSGSPGenId = In_OTFormulaSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateOverTime(
in In_OTTableId char(20),
in In_OTTableDesc char(100),
in In_MaxTotalWage double,
in In_MinTotalWage double,
in In_MaxOverTimeAmount numeric(14,4),
in In_MinOverTimeAmount numeric(14,4),
in In_MaxDayRate double,
in In_MinDayRate double,
in In_MaxHourRate double,
in In_MinHourRate double)
begin
  if exists(select* from OverTime where
      OverTime.OTTableId = In_OTTableId) then
    update OverTime set
      OverTime.OTTableDesc = In_OTTableDesc,
      OverTime.MaxTotalWage = In_MaxTotalWage,
      OverTime.MinTotalWage = In_MinTotalWage,
      OverTime.MaxOverTimeAmount = In_MaxOverTimeAmount,
      OverTime.MinOverTimeAmount = In_MinOverTimeAmount,
      OverTime.MaxDayRate = In_MaxDayRate,
      OverTime.MinDayRate = In_MinDayRate,
      OverTime.MaxHourRate = In_MaxHourRate,
      OverTime.MinHourRate = In_MinHourRate where
      OverTime.OTTableId = In_OTTableId;
    commit work
  end if
end
;

create procedure dba.UpdatePayAllocation(
in In_EmployeeSysId integer,
in In_PayAllocationSubPeriod integer,
in In_PayAllocationValue double,
in In_PayAllocationTypeId char(20))
begin
  if exists(select* from PayAllocation where PayAllocation.EmployeeSysId = In_EmployeeSysId and
      PayAllocation.PayAllocationSubPeriod = In_PayAllocationSubPeriod) then
    update PayAllocation set
      PayAllocationValue = In_PayAllocationValue,
      PayAllocationTypeId = In_PayAllocationTypeId where
      PayAllocation.EmployeeSysId = In_EmployeeSysId and
      PayAllocation.PayAllocationSubPeriod = In_PayAllocationSubPeriod;
    commit work
  end if
end
;

create procedure dba.UpdatePayEmployee(
in In_EmployeeSysId integer,
in In_ShiftTableId char(20),
in In_OTTableId char(20),
in In_PayGroupId char(20),
in In_PaySuspense integer,
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_BonusFactor double,
in In_LastPayDate date,
in In_PaySlipMessage char(100),
in In_PaySlipMessage2 char(100),
in In_EEHoursperDay double,
in In_BRPDayRateId char(20),
in In_BRPHourRateId char(20),
in In_OTDayRateId char(20),
in In_OTHourRateId char(20),
in In_GRPDayRateId char(20),
in In_GRPHourRateId char(20),
in In_PayAllocationBalance integer,
in In_LateInformation integer,
in In_AbsentInformation integer,
in In_SickLveEntitlement double,
in In_ANNLveBroughtForward double,
in In_ANNLveEntitlement double,
in In_BasicRateExchangeId char(20),
in In_EECPFPaidByER integer,
in In_DefaultHourRate double,
in In_CasualPayment integer)
begin
  if exists(select* from PayEmployee where PayEmployee.EmployeeSysId = In_EmployeeSysId) then
    update PayEmployee set
      ShiftTableId = In_ShiftTableId,
      OTTableId = In_OTTableId,
      PayGroupId = In_PayGroupId,
      PaySuspense = In_PaySuspense,
      CurrentBasicRate = In_CurrentBasicRate,
      PreviousBasicRate = In_PreviousBasicRate,
      CurrentBasicRateType = In_CurrentBasicRateType,
      PreviousBasicRateType = In_PreviousBasicRateType,
      BonusFactor = In_BonusFactor,
      LastPayDate = In_LastPayDate,
      PaySlipMessage = In_PaySlipMessage,
      PaySlipMessage2 = In_PaySlipMessage2,
      EEHoursperDay = In_EEHoursperDay,
      BRPDayRateId = In_BRPDayRateId,
      BRPHourRateId = In_BRPHourRateId,
      OTDayRateId = In_OTDayRateId,
      OTHourRateId = In_OTHourRateId,
      GRPDayRateId = In_GRPDayRateId,
      GRPHourRateId = In_GRPHourRateId,
      PayAllocationBalance = In_PayAllocationBalance,
      LateInformation = In_LateInformation,
      AbsentInformation = In_AbsentInformation,
      SickLveEntitlement = In_SickLveEntitlement,
      ANNLveBroughtForward = In_ANNLveBroughtForward,
      ANNLveEntitlement = In_ANNLveEntitlement,
      BasicRateExchangeId = In_BasicRateExchangeId,
      EECPFPaidByER = In_EECPFPaidByER,
      DefaultHourRate = In_DefaultHourRate,
      CasualPayment = In_CasualPayment where
      PayEmployee.EmployeeSysid = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePayEmployeePolicy(
in In_EmployeeSysId integer,
in In_CurrentNWC double,
in In_PreviousNWC double,
in In_CurrentMVC double,
in In_PreviousMVC double,
in In_MVCCapping double)
begin
  if exists(select* from PayEmployeePolicy where PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId) then
    update PayEmployeePolicy set
      PayEmployeePolicy.CurrentNWC = In_CurrentNWC,
      PayEmployeePolicy.PreviousNWC = In_PreviousNWC,
      PayEmployeePolicy.CurrentMVC = In_CurrentMVC,
      PayEmployeePolicy.PreviousMVC = In_PreviousMVC,
      PayEmployeePolicy.MVCCapping = In_MVCCapping where
      PayEmployeePolicy.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePayGroup(
in In_PayGroupId char(20),
in In_NoSubPeriod integer,
in In_PeriodStartYear integer,
in In_PeriodStartPRPeriod integer,
in In_PeriodStartPRMonth integer,
in In_PayGroupDesc char(100),
in In_PayBalLastSubPeriod integer,
in In_PayBankAllocGpId char(20),
in In_PaymentExRateId char(20))
begin
  if exists(select* from PayGroup where PayGroup.PayGroupId = In_PayGroupId) then
    update PayGroup set
      PayGroupId = In_PayGroupId,
      NoSubPeriod = In_NoSubPeriod,
      PeriodStartYear = In_PeriodStartYear,
      PeriodStartPRPeriod = In_PeriodStartPRPeriod,
      PeriodStartPRMonth = In_PeriodStartPRMonth,
      PayGroupDesc = In_PayGroupDesc,
      PayBalLastSubPeriod = In_PayBalLastSubPeriod,
      PayBankAllocGpId = In_PayBankAllocGpId,
      PaymentExRateId = In_PaymentExRateId where
      PayGroupId = In_PayGroupId;
    commit work
  end if
end
;

create procedure dba.UpdatePayGroupPeriod(
in In_PayGroupId char(20),
in In_PayGroupYear integer,
in In_PayGroupPeriod integer,
in In_PayGroupSubPeriod integer,
in In_SubPeriodStatus char(20),
in In_SubPeriodStartDate date,
in In_SubPeriodEndDate date)
begin
  if exists(select* from PayGroupPeriod where
      PayGroupPeriod.PayGroupId = In_PayGroupId and
      PayGroupPeriod.PayGroupYear = In_PayGroupYear and
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod and
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod) then
    update PayGroupPeriod set
      PayGroupPeriod.PayGroupId = In_PayGroupId,
      PayGroupPeriod.PayGroupYear = In_PayGroupYear,
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod,
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod,
      PayGroupPeriod.SubPeriodStatus = In_SubPeriodStatus,
      PayGroupPeriod.SubPeriodStartDate = In_SubPeriodStartDate,
      PayGroupPeriod.SubPeriodEndDate = In_SubPeriodEndDate where
      PayGroupPeriod.PayGroupId = In_PayGroupId and
      PayGroupPeriod.PayGroupYear = In_PayGroupYear and
      PayGroupPeriod.PayGroupPeriod = In_PayGroupPeriod and
      PayGroupPeriod.PayGroupSubPeriod = In_PayGroupSubPeriod;
    commit work
  end if
end
;

create procedure dba.UpdatePayLeaveSetting(
in In_EmployeeSysId integer,
in In_PayLeaveTypeId char(20),
in In_LveAutoOption integer,
in In_LveDayRateId char(20),
in In_LveHourRateId char(20))
begin
  if exists(select* from PayLeaveSetting where PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and
      PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId) then
    update PayLeaveSetting set
      LveAutoOption = In_LveAutoOption,
      LveDayRateId = In_LveDayRateId,
      LveHourRateId = In_LveHourRateId where
      PayLeaveSetting.EmployeeSysId = In_EmployeeSysId and PayLeaveSetting.PayLeaveTypeId = In_PayLeaveTypeId;
    commit work
  end if
end
;

create procedure dba.UpdatePayPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PaySectionId char(20),
in In_PayCostCenterId char(20),
in In_PayCategoryId char(20),
in In_PayDepartmentId char(20),
in In_PayBranchId char(20),
in In_PayPositionId char(20),
in In_PayPayGroupId char(20),
in In_PayWorkCalendarId char(20),
in In_PayLeaveGroupId char(20),
in In_PaySalaryGradeId char(20),
in In_PayClassificationCode char(20),
in In_PayWTCalendarId char(20),
in In_PayEmpCode1Id char(20),
in In_PayEmpCode2Id char(20),
in In_PayEmpCode3Id char(20),
in In_PayEmpCode4Id char(20),
in In_PayEmpCode5Id char(20))
begin
  if exists(select* from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod) then
    update PayPeriodRecord set
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PaySectionId = In_PaySectionId,
      PayCostCenterId = In_PayCostCenterId,
      PayCategoryId = In_PayCategoryId,
      PayDepartmentId = In_PayDepartmentId,
      PayBranchId = In_PayBranchId,
      PayPositionId = In_PayPositionId,
      PayPayGroupId = In_PayPayGroupId,
      PayWorkCalendarId = In_PayWorkCalendarId,
      PayLeaveGroupId = In_PayLeaveGroupId,
      PaySalaryGradeId = In_PaySalaryGradeId,
      PayClassification = In_PayClassificationCode,
      PayWTCalendarId = In_PayWTCalendarId,
      PayEmpCode1Id = In_PayEmpCode1Id,
      PayEmpCode2Id = In_PayEmpCode2Id,
      PayEmpCode3Id = In_PayEmpCode3Id,
      PayEmpCode4Id = In_PayEmpCode4Id,
      PayEmpCode5Id = In_PayEmpCode5Id where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    commit work
  end if
end
;

create procedure dba.UpdatePayRecord(
in In_PayRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PayRecType char(20),
in In_Status char(20),
in In_CreatedBy char(1),
in In_LastProcessed timestamp,
in In_PayDesc char(100),
in In_PayInterfaceProjectId char(100))
begin
  if exists(select* from PayRecord where
      PayRecord.PayRecSGSPGenId = In_PayRecSGSPGenId) then
    update PayRecord set
      PayRecSGSPGenId = In_PayRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      PayRecType = In_PayRecType,
      Status = In_Status,
      CreatedBy = In_CreatedBy,
      LastProcessed = In_LastProcessed,
      PayInterfaceProjectId = In_PayInterfaceProjectId,
      PayDesc = In_PayDesc where
      PayRecord.PayRecSGSPGenId = In_PayRecSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdatePeriodEEHistory(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PaySectionId char(20),
in In_PayCostCenterId char(20),
in In_PayCategoryId char(20),
in In_PayDepartmentId char(20),
in In_PayBranchId char(20),
in In_PayPositionId char(20),
in In_PayPayGroupId char(20),
in In_PayWorkCalendarId char(20))
begin
  if exists(select* from PeriodEEHistory where
      PeriodEEHistory.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodEEHistory.EmployeeSysId = In_EmployeeSysId) then
    update PeriodEEHistory set
      EmployeeSysId = In_EmployeeSysId,
      PayPeriodSGSPGenId = In_PayPeriodSGSPGenId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PaySectionId = In_PaySectionId,
      PayCostCenterId = In_PayCostCenterId,
      PayCategoryId = In_PayCategoryId,
      PayDepartmentId = In_PayDepartmentId,
      PayBranchId = In_PayBranchId,
      PayPositionId = In_PayPositionId,
      PayPayGroupId = In_PayPayGroupId,
      PayWorkCalendarId = In_PayWorkCalendarId where
      PeriodEEHistory.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodEEHistory.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePeriodMessage(
in In_PayGroupId char(20),
in In_PeriodId integer,
in In_PeriodIdType char(20),
in In_PeriodLongMessage char(20),
in In_PeriodShortMessage char(5),
in In_PeriodMonth char(20))
begin
  if exists(select* from PeriodMessage where
      PeriodMessage.PayGroupId = In_PayGroupId and
      PeriodMessage.PeriodId = In_PeriodId and
      PeriodMessage.PeriodIdType = In_PeriodIdType) then
    update PeriodMessage set
      PeriodLongMessage = In_PeriodLongMessage,
      PeriodShortMessage = In_PeriodShortMessage,
      PeriodMonth = In_PeriodMonth where
      PeriodMessage.PayGroupId = In_PayGroupId and
      PeriodMessage.PeriodId = In_PeriodId and
      PeriodMessage.PeriodIdType = In_PeriodIdType;
    commit work
  end if
end
;

create procedure dba.UpdatePeriodPolicySetting(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CPFAge integer,
in In_MAWLimit double,
in In_MAWOption integer,
in In_EECPFTable char(20),
in In_EECPFCurFormulaId char(20),
in In_EECPFPrevFormulaId char(20),
in In_ERCPFCurFormulaId char(20),
in In_ERCPFPrevFormulaId char(20),
in In_FWLFormulaId char(20),
in In_SDFFormulaId char(20),
in In_MediSaveAddFormulaId char(20),
in In_MediSaveOrdFormulaId char(20))
begin
  if exists(select* from PeriodPolicySetting where
      PeriodPolicySetting.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySetting.EmployeeSysId = In_EmployeeSysId) then
    update PeriodPolicySetting set
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      CPFAge = In_CPFAge,
      MAWLimit = In_MAWLimit,
      MAWOption = In_MAWOption,
      EECPFTable = In_EECPFTable,
      EECPFCurFormulaId = In_EECPFCurFormulaId,
      EECPFPrevFormulaId = In_EECPFPrevFormulaId,
      ERCPFCurFormulaId = In_ERCPFCurFormulaId,
      ERCPFPrevFormulaId = In_ERCPFPrevFormulaId,
      FWLFormulaId = In_FWLFormulaId,
      SDFFormulaId = In_SDFFormulaId,
      MediSaveAddFormulaId = In_MediSaveAddFormulaId,
      MediSaveOrdFormulaId = In_MediSaveOrdFormulaId where
      PeriodPolicySetting.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySetting.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure DBA.UpdatePolicyProgression(
in In_EmployeeSysId integer,
in In_BRProgDate date,
in In_NWCPrevRate double,
in In_NWCIncrementAmt double,
in In_NWCPercentage double,
in In_NWCNewRate double,
in In_MVCPrevRate double,
in In_MVCIncrementAmt double,
in In_MVCPercentage double,
in In_MVCNewRate double)
begin
  if exists(select* from PolicyProgression where PolicyProgression.EmployeeSysId = In_EmployeeSysId and PolicyProgression.BRProgDate = In_BRProgDate) then
    update PolicyProgression set
      PolicyProgression.EmployeeSysId = In_EmployeeSysId,
      PolicyProgression.BRProgDate = In_BRProgDate,
      PolicyProgression.NWCPrevRate = In_NWCPrevRate,
      PolicyProgression.NWCIncrementAmt = In_NWCIncrementAmt,
      PolicyProgression.NWCPercentage = In_NWCPercentage,
      PolicyProgression.NWCNewRate = In_NWCNewRate,
      PolicyProgression.MVCPrevRate = In_MVCPrevRate,
      PolicyProgression.MVCIncrementAmt = In_MVCIncrementAmt,
      PolicyProgression.MVCPercentage = In_MVCPercentage,
      PolicyProgression.MVCNewRate = In_MVCNewRate where
      PolicyProgression.EmployeeSysId = In_EmployeeSysId and PolicyProgression.BRProgDate = In_BRProgDate;
    commit work
  end if
end
;

create procedure dba.UpdatePolicyRecord(
in In_PolicyRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentMVC double,
in In_CurrentNWC double,
in In_PreviousMVC double,
in In_PreviousNWC double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_CPFWage double,
in In_CPFPaymentOption smallint,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_AllocatedNWC double,
in In_AllocatedMVC double,
in In_CurNWCHrDaysRate double,
in In_CurMVCHrDaysRate double,
in In_PrevNWCHrDaysRate double,
in In_PrevMVCHrDaysRate double,
in In_CurBackPayNWC double,
in In_PrevBackPayNWC double,
in In_CurBackPayMVC double,
in In_PrevBackPayMVC double,
in In_MVCCapping double,
in In_CurrEEManContri double,
in In_CurrERManContri double,
in In_PrevEEManContri double,
in In_PrevERManContri double,
in In_CurrEEVolContri double,
in In_CurrERVolContri double,
in In_PrevEEVolContri double,
in In_PrevERVolContri double,
in In_CurrEEManWage double,
in In_CurrERManWage double,
in In_PrevEEManWage double,
in In_PrevERManWage double,
in In_CurrEEVolWage double,
in In_CurrERVolWage double,
in In_PrevEEVolWage double,
in In_PrevERVolWage double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double,
in In_CurrentNWCF double,
in In_CurrentMVCF double,
in In_PreviousNWCF double,
in In_PreviousMVCF double,
in In_AllocatedNWCF double,
in In_AllocatedMVCF double,
in In_CurBackPayNWCF double,
in In_PrevBackPayNWCF double,
in In_CurBackPayMVCF double,
in In_PrevBackPayMVCF double)
begin
  if exists(select* from PolicyRecord where
      PolicyRecord.PolicyRecSGSPGenId = In_PolicyRecSGSPGenId) then
    update PolicyRecord set
      PolicyRecSGSPGenId = In_PolicyRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      CurrentMVC = In_CurrentMVC,
      CurrentNWC = In_CurrentNWC,
      PreviousMVC = In_PreviousMVC,
      PreviousNWC = In_PreviousNWC,
      CurOrdinaryWage = In_CurOrdinaryWage,
      CurAdditionalWage = In_CurAdditionalWage,
      PrevOrdinaryWage = In_PrevOrdinaryWage,
      PrevAdditionalWage = In_PrevAdditionalWage,
      ContriOrdEECPF = In_ContriOrdEECPF,
      ContriAddEECPF = In_ContriAddEECPF,
      ContriOrdERCPF = In_ContriOrdERCPF,
      ContriAddERCPF = In_ContriAddERCPF,
      CPFWage = In_CPFWage,
      CPFPaymentOption = In_CPFPaymentOption,
      TotalContriEECPF = In_TotalContriEECPF,
      TotalContriERCPF = In_TotalContriERCPF,
      AllocatedNWC = In_AllocatedNWC,
      AllocatedMVC = In_AllocatedMVC,
      CurNWCHrDaysRate = In_CurNWCHrDaysRate,
      CurMVCHrDaysRate = In_CurMVCHrDaysRate,
      PrevNWCHrDaysRate = In_PrevNWCHrDaysRate,
      PrevMVCHrDaysRate = In_PrevMVCHrDaysRate,
      CurBackPayNWC = In_CurBackPayNWC,
      PrevBackPayNWC = In_PrevBackPayNWC,
      CurBackPayMVC = In_CurBackPayMVC,
      PrevBackPayMVC = In_PrevBackPayMVC,
      MVCCapping = In_MVCCapping,
      CurrEEManContri = In_CurrEEManContri,
      CurrERManContri = In_CurrERManContri,
      PrevEEManContri = In_PrevEEManContri,
      PrevERManContri = In_PrevERManContri,
      CurrEEVolContri = In_CurrEEVolContri,
      CurrERVolContri = In_CurrERVolContri,
      PrevEEVolContri = In_PrevEEVolContri,
      PrevERVolContri = In_PrevERVolContri,
      CurrEEManWage = In_CurrEEManWage,
      CurrERManWage = In_CurrERManWage,
      PrevEEManWage = In_PrevEEManWage,
      PrevERManWage = In_PrevERManWage,
      CurrEEVolWage = In_CurrEEVolWage,
      CurrERVolWage = In_CurrERVolWage,
      PrevEEVolWage = In_PrevEEVolWage,
      PrevERVolWage = In_PrevERVolWage,
      CurrentTaxWage = In_CurrentTaxWage,
      PreviousTaxWage = In_PreviousTaxWage,
      CurrentAddTaxWage = In_CurrentAddTaxWage,
      PreviousAddTaxWage = In_PreviousAddTaxWage,
      CurrentTaxAmount = In_CurrentTaxAmount,
      PreviousTaxAmount = In_PreviousTaxAmount,
      PaidCurrentTaxAmt = In_PaidCurrentTaxAmt,
      PaidPreviousTaxAmt = In_PaidPreviousTaxAmt,
      TaxBenefit = In_TaxBenefit,
      CurrentNWCF = In_CurrentNWCF,
      CurrentMVCF = In_CurrentMVCF,
      PreviousNWCF = In_PreviousNWCF,
      PreviousMVCF = In_PreviousMVCF,
      AllocatedNWCF = In_AllocatedNWCF,
      AllocatedMVCF = In_AllocatedMVCF,
      CurBackPayNWCF = In_CurBackPayNWCF,
      PrevBackPayNWCF = In_PrevBackPayNWCF,
      CurBackPayMVCF = In_CurBackPayMVCF,
      PrevBackPayMVCF = In_PrevBackPayMVCF where
      PolicyRecord.PolicyRecSGSPGenId = In_PolicyRecSGSPGenId;
    commit work
  end if
end
;

create procedure DBA.UpdateRegistry(
in In_RegistryId char(20),
in In_RegistryDesc char(100))
begin
  if exists(select* from Registry where Registry.RegistryId = In_RegistryId) then
    update Registry set
      Registry.RegistryDesc = In_RegistryDesc where
      Registry.RegistryId = In_RegistryId;
    commit work
  end if
end
;

create procedure dba.UpdateSDFProgression(
in In_SDFEffectiveDate date,
in In_SDFFormulaID char(20),
in In_SDFRemarks char(255),
in In_SDFCurrent smallint)
begin
  if exists(select* from SDFProgression where
      SDFProgression.SDFEffectiveDate = In_SDFEffectiveDate) then
    update SDFProgression set
      SDFProgression.SDFFormulaID = In_SDFFormulaID,
      SDFProgression.SDFRemarks = In_SDFRemarks,
      SDFProgression.SDFCurrent = In_SDFCurrent where
      SDFProgression.SDFEffectiveDate = In_SDFEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateShift(
in In_ShiftTableId char(20),
in In_ShiftTableDesc char(100),
in In_ShiftAveragePeriod integer)
begin
  if exists(select* from Shift where Shift.ShiftTableId = In_ShiftTableId) then
    update Shift set
      Shift.ShiftTableDesc = In_ShiftTableDesc,
      Shift.ShiftAveragePeriod = In_ShiftAveragePeriod where
      Shift.ShiftTableId = In_ShiftTableId;
    commit work
  end if
end
;

create procedure dba.UpdateShiftRecord(
in In_ShiftFormulaSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_ShiftFormulaId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_ShiftRate double,
in In_ShiftFrequency double,
in In_ShiftAmount double,
in In_ShiftCreatedBy char(20),
in In_ShiftAmountF double,
in In_ShiftExRateId char(20),
in In_ShiftExRate double)
begin
  if exists(select* from ShiftRecord where
      ShiftRecord.ShiftFormulaSGSPGenId = In_ShiftFormulaSGSPGenId) then
    update ShiftRecord set
      EmployeeSysId = In_EmployeeSysId,
      ShiftFormulaId = In_ShiftFormulaId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      ShiftRate = In_ShiftRate,
      ShiftFrequency = In_ShiftFrequency,
      ShiftAmount = In_ShiftAmount,
      ShiftCreatedBy = In_ShiftCreatedBy,
      ShiftAmountF = In_ShiftAmountF,
      ShiftExRateId = In_ShiftExRateId,
      ShiftExRate = In_ShiftExRate where
      ShiftRecord.ShiftFormulaSGSPGenId = In_ShiftFormulaSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdateSubPeriodRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_SubPeriodStatus char(20),
in In_SubPeriodStartDate date,
in In_SubPeriodEndDate date,
in In_PaySuspense smallint)
begin
  if exists(select* from SubPeriodRecord where
      SubPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      SubPeriodRecord.PayRecYear = In_PayRecYear and
      SubPeriodRecord.PayRecPeriod = In_PayRecPeriod and
      SubPeriodRecord.PayRecSubPeriod = In_PayRecSubPeriod) then
    update SubPeriodRecord set
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      SubPeriodStatus = In_SubPeriodStatus,
      SubPeriodStartDate = In_SubPeriodStartDate,
      SubPeriodEndDate = In_SubPeriodEndDate,
      PaySuspense = In_PaySuspense where
      SubPeriodRecord.EmployeeSysId = In_EmployeeSysId and
      SubPeriodRecord.PayRecYear = In_PayRecYear and
      SubPeriodRecord.PayRecPeriod = In_PayRecPeriod and
      SubPeriodRecord.PayRecSubPeriod = In_PayRecSubPeriod;
    commit work
  end if
end
;

create procedure dba.UpdateSubPeriodSetting(
in In_EmployeeSysId integer,
in In_PaySubPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_OTDayRateId char(20),
in In_OTHourRateId char(20),
in In_CurrentOTDayRateAmt double,
in In_CurrentOTHourRateAmt double,
in In_LastOTDayRateAmt double,
in In_LastOTHourRateAmt double,
in In_EEOTTableId char(20),
in In_EEShiftTableId char(20),
in In_LateInformation smallint,
in In_AbsentInformation smallint,
in In_BRPDayRateId char(20),
in In_BRPHourRateId char(20),
in In_BRPDayRateAmt double,
in In_BRPHourRateAmt double,
in In_GRPDayRateId char(20),
in In_GRPHourRateId char(20),
in In_GRPDayRateAmt double,
in In_GRPHourRateAmt double)
begin
  if exists(select* from SubPeriodSetting where
      SubPeriodSetting.PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId and
      SubPeriodSetting.EmployeeSysId = In_EmployeeSysId) then
    update SubPeriodSetting set
      EmployeeSysId = In_EmployeeSysId,
      PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      OTDayRateId = In_OTDayRateId,
      OTHourRateId = In_OTHourRateId,
      CurrentOTDayRateAmt = In_CurrentOTDayRateAmt,
      CurrentOTHourRateAmt = In_CurrentOTHourRateAmt,
      LastOTDayRateAmt = In_LastOTDayRateAmt,
      LastOTHourRateAmt = In_LastOTHourRateAmt,
      EEOTTableId = In_EEOTTableId,
      EEShiftTableId = In_EEShiftTableId,
      LateInformation = In_LateInformation,
      AbsentInformation = In_AbsentInformation,
      BRPDayRateId = In_BRPDayRateId,
      BRPHourRateId = In_BRPHourRateId,
      BRPDayRateAmt = In_BRPDayRateAmt,
      BRPHourRateAmt = In_BRPHourRateAmt,
      GRPDayRateId = In_GRPDayRateId,
      GRPHourRateId = In_GRPHourRateId,
      GRPDayRateAmt = In_GRPDayRateAmt,
      GRPHourRateAmt = In_GRPHourRateAmt where
      SubPeriodSetting.PaySubPeriodSGSPGenId = In_PaySubPeriodSGSPGenId and
      SubPeriodSetting.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdateSubPeriodTemplate(
in In_PayGroupId char(20),
in In_SubPeriod integer,
in In_StartDay char(20),
in In_StartMonth char(20),
in In_EndDay char(20),
in In_EndMonth char(20))
begin
  if exists(select* from SubPeriodTemplate where SubPeriodTemplate.PayGroupId = In_PayGroupId and
      SubPeriodTemplate.SubPeriod = In_SubPeriod) then
    update SubPeriodTemplate set
      SubPeriodTemplate.PayGroupId = In_PayGroupId,
      SubPeriodTemplate.SubPeriod = In_SubPeriod,
      SubPeriodTemplate.StartDay = In_StartDay,
      SubPeriodTemplate.StartMonth = In_StartMonth,
      SubPeriodTemplate.EndDay = In_EndDay,
      SubPeriodTemplate.EndMonth = In_EndMonth where
      SubPeriodTemplate.PayGroupId = In_PayGroupId and
      SubPeriodTemplate.SubPeriod = In_SubPeriod;
    commit work
  end if
end
;

create procedure DBA.UpdateSubRegistry(
in In_RegistryId char(20),
in In_SubRegistryId char(20),
in In_RegProperty1 char(100),
in In_RegProperty2 char(100),
in In_RegProperty3 char(100),
in In_RegProperty4 char(100),
in In_RegProperty5 char(100),
in In_RegProperty6 char(200),
in In_RegProperty7 char(200),
in In_RegProperty8 char(200),
in In_RegProperty9 char(200),
in In_RegProperty10 char(200),
in In_DoubleAttr double,
in In_IntegerAttr integer,
in In_CharAttr char(1),
in In_BooleanAttr smallint,
in In_ShortStringAttr char(20),
in In_StringAttr char(255),
in In_DateAttr date,
in In_DateTimeAttr timestamp)
begin
  if exists(select* from SubRegistry where SubRegistry.RegistryId = In_RegistryId and
      SubRegistry.SubRegistryId = In_SubRegistryId) then
    update SubRegistry set
      SubRegistry.RegProperty1 = In_RegProperty1,
      SubRegistry.RegProperty2 = In_RegProperty2,
      SubRegistry.RegProperty3 = In_RegProperty3,
      SubRegistry.RegProperty4 = In_RegProperty4,
      SubRegistry.RegProperty5 = In_RegProperty5,
      SubRegistry.RegProperty6 = In_RegProperty6,
      SubRegistry.RegProperty7 = In_RegProperty7,
      SubRegistry.RegProperty8 = In_RegProperty8,
      SubRegistry.RegProperty9 = In_RegProperty9,
      SubRegistry.RegProperty10 = In_RegProperty10,
      SubRegistry.DoubleAttr = In_DoubleAttr,
      SubRegistry.IntegerAttr = In_IntegerAttr,
      SubRegistry.CharAttr = In_CharAttr,
      SubRegistry.BooleanAttr = In_BooleanAttr,
      SubRegistry.ShortStringAttr = In_ShortStringAttr,
      SubRegistry.StringAttr = In_StringAttr,
      SubRegistry.DateAttr = In_DateAttr,
      SubRegistry.DateTimeAttr = In_DateTimeAttr where
      SubRegistry.RegistryId = In_RegistryId and
      SubRegistry.SubRegistryId = In_SubRegistryId;
    commit work
  end if
end
;

create procedure dba.UpdateWageProperty(
in In_KeyWordId char(20),
in In_WageId char(20),
in In_NewWageId char(20),
in In_WagePropertyUsed integer)
begin
  if exists(select* from WageProperty where
      WageProperty.KeyWordId = In_KeyWordId and
      WageProperty.WageId = In_WageId) then
    if not exists(select* from WageProperty where
        WageProperty.KeyWordId = In_KeyWordId and
        WageProperty.WageId = In_NewWageId) then
      update WageProperty set
        WageProperty.WageId = In_NewWageId,
        WageProperty.WagePropertyUsed = In_WagePropertyUsed where
        WageProperty.KeyWordId = In_KeyWordId and
        WageProperty.WageId = In_WageId;
      commit work
    end if
  end if
end
;

create procedure dba.UpdateBankSubmitFormat(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankSubmitFormat where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    update BankSubmitFormat set
      BooleanField1 = In_BooleanField1,
      BooleanField2 = In_BooleanField2,
      BooleanField3 = In_BooleanField3,
      IntegerField1 = In_IntegerField1,
      IntegerField2 = In_IntegerField2,
      IntegerField3 = In_IntegerField3,
      NumericField1 = In_NumericField1,
      NumericField2 = In_NumericField2,
      NumericField3 = In_NumericField3,
      DateField1 = In_DateField1,
      DateField2 = In_DateField2,
      DateField3 = In_DateField3,
      StringField1 = In_StringField1,
      StringField2 = In_StringField2,
      StringField3 = In_StringField3,
      StringField4 = In_StringField4,
      StringField5 = In_StringField5,
      StringField6 = In_StringField6,
      StringField7 = In_StringField7,
      StringField8 = In_StringField8,
      StringField9 = In_StringField9,
      StringField10 = In_StringField10,
      StringField11 = In_StringField11,
      StringField12 = In_StringField12,
      StringField13 = In_StringField13,
      StringField14 = In_StringField14,
      StringField15 = In_StringField15,
      StringField16 = In_StringField16,
      StringField17 = In_StringField17,
      StringField18 = In_StringField18,
      StringField19 = In_StringField19,
      StringField20 = In_StringField20 where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and
      FormatName = In_FormatName;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create function DBA.FGetFormulaConstant1(
in In_FormulaID char(20),
in In_FormulaRangeID integer)
returns double
begin
  declare fresult double;
  select Constant1 into fresult from FormulaRange where FormulaID = In_FormulaID and FormulaRangeID = In_FormulaRangeID;
  return(fresult)
end
;

create function DBA.FGetPeriodToMonthYear(
in In_PayGroupId char(20),
in In_Period integer,
in In_Year integer)
returns integer
begin
  declare Out_RefPeriod integer;
  declare Out_PhyYear integer;
  set Out_RefPeriod=FGetPayrollPeriodGivenPhyYrMth(In_PayGroupId,0,1);
  if In_Period >= Out_RefPeriod and Out_RefPeriod <> 1 then
    set Out_PhyYear=In_Year+1
  else
    set Out_PhyYear=In_Year
  end if;
  return(Out_PhyYear)
end
;

create function dba.FGetFamilyAddress(
in In_PersonalSysId integer,
in In_RelationshipId char(20))
returns char(140)
begin
  declare Out_ContactAddress char(140);
  declare replacePos integer;
  select ContactAddress into Out_ContactAddress from Family where
    PersonalSysId = In_PersonalSysId and RelationshipId = In_RelationshipId;
  replaceLineBreaks:
  while((charindex("char"(10),Out_ContactAddress)) > 0) or(charindex("char"(13),Out_ContactAddress) > 0) loop
    set replacePos=charindex("char"(10),Out_ContactAddress);
    set Out_ContactAddress=stuff(Out_ContactAddress,replacePos,1,' ');
    set replacePos=charindex("char"(13),Out_ContactAddress);
    set Out_ContactAddress=stuff(Out_ContactAddress,replacePos,1,' ')
  end loop replaceLineBreaks;
  return(Out_ContactAddress)
end
;

create procedure dba.UpdatePeriodPolicySummary(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CalFWL double,
in In_CalSDF double,
in In_ContriFWL double,
in In_ContriSDF double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_VolOrdEECPF double,
in In_VolOrdERCPF double,
in In_VolAddEECPF double,
in In_VolAddERCPF double,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_CPFWage double,
in In_SDFWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_TotalCDAC double,
in In_TotalSINDA double,
in In_TotalEUCF double,
in In_TotalMBMF double,
in In_TotalComm double,
in In_TotalMOSQ double,
in In_TotalYMF double,
in In_MediSaveOrdinary double,
in In_MediSaveAdditional double,
in In_CPFClass char(20),
in In_CPFStatus char(20),
in In_SupIR8ACurOrdWage double,
in In_SupIR8ACurAddWage double,
in In_SupIR8APrevOrdWage double,
in In_SupIR8APrevAddWage double,
in In_SupIR8ACPFWage double,
in In_SupIR8AOrdEECPF double,
in In_SupIR8AAddEECPF double,
in In_SupIR8AOrdERCPF double,
in In_SupIR8AAddERCPF double,
in In_SupIR8AActOrdEECPF double,
in In_SupIR8AActAddEECPF double,
in In_SupIR8AActOrdERCPF double,
in In_SupIR8AActAddERCPF double,
in In_SupIR8AEECPF double,
in In_SupIR8AERCPF double,
in In_CompanyAddEECPF double,
in In_CompanyAddERCPF double,
in In_MAWContriCurAddWage double,
in In_MAWContriPrevAddWage double,
in In_MAWContriLimit double,
in In_MAWContriPOrdWage double,
in In_MAWContriOption double,
in In_MAWBalCurAddWage double,
in In_MAWBalPrevAddWage double,
in In_MAWBalLimit double,
in In_MAWBalPOrdWage double,
in In_MAWBalOption integer,
in In_TaxCategory char(20),
in In_TaxMaritalStatus char(20),
in In_TaxChildRelief double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_TaxEPFRelief double,
in In_TaxZakatRelief double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double)
begin
  if exists(select* from PeriodPolicySummary where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId) then
    update PeriodPolicySummary set
      EmployeeSysId = In_EmployeeSysId,
      PayPeriodSGSPGenId = In_PayPeriodSGSPGenId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      CalFWL = In_CalFWL,
      CalSDF = In_CalSDF,
      ContriFWL = In_ContriFWL,
      ContriSDF = In_ContriSDF,
      CurOrdinaryWage = In_CurOrdinaryWage,
      CurAdditionalWage = In_CurAdditionalWage,
      PrevOrdinaryWage = In_PrevOrdinaryWage,
      PrevAdditionalWage = In_PrevAdditionalWage,
      ContriOrdEECPF = In_ContriOrdEECPF,
      ContriAddEECPF = In_ContriAddEECPF,
      ContriOrdERCPF = In_ContriOrdERCPF,
      ContriAddERCPF = In_ContriAddERCPF,
      ActualOrdEECPF = In_ActualOrdEECPF,
      ActualOrdERCPF = In_ActualOrdERCPF,
      ActualAddEECPF = In_ActualAddEECPF,
      ActualAddERCPF = In_ActualAddERCPF,
      VolOrdEECPF = In_VolOrdEECPF,
      VolOrdERCPF = In_VolOrdERCPF,
      VolAddEECPF = In_VolAddEECPF,
      VolAddERCPF = In_VolAddERCPF,
      TotalContriEECPF = In_TotalContriEECPF,
      TotalContriERCPF = In_TotalContriERCPF,
      CPFWage = In_CPFWage,
      SDFWage = In_SDFWage,
      OverseasEECPF = In_OverseasEECPF,
      OverseasERCPF = In_OverseasERCPF,
      TotalCDAC = In_TotalCDAC,
      TotalSINDA = In_TotalSINDA,
      TotalEUCF = In_TotalEUCF,
      TotalMBMF = In_TotalMBMF,
      TotalComm = In_TotalComm,
      TotalMOSQ = In_TotalMOSQ,
      TotalYMF = In_TotalYMF,
      MediSaveOrdinary = In_MediSaveOrdinary,
      MediSaveAdditional = In_MediSaveAdditional,
      CPFClass = In_CPFClass,
      CPFStatus = In_CPFStatus,
      SupIR8ACurOrdWage = In_SupIR8ACurOrdWage,
      SupIR8ACurAddWage = In_SupIR8ACurAddWage,
      SupIR8APrevOrdWage = In_SupIR8APrevOrdWage,
      SupIR8APrevAddWage = In_SupIR8APrevAddWage,
      SupIR8ACPFWage = In_SupIR8ACPFWage,
      SupIR8AOrdEECPF = In_SupIR8AOrdEECPF,
      SupIR8AAddEECPF = In_SupIR8AAddEECPF,
      SupIR8AOrdERCPF = In_SupIR8AOrdERCPF,
      SupIR8AAddERCPF = In_SupIR8AAddERCPF,
      SupIR8AActOrdEECPF = In_SupIR8AActOrdEECPF,
      SupIR8AActAddEECPF = In_SupIR8AActAddEECPF,
      SupIR8AActOrdERCPF = In_SupIR8AActOrdERCPF,
      SupIR8AActAddERCPF = In_SupIR8AActAddERCPF,
      SupIR8AEECPF = In_SupIR8AEECPF,
      SupIR8AERCPF = In_SupIR8AERCPF,
      CompanyAddEECPF = In_CompanyAddEECPF,
      CompanyAddERCPF = In_CompanyAddERCPF,
      MAWContriCurAddWage = In_MAWContriCurAddWage,
      MAWContriPrevAddWage = In_MAWContriPrevAddWage,
      MAWContriLimit = In_MAWContriLimit,
      MAWContriPOrdWage = In_MAWContriPOrdWage,
      MAWContriOption = In_MAWContriOption,
      MAWBalCurAddWage = In_MAWBalCurAddWage,
      MAWBalPrevAddWage = In_MAWBalPrevAddWage,
      MAWBalLimit = In_MAWBalLimit,
      MAWBalPOrdWage = In_MAWBalPOrdWage,
      MAWBalOption = In_MAWBalOption,
      TaxCategory = In_TaxCategory,
      TaxMaritalStatus = In_TaxMaritalStatus,
      TaxChildRelief = In_TaxChildRelief,
      CurrentTaxWage = In_CurrentTaxWage,
      PreviousTaxWage = In_PreviousTaxWage,
      CurrentAddTaxWage = In_CurrentAddTaxWage,
      PreviousAddTaxWage = In_PreviousAddTaxWage,
      CurrentTaxAmount = In_CurrentTaxAmount,
      PreviousTaxAmount = In_PreviousTaxAmount,
      TaxEPFRelief = In_TaxEPFRelief,
      TaxZakatRelief = In_TaxZakatRelief,
      PaidCurrentTaxAmt = In_PaidCurrentTaxAmt,
      PaidPreviousTaxAmt = In_PaidPreviousTaxAmt,
      TaxBenefit = In_TaxBenefit where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create function dba.FGetCostCentreDesc(
in In_CostCentreId char(20))
returns char(100)
begin
  declare Out_CostCentreDesc char(100);
  select CostCentre.CostCentreDesc into Out_CostCentreDesc
    from CostCentre where
    CostCentre.CostCentreId = In_CostCentreId;
  if(Out_CostCentreDesc is null or Out_CostCentreDesc = '') then
    return(In_CostCentreId)
  else return(Out_CostCentreDesc)
  end if
end
;

create function DBA.FGetPeriodDepartment(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(20)
begin
  declare Department_ID char(20);
  select FGetDepartmentDesc(PayDepartmentID) into Department_ID
    from PayPeriodRecord where
    EmployeeSysID = In_EmployeeSysID and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Department_ID is null then set Department_ID=''
  end if;
  return Department_ID
end
;

create procedure dba.DeleteMandatoryContributeProg(
in In_MandContriSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MandatoryContributeProg where MandContriSysId = In_MandContriSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from MandatoryContributeProg where MandContriSysId = In_MandContriSysId;
    commit work
  end if;
  if exists(select* from MandatoryContributeProg where MandContriSysId = In_MandContriSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create function DBA.FGetPeriodEndDate(
in In_PayGroupId char(20),
in In_Year integer,
in In_Period integer)
returns date
begin
  declare Out_EndDate date;
  select first SubPeriodEndDate into Out_EndDate from
    PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = In_Year and
    PayGroupPeriod = In_Period order by
    SubPeriodEndDate desc;
  return Out_EndDate
end
;

create function DBA.FGetPeriodStartDate(
in In_PayGroupId char(20),
in In_Year integer,
in In_Period integer)
returns date
begin
  declare Out_StartDate date;
  select first SubPeriodStartDate into Out_StartDate from
    PayGroupPeriod where
    PayGroupId = In_PayGroupId and
    PayGroupYear = In_Year and
    PayGroupPeriod = In_Period order by
    SubPeriodStartDate asc;
  return Out_StartDate
end
;

create procedure dba.InsertNewMandatoryContributeProg(
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
out Out_ErrorCode integer)
begin
  declare Out_MandContriSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-2; // MandContriPolicyId not exist
    return
  elseif not In_MandContriCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-4; // MandContriCareerId not exist
    return
  elseif not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme') then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-3; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-3; // MandContriSchemeId not exist
      return
    end if
  end if;
  insert into MandatoryContributeProg(EmployeeSysId,MandContriCareerId,MandContriEffDate,MandContriPolicyId,MandContriSchemeId,MandContriRemarks,MandContriCurrent) values(
    In_EmployeeSysId,In_MandContriCareerId,In_MandContriEffDate,In_MandContriPolicyId,In_MandContriSchemeId,In_MandContriRemarks,In_MandContriCurrent);
  commit work;
  if
    not exists(select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent) then
    set Out_ErrorCode=0; // System error
    return
  else
    select MandContriSysId into Out_MandContriSysId from MandatoryContributeProg where
      EmployeeSysId = In_EmployeeSysId and
      MandContriCareerId = In_MandContriCareerId and
      MandContriEffDate = In_MandContriEffDate and
      MandContriPolicyId = In_MandContriPolicyId and
      MandContriSchemeId = In_MandContriSchemeId and
      MandContriRemarks = In_MandContriRemarks and
      MandContriCurrent = In_MandContriCurrent;
    // mark current if this is the first record for that particular scheme
    if(select count(*) from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriSchemeId = In_MandContriSchemeId) = 1 then
      update MandatoryContributeProg set
        MandContriCurrent = 1 where
        MandContriSysId = Out_MandContriSysId
    end if;
    set Out_ErrorCode=Out_MandContriSysId // Successful
  end if
end
;

create procedure dba.UpdateMandatoryContributeProg(
in In_MandContriSysId integer,
in In_EmployeeSysId integer,
in In_MandContriCareerId char(20),
in In_MandContriEffDate date,
in In_MandContriPolicyId char(20),
in In_MandContriSchemeId char(20),
in In_MandContriRemarks char(100),
in In_MandContriCurrent smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from MandatoryContributeProg where MandContriSysId = In_MandContriSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_MandContriPolicyId = any(select CPFPolicyId from CPFPolicy) then
    set Out_ErrorCode=-3; // MandContriPolicyId not exist
    return
  elseif not In_MandContriCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-5; // MandContriCareerId not exist
    return
  elseif not In_MandContriSchemeId = any(select KeywordId from Keyword where KeywordCategory = 'CPFScheme') then
    if FGetDBCountry(*) = 'Thailand' then
      if not In_MandContriSchemeId = any(select PFSchemeId from ProvidentFundScheme) then
        set Out_ErrorCode=-4; // MandContriSchemeId not exist
        return
      end if
    else
      set Out_ErrorCode=-4; // MandContriSchemeId not exist
      return
    end if
  end if;
  // if this is current, set other record for this scheme to not current
  if In_MandContriCurrent = 1 then
    update MandatoryContributeProg set
      MandContriCurrent = 0 where
      EmployeeSysId = In_EmployeeSysId and
      MandContriSchemeId = In_MandContriSchemeId
  end if;
  update MandatoryContributeProg set
    EmployeeSysId = In_EmployeeSysId,
    MandContriCareerId = In_MandContriCareerId,
    MandContriEffDate = In_MandContriEffDate,
    MandContriPolicyId = In_MandContriPolicyId,
    MandContriSchemeId = In_MandContriSchemeId,
    MandContriRemarks = In_MandContriRemarks,
    MandContriCurrent = In_MandContriCurrent where
    MandContriSysId = In_MandContriSysId;
  commit work;
  set Out_ErrorCode=In_MandContriSysId // Successful
end
;

create procedure dba.ASQLUpdatePayBasisAnlysKeyword()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  if exists(select* from AnlysKeyword where
      AnlysKeywordId = 'PayEmpCode1Id') then
    update AnlysKeyword set AnlysKeywordDesc = EmpCode1_Id where
      AnlysKeywordId = 'PayEmpCode1Id'
  end if;
  if exists(select* from AnlysKeyword where
      AnlysKeywordId = 'PayEmpCode2Id') then
    update AnlysKeyword set AnlysKeywordDesc = EmpCode2_Id where
      AnlysKeywordId = 'PayEmpCode2Id'
  end if;
  if exists(select* from AnlysKeyword where
      AnlysKeywordId = 'PayEmpCode3Id') then
    update AnlysKeyword set AnlysKeywordDesc = EmpCode3_Id where
      AnlysKeywordId = 'PayEmpCode3Id'
  end if;
  if exists(select* from AnlysKeyword where
      AnlysKeywordId = 'PayEmpCode4Id') then
    update AnlysKeyword set AnlysKeywordDesc = EmpCode4_Id where
      AnlysKeywordId = 'PayEmpCode4Id'
  end if;
  if exists(select* from AnlysKeyword where
      AnlysKeywordId = 'PayEmpCode5Id') then
    update AnlysKeyword set AnlysKeywordDesc = EmpCode5_Id where
      AnlysKeywordId = 'PayEmpCode5Id'
  end if;
  commit work
end
;


create function DBA.FGetRecentEmployeeId(
in In_PersonalSysId integer,
in In_Year integer)
returns char(30)
begin
  declare Out_NoOfEmp integer;
  declare Out_EmployeeId char(30);
  declare Out_Active_HireDate date;
  declare Out_Active_EmployeeSysId integer;
  declare Out_Terminated_EmployeeSysId integer;
  select Count(*) into Out_NoOfEmp from Employee where PersonalSysId = In_PersonalSysId;
  /*
  No Employment
  */
  if(Out_NoOfEmp = 0) then
    return ''
  end if;
  select first EmployeeId into Out_EmployeeId from Employee where PersonalSysId = In_PersonalSysId and
    Year(HireDate) <= In_Year and
    exists(select* from PayPeriodRecord where PayRecYear = In_Year and PayPeriodRecord.EmployeeSysId = Employee.EmployeeSysId) order by
    HireDate desc;
  return Out_EmployeeId
end
;

create procedure dba.PatchInterfaceDetails()
begin
  CreateInterfaceDetailsLoop: for CreateInterfaceDetailsFor as curs dynamic scroll cursor for
    select PersonalSysId as Out_PersonalSysId from Personal do
    if not exists(select* from InterfaceDetails where PersonalSysId = Out_PersonalSysId) then
      insert into InterfaceDetails(PersonalSysId) values(Out_PersonalSysId)
    end if end for;
  commit work
end
;

create function DBA.FGetPeriodTaxBenefit(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare In_CalTaxBenefit double;
  select Sum(TaxBenefit) into In_CalTaxBenefit from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_CalTaxBenefit is null then set In_CalTaxBenefit=0
  end if;
  return In_CalTaxBenefit
end
;

create function dba.FGetPayRecAllStatutoryDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if FGetDBCountry(*) = 'Singapore' then
    select ContriOrdEECPF+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Brunei' then
    select TotalContriEECPF+
      ContriOrdEECPF+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Indonesia' then
    select ContriOrdEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Malaysia' then
    select PrevEEManContri+
      CurrEEManContri+
      PrevEEVolContri+
      CurrEEVolContri+
      ContriOrdEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Philippines' then
    select ContriOrdEECPF+
      CurrEEManContri+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Vietnam' then
    select CurrEEVolContri+
      PrevEEVolContri+
      CurrEEVolWage+
      PrevEEVolWage+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'HongKong' then
    select CurrEEManContri+
      CurrEEVolContri into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Thailand' then
    select ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+
      CurrEEManWage+PrevEEManWage into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  else
    select 0 into TotalAmount
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetUpdatedExchangeRate(
in In_EmployeeSysId integer,
in In_ExRateId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_RateType char(20))
returns double
begin
  declare Out_ExRateForeignLocal double;
  declare Out_ExRateLocalForeign double;
  declare PayGroupID char(20);
  declare SubPEndDate date;
  //get employee pay group ID
  select first PayPayGroupId into PayGroupID from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod order by PayPeriodSGSPGenId;
  //Get Pay group sub period end date
  select first SubPeriodEndDate into SubPEndDate from PayGroupPeriod where
    PayGroupId = PayGroupID and PayGroupYear = In_PayRecYear and PayGroupPeriod = In_PayRecPeriod and
    PayGroupSubPeriod = In_PayRecSubPeriod order by PayGroupPeriodGenId;
  //get the most updated exchange rate
  select first ForeignLocalRate,LocalForeignRate into Out_ExRateForeignLocal,
    Out_ExRateLocalForeign from ExchangeRateProg where ExchangeRateId = In_ExRateId and ExChgRateEffectiveDate <= SubPEndDate order by
    ExChgRateEffectiveDate desc;
  //return result
  if In_RateType = 'LocalForeign' then
    return Out_ExRateLocalForeign
  else
    return Out_ExRateForeignLocal
  end if
end
;

create function DBA.FGetPayrollPeriodGivenPhyYrMth(
in In_PayGroupId char(20),
in In_PhysicalYear integer,
in In_PhysicalMonth integer)
returns integer
begin
  declare PayrollMonth integer;
  declare MonthId char(20);
  if In_PhysicalMonth = 1 then set MonthId='Mth01'
  end if;
  if In_PhysicalMonth = 2 then set MonthId='Mth02'
  end if;
  if In_PhysicalMonth = 3 then set MonthId='Mth03'
  end if;
  if In_PhysicalMonth = 4 then set MonthId='Mth04'
  end if;
  if In_PhysicalMonth = 5 then set MonthId='Mth05'
  end if;
  if In_PhysicalMonth = 6 then set MonthId='Mth06'
  end if;
  if In_PhysicalMonth = 7 then set MonthId='Mth07'
  end if;
  if In_PhysicalMonth = 8 then set MonthId='Mth08'
  end if;
  if In_PhysicalMonth = 9 then set MonthId='Mth09'
  end if;
  if In_PhysicalMonth = 10 then set MonthId='Mth10'
  end if;
  if In_PhysicalMonth = 11 then set MonthId='Mth11'
  end if;
  if In_PhysicalMonth = 12 then set MonthId='Mth12'
  end if;
  select PeriodId into PayrollMonth from PeriodMessage where PeriodIdType = 'Period' and
    PayGroupId = In_PayGroupId and PeriodMonth = MonthId;
  return PayrollMonth
end
;

create function DBA.FGetPayrollYearGivenPhyYrMth(
in In_PayGroupId char(20),
in In_PhysicalYear integer,
in In_PhysicalMonth integer)
returns integer
begin
  declare PayrollYear integer;
  declare PayrollMonth integer;
  declare MonthId char(20);
  if In_PhysicalMonth = 1 then set MonthId='Mth01'
  end if;
  if In_PhysicalMonth = 2 then set MonthId='Mth02'
  end if;
  if In_PhysicalMonth = 3 then set MonthId='Mth03'
  end if;
  if In_PhysicalMonth = 4 then set MonthId='Mth04'
  end if;
  if In_PhysicalMonth = 5 then set MonthId='Mth05'
  end if;
  if In_PhysicalMonth = 6 then set MonthId='Mth06'
  end if;
  if In_PhysicalMonth = 7 then set MonthId='Mth07'
  end if;
  if In_PhysicalMonth = 8 then set MonthId='Mth08'
  end if;
  if In_PhysicalMonth = 9 then set MonthId='Mth09'
  end if;
  if In_PhysicalMonth = 10 then set MonthId='Mth10'
  end if;
  if In_PhysicalMonth = 11 then set MonthId='Mth11'
  end if;
  if In_PhysicalMonth = 12 then set MonthId='Mth12'
  end if;
  select PeriodId into PayrollMonth from PeriodMessage where PeriodIdType = 'Period' and
    PayGroupId = In_PayGroupId and PeriodMonth = MonthId;
  if In_PhysicalMonth-PayrollMonth >= 0 then set PayrollYear=In_PhysicalYear
  else set PayrollYear=In_PhysicalYear-1
  end if;
  return PayrollYear
end
;

create procedure dba.ASQLCleanupBankSubmitCompanyBank(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
out Out_ErrorCode integer)
begin
  // loop through all records in BankSubmitCompanyBank.
  // for each record, if the bank account information does not exist in CompanyBank, purge the record
  CleanupLoop: for CleanupFor as cursCleanup dynamic scroll cursor for
    select BankCode as Temp_BankCode,BankBranchCode as Temp_BankBranchCode,
      AccountNo as Temp_AccountNo from BankSubmitCompanyBank where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName do
    if(not exists(select 1 from CompanyBank where ComBankCode = Temp_BankCode and ComBankBranchCode = Temp_BankBranchCode and ComAccountNo = Temp_AccountNo)) then
      delete from BankSubmitCompanyBank where
        BankSubmitSubmitForId = In_BankSubmitSubmitForId and
        FormatName = In_FormatName and
        BankCode = Temp_BankCode and
        BankBranchCode = Temp_BankBranchCode and
        AccountNo = Temp_AccountNo
    end if end for;
  return 1
end
;

create procedure dba.DeleteBankSubmitCompanyBank(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    delete from BankSubmitCompanyBank where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and
      FormatName = In_FormatName and
      BankCode = In_BankCode and
      BankBranchCode = In_BankBranchCode and
      AccountNo = In_AccountNo;
    commit work
  end if;
  if exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewBankSubmitCompanyBank(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(20),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from CompanyBank where ComBankCode = In_BankCode and ComBankBranchCode = In_BankBranchCode and ComAccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Company Bank info must exist in CompanyBank
    return
  elseif not exists(select* from BankSubmitFormat where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName) then
    set Out_ErrorCode=-2; // format info must exist in BankSubmitFormat
    return
  else
    insert into BankSubmitCompanyBank(BankSubmitSubmitForId,
      FormatName,
      BankCode,
      BankBranchCode,
      AccountNo,
      BooleanField1,
      BooleanField2,
      BooleanField3,
      IntegerField1,
      IntegerField2,
      IntegerField3,
      NumericField1,
      NumericField2,
      NumericField3,
      DateField1,
      DateField2,
      DateField3,
      StringField1,
      StringField2,
      StringField3,
      StringField4,
      StringField5,
      StringField6,
      StringField7,
      StringField8,
      StringField9,
      StringField10,
      StringField11,
      StringField12,
      StringField13,
      StringField14,
      StringField15,
      StringField16,
      StringField17,
      StringField18,
      StringField19,
      StringField20) values(In_BankSubmitSubmitForId,
      In_FormatName,
      In_BankCode,
      In_BankBranchCode,
      In_AccountNo,
      In_BooleanField1,
      In_BooleanField2,
      In_BooleanField3,
      In_IntegerField1,
      In_IntegerField2,
      In_IntegerField3,
      In_NumericField1,
      In_NumericField2,
      In_NumericField3,
      In_DateField1,
      In_DateField2,
      In_DateField3,
      In_StringField1,
      In_StringField2,
      In_StringField3,
      In_StringField4,
      In_StringField5,
      In_StringField6,
      In_StringField7,
      In_StringField8,
      In_StringField9,
      In_StringField10,
      In_StringField11,
      In_StringField12,
      In_StringField13,
      In_StringField14,
      In_StringField15,
      In_StringField16,
      In_StringField17,
      In_StringField18,
      In_StringField19,
      In_StringField20);
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateBankSubmitCompanyBank(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(20),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    update BankSubmitCompanyBank set
      BooleanField1 = In_BooleanField1,
      BooleanField2 = In_BooleanField2,
      BooleanField3 = In_BooleanField3,
      IntegerField1 = In_IntegerField1,
      IntegerField2 = In_IntegerField2,
      IntegerField3 = In_IntegerField3,
      NumericField1 = In_NumericField1,
      NumericField2 = In_NumericField2,
      NumericField3 = In_NumericField3,
      DateField1 = In_DateField1,
      DateField2 = In_DateField2,
      DateField3 = In_DateField3,
      StringField1 = In_StringField1,
      StringField2 = In_StringField2,
      StringField3 = In_StringField3,
      StringField4 = In_StringField4,
      StringField5 = In_StringField5,
      StringField6 = In_StringField6,
      StringField7 = In_StringField7,
      StringField8 = In_StringField8,
      StringField9 = In_StringField9,
      StringField10 = In_StringField10,
      StringField11 = In_StringField11,
      StringField12 = In_StringField12,
      StringField13 = In_StringField13,
      StringField14 = In_StringField14,
      StringField15 = In_StringField15,
      StringField16 = In_StringField16,
      StringField17 = In_StringField17,
      StringField18 = In_StringField18,
      StringField19 = In_StringField19,
      StringField20 = In_StringField20 where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and
      FormatName = In_FormatName and
      BankCode = In_BankCode and
      BankBranchCode = In_BankBranchCode and
      AccountNo = In_AccountNo;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure DBA.ASQLDeleteLoan(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      AllowanceRecurSysId from AllowanceRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (AllowanceCreatedBy = 'Loan' and AllowanceCustSysId <> 0) do
    delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
    delete from AllowanceRecord where AllowanceSGSPGenId = GenId end for;
  commit work
end
;

create procedure DBA.DeleteLoanEmployee(
in In_LoanSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from LoanEmployee where LoanSysId = In_LoanSysId) then
    if exists(select* from LoanPayment where LoanPayment.LoanSysId = In_LoanSysId) then
      delete from LoanPayment where LoanSysId = In_LoanSysId;
      commit work
    end if;
    if exists(select* from LoanYTD where LoanYTD.LoanSysId = In_LoanSysId) then
      delete from LoanYTD where LoanSysId = In_LoanSysId;
      commit work
    end if;
    delete from LoanEmployee where LoanSysId = In_LoanSysId;
    commit work;
    if exists(select* from LoanEmployee where LoanSysId = In_LoanSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteLoanEmployeeEmp(
in In_EmployeeSysId integer)
begin
  LoanPaymentLoop: for LoanSysIdFor as Cur_LoanSysIdId dynamic scroll cursor for
    select LoanEmployee.LoanSysId as Get_LoanSysId from
      LoanEmployee where
      LoanEmployee.EmployeeSysId = In_EmployeeSysId do
    delete from LoanPayment where
      LoanPayment.LoanSysId = Get_LoanSysId;
    delete from LoanYTD where
      LoanYTD.LoanSysId = Get_LoanSysId;
    commit work end for;
  delete from LoanEmployee where EmployeeSysId = In_EmployeeSysId;
  commit work
end
;

create procedure dba.DeleteLoanFrom(
in In_LoanFromId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from LoanFrom where LoanFromId = In_LoanFromId) then
    delete from LoanFrom where LoanFromId = In_LoanFromId;
    commit work;
    if exists(select* from LoanFrom where LoanFromId = In_LoanFromId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.FGetLoanBal(
in In_LoanSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Out_Balance double;
  declare Out_YTDPayment double;
  declare Out_LoanTotalAmt double;
  select FGetYTDPayment(In_LoanSysId,In_PayRecYear,In_PayRecPeriod) into Out_YTDPayment;
  select LoanTotalAmt into Out_LoanTotalAmt from LoanEmployee where LoanSysId = In_LoanSysId;
  set Out_Balance=Round(Out_LoanTotalAmt+Out_YTDPayment,FGetDBPayDecimal(*));
  return Out_Balance
end
;

create function dba.FGetYTDPayment(
in In_LoanSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare Tmp_PayRecPayment double;
  declare Tmp_PrevPayment double;
  declare Out_YTDPayment double;
  if(In_PayRecYear <> 0 and In_PayRecPeriod <> 0) then
    select Sum(AllowanceAmount) into Tmp_PayRecPayment from AllowanceRecord where
      IsPeriodLessThan(PayRecYear,PayRecPeriod,In_PayRecYear,In_PayRecPeriod) = 1 and
      AllowanceCustSysId = In_LoanSysId
  else
    select Sum(AllowanceAmount) into Tmp_PayRecPayment from AllowanceRecord where
      AllowanceCustSysId = In_LoanSysId
  end if;
  select Sum(LoanYTDPaidAmt) into Tmp_PrevPayment from LoanYTD where
    LoanSysId = In_LoanSysId;
  set Out_YTDPayment=FConvertNull(Tmp_PayRecPayment)+FConvertNull(Tmp_PrevPayment);
  return Out_YTDPayment
end
;

create procedure DBA.InsertNewLoanEmployee(
in In_LoanFromId char(20),
in In_LoanTypeId char(20),
in In_EmployeeSysId integer,
in In_LoanRefNo char(20),
in In_LoanApprovalDate date,
in In_LoanEffectiveDate date,
in In_LoanExpiryDate date,
in In_LoanMonths integer,
in In_LoanTotalAmt double,
in In_LoanMthPayment double,
in In_LoanPayElementId char(20),
in In_LoanDesc char(100),
in In_LoanOtherBoolean1 smallint,
in In_LoanOtherBoolean2 smallint,
in In_LoanOtherBoolean3 smallint,
in In_LoanOtherDate1 date,
in In_LoanOtherDate2 date,
in In_LoanOtherDate3 date,
in In_LoanOtherInteger1 integer,
in In_LoanOtherInteger2 integer,
in In_LoanOtherInteger3 integer,
in In_LoanOtherNumeric1 double,
in In_LoanOtherNumeric2 double,
in In_LoanOtherNumeric3 double,
in In_LoanOtherString1 char(50),
in In_LoanOtherString2 char(50),
in In_LoanOtherString3 char(50),
in In_LoanOtherString4 char(50),
in In_LoanOtherString5 char(50),
out Out_ErrorCode integer)
begin
  declare iLoanSysId integer;
  insert into LoanEmployee(LoanFromId,
    LoanTypeId,
    EmployeeSysId,
    LoanRefNo,
    LoanApprovalDate,
    LoanEffectiveDate,
    LoanExpiryDate,
    LoanMonths,
    LoanTotalAmt,
    LoanMthPayment,
    LoanPayElementId,
    LoanDesc,
    LoanOtherBoolean1,
    LoanOtherBoolean2,
    LoanOtherBoolean3,
    LoanOtherDate1,
    LoanOtherDate2,
    LoanOtherDate3,
    LoanOtherInteger1,
    LoanOtherInteger2,
    LoanOtherInteger3,
    LoanOtherNumeric1,
    LoanOtherNumeric2,
    LoanOtherNumeric3,
    LoanOtherString1,
    LoanOtherString2,
    LoanOtherString3,
    LoanOtherString4,
    LoanOtherString5) values(
    In_LoanFromId,
    In_LoanTypeId,
    In_EmployeeSysId,
    In_LoanRefNo,
    In_LoanApprovalDate,
    In_LoanEffectiveDate,
    In_LoanExpiryDate,
    In_LoanMonths,
    In_LoanTotalAmt,
    In_LoanMthPayment,
    In_LoanPayElementId,
    In_LoanDesc,
    In_LoanOtherBoolean1,
    In_LoanOtherBoolean2,
    In_LoanOtherBoolean3,
    In_LoanOtherDate1,
    In_LoanOtherDate2,
    In_LoanOtherDate3,
    In_LoanOtherInteger1,
    In_LoanOtherInteger2,
    In_LoanOtherInteger3,
    In_LoanOtherNumeric1,
    In_LoanOtherNumeric2,
    In_LoanOtherNumeric3,
    In_LoanOtherString1,
    In_LoanOtherString2,
    In_LoanOtherString3,
    In_LoanOtherString4,
    In_LoanOtherString5);
  commit work;
  select LoanSysId into iLoanSysId from LoanEmployee where
    EmployeeSysId = In_EmployeeSysId and
    LoanFromId = In_LoanFromId and
    LoanTypeId = In_LoanTypeId and
    LoanRefNo = In_LoanRefNo and
    LoanApprovalDate = In_LoanApprovalDate and
    LoanEffectiveDate = In_LoanEffectiveDate and
    LoanExpiryDate = In_LoanExpiryDate and
    LoanMonths = In_LoanMonths and
    LoanTotalAmt = In_LoanTotalAmt and
    LoanMthPayment = In_LoanMthPayment and
    LoanPayElementId = In_LoanPayElementId and
    LoanDesc = In_LoanDesc;
  insert into LoanPayment(LoanSysId,LoanPaySubPeriod,LoanPayRecordId) values(iLoanSysId,1,'Normal');
  commit work;
  set Out_ErrorCode=iLoanSysId
end
;

create procedure
dba.InsertNewLoanFrom(
in In_LoanFromId char(20),
in In_LoanFromDesc char(100),
in In_LoanFromGovt smallint,
in In_LoanOtherBoolean1Desc char(100),
in In_LoanOtherBoolean2Desc char(100),
in In_LoanOtherBoolean3Desc char(100),
in In_LoanOtherDate1Desc char(100),
in In_LoanOtherDate2Desc char(100),
in In_LoanOtherDate3Desc char(100),
in In_LoanOtherInteger1Desc char(100),
in In_LoanOtherInteger2Desc char(100),
in In_LoanOtherInteger3Desc char(100),
in In_LoanOtherNumeric1Desc char(100),
in In_LoanOtherNumeric2Desc char(100),
in In_LoanOtherNumeric3Desc char(100),
in In_LoanOtherString1Desc char(100),
in In_LoanOtherString2Desc char(100),
in In_LoanOtherString3Desc char(100),
in In_LoanOtherString4Desc char(100),
in In_LoanOtherString5Desc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from LoanFrom where LoanFromId = In_LoanFromId) then
    insert into LoanFrom(LoanFromId,
      LoanFromDesc,
      LoanFromGovt,
      LoanOtherBoolean1Desc,
      LoanOtherBoolean2Desc,
      LoanOtherBoolean3Desc,
      LoanOtherDate1Desc,
      LoanOtherDate2Desc,
      LoanOtherDate3Desc,
      LoanOtherInteger1Desc,
      LoanOtherInteger2Desc,
      LoanOtherInteger3Desc,
      LoanOtherNumeric1Desc,
      LoanOtherNumeric2Desc,
      LoanOtherNumeric3Desc,
      LoanOtherString1Desc,
      LoanOtherString2Desc,
      LoanOtherString3Desc,
      LoanOtherString4Desc,
      LoanOtherString5Desc) values(
      In_LoanFromId,
      In_LoanFromDesc,
      In_LoanFromGovt,
      In_LoanOtherBoolean1Desc,
      In_LoanOtherBoolean2Desc,
      In_LoanOtherBoolean3Desc,
      In_LoanOtherDate1Desc,
      In_LoanOtherDate2Desc,
      In_LoanOtherDate3Desc,
      In_LoanOtherInteger1Desc,
      In_LoanOtherInteger2Desc,
      In_LoanOtherInteger2Desc,
      In_LoanOtherNumeric1Desc,
      In_LoanOtherNumeric2Desc,
      In_LoanOtherNumeric3Desc,
      In_LoanOtherString1Desc,
      In_LoanOtherString2Desc,
      In_LoanOtherString3Desc,
      In_LoanOtherString4Desc,
      In_LoanOtherString5Desc);
    commit work;
    if not exists(select* from LoanFrom where LoanFromId = In_LoanFromId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.IsDateWithin(
in In_CheckDate date,
in In_StartDate date,
in In_EndDate date)
returns smallint
begin
  if(In_CheckDate between In_StartDate and In_EndDate) then
    return 1
  end if;
  return 0
end
;

create procedure dba.UpdateLoanEmployee(
in In_LoanSysId integer,
in In_LoanTypeId char(20),
in In_LoanRefNo char(20),
in In_LoanApprovalDate date,
in In_LoanEffectiveDate date,
in In_LoanExpiryDate date,
in In_LoanMonths integer,
in In_LoanTotalAmt double,
in In_LoanMthPayment double,
in In_LoanPayElementId char(20),
in In_LoanDesc char(100),
in In_LoanOtherBoolean1 smallint,
in In_LoanOtherBoolean2 smallint,
in In_LoanOtherBoolean3 smallint,
in In_LoanOtherDate1 date,
in In_LoanOtherDate2 date,
in In_LoanOtherDate3 date,
in In_LoanOtherInteger1 integer,
in In_LoanOtherInteger2 integer,
in In_LoanOtherInteger3 integer,
in In_LoanOtherNumeric1 double,
in In_LoanOtherNumeric2 double,
in In_LoanOtherNumeric3 double,
in In_LoanOtherString1 char(50),
in In_LoanOtherString2 char(50),
in In_LoanOtherString3 char(50),
in In_LoanOtherString4 char(50),
in In_LoanOtherString5 char(50),
out Out_ErrorCode integer)
begin
  if exists(select* from LoanEmployee where LoanSysId = In_LoanSysId) then
    update LoanEmployee set
      LoanTypeId = In_LoanTypeId,
      LoanRefNo = In_LoanRefNo,
      LoanApprovalDate = In_LoanApprovalDate,
      LoanEffectiveDate = In_LoanEffectiveDate,
      LoanExpiryDate = In_LoanExpiryDate,
      LoanMonths = In_LoanMonths,
      LoanTotalAmt = In_LoanTotalAmt,
      LoanMthPayment = In_LoanMthPayment,
      LoanPayElementId = In_LoanPayElementId,
      LoanDesc = In_LoanDesc,
      LoanOtherBoolean1 = In_LoanOtherBoolean1,
      LoanOtherBoolean2 = In_LoanOtherBoolean2,
      LoanOtherBoolean3 = In_LoanOtherBoolean3,
      LoanOtherDate1 = In_LoanOtherDate1,
      LoanOtherDate2 = In_LoanOtherDate2,
      LoanOtherDate3 = In_LoanOtherDate3,
      LoanOtherInteger1 = In_LoanOtherInteger1,
      LoanOtherInteger2 = In_LoanOtherInteger2,
      LoanOtherInteger3 = In_LoanOtherInteger3,
      LoanOtherNumeric1 = In_LoanOtherNumeric1,
      LoanOtherNumeric2 = In_LoanOtherNumeric2,
      LoanOtherNumeric3 = In_LoanOtherNumeric3,
      LoanOtherString1 = In_LoanOtherString1,
      LoanOtherString2 = In_LoanOtherString2,
      LoanOtherString3 = In_LoanOtherString3,
      LoanOtherString4 = In_LoanOtherString4,
      LoanOtherString5 = In_LoanOtherString5 where
      LoanSysId = In_LoanSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateLoanFrom(
in In_LoanFromId char(20),
in In_LoanFromDesc char(100),
in In_LoanFromGovt smallint,
in In_LoanOtherBoolean1Desc char(100),
in In_LoanOtherBoolean2Desc char(100),
in In_LoanOtherBoolean3Desc char(100),
in In_LoanOtherDate1Desc char(100),
in In_LoanOtherDate2Desc char(100),
in In_LoanOtherDate3Desc char(100),
in In_LoanOtherInteger1Desc char(100),
in In_LoanOtherInteger2Desc char(100),
in In_LoanOtherInteger3Desc char(100),
in In_LoanOtherNumeric1Desc char(100),
in In_LoanOtherNumeric2Desc char(100),
in In_LoanOtherNumeric3Desc char(100),
in In_LoanOtherString1Desc char(100),
in In_LoanOtherString2Desc char(100),
in In_LoanOtherString3Desc char(100),
in In_LoanOtherString4Desc char(100),
in In_LoanOtherString5Desc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from LoanFrom where LoanFromId = In_LoanFromId) then
    update LoanFrom set
      LoanFromDesc = In_LoanFromDesc,
      LoanFromGovt = In_LoanFromGovt,
      LoanOtherBoolean1Desc = In_LoanOtherBoolean1Desc,
      LoanOtherBoolean2Desc = In_LoanOtherBoolean2Desc,
      LoanOtherBoolean3Desc = In_LoanOtherBoolean3Desc,
      LoanOtherDate1Desc = In_LoanOtherDate1Desc,
      LoanOtherDate2Desc = In_LoanOtherDate2Desc,
      LoanOtherDate3Desc = In_LoanOtherDate3Desc,
      LoanOtherInteger1Desc = In_LoanOtherInteger1Desc,
      LoanOtherInteger2Desc = In_LoanOtherInteger2Desc,
      LoanOtherInteger3Desc = In_LoanOtherInteger3Desc,
      LoanOtherNumeric1Desc = In_LoanOtherNumeric1Desc,
      LoanOtherNumeric2Desc = In_LoanOtherNumeric2Desc,
      LoanOtherNumeric3Desc = In_LoanOtherNumeric3Desc,
      LoanOtherString1Desc = In_LoanOtherString1Desc,
      LoanOtherString2Desc = In_LoanOtherString2Desc,
      LoanOtherString3Desc = In_LoanOtherString3Desc,
      LoanOtherString4Desc = In_LoanOtherString4Desc,
      LoanOtherString5Desc = In_LoanOtherString5Desc where
      LoanFromId = In_LoanFromId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAdvanceProcess(
in In_AdvReportId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from AdvanceReport where AdvReportId = In_AdvReportId;
    delete from AdvanceCondition where AdvReportId = In_AdvReportId;
    delete from AdvanceProcess where AdvReportId = In_AdvReportId;
    commit work
  end if;
  if exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteAdvanceReport(
in In_AdvReportId char(20),
in In_AdvEmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from AdvanceReport where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from AdvanceProcess where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId;
    commit work
  end if;
  if exists(select* from AdvanceReport where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewAdvanceProcess(
in In_AdvReportId char(20),
in In_AdvDesc char(200),
in In_AdvPayRecYear integer,
in In_AdvPayRecPeriod integer,
in In_AdvTrialRun smallint,
in In_AdvIncTerminated smallint,
in In_AdvIncNotConfirmed smallint,
in In_AdvIncNewHire smallint,
in In_AdvFundDeduct smallint,
in In_AdvBROption smallint,
in In_AdvBRValue double,
in In_AdvMVCOption smallint,
in In_AdvMVCValue double,
in In_AdvNWCOption smallint,
in In_AdvNWCValue double,
in In_AdvSalaryType char(20),
in In_AdvFixedCalendarOption double,
in In_AdvTaxDeduct smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=-1; // Record exists
    return
  else
    insert into AdvanceProcess(AdvReportId,
      AdvDesc,
      AdvPayRecYear,
      AdvPayRecPeriod,
      AdvTrialRun,
      AdvIncTerminated,
      AdvIncNotConfirmed,
      AdvIncNewHire,
      AdvFundDeduct,
      AdvBROption,
      AdvBRValue,
      AdvMVCOption,
      AdvMVCValue,
      AdvNWCOption,
      AdvNWCValue,
      AdvSalaryType,
      AdvFixedCalendarOption,
      AdvTaxDeduct) values(
      In_AdvReportId,
      In_AdvDesc,
      In_AdvPayRecYear,
      In_AdvPayRecPeriod,
      In_AdvTrialRun,
      In_AdvIncTerminated,
      In_AdvIncNotConfirmed,
      In_AdvIncNewHire,
      In_AdvFundDeduct,
      In_AdvBROption,
      In_AdvBRValue,
      In_AdvMVCOption,
      In_AdvMVCValue,
      In_AdvNWCOption,
      In_AdvNWCValue,
      In_AdvSalaryType,
      In_AdvFixedCalendarOption,
      In_AdvTaxDeduct);
    commit work
  end if;
  if not exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewAdvanceReport(
in In_AdvReportId char(20),
in In_AdvEmployeeSysId integer,
in In_AdvExRateId char(20),
in In_AdvExRate double,
in In_AdvBRFullAmtF double,
in In_AdvMVCFullAmtF double,
in In_AdvNWCFullAmtF double,
in In_AdvBRAmtF double,
in In_AdvMVCAmtF double,
in In_AdvNWCAmtF double,
in In_AdvBRAmt double,
in In_AdvMVCAmt double,
in In_AdvNWCAmt double,
in In_AdvEEFund1 double,
in In_AdvERFund1 double,
in In_AdvEEFund2 double,
in In_AdvERFund2 double,
in In_AdvEEFund3 double,
in In_AdvERFund3 double,
in In_AdvEEFund4 double,
in In_AdvERFund4 double,
in In_AdvEEFund5 double,
in In_AdvERFund5 double,
in In_AdvEEFund6 double,
in In_AdvERFund6 double,
in In_AdvEEFund7 double,
in In_AdvERFund7 double,
in In_AdvEEFund8 double,
in In_AdvERFund8 double,
in In_AdvEEFund9 double,
in In_AdvERFund9 double,
in In_AdvEEFund10 double,
in In_AdvERFund10 double,
in In_AdvCurHrDaysBRAmtF double,
in In_AdvCurHrDaysMVCAmtF double,
in In_AdvCurHrDaysNWCAmtF double,
in In_AdvCurHrDays double,
out Out_ErrorCode integer)
begin
  if exists(select* from AdvanceReport where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=-2; // No parent
    return
  else
    insert into AdvanceReport(AdvReportId,
      AdvEmployeeSysId,
      AdvExRateId,
      AdvExRate,
      AdvBRFullAmtF,
      AdvMVCFullAmtF,
      AdvNWCFullAmtF,
      AdvBRAmtF,
      AdvMVCAmtF,
      AdvNWCAmtF,
      AdvBRAmt,
      AdvMVCAmt,
      AdvNWCAmt,
      AdvEEFund1,
      AdvERFund1,
      AdvEEFund2,
      AdvERFund2,
      AdvEEFund3,
      AdvERFund3,
      AdvEEFund4,
      AdvERFund4,
      AdvEEFund5,
      AdvERFund5,
      AdvEEFund6,
      AdvERFund6,
      AdvEEFund7,
      AdvERFund7,
      AdvEEFund8,
      AdvERFund8,
      AdvEEFund9,
      AdvERFund9,
      AdvEEFund10,
      AdvERFund10,
      AdvCurHrDaysBRAmtF,
      AdvCurHrDaysMVCAmtF,
      AdvCurHrDaysNWCAmtF,
      AdvCurHrDays) values(
      In_AdvReportId,
      In_AdvEmployeeSysId,
      In_AdvExRateId,
      In_AdvExRate,
      In_AdvBRFullAmtF,
      In_AdvMVCFullAmtF,
      In_AdvNWCFullAmtF,
      In_AdvBRAmtF,
      In_AdvMVCAmtF,
      In_AdvNWCAmtF,
      In_AdvBRAmt,
      In_AdvMVCAmt,
      In_AdvNWCAmt,
      In_AdvEEFund1,
      In_AdvERFund1,
      In_AdvEEFund2,
      In_AdvERFund2,
      In_AdvEEFund3,
      In_AdvERFund3,
      In_AdvEEFund4,
      In_AdvERFund4,
      In_AdvEEFund5,
      In_AdvERFund5,
      In_AdvEEFund6,
      In_AdvERFund6,
      In_AdvEEFund7,
      In_AdvERFund7,
      In_AdvEEFund8,
      In_AdvERFund8,
      In_AdvEEFund9,
      In_AdvERFund9,
      In_AdvEEFund10,
      In_AdvERFund10,
      In_AdvCurHrDaysBRAmtF,
      In_AdvCurHrDaysMVCAmtF,
      In_AdvCurHrDaysNWCAmtF,
      In_AdvCurHrDays);
    commit work
  end if;
  if not exists(select* from AdvanceReport where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdateAdvanceProcess(
in In_AdvReportId char(20),
in In_AdvDesc char(200),
in In_AdvPayRecYear integer,
in In_AdvPayRecPeriod integer,
in In_AdvTrialRun smallint,
in In_AdvIncTerminated smallint,
in In_AdvIncNotConfirmed smallint,
in In_AdvIncNewHire smallint,
in In_AdvFundDeduct smallint,
in In_AdvBROption smallint,
in In_AdvBRValue double,
in In_AdvMVCOption smallint,
in In_AdvMVCValue double,
in In_AdvNWCOption smallint,
in In_AdvNWCValue double,
in In_AdvSalaryType char(20),
in In_AdvFixedCalendarOption double,
in In_AdvTaxDeduct smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from AdvanceProcess where AdvReportId = In_AdvReportId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from AdvanceReport where AdvReportId = In_AdvReportId;
    update AdvanceProcess set
      AdvDesc = In_AdvDesc,
      AdvPayRecYear = In_AdvPayRecYear,
      AdvPayRecPeriod = In_AdvPayRecPeriod,
      AdvTrialRun = In_AdvTrialRun,
      AdvIncTerminated = In_AdvIncTerminated,
      AdvIncNotConfirmed = In_AdvIncNotConfirmed,
      AdvIncNewHire = In_AdvIncNewHire,
      AdvFundDeduct = In_AdvFundDeduct,
      AdvBROption = In_AdvBROption,
      AdvBRValue = In_AdvBRValue,
      AdvMVCOption = In_AdvMVCOption,
      AdvMVCValue = In_AdvMVCValue,
      AdvNWCOption = In_AdvNWCOption,
      AdvNWCValue = In_AdvNWCValue,
      AdvSalaryType = In_AdvSalaryType,
      AdvFixedCalendarOption = In_AdvFixedCalendarOption,
      AdvTaxDeduct = In_AdvTaxDeduct where
      AdvReportId = In_AdvReportId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateAdvanceReport(
in In_AdvReportId char(20),
in In_AdvEmployeeSysId integer,
in In_AdvExRateId char(20),
in In_AdvExRate double,
in In_AdvBRFullAmtF double,
in In_AdvMVCFullAmtF double,
in In_AdvNWCFullAmtF double,
in In_AdvBRAmtF double,
in In_AdvMVCAmtF double,
in In_AdvNWCAmtF double,
in In_AdvBRAmt double,
in In_AdvMVCAmt double,
in In_AdvNWCAmt double,
in In_AdvEEFund1 double,
in In_AdvERFund1 double,
in In_AdvEEFund2 double,
in In_AdvERFund2 double,
in In_AdvEEFund3 double,
in In_AdvERFund3 double,
in In_AdvEEFund4 double,
in In_AdvERFund4 double,
in In_AdvEEFund5 double,
in In_AdvERFund5 double,
in In_AdvEEFund6 double,
in In_AdvERFund6 double,
in In_AdvEEFund7 double,
in In_AdvERFund7 double,
in In_AdvEEFund8 double,
in In_AdvERFund8 double,
in In_AdvEEFund9 double,
in In_AdvERFund9 double,
in In_AdvEEFund10 double,
in In_AdvERFund10 double,
in In_AdvCurHrDaysBRAmtF double,
in In_AdvCurHrDaysMVCAmtF double,
in In_AdvCurHrDaysNWCAmtF double,
in In_AdvCurHrDays double,
out Out_ErrorCode integer)
begin
  if not exists(select* from AdvanceReport where AdvReportId = In_AdvReportId and AdvEmployeeSysId = In_AdvEmployeeSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update AdvanceReport set
      AdvExRateId = In_AdvExRateId,
      AdvExRate = In_AdvExRate,
      AdvBRFullAmtF = In_AdvBRFullAmtF,
      AdvMVCFullAmtF = In_AdvMVCFullAmtF,
      AdvNWCFullAmtF = In_AdvNWCFullAmtF,
      AdvBRAmtF = In_AdvBRAmtF,
      AdvMVCAmtF = In_AdvMVCAmtF,
      AdvNWCAmtF = In_AdvNWCAmtF,
      AdvBRAmt = In_AdvBRAmt,
      AdvMVCAmt = In_AdvMVCAmt,
      AdvNWCAmt = In_AdvNWCAmt,
      AdvEEFund1 = In_AdvEEFund1,
      AdvERFund1 = In_AdvERFund1,
      AdvEEFund2 = In_AdvEEFund2,
      AdvERFund2 = In_AdvERFund2,
      AdvEEFund3 = In_AdvEEFund3,
      AdvERFund3 = In_AdvERFund3,
      AdvEEFund4 = In_AdvEEFund4,
      AdvERFund4 = In_AdvERFund4,
      AdvEEFund5 = In_AdvEEFund5,
      AdvERFund5 = In_AdvERFund5,
      AdvEEFund6 = In_AdvEEFund6,
      AdvERFund6 = In_AdvERFund6,
      AdvEEFund7 = In_AdvEEFund7,
      AdvERFund7 = In_AdvERFund7,
      AdvEEFund8 = In_AdvEEFund8,
      AdvERFund8 = In_AdvERFund8,
      AdvEEFund9 = In_AdvEEFund9,
      AdvERFund9 = In_AdvERFund9,
      AdvEEFund10 = In_AdvEEFund10,
      AdvERFund10 = In_AdvERFund10,
      AdvCurHrDaysBRAmtF = In_AdvCurHrDaysBRAmtF,
      AdvCurHrDaysMVCAmtF = In_AdvCurHrDaysMVCAmtF,
      AdvCurHrDaysNWCAmtF = In_AdvCurHrDaysNWCAmtF,
      AdvCurHrDays = In_AdvCurHrDays where
      AdvReportId = In_AdvReportId and
      AdvEmployeeSysId = In_AdvEmployeeSysId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure DBA.ASQLAdvReportUpdate(
in In_AdvReportId char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecordID char(20))
begin
  declare In_Country char(20);
  declare Out_AdvEEFund1 double;
  declare Out_AdvERFund1 double;
  declare Out_AdvEEFund2 double;
  declare Out_AdvERFund2 double;
  declare Out_AdvEEFund3 double;
  declare Out_AdvERFund3 double;
  declare Out_AdvEEFund4 double;
  declare Out_AdvERFund4 double;
  declare Out_AdvEEFund5 double;
  declare Out_AdvERFund5 double;
  declare Out_AdvEEFund6 double;
  declare Out_AdvERFund6 double;
  declare Out_AdvEEFund7 double;
  declare Out_AdvERFund7 double;
  declare Out_AdvEEFund8 double;
  declare Out_AdvERFund8 double;
  declare Out_AdvEEFund9 double;
  declare Out_AdvERFund9 double;
  declare Out_AdvEEFund10 double;
  declare Out_AdvERFund10 double;
  set Out_AdvEEFund1=0;
  set Out_AdvERFund1=0;
  set Out_AdvEEFund2=0;
  set Out_AdvERFund2=0;
  set Out_AdvEEFund3=0;
  set Out_AdvERFund3=0;
  set Out_AdvEEFund4=0;
  set Out_AdvERFund4=0;
  set Out_AdvEEFund5=0;
  set Out_AdvERFund5=0;
  set Out_AdvEEFund6=0;
  set Out_AdvERFund6=0;
  set Out_AdvEEFund7=0;
  set Out_AdvERFund7=0;
  set Out_AdvEEFund8=0;
  set Out_AdvERFund8=0;
  set Out_AdvEEFund9=0;
  set Out_AdvERFund9=0;
  set Out_AdvEEFund10=0;
  set Out_AdvERFund10=0;
  select FGetDBCountry(*) into In_Country;
  /*
  Singapore Update CPF
  */
  if(In_Country = 'Singapore') then
    select ContriOrdEECPF+ContriAddEECPF, //  Employee CPF 
      ContriOrdERCPF+ContriAddERCPF into Out_AdvEEFund1, // Employer CPF 
      Out_AdvERFund1 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Brunei Update TAP 1,2,3
  */
  elseif(In_Country = 'Brunei') then
    select TotalContriEECPF, // TAP 1
      TotalContriERCPF,
      ContriOrdEECPF, // TAP 2
      ContriOrdERCPF,
      ContriAddEECPF, // TAP 3
      ContriAddERCPF into Out_AdvEEFund1,
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund2,
      Out_AdvERFund2 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Indonesia Update Jamsostek
  */
  elseif(In_Country = 'Indonesia') then
    select ContriOrdEECPF, // Employee Jamsostek
      ContriOrdERCPF, // Accident Jamsostek
      ContriAddEECPF, // Old Age Jamsostek
      ContriAddERCPF into Out_AdvEEFund1, // Death Jamsostek
      Out_AdvERFund2,
      Out_AdvERFund3,
      Out_AdvERFund4 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Malaysia Update EPF / SOCSO
  */
  elseif(In_Country = 'Malaysia') then
    select ContriOrdEECPF, // SOCSO EE Contribution 
      ContriOrdERCPF, // SOCSO ER Contribution
      CurrEEManContri, // Current EE Mandatory EPF 
      CurrERManContri, // Current ER Mandatory EPF 
      CurrEEVolContri, // Current EE Voluntary EPF
      CurrERVolContri, // Current ER Voluntary EPF
      PrevEEManContri, // Previous EE Mandatory EPF
      PrevERManContri, // Previous ER Mandatory EPF
      PrevEEVolContri, // Previous EE Voluntary EPF
      PrevERVolContri into Out_AdvEEFund1, // Previous ER Voluntary EPF
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4,
      Out_AdvERFund4,
      Out_AdvEEFund5,
      Out_AdvERFund5 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Philippines SSS / PHIC / HDMF
  */
  elseif(In_Country = 'Philippines') then
    select ContriOrdEECPF, // PHIC EE
      ContriOrdERCPF, // PHIC ER
      ContriAddEECPF, // HDMF EE
      ContriAddERCPF, // HDMF ER
      CurrEEManContri, // SSS EE
      CurrERManContri, // SSS ER SS
      CurrERVolContri into Out_AdvEEFund1, // SSS ER EC
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Vietnam no Fund Contribution
  */
  /*
  Hong Kong MPF Contribution
  */
  elseif(In_Country = 'HongKong') then
    select CurrEEManContri, // EE Man MPF Contri
      CurrERManContri, // ER Man MPF Contri
      CurrEEVolContri, // EE Vol MPF Contri
      CurrERVolContri into Out_AdvEEFund1, // ER Vol MPF Contri
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Thailand SS and PF Contribution
  */
  elseif(In_Country = 'Thailand') then
    select ContriOrdEECPF, //	PF1 EE
      ContriOrdERCPF, //	PF1 ER
      CurrEEManContri, //	PF2 EE
      CurrERManContri, //	PF2 ER
      PrevEEManContri, //	PF3 EE
      PrevERManContri, //	PF3 ER
      CurrEEManWage, //	PF4 EE
      CurrERManWage, //	PF4 ER
      PrevEEManWage, //	PF5 EE
      PrevERManWage, //	PF5 ER   
      TotalContriEECPF, //	SS EE 
      TotalContriERCPF, //	SS ER
      ContriAddERCPF, //	PF1 ER Special
      CurrERVolContri, //	PF2 ER Special
      PrevERVolContri, //	PF3 ER Special
      CurrERVolWage, //	PF4 ER Special
      PrevERVolWage into Out_AdvEEFund1, //	PF5 ER Special
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4,
      Out_AdvERFund4,
      Out_AdvEEFund5,
      Out_AdvERFund5,
      Out_AdvEEFund6,
      Out_AdvERFund6,
      Out_AdvEEFund7,
      Out_AdvERFund7,
      Out_AdvEEFund8,
      Out_AdvERFund8,
      Out_AdvEEFund9 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  end if;
  update AdvanceReport set
    AdvEEFund1 = Out_AdvEEFund1,
    AdvERFund1 = Out_AdvERFund1,
    AdvEEFund2 = Out_AdvEEFund2,
    AdvERFund2 = Out_AdvERFund2,
    AdvEEFund3 = Out_AdvEEFund3,
    AdvERFund3 = Out_AdvERFund3,
    AdvEEFund4 = Out_AdvEEFund4,
    AdvERFund4 = Out_AdvERFund4,
    AdvEEFund5 = Out_AdvEEFund5,
    AdvERFund5 = Out_AdvERFund5,
    AdvEEFund6 = Out_AdvEEFund6,
    AdvERFund6 = Out_AdvERFund6,
    AdvEEFund7 = Out_AdvEEFund7,
    AdvERFund7 = Out_AdvERFund7,
    AdvEEFund8 = Out_AdvEEFund8,
    AdvERFund8 = Out_AdvERFund8,
    AdvEEFund9 = Out_AdvEEFund9,
    AdvERFund9 = Out_AdvERFund9,
    AdvEEFund10 = Out_AdvEEFund10,
    AdvERFund10 = Out_AdvERFund10 where
    AdvEmployeeSysId = In_EmployeeSysId and
    AdvReportId = In_AdvReportId
end
;

create function DBA.FGetPhyYearGivenPayYrPeriod(
in In_PayGroupId char(20),
in In_PayYear integer,
in In_PayPeriod integer)
returns integer
begin
  declare PhyYear integer;
  declare PhyMonth integer;
  declare MonthId char(20);
  select PeriodMonth into MonthId from PeriodMessage where PeriodIdType = 'Period' and
    PayGroupId = In_PayGroupId and PeriodId = In_PayPeriod;
  if MonthId = 'Mth01' then set PhyMonth=1
  else if MonthId = 'Mth02' then set PhyMonth=2
    else if MonthId = 'Mth03' then set PhyMonth=3
      else
        if MonthId = 'Mth04' then set PhyMonth=4
        else
          if MonthId = 'Mth05' then set PhyMonth=5
          else
            if MonthId = 'Mth06' then set PhyMonth=6
            else
              if MonthId = 'Mth07' then set PhyMonth=7
              else
                if MonthId = 'Mth08' then set PhyMonth=8
                else
                  if MonthId = 'Mth09' then set PhyMonth=9
                  else
                    if MonthId = 'Mth10' then set PhyMonth=10
                    else
                      if MonthId = 'Mth11' then set PhyMonth=11
                      else
                        if MonthId = 'Mth12' then set PhyMonth=12
                        end if
                      end if
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  end if;
  if PhyMonth-In_PayPeriod >= 0 then set PhyYear=In_PayYear
  else set PhyYear=In_PayYear+1
  end if;
  return PhyYear
end
;

create function DBA.FGetPhyMonthGivenPayYrPeriod(
in In_PayGroupId char(20),
in In_PayYear integer,
in In_PayPeriod integer)
returns integer
begin
  declare PhyMonth integer;
  declare MonthId char(20);
  select PeriodMonth into MonthId from PeriodMessage where PeriodIdType = 'Period' and
    PayGroupId = In_PayGroupId and PeriodId = In_PayPeriod;
  if MonthId = 'Mth01' then set PhyMonth=1
  else if MonthId = 'Mth02' then set PhyMonth=2
    else if MonthId = 'Mth03' then set PhyMonth=3
      else
        if MonthId = 'Mth04' then set PhyMonth=4
        else
          if MonthId = 'Mth05' then set PhyMonth=5
          else
            if MonthId = 'Mth06' then set PhyMonth=6
            else
              if MonthId = 'Mth07' then set PhyMonth=7
              else
                if MonthId = 'Mth08' then set PhyMonth=8
                else
                  if MonthId = 'Mth09' then set PhyMonth=9
                  else
                    if MonthId = 'Mth10' then set PhyMonth=10
                    else
                      if MonthId = 'Mth11' then set PhyMonth=11
                      else
                        if MonthId = 'Mth12' then set PhyMonth=12
                        end if
                      end if
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  end if;
  return PhyMonth
end
;

create function DBA.FGetPaymentBankInfoBeneficiaryName(
in In_EmployeeSysId char(20),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30))
returns char(150)
begin
  declare Out_BeneficiaryName char(150);
  select BeneficiaryName into Out_BeneficiaryName from
    PaymentBankInfo where
    EmployeeSysId = In_EmployeeSysId and
    BankId = In_BankId and
    BankBranchId = In_BankBranchId and
    BankAccountNo = In_BankAccountNo;
  return(Out_BeneficiaryName)
end
;

create procedure dba.InsertNewMPFSubmitScheme(
in In_MPFSubmitForId char(20),
in In_MPFFormatName char(50),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_BooleanField4 smallint,
in In_BooleanField5 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_IntegerField4 integer,
in In_IntegerField5 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_NumericField4 double,
in In_NumericField5 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_DateField4 date,
in In_DateField5 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from MPFSubmitFormat where MPFSubmitForId = In_MPFSubmitForId and MPFFormatName = In_MPFFormatName) then
    set Out_ErrorCode=0; // format info must exist in MPFSubmitFormat
    return
  end if;
  insert into MPFSubmitScheme(MPFSubmitForId,
    MPFFormatName,
    BooleanField1,
    BooleanField2,
    BooleanField3,
    BooleanField4,
    BooleanField5,
    IntegerField1,
    IntegerField2,
    IntegerField3,
    IntegerField4,
    IntegerField5,
    NumericField1,
    NumericField2,
    NumericField3,
    NumericField4,
    NumericField5,
    DateField1,
    DateField2,
    DateField3,
    DateField4,
    DateField5,
    StringField1,
    StringField2,
    StringField3,
    StringField4,
    StringField5,
    StringField6,
    StringField7,
    StringField8,
    StringField9,
    StringField10,
    StringField11,
    StringField12,
    StringField13,
    StringField14,
    StringField15,
    StringField16,
    StringField17,
    StringField18,
    StringField19,
    StringField20) values(In_MPFSubmitForId,
    In_MPFFormatName,
    In_BooleanField1,
    In_BooleanField2,
    In_BooleanField3,
    In_BooleanField4,
    In_BooleanField5,
    In_IntegerField1,
    In_IntegerField2,
    In_IntegerField3,
    In_IntegerField4,
    In_IntegerField5,
    In_NumericField1,
    In_NumericField2,
    In_NumericField3,
    In_NumericField4,
    In_NumericField5,
    In_DateField1,
    In_DateField2,
    In_DateField3,
    In_DateField4,
    In_DateField5,
    In_StringField1,
    In_StringField2,
    In_StringField3,
    In_StringField4,
    In_StringField5,
    In_StringField6,
    In_StringField7,
    In_StringField8,
    In_StringField9,
    In_StringField10,
    In_StringField11,
    In_StringField12,
    In_StringField13,
    In_StringField14,
    In_StringField15,
    In_StringField16,
    In_StringField17,
    In_StringField18,
    In_StringField19,
    In_StringField20);
  commit work;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.ASQLProcessUpdatePayLabelName()
begin
  call ASQLUpdateDetailRecordKeywordLabel();
  call ASQLUpdateDetailRecordSysAttributeLabel();
  call ASQLUpdateDetailRecordCostKeywordLabel();
  commit work
end
;

create procedure dba.ASQLUpdateDetailRecordKeywordLabel()
begin
  declare CustDouble1_Id char(100);
  declare CustDouble2_Id char(100);
  declare CustDouble3_Id char(100);
  declare CustDouble4_Id char(100);
  declare CustDouble5_Id char(100);
  select NewLName into CustDouble1_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric1';
  select NewLName into CustDouble2_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric2';
  select NewLName into CustDouble3_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric3';
  select NewLName into CustDouble4_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric4';
  select NewLName into CustDouble5_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric5';
  if exists(select* from Keyword where
      KeywordId = 'FreeNumeric1') then
    update Keyword set KeywordUserDefinedName = CustDouble1_Id where
      KeywordId = 'FreeNumeric1'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'FreeNumeric2') then
    update Keyword set KeywordUserDefinedName = CustDouble2_Id where
      KeywordId = 'FreeNumeric2'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'FreeNumeric3') then
    update Keyword set KeywordUserDefinedName = CustDouble3_Id where
      KeywordId = 'FreeNumeric3'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'FreeNumeric4') then
    update Keyword set KeywordUserDefinedName = CustDouble4_Id where
      KeywordId = 'FreeNumeric4'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'FreeNumeric5') then
    update Keyword set KeywordUserDefinedName = CustDouble5_Id where
      KeywordId = 'FreeNumeric5'
  end if;
  commit work
end
;

create procedure dba.InsertNewMapGovtProg(
in In_GovtProgBasis1 char(20),
in In_GovtProgBasis2 char(20),
in In_GovtProgBasis3 char(20),
in In_GovtProgCreate smallint,
out Out_ErrorCode integer)
begin
  if In_GovtProgCreate = '' then
    set In_GovtProgCreate=0
  end if;
  if not exists(select* from MapGovtProg where GovtProgBasis1 = In_GovtProgBasis1 and
      GovtProgBasis2 = In_GovtProgBasis2 and
      GovtProgBasis3 = In_GovtProgBasis3) then
    insert into MapGovtProg(GovtProgBasis1,
      GovtProgBasis2,
      GovtProgBasis3,
      GovtProgCreate) values(
      In_GovtProgBasis1,
      In_GovtProgBasis2,
      In_GovtProgBasis3,
      In_GovtProgCreate);
    commit work;
    if not exists(select* from MapGovtProg where GovtProgBasis1 = In_GovtProgBasis1 and
        GovtProgBasis2 = In_GovtProgBasis2 and
        GovtProgBasis3 = In_GovtProgBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMapGovtProg(
in In_MapGovtProgSysId integer,
in In_GovtProgBasis1 char(20),
in In_GovtProgBasis2 char(20),
in In_GovtProgBasis3 char(20),
in In_GovtProgCreate smallint,
out Out_ErrorCode integer)
begin
  if In_GovtProgCreate = '' then
    set In_GovtProgCreate=0
  end if;
  if exists(select* from MapGovtProg where MapGovtProgSysId = In_MapGovtProgSysId) then
    update MapGovtProg set
      GovtProgBasis1 = In_GovtProgBasis1,
      GovtProgBasis2 = In_GovtProgBasis2,
      GovtProgBasis3 = In_GovtProgBasis3,
      GovtProgCreate = In_GovtProgCreate where
      MapGovtProgSysId = In_MapGovtProgSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMapGovtProg(
in In_MapGovtProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapGovtProg where MapGovtProg.MapGovtProgSysId = In_MapGovtProgSysId) then
    delete from MapGovtProg where MapGovtProg.MapGovtProgSysId = In_MapGovtProgSysId;
    commit work;
    if exists(select* from MapGovtProg where MapGovtProg.MapGovtProgSysId = In_MapGovtProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.ASQLUpdateGovtProgBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'GovtProgBasis' and SubRegistryId = 'GovtProgEmpLoc1Id'
  end if;
  commit work
end
;

create procedure dba.ASQLCalPayRecUserDefinedWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LeaveDeductAmt double,
out Out_BackPay double,
out Out_TotalWage double,
out Out_NonCPFAllowance double,
out Out_CPFAllowance double,
out Out_NonCPFDeduction double,
out Out_CPFDeduction double,
out Out_AllAllowance double,
out Out_AllDeduction double,
out Out_Reimbursement double,
out Out_UserDefinedWage double)
begin
  declare UserDefinedWage double;
  set UserDefinedWage=0;
  set Out_OTAmount=0;
  set Out_OTBackPay=0;
  set Out_ShiftAmount=0;
  set Out_LeaveDeductAmt=0;
  set Out_BackPay=0;
  set Out_TotalWage=0;
  set Out_NonCPFAllowance=0;
  set Out_CPFAllowance=0;
  set Out_NonCPFDeduction=0;
  set Out_CPFDeduction=0;
  set Out_AllAllowance=0;
  set Out_AllDeduction=0;
  set Out_Reimbursement=0;
  if(IsWageElementInUsed('OTAmount','UserDefinedWage') = 1) then
    select CalOTAmount into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_OTAmount
  end if;
  if(IsWageElementInUsed('OTBackPay','UserDefinedWage') = 1) then
    select CalOTBackPay into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_OTBackPay
  end if;
  if(IsWageElementInUsed('ShiftAmount','UserDefinedWage') = 1) then
    select CalShiftAmount into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_ShiftAmount
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','UserDefinedWage') = 1) then
    select CalLveDeductAmt into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_LeaveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','UserDefinedWage') = 1) then
    select CalBackPay into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_BackPay
  end if;
  if(IsWageElementInUsed('TotalWage','UserDefinedWage') = 1) then
    select CalTotalWage into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set UserDefinedWage=UserDefinedWage+Out_TotalWage
  end if;
  if(IsWageElementInUsed('NonCPFUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonMPFUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonContriUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonTAPUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonEPFUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonJamsoUDAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('NonPFSSUDAllowance','UserDefinedWage') = 1) then
    select FGetPayRecNonCPFUserDefinedAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFAllowance;
    set UserDefinedWage=UserDefinedWage+Out_NonCPFAllowance
  end if;
  if(IsWageElementInUsed('UDCPFAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDMPFAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDManContriAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDTAPAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDEPFAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDJamsoAllowance','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDPFSSAllowance','UserDefinedWage') = 1) then
    select FGetPayRecCPFUserDefinedAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFAllowance;
    set UserDefinedWage=UserDefinedWage+Out_CPFAllowance
  end if;
  if(IsWageElementInUsed('UDNonCPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonMPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonContriDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonTAPDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonEPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonJamsoDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDNonPFSSDeduction','UserDefinedWage') = 1) then
    select FGetPayRecNonCPFUserDefinedDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_NonCPFDeduction;
    set UserDefinedWage=UserDefinedWage+Out_NonCPFDeduction
  end if;
  if(IsWageElementInUsed('UDCPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDMPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDManContriDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDTAPDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDEPFDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDJamsoDeduction','UserDefinedWage') = 1 or
    IsWageElementInUsed('UDPFSSDeduction','UserDefinedWage') = 1) then
    select FGetPayRecCPFUserDefinedDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFDeduction;
    set UserDefinedWage=UserDefinedWage+Out_CPFDeduction
  end if;
  if(IsWageElementInUsed('UDAllAllowance','UserDefinedWage') = 1) then
    select FGetPayRecAllUserDefinedAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllAllowance;
    set UserDefinedWage=UserDefinedWage+Out_AllAllowance
  end if;
  if(IsWageElementInUsed('UDAllDeduction','UserDefinedWage') = 1) then
    select FGetPayRecAllUserDefinedDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_AllDeduction;
    set UserDefinedWage=UserDefinedWage+Out_AllDeduction
  end if;
  if(IsWageElementInUsed('UDReimbursement','UserDefinedWage') = 1) then
    select FGetPayRecAllUserDefinedReimbursement(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_Reimbursement;
    set UserDefinedWage=UserDefinedWage+Out_Reimbursement
  end if;
  set Out_UserDefinedWage=Round(UserDefinedWage,FGetDBPayDecimal(*));
  commit work
end
;

create function dba.FGetPayRecAllUserDefinedAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Allowance' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID and
    FormulaStage < 40;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecAllUserDefinedDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Deduction' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID and
    FormulaStage < 40;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecAllUserDefinedReimbursement(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
    AllowanceFormulaid = Formulaid and
    FormulaSubCategory = 'Reimbursement' and
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID and
    FormulaStage < 40;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecCPFUserDefinedAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') = 1)
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') = 1)
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') = 1)
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') = 1)
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') = 1)
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecCPFUserDefinedDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') = 1)
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') = 1)
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') = 1)
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') = 1)
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') = 1)
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecNonCPFUserDefinedAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') <> 1
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') <> 1
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') <> 1
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') <> 1
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') <> 1
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') <> 1
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') <> 1
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create function dba.FGetPayRecNonCPFUserDefinedDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if(FGetDBCountry(*) = 'Brunei') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP1') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP2') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') <> 1
  elseif(FGetDBCountry(*) = 'Singapore') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') <> 1
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERManEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjEEVolEPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjERVolEPF') <> 1
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjJamso') <> 1
  elseif(FGetDBCountry(*) = 'Philippines') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSSS') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjPHIC') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjHDMF') <> 1
  elseif(FGetDBCountry(*) = 'HongKong') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjMPFVolAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOManAdd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolOrd') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjORSOVolAdd') <> 1
  elseif(FGetDBCountry(*) = 'Thailand') then
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      FormulaStage < 40 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjNormalPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSpecialPF') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSS') <> 1
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

create procedure dba.ASQLUpdateDetailRecordSysAttributeLabel()
begin
  declare CustDouble1_Id char(100);
  declare CustDouble2_Id char(100);
  declare CustDouble3_Id char(100);
  declare CustDouble4_Id char(100);
  declare CustDouble5_Id char(100);
  select NewLName into CustDouble1_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric1';
  select NewLName into CustDouble2_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric2';
  select NewLName into CustDouble3_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric3';
  select NewLName into CustDouble4_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric4';
  select NewLName into CustDouble5_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric5';
  if exists(select* from SystemAttribute where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric1') then
    update SystemAttribute set SysUserdefinedName = CustDouble1_Id where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric2') then
    update SystemAttribute set SysUserdefinedName = CustDouble2_Id where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric3') then
    update SystemAttribute set SysUserdefinedName = CustDouble3_Id where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric4') then
    update SystemAttribute set SysUserdefinedName = CustDouble4_Id where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric4'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric5') then
    update SystemAttribute set SysUserdefinedName = CustDouble5_Id where
      SysTableId = 'DetailRecord' and SysAttributeId = 'Ana_FreeNumeric5'
  end if;
  commit work
end
;

create procedure DBA.ASQLGetPeriodLastLveDedDayHourRate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_LeaveType char(20),
out Out_LastLveDedDayRateAmt double,
out Out_LastLveDedHourRateAmt double)
begin
  declare In_PayRecSubPeriod integer;
  if In_PayRecPeriod = 1 then
    set In_PayRecYear=In_PayRecYear-1;
    set In_PayRecPeriod=12
  else
    set In_PayRecPeriod=In_PayRecPeriod-1
  end if;
  select max(PayRecSubPeriod) into In_PayRecSubPeriod from SubPeriodSetting where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if In_PayRecSubPeriod is null then
    set Out_LastLveDedDayRateAmt=0;
    set Out_LastLveDedHourRateAmt=0;
    return
  end if;
  select CurrentDayRateAmt,CurrentHourRateAmt into Out_LastLveDedDayRateAmt,
    Out_LastLveDedHourRateAmt from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    LeaveTypeFunctCode = In_LeaveType
end
;

create function DBA.FGetPayCategoryID(
in in_EmployeeSysId integer,
in in_PayRecYear integer,
in in_PayRecPeriod integer)
returns char(100)
begin
  declare Out_PayCategoryID char(100);
  select PayCategoryId into Out_PayCategoryId from PayPeriodRecord where
    EmployeeSysId = in_EmployeeSysId and
    PayRecYear = in_PayRecYear and
    PayRecPeriod = in_PayRecPeriod;
  if Out_PayCategoryID is null then set Out_PayCategoryID=''
  end if;
  return Out_PayCategoryID
end
;

create function DBA.FGetDBOTDecimal()
returns integer
begin
  declare Out_IntegerAttr integer;
  select IntegerAttr into Out_IntegerAttr from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBOTDecimal';
  return Out_IntegerAttr
end
;

create function dba.FGetPayPeriodLveAmount(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_LeaveType char(20))
returns double
begin
  declare Amt double;
  select sum(LveAmount) into Amt from LeaveDeductionRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and LeaveTypeFunctCode = In_LeaveType;
  if Amt is null then
    return 0
  else
    return Amt
  end if
end
;

create function DBA.FGetEmpeeOtherInfoNumericInfo(
in In_Type char(30),
in In_EmployeeSysId integer)
returns double
begin
  declare Out_Result double;
  select EmpeeOtherInfo.EmpeeOtherInfoDouble into Out_Result
    from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId and
    EmpeeOtherInfo.EmpeeOtherInfoId = In_Type;
  return(Out_Result)
end
;

create function DBA.FGetFormulaType(
in In_FormulaID char(20))
returns char(20)
begin
  declare fresult char(20);
  select FormulaType into fresult from Formula where FormulaID = In_FormulaID;
  return(fresult)
end
;

create function DBA.FGetBankAddress(
in In_BankId char(20),
in In_BankBranchId char(20))
returns char(150)
begin
  declare Out_BankAddress char(150);
  select BankBranch.BankAddress into Out_BankAddress
    from BankBranch where
    BankBranch.BankId = In_BankId and
    BankBranch.BankBranchId = In_BankBranchId;
  return(Out_BankAddress)
end;

create function DBA.FGetBankCountry(
in In_BankId char(20),
in In_BankBranchId char(20))
returns char(60)
begin
  declare Out_BankCountry char(60);
  select BankBranch.BankCountry into Out_BankCountry
    from BankBranch where
    BankBranch.BankId = In_BankId and
    BankBranch.BankBranchId = In_BankBranchId;
  return(Out_BankCountry)
end
;

create procedure dba.ASQLUpdateDetailRecordCostKeywordLabel()
begin
  declare CustDouble1_Id char(100);
  declare CustDouble2_Id char(100);
  declare CustDouble3_Id char(100);
  declare CustDouble4_Id char(100);
  declare CustDouble5_Id char(100);
  select NewLName into CustDouble1_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric1';
  select NewLName into CustDouble2_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric2';
  select NewLName into CustDouble3_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric3';
  select NewLName into CustDouble4_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric4';
  select NewLName into CustDouble5_Id from LabelName where TableName = 'DetailRecord' and AttributeName = 'FreeNumeric5';
  if exists(select* from CostKeyword where
      CostKeywordId = 'FreeNumeric1') then
    update CostKeyword set CostKeywordUserDefinedName = CustDouble1_Id,CostKeywordDesc = CustDouble1_Id where
      CostKeywordId = 'FreeNumeric1'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'FreeNumeric2') then
    update CostKeyword set CostKeywordUserDefinedName = CustDouble2_Id,CostKeywordDesc = CustDouble2_Id where
      CostKeywordId = 'FreeNumeric2'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'FreeNumeric3') then
    update CostKeyword set CostKeywordUserDefinedName = CustDouble3_Id,CostKeywordDesc = CustDouble3_Id where
      CostKeywordId = 'FreeNumeric3'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'FreeNumeric4') then
    update CostKeyword set CostKeywordUserDefinedName = CustDouble4_Id,CostKeywordDesc = CustDouble4_Id where
      CostKeywordId = 'FreeNumeric4'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'FreeNumeric5') then
    update CostKeyword set CostKeywordUserDefinedName = CustDouble5_Id,CostKeywordDesc = CustDouble5_Id where
      CostKeywordId = 'FreeNumeric5'
  end if;
  commit work
end
;
