if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessIR8A') then
   drop procedure ASQLYEProcessIR8A
end if
;

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
    0); //In_TotalStockGainsBef
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
