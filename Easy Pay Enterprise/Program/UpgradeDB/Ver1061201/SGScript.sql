/* MedisaveScheme */
if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMedisaveScheme') then
   drop procedure InsertNewMedisaveScheme;
end if;
create PROCEDURE DBA.InsertNewMedisaveScheme(
in In_MedisaveSchemeId char(20),
in In_MedisaveSchemeDesc char(100),
out Out_ErrorCode integer)
BEGIN
	if not exists(select * from MedisaveScheme Where MedisaveSchemeId = In_MedisaveSchemeId) then
        insert into MedisaveScheme(MedisaveSchemeId, MedisaveSchemeDesc)
        values(In_MedisaveSchemeId,In_MedisaveSchemeDesc);
        commit work;
        set Out_ErrorCode = 1; 
    else
      set Out_ErrorCode = 0;                          
    end if;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMedisaveScheme') then
   drop procedure UpdateMedisaveScheme;
end if;
create PROCEDURE DBA.UpdateMedisaveScheme(
in In_MedisaveSchemeId char(20),
in In_MedisaveSchemeDesc char(100),
out Out_ErrorCode integer)
BEGIN
	if exists(select * from MedisaveScheme where MedisaveSchemeId = In_MedisaveSchemeId) then
       update MedisaveScheme set MedisaveSchemeDesc = In_MedisaveSchemeDesc
       where MedisaveSchemeId = In_MedisaveSchemeId;
       commit work;
       set Out_ErrorCode = 1;
    else
       set Out_ErrorCode = 0;
    end if;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteMedisaveScheme') then
   drop procedure DeleteMedisaveScheme;
end if;
create PROCEDURE "DBA"."DeleteMedisaveScheme"(
in In_MedisaveSchemeId char(20),
out Out_ErrorCode integer)
BEGIN
	if exists(select * from MedisaveScheme where MedisaveSchemeId = In_MedisaveSchemeId) then
         delete from MedisaveProgression where MedisaveSchemeId = In_MedisaveSchemeId;
         delete from MedisaveScheme where MedisaveSchemeId = In_MedisaveSchemeId;
         commit work;
         set Out_ErrorCode = 1;  
    else
         set Out_ErrorCode = 0;
    end if; 
END;

/* MedisaveProgression */
if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMedisaveProgression') then
   drop procedure InsertNewMedisaveProgression;
end if;
create procedure DBA.InsertNewMedisaveProgression(
in In_MedisaveSchemeId char(20),
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMinOrdContri double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
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
          MedisaveRemarks) values(
          In_MedisaveSchemeId,
          In_MedisaveEffectiveDate,
          In_MedisaveTotalWageCapping,
          In_MedisaveContriRate,
          In_MedisaveMinOrdContri,
          In_MedisaveMaxOrdContri,
          In_MedisaveMaxAddContri,
          In_MedisaveRemarks);
          commit work
      end if;
  end if;
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMedisaveProgression') then
   drop procedure UpdateMedisaveProgression;
end if;
create procedure DBA.UpdateMedisaveProgression(
in In_MedisaveSchemeId char(20),
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMinOrdContri double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
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
      MedisaveRemarks = In_MedisaveRemarks where
      MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteMedisaveProgression') then
   drop procedure DeleteMedisaveProgression;
end if;
create procedure DBA.DeleteMedisaveProgression(
in In_MedisaveSchemeId char(20),
in In_MedisaveEffectiveDate date)
begin
  declare CtrCurrent integer;
  declare EmpSysId integer;
  declare CtrStartDate date;
  if exists(select* from MedisaveProgression where
      MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
      MedisaveProgression.MedisaveEffectiveDate = In_MedisaveEffectiveDate) then
    delete from MedisaveProgression where
      MedisaveProgression.MedisaveSchemeId = In_MedisaveSchemeId and
      MedisaveProgression.MedisaveEffectiveDate = In_MedisaveEffectiveDate;
    commit work
  end if
end
;

/* Default Data for the first time */
if not exists(select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'MedisaveSchemeId') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PaySetupData','MedisaveSchemeId','Combo','Medisave Scheme','ShortStringAttr','N','MedisaveScheme','MedisaveSchemeId','Select * from MedisaveScheme Order By MedisaveSchemeId','MedisaveSchemeId	20	Medisave Scheme	F','MedisaveSchemeDesc	80	Description	F','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  if exists(select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'MedisavePaidByER' and BooleanAttr = 1) and exists(select * from MedisaveScheme where MedisaveSchemeId = 'Scheme 1') then
      update SubRegistry set ShortStringAttr = 'Scheme 1' where RegistryId = 'PaySetupData' and SubRegistryId = 'MedisaveSchemeId';
  end if; 
end if;

commit work;