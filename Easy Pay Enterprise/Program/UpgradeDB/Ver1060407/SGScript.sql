READ UpgradeDB\Ver1060407\UsageItem_SG.sql;

Update subregistry set RegProperty1 = 'Income d)2' where registryid = 'PayElementProperty' and subregistryid = 'CommissionCode';
Update subregistry set RegProperty1 = 'Income d)3' where registryid = 'PayElementProperty' and subregistryid = 'PensionCode';
Update subregistry set RegProperty1 = 'Income d)1' where registryid = 'PayElementProperty' and subregistryid = 'TransportCode';
Update subregistry set RegProperty1 = 'Income d)1' where registryid = 'PayElementProperty' and subregistryid = 'EntertainmentCode';

commit work;