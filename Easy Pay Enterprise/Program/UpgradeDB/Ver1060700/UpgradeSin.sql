READ UpgradeDB\Ver1060700\AllScript.sql;

if exists(select * from licenserecord where FunctionList like '%EP Standard%') then
   update SubRegistry
   set RegProperty1 = 'Sage EasyPay Standard'
   where RegistryId = 'System' and SubRegistryId = 'ProductName';
end if;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060700, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;