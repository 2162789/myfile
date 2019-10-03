/* Personal Attachment Category */
if not exists(select * from CoreKeyWord where CoreKeyWordId = 'AttachLeave') then
   insert into CoreKeyWord(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('AttachLeave','PersonalAttachment','Leave','Leave','Leave');
end if;

/* Security Setup > Update Medical Claim Viewer to Claim Viewer */
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Viewer' Where ModuleScreenId = 'MedClaimViewer';

commit work;