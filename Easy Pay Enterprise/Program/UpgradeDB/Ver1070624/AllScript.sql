-- Delete this SP because it's no in use -- 
if exists(select * from sys.sysprocedure where proc_name = 'DeleteLeaveApplicationForESS') then
   drop procedure DeleteLeaveApplicationForESS;
end if;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLESSGetLookups') then
   drop procedure ASQLESSGetLookups;
end if;
create PROCEDURE "DBA"."ASQLESSGetLookups"(
in In_Type char(50),
in In_Code char(50)) 
BEGIN
    /*
      Type cannot change because it's defined by ESS WebAPI
    */
    Select * From
    (
		Select 'Title' As [Type], TitleId As [Code], (Case When TitleDesc = '' then TitleId else TitleDesc end)  As [Description], Cast(1 As bit) As [Active] From TitleCode 
		Where (In_Type = '') Or (In_Type ='Title' And (In_Code = TitleId Or In_Code = '')) 
		Union  
		Select 'Gender' As [Type], GenderCodeName As [Code], GenderCodeName As [Description], Cast(1 As bit) As [Active] From GenderCode 
		Where (In_Type = '') Or (In_Type ='Gender' And (In_Code = GEnderCodeId Or In_Code = ''))
		Union  
		Select 'MaritalStatus' As [Type], MaritalStatusCode As [Code], (Case When MaritalStatusDesc = '' then MaritalStatusCode Else MaritalStatusDesc End) As [Description], Cast(1 As bit) As [Active] From MaritalStatus 
		Where (In_Type = '')  Or (In_Type ='MaritalStatus' And (In_Code = MaritalStatusCode Or In_Code = ''))
		Union                   
		Select 'TerminationReason' As [Type], CessationCode As [Code], (Case When CessationDesc = '' then CessationCode Else CessationDesc End) As [Description], Cast(1 As bit) As [Active] From [Cessation]  
		Where (In_Type = '') Or (In_Type ='TerminationReason' And (In_Code = CessationCode Or In_Code = '')) 	
		Union   
		Select 'Country' As [Type], CountryId As [Code], (Case When CountryName = '' then CountryId Else CountryName End) As [Description], Cast(1 As bit) As [Active] From Country 
		Where (In_Type = '') Or (In_Type ='Country' And (In_Code = CountryId Or In_Code = ''))
		Union  
		Select 'State' As [Type], StateId As [Code], (Case When StateName = '' then StateId Else StateName End) As [Description], Cast(1 As bit) As [Active] From State 
		Where (In_Type = '') Or (In_Type ='State' And (In_Code = StateId Or In_Code = '')) 
		Union
		Select 'EmploymentType' As [Type], PersonalTypeId As [Code], (Case When PersonalTypeDesc = '' then PersonalTypeId Else PersonalTypeDesc End) As [Description], Cast(1 As bit) As [Active] From PersonalType 
		Where (In_Type = '') Or (In_Type ='EmploymentType' And (In_Code = PersonalTypeId Or In_Code = '')) 
		Union    
		Select 'JobClassification' As [Type], Positionid As [code], (Case When PositionDesc = '' then Positionid Else PositionDesc End) As [Description], Cast(1 As bit) As [Active] From PositionCode 
		Where (In_Type = '') Or (In_Type ='JobClassification' And (In_Code = Positionid Or In_Code = ''))  
		Union  
		Select Distinct 'Location' As [Type], CountryCode As [Code], CountryCode As [Description], Cast(1 As bit) As [Active] From Calendar ca 
		Join EmpeeWkCalen ewk ON ca.CalendarId = ewk.CalendarId
		Join Employee e On ewk.EmployeeSysId = e.EmployeeSysid
		Join ESSEmployee ess On e.EmployeeSysid = ess.EmployeeSysid
		Where ((In_Type = '') Or (In_Type ='Location' And (In_Code = CountryCode Or In_Code = '')) And (CessationDate = '1899-12-30' or CessationDate >= Today()))
		Union  
		Select 'PayrollCompany' As [Type], CompanyId As [Code], (Case When CompanyName = '' then CompanyId Else CompanyName End) As [Description], Cast(1 As bit) As [Active] From Company 
		Where (In_Type = '') Or (In_Type ='PayrollCompany' And (In_Code = CompanyId Or In_Code = ''))
    ) As Lookups
    Order by [Type], [Code]
END;

-- SubRegisty --
if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'SendHolidaysLvePat') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','SendHolidaysLvePat','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;