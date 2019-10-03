if exists(select * from sys.sysprocedure where proc_name = 'InsertNewYEEmployee') then
   drop procedure InsertNewYEEmployee;
end if;

create procedure dba.InsertNewYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(30),
in In_EEAddress1 char(30),
in In_EEAddress2 char(30),
in In_EEAddress3 char(30),
in In_EEAddress4 char(30),
in In_PostalCode char(6),
in In_EEAddressType char(20),
in In_EEAddressCountry char(20),
in In_EEName1 char(35),
in In_EEName2 char(35),
in In_EEName3 char(10),
in In_DOB date,
in In_Commencement date,
in In_Cessation date,
in In_IRASSection45 char(1),
in In_IR8SIndicator char(1),
in In_A8AIndicator char(1),
in In_Flag100K char(1),
in In_FlagPercentOrdWage char(1),
in In_FlagOverseasCPF char(1),
in In_FlagExcessCPF char(1),
in In_IRASNationalityCode char(20),
in In_PayeeIDType char(1),
in In_CessationProvision char(1),
in In_Gender char(1),
in In_MaritalStatusDesc char(50),
in In_SupYEGlobalId char(20),
in In_IR21Indicator char(1),
in In_NationalityDesc char(100))
begin
  if not exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear) then
    insert into YEEmployee(PersonalSysID,
      YEYear,
      CurrentYEGlobalId,
      YEEmployerId,
      TaxNo,
      Designation,
      EEAddress1,
      EEAddress2,
      EEAddress3,
      EEAddress4,
      PostalCode,
      EEAddressType,
      EEAddressCountry,
      EEName1,
      EEName2,
      EEName3,
      DOB,
      Commencement,
      Cessation,
      IRASSection45,
      IR8SIndicator,
      A8AIndicator,
      Flag100K,
      FlagPercentOrdWage,
      FlagOverseasCPF,
      FlagExcessCPF,
      IRASNationalityCode,
      PayeeIDType,
      CessationProvision,
      Gender,
      MaritalStatusDesc,
      SupYEGlobalId,
      IR21Indicator,
      LastChangedDateTime,
      NationalityDesc) values(
      In_PersonalSysID,
      In_YEYear,
      In_CurrentYEGlobalId,
      In_YEEmployerId,
      In_TaxNo,
      In_Designation,
      In_EEAddress1,
      In_EEAddress2,
      In_EEAddress3,
      In_EEAddress4,
      In_PostalCode,
      In_EEAddressType,
      In_EEAddressCountry,
      In_EEName1,
      In_EEName2,
      In_EEName3,
      In_DOB,
      In_Commencement,
      In_Cessation,
      In_IRASSection45,
      In_IR8SIndicator,
      In_A8AIndicator,
      In_Flag100K,
      In_FlagPercentOrdWage,
      In_FlagOverseasCPF,
      In_FlagExcessCPF,
      In_IRASNationalityCode,
      In_PayeeIDType,
      In_CessationProvision,
      In_Gender,
      In_MaritalStatusDesc,
      In_SupYEGlobalId,
      In_IR21Indicator,
      now(*),
      In_NationalityDesc);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateYEEmployee') then
   drop procedure UpdateYEEmployee;
end if;

