if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLveCreditRemaks') then
   drop procedure DBA.FGetLveCreditRemaks
end if;

create FUNCTION DBA.FGetLveCreditRemaks(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LeaveStatus char(20),
in In_LeaveDate date)
RETURNS char(100)
BEGIN
	DECLARE Out_Result char(100);
    DECLARE TempDate date;
    SET Out_Result = '';

	If In_LeaveStatus = 'Earned' then
       Select CreditExpireDate into TempDate from AdjustCredit
         where EmployeeSysId = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and AdjEffectiveDate = In_LeaveDate ;
       If FGetInvalidDate(TempDate) != '' then
          set Out_Result = 'Expired on ' + FGetDateFormat(TempDate);
       end if;
    end if; 

	If In_LeaveStatus = 'Expired' then
       Select AdjEffectiveDate into TempDate from AdjustCredit
         where EmployeeSysId = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and CreditExpireDate = In_LeaveDate ;
       If FGetInvalidDate(TempDate) != '' then
          set Out_Result = 'Earned on ' + FGetDateFormat(TempDate);
       end if;
    end if; 

	RETURN Out_Result;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
   drop procedure DBA.ASQLCalPayRecNetWage
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

  if (In_NetWage = Out_AllocatedBasicRate and Out_CurrentBRExRateId = Out_NetWageExRateId) then
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

commit work;








