if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalHKTaxableItemsB2G') then
   drop procedure ASQLCalHKTaxableItemsB2G
end if
;

CREATE PROCEDURE "DBA"."ASQLCalHKTaxableItemsB2G"(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecType char(20),
in In_TaxStartDate date,
in In_TaxEndDate date,
in In_OverwriteAdj integer,
out Out_TotalWage double,
out Out_TotalShift double,
out Out_TotalOT double,
out Out_TotalGrossCode double,
out Out_TotalSalary double,
out Out_TotalLeavePay double,
out Out_TotalDirectorFee double,
out Out_TotalCommissionCode double,
out Out_TotalBonusCode double,
out Out_TotalBackPay double,
out Out_TotalOTBackPay double,
out Out_TotalTerminalCode double,
out Out_TotalGratuityCode double,
out Out_TotalEmperMPF double,
out Out_TotalRetirement double,
out Out_TotalEmployerSalary double,
out Out_AfterTerminate double,
out Out_TotalEducationCode double,
out Out_TotalShareGain double,
out Out_TotalRentalRefund double,
out Out_TotalRentalPayment double,
out Out_TotalPensionCode double,
out Out_TotalTaxBenefit double,
out Out_Nature1 double,
out Out_Nature2 double,
out Out_Nature3 double,
out Out_Nature1Desc char(100),
out Out_Nature2Desc char(100),
out Out_Nature3Desc char(100),
out Out_ErrorCode integer)
begin
  declare Counter integer;
  declare DBDecimal integer;
  declare NormalAllowance integer;
  declare Out_TotalLeaveDeduct double;
  declare Out_FormulaSubCategory char(20);
  //
  //Initialize values
  //
  set Out_TotalLeaveDeduct=0;
  set Out_TotalSalary=0;
  set Out_TotalWage=0;
  set Out_TotalLeavePay=0;
  set Out_TotalDirectorFee=0;
  set Out_TotalBonusCode=0;
  set Out_TotalShift=0;
  set Out_TotalOT=0;
  set Out_TotalBackPay=0;
  set Out_TotalOTBackPay=0;
  set Out_TotalGrossCode=0;
  set Out_TotalCommissionCode=0;
  set Out_TotalTerminalCode=0;
  set Out_TotalRetirement=0;
  set Out_TotalEmployerSalary=0;
  set Out_AfterTerminate=0;
  set Out_TotalEducationCode=0;
  set Out_TotalShareGain=0;
  set Out_TotalRentalRefund=0;
  set Out_TotalRentalPayment=0;
  set Out_TotalPensionCode=0;
  set Out_TotalTaxBenefit=0;
  set Out_TotalGratuityCode=0;
  set Out_TotalEmperMPF=0;
  set Out_Nature1=0;
  set Out_Nature2=0;
  set Out_Nature3=0;
  set Out_Nature1Desc='';
  set Out_Nature2Desc='';
  set Out_Nature3Desc='';
  //
  //Get DBDecimal
  //
  if exists(select IntegerAttr from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBPayDecimal') then
    select IntegerAttr into DBDecimal from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBPayDecimal'
  else
    set DBDecimal=2
  end if;
  //
  //Get Total Wage/OT/OTBackpay/shift/Backpay in the tax year
  //
  select Sum(CalTotalWage),Sum(CalOTAmount),Sum(CalOTBackPay),Sum(CalShiftAmount),Sum(CalBackPay),Sum(CalLveDeductAmt) into Out_TotalWage,
    Out_TotalOT,Out_TotalOTBackPay,Out_TotalShift,Out_TotalBackPay,Out_TotalLeaveDeduct from DetailRecord join PayEmployee where
    DetailRecord.EmployeeSysId = In_EmployeeSysId and
    IsPeriodWithin(
    FGetPhyYearGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    FGetPhyMonthGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    Year(In_TaxStartDate),Month(In_TaxStartDate),
    Year(In_TaxEndDate),Month(In_TaxEndDate)) = 1;
  //
  //Get TotalShare Gain
  //
  select Sum(HKShareGain) into Out_TotalShareGain from HKShareOption where
    EmployeeSysId = In_EmployeeSysId and HKShareTaxDate >= In_TaxStartDate and HKShareTaxDate <= In_TaxEndDate;
  //
  //Get Total Tax Benefit
  //
  select Sum(HKBenefitAmount) into Out_TotalTaxBenefit from HKTaxBenefit where
    EmployeeSysId = In_EmployeeSysId and HKBenefitTaxDate >= In_TaxStartDate and HKBenefitTaxDate <= In_TaxEndDate;
  //
  //Get Total Employer MPF/ORSO Contribution
  //
  select Sum(CurrERVolContri) into Out_TotalEmperMPF from PolicyRecord join PayEmployee where
    PolicyRecord.EmployeeSysId = In_EmployeeSysId and
    IsPeriodWithin(
    FGetPhyYearGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    FGetPhyMonthGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    Year(In_TaxStartDate),Month(In_TaxStartDate),
    Year(In_TaxEndDate),Month(In_TaxEndDate)) = 1;
  //
  //Get Total allowance amount which has Gross Salary Code / CommissionCode/DirectorFee Code
  // Bonus Code,PensionCode,EducationCode,Gratuity Code,TerminalAward Code/Others(Nature1,Nature2,Nature3)
  //
  set Counter=1;
  SumLoop1: for SumAllowanceLoop as Cur_SumAllowanceLoop dynamic scroll cursor for
    select sum(AllowanceAmount) as AllowanceAmt,AllowanceFormulaId as AllowanceFormula,FormulaDesc from
      AllowanceRecord join Formula on(AllowanceRecord.AllowanceFormulaId = Formula.FormulaId) join PayEmployee on(PayEmployee.EmployeeSysId = AllowanceRecord.EmployeeSysId) where
      AllowanceRecord.EmployeeSysId = In_EmployeeSysId and
      IsPeriodWithin(
      FGetPhyYearGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
      FGetPhyMonthGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
      Year(In_TaxStartDate),Month(In_TaxStartDate),
      Year(In_TaxEndDate),Month(In_TaxEndDate)) = 1 group by AllowanceFormulaId,FormulaDesc order by AllowanceAmt desc do
    if((In_HKTaxRecType <> 'IR56F' and In_HKTaxRecType <> 'IR56G') or
      not AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'NoTaxableLeavingCode')) and
      not AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'NonTaxableCode') then
      set NormalAllowance=0;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'CommissionCode') then
        set Out_TotalCommissionCode=Out_TotalCommissionCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'GrossSalaryCode') then
        set Out_TotalGrossCode=Out_TotalGrossCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'DirectorFeeCode') then
        set Out_TotalDirectorFee=Out_TotalDirectorFee+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'BonusCode') then
        set Out_TotalBonusCode=Out_TotalBonusCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'GratuityCode') then
        set Out_TotalGratuityCode=Out_TotalGratuityCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'EducationCode') then
        set Out_TotalEducationCode=Out_TotalEducationCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'PensionCode') then
        set Out_TotalPensionCode=Out_TotalPensionCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'TerminalAwardCode') then
        set Out_TotalTerminalCode=Out_TotalTerminalCode+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'RentRefundCode') then
        set Out_TotalRentalRefund=Out_TotalRentalRefund+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'RentPaymentCode') then
        set Out_TotalRentalPayment=Out_TotalRentalPayment+(AllowanceAmt*-1);
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'RetireSchemeCode') then
        set Out_TotalRetirement=Out_TotalRetirement+AllowanceAmt;
        set NormalAllowance=1
      end if;
      if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'HKLeavePayCode') then
        set Out_TotalLeavePay=Out_TotalLeavePay+AllowanceAmt;
        set NormalAllowance=1
      end if;
      select FormulaSubCategory into Out_FormulaSubCategory from Formula where FormulaId = AllowanceFormula;
      if NormalAllowance <> 1 and Out_FormulaSubCategory <> 'Reimbursement' then
        if Counter = 1 then
          set Out_Nature1=Out_Nature1+AllowanceAmt;
          set Out_Nature1Desc=FormulaDesc;
          set Counter=Counter+1
        else if Counter = 2 then
            set Out_Nature2=Out_Nature2+AllowanceAmt;
            set Out_Nature2Desc=FormulaDesc;
            set Counter=Counter+1
          else
            set Out_Nature3=Out_Nature3+AllowanceAmt
          end if
        end if
      end if
    end if;
    commit work end for;
  //
  //refine values
  //
  if Out_TotalSalary is null then set Out_TotalSalary=0
  else set Out_TotalSalary=Round(Out_TotalSalary,DBDecimal)
  end if;
  if Out_TotalWage is null then set Out_TotalWage=0
  else set Out_TotalWage=Round(Out_TotalWage,DBDecimal)
  end if;
  if Out_TotalLeaveDeduct is null then set Out_TotalLeaveDeduct=0
  else set Out_TotalLeaveDeduct=Round(Out_TotalLeaveDeduct,DBDecimal)
  end if;
  if Out_TotalLeavePay is null then set Out_TotalLeavePay=0
  else set Out_TotalLeavePay=Round(Out_TotalLeavePay,DBDecimal)
  end if;
  if Out_TotalDirectorFee is null then set Out_TotalDirectorFee=0
  else set Out_TotalDirectorFee=Round(Out_TotalDirectorFee,DBDecimal)
  end if;
  if Out_TotalBonusCode is null then set Out_TotalBonusCode=0
  else set Out_TotalBonusCode=Round(Out_TotalBonusCode,DBDecimal)
  end if;
  if Out_TotalShift is null then set Out_TotalShift=0
  else set Out_TotalShift=Round(Out_TotalShift,DBDecimal)
  end if;
  if Out_TotalOT is null then set Out_TotalOT=0
  else set Out_TotalOT=Round(Out_TotalOT,DBDecimal)
  end if;
  if Out_TotalBackPay is null then set Out_TotalBackPay=0
  else set Out_TotalBackPay=Round(Out_TotalBackPay,DBDecimal)
  end if;
  if Out_TotalOTBackPay is null then set Out_TotalOTBackPay=0
  else set Out_TotalOTBackPay=Round(Out_TotalOTBackPay,DBDecimal)
  end if;
  if Out_TotalGrossCode is null then set Out_TotalGrossCode=0
  else set Out_TotalGrossCode=Round(Out_TotalGrossCode,DBDecimal)
  end if;
  if Out_TotalCommissionCode is null then set Out_TotalCommissionCode=0
  else set Out_TotalCommissionCode=Round(Out_TotalCommissionCode,DBDecimal)
  end if;
  if Out_TotalTerminalCode is null then set Out_TotalTerminalCode=0
  else set Out_TotalTerminalCode=Round(Out_TotalTerminalCode,DBDecimal)
  end if;
  if Out_TotalRetirement is null then set Out_TotalRetirement=0
  else set Out_TotalRetirement=Round(Out_TotalRetirement,DBDecimal)
  end if;
  if Out_TotalEmployerSalary is null then set Out_TotalEmployerSalary=0
  else set Out_TotalEmployerSalary=Round(Out_TotalEmployerSalary,DBDecimal)
  end if;
  if Out_AfterTerminate is null then set Out_AfterTerminate=0
  else set Out_AfterTerminate=Round(Out_AfterTerminate,DBDecimal)
  end if;
  if Out_TotalEducationCode is null then set Out_TotalEducationCode=0
  else set Out_TotalEducationCode=Round(Out_TotalEducationCode,DBDecimal)
  end if;
  if Out_TotalShareGain is null then set Out_TotalShareGain=0
  else set Out_TotalShareGain=Round(Out_TotalShareGain,DBDecimal)
  end if;
  if Out_TotalRentalRefund is null then set Out_TotalRentalRefund=0
  else set Out_TotalRentalRefund=Round(Out_TotalRentalRefund,DBDecimal)
  end if;
  if Out_TotalRentalPayment is null then set Out_TotalRentalPayment=0
  else set Out_TotalRentalPayment=Round(Out_TotalRentalPayment,DBDecimal)
  end if;
  if Out_TotalPensionCode is null then set Out_TotalPensionCode=0
  else set Out_TotalPensionCode=Round(Out_TotalPensionCode,DBDecimal)
  end if;
  if Out_TotalTaxBenefit is null then set Out_TotalTaxBenefit=0
  else set Out_TotalTaxBenefit=Round(Out_TotalTaxBenefit,DBDecimal)
  end if;
  if Out_TotalGratuityCode is null then set Out_TotalGratuityCode=0
  else set Out_TotalGratuityCode=Round(Out_TotalGratuityCode,DBDecimal)
  end if;
  if Out_TotalEmperMPF is null then set Out_TotalEmperMPF=0
  else set Out_TotalEmperMPF=Round(Out_TotalEmperMPF,DBDecimal)
  end if;
  if Out_Nature1 is null then set Out_Nature1=0
  else set Out_Nature1=Round(Out_Nature1,DBDecimal)
  end if;
  if Out_Nature2 is null then set Out_Nature2=0
  else set Out_Nature2=Round(Out_Nature2,DBDecimal)
  end if;
  if Out_Nature3 is null then set Out_Nature3=0
  else set Out_Nature3=Round(Out_Nature3,DBDecimal)
  end if;
  //
  //Save/update HKTaxableItems table
  //
  set Out_TotalSalary=Out_TotalWage+Out_TotalShift+Out_TotalOT+Out_TotalGrossCode+Out_TotalLeaveDeduct;
  //Insert Salary, Salary
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Salary' and HKTaxItemCode = 'Salary') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Salary','Salary','Salary',In_TaxStartDate,In_TaxEndDate,Out_TotalSalary,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Salary','Salary','Salary',In_TaxStartDate,In_TaxEndDate,Out_TotalSalary,0,In_OverwriteAdj)
  end if;
  //insert LeavePay, LeavePay
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'LeavePay' and HKTaxItemCode = 'LeavePay') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'LeavePay','LeavePay','Leave Pay',In_TaxStartDate,In_TaxEndDate,Out_TotalLeavePay,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'LeavePay','LeavePay','Leave Pay',In_TaxStartDate,In_TaxEndDate,Out_TotalLeavePay,0,In_OverwriteAdj)
  end if;
  //Director fee, Director fee
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'DirectorFee' and HKTaxItemCode = 'DirectorFee') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'DirectorFee','DirectorFee','Director Fee',In_TaxStartDate,In_TaxEndDate,Out_TotalDirectorFee,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'DirectorFee','DirectorFee','Director Fee',In_TaxStartDate,In_TaxEndDate,Out_TotalDirectorFee,0,In_OverwriteAdj)
  end if;
  //insert commission, commission
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Commission' and HKTaxItemCode = 'Commission') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Commission','Commission','Commission/Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalCommissionCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Commission','Commission','Commission/Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalCommissionCode,0,In_OverwriteAdj)
  end if;
  //Insert Bonus, Bonus
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'BonusCode' and HKTaxItemCode = 'BonusCode') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'BonusCode','BonusCode','Bonus',In_TaxStartDate,In_TaxEndDate,Out_TotalBonusCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'BonusCode','BonusCode','Bonus',In_TaxStartDate,In_TaxEndDate,Out_TotalBonusCode,0,In_OverwriteAdj)
  end if;
  //Insert BackPay, BackPay = TotalBackPay+TotalOTBackPay
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'BackPay' and HKTaxItemCode = 'BackPay') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'BackPay','BackPay','Back Pay',In_TaxStartDate,In_TaxEndDate,Out_TotalBackPay+Out_TotalOTBackPay,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'BackPay','BackPay','Back Pay',In_TaxStartDate,In_TaxEndDate,Out_TotalBackPay+Out_TotalOTBackPay,0,In_OverwriteAdj)
  end if;
  //Insert Terminal Award
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Terminal' and HKTaxItemCode = 'Terminal') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Terminal','Terminal','Terminal Awards',In_TaxStartDate,In_TaxEndDate,Out_TotalTerminalCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Terminal','Terminal','Terminal Awards',In_TaxStartDate,In_TaxEndDate,Out_TotalTerminalCode,0,In_OverwriteAdj)
  end if;
  //Insert Gratuity, Gratuity
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Gratuity' and HKTaxItemCode = 'Gratuity') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Gratuity','Gratuity','Gratuities',In_TaxStartDate,In_TaxEndDate,Out_TotalGratuityCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Gratuity','Gratuity','Gratuities',In_TaxStartDate,In_TaxEndDate,Out_TotalGratuityCode,0,In_OverwriteAdj)
  end if;
  //Insert Retirement, Retirement = RetirementCode
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Retirement' and HKTaxItemCode = 'Retirement') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Retirement','Retirement','Retirement Scheme',In_TaxStartDate,In_TaxEndDate,Out_TotalRetirement,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Retirement','Retirement','Retirement Scheme',In_TaxStartDate,In_TaxEndDate,Out_TotalRetirement,0,In_OverwriteAdj)
  end if;
  //Insert Employer Salary, Employer Salary = 0
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'EmployerSalary' and HKTaxItemCode = 'EmployerSalary') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'EmployerSalary','EmployerSalary','Salaries Tax Paid By Employer',In_TaxStartDate,In_TaxEndDate,Out_TotalEmployerSalary,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'EmployerSalary','EmployerSalary','Salaries Tax Paid By Employer',In_TaxStartDate,In_TaxEndDate,Out_TotalEmployerSalary,0,In_OverwriteAdj)
  end if;
  //Insert AfterTerminate, After Terminate = 0
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'AfterTerminate' and HKTaxItemCode = 'AfterTerminate') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'AfterTerminate','AfterTerminate','Payment that will be paid after termination',In_TaxStartDate,In_TaxEndDate,Out_AfterTerminate,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'AfterTerminate','AfterTerminate','Payment that will be paid after termination',In_TaxStartDate,In_TaxEndDate,Out_AfterTerminate,0,In_OverwriteAdj)
  end if;
  //Insert Education, Education
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Education' and HKTaxItemCode = 'Education') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Education','Education','Education Benefits',In_TaxStartDate,In_TaxEndDate,Out_TotalEducationCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Education','Education','Education Benefits',In_TaxStartDate,In_TaxEndDate,Out_TotalEducationCode,0,In_OverwriteAdj)
  end if;
  //Insert ShareGain, ShareGain
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'ShareGain' and HKTaxItemCode = 'ShareGain') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'ShareGain','ShareGain','Gain realized under share option scheme',In_TaxStartDate,In_TaxEndDate,Out_TotalShareGain,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'ShareGain','ShareGain','Gain realized under share option scheme',In_TaxStartDate,In_TaxEndDate,Out_TotalShareGain,0,In_OverwriteAdj)
  end if;
  //Insert RentalRefund, RentalRefund
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'RentalRefund' and HKTaxItemCode = 'RentalRefund') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'RentalRefund','RentalRefund','Rental Refund Code',In_TaxStartDate,In_TaxEndDate,Out_TotalRentalRefund,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'RentalRefund','RentalRefund','Rental Refund Code',In_TaxStartDate,In_TaxEndDate,Out_TotalRentalRefund,0,In_OverwriteAdj)
  end if;
  //Insert RentalPayment,RentalPayment
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'RentalPayment' and HKTaxItemCode = 'RentalPayment') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'RentalPayment','RentalPayment','Rental Payment Code',In_TaxStartDate,In_TaxEndDate,Out_TotalRentalPayment,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'RentalPayment','RentalPayment','Rental Payment Code',In_TaxStartDate,In_TaxEndDate,Out_TotalRentalPayment,0,In_OverwriteAdj)
  end if;
  //Insert Pension, Pension
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Pension' and HKTaxItemCode = 'Pension') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Pension','Pension','Pension',In_TaxStartDate,In_TaxEndDate,Out_TotalPensionCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Pension','Pension','Pension',In_TaxStartDate,In_TaxEndDate,Out_TotalPensionCode,0,In_OverwriteAdj)
  end if;
  //Insert TaxBenefits, TaxBenefits
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'TaxBenefits' and HKTaxItemCode = 'TaxBenefits') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'TaxBenefits','TaxBenefits','Tax Benefits',In_TaxStartDate,In_TaxEndDate,Out_TotalTaxBenefit,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'TaxBenefits','TaxBenefits','Tax Benefits',In_TaxStartDate,In_TaxEndDate,Out_TotalTaxBenefit,0,In_OverwriteAdj)
  end if;
  //Insert Nature1, Nature1
  if Out_Nature1 <> 0 then
    if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature1') then
      call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature1',Out_Nature1Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature1,0)
    else
      call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature1',Out_Nature1Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature1,0,In_OverwriteAdj)
    end if
  else
    delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature1'
  end if;
  //Insert Nature2, Nature2
  if Out_Nature2 <> 0 then
    if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature2') then
      call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature2',Out_Nature2Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature2,0)
    else
      call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature2',Out_Nature2Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature2,0,In_OverwriteAdj)
    end if
  else
    delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature2'
  end if;
  //Insert Nature3, Nature3
  set Out_Nature3Desc='Other';
  if Out_Nature3 <> 0 then
    if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature3') then
      call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature3',Out_Nature3Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature3,0)
    else
      call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecType,'Other','Nature3',Out_Nature3Desc,In_TaxStartDate,In_TaxEndDate,Out_Nature3,0,In_OverwriteAdj)
    end if
  else
    delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecType and HKTaxItemType = 'Other' and HKTaxItemCode = 'Nature3'
  end if;
  commit work
