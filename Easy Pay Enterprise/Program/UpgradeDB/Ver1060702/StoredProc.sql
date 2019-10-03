if exists(select * from sys.sysprocedure where proc_name = 'FGetPayRecCPFDeduction') then
   drop procedure FGetPayRecCPFDeduction;
end if;

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
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSCP') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
  // For if PayRecID=blank, means sum all Pay Records.
    if (In_PayRecID != '') then
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
    else
      select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
    end if;
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

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayRecCPFAllowance') then
   drop procedure FGetPayRecCPFAllowance
end if;

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
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSCP') = 1)
  elseif(FGetDBCountry(*) = 'Singapore') then
  // For if PayRecID=blank, means sum all Pay Records.
    if (In_PayRecID != '') then
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
    else
      select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1)
    end if;  
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

commit work;