/* Table : IndoTaxEmployer */
if exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoTaxERTaxRefNo') then
    alter table DBA.IndoTaxEmployer Alter IndoTaxERTaxRefNo char(35);
end if;

if exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoTaxAuthoriseTaxRefNo') then
    alter table DBA.IndoTaxEmployer Alter IndoTaxAuthoriseTaxRefNo char(35);
end if;

if exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='TelephoneNo') then
    alter table DBA.IndoTaxEmployer Alter TelephoneNo char(30);
end if;

if exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='RegistrationNo') then
    alter table DBA.IndoTaxEmployer Alter RegistrationNo char(35);
end if;

/* ============================================================ */
/*   View: View_TMS_LabelName                      */
/* ============================================================ */
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_LabelName')
then 
  alter VIEW "DBA"."View_TMS_LabelName"
     AS
     SELECT TableName, AttributeName, NewLName AS LabelName FROM LabelName WHERE TableName like 'EmpCode%' or TableName like 'EmpLocation%'
else
  create VIEW "DBA"."View_TMS_LabelName"
     AS
     SELECT TableName, AttributeName, NewLName AS LabelName FROM LabelName WHERE TableName like 'EmpCode%' or TableName like 'EmpLocation%'
end if;   

if exists(select * from sys.sysprocedure where proc_name = 'ASQLDeleteEmployeeProgression') then
    drop procedure ASQLDeleteEmployeeProgression
end if;

create procedure DBA.ASQLDeleteEmployeeProgression(
in In_EmployeeSysId integer)
begin
  //
  //    Delete Policy Progression
  //    
  call DeletePolicyProgression(In_EmployeeSysId);
  //
  //    Delete Basic Rate Progression
  //  
  call DeleteBasicRateProgression(In_EmployeeSysId);
  //
  //    Delete CPF Progression
  //  
  call DeleteCPFProgression(In_EmployeeSysId);
  //
  //    Delete EPF, SOCSO Progression
  //
  if FGetDBCountry(*) = 'Malaysia' then
    call DeleteEPFProgression(In_EmployeeSysId);
    call DeleteSOCSOProgression(In_EmployeeSysId)
  end if;
  //
  //    Delete Mandatory Contribution Progression
  //
  if FGetDBCountry(*) = 'Philippines' or FGetDBCountry(*) = 'Indonesia' then
    DeleteMandatoryContributeProgressionLoop: for MandatoryContributeProgressionFor as MandatoryContributeProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete VnC45 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC45Loop: for VnC45For as VnC45curs dynamic scroll cursor for
      select VnC45SGSPGenId as In_VnC45SGSPGenId from VnC45Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC45Record(In_VnC45SGSPGenId) end for
  end if;
  //
  //    Delete VnC47 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47Loop: for VnC47For as VnC47curs dynamic scroll cursor for
      select VnC47SGSPGenId as In_VnC47SGSPGenId from VnC47Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47Record(In_VnC47SGSPGenId) end for
  end if;
  //
  //    Delete VnC04 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC04Loop: for VnC04For as VnC04curs dynamic scroll cursor for
      select VnC04SGSPGenId as In_VnC04SGSPGenId from VnC04Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC04Record(In_VnC04SGSPGenId) end for
  end if;
  //
  //    Delete VnC47a Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47aLoop: for VnC47aFor as VnC47acurs dynamic scroll cursor for
      select VnC47aSGSPGenId as In_VnC47aSGSPGenId from VnC47aRecord where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47aRecord(In_VnC47aSGSPGenId) end for
  end if;
  //
  //    Delete SI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteSIProgressionLoop: for SIProgressionFor as SIProgressioncurs dynamic scroll cursor for
      select SIProgSysId as In_SIProgSysId from SIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteSIProgression(In_SIProgSysId) end for
  end if;
  //
  //    Delete HI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteHIProgressionLoop: for HIProgressionFor as HIProgressioncurs dynamic scroll cursor for
      select HIProgSysId as In_HIProgSysId from HIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteHIProgression(In_HIProgSysId) end for
  end if;
  //
  //    Delete MPF Progression
  //
  if FGetDBCountry(*) = 'HongKong' then
    DeleteMPFProgressionLoop: for MPFProgressionFor as MPFProgressioncurs dynamic scroll cursor for
      select MPFProgSysId as In_MPFProgSysId from MPFProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMPFProgression(In_MPFProgSysId) end for
  end if;
  //
  //Delete Mandatory Contribution
  //
  if FGetDBCountry(*) = 'Thailand' or FGetDBCountry(*) = 'Brunei' then
    DeletePFSSProgressionLoop: for PFSSProgressionFor as PFSSProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete Career Progression
  //
  DeleteCareerProgressionLoop: for CareerProgressionFor as CareerProgressioncurs dynamic scroll cursor for
    select CareerEffectiveDate as In_CareerEffectiveDate from CareerProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteCareerProgression(In_EmployeeSysId,In_CareerEffectiveDate) end for;
  //
  //    Delete Contract Progression
  //
  DeleteContractProgressionLoop: for ContractProgressionFor as ContractProgressioncurs dynamic scroll cursor for
    select ContractStartDate as In_ContractStartDate from ContractProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteContractProgression(In_EmployeeSysId,In_ContractStartDate) end for;
  //
  // Delete FWL Progression
  //
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  //
  // Delete EP Progression
  //
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  commit work
end
;

commit work;