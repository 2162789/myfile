UPDATE subregistry SET RegProperty3 = 'Current Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'CurrentTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Additional Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'CurrentAddTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Tax Gross Wage' where registryid='PayRecordPolicy' and SubRegistryId = 'PreviousTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Additional Tax Gross Wage' where  registryid='PayRecordPolicy' and SubRegistryId = 'PreviousAddTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'CurrentTaxWage';
UPDATE subregistry SET RegProperty3 = 'Current Additional Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'CurrentAddTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Tax Gross Wage' where registryid='PayPeriodPolicy' and SubRegistryId = 'PreviousTaxWage';
UPDATE subregistry SET RegProperty3 = 'Previous Additional Tax Gross Wage' where  registryid='PayPeriodPolicy' and SubRegistryId = 'PreviousAddTaxWage';
Update SystemAttribute Set SysUserdefinedName = 'Total Current Tax Gross Wage' where SysAttributeId='Ana_TotalCurTaxWage';
Update SystemAttribute Set SysUserdefinedName = 'Total Previous Tax Gross Wage' where SysAttributeId='Ana_TotalPrevTaxWage';

commit work;