if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIR8A') then
   drop procedure InsertNewIR8A
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
in In_RetirementPaymentDate date,
in In_EROutsideContriTaxName char(150),
in In_EROutsideContriTaxAmt double,
in In_EROutsideContriTaxMand char(20),
in In_EROutsideContriTaxPR char(20),
in In_RemissionAmt double)
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
      RetirementPaymentDate,
      EROutsideContriTaxName,
      EROutsideContriTaxAmt,
      EROutsideContriTaxMand,
      EROutsideContriTaxPR,
      RemissionAmt) values(
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
      In_RetirementPaymentDate,
      In_EROutsideContriTaxName,
      In_EROutsideContriTaxAmt,
      In_EROutsideContriTaxMand,
      In_EROutsideContriTaxPR,
      In_RemissionAmt);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIR8A') then
   drop procedure UpdateIR8A
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
in In_RetirementPaymentDate date,
in In_EROutsideContriTaxName char(150),
in In_EROutsideContriTaxAmt double,
in In_EROutsideContriTaxMand char(20),
in In_EROutsideContriTaxPR char(20),
in In_RemissionAmt double)
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
      RetirementPaymentDate = In_RetirementPaymentDate,
      EROutsideContriTaxName = In_EROutsideContriTaxName,
      EROutsideContriTaxAmt = In_EROutsideContriTaxAmt,
      EROutsideContriTaxMand = In_EROutsideContriTaxMand,
      EROutsideContriTaxPR = In_EROutsideContriTaxPR,
      RemissionAmt = In_RemissionAmt where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessIR8A') then
   drop procedure ASQLYEProcessIR8A
