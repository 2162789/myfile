if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessYEEmployee') then
   drop function DBA.ASQLYEProcessYEEmployee
end if;

CREATE PROCEDURE DBA.ASQLYEProcessYEEmployee(
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
  if(Year(In_CommencementDate) <> In_YEYear and In_CessationProvision = 'N') then set In_CommencementDate='1899-12-30'
  end if;
  if(Year(In_CessationDate) <> In_YEYear) then set In_CessationDate='1899-12-30'
  end if;
  /*
  Get information from Personal
  */
  select Nationality,
    MaritalStatusCode,
    Gender,
    Trim(IdentityNo),
    IdentityTypeId,
    DateOfBirth,
    PersonalName into In_Nationality,
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
    In_SupYEGlobalId,In_ProcessIR21)
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
      LastChangedDateTime = now(*) where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

Commit Work;