if exists (select 1 from sys.sysprocedure where proc_name = 'FGetPeriodGPCLSalary') then
  drop FUNCTION FGetPeriodGPCLSalary;
end if;

CREATE FUNCTION "DBA"."FGetPeriodGPCLSalary"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  
  declare In_BasicRateType Char(30);
  declare In_TotWorkDays double;
  declare In_TotWorkHrperDay double;
  declare In_CurrentBasicRate double;
  declare In_NWCMVC double;
  declare In_GPCLSalary double;
  
  Select first CurrentBasicRate into In_CurrentBasicRate From DetailRecord where 
  EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod 
  and PayRecId='Normal';

  Select first CurrentMVC+CurrentNWC into In_NWCMVC From PolicyRecord where
  EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod
  and PayRecId='Normal';
  
  Select first CurrentBasicRateType into In_BasicRateType From DetailRecord 
  where EmployeeSysId = In_EmployeeSysId and
  PayRecYear = In_PayRecYear and
  PayRecPeriod = In_PayRecPeriod 
  and PayRecId='Normal';
  
//Monthly Rated
  if In_BasicRateType='MonthlyRated' then          
   Set In_GPCLSalary=In_CurrentBasicRate+In_NWCMVC 
 end if;

//Daily Rated
  if In_BasicRateType='DailyRated' then  
    Select SUM(WKCALENDAYWKPATTERN) into In_TotWorkDays  From CalendarDay Where CalendarIDCode=FGetEmployeeCalendarId(In_EmployeeSysId) and Year(CalendarDate)=In_PayRecYear and Month(CalendarDate)=In_PayRecPeriod ;   
    Set In_GPCLSalary= ((In_CurrentBasicRate+In_NWCMVC)*In_TotWorkDays) ;
  end if;

//Hourly Rated

  if In_BasicRateType='HourlyRated' then   
    Select SUM(WKCALENDAYWKPATTERN) into In_TotWorkDays  From CalendarDay Where CalendarIDCode=FGetEmployeeCalendarId(In_EmployeeSysId) and Year(CalendarDate)=In_PayRecYear and Month(CalendarDate)=In_PayRecPeriod ; 
    Select SUM(HOURSPERFULLDAY) into In_TotWorkHrperDay  From Calendar Where CalendarID=FGetEmployeeCalendarId(In_EmployeeSysId);
    
    Set In_GPCLSalary=(In_CurrentBasicRate+In_NWCMVC)*In_TotWorkDays*In_TotWorkHrperDay;

  end if;
 return In_GPCLSalary;
end;

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
in In_RemissionAmt double,
in In_OverseasPostingPeriod char(20))
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
      RemissionAmt,
      OverseasPostingPeriod) values(
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
      In_RemissionAmt,
      In_OverseasPostingPeriod);
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
in In_RemissionAmt double,
in In_OverseasPostingPeriod char(20))
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
      RemissionAmt = In_RemissionAmt,
      OverseasPostingPeriod = In_OverseasPostingPeriod where
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
CREATE PROCEDURE DBA.ASQLYEProcessIR8A(
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
    0, //RemissionAmt
    ''); //ExemptIncomeType
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

if exists(select * from sys.sysprocedure where proc_name= 'ASQLYEProcessA8A') then
  drop procedure ASQLYEProcessA8A
