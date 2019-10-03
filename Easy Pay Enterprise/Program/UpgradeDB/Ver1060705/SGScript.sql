READ UpgradeDB\Ver1060705\IRASNationalityCode.sql;

if exists(select * from sys.sysprocedure where proc_name = 'FGetIRASEmployeeBank') then
   drop procedure FGetIRASEmployeeBank;
end if;

create function DBA.FGetIRASEmployeeBank(
in In_EmployeeSysId integer)
returns char(1)
begin
  declare Out_IRASEmployeeBank char(1);
  declare Out_BankId char(20);
  select first BankId into Out_BankId from PaymentBankInfo where EmployeeSysId = In_EmployeeSysId order by PaymentValue desc;
  case Out_BankId when '7171' then
    set Out_IRASEmployeeBank='1' when '7348' then
    set Out_IRASEmployeeBank='2' when '7375' then
    set Out_IRASEmployeeBank='2' when '7339' then
    set Out_IRASEmployeeBank='3' when '7986' then 
    set Out_IRASEmployeeBank='5' when '7214' then
    set Out_IRASEmployeeBank='6' when '7232' then 
    set Out_IRASEmployeeBank='7' when '7302' then
    set Out_IRASEmployeeBank='8' when '7144' then
    set Out_IRASEmployeeBank='9' when '7199' then
    set Out_IRASEmployeeBank='A' when '7931' then
    set Out_IRASEmployeeBank='B' when '7047' then
    set Out_IRASEmployeeBank='C' when '7065' then
    set Out_IRASEmployeeBank='D' when '7083' then
    set Out_IRASEmployeeBank='E' when '7092' then
    set Out_IRASEmployeeBank='F' when '7108' then
    set Out_IRASEmployeeBank='G' when '7126' then
    set Out_IRASEmployeeBank='H' when '7418' then
    set Out_IRASEmployeeBank='I' when '7135' then
    set Out_IRASEmployeeBank='J' when '7287' then
    set Out_IRASEmployeeBank='K' when '9186' then
    set Out_IRASEmployeeBank='L' when '7241' then
    set Out_IRASEmployeeBank='M' when '7250' then
    set Out_IRASEmployeeBank='N' when 'ICBKSGSG' then
    set Out_IRASEmployeeBank='O' when '7153' then
    set Out_IRASEmployeeBank='P' when '7621' then
    set Out_IRASEmployeeBank='Q' when '7056' then
    set Out_IRASEmployeeBank='R' when '7366' then
    set Out_IRASEmployeeBank='S' when '7791' then
    set Out_IRASEmployeeBank='T' when '7472' then
    set Out_IRASEmployeeBank='U' when '7357' then
    set Out_IRASEmployeeBank='V'
  else
    set Out_IRASEmployeeBank='4'
  end case
  ;
  return(Out_IRASEmployeeBank)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewA8AS2') then
   drop procedure InsertNewA8AS2;
end if;

create procedure dba.InsertNewA8AS2(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec2ItemsNo char(3),
in In_Sec2Items char(100),
in In_Sec2Selection integer,
in In_Sec2Unit double,
in In_Sec2Rate double,
in In_Sec2Days double,
in In_Sec2Value double,
in In_Sec2YEKeywordId char(20))
begin
  if not exists(select* from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo) then
    insert into A8AS2(PersonalSysId,
      YEYear,
      Sec2ItemsNo,
      Sec2Items,
      Sec2Selection,
      Sec2Unit,
      Sec2Rate,
      Sec2Days,
      Sec2Value,
      Sec2YEKeywordId) values(
      In_PersonalSysId,
      In_YEYear,
      In_Sec2ItemsNo,
      In_Sec2Items,
      In_Sec2Selection,
      In_Sec2Unit,
      In_Sec2Rate,
      In_Sec2Days,
      In_Sec2Value,
      In_Sec2YEKeywordId);
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateA8AS2') then
   drop procedure UpdateA8AS2;
end if;

