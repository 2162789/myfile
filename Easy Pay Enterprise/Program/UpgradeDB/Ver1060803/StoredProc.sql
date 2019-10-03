/* ============================================================ */
/*   View: View_TMS_AllowanceId                      */
/* ============================================================ */ 
if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_AllowanceID') then
Alter VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc, FormulaType, (IF (SELECT 1 FROM FormulaProperty WHERE FormulaId=Formula.FormulaId and KeywordId = 'GRPCode') IS NULL THEN 0 ELSE 1 ENDIF) AS IsGRPCode 
FROM Formula WHERE FormulaSubCategory='Allowance' AND FormulaActive=1
else
create VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc, FormulaType, (IF (SELECT 1 FROM FormulaProperty WHERE FormulaId=Formula.FormulaId and KeywordId = 'GRPCode') IS NULL THEN 0 ELSE 1 ENDIF) AS IsGRPCode 
FROM Formula WHERE FormulaSubCategory='Allowance' AND FormulaActive=1
end if;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLProcessUpdateLabelName') then
  drop procedure ASQLProcessUpdateLabelName;
end if;

create procedure dba.ASQLProcessUpdateLabelName()
begin
  call ASQLUpdateCareerSubregistry();
  call ASQLUpdateImportFieldNameLabel();
  call ASQLUpdateInterfaceAttributeMappingLabel();
  call ASQLUpdateInterfaceCodeMappingLabel();
  call ASQLUpdateCostBasisSubregistry();
  call ASQLUpdateRPayElementBasisSubregistry();
  call ASQLUpdateItemBasisSubregistry();
  call ASQLUpdateOTBasisSubregistry();
  call ASQLUpdateShiftBasisSubregistry();
  call ASQLUpdateGovtProgBasisSubregistry();
  call ASQLUpdateMClaimBasisSubregistry();
  call ASQLUpdateLeaveBasisSubregistry();
  call ASQLUpdateHRBasisSubregistry();
  call ASQLUpdateEmployeeSystemAttribute();
  call ASQLUpdatePayBasisAnlysKeyword();
  call ASQLUpdateAccrualBasisKeyword();
  call ASQLUpdatePayKeyword();
  call ASQLUpdateCEBasisSubregistry();
  call ASQLUpdateLeaveKeyword();
  call ASQLUpdateInterCorpBasisSubregistry();
  call ASQLUpdateAuditTrialBasisSubregistry();
  call ASQLUpdateAnlysSystemAttribute();
  call ASQLUpdateLabourSurveyBasis();
  commit work
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateLabourSurveyBasis') then
  drop procedure ASQLUpdateLabourSurveyBasis;
end if;

create PROCEDURE DBA.ASQLUpdateLabourSurveyBasis()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  // Update for Job Position Basis
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'LabSurveyPosBasis' and SubRegistryId = 'EmpCode5Id'
  end if;

  // Update for Classification Basis
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'LabSurveyClaBasis' and SubRegistryId = 'EmpCode5Id'
  end if;
  commit work
end;

commit work;