end if;
CREATE PROCEDURE DBA.ASQLYEProcessA8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20),
in In_OtherBenefits double,
in In_ProcessIR21 char(1))
begin
  declare In_OccupationFrom date;
  declare In_OccupationTo date;
  declare In_OccupationDays integer;
  declare In_ResidenceAddress1 char(30);
  declare In_ResidenceAddress2 char(30);
  declare In_ResidenceAddress3 char(30);
  declare In_TotalBenefitInKind double;
  declare In_Section2Total double;
  declare In_Section3Total double;
  declare In_Section4Total double;
  declare In_ResidenceValue double;
  declare In_NoOfEESharingQtr double;
  declare In_IncidentalBenefits double;
  declare In_OHQStatus char(1);
  declare DayInYear double;
  declare In_TotalSectionDE double;
  declare In_LongServiceAmount double;
  declare In_OtherBenefitsAmount double;
  /*
  To default the Occupation Dates and residence Address
  */
  if(In_Operation = 'Create') then
    set In_ResidenceAddress1='';
    set In_ResidenceAddress2='';
    set In_ResidenceAddress3='';
    select 0 into In_OccupationDays
  else
    select OccupationFrom,OccupationTo,OccupationDays into In_OccupationFrom,In_OccupationTo,In_OccupationDays from A8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    if(In_OccupationFrom = '1899-12-30' or In_OccupationTo = '1899-12-30') then
      set In_OccupationDays=0
    end if
  end if;
	
  if(In_Operation = 'Create') then
    if (In_ProcessIR21 = 'N') then
	  set In_LongServiceAmount = In_OtherBenefits;
	  set In_OtherBenefitsAmount = 0;	   
    else
      set In_LongServiceAmount = 0;
	  set In_OtherBenefitsAmount = In_OtherBenefits;
	end if; 
    call InsertNewA8A(In_PersonalSysId,
    In_YEYear,'',
    /*In_FormHeaderMsg*/
    0, /*In_ResidenceValue*/
    In_ResidenceAddress1,
    In_ResidenceAddress2,
    In_ResidenceAddress3,
    0, /*In_ERPaidRent*/
    0, /*In_EEPaidRent*/
    In_OccupationFrom,
    In_OccupationTo,
    In_OccupationDays,
    0, /*In_Section2Total*/
    0, /*In_Section3Total*/
    0, /*In_Section4Total*/
    0, /*In_IncidentalBenefits*/
    0, /*In_PassagesSelf*/
    0, /*In_PassagesWife*/
    0, /*In_PassagesChildren*/
    0, /*In_InterestLoan*/
    0, /*In_LifeInsurance*/
    0, /*In_Holidays*/
    0, /*In_Education*/
    In_LongServiceAmount, /*In_LongService*/
    0, /*In_Clubs*/
    0, /*In_Assets*/
    0, /*In_MotorVehicle*/
    0, /*In_CarBenefit*/
    In_OtherBenefitsAmount,'','','','',
    /*In_OtherBenefitsDetails*/
    /*In_OHQStatus*/
    /*In_OHQDetails*/
    /*In_Additional*/
    0, /*In_TotalBenefitInKind*/
    1); /*NoOfEESharingQtr*/
    /*
    To create A8A section 2 Items
    */
    if(In_ProcessIR21 = 'N') then     
      if In_YEYear >2013 then  
         call InsertNewA8AS2S3(In_PersonalSysID,In_YEYear,0,'',0,0,0,0,0,0,0,0,0,0,0,0);
      else
         call ASQLYECreateA8A_S2S3(In_PersonalSysID,In_YEYear);  
      end if;
    else
      call ASQLYECreateIR21A1_S2S3(In_PersonalSysID,In_YEYear);
      if In_YEYear >2013 then
	    call InsertNewIR21A1S4S5(In_PersonalSysID,In_YEYear,'','1899-12-30','1899-12-30',0,0,'',0,0,0,'','1899-12-30','1899-12-30',0,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0);
      end if;
    end if;
  else
    update A8A set
      OccupationDays = In_OccupationDays where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    For Re-Reprocess Only
    */
    if(In_Operation = 'Reprocess') then
      /*
      No Of EE Sharing Quarter
      */
      select NoOfEESharingQtr into In_NoOfEESharingQtr
        from A8A where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      if(In_NoOfEESharingQtr < 0) then
        set In_NoOfEESharingQtr=0
      end if;
      if(In_ProcessIR21 = 'N') then
        if In_YEYear <= 2013 then 
           call ASQLYEReprocessA8A_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
        end if;
      else
        call ASQLYEReprocessIR21A1_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
      end if;
      /*
      Update the OtherBenefits value if reprocess
      */
	  if(In_ProcessIR21 = 'N') then  
        update A8A set
          LongService = In_OtherBenefits where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear;
      else
        update A8A set
          OtherBenefits = In_OtherBenefits where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear;	    
	  end if;
      commit work
    end if
  end if;
  /*
  Compute Total for Section 2, 3 and 4
  */
  if(In_ProcessIR21 = 'N' and In_YEYear >2013) then
   select (TotalTaxableResidenceValue+TotalValueofUtilities) into In_Section2Total from A8AS2S3 where
     PersonalSysId = In_PersonalSysId and 
     YEYear = In_YEYear; 
  else 
    select sum(Sec2Value) into In_Section2Total from A8AS2 where Sec2Selection = 1 and
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
  end if;
  if(In_Section2Total is null) then
    set In_Section2Total=0
  end if;
  
  if(In_ProcessIR21 = 'N' and In_YEYear >2013) then
    select TotalHotelAccommodation into In_Section3Total from A8AS2S3 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
  else
    select sum(Sec3Value) into In_Section3Total from A8AS3 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
  end if;
  if(In_Section3Total is null) then
    set In_Section3Total=0
  end if;
  select Round(IncidentalBenefits+
    InterestLoan+
    LifeInsurance+
    Holidays+
    Education+
    LongService+
    Clubs+
    Assets+
    MotorVehicle+
    CarBenefit+
    OtherBenefits,2) into In_Section4Total from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section4Total is null) then
    set In_Section4Total=0
  end if;
  
  /*
    Compute Total Value of Section D & E for IR21 Appendix 1 Only In_TotalSectionDE
  */
  if(In_ProcessIR21 = 'Y' and In_YEYear >2013) then
     select Round(TotalValueofAccommodation+
	    TotalValueofUtilities+
		TotalHotelAccommodation,2) into In_TotalSectionDE from IR21A1S4S5 where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
	if(In_TotalSectionDE is null) then
       set In_TotalSectionDE=0
    end if;
  else
     set In_TotalSectionDE = 0;     
  end if;
  
  /*
  Compute A8A Total Benefits in Kind
  */
  select ResidenceValue,IncidentalBenefits,OHQStatus into In_ResidenceValue,In_IncidentalBenefits,In_OHQStatus from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  /*
  Default OHQ Status to No if NA when Incidental Benefits is not zero
  */
  if(In_IncidentalBenefits <> 0 and In_OHQStatus = '') then
    set In_OHQStatus='N'
  end if;

  /*
  Update Total
  */
  if(In_ProcessIR21 = 'N' and In_YEYear >2013) then
    set In_TotalBenefitInKind=In_Section2Total+In_Section3Total+In_Section4Total;
  else
    set In_TotalBenefitInKind=In_ResidenceValue+
      In_Section2Total+In_Section3Total+In_Section4Total+In_TotalSectionDE;
  end if;
  update A8A set
    OHQStatus = In_OHQStatus,
    TotalBenefitInKind = In_TotalBenefitInKind,
    Section2Total = In_Section2Total,
    Section3Total = In_Section3Total,
    Section4Total = In_Section4Total where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work;
