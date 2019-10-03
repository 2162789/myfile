/*LabSurveyKeyWord */
if not exists(select * from LabSurveyKeyWord where KeywordId = 'ManagerProf') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('ManagerProf','Managers and professionals','JobPosition');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'AssManagerProf') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('AssManagerProf','Associate professionals and technicians','JobPosition');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Production') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Production','Production & transport operators, tradesmen, cleaners and labourers','JobPosition');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'ClericalSaleService') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('ClericalSaleService','Clerical, sales and service workers','JobPosition');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Resignations') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Resignations','Resignations','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'ExpiryOfContracts') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('ExpiryOfContracts','Expiry of contracts','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Retirements') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Retirements','Retirements','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'EarlyRelOfContracts') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('EarlyRelOfContracts','Early release of contract','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'TransferToSubsidiary') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('TransferToSubsidiary','Transfer to subsidiaries/associate establishments','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Others') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Others','Others (including death)','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Retrenchments') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Retrenchments','Retrenchments','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Dismissals') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Dismissals','Dismissals','CessationCode');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'FullTime') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('FullTime','Full-time Employees','EmployeeClassification');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'PartTime') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('PartTime','Part-time Employees','EmployeeClassification');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Local') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Local','Singapore Citizens','ResidenceStatus');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'PR') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('PR','Permanent Residents (PRs)','ResidenceStatus');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'Foreigners') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('Foreigners','Foreigners','ResidenceStatus');
end if;

if not exists(select * from LabSurveyKeyWord where KeywordId = 'LocalPR') then
   insert into LabSurveyKeyWord(KeywordId,KeyWordDesc,KeyWordCategory)
   values('LocalPR','Singapore Citizens & PRs','ResidenceStatus');
end if;


/* LabSurveyResidenceStatusMapping */
if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '1') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(1,'EP','Foreigners');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '2') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(2,'FW','Foreigners');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '3') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(3,'PR2','PR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '4') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(4,'Local','Local');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '5') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(5,'Others','Foreigners');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '6') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(6,'PR1','PR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '7') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(7,'PR3','PR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '8') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(8,'PR1','LocalPR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '9') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(9,'PR2','LocalPR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '10') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(10,'PR3','LocalPR');
end if;

if not exists(select * from LabSurveyResidenceStatusMapping where LabourSurveyResidenceStatusId = '11') then
   insert into LabSurveyResidenceStatusMapping(LabourSurveyResidenceStatusId,EPEResidenceStatus,MOMResidenceStatus)
   values(11,'Local','LocalPR');
end if;

commit work;

