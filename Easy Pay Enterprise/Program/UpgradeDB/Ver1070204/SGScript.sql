if not exists (select 1 from sys.syscolumns where cname = 'MediSaveMaxContriCapping' and tname = 'MedisaveProgression') then
  alter table MedisaveProgression add MediSaveMaxContriCapping double DEFAULT 0 NOT NULL;
end if;

if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewMedisaveProgression') then
  drop Procedure InsertNewMedisaveProgression;
end if;

CREATE PROCEDURE "DBA"."InsertNewMedisaveProgression"(
in In_MedisaveSchemeId char(20),
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMinOrdContri double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
in In_MediSaveMaxContriCapping double,
in In_MedisaveRemarks char(255))
begin
  if exists(select * from MedisaveScheme where MedisaveSchemeId = In_MedisaveSchemeId) then
      if not exists(select* from MedisaveProgression where
          MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
          MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate) then
      insert into MedisaveProgression(MedisaveSchemeId,
          MedisaveEffectiveDate,
          MedisaveTotalWageCapping,
          MedisaveContriRate,
          MedisaveMinOrdContri,
          MedisaveMaxOrdContri,
          MedisaveMaxAddContri,
          MediSaveMaxContriCapping,
          MedisaveRemarks) values(
          In_MedisaveSchemeId,
          In_MedisaveEffectiveDate,
          In_MedisaveTotalWageCapping,
          In_MedisaveContriRate,
          In_MedisaveMinOrdContri,
          In_MedisaveMaxOrdContri,
          In_MedisaveMaxAddContri,
          In_MediSaveMaxContriCapping, 
          In_MedisaveRemarks);
          commit work
      end if;
  end if;
end;


if exists (select 1 from sys.sysprocedure where proc_name = 'UpdateMedisaveProgression') then
  drop Procedure UpdateMedisaveProgression;
end if;

CREATE PROCEDURE "DBA"."UpdateMedisaveProgression"(
in In_MedisaveSchemeId char(20),
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMinOrdContri double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
In_MediSaveMaxContriCapping double,
in In_MedisaveRemarks char(255))
begin
  if exists(select* from MedisaveProgression where
      MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate) then
    update MedisaveProgression set
      MedisaveEffectiveDate = In_MedisaveEffectiveDate,
      MedisaveTotalWageCapping = In_MedisaveTotalWageCapping,
      MedisaveContriRate = In_MedisaveContriRate,
      MedisaveMinOrdContri = In_MedisaveMinOrdContri,
      MedisaveMaxOrdContri = In_MedisaveMaxOrdContri,
      MedisaveMaxAddContri = In_MedisaveMaxAddContri,
      MediSaveMaxContriCapping = In_MediSaveMaxContriCapping,  
      MedisaveRemarks = In_MedisaveRemarks where
      MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate;
    commit work
  end if;
end;


if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBalMedisave') then
  drop Procedure ASQLCalPayPeriodBalMedisave;
end if;

CREATE PROCEDURE "DBA"."ASQLCalPayPeriodBalMedisave"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PeriodMediSaveOrdinary double,
out Out_PeriodMediSaveAdditional double,
out Out_YTDMediSaveAdditional double,
out Out_YTDMediSaveOrdinary double)
begin
  declare Tmp_MediSaveOrdinary double;
  declare Tmp_MediSaveAdditional double;
  /*
  Get accumulated contributions for the period excluding current record
  */
  select FConvertNull(sum(CurrentTaxAmount)) into Out_PeriodMediSaveOrdinary from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  select FConvertNull(sum(PreviousTaxAmount)) into Out_PeriodMediSaveAdditional from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  /*
  Get accumulated additional contribution for the year excluding current record
  */
  select FConvertNull(sum(PreviousTaxAmount)),FConvertNull(sum(CurrentTaxAmount)) into Out_YTDMediSaveAdditional,
    Out_YTDMediSaveOrdinary from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod <= In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  /*
  Get the specified Record
  */
  select FConvertNull(sum(CurrentTaxAmount)),FConvertNull(sum(PreviousTaxAmount)) into Tmp_MediSaveOrdinary,
    Tmp_MediSaveAdditional from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Deduct away from the specified
  */
  set Out_PeriodMediSaveOrdinary=Out_PeriodMediSaveOrdinary-Tmp_MediSaveOrdinary;
  set Out_PeriodMediSaveAdditional=Out_PeriodMediSaveAdditional-Tmp_MediSaveAdditional;
  set Out_YTDMediSaveAdditional=Out_YTDMediSaveAdditional-Tmp_MediSaveAdditional;
  set Out_YTDMediSaveOrdinary=Out_YTDMediSaveOrdinary-Tmp_MediSaveOrdinary;
end;


commit work;