if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteRptConfigEmail') then
   drop procedure DeleteRptConfigEmail
end if
;

CREATE PROCEDURE DBA.DeleteRptConfigEmail(in In_PersonalSysId integer)
begin
  if exists(select* from RptConfigEmail where
      RptConfigEmail.PersonalSysId = In_PersonalSysId) then
    delete from RptConfigEmail where
      RptConfigEmail.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end;

commit work;

IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'CoreBankAllocDelete') THEN
  INSERT INTO ModuleScreenGroup VALUES ('CoreBankAllocDelete','CoreEmployment','Delete Bank Allocation','Core',0,0,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'CoreBankAllocSave') THEN
  INSERT INTO ModuleScreenGroup VALUES ('CoreBankAllocSave','CoreEmployment','Save Bank Allocation','Core',0,0,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'HRMedicalClaimDelete') THEN
  INSERT INTO ModuleScreenGroup VALUES ('HRMedicalClaimDelete','HRMedicalClaim','Medical Claim Delete','HR',0,0,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'HRMedicalClaimSave') THEN
  INSERT INTO ModuleScreenGroup VALUES ('HRMedicalClaimSave','HRMedicalClaim','Medical Claim Save','HR',0,0,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'HRItemIssuedDelete') THEN
  INSERT INTO ModuleScreenGroup VALUES ('HRItemIssuedDelete','HRItemIssued','Item Issued Delete','HR',0,0,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM ModuleScreenGroup WHERE ModuleScreenId = 'HRItemIssuedSave') THEN
  INSERT INTO ModuleScreenGroup VALUES ('HRItemIssuedSave','HRItemIssued','Item Issued Save','HR',0,0,0,'')
END IF;

IF NOT EXISTS (SELECT * FROM GeneralBlob WHERE GeneralBlobId = 'LaserPayslipLH') THEN
  INSERT INTO GeneralBlob VALUES ('LaserPayslipLH','')
END IF;

commit work;

Update UsageGrp Set UsageGrpDesc='Statutory Submission' where UsageGrpID='StatSubmit';

if not exists(select 1 from UsageGrp where UsageGrpID='StatutoryInfo') then
insert into UsageGrp values('StatutoryInfo','Statutory Information');
end if;
commit work;

Update ModuleScreenGroup set ModuleScreenName='Delete Employment' where ModuleScreenId='CoreEmployDelete';

commit work;