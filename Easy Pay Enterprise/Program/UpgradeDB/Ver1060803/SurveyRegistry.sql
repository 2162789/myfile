/*Job Position Basis */
if not exists(select * from registry where registryid = 'LabSurveyPosBasis') then
   insert into registry(registryid,RegistryDesc) values('LabSurveyPosBasis','Labour Survey Job Position Basis');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'Category') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','Category','','','ShortStringAttr','CategoryId','Category','Employee','Select 1, CategoryId as A, CategoryDesc as B from Category ','','','A;B',0.0,0,'',0,'Category','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'Position') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','Position','','','ShortStringAttr','PositionId','PositionCode','Employee','Select 1, PositionId as A, PositionDesc as B from PositionCode ','','','A;B',0.0,0,'',0,'Position','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'EmpCode1Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','EmpCode1Id','','','ShortStringAttr','EmpCode1Id','EmpCode1','Employee','Select 1, EmpCode1Id as A, CustCodeDesc as B from EmpCode1 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'EmpCode2Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','EmpCode2Id','','','ShortStringAttr','EmpCode2Id','EmpCode2','Employee','Select 1, EmpCode2Id as A, CustCodeDesc as B from EmpCode2 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'EmpCode3Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','EmpCode3Id','','','ShortStringAttr','EmpCode3Id','EmpCode3','Employee','Select 1, EmpCode3Id as A, CustCodeDesc as B from EmpCode3 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'EmpCode4Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','EmpCode4Id','','','ShortStringAttr','EmpCode4Id','EmpCode4','Employee','Select 1, EmpCode4Id as A, CustCodeDesc as B from EmpCode4 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyPosBasis' and subregistryid = 'EmpCode5Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyPosBasis','EmpCode5Id','','','ShortStringAttr','EmpCode5Id','EmpCode5','Employee','Select 1, EmpCode5Id as A, CustCodeDesc as B from EmpCode5 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

/*Employee Classification Basis */
if not exists(select * from registry where registryid = 'LabSurveyClaBasis') then
   insert into registry(registryid,RegistryDesc) values('LabSurveyClaBasis','Labour Survey Employee Classification Basis');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'Classification') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','Classification','','','ShortStringAttr','ClassificationCode','Classification','Employee','Select 1, ClassificationCode as A, ClassificationDesc as B from Classification ','','','A;B',0.0,0,'',0,'Classification','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'EmpCode1Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','EmpCode1Id','','','ShortStringAttr','EmpCode1Id','EmpCode1','Employee','Select 1, EmpCode1Id as A, CustCodeDesc as B from EmpCode1 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'EmpCode2Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','EmpCode2Id','','','ShortStringAttr','EmpCode2Id','EmpCode2','Employee','Select 1, EmpCode2Id as A, CustCodeDesc as B from EmpCode2 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'EmpCode3Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','EmpCode3Id','','','ShortStringAttr','EmpCode3Id','EmpCode3','Employee','Select 1, EmpCode3Id as A, CustCodeDesc as B from EmpCode3 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'EmpCode4Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','EmpCode4Id','','','ShortStringAttr','EmpCode4Id','EmpCode4','Employee','Select 1, EmpCode4Id as A, CustCodeDesc as B from EmpCode4 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabSurveyClaBasis' and subregistryid = 'EmpCode5Id') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabSurveyClaBasis','EmpCode5Id','','','ShortStringAttr','EmpCode5Id','EmpCode5','Employee','Select 1, EmpCode5Id as A, CustCodeDesc as B from EmpCode5 ','','','A;B',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

/*Default Basis for Job Position & Employee Classification */
if not exists(select * from registry where registryid = 'LabourSurvey') then
   insert into registry(registryid,RegistryDesc) values('LabourSurvey','Labour Market Survey');
end if;

if not exists(select * from subregistry where registryid = 'LabourSurvey' and subregistryid = 'JobPositionBasis') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabourSurvey','JobPositionBasis','Position','PositionCode','PositionId','','','','','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabourSurvey' and subregistryid = 'ClassificationBasis') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabourSurvey','ClassificationBasis','Classification','Classification','ClassificationCode','','','','','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from subregistry where registryid = 'LabourSurvey' and subregistryid = 'ExplanatoryLink') then
   insert into subregistry(RegistryId,subregistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
               RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LabourSurvey','ExplanatoryLink','','','','','','','','','','',0.0,0,'',0,'','https://msol.mom.gov.sg/msol/est/Establishment/EstExplanatoryNotes.aspx?t=6307','1899-12-30','1899-12-30 00:00:00.000');
end if;

/* Map Default Cessation Code */
if exists(select * from Cessation where CessationCode = 'None') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'None') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('None','Others');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Terminated') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Terminated') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Terminated','EarlyRelOfContracts');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Resigned') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Resigned') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Resigned','Resignations');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Retired') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Retired') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Retired','Retirements');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Deceased') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Deceased') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Deceased','Others');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Dismissed') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Dismissed') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Dismissed','Dismissals');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Retrenched') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Retrenched') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Retrenched','Retrenchments');
   end if;
end if;

if exists(select * from Cessation where CessationCode = 'Leave Country') then
   if not exists(select * from LabSurveyCessationMapping where EPECessationCode = 'Leave Country') then
      insert into LabSurveyCessationMapping(EPECessationCode,MOMReason) values('Leave Country','Others');
   end if;
end if;

/* Map Default Classification Code */
if exists(select * from Classification where ClassificationCode = 'Permanent') then
   if not exists(select * from LabSurveyEmpClassificationMapping where EPEClassification = 'Permanent') then
      insert into LabSurveyEmpClassificationMapping(EPEClassification,MOMEmployeeClassification) values('Permanent','FullTime');
   end if;
end if;

if exists(select * from Classification where ClassificationCode = 'Part-Timer') then
   if not exists(select * from LabSurveyEmpClassificationMapping where EPEClassification = 'Part-Timer') then
      insert into LabSurveyEmpClassificationMapping(EPEClassification,MOMEmployeeClassification) values('Part-Timer','PartTime');
   end if;
end if;

commit work;

