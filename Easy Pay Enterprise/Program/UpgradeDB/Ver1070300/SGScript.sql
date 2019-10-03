/* Hide Wage from Screen for Leave Childcare Form 1*/
Update ModuleScreenGroup Set HideScreenForWage = 1 Where ModuleScreenId = 'LvGCL1Rpt';

Insert Into UserModuleNoAccess(ModuleScreenId, UserGroupId)
Select 'LvGCL1Rpt', UserGroup.UserGroupId
From UserGroup Left Join UserModuleNoAccess
On UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'LvGCL1Rpt'
Where UserGroup.UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null;

commit work;