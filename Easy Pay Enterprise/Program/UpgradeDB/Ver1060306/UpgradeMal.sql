READ UpgradeDB\Ver1060306\AllScript.sql;

Update DBA.RebateSetup Set RebateCapAmt=10000 where RebateID='Compensation' and RebateCapAmt=6000 and MalTaxPolicyProgSysId in
(Select MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyID='DefaultPolicy' and (MalTaxPolicyEffDate = '2011-01-01' or MalTaxPolicyEffDate = '2012-01-01'));

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060306, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;