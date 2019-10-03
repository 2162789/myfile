create procedure
dba.ASQLCalHKTaxableItemsB2G(
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
      if NormalAllowance <> 1 then
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
end
;


create procedure dba.ASQLCalHKTaxableItemsM(
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
    if NormalAllowance <> 1 then
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

create procedure DBA.ASQLCalPayRecMPFManAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SchemeId char(20),
out Out_ManAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_ManAddWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_SchemeId = 'MPF' then
    set SubjectProperty='SubjMPFManAdd';
    set WageProperty='ManAddWage'
  else
    set SubjectProperty='SubjORSOManAdd';
    set WageProperty='ManAddWage'
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_ManAddWage=Out_ManAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManAddWage=Out_ManAddWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManAddWage=Out_ManAddWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManAddWage=Out_ManAddWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecMPFManOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SchemeId char(20),
out Out_ManOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_ManOrdWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_SchemeId = 'MPF' then
    set SubjectProperty='SubjMPFManOrd';
    set WageProperty='ManOrdWage'
  else
    set SubjectProperty='SubjORSOManOrd';
    set WageProperty='ManOrdWage'
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_ManOrdWage=Out_ManOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManOrdWage=Out_ManOrdWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManOrdWage=Out_ManOrdWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_ManOrdWage=Out_ManOrdWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecMPFVolAddWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SchemeId char(20),
out Out_VolAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_VolAddWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_SchemeId = 'MPF' then
    set SubjectProperty='SubjMPFVolAdd';
    set WageProperty='VolAddWage'
  else
    set SubjectProperty='SubjORSOVolAdd';
    set WageProperty='VolAddWage'
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_VolAddWage=Out_VolAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolAddWage=Out_VolAddWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolAddWage=Out_VolAddWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolAddWage=Out_VolAddWage+Out_TotalWageAmt
  end if
end
;

create procedure DBA.ASQLCalPayRecMPFVolOrdWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_SchemeId char(20),
out Out_VolOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_VolOrdWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_SchemeId = 'MPF' then
    set SubjectProperty='SubjMPFVolOrd';
    set WageProperty='VolOrdWage'
  else
    set SubjectProperty='SubjORSOVolOrd';
    set WageProperty='VolOrdWage'
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_VolOrdWage=Out_VolOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolOrdWage=Out_VolOrdWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolOrdWage=Out_VolOrdWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_VolOrdWage=Out_VolOrdWage+Out_TotalWageAmt
  end if
end
;

create procedure dba.DeleteHKIR56BRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    delete from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear;
    commit work;
    if exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKIR56ERecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    delete from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear;
    commit work;
    if exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKIR56FRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    delete from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear;
    commit work;
    if exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKIR56GRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    delete from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear;
    commit work;
    if exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKIR56MRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    delete from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear;
    commit work;
    if exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKPlaceOfRes(
in In_HKPlaceOfResSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKPlaceOfRes where HKPlaceOfResSysId = In_HKPlaceOfResSysId) then
    delete from HKPlaceOfRes where HKPlaceOfResSysId = In_HKPlaceOfResSysId;
    commit work;
    if exists(select* from HKPlaceOfRes where HKPlaceOfResSysId = In_HKPlaceOfResSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKTaxDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKTaxDetails where EmployeeSysId = In_EmployeeSysId) then
    if exists(select* from HKTaxYear where EmployeeSysId = In_EmployeeSysId) then
      if exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId) then
        if exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId) then
          delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId;
          commit work
        end if;
        if exists(select* from HKPlaceOfRes where EmployeeSysId = In_EmployeeSysId) then
          delete from HKPlaceOfRes where EmployeeSysId = In_EmployeeSysId;
          commit work
        end if;
        delete from HKTaxRecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      if exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId) then
        delete from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      if exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId) then
        delete from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      if exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId) then
        delete from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      if exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId) then
        delete from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      if exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId) then
        delete from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId;
        commit work
      end if;
      delete from HKTaxYear where EmployeeSysId = In_EmployeeSysId;
      commit work
    end if;
    if exists(select* from HKTaxBenefit where EmployeeSysId = In_EmployeeSysId) then
      delete from HKTaxBenefit where EmployeeSysId = In_EmployeeSysId;
      commit work
    end if;
    if exists(select* from HKShareOption where EmployeeSysId = In_EmployeeSysId) then
      delete from HKShareOption where EmployeeSysId = In_EmployeeSysId;
      commit work
    end if;
    delete from HKTaxDetails where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from HKTaxDetails where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKTaxEmployer(
in In_HKTaxEmployerId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKTaxDetails where HKTaxEmployerId = In_HKTaxEmployerId) then
    if exists(select* from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId) then
      delete from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId;
      commit work;
      if exists(select* from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKTaxRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType) then
    if exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType) then
      delete from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType;
      commit work
    end if;
    if exists(select* from HKPlaceOfRes where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType) then
      delete from HKPlaceOfRes where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType;
      commit work
    end if;
    delete from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType;
    commit work;
    if exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMPFProgression(
in In_MPFProgSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MPFProgression where MPFProgSysId = In_MPFProgSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  end if;
  delete from MPFProgression where MPFProgSysId = In_MPFProgSysId;
  commit work;
  if exists(select* from MPFProgression where MPFProgSysId = In_MPFProgSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create function DBA.FGetEmployeePersonalTypeId(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_PersonalTypeId char(20);
  select PersonalTypeId into Out_PersonalTypeId
    from Personal where PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
  return(Out_PersonalTypeId)
end
;

create function dba.FGetHKTaxableItemsAmount(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemCode char(20))
returns double
begin
  declare Out_Amount double;
  if In_HKTaxItemCode is not null then
    select "truncate"(FConvertNull(HKTaxItemAmount)+FConvertNull(HKTaxItemAmountAdj),0) into Out_Amount from HKTaxableItems where
      EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType and HKTaxItemCode = In_HKTaxItemCode
  else
    select Sum("truncate"(FConvertNull(HKTaxItemAmount)+FConvertNull(HKTaxItemAmountAdj),0)) into Out_Amount from HKTaxableItems where
      EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType
  end if;
  if(Out_Amount is null) then
    return 0
  else return(Out_Amount)
  end if
end
;

create function dba.FGetHKTaxableItemsDesc(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemCode char(20))
returns char(100)
begin
  declare Out_Desc char(100);
  select HKTaxItemDesc into Out_Desc from HKTaxableItems where
    EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
    HKTaxRecordType = In_HKTaxRecordType and HKTaxItemCode = In_HKTaxItemCode;
  if(Out_Desc is null) then
    return ''
  else return(Out_Desc)
  end if
end
;

create function dba.FGetHKTaxableItemsPeriod(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemCode char(20))
returns char(100)
begin
  declare Temp_FromDate char(10);
  declare Temp_ToDate char(10);
  declare Out_Period char(100);
  select FGetDateFormat(HKTaxItemFromDate),FGetDateFormat(HKTaxItemToDate) into Temp_FromDate,Temp_ToDate from HKTaxableItems where
    EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
    HKTaxRecordType = In_HKTaxRecordType and HKTaxItemCode = In_HKTaxItemCode;
  set Out_Period=Temp_FromDate || ' - ' || Temp_ToDate;
  if(Out_Period is null) then
    return ''
  else return(Out_Period)
  end if
end
;

create function dba.FGetMPFFormula(
in In_OrdFormulaId char(20))
returns char(255)
begin
  declare Out_OrdDesc char(255);
  declare OrdFormulaType char(20);
  declare OrdC1 double;
  declare OrdC2 double;
  declare OrdC3 double;
  declare OrdC4 double;
  declare OrdC5 double;
  declare OrdUserDef1 char(20);
  declare OrdUserDef2 char(20);
  /*
  To Get Ordinary Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    UserDef1,
    UserDef2 into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5,
    OrdUserDef1,
    OrdUserDef2 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  set Out_OrdDesc=null;
  /*
  To check the formula type
  */
  if(OrdFormulaType = 'T1') then
    if(OrdUserDef1 = 'RNDPVT') then
      set Out_OrdDesc=OrdUserDef1+'('+OrdUserDef2+')['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF ]'
    elseif(OrdUserDef1 = 'ROUND') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF ]'
    elseif(OrdUserDef1 = 'TRUNC') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF ]'
    end if
  elseif(OrdFormulaType = 'T2') then
    if(OrdUserDef1 = 'RNDPVT') then
      set Out_OrdDesc=OrdUserDef1+'('+OrdUserDef2+')['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and monthly capping $'+LTrim(Str(OrdC3,8,2))+']'
    elseif(OrdUserDef1 = 'ROUND') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and monthly capping $'+LTrim(Str(OrdC3,8,2))+']'
    elseif(OrdUserDef1 = 'TRUNC') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and monthly capping $'+LTrim(Str(OrdC3,8,2))+']'
    end if
  elseif(OrdFormulaType = 'T3') then
    if(OrdUserDef1 = 'RNDPVT') then
      set Out_OrdDesc=OrdUserDef1+'('+OrdUserDef2+')['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and yearly capping $'+LTrim(Str(OrdC3,8,2))+']'
    elseif(OrdUserDef1 = 'ROUND') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and yearly capping $'+LTrim(Str(OrdC3,8,2))+']'
    elseif(OrdUserDef1 = 'TRUNC') then
      set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of Ordinary MPF and '+LTrim(Str(OrdC2,8,2))+'% of Additional MPF and yearly capping $'+LTrim(Str(OrdC3,8,2))+']'
    end if
  elseif(OrdFormulaType = 'T4') then
    set Out_OrdDesc=' Fixed amount $'+LTrim(Str(OrdC1,8,1))
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc
  end if;
  return Out_OrdDesc
