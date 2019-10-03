
/* Add Rebate Item for BIK Perquisites*/
if not exists(select * from RebateItem where RebateID = 'Perquisites') then
  Insert into RebateItem (RebateID,RebateDesc,RebateERApproval,RebateProperty)
  Values('Perquisites','Perquisites (BIK)',1,'MalBIKPerquisites');
end if;

/* Insert New Rebate Item  for BIK Perquisites into Tax Policy Progression for default policy of 2016*/
if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy2016') then
   drop PROCEDURE PatchMalaysiaTaxPolicy2016
end if;


CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy2016"()
begin
  declare In_MalTaxPolicyProgSysId integer;

  /* Get Tax Policy Progression ID  for Default Policy for 2016 */
  SELECT MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyEffDate = '2016-01-01' and MalTaxPolicyId = 'DefaultPolicy';

  if (In_MalTaxPolicyProgSysId>0) then
    IF NOT EXISTS(SELECT * FROM RebateSetup WHERE MalTaxPolicyProgSysId=In_MalTaxPolicyProgSysId AND RebateId = 'Perquisites') THEN
        insert into RebateSetup values(In_MalTaxPolicyProgSysId,'Perquisites',0,1,0);
    end if;
  end if;
  commit work;

end;

call dba.PatchMalaysiaTaxPolicy2016();
drop procedure dba.PatchMalaysiaTaxPolicy2016;

/* Add BIK Property for Perquisites*/
IF NOT EXISTS(SELECT * FROM Subregistry WHERE RegistryId='MalBIKProperty' AND SubregistryId = 'MalBIKPerquisites') THEN
 INSERT INTO Subregistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2) VALUES('MalBIKProperty','MalBIKPerquisites','Perquisites','Rebate');
END IF;

/* Relace existing erquisites code with newly created property */
Update MalBIKItem SET MalBIKPropertyId='MalBIKPerquisites' WHERE MalBIKPropertyId='PerquisitesCode';

Delete SubRegistry Where RegistryId='MalBIKProperty' AND SubregistryId = 'PerquisitesCode'

commit work;