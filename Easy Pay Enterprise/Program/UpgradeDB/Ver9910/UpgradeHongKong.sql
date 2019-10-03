Read upgradeDB\Ver9910\entity.sql;
Read upgradeDB\Ver9910\CommonSpecial.sql;

Read upgradeDB\Ver9910\DropStoreProcHongKong.sql;

Read upgradeDB\Ver9910\ViewTable.sql;

Read upgradeDB\Ver9910\core.sql;
Read upgradeDB\Ver9910\Pay.sql;
Read upgradeDB\Ver9910\Leave.sql;
Read upgradeDB\Ver9910\HR.sql;
Read upgradeDB\Ver9910\ReportGenerator.sql;
Read upgradeDB\Ver9910\Interface.sql;
Read upgradeDB\Ver9910\CostCentre.sql;
Read upgradeDB\Ver9910\Automation.sql;
Read upgradeDB\Ver9910\Utility.sql;
Read upgradeDB\Ver9910\Alert.sql;
Read upgradeDB\Ver9910\Analysis.sql;
Read upgradeDB\Ver9910\ExcelExport.sql;
Read upgradeDB\Ver9910\Benefit.sql;
Read upgradeDB\Ver9910\Accrual.sql;
Read upgradeDB\Ver9910\TimeSheet.sql;
Read upgradeDB\Ver9910\Transfer.sql;
Read upgradeDB\Ver9910\RptConfig.sql;

Read upgradeDB\Ver9910\Hongkong.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9910, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;