create procedure dba.UpdateA8AS2(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec2ItemsNo char(3),
in In_Sec2Items char(100),
in In_Sec2Selection integer,
in In_Sec2Unit double,
in In_Sec2Rate double,
in In_Sec2Days double,
in In_Sec2Value double,
in In_Sec2YEKeywordId char(20))
begin
  if exists(select* from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo) then
    update A8AS2 set
      A8AS2.Sec2Items = In_Sec2Items,
      A8AS2.Sec2Selection = In_Sec2Selection,
      A8AS2.Sec2Unit = In_Sec2Unit,
      A8AS2.Sec2Rate = In_Sec2Rate,
      A8AS2.Sec2Days = In_Sec2Days,
      A8AS2.Sec2Value = In_Sec2Value,
      A8AS2.Sec2YEKeywordId = In_Sec2YEKeywordId where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo;
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCPFContriWage') then
   drop procedure ASQLCalPayRecCPFContriWage;
end if;

create PROCEDURE DBA.ASQLCalPayRecCPFContriWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
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
      PayRecPeriod = In_PayRecPeriod; 
    if Out_OTAmount is null then set Out_OTAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTAmount;

  // Compute OT Back Pay    
    select Sum(CalOTBackPay) into Out_OTBackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_OTBackPay is null then set Out_OTBackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_OTBackPay;

  // Compute Shift Amount    
    select Sum(CalShiftAmount) into Out_ShiftAmount from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_ShiftAmount is null then set Out_ShiftAmount=0
    end if;
    set CPFContriWage=CPFContriWage+Out_ShiftAmount;

  // Compute Leave Deduction Amount  
    select Sum(CalLveDeductAmt) into Out_LeaveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_LeaveDeductAmt is null then set Out_LeaveDeductAmt=0
    end if;
    set CPFContriWage=CPFContriWage+Out_LeaveDeductAmt;

  // Compute Back Pay  
    select Sum(CalBackPay) into Out_BackPay from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_BackPay is null then set Out_BackPay=0
    end if;
    set CPFContriWage=CPFContriWage+Out_BackPay;

  // Compute Total Wage  
    select Sum(CalTotalWage) into Out_TotalWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod; 
    if Out_TotalWage is null then set Out_TotalWage=0
    end if;
    set CPFContriWage=CPFContriWage+Out_TotalWage;

  // Compute CPF Allowance  
     select Sum(AllowanceAmount) into Out_CPFAllowance from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Allowance' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1);
     
    if Out_CPFAllowance is null then set Out_CPFAllowance=0
    end if;
    set CPFContriWage=CPFContriWage+Out_CPFAllowance;

  // Compute CPF Deduction  
    select Sum(AllowanceAmount) into Out_CPFDeduction from AllowanceRecord,Formula where
      AllowanceFormulaid = Formulaid and
      FormulaSubCategory = 'Deduction' and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      (IsFormulaIdHasProperty(AllowanceFormulaid,'SubjOrdinary') = 1 or
      IsFormulaIdHasProperty(AllowanceFormulaid,'SubjAdditional') = 1);
  
    if Out_CPFDeduction is null then set Out_CPFDeduction=0
    end if;
    set CPFContriWage=CPFContriWage+Out_CPFDeduction;


  // Compute CPF Contribution Wage  
  set Out_CPFContriWage=Round(CPFContriWage,FGetDBPayDecimal(*));
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIR8A') then
   drop procedure InsertNewIR8A;
end if;

