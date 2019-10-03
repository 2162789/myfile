if exists (select * from subregistry where registryid='System' and SubRegistryId='ProductName' and RegProperty1='EasyPay Standard') then
Update CPFProgression Set CPFProgPolicyId='Year2010Sep' where CPFProgCurrent = 1;
Update SubRegistry set ShortStringAttr='Year2010Sep' where RegistryId='PaySetupData' and SubRegistryId='CPFProgPolicyId';
end if;

commit work;