if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBalCPF') then
  drop procedure ASQLCalPayPeriodBalCPF
end if;
create procedure DBA.ASQLCalPayPeriodBalCPF(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_ContriOrdEECPF double,
out Out_ContriAddEECPF double,
out Out_ContriOrdERCPF double,
out Out_ContriAddERCPF double,
out Out_ExcessAddEECPF double,
out Out_ExcessAddERCPF double)
begin
  declare Tmp_ContriOrdEECPF double;
  declare Tmp_ContriAddEECPF double;
  declare Tmp_ContriOrdERCPF double;
  declare Tmp_ContriAddERCPF double;
  declare Tmp_ExcessAddEECPF double;
  declare Tmp_ExcessAddERCPF double;
  select sum(ContriOrdEECPF),sum(ContriAddEECPF),Sum(ContriOrdERCPF),sum(ContriAddERCPF),
         sum(CurrentAddTaxWage),sum(PreviousAddTaxWage) into Out_ContriOrdEECPF,
    Out_ContriAddEECPF,Out_ContriOrdERCPF,
    Out_ContriAddERCPF,
    Out_ExcessAddEECPF,Out_ExcessAddERCPF from PolicyRecord where
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
  if Out_ExcessAddEECPF is null then set Out_ExcessAddEECPF=0
  end if;
  if Out_ExcessAddERCPF is null then set Out_ExcessAddERCPF=0
  end if;

  /*
  Get the specified Record
  */
  select sum(ContriOrdEECPF),sum(ContriAddEECPF),Sum(ContriOrdERCPF),sum(ContriAddERCPF),
         sum(CurrentAddTaxWage),sum(PreviousAddTaxWage) into Tmp_ContriOrdEECPF,
    Tmp_ContriAddEECPF,Tmp_ContriOrdERCPF,
    Tmp_ContriAddERCPF,
    Tmp_ExcessAddEECPF,Tmp_ExcessAddERCPF from PolicyRecord where
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
  set Out_ContriAddERCPF=Out_ContriAddERCPF-Tmp_ContriAddERCPF;
  set Out_ExcessAddEECPF=Out_ExcessAddEECPF-Tmp_ExcessAddEECPF;
  set Out_ExcessAddERCPF=Out_ExcessAddERCPF-Tmp_ExcessAddERCPF;
end
;

if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodCPFWage') then
  drop procedure ASQLCalPayPeriodCPFWage
end if;
create procedure DBA.ASQLCalPayPeriodCPFWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_CurOrdinaryWage double,
out Out_CurAdditionalWage double,
out Out_PrevOrdinaryWage double,
out Out_PrevAdditionalWage double,
out Out_CPFWage double,
out Out_ExcessCurAddWage double)
begin
  select sum(CurOrdinaryWage),sum(CurAdditionalWage),Sum(PrevOrdinaryWage),sum(PrevAdditionalWage),sum(CPFWage),sum(CurrentTaxWage) into Out_CurOrdinaryWage,
    Out_CurAdditionalWage,Out_PrevOrdinaryWage,Out_PrevAdditionalWage,
    Out_CPFWage,Out_ExcessCurAddWage from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod
end
;

if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBalExcessCPF') then
  drop procedure ASQLCalPayPeriodBalExcessCPF
end if;
Create PROCEDURE DBA.ASQLCalPayPeriodBalExcessCPF(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_ExcessAddEECPF double,
out Out_ExcessAddERCPF double)
begin
  declare Period_AddEECPF double;
  declare Period_AddERCPF double;
  declare Tmp_AddEECPF double;
  declare Tmp_AddERCPF double;
  declare Tmp_AddExcessEECPF double;
  declare Tmp_AddExcessERCPF double;
  set Period_AddEECPF = 0;
  set Period_AddERCPF = 0;
  set Tmp_AddEECPF = 0;
  set Tmp_AddERCPF = 0;
  set Tmp_AddExcessEECPF = 0;
  set Tmp_AddExcessERCPF = 0;
  
  /* Get EE & ER Period Contribution for both Contributed & Excess from PeriodPolicySummary */ 
  select ContriAddEECPF+CurrentAddTaxWage, ContriAddERCPF+PreviousAddTaxWage into Out_ExcessAddEECPF,Out_ExcessAddERCPF from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Out_ExcessAddEECPF is null then set Out_ExcessAddEECPF=0
  end if;
  if Out_ExcessAddERCPF is null then set Out_ExcessAddERCPF=0
  end if;

  /* Recalculate the Excess CPF if has excess */ 
  /* Get EE & ER Period Contribution for both Contributed & Excess from PolicyRecord */
  select sum(ContriAddEECPF+CurrentAddTaxWage),sum(ContriAddERCPF+PreviousAddTaxWage) into Period_AddEECPF, Period_AddERCPF from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Period_AddEECPF is null then set Period_AddEECPF=0
  end if;
  if Period_AddERCPF is null then set Period_AddERCPF=0
  end if;

  /*
  Get the specified Record
  */
  select sum(ContriAddEECPF),sum(ContriAddERCPF),sum(CurrentAddTaxWage),sum(PreviousAddTaxWage) into Tmp_AddEECPF, Tmp_AddERCPF,
    Tmp_AddExcessEECPF, Tmp_AddExcessERCPF from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  if Tmp_AddEECPF is null then set Tmp_AddEECPF=0
  end if;
  if Tmp_AddERCPF is null then set Tmp_AddERCPF=0
  end if;
  if Tmp_AddExcessEECPF is null then set Tmp_AddExcessEECPF=0
  end if;
  if Tmp_AddExcessERCPF is null then set Tmp_AddExcessERCPF=0
  end if;
 
  /*
   Deduct away from the specified
  */
  set Out_ExcessAddEECPF=Out_ExcessAddEECPF-(Period_AddEECPF-(Tmp_AddEECPF+Tmp_AddExcessEECPF))-Tmp_AddEECPF;
  set Out_ExcessAddERCPF=Out_ExcessAddERCPF-(Period_AddERCPF-(Tmp_AddERCPF+Tmp_AddExcessERCPF))-Tmp_AddERCPF;
end
;

if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBalCPFAddWage') then
  drop procedure ASQLCalPayPeriodBalCPFAddWage
end if;
Create PROCEDURE DBA.ASQLCalPayPeriodBalCPFAddWage( 
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_ExcessCurAddWage double,
out Out_CurAddWage double
)
begin
  declare Tmp_ExcessCurAddWage double;
  declare Tmp_CurAddWage double;
  select sum(CurrentTaxWage), sum(CurAdditionalWage) into Out_ExcessCurAddWage,Out_CurAddWage from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and 
    PayRecSubPeriod <= In_PayRecSubPeriod;
  if Out_ExcessCurAddWage is null then set Out_ExcessCurAddWage=0
  end if;
  if Out_CurAddWage is null then set Out_CurAddWage=0
  end if;
  /*
  Get the specified Record
  */
  select sum(CurrentTaxWage),sum(CurAdditionalWage) into Tmp_ExcessCurAddWage,
    Tmp_CurAddWage from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Deduct away from the specified
  */
  set Out_ExcessCurAddWage=Out_ExcessCurAddWage-Tmp_ExcessCurAddWage;
  set Out_CurAddWage=Out_CurAddWage-Tmp_CurAddWage;
end
;
commit work;