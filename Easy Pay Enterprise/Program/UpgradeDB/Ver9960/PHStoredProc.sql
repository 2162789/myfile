if exists(select 1 from sys.sysprocedure where proc_name = 'FGetContriOrdEECPF') then
   drop procedure FGetContriOrdEECPF
end if
;

CREATE FUNCTION "DBA"."FGetContriOrdEECPF"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalContriOrdEECPF double;
  select ContriOrdEECPF into TotalContriOrdEECPF
    from PeriodPolicySummary where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    EmployeeSysId = In_EmployeeSysId;
  if TotalContriOrdEECPF is null then set TotalContriOrdEECPF=0
  end if;
  return TotalContriOrdEECPF
end
;



if exists(select 1 from sys.sysprocedure where proc_name = 'FGetContriOrdERCPF') then
   drop procedure FGetContriOrdERCPF
end if
;

CREATE FUNCTION "DBA"."FGetContriOrdERCPF"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalContriOrdERCPF double;
  select ContriOrdERCPF into TotalContriOrdERCPF
    from PeriodPolicySummary where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    EmployeeSysId = In_EmployeeSysId;
  if TotalContriOrdERCPF is null then set TotalContriOrdERCPF=0
  end if;
  return TotalContriOrdERCPF
end
;




if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCurOrdinaryWage') then
   drop procedure FGetCurOrdinaryWage
end if
;

CREATE FUNCTION "DBA"."FGetCurOrdinaryWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare TotalCurOrdinaryWage double;
  select CurOrdinaryWage into TotalCurOrdinaryWage
    from PeriodPolicySummary where
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    EmployeeSysId = In_EmployeeSysId;
  if TotalCurOrdinaryWage is null then set TotalCurOrdinaryWage=0
  end if;
  return TotalCurOrdinaryWage
end
;