end if;
CREATE PROCEDURE "DBA"."ASQLYEProcessIR8A"(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_Operation char(20),
in In_NSPay double,
in In_GrossTotal double,
in In_ContractualBonus double,
in In_NonContractualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_Insurance double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_EECPFPension double,
in In_EECPF smallint,
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
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
out Out_ProcessResult integer)
begin
  declare In_PaymentFrom date;
  declare In_PaymentTo date;
  declare StartBasis date;
  declare EndBasis date;
  declare In_AccruedFrom double;
  declare In_EROutsideContri double;
  declare In_ShareAmt double;
  declare In_TotalSectionD double;
  declare In_EEPensionDetails char(60);
  declare In_BenefitsInKind double;
  declare In_OtherAllowanceAmt double;
  set In_AccruedFrom=0;
  set In_EROutsideContri=0;
  set In_ShareAmt=0;
  set In_BenefitsInKind=0;
  set In_TotalSectionD=0;
  set In_EEPensionDetails='';
  set In_OtherAllowanceAmt=0;
  if((In_Operation = 'Recalculate' or In_Operation = 'Reprocess')) then
    select AccruedFrom,EROutsideContri,ShareAmt,EEPensionDetails,OtherAllowanceAmt into In_AccruedFrom,
      In_EROutsideContri,
      In_ShareAmt,In_EEPensionDetails,
      In_OtherAllowanceAmt from IR8A where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and IR8AType = In_IR8AType
  end if;
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'A8A') and In_IR8AType = 'CurIR8A' then
    select TotalBenefitInKind into In_BenefitsInKind from A8A where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear
  else
    set In_BenefitsInKind=0
  end if;
  if(In_GrossTotal = 0 and
    In_ContractualBonus = 0 and
    In_NonContractualBonus = 0 and
    In_DirectorFee = 0 and
    In_Commission = 0 and
    In_Pension = 0 and
    In_Transport = 0 and
    In_Entertainment = 0 and
    In_Insurance = 0 and
    In_OtherAllowance = 0 and
    In_OtherAllowanceAmt = 0 and
    In_Gratuity = 0 and
    In_EECPFPension = 0 and
    In_IR8AType = 'SupIR8A') then
    delete from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YERecordType = In_IR8AType;
    delete from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work;
    set Out_ProcessResult=0;
    return
  end if;
  if(In_IR8AType = 'CurIR8A') then
    set StartBasis="date"(str(In_YEYear)+'-01-01');
    set EndBasis="date"(str(In_YEYear)+'-12-31')
  else
    set StartBasis="date"(str(In_YEYear-1)+'-01-01');
    set EndBasis="date"(str(In_YEYear-1)+'-12-31')
  end if;
  select Commencement,Cessation into In_PaymentFrom,In_PaymentTo from YEEmployee where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_PaymentFrom < StartBasis or In_PaymentFrom is null) then
    set In_PaymentFrom=StartBasis
  end if;
  if(In_PaymentTo is null or In_PaymentTo = '1899-12-30' or In_PaymentTo > EndBasis) then
    set In_PaymentTo=EndBasis
  end if;
  if(In_EECPFPension <> 0 and(In_EEPensionDetails = '' or In_EEPensionDetails is null)) then
    set In_EEPensionDetails='Central Provident Fund';
    set In_EECPF=1
  end if;
  if(In_EECPFPension = 0) then
    set In_EEPensionDetails=''
  end if;
  set In_TotalSectionD
    =In_Commission+
    In_Pension+
    In_Transport+
    In_Entertainment+
    In_OtherAllowance+
    In_OtherAllowanceAmt+
    In_Gratuity+
    In_AccruedFrom+
    In_EROutsideContri+
    In_ShareAmt;
  if(In_Operation = 'Recalculate') then
    update IR8A set
      GrossTotal = In_GrossTotal,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      Gratuity = In_Gratuity,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      BenefitsInKind = In_BenefitsInKind,
      TotalSectionD = In_TotalSectionD where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  if(In_Operation = 'Reprocess') then
    update IR8A set
      EEPensionDetails = In_EEPensionDetails,
      NSPay = In_NSPay,
      GrossTotal = In_GrossTotal,
      ContratualBonus = In_ContractualBonus,
      NonContratualBonus = In_NonContractualBonus,
      DirectorFee = In_DirectorFee,
      Commission = In_Commission,
      Pension = In_Pension,
      Transport = In_Transport,
      Entertainment = In_Entertainment,
      OtherAllowance = In_OtherAllowance,
      Gratuity = In_Gratuity,
      EECPFPension = In_EECPFPension,
      EECPF = In_EECPF,
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
      Insurance = In_Insurance,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      BenefitsInKind = In_BenefitsInKind,
      TotalSectionD = In_TotalSectionD,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      LastChangedDateTime = now(*) where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  if(In_Operation = 'Create') then
    call InsertNewIR8A(
    In_PersonalSysID,
    In_YEYear,
    In_IR8AType,'',
    In_NSPay,
    In_GrossTotal,
    In_ContractualBonus,
    In_DirectorFee,
    In_Commission,
    In_Pension,
    In_Transport,
    In_Entertainment,
    In_OtherAllowance,
    In_Gratuity,'','',
    0,
    0,
    0,'',
    0,
    0,'',
    In_BenefitsInKind,
    0,'','',
    In_EECPFPension,
    In_EECPF,
    0,
    In_EEPensionDetails,
    0,
    In_Donation,
    In_MOSQFund,
    In_MBMF,
    In_COMC,
    In_SINDA,
    In_CDAC,
    In_ECF,
    In_MOSQ,
    In_YMF,
    In_OtherDonation,'',
    In_Insurance,
    In_PaymentFrom,
    In_PaymentTo,
    0,
    In_NonContractualBonus,
    In_TotalSectionD,'',
    0,
    In_LumpSumGratuity,
    In_LumpSumCompensation,
    In_LumpSumNoticePay,
    In_LumpSumExGratia,
    In_LumpSumOthers,'','',
    0, //CPFBorneByER 
    0, //TaxBorneByER
    0,'1899-12-30','IncomeTypeNA', //FixedAmtBorneByEE
    //CompensationApprovedDate
    //ExemptIncomeType
    0, //ExemptIncomeAmt  
    0, //In_OtherAllowanceAmt
    0, ////In_TotalStockGainsBef
    '1899-12-30', //RetirementPaymentDate 
    '', //EROutsideContriTaxName
    0, //EROutsideContriTaxAmt
    '', //EROutsideContriTaxMand
    '', //EROutsideContriTaxPR
    0 ); //RemissionAmt
    update IR8A set
      LengthOfService = 0 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  set Out_ProcessResult=In_TotalSectionD
