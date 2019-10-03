Read UpgradeDB\Ver1061001\Entity.sql;
Read UpgradeDB\Ver1061001\PerAttCategory.sql;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewBankBranch') then
   drop procedure InsertNewBankBranch;
end if;
create procedure dba.InsertNewBankBranch(
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankBranchDesc char(60),
in In_BankAddress char(150),
in In_BankPCode char(20),
in In_BankCity char(60),
in In_BankState char(60),
in In_BankCountry char(60),
in In_BankBranchString1 char(100))
begin
  if not exists(select* from BankBranch where BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId) then
    insert into BankBranch(BankId,BankBranchId,
      BankBranchDesc,BankAddress,BankPCode,
      BankCity,BankState,BankCountry,BankBranchString1) values(
      In_BankId,In_BankBranchId,In_BankBranchDesc,In_BankAddress,In_BankPCode,
      In_BankCity,In_BankState,In_BankCountry,In_BankBranchString1);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateBankBranch') then
   drop procedure UpdateBankBranch;
end if;
create procedure dba.UpdateBankBranch(
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankBranchDesc char(60),
in In_BankAddress char(150),
in In_BankPCode char(20),
in In_BankCity char(60),
in In_BankState char(60),
in In_BankCountry char(60),
in In_BankBranchString1 char(100))
begin
  if exists(select* from BankBranch where BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId) then
    update BankBranch set
      BankBranch.BankBranchDesc = In_BankBranchDesc,
      BankBranch.BankAddress = In_BankAddress,
      BankBranch.BankPCode = In_BankPCode,
      BankBranch.BankCity = In_BankCity,
      BankBranch.BankState = In_BankState,
      BankBranch.BankCountry = In_BankCountry, 
      BankBranch.BankBranchString1 = In_BankBranchString1 where
      BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayRecAllStatutoryDeduction') then
   drop function FGetPayRecAllStatutoryDeduction;
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
    select ContriOrdEECPF+CurrEEManContri into TotalAmount
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

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
   drop procedure ASQLCalPayRecNetWage;
end if;
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
  Indonesia consider EE Jamsostek & Tax Amt (For Gross To Net)
  */
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select ContriOrdEECPF+CurrEEManContri into In_TotalContriEECPF from PolicyRecord where
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

if not exists(select * from Subregistry where SubRegistryId = 'TMSViewLabelName') then
 Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1) values ('SageProdIntegrate','TMSViewLabelName','View_TMS_LabelName');
end if;

commit work;