end;


if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalHKTaxableItemsM') then
   drop procedure ASQLCalHKTaxableItemsM
end if
;

CREATE PROCEDURE "DBA"."ASQLCalHKTaxableItemsM"(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_TaxStartDate date,
in In_TaxEndDate date,
in In_OverwriteAdj integer,
out Out_TotalSubContract double,
out Out_TotalWage double,
out Out_TotalShift double,
out Out_TotalOT double,
out Out_TotalBackPay double,
out Out_TotalOTBackPay double,
out Out_TotalGrossCode double,
out Out_TotalCommissionCode double,
out Out_TotalContributorFee double,
out Out_ArtisteFee double,
out Out_RoyaltiesFee double,
out Out_ConsultancyFee double,
out Out_TotalItem1 double,
out Out_TotalItem2 double,
out Out_TotalItem1Desc char(100),
out Out_TotalItem2Desc char(100),
out Out_ErrorCode integer)
begin
  declare Counter integer;
  declare DBDecimal integer;
  declare NormalAllowance integer;
  declare Out_FormulaSubCategory char(20);
  //
  //Initislize values
  //
  set Out_TotalSubContract=0;
  set Out_TotalWage=0;
  set Out_TotalShift=0;
  set Out_TotalOT=0;
  set Out_TotalBackPay=0;
  set Out_TotalOTBackPay=0;
  set Out_TotalGrossCode=0;
  set Out_TotalCommissionCode=0;
  set Out_TotalContributorFee=0;
  set Out_ArtisteFee=0;
  set Out_RoyaltiesFee=0;
  set Out_ConsultancyFee=0;
  set Out_TotalItem1=0;
  set Out_TotalItem2=0;
  set Out_TotalItem1Desc='';
  set Out_TotalItem2Desc='';
  //
  //Get DBDecimal
  //
  if exists(select IntegerAttr from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBPayDecimal') then
    select IntegerAttr into DBDecimal from SubRegistry where RegistryId = 'System' and SubRegistryId = 'DBPayDecimal'
  else
    set DBDecimal=2
  end if;
  //
  //Get Total Wage/OT/OTBackpay/shift/Backpay in the tax year
  //
  select Sum(CalTotalWage),Sum(CalOTAmount),Sum(CalOTBackPay),Sum(CalShiftAmount),Sum(CalBackPay) into Out_TotalWage,
    Out_TotalOT,Out_TotalOTBackPay,Out_TotalShift,Out_TotalBackPay from DetailRecord join PayEmployee where
    DetailRecord.EmployeeSysId = In_EmployeeSysId and
    IsPeriodWithin(
    FGetPhyYearGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    FGetPhyMonthGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
    Year(In_TaxStartDate),Month(In_TaxStartDate),
    Year(In_TaxEndDate),Month(In_TaxEndDate)) = 1;
  //
  //Get Total allowance amount which has Gross Salary Code / CommissionCode / Contributor Fee Code/5 Items
  //
  set Counter=1;
  SumLoop1: for SumAllowanceLoop as Cur_SumAllowanceLoop dynamic scroll cursor for
    select AllowanceAmount as AllowanceAmt,AllowanceFormulaId as AllowanceFormula,FormulaDesc from
      AllowanceRecord join Formula on(AllowanceRecord.AllowanceFormulaId = Formula.FormulaId) join PayEmployee on(PayEmployee.EmployeeSysId = AllowanceRecord.EmployeeSysId) where
      AllowanceRecord.EmployeeSysId = In_EmployeeSysId and
      IsPeriodWithin(
      FGetPhyYearGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
      FGetPhyMonthGivenPayYrPeriod(PayGroupId,PayRecYear,PayRecPeriod),
      Year(In_TaxStartDate),Month(In_TaxStartDate),
      Year(In_TaxEndDate),Month(In_TaxEndDate)) = 1 order by AllowanceAmt desc do
    set NormalAllowance=0;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'CommissionCode') then
      set Out_TotalCommissionCode=Out_TotalCommissionCode+AllowanceAmt;
      set NormalAllowance=1
    end if;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'GrossSalaryCode') then
      set Out_TotalGrossCode=Out_TotalGrossCode+AllowanceAmt;
      set NormalAllowance=1
    end if;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'ContributorFeesCode') then
      set Out_TotalContributorFee=Out_TotalContributorFee+AllowanceAmt;
      set NormalAllowance=1
    end if;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'ArtisteFeeCode') then
      set Out_ArtisteFee=Out_ArtisteFee+AllowanceAmt;
      set NormalAllowance=1
    end if;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'RoyaltiesCode') then
      set Out_RoyaltiesFee=Out_RoyaltiesFee+AllowanceAmt;
      set NormalAllowance=1
    end if;
    if AllowanceFormula = any(select FormulaId from FormulaProperty where KeywordId = 'ConsultancyFeeCode') then
      set Out_ConsultancyFee=Out_ConsultancyFee+AllowanceAmt;
      set NormalAllowance=1
    end if;
    select FormulaSubCategory into Out_FormulaSubCategory from Formula where FormulaId = AllowanceFormula;
    if NormalAllowance <> 1 and Out_FormulaSubCategory <> 'Reimbursement' then
      if Counter = 1 then
        set Out_TotalItem1=Out_TotalItem1+AllowanceAmt;
        set Out_TotalItem1Desc=FormulaDesc;
        set Counter=Counter+1
      else
        set Out_TotalItem2=Out_TotalItem2+AllowanceAmt;
        set Counter=Counter+1
      end if
    end if;
    commit work end for;
  //
  //refine values
  //
  if Out_TotalSubContract is null then set Out_TotalSubContract=0
  else set Out_TotalSubContract=Round(Out_TotalSubContract,DBDecimal)
  end if;
  if Out_TotalWage is null then set Out_TotalWage=0
  else set Out_TotalWage=Round(Out_TotalWage,DBDecimal)
  end if;
  if Out_TotalShift is null then set Out_TotalShift=0
  else set Out_TotalShift=Round(Out_TotalShift,DBDecimal)
  end if;
  if Out_TotalOT is null then set Out_TotalOT=0
  else set Out_TotalOT=Round(Out_TotalOT,DBDecimal)
  end if;
  if Out_TotalBackPay is null then set Out_TotalBackPay=0
  else set Out_TotalBackPay=Round(Out_TotalBackPay,DBDecimal)
  end if;
  if Out_TotalOTBackPay is null then set Out_TotalOTBackPay=0
  else set Out_TotalOTBackPay=Round(Out_TotalOTBackPay,DBDecimal)
  end if;
  if Out_TotalGrossCode is null then set Out_TotalGrossCode=0
  else set Out_TotalGrossCode=Round(Out_TotalGrossCode,DBDecimal)
  end if;
  if Out_TotalCommissionCode is null then set Out_TotalCommissionCode=0
  else set Out_TotalCommissionCode=Round(Out_TotalCommissionCode,DBDecimal)
  end if;
  if Out_TotalContributorFee is null then set Out_TotalContributorFee=0
  else set Out_TotalContributorFee=Round(Out_TotalContributorFee,DBDecimal)
  end if;
  if Out_ArtisteFee is null then set Out_ArtisteFee=0
  else set Out_ArtisteFee=Round(Out_ArtisteFee,DBDecimal)
  end if;
  if Out_RoyaltiesFee is null then set Out_RoyaltiesFee=0
  else set Out_RoyaltiesFee=Round(Out_RoyaltiesFee,DBDecimal)
  end if;
  if Out_ConsultancyFee is null then set Out_ConsultancyFee=0
  else set Out_ConsultancyFee=Round(Out_ConsultancyFee,DBDecimal)
  end if;
  if Out_TotalItem1 is null then set Out_TotalItem1=0
  else set Out_TotalItem1=Round(Out_TotalItem1,DBDecimal)
  end if;
  if Out_TotalItem2 is null then set Out_TotalItem2=0
  else set Out_TotalItem2=Round(Out_TotalItem2,DBDecimal)
  end if;
  //
  //Save/update HKTaxableItems table
  //
  set Out_TotalSubContract=Out_TotalWage+Out_TotalShift+Out_TotalOT+Out_TotalBackPay+Out_TotalOTBackPay+Out_TotalGrossCode;
  //Insert subcontract, subcontract
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Subcontract' and HKTaxItemCode = 'Subcontract') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Subcontract','Subcontract','Subcontracting Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalSubContract,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Subcontract','Subcontract','Subcontracting Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalSubContract,0,In_OverwriteAdj)
  end if;
  //insert commission, commission
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Commission' and HKTaxItemCode = 'Commission') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Commission','Commission','Commission / Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalCommissionCode,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Commission','Commission','Commission / Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalCommissionCode,0,In_OverwriteAdj)
  end if;
  //insert writerfee, writer fee
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'WriterFee' and HKTaxItemCode = 'WriterFee') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'WriterFee','WriterFee','Writer / Contributor Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalContributorFee,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'WriterFee','WriterFee','Writer / Contributor Fees',In_TaxStartDate,In_TaxEndDate,Out_TotalContributorFee,0,In_OverwriteAdj)
  end if;
  //insert ConsultancyFee
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'ConsultancyFee') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','ConsultancyFee','Consultancy Fee',In_TaxStartDate,In_TaxEndDate,Out_ConsultancyFee,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','ConsultancyFee','Consultancy Fee',In_TaxStartDate,In_TaxEndDate,Out_ConsultancyFee,0,In_OverwriteAdj)
  end if;
  //insert RoyaltiesFee
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'RoyaltiesFee') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','RoyaltiesFee','Royalties Fee',In_TaxStartDate,In_TaxEndDate,Out_RoyaltiesFee,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','RoyaltiesFee','Royalties Fee',In_TaxStartDate,In_TaxEndDate,Out_RoyaltiesFee,0,In_OverwriteAdj)
  end if;
  //insert ArtisteFee
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'ArtisteFee') then
    call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','ArtisteFee','Artiste Fee',In_TaxStartDate,In_TaxEndDate,Out_ArtisteFee,0)
  else
    call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','ArtisteFee','Artiste Fee',In_TaxStartDate,In_TaxEndDate,Out_ArtisteFee,0,In_OverwriteAdj)
  end if;
  //Insert Item1
  if Out_TotalItem1 <> 0 then
    if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'Item1') then
      call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','Item1',Out_TotalItem1Desc,In_TaxStartDate,In_TaxEndDate,Out_TotalItem1,0)
    else
      call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','Item1',Out_TotalItem1Desc,In_TaxStartDate,In_TaxEndDate,Out_TotalItem1,0,In_OverwriteAdj)
    end if
  else
    delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'Item1'
  end if;
  //Insert Item2
  set Out_TotalItem2Desc='Others';
  if Out_TotalItem2 <> 0 then
    if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'Item2') then
      call InsertNewHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','Item2',Out_TotalItem2Desc,In_TaxStartDate,In_TaxEndDate,Out_TotalItem2,0)
    else
      call UpdateHKTaxableItems(In_EmployeeSysId,In_HKTaxYear,In_HKTaxRecordType,'Others','Item2',Out_TotalItem2Desc,In_TaxStartDate,In_TaxEndDate,Out_TotalItem2,0,In_OverwriteAdj)
    end if
  else
    delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemType = 'Others' and HKTaxItemCode = 'Item2'
  end if;
  commit work
end
;


