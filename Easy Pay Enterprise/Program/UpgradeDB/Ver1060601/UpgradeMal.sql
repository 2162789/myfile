READ UpgradeDB\Ver1060601\AllScript.sql;
READ UpgradeDB\Ver1060601\keywordMY.sql;

UPDATE RebateSetup SET RebateCapAmt=3000 WHERE 
RebateID='Annuity'
AND MalTaxPolicyProgSysId=(SELECT MalTaxPolicyProgSysId FROM MalTaxPolicyProg WHERE MalTaxPolicyId='DefaultPolicy' AND MalSTDPolicyId='ResYear2013' AND MalTaxPolicyEffDate='2013-01-01'); 


UPDATE "DBA"."subRegistry" SET IntegerAttr=1060601, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;