create procedure dba.InsertNewIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_FormHeaderMsg char(100),
in In_NSPay double,
in In_GrossTotal double,
in In_ContratualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_GratuityDetails char(150),
in In_RetirementDetails char(60),
in In_AccruedFrom double,
in In_AccruedTo double,
in In_EROutsideContri double,
in In_EROutsideContriDetails char(150),
in In_ERExcessContri double,
in In_ShareAmt double,
in In_ShareDetails char(150),
in In_BenefitsInKind double,
in In_IncomeBorne smallint,
in In_IncomeBorneStatus char(20),
in In_IncomeBorneDetails char(150),
in In_EECPFPension double,
in In_EECPF smallint,
in In_EEPension smallint,
in In_EEPensionDetails char(60),
in In_EEVoluntaryCPF double,
in In_Donation double,
in In_MOSQFund double,
in In_MBMF smallint,
in In_COMC smallint,
in In_SINDA smallint,
in In_CDAC smallint,
in In_ECF smallint,
in In_MOSQ smallint,
in In_YMF smallint,
in In_OtherDonation smallint,
in In_Remarks char(200),
in In_Insurance double,
in In_PaymentFrom date,
in In_PaymentTo date,
in In_EEOverseasCPF double,
in In_NonContratualBonus double,
in In_TotalSectionD double,
in In_FormFooterMsg char(100),
in In_IR8ABenefitsInKind double,
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
in In_LumpSumBasis char(150),
in In_BenefitsInKindDesc char(150),
in In_CPFBorneByER double,
in In_TaxBorneByER double,
in In_FixedAmtBorneByEE double,
in In_CompensationApprovedDate date,
in In_ExemptIncomeType char(20),
in In_ExemptIncomeAmt double,
in In_OtherAllowanceAmt double,
in In_TotalStockGainsBef double,
in In_RetirementPaymentDate date)
begin
  if not exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType) then
    insert into IR8A(PersonalSysID,
      YEYear,
      IR8AType,
      FormHeaderMsg,
      NSPay,
      GrossTotal,
      ContratualBonus,
      DirectorFee,
      Commission,
      Pension,
      Transport,
      Entertainment,
      OtherAllowance,
      Gratuity,
      GratuityDetails,
      RetirementDetails,     
      AccruedFrom,
      AccruedTo,
      EROutsideContri,
      EROutsideContriDetails,
      ERExcessContri,
      ShareAmt,
      ShareDetails,
      BenefitsInKind,
      IncomeBorne,
      IncomeBorneStatus,
      IncomeBorneDetails,
      EECPFPension,
      EECPF,
      EEPension,
      EEPensionDetails,
      EEVoluntaryCPF,
      Donation,
      MOSQFund,
      MBMF,
      COMC,
      SINDA,
      CDAC,
      ECF,
      MOSQ,
      YMF,
      OtherDonation,
      Remarks,
      Insurance,
      PaymentFrom,
      PaymentTo,
      EEOverseasCPF,
      NonContratualBonus,
      TotalSectionD,FormFooterMsg,
      IR8ABenefitsInKind,
      LumpSumGratuity,
      LumpSumCompensation,
      LumpSumNoticePay,
      LumpSumExGratia,
      LumpSumOthers,
      LumpSumBasis,
      BenefitsInKindDesc,
      CPFBorneByER,
      TaxBorneByER,
      FixedAmtBorneByEE,
      LastChangedDateTime,
      CompensationApprovedDate,
      ExemptIncomeType,
      ExemptIncomeAmt,
      OtherAllowanceAmt,
      TotalStockGainsBef,
      RetirementPaymentDate) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR8AType,
      In_FormHeaderMsg,
      In_NSPay,
      In_GrossTotal,
      In_ContratualBonus,
      In_DirectorFee,
      In_Commission,
      In_Pension,
      In_Transport,
      In_Entertainment,
      In_OtherAllowance,
      In_Gratuity,
      In_GratuityDetails,
      In_RetirementDetails,     
      In_AccruedFrom,
      In_AccruedTo,
      In_EROutsideContri,
      In_EROutsideContriDetails,
      In_ERExcessContri,
      In_ShareAmt,
      In_ShareDetails,
      In_BenefitsInKind,
      In_IncomeBorne,
      In_IncomeBorneStatus,
      In_IncomeBorneDetails,
      In_EECPFPension,
      In_EECPF,
      In_EEPension,
      In_EEPensionDetails,
      In_EEVoluntaryCPF,
      In_Donation,
      In_MOSQFund,
      In_MBMF,
      In_COMC,
      In_SINDA,
      In_CDAC,
      In_ECF,
      In_MOSQ,
      In_YMF,
      In_OtherDonation,
      In_Remarks,
      In_Insurance,
      In_PaymentFrom,
      In_PaymentTo,
      In_EEOverseasCPF,
      In_NonContratualBonus,
      In_TotalSectionD,In_FormFooterMsg,In_IR8ABenefitsInKind,
      In_LumpSumGratuity,
      In_LumpSumCompensation,
      In_LumpSumNoticePay,
      In_LumpSumExGratia,
      In_LumpSumOthers,
      In_LumpSumBasis,
      In_BenefitsInKindDesc,
      In_CPFBorneByER,
      In_TaxBorneByER,
      In_FixedAmtBorneByEE,
      now(*),
      In_CompensationApprovedDate,
      In_ExemptIncomeType,
      In_ExemptIncomeAmt,
      In_OtherAllowanceAmt,
      In_TotalStockGainsBef,
      In_RetirementPaymentDate);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIR8A') then
   drop procedure UpdateIR8A;
