IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeePersonnelDetails') THEN
    DROP VIEW "DBA"."View_Alc_EmployeePersonnelDetails";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeePersonnelDetails" AS 
 SELECT 
 Personal.EmployeeID  
, Personal.PersonalName AS PersonalName
, Personal.Alias AS Alias
, Personal.BloodGroupId AS BloodGroupId
, FGetBloodGroupType(Personal.BloodGroupId) AS BloodGroupType
, Personal.CountryOfBirth AS CountryOfBirth
, FGetCountryName(Personal.CountryOfBirth) AS CountryNameOfBirth
, Personal.DateOfBirth AS DateOfBirth
, Personal.Gender AS Gender
, FGetGenderDesc(Personal.Gender) AS GenderDesc
, Personal.Height AS Height
, Personal.IdentityNo AS IdentityNo
, Personal.IdentityTypeId AS IdentityTypeId
, FGetIdentityTypeDesc(Personal.IdentityTypeId) AS IdentityTypeDesc
, Personal.Mal_OldIdentity AS Mal_OldIdentity
, Personal.MaritalStatusCode AS MaritalStatusCode
, FGetMaritalStatusDesc(Personal.MaritalStatusCode) AS MaritalStatusDesc
, Personal.Nationality AS Nationality
, Personal.PassportIssue AS PassportIssue
, Personal.RaceId AS RaceId
, FGetRaceDesc(Personal.RaceId) AS RaceDesc 
, Personal.ReligionID AS ReligionID
, FGetReligionDesc(Personal.ReligionID) AS ReligionDesc
, Personal.TitleId AS TitleId
, FGetTitleCodeDesc(Personal.TitleId) AS TitleDesc
, Personal.Weight AS Weight
 FROM
Personal