create procedure dba.UpdateYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(30),
in In_EEAddress1 char(30),
in In_EEAddress2 char(30),
in In_EEAddress3 char(30),
in In_EEAddress4 char(30),
in In_PostalCode char(6),
in In_EEAddressType char(20),
in In_EEAddressCountry char(20),
in In_EEName1 char(35),
in In_EEName2 char(35),
in In_EEName3 char(10),
in In_DOB date,
in In_Commencement date,
in In_Cessation date,
in In_IRASSection45 char(1),
in In_IR8SIndicator char(1),
in In_A8AIndicator char(1),
in In_Flag100K char(1),
in In_FlagPercentOrdWage char(1)
,in In_FlagOverseasCPF char(1),
in In_FlagExcessCPF char(1),
in In_IRASNationalityCode char(20),
in In_PayeeIDType char(1),
in In_CessationProvision char(1),
in In_Gender char(1),
in In_MaritalStatusDesc char(50),
in In_SupYEGlobalId char(20),
in In_IR21Indicator char(1),
in In_NationalityDesc  char(100))
begin
  if exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear) then
    update YEEmployee set
      CurrentYEGlobalId = In_CurrentYEGlobalId,
      YEEmployerId = In_YEEmployerId,
      TaxNo = In_TaxNo,
      Designation = In_Designation,
      EEAddress1 = In_EEAddress1,
      EEAddress2 = In_EEAddress2,
      EEAddress3 = In_EEAddress3,
      EEAddress4 = In_EEAddress4,
      PostalCode = In_PostalCode,
      EEAddressType = In_EEAddressType,
      EEAddressCountry = In_EEAddressCountry,
      EEName1 = In_EEName1,
      EEName2 = In_EEName2,
      EEName3 = In_EEName3,
      DOB = In_DOB,
      Commencement = In_Commencement,
      Cessation = In_Cessation,
      IRASSection45 = In_IRASSection45,
      IR8SIndicator = In_IR8SIndicator,
      A8AIndicator = In_A8AIndicator,
      Flag100K = In_Flag100K,
      FlagPercentOrdWage = In_FlagPercentOrdWage,
      FlagOverseasCPF = In_FlagOverseasCPF,
      FlagExcessCPF = In_FlagExcessCPF,
      IRASNationalityCode = In_IRASNationalityCode,
      PayeeIDType = In_PayeeIDType,
      CessationProvision = In_CessationProvision,
      Gender = In_Gender,
      MaritalStatusDesc = In_MaritalStatusDesc,
      SupYEGlobalId = In_SupYEGlobalId,
      IR21Indicator = In_IR21Indicator,
      LastChangedDateTime = now(*),
      NationalityDesc = In_NationalityDesc where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessYEEmployee') then
   drop procedure ASQLYEProcessYEEmployee;
end if;

