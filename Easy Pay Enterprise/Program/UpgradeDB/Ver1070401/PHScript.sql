/*
  Security Setup: Add SSS (AMS-CCL) in Module Screen Group
*/
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayPhilSSSCCL') then
	INSERT INTO ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
	VALUES ('PayPhilSSSCCL','PayPhilStatutory','SSS Online (AMS-CCL)','Pay',0,1,0,'');
end if;

Insert Into UserModuleNoAccess(ModuleScreenId, UserGroupId)
Select 'PayPhilSSSCCL', UserGroup.UserGroupId
From UserGroup Left Join UserModuleNoAccess
On UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'PayPhilSSSCCL'
Where UserGroup.UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null;

commit work;