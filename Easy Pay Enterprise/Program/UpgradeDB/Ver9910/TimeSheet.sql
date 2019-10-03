create procedure DBA.ASQLTimeSheetDistributeAllowance(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20))
begin
  /*
  Loop through Pay Record Non Free Allowance Records
  */
  AllowanceRecordLoop: for AllowanceRecordFor as curs dynamic scroll cursor for
    select AllowanceCustSysId as In_TMSAllowanceSysId,
      AllowanceAmount as In_AllowanceAmount from
      AllowanceRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      PayRecId = In_TMSPayRecId and
      AllowanceCreatedBy = 'TimeSheet' and
      FGetFormulaType(AllowanceFormulaId) <> 'Free' do
    /*
    Update TMS Allowance Record Costing Amount
    */
    update TMSAllowance set
      CostingAmount = In_AllowanceAmount where
      TMSAllowanceSysId = In_TMSAllowanceSysId end for;
  commit work
end
;

create procedure
DBA.ASQLTimeSheetDistributeBackPay(in In_EmployeeSysId integer,in In_TMSYear integer,in In_TMSPeriod integer)
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
    select TMSWorkingDayHour as In_TMSWorkingDayHour from
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
    update TMSDetail set BackPayCostingAmt = In_CostingAmount where current of TMSDetailCurs end for;
  commit work
end
;