end
;

commit work;

if exists(select modulescreenid from ModuleScreenGroup where modulescreenid='CorePDPARpt') then
    Update ModuleScreenGroup set HIDEONLYWAGE=1 where modulescreenid='CorePDPARpt';
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'DNB (G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'DNB (G3)', 'RSingBankFormatDNBG3.dll', 'InvokeSalaryFormatter', 0)
end if;

--IR21
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsLessThan1Mth1') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsLessThan1Mth1','','Absconded / Left without notice','ReasonsLessThan1Mth','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsLessThan1Mth2') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsLessThan1Mth2','','Immediate Resignation / Short Notice','ReasonsLessThan1Mth','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsLessThan1Mth3') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsLessThan1Mth3','','Resigned whilst overseas / on Home Leave','ReasonsLessThan1Mth','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsLessThan1MthO') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsLessThan1MthO','','Others','ReasonsLessThan1Mth','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsNotWithhold1') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsNotWithhold1','','Resigned after payday','ReasonsNotWithhold','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsNotWithhold2') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsNotWithhold2','','Salary already paid via bank','ReasonsNotWithhold','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsNotWithhold3') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsNotWithhold3','','Did not return from leave','ReasonsNotWithhold','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsNotWithhold4') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsNotWithhold4','','Employee owes company monies','ReasonsNotWithhold','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from YEKeyWord where YEKeyWordId = 'ReasonsNotWithholdO') then
  insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
  values ('ReasonsNotWithholdO','','Others','ReasonsNotWithhold','','','',0,0,0.0,0.0,0.0,0.0,'1899-12-30 00:00:00.000');
end if;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIR21Details') then
   drop procedure InsertNewIR21Details
end if;
create procedure DBA.InsertNewIR21Details(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21Type integer,
in In_SupersedeIR21Date date,
in In_DateOfArrival date,
in In_DateOfDeparture date,
in In_DateResignationTendered date,
in In_ReasonsLessThan1Mth char(100),
in In_AmtOfMoniesWithheld double,
in In_DateLastSalaryPaid date,
in In_AmtOfLastSalaryPaid double,
in In_PeriodLastSalaryPaid char(50),
in In_ReasonsNotWithholding char(100),
in In_NameOfNewEmployer char(50),
in In_TelNoOfNewEmployer char(30),
in In_MailingAddEffDate date,
in In_DateOfMarriage date,
in In_UnexercisedGainsBef integer,
in In_UnexercisedGainsAft integer,
in In_SpouseNationality char(50),
in In_MoniesStatus integer,
in In_ReasonsLessThan1MthOpt char(100) default '',
in In_ReasonsNotWithholdingOpt char(100) default '',
in In_SpouseMoreThan4000 smallint default NULL,
in In_SpouseEmployer char(100) default '')
begin
  if not exists(select * from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear) then
    insert into IR21Details(PersonalSysID,
      YEYear,
      IR21Type,
      SupersedeIR21Date,
      DateOfArrival,
      DateOfDeparture,
      DateResignationTendered,
      ReasonsLessThan1Mth,
      AmtOfMoniesWithheld,
      DateLastSalaryPaid,
      AmtOfLastSalaryPaid,
      PeriodLastSalaryPaid,
      ReasonsNotWithholding,
      NameOfNewEmployer,
      TelNoOfNewEmployer,
      MailingAddEffDate,
      DateOfMarriage,
      UnexercisedGainsBef,
      UnexercisedGainsAft,
      SpouseNationality,
      MoniesStatus,
      ReasonsLessThan1MthOpt,
      ReasonsNotWithholdingOpt,
	  SpouseMoreThan4000,
	  SpouseEmployer) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR21Type,
      In_SupersedeIR21Date,
      In_DateOfArrival,
      In_DateOfDeparture,
      In_DateResignationTendered,
      In_ReasonsLessThan1Mth,
      In_AmtOfMoniesWithheld,
      In_DateLastSalaryPaid,
      In_AmtOfLastSalaryPaid,
      In_PeriodLastSalaryPaid,
      In_ReasonsNotWithholding,
      In_NameOfNewEmployer,
      In_TelNoOfNewEmployer,
      In_MailingAddEffDate,
      In_DateOfMarriage,
      In_UnexercisedGainsBef,
      In_UnexercisedGainsAft,
      In_SpouseNationality,
      In_MoniesStatus,
      In_ReasonsLessThan1MthOpt,
      In_ReasonsNotWithholdingOpt,
	  In_SpouseMoreThan4000,
	  In_SpouseEmployer);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIR21Details') then
   drop procedure UpdateIR21Details
