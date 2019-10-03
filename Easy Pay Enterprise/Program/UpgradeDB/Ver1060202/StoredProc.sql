if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPeriodAllowance' and user_name(creator) = 'DBA') then
   drop function DBA.FGetPeriodAllowance
end if;

create function DBA.FGetPeriodAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalAmount double;
  if FGetDBCountry(*) = 'Malaysia' then
    Select Sum(if SubString(FormulaId,1,6) = 'Arrear' And FormulaType='Formula' then UserDef1Value else AllowanceAmount endif) into TotalAmount
        from (AllowanceRecord left outer join AllowanceHistoryRecord),Formula where
        AllowanceFormulaid = Formulaid and
        FormulaSubCategory = 'Allowance' and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
  else
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
        AllowanceFormulaid = Formulaid and
        FormulaSubCategory = 'Allowance' and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
  end if;  
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecNonCPFAllowance' and user_name(creator) = 'DBA') then
   drop function DBA.FGetPayRecNonCPFAllowance
end if;

create function DBA.FGetPayRecNonCPFAllowance(
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
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjTAP3') <> 1 and
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjSCP') <> 1
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
    Select Sum(if SubString(FormulaId,1,6) = 'Arrear' And FormulaType='Formula' then UserDef1Value else AllowanceAmount endif) into TotalAmount
      from (AllowanceRecord left outer join AllowanceHistoryRecord),Formula where
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
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllAllowance' and user_name(creator) = 'DBA') then
   drop function DBA.FGetPayRecAllAllowance
end if;

create function DBA.FGetPayRecAllAllowance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;

  if FGetDBCountry(*) = 'Malaysia' then

    Select Sum(if SubString(FormulaId,1,6) = 'Arrear' And FormulaType='Formula' then UserDef1Value else AllowanceAmount endif) into TotalAmount
        from (AllowanceRecord left outer join AllowanceHistoryRecord),Formula where
        AllowanceFormulaid = Formulaid and
        FormulaSubCategory = 'Allowance' and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID;

  else
    select Sum(AllowanceAmount) into TotalAmount from AllowanceRecord,Formula where
        AllowanceFormulaid = Formulaid and
        FormulaSubCategory = 'Allowance' and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID;
  end if;

  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end;