create procedure DBA.ASQLTimeSheetDistributeBR(
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
    select TMSWorkingDayHour as In_TMSWorkingDayHour from
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
    update TMSDetail set BasicRateCostingAmt = In_CostingAmount where current of TMSDetailCurs end for;
  commit work
end
;

create procedure DBA.ASQLTimeSheetDistributeLeave(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer)
begin
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare In_CostingCurDayAmt double;
  declare In_CostingCurHourAmt double;
  declare In_CostingPrevDayAmt double;
  declare In_CostingPrevHourAmt double;
  declare In_TotalCurDayAmt double;
  declare In_TotalCurHourAmt double;
  declare In_TotalPrevDayAmt double;
  declare In_TotalPrevHourAmt double;
  declare Accu_CostingCurDayAmt double;
  declare Accu_CostingCurHourAmt double;
  declare Accu_CostingPrevDayAmt double;
  declare Accu_CostingPrevHourAmt double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Set all costing amount to be zero
  */
  update TMSLeaveDeduction set
    CurrentCostingAmt = 0,
    PreviousCostingAmt = 0 where
    TMSSGSPGenId = 
    any(select TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = 'Normal Time Sheet');
  commit work;
  /*
  Loop through Pay Leave Deduction Record for NPL, Absent and Late
  */
  LeaveDeductionLoop: for LeaveDeductionFor as curs dynamic scroll cursor for
    select LeaveTypeFunctCode as In_LeaveTypeFunctCode,
      CurrentLveDays as In_TotalCurDay,
      CurrentLveHours as In_TotalCurHour,
      PreviousLveIncDays as In_TotalPrevDay,
      PreviousLveIncHours as In_TotalPrevHour,
      CurrentDayRateAmt as In_CurrentDayRateAmt,
      CurrentHourRateAmt as In_CurrentHourRateAmt,
      PreviousDayRateAmt as In_PreviousDayRateAmt,
      PreviousHourRateAmt as In_PreviousHourRateAmt from
      LeaveDeductionRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      LveDedCreatedBy = 'TimeSheet' do
    /*
    Compute Total for Current / Previous Day / Hour
    */
    set In_TotalCurDayAmt=Round(In_TotalCurDay*In_CurrentDayRateAmt,In_DecimalPlace);
    set In_TotalCurHourAmt=Round(In_TotalCurHour*In_CurrentHourRateAmt,In_DecimalPlace);
    set In_TotalPrevDayAmt=Round(In_TotalPrevDay*In_PreviousDayRateAmt,In_DecimalPlace);
    set In_TotalPrevHourAmt=Round(In_TotalPrevHour*In_PreviousHourRateAmt,In_DecimalPlace);
    message '' type info to client;
    message In_LeaveTypeFunctCode type info to client;
    message '--------------------------' type info to client;
    /*
    Current Days   
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Absent') and In_TotalCurDay <> 0) then
      /*
      Get TMS Leave Deduction Records that has Current Days
      */
      message 'Total Current Day Amount : '+cast(In_TotalCurDayAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        CurrentLveDays <> 0;
      /*
      Distribution
      */
      set Accu_CostingCurDayAmt=0;
      CurrentDayLoop: for CurrentDayFor as CurrentDayCurs dynamic scroll cursor for
        select CurrentLveDays as In_CurDay from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          CurrentLveDays <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingCurDayAmt=Round(In_TotalCurDayAmt-Accu_CostingCurDayAmt,In_DecimalPlace)
        else
          set In_CostingCurDayAmt=Round(In_TotalCurDayAmt/In_TotalCurDay*In_CurDay,In_DecimalPlace);
          if(In_CostingCurDayAmt+Accu_CostingCurDayAmt < In_TotalCurDayAmt) then
            set In_CostingCurDayAmt=Round(In_TotalCurDayAmt-Accu_CostingCurDayAmt,In_DecimalPlace)
          end if;
          set Accu_CostingCurDayAmt=Accu_CostingCurDayAmt+In_CostingCurDayAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message 'Distributed Current Day Amount : '+cast(In_CostingCurDayAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          CurrentCostingAmt = In_CostingCurDayAmt where current of CurrentDayCurs end for;
      commit work
    end if;
    /*
    Current Hour
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Late') and In_TotalCurHour <> 0) then
      /*
      Get TMS Leave Deduction Records that has Current Hour
      */
      message 'Total Current Hour Amount : '+cast(In_TotalCurHourAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        CurrentLveHours <> 0;
      set Accu_CostingCurHourAmt=0;
      /*
      Distribution
      */
      CurrentHourLoop: for CurrentHourFor as CurrentHourCurs dynamic scroll cursor for
        select CurrentLveHours as In_CurHour from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          CurrentLveHours <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingCurHourAmt=Round(In_TotalCurHourAmt-Accu_CostingCurHourAmt,In_DecimalPlace)
        else
          set In_CostingCurHourAmt=Round(In_TotalCurHourAmt/In_TotalCurHour*In_CurHour,In_DecimalPlace);
          if(In_CostingCurHourAmt+Accu_CostingCurHourAmt < In_TotalCurHourAmt) then
            set In_CostingCurHourAmt=Round(In_TotalCurHourAmt-Accu_CostingCurHourAmt,In_DecimalPlace)
          end if;
          set Accu_CostingCurHourAmt=Accu_CostingCurHourAmt+In_CostingCurHourAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        /*
        To append Hour value to Day if any
        */
        message 'Distributed Current Hour Amount : '+cast(In_CostingCurHourAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          CurrentCostingAmt = CurrentCostingAmt+In_CostingCurHourAmt where current of CurrentHourCurs end for;
      commit work
    end if;
    /*
    Previous Days   
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Absent') and In_TotalPrevDay <> 0) then
      /*
      Get TMS Leave Deduction Records that has Previous Days
      */
      message 'Total Previous Day Amount : '+cast(In_TotalPrevDayAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        PreviousLveIncDays <> 0;
      /*
      Distribution
      */
      set Accu_CostingPrevDayAmt=0;
      PreviousDayLoop: for PreviousDayFor as PreviousDayCurs dynamic scroll cursor for
        select PreviousLveIncDays as In_PrevDay from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          PreviousLveIncDays <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt-Accu_CostingPrevDayAmt,In_DecimalPlace)
        else
          set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt/In_TotalPrevDay*In_PrevDay,In_DecimalPlace);
          if(In_CostingPrevDayAmt+Accu_CostingPrevDayAmt < In_TotalPrevDayAmt) then
            set In_CostingPrevDayAmt=Round(In_TotalPrevDayAmt-Accu_CostingPrevDayAmt,In_DecimalPlace)
          end if;
          set Accu_CostingPrevDayAmt=Accu_CostingPrevDayAmt+In_CostingPrevDayAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message 'Distributed Previous Day Amount : '+cast(In_CostingPrevDayAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          PreviousCostingAmt = In_CostingPrevDayAmt where current of PreviousDayCurs end for;
      commit work
    end if;
    /*
    Previous Hour
    */
    if((In_LeaveTypeFunctCode = 'NPL' or In_LeaveTypeFunctCode = 'Late') and In_TotalPrevHour <> 0) then
      /*
      Get TMS Leave Deduction Records that has Previous Hour
      */
      message 'Total Previous Hour Amount : '+cast(In_TotalPrevHourAmt as char(12)) type info to client;
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = 'Normal Time Sheet' and
        TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
        PreviousLveIncHours <> 0;
      set Accu_CostingPrevHourAmt=0;
      PreviousHourLoop: for PreviousHourFor as PreviousHourCurs dynamic scroll cursor for
        select PreviousLveIncHours as In_PrevHour from
          TimeSheet join TMSLeaveDeduction where EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = 'Normal Time Sheet' and
          TMSLveTypeFunctCode = In_LeaveTypeFunctCode and
          PreviousLveIncHours <> 0 do
        if(In_TotalRecord = 1) then
          set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt-Accu_CostingPrevHourAmt,In_DecimalPlace)
        else
          set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt/In_TotalPrevHour*In_PrevHour,In_DecimalPlace);
          if(In_CostingPrevHourAmt+Accu_CostingPrevHourAmt < In_TotalPrevHourAmt) then
            set In_CostingPrevHourAmt=Round(In_TotalPrevHourAmt-Accu_CostingPrevHourAmt,In_DecimalPlace)
          end if;
          set Accu_CostingPrevHourAmt=Accu_CostingPrevHourAmt+In_CostingPrevHourAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        /*
        To append Hour value to Day if any
        */
        message 'Distributed Previous Hour Amount : '+cast(In_CostingPrevHourAmt as char(12)) type info to client;
        update TMSLeaveDeduction set
          PreviousCostingAmt = PreviousCostingAmt+In_CostingPrevHourAmt where current of PreviousHourCurs end for;
      commit work
    end if end for
end
;

create procedure DBA.ASQLTimeSheetDistributeOT(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20))
begin
  declare In_CurrentCostingAmt double;
  declare In_LastCostingAmt double;
  declare In_BackPayCostingAmt double;
  declare Accu_CurrentCostingAmt double;
  declare Accu_LastCostingAmt double;
  declare Accu_BackPayCostingAmt double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Set all Costing Amount zero
  */
  update TMSOvertime set
    CurrentCostingAmt = 0,
    LastOTCostingAmt = 0,
    BackPayOTCostingAmt = 0 where
    TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = In_TMSPayRecId);
  /*
  Loop through Overtime Record 
  */
  OTRecordLoop: for OTRecordFor as OTRecordCurs dynamic scroll cursor for
    select OTFormulaId as In_OTFormulaId,
      CurrentOTFreq as In_TotalCurrentOTFreq,
      LastOTFreq as In_TotalLastOTFreq,
      BackPayOTFreq as In_TotalBackPayOTFreq,
      CurrentOTAmount as In_TotalCurrentOTAmount,
      LastOTAmount as In_TotalLastOTAmount,
      BackPayOTAmount as In_TotalBackPayOTAmount from
      OTRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      PayRecId = In_TMSPayRecId and
      OTCreatedBy = 'TimeSheet' do
    message '' type info to client;
    message In_OTFormulaId type info to client;
    message '-------------------------------' type info to client;
    message 'Current Freq : '+cast(In_TotalCurrentOTFreq as char(20)) type info to client;
    message 'Last Freq : '+cast(In_TotalLastOTFreq as char(20)) type info to client;
    message 'Back Pay Freq : '+cast(In_TotalBackPayOTFreq as char(20)) type info to client;
    message 'Current Amt : '+cast(In_TotalCurrentOTAmount as char(20)) type info to client;
    message 'Last Amt : '+cast(In_TotalLastOTAmount as char(20)) type info to client;
    message 'Back Pay Amt : '+cast(In_TotalBackPayOTAmount as char(20)) type info to client;
    message '' type info to client;
    //
    // Current OT
    //
    if(In_TotalCurrentOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        CurrentOTFreq <> 0;
      message 'No Of Current OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_CurrentCostingAmt=0;
      CurrentOTLoop: for CurrentOTFor as CurrentOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          CurrentOTFreq as In_CurrentOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          CurrentOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount-Accu_CurrentCostingAmt,In_DecimalPlace)
        else
          set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount/In_TotalCurrentOTFreq*In_CurrentOTFreq,In_DecimalPlace);
          if(In_CurrentCostingAmt+Accu_CurrentCostingAmt > In_TotalCurrentOTAmount) then
            set In_CurrentCostingAmt=Round(In_TotalCurrentOTAmount-Accu_CurrentCostingAmt,In_DecimalPlace)
          end if;
          set Accu_CurrentCostingAmt=Accu_CurrentCostingAmt+In_CurrentCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_CurrentCostingAmt as char(20)) type info to client;
        update TMSOvertime set
          CurrentCostingAmt = In_CurrentCostingAmt where current of CurrentOTCurs end for
    end if;
    //
    // Last OT
    //
    if(In_TotalLastOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        LastOTFreq <> 0;
      message 'No Of Last OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_LastCostingAmt=0;
      LastOTLoop: for LastOTFor as LastOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          LastOTFreq as In_LastOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          LastOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_LastCostingAmt=Round(In_TotalLastOTAmount-Accu_LastCostingAmt,In_DecimalPlace)
        else
          set In_LastCostingAmt=Round(In_TotalLastOTAmount/In_TotalLastOTFreq*In_LastOTFreq,In_DecimalPlace);
          if(In_LastCostingAmt+Accu_LastCostingAmt > In_TotalLastOTAmount) then
            set In_LastCostingAmt=Round(In_TotalLastOTAmount-Accu_LastCostingAmt,In_DecimalPlace)
          end if;
          set Accu_LastCostingAmt=Accu_LastCostingAmt+In_LastCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_LastCostingAmt as char(20)) type info to client;
        update TMSOvertime set
          LastOTCostingAmt = In_LastCostingAmt where current of LastOTCurs end for
    end if;
    //
    // Back Pay OT
    //
    if(In_TotalBackPayOTFreq <> 0) then
      /*
      Get TMS Overtime Records 
      */
      select Count(*) into In_TotalRecord from
        TimeSheet join TMSOvertime where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_OTFormulaId and
        BackPayOTFreq <> 0;
      message 'No Of Back Pay OT Records '+cast(In_TotalRecord as char(20)) type info to client;
      /*
      Distribution
      */
      set Accu_BackPayCostingAmt=0;
      BackPayOTLoop: for BackPayOTFor as BackPayOTCurs dynamic scroll cursor for
        select TMSOvertime.TMSSGSPGenId as In_TMSSGSPGenId,
          BackPayOTFreq as In_BackPayOTFreq from
          TimeSheet join TMSOvertime where
          EmployeeSysId = In_EmployeeSysId and
          TMSYear = In_TMSYear and
          TMSPeriod = In_TMSPeriod and
          TMSSubPeriod = In_TMSSubPeriod and
          TMSPayRecId = In_TMSPayRecId and
          FormulaId = In_OTFormulaId and
          BackPayOTFreq <> 0 do
        if(In_TotalRecord = 1) then
          set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount-Accu_BackPayCostingAmt,In_DecimalPlace)
        else
          set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount/In_TotalBackPayOTFreq*In_BackPayOTFreq,In_DecimalPlace);
          if(In_BackPayCostingAmt+Accu_BackPayCostingAmt > In_TotalBackPayOTAmount) then
            set In_BackPayCostingAmt=Round(In_TotalBackPayOTAmount-Accu_BackPayCostingAmt,In_DecimalPlace)
          end if;
          set Accu_BackPayCostingAmt=Accu_BackPayCostingAmt+In_BackPayCostingAmt;
          set In_TotalRecord=In_TotalRecord-1
        end if;
        message '     '+In_TMSSGSPGenId+' : '+cast(In_BackPayCostingAmt as char(20)) type info to client;
        update TMSOvertime set
          BackPayOTCostingAmt = In_BackPayCostingAmt where current of BackPayOTCurs end for
    end if end for;
  commit work
