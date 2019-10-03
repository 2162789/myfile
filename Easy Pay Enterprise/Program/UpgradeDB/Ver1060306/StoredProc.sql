If exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
  drop procedure ASQLCalPayRecNetWage
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
    select TotalContriEECPF + ContriOrdEECPF + ContriAddEECPF + CurrEEManContri into In_TotalContriEECPF 

from PolicyRecord 

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
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri+PrevEEManContri+PrevEEVolContri into 

In_TotalContriEECPF
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
    select 

CurrEEVolContri+PrevEEVolContri+CurrEEVolWage+PrevEEVolWage+ContriAddEECPF,PreviousTaxAmount+CurNWCHrDaysR

ate into 

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
    select 

ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+CurrEEManWage+PrevEEManWage,PaidCurrentTax

Amt into 

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
    FGetPayRecAllPayElement

(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID)+
    In_CalLveDeductAmt-
    In_TotalContriEECPF-
    In_TaxAmt;
  set In_NetWage=Round(In_NetWage,FGetDBPayDecimal(*));

  select AllocatedBasicRate,AllocatedBasicRateF,CurrentBRExRateId,NetWageExRateId into
         Out_AllocatedBasicRate,Out_AllocatedBasicRateF,Out_CurrentBRExRateId,Out_NetWageExRateId from 

DetailRecord where
         EmployeeSysId = In_EmployeeSysId and
         PayRecYear = In_PayRecYear and
         PayRecPeriod = In_PayRecPeriod and
         PayRecSubPeriod = In_PayRecSubPeriod and
         PayRecID = In_PayRecID;

  if (In_NetWage = Out_AllocatedBasicRate and Out_CurrentBRExRateId = Out_NetWageExRateId and Length

(Out_CurrentBRExRateId)>0) then
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

If exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCreateOTRecord') then
  drop procedure ASQLCreateOTRecord
end if;

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
      set In_CurrentOTRate=round(cast(In_OTRate*In_CalOTDayRate as numeric(21,8)),In_DecimalPlace);
      set In_LastOTRate=round(cast(In_OTRate*In_CalOTLastDayRate as numeric(21,8)),In_DecimalPlace);
      set In_BackPayOTRate=round(cast(In_OTRate*In_BackPayDayRate as numeric(21,8)),In_DecimalPlace);
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
      set In_CurrentOTRate=round(cast(In_OTRate*In_CalOTHourRate as numeric(21,8)),In_DecimalPlace);
      set In_LastOTRate=round(cast(In_OTRate*In_CalOTLastHourRate as numeric(21,8)),In_DecimalPlace);
      set In_BackPayOTRate=round(cast(In_OTRate*In_BackPayHourRate as numeric(21,8)),In_DecimalPlace);
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

If exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalOTRecord') then
  drop procedure ASQLRecalOTRecord
end if;

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
      set In_CurrentOTAmount=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as numeric

(21,8)),FGetDBPayDecimal(*));
      set In_LastOTAmount=Round(cast(In_LastOTFreq*In_LastOTRate as numeric(21,8)),FGetDBPayDecimal(*));
      set In_BackPayOTAmount=Round(cast(In_BackPayOTFreq*In_BackPayOTRate as numeric

(21,8)),FGetDBPayDecimal(*));
      set In_OTAmountF=0
    /*
    Hour Rate
    */
    elseif(In_OTType = 'OTHourRate') then
      set In_CurrentOTAmount=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as numeric

(21,8)),FGetDBPayDecimal(*));
      set In_LastOTAmount=Round(cast(In_LastOTFreq*In_LastOTRate as numeric(21,8)),FGetDBPayDecimal(*));
      set In_BackPayOTAmount=Round(cast(In_BackPayOTFreq*In_BackPayOTRate as numeric

(21,8)),FGetDBPayDecimal(*));
      set In_OTAmountF=0
    /*
    Fixed Rate
    */
    elseif(In_OTType = 'OTFixedRate') then
      set In_OTAmountF=Round(cast(In_CurrentOTFreq*In_CurrentOTRate as numeric(21,8)),FGetDBPayDecimal

(*));
      if(In_OTAmountF > In_MaxFreq and In_MaxFreq <> 0) then
        set In_OTAmountF=Round(In_MaxFreq,FGetDBPayDecimal(*))
      end if;
      set In_CurrentOTAmount=Round(cast(In_OTAmountF*In_OTExRate as numeric(21,8)),FGetDBPayDecimal(*));
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

If exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateOTRecord') then
  drop procedure ASQLUpdateOTRecord
end if;

CREATE PROCEDURE DBA.ASQLUpdateOTRecord(
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
    select FormulaSubCategory,FormulaExRateId into In_OTType,In_FormulaExRateId from Formula where 

FormulaId = In_OTRateId;
    select Constant1,Constant2,Constant3,Constant4 into In_OTRate,In_MaxFreq,In_MinRateAmt,
      In_MaxRateAmt from Formula join FormulaRange where Formula.FormulaId = In_OTRateId;
    if(In_FormulaExRateId <> '') then
      select first ForeignLocalRate into In_ForeignLocalRate
        from ExchangeRateProg where ExchangeRateId = In_FormulaExRateId and ExChgRateEffectiveDate <= 

In_SubPeriodEndDate order by
        ExChgRateEffectiveDate desc;
    else
      set In_ForeignLocalRate=1
    end if;
    /*   
    Day Rate
    */
    if(In_OTType = 'OTDayRate') then
      set In_CurrentOTRate=Round(cast(In_OTRate*In_CalOTDayRate as numeric(21,8)),In_DecimalPlace);
      set In_LastOTRate=Round(cast(In_OTRate*In_CalOTLastDayRate as numeric(21,8)),In_DecimalPlace);
      set In_BackPayOTRate=Round(cast(In_OTRate*In_BackPayDayRate as numeric(21,8)),In_DecimalPlace);
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
        BackPayOTRate = In_BackPayOTRate,
        OTExRateId = '',
        OTExRate = 1 where current of curs
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
      set In_CurrentOTRate=Round(cast(In_OTRate*In_CalOTHourRate as numeric(21,8)),In_DecimalPlace);
      set In_LastOTRate=Round(cast(In_OTRate*In_CalOTLastHourRate as numeric(21,8)),In_DecimalPlace);
      set In_BackPayOTRate=Round(cast(In_OTRate*In_BackPayHourRate as numeric(21,8)),In_DecimalPlace);
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
        BackPayOTRate = In_BackPayOTRate, 
        OTExRateId = '',
        OTExRate = 1 where current of curs
    end if end for;
  commit work
end
;

IF Exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecResidenceType') Then
  Drop function FGetPayRecResidenceType
End if;

Create FUNCTION DBA.FGetPayRecResidenceType(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns char(100)
begin
  declare Out_ResidenceTypeId char(20);
  declare Out_PayGroupId char(20);
  declare Out_SubPeriodEndDate date;
  /* Get Pay Group */
  select PayPayGroupId into Out_PayGroupId from PayPeriodRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if Out_PayGroupId is null or Out_PayGroupId='' then return ''
  end if;
  /* Get sub Period End Date */
  select first SubPeriodEndDate into Out_SubPeriodEndDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PayRecYear and
    PayGroupPeriod = In_PayRecPeriod order by SubPeriodEndDate desc;
  select first ResidenceTypeId into Out_ResidenceTypeId
    from  ResidenceStatusRecord where
    PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
    ResStatusEffectiveDate <= Out_SubPeriodEndDate order by ResStatusEffectiveDate desc;
  return(Out_ResidenceTypeId)
end
;

commit work;