end
;

create function DBA.FGetMPFProgPreviousProgDate(
in In_EmployeeSysId integer,
in In_MPFProgEffDate date)
returns date
begin
  declare Out_PrevMPFProgEffDate date;
  declare Out_MPFProgSysId integer;
  select max(MPFProgEffDate) into Out_PrevMPFProgEffDate from MPFProgression where EmployeeSysId = in_EmployeeSysId and
    MPFProgEffDate < In_MPFProgEffDate;
  select first MPFProgSysId into Out_MPFProgSysId from MPFProgression where MPFProgression.EmployeeSysId = In_EmployeeSysId and
    MPFProgEffDate = Out_PrevMPFProgEffDate Order By MPFProgSysId;
  update MPFProgression set
    MPFProgression.MPFCurrent = 1 where
    MPFProgression.EmployeeSysId = In_EmployeeSysId and MPFProgEffDate = Out_PrevMPFProgEffDate and
    MPFProgSysId = Out_MPFProgSysId;
  commit work;
  return(Out_PrevMPFProgEffDate)
end
;

create procedure DBA.InsertNewHKIR56BRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKIR56BRemarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKIR56BRecord(EmployeeSysId,
      HKTaxYear,
      HKEmpPeriodFrom,
      HKEmpPeriodTo,
      HKIR56BRemarks) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKEmpPeriodFrom,
      In_HKEmpPeriodTo,
      In_HKIR56BRemarks);
    commit work;
    if not exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKIR56ERecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKCommenceDate date,
in In_HKPrevEmployer char(50),
in In_HKPrevEmployerAdd char(100),
in In_HKFixedIncome double,
in In_HKAllowance double,
in In_HKFluctuateIncome double,
in In_HKGrantedShare integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKIR56ERecord(EmployeeSysId,
      HKTaxYear,
      HKCommenceDate,
      HKPrevEmployer,
      HKPrevEmployerAdd,
      HKFixedIncome,
      HKAllowance,
      HKFluctuateIncome,
      HKGrantedShare) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKCommenceDate,
      In_HKPrevEmployer,
      In_HKPrevEmployerAdd,
      In_HKFixedIncome,
      In_HKAllowance,
      In_HKFluctuateIncome,
      In_HKGrantedShare);
    commit work;
    if not exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKIR56FRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKCessationReason char(100),
in In_HKNewEmployer char(50),
in In_HKNewEmployerAdd char(100),
in In_HKEmpFutureAdd char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKIR56FRecord(EmployeeSysId,
      HKTaxYear,
      HKEmpPeriodFrom,
      HKEmpPeriodTo,
      HKCessationReason,
      HKNewEmployer,
      HKNewEmployerAdd,
      HKEmpFutureAdd) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKEmpPeriodFrom,
      In_HKEmpPeriodTo,
      In_HKCessationReason,
      In_HKNewEmployer,
      In_HKNewEmployerAdd,
      In_HKEmpFutureAdd);
    commit work;
    if not exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKIR56GRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKDepartureDate date,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKTaxBorneEmper integer,