end if;

create procedure dba.UpdateIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_FormHeaderMsg char(100),
in In_NSPay double,
in In_GrossTotal double,
in In_ContratualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_GratuityDetails char(150),
in In_RetirementDetails char(60),
in In_AccruedFrom double,
in In_AccruedTo double,
in In_EROutsideContri double,
in In_EROutsideContriDetails char(150),
in In_ERExcessContri double,
in In_ShareAmt double,
in In_ShareDetails char(150),
in In_BenefitsInKind double,
in In_IncomeBorne smallint,
in In_IncomeBorneStatus char(20),
in In_IncomeBorneDetails char(150),
in In_EECPFPension double,
in In_EECPF smallint,
in In_EEPension smallint,
in In_EEPensionDetails char(60),
in In_EEVoluntaryCPF double,
in In_Donation double,
in In_MOSQFund double,
in In_MBMF smallint,
in In_COMC smallint,
in In_SINDA smallint,
in In_CDAC smallint,
in In_ECF smallint,
in In_MOSQ smallint,
in In_YMF smallint,
in In_OtherDonation smallint,
in In_Remarks char(200),
in In_Insurance double,
in In_PaymentFrom date,
in In_PaymentTo date,
in In_EEOverseasCPF double,
in In_NonContratualBonus double,
in In_TotalSectionD double,
in In_FormFooterMsg char(100),
in In_IR8ABenefitsInKind double,
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
in In_LumpSumBasis char(150),
in In_BenefitsInKindDesc char(150),
in In_CPFBorneByER double,
in In_TaxBorneByER double,
in In_FixedAmtBorneByEE double,
in In_CompensationApprovedDate date,
in In_ExemptIncomeType char(20),
in In_ExemptIncomeAmt double,
in In_OtherAllowanceAmt double,
in In_TotalStockGainsBef double,
in In_RetirementPaymentDate date)
begin
  if exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType) then
    update IR8A set
      FormHeaderMsg = In_FormHeaderMsg,
      NSPay = In_NSPay,
      GrossTotal = In_GrossTotal,
      ContratualBonus = In_ContratualBonus,
      DirectorFee = In_DirectorFee,
      Commission = In_Commission,
      Pension = In_Pension,
      Transport = In_Transport,
      Entertainment = In_Entertainment,
      OtherAllowance = In_OtherAllowance,
      Gratuity = In_Gratuity,
      GratuityDetails = In_GratuityDetails,
      RetirementDetails = In_RetirementDetails,    
      AccruedFrom = In_AccruedFrom,
      AccruedTo = In_AccruedTo,
      EROutsideContri = In_EROutsideContri,
      EROutsideContriDetails = In_EROutsideContriDetails,
      ERExcessContri = In_ERExcessContri,
      ShareAmt = In_ShareAmt,
      ShareDetails = In_ShareDetails,
      BenefitsInKind = In_BenefitsInKind,
      IncomeBorne = In_IncomeBorne,
      IncomeBorneStatus = In_IncomeBorneStatus,
      IncomeBorneDetails = In_IncomeBorneDetails,
      EECPFPension = In_EECPFPension,
      EECPF = In_EECPF,
      EEPension = In_EEPension,
      EEPensionDetails = In_EEPensionDetails,
      EEVoluntaryCPF = In_EEVoluntaryCPF,
      Donation = In_Donation,
      MOSQFund = In_MOSQFund,
      MBMF = In_MBMF,
      COMC = In_COMC,
      SINDA = In_SINDA,
      CDAC = In_CDAC,
      ECF = In_ECF,
      MOSQ = In_MOSQ,
      YMF = In_YMF,
      OtherDonation = In_OtherDonation,
      Remarks = In_Remarks,
      Insurance = In_Insurance,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      EEOverseasCPF = In_EEOverseasCPF,
      NonContratualBonus = In_NonContratualBonus,
      TotalSectionD = In_TotalSectionD,
      FormFooterMsg = In_FormFooterMsg,
      IR8ABenefitsInKind = In_IR8ABenefitsInKind,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      LumpSumBasis = In_LumpSumBasis,
      BenefitsInKindDesc = In_BenefitsInKindDesc,
      CPFBorneByER = In_CPFBorneByER,
      TaxBorneByER = In_TaxBorneByER,
      FixedAmtBorneByEE = In_FixedAmtBorneByEE,
      LastChangedDateTime = now(*),
      CompensationApprovedDate = In_CompensationApprovedDate,
      ExemptIncomeType = In_ExemptIncomeType,
      ExemptIncomeAmt = In_ExemptIncomeAmt,
      OtherAllowanceAmt = In_OtherAllowanceAmt,
      TotalStockGainsBef = In_TotalStockGainsBef,
      RetirementPaymentDate=In_RetirementPaymentDate where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType;
    commit work
  end if