end
;

create procedure DBA.ASQLTimeSheetDistributeShift(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20))
begin
  declare In_CostingAmount double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Accu_CostingAmount double;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Loop through Shift Record 
  */
  ShiftRecordLoop: for ShiftRecordFor as ShiftRecordCurs dynamic scroll cursor for
    select ShiftFormulaId as In_ShiftFormulaId,
      ShiftFrequency as In_TotalShiftFrequency,
      ShiftAmount as In_TotalShiftAmount from
      ShiftRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_TMSYear and
      PayRecPeriod = In_TMSPeriod and
      PayRecSubPeriod = In_TMSSubPeriod and
      PayRecId = In_TMSPayRecId and
      ShiftCreatedBy = 'TimeSheet' do
    message '' type info to client;
    message In_ShiftFormulaId type info to client;
    message '-------------------------------' type info to client;
    message 'Freq : '+cast(In_TotalShiftFrequency as char(20)) type info to client;
    message 'Amt : '+cast(In_TotalShiftAmount as char(20)) type info to client;
    /*
    Get TMS Shift Records 
    */
    select Count(*) into In_TotalRecord from
      TimeSheet join TMSShift where EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = In_TMSPayRecId and
      FormulaId = In_ShiftFormulaId;
    message 'No Of Time Sheet Records '+cast(In_TotalRecord as char(20)) type info to client;
    /*
    Loop through Shift Record 
    */
    set Accu_CostingAmount=0;
    TMSShiftLoop: for TMSShiftFor as TMSShiftCurs dynamic scroll cursor for
      select TMSShift.TMSSGSPGenId as In_TMSSGSPGenId,
        ShiftFrequency as In_ShiftFrequency from
        TimeSheet join TMSShift where EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod and
        TMSSubPeriod = In_TMSSubPeriod and
        TMSPayRecId = In_TMSPayRecId and
        FormulaId = In_ShiftFormulaId do
      if(In_TotalRecord = 1) then
        set In_CostingAmount=Round(In_TotalShiftAmount-Accu_CostingAmount,In_DecimalPlace)
      else
        if(In_TotalShiftFrequency = 0) then
          set In_CostingAmount=0
        else
          set In_CostingAmount=Round(In_TotalShiftAmount/In_TotalShiftFrequency*In_ShiftFrequency,In_DecimalPlace);
          if(In_CostingAmount+Accu_CostingAmount > In_TotalShiftAmount) then
            set In_CostingAmount=Round(In_TotalShiftAmount-Accu_CostingAmount,In_DecimalPlace)
          end if
        end if;
        set Accu_CostingAmount=Accu_CostingAmount+In_CostingAmount;
        set In_TotalRecord=In_TotalRecord-1
      end if;
      message '' type info to client;
      message '     '+In_TMSSGSPGenId type info to client;
      message '--------------------' type info to client;
      message '     Amt : '+cast(In_CostingAmount as char(20)) type info to client;
      update TMSShift set CostingAmount = In_CostingAmount where current of TMSShiftCurs end for end for;
  commit work