create procedure DBA.ASQLYEProcessYEEmployee(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_SupYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_Operation char(20),
in In_ProcessIR21 char(1))
begin
  declare In_TaxNo char(20);
  declare In_DOB date;
  declare In_PersonalName char(150);
  declare In_EEName1 char(35);
  declare In_EEName2 char(35);
  declare In_EEName3 char(10);
  declare In_EEAddress1 char(30);
  declare In_EEAddress2 char(30);
  declare In_EEAddress3 char(30);
  declare In_EEAddress4 char(30);
  declare In_EEAddressCountry char(20);
  declare In_PostalCode char(6);
  declare In_IdentityTypeId char(20);
  declare In_PayeeIDType char(1);
  declare In_GenderCodeId char(1);
  declare In_Gender char(1);
  declare In_MaritalStatusCode char(20);
  declare In_MaritalStatusDesc char(60);
  declare In_IRASNationalityCode char(20);
  declare In_Nationality char(20);
  declare In_CommencementDate date;
  declare In_CessationDate date;
  declare In_Designation char(30);
  declare In_EmployeeSysId integer;
  declare In_CessationProvision char(1);
  declare In_AddressType char(20);
  declare In_NationalityDesc char(100);
  /*
  Recalculate Operation
  */
  if(In_Operation = 'Recalculate') then
    select Commencement,Cessation into In_CommencementDate,In_CessationDate from YEEmployee where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    /*
    Cessation Provision
    */
    if(In_CommencementDate < '1969-1-1' and Year(In_CessationDate) = In_YEYear) then
      set In_CessationProvision='Y'
    else
      set In_CessationProvision='N'
    end if;
    update YEEmployee set
      CessationProvision = In_CessationProvision where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work;
    return
  end if;
  /*
  For Create and Reprocess Operation  
  Get the latest Employment
  */
  select Max(HireDate) into In_CommencementDate from Employee where PersonalSysId = In_PersonalSysId;
  if In_CommencementDate is null then return // not employed yet
  end if;
  select EmployeeSysId into In_EmployeeSysId from Employee where PersonalSysId = In_PersonalSysId and HireDate = In_CommencementDate;
  select PositionDesc,CessationDate into In_Designation,In_CessationDate from Employee join PositionCode where EmployeeSysId = In_EmployeeSysId;
  if In_CessationDate is null then set In_CessationDate='1899-12-30'
  end if;
  /*
  Cessation Provision
  */
  if(In_CommencementDate < '1969-1-1' and Year(In_CessationDate) = In_YEYear) then
    set In_CessationProvision='Y'
  else
    set In_CessationProvision='N'
  end if;
  /*
  Check if Hire date not in Current Year then blank
  Check if Cessation date not in Current Year then blank
  */
  if(In_ProcessIR21 = 'N') then
      if(Year(In_CommencementDate) <> In_YEYear and In_CessationProvision = 'N') then set In_CommencementDate='1899-12-30'
       end if;
      if(Year(In_CessationDate) <> In_YEYear) then set In_CessationDate='1899-12-30'
      end if;
  end if;
  /*
  Get information from Personal
  */
  select Nationality,
    FGetNationality(Nationality),
    MaritalStatusCode,
    Gender,
    Trim(IdentityNo),
    IdentityTypeId,
    DateOfBirth,
    PersonalName into In_Nationality,
    In_NationalityDesc, 
    In_MaritalStatusCode,
    In_GenderCodeId,
    In_TaxNo,
    In_IdentityTypeId,
    In_DOB,
    In_PersonalName from Personal where PersonalSysId = In_PersonalSysId;
  /*
  Map Nationality
  */
  select IRASNationalityCode into In_IRASNationalityCode from IRASNationality where EPECountryId = In_Nationality;
  /*
  Get Marital Status
  */
  select MaritalStatusDesc into In_MaritalStatusDesc from MaritalStatus where MaritalStatusCode = In_MaritalStatusCode;
  /*
  Decode Payee Type
  */
  if In_IdentityTypeId = 'SNRIC(PINK)' or In_IdentityTypeId = 'SNRIC(BLUE)' then
    set In_PayeeIDType='1' // NRIC
  elseif In_IdentityTypeId = 'FIN(EP)' then
    set In_PayeeIDType='2' // FIN
  elseif In_IdentityTypeId = 'FIN' then
    set In_PayeeIDType='2' // FIN   
  elseif In_IdentityTypeId = 'Passport' then
    set In_PayeeIDType='6' // Passport 
  /*
  Immigration File Ref No.
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) = 8 and
  SubString(In_TaxNo,1,1) between '0' and '9' and
  SubString(In_TaxNo,2,1) between '0' and '9' and
  SubString(In_TaxNo,3,1) between '0' and '9' and
  SubString(In_TaxNo,4,1) between '0' and '9' and
  SubString(In_TaxNo,5,1) between '0' and '9' and
  SubString(In_TaxNo,6,1) between '0' and '9' and
  SubString(In_TaxNo,7,1) between '0' and '9' and
  Upper(SubString(In_TaxNo,8,1)) between 'A' and 'Z' then
    set In_PayeeIDType='3'
  /*
  Malaysia IC 12 numeric Format
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) = 12 and
  SubString(In_TaxNo,1,1) between '0' and '9' and
  SubString(In_TaxNo,2,1) between '0' and '9' and
  SubString(In_TaxNo,3,1) between '0' and '9' and
  SubString(In_TaxNo,4,1) between '0' and '9' and
  SubString(In_TaxNo,5,1) between '0' and '9' and
  SubString(In_TaxNo,6,1) between '0' and '9' and
  SubString(In_TaxNo,7,1) between '0' and '9' and
  SubString(In_TaxNo,8,1) between '0' and '9' and
  SubString(In_TaxNo,9,1) between '0' and '9' and
  SubString(In_TaxNo,10,1) between '0' and '9' and
  SubString(In_TaxNo,11,1) between '0' and '9' and
  SubString(In_TaxNo,12,1) between '0' and '9' then
    set In_PayeeIDType='5'
  /*
  Malaysia IC 7 to 8 alphaNumeric Format
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) between 7 and 8 then
    set In_PayeeIDType='5'
  else
    set In_PayeeIDType='0'
  end if;
  /*
  Decode Gender
  */
  if In_GenderCodeId = '1' then set In_Gender='M'
  else set In_Gender='F'
  end if;
  /*
  Break Name
  */
  select SubString(In_PersonalName,1,35) into In_EEName1;
  select SubString(In_PersonalName,36,35) into In_EEName2;
  select SubString(In_PersonalName,71,10) into In_EEName3;
  /*
  Get Address Type
  */
  select CustString1 into In_AddressType from PersonalAddress where PersonalSysId = In_PersonalSysId and
    PersonalAddMailing = 1;
  if(In_AddressType = '' or In_AddressType is null) then set In_AddressType='N'
  end if; /*
  Get Formatted Address
  */
  if(In_AddressType = 'L' or In_AddressType = 'C') then
    select CustString2,CustString3,CustString4,CustString5,PersonalAddPCode,PersonalAddCountry into In_EEAddress1,
      In_EEAddress2,In_EEAddress3,In_EEAddress4,In_PostalCode,In_EEAddressCountry from PersonalAddress where
      PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1
  elseif(In_AddressType = 'F') then
    /*
    Get UnFormatted Address
    */
    select PersonalAddAddress,PersonalAddAddress2,PersonalAddAddress3,PersonalAddPCode,PersonalAddCountry into In_EEAddress1,
      In_EEAddress2,In_EEAddress3,In_PostalCode,In_EEAddressCountry from PersonalAddress where
      PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1;
    set In_EEAddress4=''
  else
    set In_EEAddress1='';
    set In_EEAddress2='';
    set In_EEAddress3='';
    set In_EEAddress4='';
  end if;
  /*
  Convert Country Code to IRAS Code
  */
  select IRASNationalityCode into In_EEAddressCountry from IRASNationality where EPECountryId = In_EEAddressCountry;
  if(In_EEAddressCountry = '') then set In_EEAddressCountry='999'
  end if; /*
  Create new YEEmployee
  */
  if(In_Operation = 'Create') then
    call InsertNewYEEmployee(
    In_PersonalSysID,
    In_YEYear,
    In_CurrentYEGlobalId,
    In_YEEmployerId,
    In_TaxNo,
    In_Designation,
    In_EEAddress1,
    In_EEAddress2,
    In_EEAddress3,
    In_EEAddress4,
    In_PostalCode,
    In_AddressType,
    In_EEAddressCountry,
    In_EEName1,
    In_EEName2,
    In_EEName3,
    In_DOB,
    In_CommencementDate,
    In_CessationDate,'N','N','N','N','N','N','N',
    /* In_IRASSection45 */
    /* In_IR8SIndicator */
    /* In_A8AIndicator */
    /* In_Flag100K */
    /* In_FlagPercentOrdWage */
    /* In_FlagOverseasCPF */
    /* In_FlagExcessCPF */
    In_IRASNationalityCode,
    In_PayeeIDType,
    In_CessationProvision,
    In_Gender,
    In_MaritalStatusDesc,
    In_SupYEGlobalId,In_ProcessIR21,In_NationalityDesc)
  else
    /* Only Reprocess */
    update YEEmployee set
      TaxNo = In_TaxNo,
      Designation = In_Designation,
      EEAddress1 = In_EEAddress1,
      EEAddress2 = In_EEAddress2,
      EEAddress3 = In_EEAddress3,
      EEAddress4 = In_EEAddress4,
      PostalCode = In_PostalCode,
      EEAddressType = In_AddressType,
      EEAddressCountry = In_EEAddressCountry,
      EEName1 = In_EEName1,
      EEName2 = In_EEName2,
      EEName3 = In_EEName3,
      DOB = In_DOB,
      Commencement = In_CommencementDate,
      Cessation = In_CessationDate,
      IRASNationalityCode = In_IRASNationalityCode,
      PayeeIDType = In_PayeeIDType,
      CessationProvision = In_CessationProvision,
      Gender = In_Gender,
      MaritalStatusDesc = In_MaritalStatusDesc,
      LastChangedDateTime = now(*) ,
      NationalityDesc = In_NationalityDesc where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessIR8A') then
   drop procedure ASQLYEProcessIR8A;
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
    '1899-12-30'); //In_RetirementPaymentDate 
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

// Data
if not exists(select * from subregistry where Registryid = 'YEPRocess' and SubRegistryId = 'TaxEmployerBasisYear') then
   insert into subregistry(RegistryId, subregistryid, RegProperty1,RegProperty2)
   values('YEPRocess','TaxEmployerBasisYear','','');
end if;

if exists(select * from YEKeyword where YEKeyWordId = 'Cote Divoire ') then 
   delete from YEKeyword where YEKeyWordId = 'Cote Divoire ';
end if;

if not exists(select * from YEKeyword where YEKeyWordId = 'Cote Divoire') then 
insert into YEKeyWord(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9) 
Values('Cote Divoire','','Ivory Coast ','IRASNationality','','','','422','','','','','','1899-12-30 00:00:00'); 
End if;

if not exists(select * from YEKeyword where YEKeyWordId = 'KyrgyzstanCountry') then 
insert into YEKeyWord(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9) 
Values('KyrgyzstanCountry','','Kyrgyzstan ','IRASNationality','','','','894','','','','','','1899-12-30 00:00:00'); 
End if;

commit work;