if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessYEEmployee') then
    drop procedure ASQLYEProcessYEEmployee
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
  declare In_BankSalaryCredited char(100); 
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
   Bank to which salary is credited
   */
  select first FGetBankName(BankId) into In_BankSalaryCredited from PaymentBankInfo where EmployeeSysId = In_EmployeeSysId order by PaymentValue desc;
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
    In_SupYEGlobalId,
    In_ProcessIR21,
    In_NationalityDesc,
    In_BankSalaryCredited)
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
      NationalityDesc = In_NationalityDesc,
      BankSalaryCredited = In_BankSalaryCredited where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewYEEmployee') then
    drop procedure InsertNewYEEmployee
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
in In_NationalityDesc char(100),
in In_BankSalaryCredited char(100))
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
      NationalityDesc,
      BankSalaryCredited) values(
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
      In_NationalityDesc,
      In_BankSalaryCredited);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateYEEmployee') then
    drop procedure UpdateYEEmployee
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
in In_NationalityDesc  char(100),
in In_BankSalaryCredited char(100))
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
      NationalityDesc = In_NationalityDesc,
      BankSalaryCredited = In_BankSalaryCredited where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewA8AS2S3') then
    drop procedure InsertNewA8AS2S3
end if;

Create PROCEDURE "DBA"."InsertNewA8AS2S3"(
In In_PersonalSysId integer,
In In_YEYear integer,
In In_AnnualValue double, 
In In_FurnishedStatus char(20), 
In In_FurnitureFittingsValue double, 
In In_RentPaidToLandlord double, 
In In_ResidenceValue double, 
In In_RentPaidByEmployee double,
In In_TotalTaxableResidenceValue double,
In In_UtilityTelPagerValue double, 
In In_Driver double, 
In In_ServantGardener double, 
In In_TotalValueofUtilities double, 
In In_HotelAccommodation double, 
In In_HotelAmtPaidByEmployee double,
In In_TotalHotelAccommodation double
)
BEGIN
  if not exists(select* from A8AS2S3 where
      A8AS2S3.PersonalSysId = In_PersonalSysId and
      A8AS2S3.YEYear = In_YEYear) then
    insert into A8AS2S3(
      PersonalSysId,
      YEYear,
      AnnualValue,
      FurnishedStatus,
      FurnitureFittingsValue,
      RentPaidToLandlord,
      ResidenceValue,
      RentPaidByEmployee,
      TotalTaxableResidenceValue,
      UtilityTelPagerValue,
      Driver,
      ServantGardener,
      TotalValueofUtilities,
      HotelAccommodation,
      HotelAmtPaidByEmployee,
      TotalHotelAccommodation) values(
      In_PersonalSysId,
      In_YEYear,
      In_AnnualValue,
      In_FurnishedStatus,
      In_FurnitureFittingsValue,
      In_RentPaidToLandlord,
      In_ResidenceValue,
      In_RentPaidByEmployee,
      In_TotalTaxableResidenceValue,
      In_UtilityTelPagerValue,
      In_Driver,
      In_ServantGardener,
      In_TotalValueofUtilities,
      In_HotelAccommodation,
      In_HotelAmtPaidByEmployee,
      In_TotalHotelAccommodation);
    commit work;
  end if;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateA8AS2S3') then
    drop procedure UpdateA8AS2S3
end if;

Create PROCEDURE "DBA"."UpdateA8AS2S3"(
In In_PersonalSysId integer,
In In_YEYear integer,
In In_AnnualValue double, 
In In_FurnishedStatus char(20), 
In In_FurnitureFittingsValue double, 
In In_RentPaidToLandlord double, 
In In_ResidenceValue double, 
In In_RentPaidByEmployee double,
In In_TotalTaxableResidenceValue double,
In In_UtilityTelPagerValue double, 
In In_Driver double, 
In In_ServantGardener double, 
In In_TotalValueofUtilities double, 
In In_HotelAccommodation double, 
In In_HotelAmtPaidByEmployee double,
In In_TotalHotelAccommodation double,
OUT Out_ErrorCode integer
)
BEGIN
  if exists(select * from A8AS2S3 Where PersonalSysId = In_PersonalSysId And YEYear = In_YEYear) Then
	 Update A8AS2S3 Set
       AnnualValue = In_AnnualValue,
       FurnishedStatus = In_FurnishedStatus,
       FurnitureFittingsValue = In_FurnitureFittingsValue,
       RentPaidToLandlord = In_RentPaidToLandlord,
       ResidenceValue = In_ResidenceValue,
       RentPaidByEmployee = In_RentPaidByEmployee,
       TotalTaxableResidenceValue = In_TotalTaxableResidenceValue,
       UtilityTelPagerValue = In_UtilityTelPagerValue,
       Driver = In_Driver,
       ServantGardener = In_ServantGardener,
       TotalValueofUtilities = In_TotalValueofUtilities,
       HotelAccommodation = In_HotelAccommodation,
       HotelAmtPaidByEmployee = In_HotelAmtPaidByEmployee,
       TotalHotelAccommodation = In_TotalHotelAccommodation
     Where PersonalSysId = In_PersonalSysId And YEYear = In_YEYear;
     commit work;
     set Out_ErrorCode=1;
     update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
  else
     set Out_ErrorCode=0;
  end if;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteA8AS2S3') then
    drop procedure DeleteA8AS2S3
end if;

Create PROCEDURE "DBA"."DeleteA8AS2S3"(
In In_PersonalSysId integer,
In In_YEYear integer,
OUT Out_ErrorCode integer 
)
BEGIN
	if exists(select * from A8AS2S3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
       delete from A8AS2S3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear; 
	   if exists(select * from A8AS2S3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
         set Out_ErrorCode = 0;
       else
         set Out_ErrorCode =1;
       end if;
     else
         set Out_ErrorCode = 0;
     end if;
END;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessA8A') then
    drop procedure ASQLYEProcessA8A
end if;

CREATE PROCEDURE "DBA"."ASQLYEProcessA8A"(
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
    0, /*In_LongService*/
    0, /*In_Clubs*/
    0, /*In_Assets*/
    0, /*In_MotorVehicle*/
    0, /*In_CarBenefit*/
    In_OtherBenefits,'','','','',
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
      if In_YEYear >2013 then
	    call InsertNewIR21A1S4S5(In_PersonalSysID,In_YEYear,'','1899-12-30','1899-12-30',0,0,'',0,0,0,'','1899-12-30','1899-12-30',0,0,'',0,0,0,0,0,0,0,0,0,0,0);
      else
        call ASQLYECreateIR21A1_S2S3(In_PersonalSysID,In_YEYear); 
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
      update A8A set
        OtherBenefits = In_OtherBenefits where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
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
  if(In_ProcessIR21 = 'N' and In_YEYear >2013) then
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

if exists(select * from sys.sysprocedure where proc_name = 'DeleteA8A') then
    drop procedure DeleteA8A
end if;

CREATE PROCEDURE "DBA"."DeleteA8A"(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear;
    delete from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear;
    delete from A8AS2S3 where
      A8AS2S3.PersonalSysId = In_PersonalSysId and
      A8AS2S3.YEYear = In_YEYear;
    delete from IR21A1S4S5 where
      IR21A1S4S5.PersonalSysId = In_PersonalSysId and
      IR21A1S4S5.YEYear = In_YEYear;       
    delete from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear;
    commit work;
  end if;
end;

commit work;