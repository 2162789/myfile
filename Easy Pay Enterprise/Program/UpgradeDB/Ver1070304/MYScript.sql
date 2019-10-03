update RebateItem set RebateDesc = 'Payment Of Alimony To Former Wife' where RebateID = 'Alimony';
update RebateItem set RebateDesc = 'Employer''s own goods (free / discounted)' where RebateID = 'Employer Goods';
update RebateItem set RebateDesc = 'Employer''s own services (free / discounted)' where RebateID = 'Employer Service';
update RebateItem set RebateDesc = 'Petrol Card / Petrol Allowance / Travel Allowance (Home - Work)' where RebateID = 'Petrol Non Official';

/* Process Flow -> EIS Submission */
IF not exists(select * from Keyword where KeyWordId = 'EISSubmission') then 
  INSERT INTO Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup) 
  VALUES ('EISSubmission','InvokeEISSubmission','EIS Submission','Submissions',0,0,0,'RMalGovForm.dll',6,1,0,'');
end if;

Update Keyword Set KeyWordSubCategory = 7 Where KeyWordId = 'Socso2/3'; 
Update Keyword Set KeyWordSubCategory = 8 Where KeyWordId = 'CP39'; 
Update Keyword Set KeyWordSubCategory = 9 Where KeyWordId = 'CP22'; 
Update Keyword Set KeyWordSubCategory = 10 Where KeyWordId = 'CP21'; 
Update Keyword Set KeyWordSubCategory = 11 Where KeyWordId = 'TabungHaji'; 
Update Keyword Set KeyWordSubCategory = 12 Where KeyWordId = 'ASB'; 
Update Keyword Set KeyWordSubCategory = 13 Where KeyWordId = 'HRDF'; 

/* Security Setup > EIS Submission */
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayEISSubmission') then 
   insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
   values('PayEISSubmission','PayMalGovForm','EIS Submission','Pay',0,1,0,'');
end if;

Insert Into UserModuleNoAccess(ModuleScreenId, UserGroupId)
Select 'PayEISSubmission', UserGroup.UserGroupId
From UserGroup Left Join UserModuleNoAccess
On UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'PayEISSubmission'
Where UserGroup.UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null;

commit work;