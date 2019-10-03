READ UpgradeDB\Ver1060701\SG_Holiday.sql;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCPFContriWage') then
   drop procedure ASQLCalPayRecCPFContriWage
end if;

Create PROCEDURE DBA.ASQLCalPayRecCPFContriWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
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
    select CalOTAmount into Out_OTAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTAmount;

  // Compute OT Back Pay    
    select CalOTBackPay into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTBackPay;

  // Compute Shift Amount    
    select CalShiftAmount into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_ShiftAmount;

  // Compute Leave Deduction Amount  
    select CalLveDeductAmt into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set CPFContriWage=CPFContriWage+Out_LeaveDeductAmt;

  // Compute Back Pay  
    select CalBackPay into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_BackPay;

  // Compute Total Wage  
    select CalTotalWage into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set CPFContriWage=CPFContriWage+Out_TotalWage;

  // Compute CPF Allowance  
    select FGetPayRecCPFAllowance(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFAllowance;
    set CPFContriWage=CPFContriWage+Out_CPFAllowance;

  // Compute CPF Deduction  
    select FGetPayRecCPFDeduction(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID) into Out_CPFDeduction;
    set CPFContriWage=CPFContriWage+Out_CPFDeduction;

  // Compute CPF Contribution Wage  
  set Out_CPFContriWage=Round(CPFContriWage,FGetDBPayDecimal(*));
end
;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BOA (EFD)' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BOA (EFD)','RSingBankFormatBOAEDF.dll','InvokeSalaryFormatter',0)
END IF;

UPDATE Subregistry SET RegProperty1='14', RegProperty2='46' WHERE SubRegistryId='SGSickHosp2000';
UPDATE Subregistry SET RegProperty1='5', RegProperty2='10' WHERE SubRegistryId='SGSickHosp2000P3';
UPDATE Subregistry SET RegProperty1='8', RegProperty2='22' WHERE SubRegistryId='SGSickHosp2000P4';
UPDATE Subregistry SET RegProperty1='11', RegProperty2='34' WHERE SubRegistryId='SGSickHosp2000P5';
UPDATE Subregistry SET RegProperty1='14', RegProperty2='46' WHERE SubRegistryId IN ('SGSickHosp2000P6','SGSickHosp2000P7','SGSickHosp2000P8','SGSickHosp2000P9','SGSickHosp2000P10','SGSickHosp2000P11','SGSickHosp2000P12');

UPDATE Subregistry SET RegProperty1='16', RegProperty2='12' WHERE SubRegistryId='SGMaternity2000';
UPDATE Subregistry SET RegProperty1='0', RegProperty2='1' WHERE SubRegistryId='SGPaternity2013';
UPDATE Subregistry SET RegProperty1='0', RegProperty2='1' WHERE SubRegistryId='SGSharedParental2013';
UPDATE Subregistry SET RegProperty1='0', RegProperty2='4' WHERE SubRegistryId='SGAdoption2013';


commit work;