end if;
create procedure DBA.UpdateIR21Details(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR21Type integer,
in In_SupersedeIR21Date date,
in In_DateOfArrival date,
in In_DateOfDeparture date,
in In_DateResignationTendered date,
in In_ReasonsLessThan1Mth char(100),
in In_AmtOfMoniesWithheld double,
in In_DateLastSalaryPaid date,
in In_AmtOfLastSalaryPaid double,
in In_PeriodLastSalaryPaid char(50),
in In_ReasonsNotWithholding char(100),
in In_NameOfNewEmployer char(50),
in In_TelNoOfNewEmployer char(30),
in In_MailingAddEffDate date,
in In_DateOfMarriage date,
in In_UnexercisedGainsBef integer,
in In_UnexercisedGainsAft integer,
in In_SpouseNationality char(50),
in In_MoniesStatus integer,
in In_ReasonsLessThan1MthOpt char(100),
in In_ReasonsNotWithholdingOpt char(100),
in In_SpouseMoreThan4000 smallint,
in In_SpouseEmployer char(100)
)
begin
  if exists(select* from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear) then
    update IR21Details set
      IR21Type = In_IR21Type,
      SupersedeIR21Date = In_SupersedeIR21Date,
      DateOfArrival = In_DateOfArrival,
      DateOfDeparture = In_DateOfDeparture,
      DateResignationTendered = In_DateResignationTendered,
      ReasonsLessThan1Mth = In_ReasonsLessThan1Mth,
      AmtOfMoniesWithheld = In_AmtOfMoniesWithheld,
      DateLastSalaryPaid = In_DateLastSalaryPaid,
      AmtOfLastSalaryPaid = In_AmtOfLastSalaryPaid,
      PeriodLastSalaryPaid = In_PeriodLastSalaryPaid,
      ReasonsNotWithholding = In_ReasonsNotWithholding,
      NameOfNewEmployer = In_NameOfNewEmployer,
      TelNoOfNewEmployer = In_TelNoOfNewEmployer,
      MailingAddEffDate = In_MailingAddEffDate,
      DateOfMarriage = In_DateOfMarriage,
      UnexercisedGainsBef = In_UnexercisedGainsBef,
      UnexercisedGainsAft = In_UnexercisedGainsAft,
      SpouseNationality = In_SpouseNationality,
      MoniesStatus = In_MoniesStatus,
      ReasonsLessThan1MthOpt = In_ReasonsLessThan1MthOpt,
      ReasonsNotWithholdingOpt = In_ReasonsNotWithholdingOpt,
      SpouseMoreThan4000 = In_SpouseMoreThan4000,
      SpouseEmployer = In_SpouseEmployer	  where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear;
    commit work
  end if
end
;

Delete from "DBA"."KEYWORD" where keywordcategory in ('AnalysisReport','CPFSubmission','Reports','Submissions');

if not exists(select keywordid from keyword where keywordid='Payslip') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Payslip','InvokeRPayslipFrontend','Payslip','Reports','','','','RPayslipFrontend.dll',1,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CPFContriRpt') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CPFContriRpt','InvokeCPFContributionReport','CPF Contribution Report','Reports','','','','RPayEngine.dll',2,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='BonusProcessReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('BonusProcessReport','InvokeBonusProcessingReport','Bonus Processing Report','Reports','','','','RPayEngine.dll',3,'',0,'');
end if ;