end
;

// A8A Section 2 & 3
Update YeKeyword Set YEKeyWordDefaultName = 'Swimming Pool (exclude swimming pool in condominiums)', YEKeyWordUserDefinedName = 'Swimming Pool (exclude swimming pool in condominiums)'
Where YeKeywordId = 'SwimmingPool';

Update YeKeyword Set YEKeyWordDefaultName = 'Add: 2% x Basic Salary for period provided', YEKeyWordUserDefinedName = 'Add: 2% x Basic Salary for period provided'
Where YeKeywordId = 'plus2%';

Update YeKeyword Set YEKeyWordDefaultName = 'Others(See paragraph 15 of the Explanatory Notes)', YEKeyWordUserDefinedName = 'Others(See paragraph 15 of the Explanatory Notes)'
Where YeKeywordId = 'OthersFurniture';

// IR21 Section 3
Update YEKeyword set YEKeyWordDefaultName = 'Self', YEKeyWordUserDefinedName = 'Self', YEProperty1='A' Where YEKeywordId = 'IR21Self'; 
Update YEKeyword set YEKeyWordDefaultName = 'Child- 8 to 20 yrs', YEKeyWordUserDefinedName = 'Child- 8 to 20 yrs', YEProperty1='C' Where YEKeywordId = 'IR21Children8-20'; 
Update YEKeyword set YEKeyWordDefaultName = 'Child- 3 to 7 yrs', YEKeyWordUserDefinedName = 'Child- 3 to 7 yrs' , YEProperty1='D' Where YEKeywordId = 'IR21Children3-7'; 
Update YEKeyword set YEKeyWordDefaultName = 'Child- < 3 yrs old', YEKeyWordUserDefinedName = 'Child- < 3 yrs old', YEProperty1='E' Where YEKeywordId = 'IR21Children<3'; 
Update YEKeyword set YEProperty1='F' Where YEKeywordId = 'IR21plus2%'; 
if not exists(select * from YEKeyword where YEKeywordId = 'IR21Child20') then
  insert into YEKeyword(YEKeywordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,
              YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values('IR21Child20','Wife / Child >20 yrs','Wife / Child >20 yrs','IR21A1S3','','B','','0','','3000','0','0','0','1899-12-30 00:00:00');
end if;

commit work;