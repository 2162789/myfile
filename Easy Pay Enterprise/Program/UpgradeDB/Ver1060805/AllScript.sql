
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'AttachmentStorage') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('AttachmentStorage','Control','Attachment Storage Configuration','Control',0,0,0,'');
end if;

Delete FROM SubRegistry where RegistryId = 'TMS Vendor' and SubRegistryId IN ('TMSViewPayRecID','TMSViewOTRate','TMSViewAllowanceID'
,'TMSViewLeaveType','TMSViewHolidays','TMSViewJobCode');

commit work;