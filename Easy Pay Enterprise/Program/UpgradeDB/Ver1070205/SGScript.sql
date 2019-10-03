if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewYEEmployer') then
  drop procedure InsertNewYEEmployer
end if;
create procedure "DBA"."InsertNewYEEmployer"(
in In_YEEmployerID char(20),
in In_YEEmployerDesc char(100),
in In_TaxRefNo char(20),
in In_TelephoneNo char(20),
in In_ERName1 char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_AuthorisedName char(60),
in In_DeclaredDate date,
in In_Designation char(30),
in In_EmployerSource char(20),
in In_PayerId char(20),
in In_ERName2 char(35),
in In_IsAutoInclusion smallint,
in In_DivisionBranch char(100),
in In_EmailAddress char(100),
in In_HandphonePagerNo char(20),
in In_ContactPerson char(60),
in In_FaxNo char(20),
in In_DateIncorporation date,
in In_AddressBlock char(20),
in In_AddressStorey char(20),
in In_AddressUnit char(20),
in In_AddressStreetName char(100),
in In_AddressPostalCode char(20))
begin
  if not exists(select* from YEEmployer where 
        YEEmployer.YEEmployerID = In_YEEmployerID) then
    insert into YEEmployer(YEEmployerID,
      YEEmployerDesc,
      TaxRefNo,
      TelephoneNo,
      ERName1,
      DivisionBranch,
      Address1,
      Address2,
      Address3,
      AuthorisedName,
      DeclaredDate,
      Designation,
      EmailAddress,
      EmployerSource,
      PayerId,
      ERName2,
      IsAutoInclusion,
      HandphonePagerNo,
      ContactPerson,
      FaxNo,
      DateIncorporation,
      AddressBlock,
      AddressStorey,
      AddressUnit,
      AddressStreetName,
      AddressPostalCode) values(
      In_YEEmployerID,
      In_YEEmployerDesc,
      In_TaxRefNo,
      In_TelephoneNo,
      In_ERName1,
      In_DivisionBranch,
      In_Address1,
      In_Address2,
      In_Address3,
      In_AuthorisedName,
      In_DeclaredDate,
      In_Designation,
      In_EmailAddress,
      In_EmployerSource,
      In_PayerId,
      In_ERName2,
      In_IsAutoInclusion,
      In_HandphonePagerNo,
      In_ContactPerson,
      In_FaxNo,
      In_DateIncorporation,
      In_AddressBlock,
      In_AddressStorey,
      In_AddressUnit,
      In_AddressStreetName,
      In_AddressPostalCode);
    commit work
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdateYEEmployer') then
  drop procedure UpdateYEEmployer
end if;
create procedure "DBA"."UpdateYEEmployer"(
in In_YEEmployerID char(20),
in In_YEEmployerDesc char(100),
in In_TaxRefNo char(20),
in In_TelephoneNo char(20),
in In_ERName1 char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_AuthorisedName char(60),
in In_DeclaredDate date,
in In_Designation char(30),
in In_EmployerSource char(20),
in In_PayerId char(20),
in In_ERName2 char(35),
in In_IsAutoInclusion smallint,
in In_DivisionBranch char(100),
in In_EmailAddress char(100),
in In_HandphonePagerNo char(20),
in In_ContactPerson char(60),
in In_FaxNo char(20),
in In_DateIncorporation date,
in In_AddressBlock char(20),
in In_AddressStorey char(20),
in In_AddressUnit char(20),
in In_AddressStreetName char(100),
in In_AddressPostalCode char(20))
begin
  if exists(select* from YEEmployer where 
        YEEmployer.YEEmployerID = In_YEEmployerID) then
    update YEEmployer set
      YEEmployer.YEEmployerID = In_YEEmployerID,
      YEEmployer.YEEmployerDesc = In_YEEmployerDesc,
      YEEmployer.TaxRefNo = In_TaxRefNo,
      YEEmployer.TelephoneNo = In_TelephoneNo,
      YEEmployer.ERName1 = In_ERName1,
      YEEmployer.DivisionBranch = In_DivisionBranch,
      YEEmployer.Address1 = In_Address1,
      YEEmployer.Address2 = In_Address2,
      YEEmployer.Address3 = In_Address3,
      YEEmployer.AuthorisedName = In_AuthorisedName,
      YEEmployer.DeclaredDate = In_DeclaredDate,
      YEEmployer.Designation = In_Designation,
      YEEmployer.EmailAddress = In_EmailAddress,
      YEEmployer.EmployerSource = In_EmployerSource,
      YEEmployer.PayerId = In_PayerId,
      YEEmployer.ERName2 = In_ERName2,
      YEEmployer.IsAutoInclusion = In_IsAutoInclusion,
      YEEmployer.HandphonePagerNo = In_HandphonePagerNo,
      YEEmployer.ContactPerson = In_ContactPerson,
      YEEmployer.FaxNo = In_FaxNo,
      YEEmployer.DateIncorporation = In_DateIncorporation,
      YEEmployer.AddressBlock = In_AddressBlock,
      YEEmployer.AddressStorey = In_AddressStorey,
      YEEmployer.AddressUnit = In_AddressUnit,
      YEEmployer.AddressStreetName = In_AddressStreetName,
      YEEmployer.AddressPostalCode = In_AddressPostalCode where
      YEEmployer.YEEmployerID = In_YEEmployerID;
    update YEEmployee set LastChangedDateTime = now(*) where 
        YEEmployerId = In_YEEmployerID;
    commit work
  end if
end;

commit work;