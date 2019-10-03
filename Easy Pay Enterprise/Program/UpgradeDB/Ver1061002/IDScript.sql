if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIndoTaxEmployer') then
   drop procedure InsertNewIndoTaxEmployer
end if;
create procedure DBA.InsertNewIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(35),
in In_IndoTaxAuthoriseTaxRefNo char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(30),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(35),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    insert into IndoTaxEmployer(IndoTaxEmployerId,
      IndoTaxEmployerDesc,
      IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo,
      Address1,Address2,Address3,
      State,City,PostalCode,
      TelephoneNo,
      TypeOfBusiness,
      RegistrationNo,
      IndoOldAgeOption,
      Signature,
      IndoBPJSKSOption) values(
      In_IndoTaxEmployerId,
      In_IndoTaxEmployerDesc,
      In_IndoTaxAuthoriseName,
      In_IndoTaxERTaxRefNo,
      In_IndoTaxAuthoriseTaxRefNo,
      In_Address1,In_Address2,In_Address3,
      In_State,In_City,In_PostalCode,
      In_TelephoneNo,
      In_TypeOfBusiness,
      In_RegistrationNo,
      In_IndoOldAgeOption,
      In_Signature,
      In_IndoBPJSKSOption);
    commit work;
    if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIndoTaxEmployer') then
   drop procedure UpdateIndoTaxEmployer
end if;
create procedure DBA.UpdateIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(35),
in In_IndoTaxAuthoriseTaxRefNo char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(30),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(35),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
out Out_ErrorCode 
integer)
begin
  if exists(select* from IndoTaxEmployer where IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    update IndoTaxEmployer set
      IndoTaxEmployerDesc = In_IndoTaxEmployerDesc,
      IndoTaxAuthoriseName = In_IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo = In_IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo = In_IndoTaxAuthoriseTaxRefNo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      TypeOfBusiness = In_TypeOfBusiness,
      RegistrationNo = In_RegistrationNo,
      IndoOldAgeOption = In_IndoOldAgeOption,
      Signature = In_Signature, 
      IndoBPJSKSOption = In_IndoBPJSKSOption where
      IndoTaxEmployerId = In_IndoTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;
commit work;