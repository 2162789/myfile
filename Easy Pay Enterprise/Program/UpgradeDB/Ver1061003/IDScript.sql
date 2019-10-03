if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBPJSKSWage') then
   drop procedure ASQLCalPayPeriodBPJSKSWage
end if;
Create PROCEDURE "DBA"."ASQLCalPayPeriodBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare Temp_TotalWageAmtNormal double;
  declare Temp_TotalWageAmtNonNormal double;
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Temp_TotalWageAmtNormal=0;
  set Temp_TotalWageAmtNonNormal=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
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
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select (case CurrentBasicRateType when 'MonthlyRated' then sum(CurrentBasicRate) else sum(CalTotalWage) end) into Temp_TotalWageAmtNormal from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and 
      PayRecId = 'Normal'
      group by CurrentBasicRateType;
    select sum(CalTotalWage) into Temp_TotalWageAmtNonNormal from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and 
      PayRecId <> 'Normal';
    if Temp_TotalWageAmtNormal is null then set Temp_TotalWageAmtNormal=0
    end if;
    if Temp_TotalWageAmtNonNormal is null then set Temp_TotalWageAmtNonNormal=0
    end if;
    set Out_TotalWageAmt=Temp_TotalWageAmtNormal+Temp_TotalWageAmtNonNormal;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecBPJSKSWage') then
   drop procedure ASQLCalPayRecBPJSKSWage
end if;
CREATE PROCEDURE "DBA"."ASQLCalPayRecBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
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
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select (case CurrentBasicRateType when 'MonthlyRated' then 
             (if PayRecID = 'Normal' then CurrentBasicRate else CalTotalWage endif) 
           else CalTotalWage end) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

commit work;