in In_HKHasMoneyWithold integer,
in In_HKMoneyWithold double,
in In_HKNoWitholdReason char(100),
in In_HKLeaveReason char(20),
in In_HKReasonDesc char(100),
in In_HKMayReturn integer,
in In_HKMayReturnDate date,
in In_HKHasShareOption integer,
in In_HKNoOfShare integer,
in In_HKShareGrantDate date,
in In_HKEmpFutureAdd char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKIR56GRecord(EmployeeSysId,
      HKTaxYear,
      HKDepartureDate,
      HKEmpPeriodFrom,
      HKEmpPeriodTo,
      HKTaxBorneEmper,
      HKHasMoneyWithold,
      HKMoneyWithold,
      HKNoWitholdReason,
      HKLeaveReason,
      HKReasonDesc,
      HKMayReturn,
      HKMayReturnDate,
      HKHasShareOption,
      HKNoOfShare,
      HKShareGrantDate,
      HKEmpFutureAdd) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKDepartureDate,
      In_HKEmpPeriodFrom,
      In_HKEmpPeriodTo,
      In_HKTaxBorneEmper,
      In_HKHasMoneyWithold,
      In_HKMoneyWithold,
      In_HKNoWitholdReason,
      In_HKLeaveReason,
      In_HKReasonDesc,
      In_HKMayReturn,
      In_HKMayReturnDate,
      In_HKHasShareOption,
      In_HKNoOfShare,
      In_HKShareGrantDate,
      In_HKEmpFutureAdd);
    commit work;
    if not exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKIR56MRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKCompanyName char(100),
