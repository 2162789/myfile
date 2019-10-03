READ UpgradeDB\Ver1060702\2014JanCPFRate.sql;

Update LeaveComputation set IncludeHolidayoff=0 
where LeaveFunctionID IN ('MOM Maternity', 'MOM Paternity','MOM Adoption','MOM Shared Parental');

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCPFContriWage') then
   drop procedure ASQLCalPayRecCPFContriWage;
end if;

Create PROCEDURE DBA.ASQLCalPayRecCPFContriWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
out Out_OTAmount double,
out Out_OTBackPay double,
out Out_ShiftAmount double,
out Out_LeaveDeductAmt double,
out Out_BackPay double,
out Out_TotalWage double,
out Out_CPFAllowance double,
out Out_CPFDeduction double,
out Out_CPFContriWage double)
begin
  declare CPFContriWage double;
  set CPFContriWage=0;
  set Out_OTAmount=0;
  set Out_OTBackPay=0;
  set Out_ShiftAmount=0;
  set Out_LeaveDeductAmt=0;
  set Out_BackPay=0;
  set Out_TotalWage=0;
  set Out_CPFAllowance=0;
  set Out_CPFDeduction=0;

  // Compute OT Amount
    select Sum(CalOTAmount) into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod; 
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTAmount;

  // Compute OT Back Pay    
    select Sum(CalOTBackPay) into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTBackPay;

  // Compute Shift Amount    
    select Sum(CalShiftAmount) into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_ShiftAmount;

  // Compute Leave Deduction Amount  
    select Sum(CalLveDeductAmt) into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set CPFContriWage=CPFContriWage+Out_LeaveDeductAmt;

  // Compute Back Pay  
    select Sum(CalBackPay) into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod; 
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_BackPay;

  // Compute Total Wage  
    select Sum(CalTotalWage) into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod;
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set CPFContriWage=CPFContriWage+Out_TotalWage;

  // Compute CPF Allowance  
    select FGetPayRecCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,'') into Out_CPFAllowance;
    set CPFContriWage=CPFContriWage+Out_CPFAllowance;

  // Compute CPF Deduction  
    select FGetPayRecCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,'') into Out_CPFDeduction;
    set CPFContriWage=CPFContriWage+Out_CPFDeduction;

  // Compute CPF Contribution Wage  
  set Out_CPFContriWage=Round(CPFContriWage,FGetDBPayDecimal(*));
end
;

commit work;