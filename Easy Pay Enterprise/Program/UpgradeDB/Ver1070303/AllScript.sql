Read UpgradeDB\Ver1070303\Entity.sql;
Read UpgradeDB\Ver1070303\StoredProc.sql;

if not exists (select 1 from SystemAttribute where SysTableId = 'PaymentBankInfo' and SysAttributeId = 'BeneficiaryName') then
  insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  values ('PaymentBankInfo','BeneficiaryName','Beneficiary Name',0,'','','','','')
end if;

/* Claim Type : Function As */
if not exists(select 1 from HRKeyword where HRKeywordId = 'NonMedical') then
  insert into HRKeyword(HRKeywordId,HRKeywordUserDefinedName,HRKeywordDesc,HRKeywordCategory)
  values('NonMedical','Non Medical','Non Medical','HRFunctionAs');
end if;

/* Personal Attachment Category */
Update CoreKeyWord Set CoreKeyWordDefaultName = 'Claim', CoreUserDefinedName = 'Claim', CoreKeyWordDesc = 'Claim' Where CoreKeyWordId = 'AttachMedClaim';

/* Core > Automation Process Setup */
Update SubRegistry Set RegProperty1 = 'Claim Policy' Where RegistryId = 'AutoCareerProcess' and SubRegistryId = 'AutoCareerMedClaim';
Update SubRegistry Set RegProperty1 = 'Claim Policy' Where RegistryId = 'AutoConfirmProcess' and SubRegistryId = 'AutoCfmMedClaim';
Update SubRegistry Set RegProperty1 = 'Claim Policy' Where RegistryId = 'AutoEmployProcess' and SubRegistryId = 'AutoEmpMedClaim';

/* Security Setup */
Update ModuleScreenGroup Set ModuleScreenName = 'Claim' Where ModuleScreenId = 'ImportMedicalClaim';

Update ModuleScreenGroup Set ModuleScreenName = 'Claim' Where ModuleScreenId = 'HRMedClaimSetup';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Policy' Where ModuleScreenId = 'HRMedClaimPolicy';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Type' Where ModuleScreenId = 'HRMedClaimType';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Policy Default' Where ModuleScreenId = 'HRMedClaimPolicyDef';

Update ModuleScreenGroup Set ModuleScreenName = 'Claim Modules' Where ModuleScreenId = 'HRMedicalMod';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim' Where ModuleScreenId = 'HRMedicalClaim';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Delete' Where ModuleScreenId = 'HRMedicalClaimDelete';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Save' Where ModuleScreenId = 'HRMedicalClaimSave';

Update ModuleScreenGroup Set ModuleScreenName = 'Claim Reports' Where ModuleScreenId = 'HRMedicalRpts';
Update ModuleScreenGroup Set ModuleScreenName = 'Claim Report' Where ModuleScreenId = 'HRMedClaimRpt';

/* Interface Viewer */
Update SubRegistry Set RegProperty1 = 'Claim Viewer' Where RegistryId = 'Viewer' and SubRegistryId = 'MedClaimViewer';

/* Interface > Code Setup */
Update SubRegistry Set RegProperty8 = 'Claim Reason' Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MedClaimReasonId';
Update SubRegistry Set RegProperty8 = 'Claim Type' Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MedClaimTypeId';

/* Interface > Interface Process Selection */
Update SubRegistry Set RegProperty7 = 'Claim' Where RegistryId = 'InterfaceSelection' and SubRegistryId = 'iMedClaim';

/* Import Designer > Fields */
Update ImportFieldTable Set TableNameUserDefined = 'Claim' Where TableNamePhysical = 'iMedClaim';
Update ImportFieldName Set FieldNameUserDefined = 'Receipt No' Where TableNamePhysical = 'iMedClaim' and FieldNamePhysical = 'MedClaimNo';
Update ImportFieldName Set FieldNameUserDefined = 'Claim Type' Where TableNamePhysical = 'iMedClaim' and FieldNamePhysical = 'MedClaimTypeId';

/* Core > Import Claim */
Update ImportWorkSheet Set WorkSheetName = 'Claim' Where WorkSheetID = 'System_MedicalClaim';

/* Personal Attachment Category : For record creating in EPE, Save as ID instead of Description & Set PersonalAttCreatedByEPE as 1 */
PerAttachLoop: FOR PerAttach AS DYNAMIC SCROLL CURSOR FOR    
   SELECT PersonalSysId AS OUT_PersonalSysId, PersonalAttachmentId AS OUT_PersonalAttachmentId FROM PersonalAttachment 
   WHERE PersonalAttCategory NOT IN (SELECT CoreKeyWordId From CoreKeyWord Where CoreKeyWordCategory = 'PersonalAttachment') AND PersonalAttCategory <> ''
   ORDER BY PersonalSysId
   DO 
                  UPDATE PersonalAttachment 
                  Set PersonalAttCategory = (Select CoreKeyWordId From CoreKeyWord Where CoreKeyWordDesc = PersonalAttCategory), PersonalAttCreatedByEPE = 1 
                  Where PersonalSysId = OUT_PersonalSysId AND PersonalAttachmentId = OUT_PersonalAttachmentId;
   END FOR;


/* Cost Record Export */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'CostRecordExport') then
   insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
   values ('CostRecordExport','CostAnalysisRpt','Cost Record Export','Costing',0,1,0,'');
   insert into UserModuleNoAccess (UserGroupId, ModuleScreenId)
   select UserGroup.UserGroupId, 'CostRecordExport' as ModuleScreenId from UserGroup
   left join UserModuleNoAccess on UserGroup.UserGroupId = UserModuleNoAccess.UserGroupId and UserModuleNoAccess.ModuleScreenId = 'CostRecordExport'
   where UserGroupHideWage = 1 and UserModuleNoAccess.UserGroupId is null;
end if;

commit work;