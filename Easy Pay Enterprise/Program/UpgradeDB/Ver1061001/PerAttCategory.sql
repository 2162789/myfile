if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachAwardDis') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachAwardDis','PersonalAttachment','Award/Discipline','Award/Discipline','Award/Discipline');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachBond') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachBond','PersonalAttachment','Bond','Bond','Bond');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachCourse') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachCourse','PersonalAttachment','Course','Course','Course');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachEducation') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachEducation','PersonalAttachment','Education','Education','Education');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachExitInterview') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachExitInterview','PersonalAttachment','Exit Interview','Exit Interview','Exit Interview');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachFamily') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachFamily','PersonalAttachment','Family','Family','Family');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachMedClaim') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachMedClaim','PersonalAttachment','Medical Claim','Medical Claim','Medical Claim');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachMedExaim') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachMedExaim','PersonalAttachment','Medical Exaimination','Medical Exaimination','Medical Exaimination');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachMedHistory') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachMedHistory','PersonalAttachment','Medical History','Medical History','Medical History');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachOthers') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachOthers','PersonalAttachment','Others','Others','Others');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachPersonal') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachPersonal','PersonalAttachment','Personal','Personal','Personal');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachProject') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachProject','PersonalAttachment','Project','Project','Project');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachRecruitApp') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachRecruitApp','PersonalAttachment','Recruitment Applicant','Recruitment Applicant','Recruitment Applicant');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachRecruitPos') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachRecruitPos','PersonalAttachment','Recruitment Postion','Recruitment Postion','Recruitment Postion');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachTestEvaluation') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachTestEvaluation','PersonalAttachment','Test Evaluation','Test Evaluation','Test Evaluation');
end if;

if not exists(select * from CoreKeyword where CoreKeyWordId = 'AttachTraining') then
   insert into CoreKeyword(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachTraining','PersonalAttachment','Training','Training','Training');
end if;

commit work;