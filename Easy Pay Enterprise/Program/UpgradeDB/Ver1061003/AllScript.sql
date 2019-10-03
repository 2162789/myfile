/* ============================================================ */
/*   View: View_TMS_SystemInfo                                  */
/* ============================================================ */
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_SystemInfo')
then 
   ALTER VIEW "DBA"."View_TMS_SystemInfo"
   AS
   SELECT SubRegistryId AS FieldName, CAST(IntegerAttr AS CHAR(7)) AS FieldValue FROM SubRegistry WHERE SubRegistryId='DBVersion'
   UNION
   SELECT SubRegistryId, RegProperty1 FROM SubRegistry WHERE SubRegistryId='DBCountry'
   UNION
   SELECT 'LicenseExpiryDate', StrKey2 FROM LicenseRecord;
else
   CREATE VIEW "DBA"."View_TMS_SystemInfo"
   AS
   SELECT SubRegistryId AS FieldName, CAST(IntegerAttr AS CHAR(7)) AS FieldValue FROM SubRegistry WHERE SubRegistryId='DBVersion'
   UNION
   SELECT SubRegistryId, RegProperty1 FROM SubRegistry WHERE SubRegistryId='DBCountry'
   UNION
   SELECT 'LicenseExpiryDate', StrKey2 FROM LicenseRecord;
end if;   

if not exists(select * from Subregistry where SubRegistryId = 'TMSViewLabelName') then
 Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1) values ('SageProdIntegrate','TMSViewSystemInfo','View_TMS_SystemInfo');
end if;

commit work;