if not exists(select keywordid from keyword where keywordid='FWL/SDFReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('FWL/SDFReport','InvokeFWLSDFReport','FWL/SDF Report','Reports','','','','RPayEngine.dll',4,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='PayrollSummaryReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayrollSummaryReport','InvokePayrollSummary','Payroll Summary Report','Reports','','','','RPayrollSummary.dll',5,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='StatisticsReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('StatisticsReport','InvokeAnlysStatistic','Statistics Report','Reports','','','','RPayEngine.dll',6,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='Bank/CashListing') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Bank/CashListing','InvokeBankCashListing','Bank/Cash Listing Report','Reports','','','','RPayEngine.dll',7,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='PayrollVarianceRpt') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayrollVarianceRpt','InvokeAnlysVariance','Payroll Variance Report','Reports','','','','RPayEngine.dll',8,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='MAWReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('MAWReport','InvokeMawReport','MAW Report','Reports','','','','RPayEngine.dll',9,'',0,'');
end if ;


if not exists(select keywordid from keyword where keywordid='PayAnalysisReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayAnalysisReport','InvokePayrollAnalysis','Payroll Analysis Report','Reports','','','','RPayrollAnalysis.dll',10,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='AdvPayProReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('AdvPayProReport','InvokeAdvanceProcessingReport','Advance Pay Processing Report','Reports','','','','RPayEngine.dll',11,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='LoanReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('LoanReport','InvokeLoanReportGeneric','Loan Report','Reports','','','','RLoanGeneric.dll',12,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='MedisaveReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('MedisaveReport','InvokeMedisaveReport','Medisave Report','Reports','','','','RPayEngine.dll',13,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CashPayOutReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CashPayOutReport','InvokeCashPayoutListing','Cash Pay Out Listing Report','Reports','','','','RPayEngine.dll',14,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='BankDiskSubmission') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('BankDiskSubmission','InvokeRBankSubmissionFrontend','BankDisk Submission','Submissions','','','','RBankSubmission.dll',1,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CPFeSubmit') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CPFeSubmit','InvokeCPFPALSubmission','CPF e-Submit@web','Submissions','','','','RCPFReport.dll',2,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CPFLine') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CPFLine','InvokeCPFLineReport','CPF Line','Submissions','','','','RCPFReport.dll',3,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CPFMasnet') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CPFMasnet','InvokeCPFMasnetSubmission','CPF Masnet','Submissions','','','','RCPFReport.dll',4,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CPFPaymentAdvice') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CPFPaymentAdvice','InvokeCPFPaymentReport','CPF Payment Advice','Submissions','','','','RCPFReport.dll',5,'',0,'');
end if ;





/* Remove unused the code table for Interface -> Income Tax Process */
delete from InterfaceCodeMapping where InterfaceProcessID = 'Income Tax Process' and CodeTableID in ('Sec2ItemsNo','Sec3No');
delete from InterfaceCodeTable where InterfaceProcessId = 'Income Tax Process' and CodeTableID in ('Sec2ItemsNo','Sec3No');
delete from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId in ('Sec2ItemsNo','Sec3No') and RegProperty1 = 'Income Tax Process';

update EmployeeRpt set EmployeeRptHasFilter = 1 where EmpInfoRptId = 'LeaveApplication';
if not exists (select 1 from CoreKeyWord where CoreKeyWordId = 'LeaveAppFromDate') then
  insert into CoreKeyWord (CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
  values ('LeaveAppFromDate','ExpLeaveApp','From Date','From Date','LeaveApplication.LveAppFromDate');
end if;
if not exists (select 1 from CoreKeyWord where CoreKeyWordId = 'LeaveAppToDate') then
  insert into CoreKeyWord (CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
  values ('LeaveAppToDate','ExpLeaveApp','To Date','To Date','LeaveApplication.LveAppToDate');
end if;

commit work;
