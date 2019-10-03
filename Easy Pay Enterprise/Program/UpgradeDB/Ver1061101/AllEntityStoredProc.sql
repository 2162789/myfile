if not exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoBPJSPensiunOption') then
    alter table DBA.IndoTaxEmployer Add IndoBPJSPensiunOption smallint;
end if;

Update IndoTaxEmployer Set IndoBPJSPensiunOption = 0;

if not exists(select 1 from sys.syscolumns where tname='iYTDIDPolicy' and cname='EmployeeBPJSPensiun') then
    alter table DBA.iYTDIDPolicy Add EmployeeBPJSPensiun double;
end if;

if not exists(select 1 from sys.syscolumns where tname='iYTDIDPolicy' and cname='EmployerBPJSPensiun') then
    alter table DBA.iYTDIDPolicy Add EmployerBPJSPensiun double;
end if;

if not exists(select 1 from sys.syscolumns where tname='MandatoryContributeProg' and cname='ManContriActSchemeId') then
    alter table DBA.MandatoryContributeProg Add ManContriActSchemeId char(20);
end if;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
   drop procedure ASQLCalPayRecNetWage;
end if;
Create PROCEDURE "DBA"."ASQLCalPayRecNetWage"(
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

  declare Out_AllocatedBasicRate double;
  declare Out_AllocatedBasicRateF double;
  declare Out_CurrentBRExRateId char(20);
  declare Out_NetWageExRateId char(20);

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
    select TotalContriEECPF + ContriOrdEECPF + ContriAddEECPF + CurrEEManContri into In_TotalContriEECPF from PolicyRecord 

where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Indonesia consider EE Jamsostek, EE BPJS Kesehatan, EE BPJS Pensiun & Tax Amt (For Gross To Net)
  */
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri into In_TotalContriEECPF from PolicyRecord where
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
    select CurrEEVolContri+PrevEEVolContri+CurrEEVolWage+PrevEEVolWage+ContriAddEECPF,PreviousTaxAmount+CurNWCHrDaysRate into 

In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
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
    select ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+CurrEEManWage+PrevEEManWage,PaidCurrentTaxAmt into 

In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
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

  select AllocatedBasicRate,AllocatedBasicRateF,CurrentBRExRateId,NetWageExRateId into
         Out_AllocatedBasicRate,Out_AllocatedBasicRateF,Out_CurrentBRExRateId,Out_NetWageExRateId from DetailRecord where
         EmployeeSysId = In_EmployeeSysId and
         PayRecYear = In_PayRecYear and
         PayRecPeriod = In_PayRecPeriod and
         PayRecSubPeriod = In_PayRecSubPeriod and
         PayRecID = In_PayRecID;

  if (In_NetWage = Out_AllocatedBasicRate and Out_CurrentBRExRateId = Out_NetWageExRateId and Length(Out_CurrentBRExRateId)>0) then
    set In_NetWageP=Out_AllocatedBasicRateF;  
  else  
    set In_NetWageP=Round(In_NetWage*In_NetWageExRate,FGetDBPayDecimal(*));
  end if;  

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

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayRecAllStatutoryDeduction') then
   drop FUNCTION FGetPayRecAllStatutoryDeduction;
end if;
CREATE FUNCTION "DBA"."FGetPayRecAllStatutoryDeduction"(
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
      ContriAddEECPF+
      CurrEEManContri
      into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Indonesia' then
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri into TotalAmount
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
      ContriOrdEECPF+ 
      PaidCurrentTaxAmt+
      PaidPreviousTaxAmt
      into TotalAmount
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

commit work;