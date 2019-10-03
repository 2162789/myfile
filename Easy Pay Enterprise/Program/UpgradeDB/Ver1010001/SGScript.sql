update YEKeyWord set YEKeyWordUserDefinedName = 'UEN-Others'
where YEKeyWordId = 'UENO'
commit work;

if (IsEPClassicDB()=1) then
    UPDATE SubRegistry SET BooleanAttr = 1 WHERE RegistryId = 'AutoEmployProcess' AND SubRegistryId = 'AutoEmpDonation';
end if;
COMMIT WORK;

if not exists (select * from "DBA"."ModuleScreenGroup" where ModuleScreenId = 'EC_CPFFWLSDFRpt')
then
delete from ModuleScreenGroup where ModuleScreenId = 'EC_CPFFWLSDFRpt'
end if;
commit work;