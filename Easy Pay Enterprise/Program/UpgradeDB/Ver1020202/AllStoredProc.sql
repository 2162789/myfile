if exists(select 1 from sys.sysprocedure where proc_name = 'IsResidenceStatusChanged') then
   drop procedure IsResidenceStatusChanged
end if
;

CREATE FUNCTION "DBA"."IsResidenceStatusChanged"(
in In_PersonalSysId integer,
in In_ResStatusEffectiveDate date,
in In_ResidenceTypeId char(20))
returns smallint
begin
  if exists (select 1 from ResidenceStatusRecord 
             where PersonalSysId = In_PersonalSysId 
               and ResStatusEffectiveDate < In_ResStatusEffectiveDate 
               and ResidenceTypeId != In_ResidenceTypeId) then

    return 1;
  else
    return 0;
  end if;  
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalLeaveDeductionRecord') then
   drop procedure ASQLRecalLeaveDeductionRecord
end if
;

CREATE PROCEDURE "DBA"."ASQLRecalLeaveDeductionRecord"(
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
      Round(CurrentDayRateAmt,FGetDBOTDecimal(*)) as In_CurrentDayRateAmt,
      Round(CurrentHourRateAmt,FGetDBOTDecimal(*)) as In_CurrentHourRateAmt,
      Round(PreviousDayRateAmt,FGetDBOTDecimal(*)) as In_PreviousDayRateAmt,
      Round(PreviousHourRateAmt,FGetDBOTDecimal(*)) as In_PreviousHourRateAmt from
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

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateOTRecord') then
   drop procedure ASQLUpdateOTRecord
end if
;

CREATE PROCEDURE "DBA"."ASQLUpdateOTRecord"(
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
        ExChgRateEffectiveDate desc;
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
        BackPayOTRate = In_BackPayOTRate, 
        OTExRateId = '',
        OTExRate = 1 where current of curs
    end if end for;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllStatutoryDeduction') then
   drop procedure FGetPayRecAllStatutoryDeduction
end if
;

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

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyName') then
   drop procedure FGetFamilyName
end if
;

CREATE FUNCTION "DBA"."FGetFamilyName"(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(150)
begin
  declare Out_Name char(150);
  select First Family.PersonName into Out_Name
    from Family where RelationShipId = In_RelationShipId and
    Family.PersonalSysId = In_PersonalSysId;
  return(Out_Name)
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeletePayRecords') then
   drop procedure ASQLDeletePayRecords
end if
;

CREATE PROCEDURE "DBA"."ASQLDeletePayRecords"(
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
    call ASQLDeleteSubPeriodRecords(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod);
    if(FGetDBCountry(*) = 'Malaysia') then
      delete from RebateGranted where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId) and
        RebatePayrollYear = In_PayRecYear and
        RebatePayrollPeriod = In_PayRecPeriod
    end if
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
    delete from MalBIKRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    delete from DMBRecord where
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
      end if end for;
    if(In_PayRecID = 'Normal') then
      update LeaveDeductionRecord set
        CurrentLveDays = 0,
        CurrentLveHours = 0,
        PreviousLveIncDays = 0,
        PreviousLveIncHours = 0 where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod;
      update LeaveInfoRecord set
        CurrLvePeriodTaken = 0 where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod
    end if;
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBackPay') then
   drop procedure ASQLTimeSheetDistributeBackPay
end if
;

CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeBackPay"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer)
begin
  declare In_TotalBackPay double;
  declare In_TotalWorkingDayHour double;
  declare In_CostingAmount double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Accu_CostingAmount double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  To get the Total Basic Rate for the Period
  */
  select Sum(CalBackPay) into In_TotalBackPay
    from
    DetailRecord where EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  if In_TotalBackPay is null then set In_TotalBackPay=0
  end if;
  /*
  Get no of TMS Detail Records
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSPayRecId = 'Normal Time Sheet';
  /*
  Get Total Working Days
  */
  select Sum(TMSWorkingDayHour) into In_TotalWorkingDayHour from
    TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSPayRecId = 'Normal Time Sheet';
  if In_TotalWorkingDayHour is null then set In_TotalWorkingDayHour=0
  end if;
  /*
  Loop through Non Fixed Payment TMS Detail Records 
  */
  set Accu_CostingAmount=0;
  TMSDetailLoop: for TMSDetailFor as TMSDetailCurs dynamic scroll cursor for
    select TMSWorkingDayHour as In_TMSWorkingDayHour, 
           TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId
      from
      TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSPayRecId = 'Normal Time Sheet' do
    if(In_TotalRecord = 1) then
      set In_CostingAmount=Round(In_TotalBackPay-Accu_CostingAmount,In_DecimalPlace)
    else
      if(In_TMSWorkingDayHour = 0) then
        set In_CostingAmount=0
      else
        set In_CostingAmount=Round(In_TotalBackPay/In_TotalWorkingDayHour*In_TMSWorkingDayHour,In_DecimalPlace);
        if(In_CostingAmount+Accu_CostingAmount > In_TotalBackPay) then
          set In_CostingAmount=Round(In_TotalBackPay-Accu_CostingAmount,In_DecimalPlace)
        end if
      end if;
      set Accu_CostingAmount=Accu_CostingAmount+In_CostingAmount;
      set In_TotalRecord=In_TotalRecord-1
    end if;
    update TMSDetail set BackPayCostingAmt = In_CostingAmount where TMSSGSPGenId = In_TMSSGSPGenId end for;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBR') then
   drop procedure ASQLTimeSheetDistributeBR
end if
;

CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeBR"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_Error integer)
begin
  declare DistributeAmount double;
  declare In_TotalBasicRate double;
  declare In_FixedCostingAmount double;
  declare In_TotalWorkingDayHour double;
  declare In_CostingAmount double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Accu_CostingAmount double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_Error=0;
  /*
  To get the Total Basic Rate for the Period
  */
  select Sum(AllocatedBasicRate) into In_TotalBasicRate
    from
    DetailRecord where EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  if In_TotalBasicRate is null then set In_TotalBasicRate=0
  end if;
  message 'Total Basic Rate : '+cast(In_TotalBasicRate as char(20)) type info to client;
  /*
  To get the Total Fixed Payment
  */
  select Sum(BasicRateCostingAmt) into In_FixedCostingAmount from
    TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSPayRecId = 'Normal Time Sheet' and
    TMSPaymentType = 'FixedPayment';
  if In_FixedCostingAmount is null then set In_FixedCostingAmount=0
  end if;
  message 'Total Fixed Payment : '+cast(In_FixedCostingAmount as char(20)) type info to client;
  /*
  To get Distributed 
  */
  set DistributeAmount=In_TotalBasicRate-In_FixedCostingAmount;
  message 'Total Distribution Amout : '+cast(DistributeAmount as char(20)) type info to client;
  if DistributeAmount < 0 then set Out_Error=1;
    return
  end if;
  /*
  Get no of TMS Detail Records for Non Fixed Payment
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSPayRecId = 'Normal Time Sheet' and
    TMSPaymentType <> 'FixedPayment' and
    TMSWorkingDayHour <> 0;
  message 'Record for Distribution : '+cast(In_TotalRecord as char(20)) type info to client;
  /*
  No record for distribution
  */
  if(DistributeAmount > 0 and In_TotalRecord = 0) then set Out_Error=2;
    return
  end if;
  /*
  Get Total Working Days for Non Fixed Payment
  */
  select Sum(TMSWorkingDayHour) into In_TotalWorkingDayHour from
    TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSPayRecId = 'Normal Time Sheet' and
    TMSPaymentType <> 'FixedPayment';
  if In_TotalWorkingDayHour is null then set In_TotalWorkingDayHour=0
  end if;
  message 'Total Working Days : '+cast(In_TotalWorkingDayHour as char(20)) type info to client;
  /*
  No record with days for distribution
  */
  if(DistributeAmount > 0 and In_TotalWorkingDayHour <= 0) then set Out_Error=3;
    return
  end if;
  /*
  Loop through Non Fixed Payment TMS Detail Records 
  */
  set Accu_CostingAmount=0;
  TMSDetailLoop: for TMSDetailFor as TMSDetailCurs dynamic scroll cursor for
    select TMSWorkingDayHour as In_TMSWorkingDayHour,
            TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId
        from
      TimeSheet join TMSDetail where EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSPayRecId = 'Normal Time Sheet' and
      TMSPaymentType <> 'FixedPayment' and
      TMSWorkingDayHour <> 0 do
    if(In_TotalRecord = 1) then
      set In_CostingAmount=Round(DistributeAmount-Accu_CostingAmount,In_DecimalPlace)
    else
      set In_CostingAmount=Round(DistributeAmount/In_TotalWorkingDayHour*In_TMSWorkingDayHour,In_DecimalPlace);
      if(In_CostingAmount+Accu_CostingAmount > DistributeAmount) then
        set In_CostingAmount=Round(DistributeAmount-Accu_CostingAmount,In_DecimalPlace)
      end if;
      set Accu_CostingAmount=Accu_CostingAmount+In_CostingAmount;
      set In_TotalRecord=In_TotalRecord-1
    end if;
    update TMSDetail set BasicRateCostingAmt = In_CostingAmount where TMSSGSPGenId = In_TMSSGSPGenId end for;
  commit work
end
;

commit work;