end
;

create procedure DBA.DeleteJobCode(
in In_JobCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from JobCode where JobCode.JobCode = In_JobCode) then
    if not exists(select* from TimeSheet where
        TimeSheet.JobCode = In_JobCode) then
      delete from JobCode where JobCode.JobCode = In_JobCode;
      commit work
    end if;
    if exists(select* from JobCode where JobCode.JobCode = In_JobCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTimeSheet(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TimeSheet where
      TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId) then
    call DeleteTMSLeaveDeductionByGenId(In_TMSSGSPGenId);
    call DeleteTMSOvertimeByGenId(In_TMSSGSPGenId);
    call DeleteTMSShiftByGenId(In_TMSSGSPGenId);
    call DeleteTMSAllowanceByGenId(In_TMSSGSPGenId);
    call DeleteTMSDetail(In_TMSSGSPGenId);
    call DeleteTMSDistributeByGenId(In_TMSSGSPGenId);
    delete from TimeSheet where
      TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TimeSheet where
        TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSAllowance(
in In_TMSSGSPGenId char(30),
in In_TMSAllowanceSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSAllowance.TMSAllowanceSysId = In_TMSAllowanceSysId) then
    delete from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSAllowance.TMSAllowanceSysId = In_TMSAllowanceSysId;
    commit work;
    if exists(select* from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSAllowance.TMSAllowanceSysId = In_TMSAllowanceSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSAllowanceByGenId(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSDetail(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSDetail where TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSDetail where TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSDetail where TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSDistribute(
in In_TMSDistributeId char(20),
in In_TMSSGSPGenId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSDistribute where TMSDistribute.TMSDistributeId = In_TMSDistributeId and
      TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSDistribute where TMSDistribute.TMSDistributeId = In_TMSDistributeId and TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSDistribute where TMSDistribute.TMSDistributeId = In_TMSDistributeId and
        TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSDistributeByGenId(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSDistribute where TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSDistribute where TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSDistribute where TMSDistribute.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSLeaveDeduction(
in In_TMSSGSPGenId char(30),
in In_TMSLveTypeFunctCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode) then
    delete from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode;
    commit work;
    if exists(select* from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSLeaveDeductionByGenId(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSLeaveDeduction where TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSOverTime(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSOverTime.FormulaId = In_FormulaId) then
    delete from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSOverTime.FormulaId = In_FormulaId;
    commit work;
    if exists(select* from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSOverTime.FormulaId = In_FormulaId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSOverTimeByGenId(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSOverTime where TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSShift(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSShift.FormulaId = In_FormulaId) then
    delete from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSShift.FormulaId = In_FormulaId;
    commit work;
    if exists(select* from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSShift.FormulaId = In_FormulaId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteTMSShiftByGenId(
in In_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId) then
    delete from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    if exists(select* from TMSShift where TMSShift.TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewJobCode(
in In_JobCode char(20),
in In_JobCodeDesc char(100),
in In_JobCodeRefNo char(100),
in In_TMSProjectId char(20),
in In_TMSCostCentreId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from JobCode where JobCode.JobCode = In_JobCode) then
    insert into JobCode(JobCode,
      JobCodeDesc,
      JobCodeRefNo,
      TMSProjectId,
      TMSCostCentreId) values(
      In_JobCode,
      In_JobCodeDesc,
      In_JobCodeRefNo,
      In_TMSProjectId,
      In_TMSCostCentreId);
    commit work;
    if not exists(select* from JobCode where JobCode.JobCode = In_JobCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTimeSheet(
in In_EmployeeSysId integer,
in In_JobCode char(20),
in In_TMSType char(20),
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSDate date,
in In_TMSPayRecId char(20),
in In_Status char(20),
in In_LastProcessed timestamp,
in In_PayrollLastProcessed timestamp,
out Out_TMSSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if not exists(select* from TimeSheet where
      TimeSheet.EmployeeSysId = In_EmployeeSysId and
      TimeSheet.JobCode = In_JobCode and
      TimeSheet.TMSType = In_TMSType and
      TimeSheet.TMSYear = In_TMSYear and
      TimeSheet.TMSPeriod = In_TMSPeriod and
      TimeSheet.TMSSubPeriod = In_TMSSubPeriod and
      TimeSheet.TMSDate = In_TMSDate and
      TimeSheet.TMSPayRecId = In_TMSPayRecId and
      TimeSheet.Status = In_Status and
      TimeSheet.LastProcessed = In_LastProcessed and
      TimeSheet.PayrollLastProcessed = In_PayrollLastProcessed) then
    select FGetNewSGSPGeneratedIndex('TimeSheet') into Out_TMSSGSPGenId;
    insert into TimeSheet(TMSSGSPGenId,
      EmployeeSysId,
      JobCode,
      TMSType,
      TMSYear,
      TMSPeriod,
      TMSSubPeriod,
      TMSDate,
      TMSPayRecId,
      Status,
      LastProcessed,
      PayrollLastProcessed) values(
      Out_TMSSGSPGenId,
      In_EmployeeSysId,
      In_JobCode,
      In_TMSType,
      In_TMSYear,
      In_TMSPeriod,
      In_TMSSubPeriod,
      In_TMSDate,
      In_TMSPayRecId,
      In_Status,
      In_LastProcessed,
      In_PayrollLastProcessed);
    commit work;
    if not exists(select* from TimeSheet where
        TimeSheet.TMSSGSPGenId = Out_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTMSAllowance(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
in In_AllowanceRemarks char(100),
in In_AllowanceDeclaredDate date,
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  insert into TMSAllowance(TMSSGSPGenId,
    FormulaId,
    AllowanceRemarks,
    AllowanceDeclaredDate,
    UserDef1Value,
    UserDef2Value,
    UserDef3Value,
    UserDef4Value,
    UserDef5Value,
    CostingAmount) values(
    In_TMSSGSPGenId,
    In_FormulaId,
    In_AllowanceRemarks,
    In_AllowanceDeclaredDate,
    In_UserDef1Value,
    In_UserDef2Value,
    In_UserDef3Value,
    In_UserDef4Value,
    In_UserDef5Value,
    In_CostingAmount);
  commit work;
  update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
  set Out_ErrorCode=1
end
;

create procedure DBA.InsertNewTMSDetail(
in In_TMSSGSPGenId char(30),
in In_TMSPaymentType char(20),
in In_TMSBRDayHourRate double,
in In_TMSWorkingDayHour double,
in In_TMSBasicRate double,
in In_TMSExRateId char(20),
in In_TMSExRate double,
in In_TMSSickLeave double,
in In_TMSAnnualLeave double,
in In_BasicRateCostingAmt double,
in In_BackPayCostingAmt double,
in In_Description char(150),
out Out_ErrorCode integer)
begin
  if not exists(select* from TMSDetail where
      TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSDetail.TMSPaymentType = In_TMSPaymentType and
      TMSDetail.TMSBRDayHourRate = In_TMSBRDayHourRate and
      TMSDetail.TMSWorkingDayHour = In_TMSWorkingDayHour and
      TMSDetail.TMSBasicRate = In_TMSBasicRate and
      TMSDetail.TMSExRateId = In_TMSExRateId and
      TMSDetail.TMSExRate = In_TMSExRate and
      TMSDetail.TMSSickLeave = In_TMSSickLeave and
      TMSDetail.TMSAnnualLeave = In_TMSAnnualLeave and
      TMSDetail.BasicRateCostingAmt = In_BasicRateCostingAmt and
      TMSDetail.BackPayCostingAmt = In_BackPayCostingAmt and
      TMSDetail.Description = In_Description) then
    insert into TMSDetail(TMSSGSPGenId,
      TMSPaymentType,
      TMSBRDayHourRate,
      TMSWorkingDayHour,
      TMSBasicRate,
      TMSExRateId,
      TMSExRate,
      TMSSickLeave,
      TMSAnnualLeave,
      BasicRateCostingAmt,
      BackPayCostingAmt,
      Description) values(
      In_TMSSGSPGenId,
      In_TMSPaymentType,
      In_TMSBRDayHourRate,
      In_TMSWorkingDayHour,
      In_TMSBasicRate,
      In_TMSExRateId,
      In_TMSExRate,
      In_TMSSickLeave,
      In_TMSAnnualLeave,
      In_BasicRateCostingAmt,
      In_BackPayCostingAmt,
      In_Description);
    commit work;
    if not exists(select* from TMSDetail where
        TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSDetail.TMSPaymentType = In_TMSPaymentType and
        TMSDetail.TMSBRDayHourRate = In_TMSBRDayHourRate and
        TMSDetail.TMSWorkingDayHour = In_TMSWorkingDayHour and
        TMSDetail.TMSBasicRate = In_TMSBasicRate and
        TMSDetail.TMSExRateId = In_TMSExRateId and
        TMSDetail.TMSExRate = In_TMSExRate and
        TMSDetail.TMSSickLeave = In_TMSSickLeave and
        TMSDetail.TMSAnnualLeave = In_TMSAnnualLeave and
        TMSDetail.BasicRateCostingAmt = In_BasicRateCostingAmt and
        TMSDetail.BackPayCostingAmt = In_BackPayCostingAmt and
        TMSDetail.Description = In_Description) then
      set Out_ErrorCode=0
    else
      update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTMSDistribute(
in In_TMSDistributeId char(20),
in In_TMSSGSPGenId char(30),
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  if not exists(select* from TMSDistribute where
      TMSDistribute.TMSDistributeId = In_TMSDistributeId and TMSSGSPGenId = In_TMSSGSPGenId) then
    insert into TMSDistribute(TMSDistributeId,
      TMSSGSPGenId,
      CostingAmount) values(
      In_TMSDistributeId,
      In_TMSSGSPGenId,
      In_CostingAmount);
    commit work;
    if not exists(select* from TMSDistribute where
        TMSDistribute.TMSDistributeId = In_TMSDistributeId and TMSSGSPGenId = In_TMSSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTMSLeaveDeduction(
in In_TMSSGSPGenId char(30),
in In_TMSLveTypeFunctCode char(20),
in In_CurrentLveDays double,
in In_CurrentLveHours double,
in In_PreviousLveIncDays double,
in In_PreviousLveIncHours double,
in In_CurrentCostingAmt double,
in In_PreviousCostingAmt double,
out Out_ErrorCode integer)
begin
  if not exists(select* from TMSLeaveDeduction where
      TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode) then
    insert into TMSLeaveDeduction(TMSSGSPGenId,
      TMSLveTypeFunctCode,
      CurrentLveDays,
      CurrentLveHours,
      PreviousLveIncDays,
      PreviousLveIncHours,
      CurrentCostingAmt,
      PreviousCostingAmt) values(
      In_TMSSGSPGenId,
      In_TMSLveTypeFunctCode,
      In_CurrentLveDays,
      In_CurrentLveHours,
      In_PreviousLveIncDays,
      In_PreviousLveIncHours,
      In_CurrentCostingAmt,
      In_PreviousCostingAmt);
    commit work;
    if not exists(select* from TMSLeaveDeduction where
        TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode) then
      set Out_ErrorCode=0
    else
      update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTMSOverTime(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
in In_CurrentOTFreq double,
in In_LastOTFreq double,
in In_BackPayOTFreq double,
in In_CurrentCostingAmt double,
in In_LastOTCostingAmt double,
in In_BackPayOTCostingAmt double,
out Out_ErrorCode integer)
begin
  if not exists(select* from TMSOverTime where
      TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSOverTime.FormulaId = In_FormulaId) then
    insert into TMSOverTime(TMSSGSPGenId,
      FormulaId,
      CurrentOTFreq,
      LastOTFreq,
      BackPayOTFreq,
      CurrentCostingAmt,
      LastOTCostingAmt,
      BackPayOTCostingAmt) values(
      In_TMSSGSPGenId,
      In_FormulaId,
      In_CurrentOTFreq,
      In_LastOTFreq,
      In_BackPayOTFreq,
      In_CurrentCostingAmt,
      In_LastOTCostingAmt,
      In_BackPayOTCostingAmt);
    commit work;
    if not exists(select* from TMSOverTime where
        TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSOverTime.FormulaId = In_FormulaId) then
      set Out_ErrorCode=0
    else
      update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewTMSShift(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
in In_ShiftFrequency double,
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  if not exists(select* from TMSShift where
      TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSShift.FormulaId = In_FormulaId) then
    insert into TMSShift(TMSSGSPGenId,
      FormulaId,
      ShiftFrequency,
      CostingAmount) values(
      In_TMSSGSPGenId,
      In_FormulaId,
      In_ShiftFrequency,
      In_CostingAmount);
    commit work;
    if not exists(select* from TMSShift where
        TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
        TMSShift.FormulaId = In_FormulaId) then
      set Out_ErrorCode=0
    else
      update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.IsTimeSheetExistDate(
in In_EmployeeSysId integer,
in In_TMSFromDate date,
in In_TMSToDate date,
in In_TMSPayRecId char(20),
in In_JobCode char(20))
returns smallint
begin
  if exists(select* from TimeSheet where EmployeeSysId = In_EmployeeSysId and
      (TMSDate between In_TMSFromDate and In_TMSToDate) and
      TMSPayRecId = In_TMSPayRecId and
      JobCode = In_JobCode) then
    return 1
  end if;
  return 0
end
;

create function dba.IsTimeSheetExistSubPeriod(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSPayRecId char(20),
in In_JobCode char(20))
returns smallint
begin
  if exists(select* from TimeSheet where EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSSubPeriod = In_TMSSubPeriod and
      TMSPayRecId = In_TMSPayRecId and
      JobCode = In_JobCode) then
    return 1
  end if;
  return 0
end
;

create procedure DBA.UpdateJobCode(
in In_JobCode char(20),
in In_JobCodeDesc char(100),
in In_JobCodeRefNo char(100),
in In_TMSProjectId char(20),
in In_TMSCostCentreId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from JobCode where JobCode = In_JobCode) then
    update JobCode set
      JobCodeDesc = In_JobCodeDesc,
      JobCodeRefNo = In_JobCodeRefNo,
      TMSProjectId = In_TMSProjectId,
      TMSCostCentreId = In_TMSCostCentreId where
      JobCode = In_JobCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTimeSheet(
in In_TMSSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_JobCode char(20),
in In_TMSType char(20),
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TMSSubPeriod integer,
in In_TMSDate date,
in In_TMSPayRecId char(20),
in In_Status char(20),
in In_LastProcessed timestamp,
in In_PayrollLastProcessed timestamp,
out Out_ErrorCode integer)
begin
  if exists(select* from TimeSheet where
      TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId) then
    update TimeSheet set
      TimeSheet.EmployeeSysId = In_EmployeeSysId,
      TimeSheet.JobCode = In_JobCode,
      TimeSheet.TMSType = In_TMSType,
      TimeSheet.TMSYear = In_TMSYear,
      TimeSheet.TMSPeriod = In_TMSPeriod,
      TimeSheet.TMSSubPeriod = In_TMSSubPeriod,
      TimeSheet.TMSDate = In_TMSDate,
      TimeSheet.TMSPayRecId = In_TMSPayRecId,
      TimeSheet.Status = In_Status,
      TimeSheet.LastProcessed = In_LastProcessed,
      TimeSheet.PayrollLastProcessed = In_PayrollLastProcessed where
      TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTMSAllowance(
in In_TMSSGSPGenId char(30),
in In_TMSAllowanceSysId integer,
in In_FormulaId char(20),
in In_AllowanceRemarks char(100),
in In_AllowanceDeclaredDate date,
in In_UserDef1Value double,
in In_UserDef2Value double,
in In_UserDef3Value double,
in In_UserDef4Value double,
in In_UserDef5Value double,
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSAllowance where TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSAllowance.TMSAllowanceSysId = In_TMSAllowanceSysId) then
    update TMSAllowance set
      TMSSGSPGenId = In_TMSSGSPGenId,
      FormulaId = In_FormulaId,
      AllowanceRemarks = In_AllowanceRemarks,
      AllowanceDeclaredDate = In_AllowanceDeclaredDate,
      UserDef1Value = In_UserDef1Value,
      UserDef2Value = In_UserDef2Value,
      UserDef3Value = In_UserDef3Value,
      UserDef4Value = In_UserDef4Value,
      UserDef5Value = In_UserDef5Value,
      CostingAmount = In_CostingAmount where
      TMSAllowance.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSAllowance.TMSAllowanceSysId = In_TMSAllowanceSysId;
    commit work;
    update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTMSDetail(
in In_TMSSGSPGenId char(30),
in In_TMSPaymentType char(20),
in In_TMSBRDayHourRate double,
in In_TMSWorkingDayHour double,
in In_TMSBasicRate double,
in In_TMSExRateId char(20),
in In_TMSExRate double,
in In_TMSSickLeave double,
in In_TMSAnnualLeave double,
in In_BasicRateCostingAmt double,
in In_BackPayCostingAmt double,
in In_Description char(150),
out Out_ErrorCode integer)
begin
  if exists(select* from TMSDetail where
      TMSDetail.TMSSGSPGenId = In_TMSSGSPGenId) then
    update TMSDetail set
      TMSPaymentType = In_TMSPaymentType,
      TMSBRDayHourRate = In_TMSBRDayHourRate,
      TMSWorkingDayHour = In_TMSWorkingDayHour,
      TMSBasicRate = In_TMSBasicRate,
      TMSExRateId = In_TMSExRateId,
      TMSExRate = In_TMSExRate,
      TMSSickLeave = In_TMSSickLeave,
      TMSAnnualLeave = In_TMSAnnualLeave,
      BasicRateCostingAmt = In_BasicRateCostingAmt,
      BackPayCostingAmt = In_BackPayCostingAmt,
      Description = In_Description where
      TMSSGSPGenId = In_TMSSGSPGenId;
    commit work;
    update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTMSDistribute(
in In_TMSDistributeId char(20),
in In_TMSSGSPGenId char(30),
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSDistribute where
      TMSDistribute.TMSDistributeId = In_TMSDistributeId and TMSSGSPGenId = In_TMSSGSPGenId) then
    update TMSDistribute set
      CostingAmount = In_CostingAmount where
      TMSSGSPGenId = In_TMSSGSPGenId and
      TMSDistributeId = In_TMSDistributeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;
create procedure DBA.UpdateTMSLeaveDeduction(
in In_TMSSGSPGenId char(30),
in In_TMSLveTypeFunctCode char(20),
in In_CurrentLveDays double,
in In_CurrentLveHours double,
in In_PreviousLveIncDays double,
in In_PreviousLveIncHours double,
in In_CurrentCostingAmt double,
in In_PreviousCostingAmt double,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSLeaveDeduction where
      TMSLeaveDeduction.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSLeaveDeduction.TMSLveTypeFunctCode = In_TMSLveTypeFunctCode) then
    update TMSLeaveDeduction set
      CurrentLveDays = In_CurrentLveDays,
      CurrentLveHours = In_CurrentLveHours,
      PreviousLveIncDays = In_PreviousLveIncDays,
      PreviousLveIncHours = In_PreviousLveIncHours,
      CurrentCostingAmt = In_CurrentCostingAmt,
      PreviousCostingAmt = In_PreviousCostingAmt where
      TMSSGSPGenId = In_TMSSGSPGenId and
      TMSLveTypeFunctCode = In_TMSLveTypeFunctCode;
    commit work;
    update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTMSOverTime(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
in In_CurrentOTFreq double,
in In_LastOTFreq double,
in In_BackPayOTFreq double,
in In_CurrentCostingAmt double,
in In_LastOTCostingAmt double,
in In_BackPayOTCostingAmt double,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSOverTime where
      TMSOverTime.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSOverTime.FormulaId = In_FormulaId) then
    update TMSOverTime set
      CurrentOTFreq = In_CurrentOTFreq,
      LastOTFreq = In_LastOTFreq,
      BackPayOTFreq = In_BackPayOTFreq,
      CurrentCostingAmt = In_CurrentCostingAmt,
      LastOTCostingAmt = In_LastOTCostingAmt,
      BackPayOTCostingAmt = In_BackPayOTCostingAmt where
      TMSSGSPGenId = In_TMSSGSPGenId and
      FormulaId = In_FormulaId;
    commit work;
    update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateTMSShift(
in In_TMSSGSPGenId char(30),
in In_FormulaId char(20),
in In_ShiftFrequency double,
in In_CostingAmount double,
out Out_ErrorCode integer)
begin
  if exists(select* from TMSShift where
      TMSShift.TMSSGSPGenId = In_TMSSGSPGenId and
      TMSShift.FormulaId = In_FormulaId) then
    update TMSShift set
      ShiftFrequency = In_ShiftFrequency,
      CostingAmount = In_CostingAmount where
      TMSSGSPGenId = In_TMSSGSPGenId and
      FormulaId = In_FormulaId;
    commit work;
    update TimeSheet set TimeSheet.LastProcessed = Now(*) where TimeSheet.TMSSGSPGenId = In_TMSSGSPGenId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.ASQLTimeSheetDistributeSDF(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_SDFErrorCode integer)
begin
  declare In_TotalContriSDF double;
  declare In_ContriSDF double;
  declare Accu_ContriSDF double;
  declare In_TotalFreq double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Out_ErrorCode integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_SDFErrorCode=0;
  /*
  Get the SDF Contribution
  */
  select ContriSDF into In_TotalContriSDF
    from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  /*
  Count for TMS Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod;
  /*
  Get Total Working Days
  */
  select Sum(CurrentHrDays) into In_TotalFreq from
    DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  /*
  Distribute SDF
  */
  set Accu_ContriSDF=0;
  SDFLoop: for SDFFor as SDF_curs dynamic scroll cursor for
    select TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      TMSWorkingDayHour as In_TMSWorkingDayHour from
      TimeSheet join TMSDetail where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    if(In_TotalRecord = 1) then
      set In_ContriSDF=Round(In_TotalContriSDF-Accu_ContriSDF,In_DecimalPlace)
    else
      if(In_TotalFreq = 0) then
        set In_ContriSDF=0
      else
        set In_ContriSDF=Round(In_TMSWorkingDayHour/In_TotalFreq*In_TotalContriSDF,In_DecimalPlace);
        if(In_ContriSDF+Accu_ContriSDF > In_TotalContriSDF) then
          set In_ContriSDF=Round(In_TotalContriSDF-Accu_ContriSDF,In_DecimalPlace)
        end if
      end if
    end if;
    set Accu_ContriSDF=Accu_ContriSDF+In_ContriSDF;
    /*
    Update SDF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsSDF') then
      if(In_ContriSDF <> 0) then
        call InsertNewTMSDistribute('TsSDF',In_TMSSGSPGenId,In_ContriSDF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsSDF',In_TMSSGSPGenId,In_ContriSDF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set Out_SDFErrorCode=1;
      return
    end if end for;
  set Out_SDFErrorCode=0;
  message 'End SDF' type info to client
end
;
