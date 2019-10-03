if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeCPFPayment' and user_name(creator) = 'DBA') then
   drop function DBA.FGetEmployeeCPFPayment
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLRecalLeaveDeductionRecord' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLRecalLeaveDeductionRecord
end if;

create procedure DBA.ASQLRecalLeaveDeductionRecord(
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
    set In_LveAmount=Round(cast(In_CurrentDayRateAmt*In_CurrentLveDays as MONEY),FGetDBPayDecimal(*))+
      Round(cast(In_CurrentHourRateAmt*In_CurrentLveHours as MONEY),FGetDBPayDecimal(*))+
      Round(cast(In_PreviousDayRateAmt*In_PerviousLveIncDays as MONEY),FGetDBPayDecimal(*))+
      Round(cast(In_PreviousHourRateAmt*In_PerviousLveIncHours as MONEY),FGetDBPayDecimal(*));
    update LeaveDeductionRecord set LveAmount = In_LveAmount where current of curs end for;
  commit work
end;

create function DBA.FGetEmployeeCPFPayment(in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_EmployeeCPFPayment char(30);
  set Out_EmployeeCPFPayment = '';

  if exists (select 1 from CPFPayment where EmployeeSysId = In_EmployeeSysId and CPFPaymentOption = 1) then
    CPFPaymentLoop: for CPFPaymentFor as curs dynamic scroll cursor for
      select CPFPaymentSubPeriod from CPFPayment where
        EmployeeSysId = In_EmployeeSysId and
        CPFPaymentOption = 1 order by CPFPaymentSubPeriod asc do
      set Out_EmployeeCPFPayment = Out_EmployeeCPFPayment || ' ' || CPFPaymentSubPeriod || ',';
    end for;
    
    set Out_EmployeeCPFPayment = 'Sub Period' || left(Out_EmployeeCPFPayment, length(Out_EmployeeCPFPayment)-1);
  end if ;

  return(Out_EmployeeCPFPayment);
end;

COMMIT WORK;