in In_HKCompanyRegNo char(20),
in In_HKServiceFromDate date,
in In_HKServiceToDate date,
in In_HKSumWithheld integer,
in In_HKSumWithheldAmt double,
in In_HKRemarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKIR56MRecord(EmployeeSysId,
      HKTaxYear,
      HKCompanyName,
      HKCompanyRegNo,
      HKServiceFromDate,
      HKServiceToDate,
      HKSumWithheld,
      HKSumWithheldAmt,
      HKRemarks) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKCompanyName,
      In_HKCompanyRegNo,
      In_HKServiceFromDate,
      In_HKServiceToDate,
      In_HKSumWithheld,
      In_HKSumWithheldAmt,
      In_HKRemarks);
    commit work;
    if not exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKPlaceOfRes(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKResAddress char(100),
in In_HKResNature char(20),
in In_HKProvideFromDate date,
in In_HKProvideToDate date,
in In_HKEmpeePaid double,
in In_HKEmperPaid double,
in In_HKRefundToEmpee double,
in In_HKRefundToEmpeeAdj double,
in In_HKPaidToEmper double,
in In_HKPaidToEmperAdj double,
in In_HKSystemGenerate double,
out Out_ErrorCode integer)
begin
  insert into HKPlaceOfRes(EmployeeSysId,
    HKTaxYear,
    HKTaxRecordType,
    HKResAddress,
    HKResNature,
    HKProvideFromDate,
    HKProvideToDate,
    HKEmpeePaid,
    HKEmperPaid,
    HKRefundToEmpee,
    HKRefundToEmpeeAdj,
    HKPaidToEmper,
    HKPaidToEmperAdj,
    HKSystemGenerate) values(
    In_EmployeeSysId,
    In_HKTaxYear,
    In_HKTaxRecordType,
    In_HKResAddress,
    In_HKResNature,
    In_HKProvideFromDate,
    In_HKProvideToDate,
    In_HKEmpeePaid,
    In_HKEmperPaid,
    In_HKRefundToEmpee,
    In_HKRefundToEmpeeAdj,
    In_HKPaidToEmper,
    In_HKPaidToEmperAdj,
    In_HKSystemGenerate);
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.InsertNewHKTaxableItems(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemType char(20),
in In_HKTaxItemCode char(20),
in In_HKTaxItemDesc char(100),
in In_HKTaxItemFromDate date,
in In_HKTaxItemToDate date,
in In_HKTaxItemAmount double,
in In_HKTaxItemAmountAdj double,
out Out_ErrorCode integer)
begin
  if not exists(select* from HKTaxableItems where EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear and HKTaxRecordType = In_HKTaxRecordType and
      HKTaxItemType = In_HKTaxItemType and HKTaxItemCode = In_HKTaxItemCode) then
    insert into HKTaxableItems(HKTaxItemSGSPGenId,
      EmployeeSysId,
      HKTaxYear,
      HKTaxRecordType,
      HKTaxItemType,
      HKTaxItemCode,
      HKTaxItemDesc,
      HKTaxItemFromDate,
      HKTaxItemToDate,
      HKTaxItemAmount,
      HKTaxItemAmountAdj) values(
      FGetNewSGSPGeneratedIndex('HKTaxableItems'),
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKTaxRecordType,
      In_HKTaxItemType,
      In_HKTaxItemCode,
      In_HKTaxItemDesc,
      In_HKTaxItemFromDate,
      In_HKTaxItemToDate,
      In_HKTaxItemAmount,
      In_HKTaxItemAmountAdj);
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure DBA.InsertNewHKTaxDetails(
in In_EmployeeSysId integer,
in In_HKTaxEmployerId char(20),
in In_HKEETaxFileNo char(30),
in In_HKPrincipalEmployer char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKTaxDetails where EmployeeSysId = In_EmployeeSysId) then
    insert into HKTaxDetails(EmployeeSysId,HKTaxEmployerId,
      HKEETaxFileNo,
      HKPrincipalEmployer) values(
      In_EmployeeSysId,
      In_HKTaxEmployerId,
      In_HKEETaxFileNo,
      In_HKPrincipalEmployer);
    commit work;
    if not exists(select* from HKTaxDetails where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKTaxEmployer(
in In_HKTaxEmployerId char(20),
in In_HKCompanyName char(100),
in In_HKERTaxFileNo char(30),
in In_HKAuthorisedPerson char(50),
in In_HKAuthorisedPosition char(50),
in In_HKCompanyAddress char(100),
in In_HKTelephoneNo char(20),
in In_HKFaxNo char(20),
out Out_ErrorCode integer)
begin
  if(In_HKTaxEmployerId is null) then
    set Out_ErrorCode=-1
  else
    if not exists(select* from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId) then
      insert into HKTaxEmployer(HKTaxEmployerId,
        HKCompanyName,
        HKERTaxFileNo,
        HKAuthorisedPerson,
        HKAuthorisedPosition,
        HKCompanyAddress,
        HKTelephoneNo,
        HKFaxNo) values(
        In_HKTaxEmployerId,
        In_HKCompanyName,
        In_HKERTaxFileNo,
        In_HKAuthorisedPerson,
        In_HKAuthorisedPosition,
        In_HKCompanyAddress,
        In_HKTelephoneNo,
        In_HKFaxNo);
      commit work;
      if not exists(select* from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure DBA.InsertNewHKTaxRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxRecordLocked integer,
in In_HKLastProcessed timestamp,
in In_HKPaidOversea integer,
in In_HKResProvided integer,
in In_HKOverseaEmper char(50),
in In_HKOverseaEmperAdd char(100),
in In_HKOverseaEmperPayAmt char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType) then
    insert into HKTaxRecord(EmployeeSysId,
      HKTaxYear,
      HKTaxRecordType,
      HKTaxRecordLocked,
      HKLastProcessed,
      HKPaidOversea,
      HKResProvided,
      HKOverseaEmper,
      HKOverseaEmperAdd,
      HKOverseaEmperPayAmt) values(
      In_EmployeeSysId,
      In_HKTaxYear,
      In_HKTaxRecordType,
      In_HKTaxRecordLocked,
      In_HKLastProcessed,
      In_HKPaidOversea,
      In_HKResProvided,
      In_HKOverseaEmper,
      In_HKOverseaEmperAdd,
      In_HKOverseaEmperPayAmt);
    commit work;
    if not exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
        HKTaxRecordType = In_HKTaxRecordType) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewHKTaxYear(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from HKTaxYear where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    insert into HKTaxYear(EmployeeSysId,
      HKTaxYear) values(
      In_EmployeeSysId,
      In_HKTaxYear);
    commit work;
    if not exists(select* from HKTaxYear where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewMPFProgression(
in In_EmployeeSysId integer,
in In_MPFProgEffDate date,
in In_MPFPaymentDate date,
in In_MPFEEStartDate date,
in In_MPFERVolStartDate date,
in In_MPFCareerId char(20),
in In_MPFMandatoryPolicyId char(20),
in In_MPFVoluntaryPolicyId char(20),
in In_MPFScheme char(20),
in In_MPFMembershipNo char(30),
in In_MPFRemarks char(100),
in In_MPFCurrent smallint,
in In_MPFTrustee char(50),
out Out_ErrorCode integer)
begin
  declare Out_MPFProgSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_MPFCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-2; // In_MPFCareerId not exist
    return
  elseif not In_MPFMandatoryPolicyId = any(select CPFPolicyId from CPFPolicy) and In_MPFMandatoryPolicyId <> '' then
    set Out_ErrorCode=-3; // In_MPFMandatoryPolicyId not exist
    return
  elseif not In_MPFVoluntaryPolicyId = any(select CPFPolicyId from CPFPolicy) and In_MPFVoluntaryPolicyId <> '' then
    set Out_ErrorCode=-4; // In_MPFVoluntaryPolicyId not exist
    return
  elseif In_MPFCareerId = 'FirstRecord' and exists(select* from MPFProgression where
    EmployeeSysID = In_EmployeeSysId and MPFCareerId = 'FirstRecord') then
    set Out_ErrorCode=-5; // In_MPFCareerId Already has First Record
    return
  else
    select max(MPFProgSysId) into Out_MPFProgSysId from MPFProgression;
    if(Out_MPFProgSysId is null) then
      set Out_MPFProgSysId=0
    end if;
    if not exists(select* from MPFProgression where
        MPFProgSysId = Out_MPFProgSysId+1) then
      insert into MPFProgression(MPFProgSysId,
        EmployeeSysId,
        MPFProgEffDate,
        MPFPaymentDate,
        MPFEEStartDate,
        MPFERVolStartDate,
        MPFCareerId,
        MPFMandatoryPolicyId,
        MPFVoluntaryPolicyId,
        MPFScheme,
        MPFMembershipNo,
        MPFRemarks,
        MPFCurrent,
        MPFTrustee) values(Out_MPFProgSysId+1,
        In_EmployeeSysId,
        In_MPFProgEffDate,
        In_MPFPaymentDate,
        In_MPFEEStartDate,
        In_MPFERVolStartDate,
        In_MPFCareerId,
        In_MPFMandatoryPolicyId,
        In_MPFVoluntaryPolicyId,
        In_MPFScheme,
        In_MPFMembershipNo,
        In_MPFRemarks,
        In_MPFCurrent,
        In_MPFTrustee);
      commit work
    end if;
    if not exists(select* from MPFProgression where
        MPFProgSysId = Out_MPFProgSysId+1) then
      set Out_ItemAssignItemSysId=null;
      set Out_ErrorCode=0
    else
      // mark current if this is the first record for that particular scheme
      if(select count(*) from MPFProgression where EmployeeSysId = In_EmployeeSysId) = 1 or
        (select count(*) from MPFProgression where EmployeeSysId = In_EmployeeSysId and MPFCurrent = 1) = 0 then
        update MPFProgression set
          MPFCurrent = 1 where
          MPFProgSysId = Out_MPFProgSysId+1
      else
        if In_MPFCurrent = 1 then
          update MPFProgression set
            MPFCurrent = 0 where
            MPFProgSysId <> Out_MPFProgSysId+1 and
            EmployeeSysId = In_EmployeeSysId
        end if
      end if; // Successful
      set Out_ErrorCode=Out_MPFProgSysId+1
    end if
  end if
end
;

create procedure dba.UpdateHKIR56BRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKIR56BRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56BRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    update HKIR56BRecord set
      HKEmpPeriodFrom = In_HKEmpPeriodFrom,
      HKEmpPeriodTo = In_HKEmpPeriodTo,
      HKIR56BRemarks = In_HKIR56BRemarks where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKIR56ERecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKCommenceDate date,
in In_HKPrevEmployer char(50),
in In_HKPrevEmployerAdd char(100),
in In_HKFixedIncome double,
in In_HKAllowance double,
in In_HKFluctuateIncome double,
in In_HKGrantedShare integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56ERecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    update HKIR56ERecord set
      HKCommenceDate = In_HKCommenceDate,
      HKPrevEmployer = In_HKPrevEmployer,
      HKPrevEmployerAdd = In_HKPrevEmployerAdd,
      HKFixedIncome = In_HKFixedIncome,
      HKAllowance = In_HKAllowance,
      HKFluctuateIncome = In_HKFluctuateIncome,
      HKGrantedShare = In_HKGrantedShare where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKIR56FRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKCessationReason char(100),
in In_HKNewEmployer char(50),
in In_HKNewEmployerAdd char(100),
in In_HKEmpFutureAdd char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56FRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    update HKIR56FRecord set
      HKEmpPeriodFrom = In_HKEmpPeriodFrom,
      HKEmpPeriodTo = In_HKEmpPeriodTo,
      HKCessationReason = In_HKCessationReason,
      HKNewEmployer = In_HKNewEmployer,
      HKNewEmployerAdd = In_HKNewEmployerAdd,
      HKEmpFutureAdd = In_HKEmpFutureAdd where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKIR56GRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKDepartureDate date,
in In_HKEmpPeriodFrom date,
in In_HKEmpPeriodTo date,
in In_HKTaxBorneEmper integer,
in In_HKHasMoneyWithold integer,
in In_HKMoneyWithold double,
in In_HKNoWitholdReason char(100),
in In_HKLeaveReason char(20),
in In_HKReasonDesc char(100),
in In_HKMayReturn integer,
in In_HKMayReturnDate date,
in In_HKHasShareOption integer,
in In_HKNoOfShare integer,
in In_HKShareGrantDate date,
in In_HKEmpFutureAdd char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56GRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    update HKIR56GRecord set
      HKDepartureDate = In_HKDepartureDate,
      HKEmpPeriodFrom = In_HKEmpPeriodFrom,
      HKEmpPeriodTo = In_HKEmpPeriodTo,
      HKTaxBorneEmper = In_HKTaxBorneEmper,
      HKHasMoneyWithold = In_HKHasMoneyWithold,
      HKMoneyWithold = In_HKMoneyWithold,
      HKNoWitholdReason = In_HKNoWitholdReason,
      HKLeaveReason = In_HKLeaveReason,
      HKReasonDesc = In_HKReasonDesc,
      HKMayReturn = In_HKMayReturn,
      HKMayReturnDate = In_HKMayReturnDate,
      HKHasShareOption = In_HKHasShareOption,
      HKNoOfShare = In_HKNoOfShare,
      HKShareGrantDate = In_HKShareGrantDate,
      HKEmpFutureAdd = In_HKEmpFutureAdd where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKIR56MRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKCompanyName char(100),
in In_HKCompanyRegNo char(20),
in In_HKServiceFromDate date,
in In_HKServiceToDate date,
in In_HKSumWithheld integer,
in In_HKSumWithheldAmt double,
in In_HKRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from HKIR56MRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear) then
    update HKIR56MRecord set
      HKCompanyName = In_HKCompanyName,
      HKCompanyRegNo = In_HKCompanyRegNo,
      HKServiceFromDate = In_HKServiceFromDate,
      HKServiceToDate = In_HKServiceToDate,
      HKSumWithheld = In_HKSumWithheld,
      HKSumWithheldAmt = In_HKSumWithheldAmt,
      HKRemarks = In_HKRemarks where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKPlaceOfRes(
in In_HKPlaceOfResSysId integer,
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecType char(20),
in In_HKResAddress char(100),
in In_HKResNature char(20),
in In_HKProvideFromDate date,
in In_HKProvideToDate date,
in In_HKEmpeePaid double,
in In_HKEmperPaid double,
in In_HKRefundToEmpee double,
in In_HKRefundToEmpeeAdj double,
in In_HKPaidToEmper double,
in In_HKPaidToEmperAdj double,
in In_HKSystemGenerate integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKPlaceOfRes where HKPlaceOfResSysId = In_HKPlaceOfResSysId) then
    update HKPlaceOfRes set
      EmployeeSysId = In_EmployeeSysId,
      HKTaxYear = In_HKTaxYear,
      HKTaxRecordType = In_HKTaxRecType,
      HKResAddress = In_HKResAddress,
      HKResNature = In_HKResNature,
      HKProvideFromDate = In_HKProvideFromDate,
      HKProvideToDate = In_HKProvideToDate,
      HKEmpeePaid = In_HKEmpeePaid,
      HKEmperPaid = In_HKEmperPaid,
      HKRefundToEmpee = In_HKRefundToEmpee,
      HKRefundToEmpeeAdj = In_HKRefundToEmpeeAdj,
      HKPaidToEmper = In_HKPaidToEmper,
      HKPaidToEmperAdj = In_HKPaidToEmperAdj,
      HKSystemGenerate = In_HKSystemGenerate where
      HKPlaceofResSysId = In_HKPlaceOfResSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKTaxableItems(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemType char(20),
in In_HKTaxItemCode char(20),
in In_HKTaxItemDesc char(100),
in In_HKTaxItemFromDate date,
in In_HKTaxItemToDate date,
in In_HKTaxItemAmount double,
in In_HKTaxItemAmountAdj double,
in In_OverwriteAdj integer,
out Out_ErrorCode integer)
begin
  if In_OverwriteAdj = 1 then
    update HKTaxableItems set
      HKTaxItemDesc = In_HKTaxItemDesc,
      HKTaxItemFromDate = In_HKTaxItemFromDate,
      HKTaxItemToDate = In_HKTaxItemToDate,
      HKTaxItemAmount = In_HKTaxItemAmount,
      HKTaxItemAmountAdj = In_HKTaxItemAmountAdj where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear and HKTaxRecordType = In_HKTaxRecordType and
      HKTaxItemType = In_HKTaxItemType and HKTaxItemCode = In_HKTaxItemCode
  else
    update HKTaxableItems set
      HKTaxItemDesc = In_HKTaxItemDesc,
      HKTaxItemAmount = In_HKTaxItemAmount where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear and HKTaxRecordType = In_HKTaxRecordType and
      HKTaxItemType = In_HKTaxItemType and HKTaxItemCode = In_HKTaxItemCode
  end if;
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.UpdateHKTaxDetails(
in In_EmployeeSysId integer,
in In_HKTaxEmployerId char(20),
in In_HKEETaxFileNo char(30),
in In_HKPrincipalEmployer char(50),
out Out_ErrorCode integer)
begin
  if exists(select* from HKTaxDetails where EmployeeSysId = In_EmployeeSysId) then
    update HKTaxDetails set
      HKTaxEmployerId = In_HKTaxEmployerId,
      HKEETaxFileNo = In_HKEETaxFileNo,
      HKPrincipalEmployer = In_HKPrincipalEmployer where
      EmployeeSysId = In_EmployeeSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKTaxEmployer(
in In_HKTaxEmployerId char(20),
in In_HKCompanyName char(100),
in In_HKERTaxFileNo char(30),
in In_HKAuthorisedPerson char(50),
in In_HKAuthorisedPosition char(50),
in In_HKCompanyAddress char(100),
in In_HKTelephoneNo char(20),
in In_HKFaxNo char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from HKTaxEmployer where HKTaxEmployerId = In_HKTaxEmployerId) then
    update HKTaxEmployer set
      HKCompanyName = In_HKCompanyName,
      HKERTaxFileNo = In_HKERTaxFileNo,
      HKAuthorisedPerson = In_HKAuthorisedPerson,
      HKAuthorisedPosition = In_HKAuthorisedPosition,
      HKCompanyAddress = In_HKCompanyAddress,
      HKTelephoneNo = In_HKTelephoneNo,
      HKFaxNo = In_HKFaxNo where
      HKTaxEmployerId = In_HKTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKTaxRecord(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxRecordLocked integer,
in In_HKLastProcessed timestamp,
in In_HKPaidOversea integer,
in In_HKResProvided integer,
in In_HKOverseaEmper char(50),
in In_HKOverseaEmperAdd char(100),
in In_HKOverseaEmperPayAmt char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from HKTaxRecord where EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType) then
    update HKTaxRecord set
      HKTaxRecordLocked = In_HKTaxRecordLocked,
      HKLastProcessed = In_HKLastProcessed,
      HKPaidOversea = In_HKPaidOversea,
      HKResProvided = In_HKResProvided,
      HKOverseaEmper = In_HKOverseaEmper,
      HKOverseaEmperAdd = In_HKOverseaEmperAdd,
      HKOverseaEmperPayAmt = In_HKOverseaEmperPayAmt where
      EmployeeSysId = In_EmployeeSysId and
      HKTaxYear = In_HKTaxYear and
      HKTaxRecordType = In_HKTaxRecordType;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMPFProgression(
in In_MPFProgSysId integer,
in In_EmployeeSysId integer,
in In_MPFProgEffDate date,
in In_MPFPaymentDate date,
in In_MPFEEStartDate date,
in In_MPFERVolStartDate date,
in In_MPFCareerId char(20),
in In_MPFMandatoryPolicyId char(20),
in In_MPFVoluntaryPolicyId char(20),
in In_MPFScheme char(20),
in In_MPFMembershipNo char(30),
in In_MPFRemarks char(100),
in In_MPFCurrent smallint,
in In_MPFTrustee char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from MPFProgression where MPFProgSysId = In_MPFProgSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_MPFCareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-3; // In_MPFCareerId not exist
    return
  elseif not In_MPFMandatoryPolicyId = any(select CPFPolicyId from CPFPolicy) and In_MPFMandatoryPolicyId <> '' then
    set Out_ErrorCode=-4; // In_MPFMandatoryPolicyId not exist
    return
  elseif not In_MPFVoluntaryPolicyId = any(select CPFPolicyId from CPFPolicy) and In_MPFVoluntaryPolicyId <> '' then
    set Out_ErrorCode=-5; // In_MPFVoluntaryPolicyId not exist
    return
  elseif In_MPFCareerId = 'FirstRecord' and exists(select* from MPFProgression where
    EmployeeSysID = In_EmployeeSysId and MPFCareerId = 'FirstRecord' and MPFProgSysId <> In_MPFProgSysId) then
    set Out_ErrorCode=-6; // In_MPFCareerId Already has First Record
    return
  else
    // if this is current, set other record for this scheme to not current
    if In_MPFCurrent = 1 then
      update MPFProgression set
        MPFCurrent = 0 where
        EmployeeSysId = In_EmployeeSysId
    end if;
    update MPFProgression set
      EmployeeSysId = In_EmployeeSysId,
      MPFProgEffDate = In_MPFProgEffDate,
      MPFPaymentDate = In_MPFPaymentDate,
      MPFEEStartDate = In_MPFEEStartDate,
      MPFERVolStartDate = In_MPFERVolStartDate,
      MPFCareerId = In_MPFCareerId,
      MPFMandatoryPolicyId = In_MPFMandatoryPolicyId,
      MPFVoluntaryPolicyId = In_MPFVoluntaryPolicyId,
      MPFScheme = In_MPFScheme,
      MPFMembershipNo = In_MPFMembershipNo,
      MPFRemarks = In_MPFRemarks,
      MPFCurrent = In_MPFCurrent,
      MPFTrustee = In_MPFTrustee where
      MPFProgSysId = In_MPFProgSysId;
    commit work
  end if;
  set Out_ErrorCode=In_MPFProgSysId // Successful
end
;

create function dba.FGetMonthLastDay(
in In_Year integer,
in In_Month integer)
returns integer
begin
  declare Tmp_Month integer;
  declare Tmp_Year integer;
  if(In_Month < 0) or(In_Month > 12) then
    return 0
  else
    set Tmp_Month=In_Month+1;
    set Tmp_Year=In_Year;
    if(Tmp_Month > 12) then
      set Tmp_Year=Tmp_Year+1;
      set Tmp_Month=1
    end if;
    return Day("Date"(Str(Tmp_Year)+'-'+Str(Tmp_Month)+'-01')-1)
  end if
end
;

create function DBA.FGetMPFUserDefCode(
in In_MPFSubmitForId char(20),
in In_MPFFormatName char(50),
in In_MPFCessationCode char(20))
returns char(20)
begin
  declare Out_MPFUserDefCode char(20);
  if exists(select* from MPFCessation where
      MPFSubmitForId = In_MPFSubmitForId and
      MPFFormatName = In_MPFFormatName and
      MPFCessationCode = In_MPFCessationCode) then
    select MPFUserDefCode into Out_MPFUserDefCode
      from MPFCessation where
      MPFSubmitForId = In_MPFSubmitForId and
      MPFFormatName = In_MPFFormatName and
      MPFCessationCode = In_MPFCessationCode;
    return(Out_MPFUserDefCode)
  else
    return ''
  end if
end
;

create function DBA.FGetMPFContriStartDate(
in In_HireDate date,
in In_PayGroupId char(20),
in In_Year integer,
in In_Period integer,
in In_MPFYear integer,
in In_MPFMonth integer)
returns date
begin
  declare Out_StartDate date;
  if(IsDateWithin(In_HireDate,
    FGetPeriodStartDate(In_PayGroupId,In_Year,In_Period),
    FGetPeriodEndDate(In_PayGroupId,In_Year,In_Period)) = 1) then
    set Out_StartDate=In_HireDate
  else
    set Out_StartDate="DATE"(STR(In_MPFYear)+'-'+STR(In_MPFMonth)+'-01')
  end if;
  return Out_StartDate
end
;

create function DBA.FGetMPFContriEndDate(
in In_CessationDate date,
in In_PayGroupId char(20),
in In_Year integer,
in In_Period integer,
in In_MPFYear integer,
in In_MPFMonth integer)
returns date
begin
  declare Out_EndDate date;
  if(IsDateWithin(In_CessationDate,
    FGetPeriodStartDate(In_PayGroupId,In_Year,In_Period),
    FGetPeriodEndDate(In_PayGroupId,In_Year,In_Period)) = 1) then
    set Out_EndDate=In_CessationDate
  else
    set Out_EndDate="DATE"(STR(In_MPFYear)+'-'+STR(In_MPFMonth)+STR(FGetMonthLastDay(In_MPFYear,In_MPFMonth)))
  end if;
  return Out_EndDate
end
;

create function dba.FGetHKTaxableItemsPeriodForSubmit(
in In_EmployeeSysId integer,
in In_HKTaxYear integer,
in In_HKTaxRecordType char(20),
in In_HKTaxItemCode char(20))
returns char(100)
begin
  declare Temp_FromDate char(10);
  declare Temp_ToDate char(10);
  declare Out_Period char(100);
  select DateFormat(HKTaxItemFromDate,'YYYYMMDD'),DateFormat(HKTaxItemToDate,'YYYYMMDD') into Temp_FromDate,Temp_ToDate from HKTaxableItems where
    EmployeeSysId = In_EmployeeSysId and HKTaxYear = In_HKTaxYear and
    HKTaxRecordType = In_HKTaxRecordType and HKTaxItemCode = In_HKTaxItemCode;
  set Out_Period=Temp_FromDate || ' - ' || Temp_ToDate;
  if(Out_Period is null) then
    return ''
  else return(Out_Period)
  end if
end
;

create function DBA.FGetCurrentMPFMembershipNo(
in In_EmployeeSysId integer,
in In_MPFScheme char(20))
returns char(30)
begin
  declare Out_MPFMembershipNo char(30);
  select MPFMembershipNo into Out_MPFMembershipNo
    from MPFProgression where
    EmployeeSysId = in_EmployeeSysId and
    MPFScheme = In_MPFScheme and
    MPFProgression.MPFCurrent = 1;
  return(Out_MPFMembershipNo)
end
;

create procedure DBA.ASQLMPFForSubmission(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_EEManMPFContri double,
out Out_EEVolMPFContri double,
out Out_ERManMPFContri double,
out Out_ERVolMPFContri double)
begin
  declare In_MPFStatus char(20);
  set Out_EEManMPFContri=0;
  set Out_EEVolMPFContri=0;
  set Out_ERManMPFContri=0;
  set Out_ERVolMPFContri=0;
  select CPFStatus into In_MPFStatus from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  /*
  Not No Submisison will update all Pay records = computed amount
  */
  if(In_MPFStatus <> 'MPFNoSubmisison' and In_MPFStatus <> 'MPFFirstPayment') then
    update PolicyRecord set
      PrevEEManContri = CurrEEManContri,
      PrevEEVolContri = CurrEEVolContri,
      PrevERManContri = CurrERManContri,
      PrevERVolContri = CurrERVolContri where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Get the Full Total For 1st Submisison
    */
    select Sum(CurrEEManContri),
      Sum(CurrEEVolContri),
      Sum(CurrERManContri),
      Sum(CurrERVolContri) into Out_EEManMPFContri,
      Out_EEVolMPFContri,
      Out_ERManMPFContri,
      Out_ERVolMPFContri from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Update to PeriodPolicySummary
    */
    update PeriodPolicySummary set
      ContriAddEECPF = Out_EEManMPFContri,
      VolAddEECPF = Out_EEVolMPFContri,
      ContriAddERCPF = Out_ERManMPFContri,
      VolAddERCPF = Out_ERVolMPFContri where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  No Submisison will update all Pay records = 0
  */
  if(In_MPFStatus = 'MPFNoSubmission') then
    update PolicyRecord set
      PrevEEManContri = 0,
      PrevEEVolContri = 0,
      PrevERManContri = 0,
      PrevERVolContri = 0 where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    update PeriodPolicySummary set
      ContriAddEECPF = 0,
      VolAddEECPF = 0,
      ContriAddERCPF = 0,
      VolAddERCPF = 0 where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  First Payment will accumulate
  NOTE: Pay Record Total MAY NOT equal to Pay Period Total
  */
  if(In_MPFStatus = 'MPFFirstPayment') then
    /*
    To sum previous month No Submission for same Sub Period and Pay Record ID
    */
    FirstPaymentLoop: for FirstPaymentFor as curs dynamic scroll cursor for
      select PayRecSubPeriod as In_PayRecSubPeriod,
        PayRecId as In_PayRecId from
        PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod do
      select Sum(CurrEEManContri),
        Sum(CurrEEVolContri),
        Sum(CurrERManContri),
        Sum(CurrERVolContri) into Out_EEManMPFContri,
        Out_EEVolMPFContri,
        Out_ERManMPFContri,
        Out_ERVolMPFContri from PolicyRecord where PolicyRecord.EmployeeSysId = In_EmployeeSysId and
        PolicyRecord.PayRecSubPeriod = In_PayRecSubPeriod and
        PolicyRecord.PayRecId = In_PayRecId and
        cast((select CPFStatus from PeriodPolicySummary where
          PeriodPolicySummary.EmployeeSysId = PolicyRecord.EmployeeSysId and
          PeriodPolicySummary.PayRecYear = PolicyRecord.PayRecYear and
          PeriodPolicySummary.PayRecPeriod = PolicyRecord.PayRecPeriod) as char(20)) in('MPFNoSubmission','MPFFirstPayment');
      update PolicyRecord set
        PrevEEManContri = Out_EEManMPFContri,
        PrevEEVolContri = Out_EEVolMPFContri,
        PrevERManContri = Out_ERManMPFContri,
        PrevERVolContri = Out_ERVolMPFContri where current of curs end for;
    /*
    Get the Full Total For 1st Submisison
    */
    select Sum(CurrEEManContri),
      Sum(CurrEEVolContri),
      Sum(CurrERManContri),
      Sum(CurrERVolContri) into Out_EEManMPFContri,
      Out_EEVolMPFContri,
      Out_ERManMPFContri,
      Out_ERVolMPFContri from PolicyRecord where PolicyRecord.EmployeeSysId = In_EmployeeSysId and
      cast((select CPFStatus from PeriodPolicySummary where
        PeriodPolicySummary.EmployeeSysId = PolicyRecord.EmployeeSysId and
        PeriodPolicySummary.PayRecYear = PolicyRecord.PayRecYear and
        PeriodPolicySummary.PayRecPeriod = PolicyRecord.PayRecPeriod) as char(20)) in('MPFNoSubmission','MPFFirstPayment');
    /*
    Update to PeriodPolicySummary
    */
    update PeriodPolicySummary set
      ContriAddEECPF = Out_EEManMPFContri,
      VolAddEECPF = Out_EEVolMPFContri,
      ContriAddERCPF = Out_ERManMPFContri,
      VolAddERCPF = Out_ERVolMPFContri where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  commit work
end
;

create procedure DBA.ASQLCalPayPeriodEOWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_EOWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  set Out_EOWage=0;
  set SubjectProperty='SubjEO';
  set WageProperty='EOWage';
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_EOWage=Out_EOWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_LveDeductAmt is null then set Out_LveDeductAmt=0
    end if;
    set Out_EOWage=Out_EOWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_BackPayAmt is null then set Out_BackPayAmt=0
    end if;
    set Out_EOWage=Out_EOWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_TotalWageAmt is null then set Out_TotalWageAmt=0
    end if;
    set Out_EOWage=Out_EOWage+Out_TotalWageAmt
  end if
end
;

create procedure dba.DeleteHKOrdinance(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId) then
    delete from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId;
    commit work;
    if exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKOrdinanceByEmployeeSysId(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId) then
    delete from HKOrdinance where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKPeriodOrdinance(
in In_OrdinSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from HKPeriodOrdinance where OrdinSGSPGenId = In_OrdinSGSPGenId) then
    delete from HKPeriodDisregard where OrdinSGSPGenId = In_OrdinSGSPGenId;
    delete from HKPeriodOrdinance where OrdinSGSPGenId = In_OrdinSGSPGenId;
    commit work;
    if exists(select* from HKPeriodOrdinance where OrdinSGSPGenId = In_OrdinSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteHKPeriodOrdinanceByEmployeeSysId(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKPeriodOrdinance where EmployeeSysId = In_EmployeeSysId) then
    delete from HKPeriodDisregard where EmployeeSysId = In_EmployeeSysId;
    delete from HKPeriodOrdinance where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from HKPeriodOrdinance where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewHKOrdinance(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_OrdinDayRate double,
in In_OrdinMonthRate double,
in In_Ordin12MthEOWage double,
in In_OrdinDisregardAmt double,
in In_OrdinDisregardDays double,
in In_PayRecFromYear integer,
in In_PayRecFromPeriod integer,
in In_PayRecToYear integer,
in In_PayRecToPeriod integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId) then
    insert into HKOrdinance(EmployeeSysId,
      PayPeriodSGSPGenId,
      OrdinDayRate,
      OrdinMonthRate,
      Ordin12MthEOWage,
      OrdinDisregardAmt,
      OrdinDisregardDays,
      PayRecFromYear,
      PayRecFromPeriod,
      PayRecToYear,
      PayRecToPeriod) values(
      In_EmployeeSysId,
      In_PayPeriodSGSPGenId,
      In_OrdinDayRate,
      In_OrdinMonthRate,
      In_Ordin12MthEOWage,
      In_OrdinDisregardAmt,
      In_OrdinDisregardDays,
      In_PayRecFromYear,
      In_PayRecFromPeriod,
      In_PayRecToYear,
      In_PayRecToPeriod);
    commit work;
    if not exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewHKPeriodDisregard(
in In_OrdinSGSPGenId char(30),
in In_DisregardItemId char(20),
in In_DisregardDay double,
in In_DisregardAmt double,
out Out_ErrorCode integer)
begin
  if not exists(select* from HKPeriodDisregard where OrdinSGSPGenId = In_OrdinSGSPGenId and DisregardItemId = In_DisregardItemId) then
    insert into HKPeriodDisregard(OrdinSGSPGenId,
      DisregardItemId,
      DisregardDay,
      DisregardAmt) values(
      In_OrdinSGSPGenId,
      In_DisregardItemId,
      In_DisregardDay,
      In_DisregardAmt);
    commit work;
    if not exists(select* from HKPeriodDisregard where OrdinSGSPGenId = In_OrdinSGSPGenId and DisregardItemId = In_DisregardItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewHKPeriodOrdinance(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_OrdinCalYear integer,
in In_OrdinCalMth integer,
in In_OrdinPeriodEOWage double,
out Out_OrdinSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if not exists(select* from HKPeriodOrdinance where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod) then
    set Out_OrdinSGSPGenId=FGetNewSGSPGeneratedIndex('HKPeriodOrdinance');
    insert into HKPeriodOrdinance(EmployeeSysId,
      OrdinSGSPGenId,
      PayRecYear,
      PayRecPeriod,
      OrdinCalYear,
      OrdinCalMth,
      OrdinPeriodEOWage) values(
      In_EmployeeSysId,
      Out_OrdinSGSPGenId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_OrdinCalYear,
      In_OrdinCalMth,
      In_OrdinPeriodEOWage);
    commit work;
    if not exists(select* from HKPeriodOrdinance where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod) then
      set Out_ErrorCode=0;
      set Out_OrdinSGSPGenId=''
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKOrdinance(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_OrdinDayRate double,
in In_OrdinMonthRate double,
in In_Ordin12MthEOWage double,
in In_OrdinDisregardAmt double,
in In_OrdinDisregardDays double,
in In_PayRecFromYear integer,
in In_PayRecFromPeriod integer,
in In_PayRecToYear integer,
in In_PayRecToPeriod integer,
out Out_ErrorCode integer)
begin
  if exists(select* from HKOrdinance where EmployeeSysId = In_EmployeeSysId and PayPeriodSGSPGenId = In_PayPeriodSGSPGenId) then
    update HKOrdinance set
      OrdinDayRate = In_OrdinDayRate,
      OrdinMonthRate = In_OrdinMonthRate,
      Ordin12MthEOWage = In_Ordin12MthEOWage,
      OrdinDisregardAmt = In_OrdinDisregardAmt,
      OrdinDisregardDays = In_OrdinDisregardDays,
      PayRecFromYear = In_PayRecFromYear,
      PayRecFromPeriod = In_PayRecFromPeriod,
      PayRecToYear = In_PayRecToYear,
      PayRecToPeriod = In_PayRecToPeriod where
      EmployeeSysId = In_EmployeeSysId and
      PayPeriodSGSPGenId = In_PayPeriodSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateHKPeriodOrdinance(
in In_OrdinSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_OrdinCalYear integer,
in In_OrdinCalMth integer,
in In_OrdinPeriodEOWage double,
out Out_ErrorCode integer)
begin
  if exists(select* from HKPeriodOrdinance where OrdinSGSPGenId = In_OrdinSGSPGenId) then
    update HKPeriodOrdinance set
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      OrdinCalYear = In_OrdinCalYear,
      OrdinCalMth = In_OrdinCalMth,
      OrdinPeriodEOWage = In_OrdinPeriodEOWage where
      OrdinSGSPGenId = In_OrdinSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