end;

/* YEKeyword */
if not exists(select * from YEKeyword where YEKeyWordId = 'OverseasFullYear') then
   insert into YEKeyword(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,
                         YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
   values('OverseasFullYear','Full Year','Full Year','OverseasPeriod','','','','','','','','','','1899-12-30 00:00:00');
end if;

if not exists(select * from YEKeyword where YEKeyWordId = 'OverseasPartYear') then
   insert into YEKeyword(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,
                         YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9)
   values('OverseasPartYear','Part of the Year','Part of the Year','OverseasPeriod','','','','','','','','','','1899-12-30 00:00:00');
end if;

/* ImportFieldName */
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'PassagesSelf'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'PassagesWife'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'PassagesChildren'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'OHQStatus'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'OHQDetails'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'OtherBenefits'; 
Delete ImportFieldName Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'OtherBenefitsDetails'; 
Update ImportFieldName Set FieldNameUserDefined = 'Insurance' Where TableNamePhysical = 'iA8ASection4' And FieldNamePhysical = 'LifeInsurance';

/* SystemRptComp */
if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'IncludeROC_CheckBox') then
   insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
   values('Payslip - CS 2','IncludeROC_CheckBox','Include ROC','int',0,NULL);
end if;

/* RptCompConfig */
if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_206') then
   insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
   values('Sys_206','_Payslip - CS 2','Payslip - CS 2','IncludeROC_CheckBox');
end if;


/* RptCompItemConfig */
if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_206' and RptCompItemSysId = '1') then
  insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
  values('Sys_206','1','1');
end if;



commit work;