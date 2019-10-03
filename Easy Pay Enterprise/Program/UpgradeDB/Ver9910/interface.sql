create procedure DBA.ASQLInterfaceCodeMapping(
in In_InterfaceProjectID char(20),
in In_CodeTableID char(20),
in In_CodeMappingExtID char(20),
out Out_CodeMappingEPEID char(20))
begin
  select CodeMappingEPEID into Out_CodeMappingEPEID from InterfaceCodeMapping where
    InterfaceProjectID = In_InterfaceProjectID and
    CodeTableID = In_CodeTableID and
    CodeMappingExtID = In_CodeMappingExtID;
  if Out_CodeMappingEPEID is null then
    select CodeMappingEPEID into Out_CodeMappingEPEID from InterfaceCodeMapping where
      InterfaceProjectID = In_InterfaceProjectID and
      CodeTableID = In_CodeTableID and
      CodeMappingExtID = '???';
    if Out_CodeMappingEPEID is null then
      set Out_CodeMappingEPEID=In_CodeMappingExtID
    end if
  end if
end
;

create procedure dba.ASQLUpdateImportFieldNameLabel()
begin
  declare EmpCode1_Id char(100);
  declare EmpCode2_Id char(100);
  declare EmpCode3_Id char(100);
  declare EmpCode4_Id char(100);
  declare EmpCode5_Id char(100);
  declare EmpLocation1_Id char(100);
  declare CustBoolean1_Id char(100);
  declare CustBoolean2_Id char(100);
  declare CustBoolean3_Id char(100);
  declare CustDate1_Id char(100);
  declare CustDate2_Id char(100);
  declare CustDate3_Id char(100);
  declare CustInteger1_Id char(100);
  declare CustInteger2_Id char(100);
  declare CustInteger3_Id char(100);
  declare CustNumeric1_Id char(100);
  declare CustNumeric2_Id char(100);
  declare CustNumeric3_Id char(100);
  declare CustString1_Id char(100);
  declare CustString2_Id char(100);
  declare CustString3_Id char(100);
  declare CustString4_Id char(100);
  declare CustString5_Id char(100);
  declare CasRecordBasis char(100);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  select NewLName into CustBoolean1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean1';
  select NewLName into CustBoolean2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean2';
  select NewLName into CustBoolean3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean3';
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustNumeric1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric1';
  select NewLName into CustNumeric2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric2';
  select NewLName into CustNumeric3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric3';
  select NewLName into CustString1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString1';
  select NewLName into CustString2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString2';
  select NewLName into CustString3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString3';
  select NewLName into CustString4_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString4';
  select NewLName into CustString5_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString5';
  select RegProperty8 into CasRecordBasis from SubRegistry where RegistryId = 'InterfaceCodeTable' and
    RegProperty1 = 'Casual Pay Process' and
    RegProperty2 = 
    any(select RegProperty1 from SubRegistry where RegistryId = 'MapAutomationBasis' and
      SubRegistryId = 'MapCasualBasis');
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iCasRecord' and FieldNamePhysical = 'CasualRecBasis') then
    update ImportFieldName set FieldNameUserDefined = CasRecordBasis where
      TableNamePhysical = 'iCasRecord' and FieldNamePhysical = 'CasualRecBasis'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode1Id') then
    update ImportFieldName set FieldNameUserDefined = EmpCode1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode1Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode2Id') then
    update ImportFieldName set FieldNameUserDefined = EmpCode2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode2Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode3Id') then
    update ImportFieldName set FieldNameUserDefined = EmpCode3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode3Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode4Id') then
    update ImportFieldName set FieldNameUserDefined = EmpCode4_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode4Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode5Id') then
    update ImportFieldName set FieldNameUserDefined = EmpCode5_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpCode5Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpLocation1Id') then
    update ImportFieldName set FieldNameUserDefined = EmpLocation1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'EmpLocation1Id'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean1') then
    update ImportFieldName set FieldNameUserDefined = CustBoolean1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean1'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean2') then
    update ImportFieldName set FieldNameUserDefined = CustBoolean2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean2'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean3') then
    update ImportFieldName set FieldNameUserDefined = CustBoolean3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustBoolean3'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate1') then
    update ImportFieldName set FieldNameUserDefined = CustDate1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate1'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate2') then
    update ImportFieldName set FieldNameUserDefined = CustDate2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate2'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate3') then
    update ImportFieldName set FieldNameUserDefined = CustDate3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustDate3'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger1') then
    update ImportFieldName set FieldNameUserDefined = CustInteger1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger1'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger2') then
    update ImportFieldName set FieldNameUserDefined = CustInteger2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger2'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger3') then
    update ImportFieldName set FieldNameUserDefined = CustInteger3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustInteger3'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric1') then
    update ImportFieldName set FieldNameUserDefined = CustNumeric1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric1'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric2') then
    update ImportFieldName set FieldNameUserDefined = CustNumeric2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric2'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric3') then
    update ImportFieldName set FieldNameUserDefined = CustNumeric3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustNumeric3'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString1') then
    update ImportFieldName set FieldNameUserDefined = CustString1_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString1'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString2') then
    update ImportFieldName set FieldNameUserDefined = CustString2_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString2'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString3') then
    update ImportFieldName set FieldNameUserDefined = CustString3_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString3'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString4') then
    update ImportFieldName set FieldNameUserDefined = CustString4_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString4'
  end if;
  if exists(select* from ImportFieldName where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString5') then
    update ImportFieldName set FieldNameUserDefined = CustString5_Id where
      TableNamePhysical = 'iEmployee' and FieldNamePhysical = 'CustString5'
  end if;
  commit work
end
;

create procedure dba.ASQLUpdateInterfaceAttributeList(
in In_InterfaceProjectID char(20))
begin
  if exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    // Inserts the Attribute one by one
    InterfaceAttributeLoop: for InterfaceAttributeForLoop as Cur_InterfaceAttribute dynamic scroll cursor for
      select SubRegistryID as New_InterfaceAttributeID,
        RegProperty7 as New_InterfacePhysicalAttr,
        RegProperty1 as New_InterfaceAttrTableID,
        RegProperty8 as InterfaceAttrLabel from
        Subregistry where
        RegistryID = 'InterfaceAttribute' do
      if(InterfaceAttrLabel <> '') then
        call InsertNewInterfaceAttribute(
        In_InterfaceProjectID,
        New_InterfaceAttributeID,
        New_InterfaceAttrTableID,1,
        New_InterfacePhysicalAttr)
      else
        call DeleteInterfaceAttribute(In_InterfaceProjectID,
        New_InterfaceAttributeID,
        New_InterfaceAttrTableID)
      end if end for;
    commit work
  end if
end
;

create procedure dba.ASQLUpdateInterfaceAttributeMappingLabel()
begin
  declare EmpCode1_Id char(100);
  declare EmpCode2_Id char(100);
  declare EmpCode3_Id char(100);
  declare EmpCode4_Id char(100);
  declare EmpCode5_Id char(100);
  declare EmpLocation1_Id char(100);
  declare CustBoolean1_Id char(100);
  declare CustBoolean2_Id char(100);
  declare CustBoolean3_Id char(100);
  declare CustDate1_Id char(100);
  declare CustDate2_Id char(100);
  declare CustDate3_Id char(100);
  declare CustInteger1_Id char(100);
  declare CustInteger2_Id char(100);
  declare CustInteger3_Id char(100);
  declare CustNumeric1_Id char(100);
  declare CustNumeric2_Id char(100);
  declare CustNumeric3_Id char(100);
  declare CustString1_Id char(100);
  declare CustString2_Id char(100);
  declare CustString3_Id char(100);
  declare CustString4_Id char(100);
  declare CustString5_Id char(100);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  select NewLName into CustBoolean1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean1';
  select NewLName into CustBoolean2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean2';
  select NewLName into CustBoolean3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean3';
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustNumeric1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric1';
  select NewLName into CustNumeric2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric2';
  select NewLName into CustNumeric3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric3';
  select NewLName into CustString1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString1';
  select NewLName into CustString2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString2';
  select NewLName into CustString3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString3';
  select NewLName into CustString4_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString4';
  select NewLName into CustString5_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString5';
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode1Id') then
    update SubRegistry set RegProperty8 = EmpCode1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode2Id') then
    update SubRegistry set RegProperty8 = EmpCode2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode3Id') then
    update SubRegistry set RegProperty8 = EmpCode3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode4Id') then
    update SubRegistry set RegProperty8 = EmpCode4_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode5Id') then
    update SubRegistry set RegProperty8 = EmpCode5_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpCode5Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpLocation1Id') then
    update SubRegistry set RegProperty8 = EmpLocation1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'EmpLocation1Id'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean1') then
    update SubRegistry set RegProperty8 = CustBoolean1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean2') then
    update SubRegistry set RegProperty8 = CustBoolean2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean3') then
    update SubRegistry set RegProperty8 = CustBoolean3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustBoolean3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate1') then
    update SubRegistry set RegProperty8 = CustDate1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate2') then
    update SubRegistry set RegProperty8 = CustDate2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate3') then
    update SubRegistry set RegProperty8 = CustDate3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustDate3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger1') then
    update SubRegistry set RegProperty8 = CustInteger1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger2') then
    update SubRegistry set RegProperty8 = CustInteger2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger3') then
    update SubRegistry set RegProperty8 = CustInteger3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustInteger3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric1') then
    update SubRegistry set RegProperty8 = CustNumeric1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric2') then
    update SubRegistry set RegProperty8 = CustNumeric2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric3') then
    update SubRegistry set RegProperty8 = CustNumeric3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustNumeric3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString1') then
    update SubRegistry set RegProperty8 = CustString1_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString2') then
    update SubRegistry set RegProperty8 = CustString2_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString3') then
    update SubRegistry set RegProperty8 = CustString3_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString4') then
    update SubRegistry set RegProperty8 = CustString4_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString4'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString5') then
    update SubRegistry set RegProperty8 = CustString5_Id where
      RegistryID = 'InterfaceAttribute' and SubRegistryId = 'CustString5'
  end if;
  commit work
end
;

create procedure dba.ASQLUpdateInterfaceCodeMappingLabel()
begin
  declare EmpCode1_Id char(100);
  declare EmpCode2_Id char(100);
  declare EmpCode3_Id char(100);
  declare EmpCode4_Id char(100);
  declare EmpCode5_Id char(100);
  declare EmpLocation1_Id char(100);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode1') then
    update SubRegistry set RegProperty8 = EmpCode1_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode2') then
    update SubRegistry set RegProperty8 = EmpCode2_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode3') then
    update SubRegistry set RegProperty8 = EmpCode3_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode4') then
    update SubRegistry set RegProperty8 = EmpCode4_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode4'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode5') then
    update SubRegistry set RegProperty8 = EmpCode5_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpCode5'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpLocation1') then
    update SubRegistry set RegProperty8 = EmpLocation1_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Employment Process' and SubRegistryID = 'EmpLocation1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode1') then
    update SubRegistry set RegProperty8 = EmpCode1_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode1'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode2') then
    update SubRegistry set RegProperty8 = EmpCode2_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode2'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode3') then
    update SubRegistry set RegProperty8 = EmpCode3_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode3'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode4') then
    update SubRegistry set RegProperty8 = EmpCode4_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode4'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode5') then
    update SubRegistry set RegProperty8 = EmpCode5_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomCode5'
  end if;
  if exists(select* from SubRegistry where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomLocation') then
    update SubRegistry set RegProperty8 = EmpLocation1_Id where
      RegistryID = 'InterfaceCodeTable' and RegProperty1 = 'Casual Pay Process' and SubRegistryID = 'CasCustomLocation'
  end if;
  commit work
end
;

create procedure dba.DeleteInterfaceAttribute(
in In_InterfaceProjectID char(20),
in In_InterfaceAttributeID char(20),
in In_InterfaceAttrTableID char(20))
begin
  if exists(select* from InterfaceAttribute where
      InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceAttribute.InterfaceAttributeID = In_InterfaceAttributeID and
      InterfaceAttribute.InterfaceAttrTableID = In_InterfaceAttrTableID) then
    delete from InterfaceAttribute where
      InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceAttribute.InterfaceAttributeID = In_InterfaceAttributeID and
      InterfaceAttribute.InterfaceAttrTableID = In_InterfaceAttrTableID;
    commit work
  end if
end
;

create procedure dba.DeleteInterfaceCodeMapping(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20),
in In_CodeMappingExtID char(50))
begin
  if exists(select* from InterfaceCodeMapping where
      InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeMapping.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeMapping.CodeTableID = In_CodeTableID and
      InterfaceCodeMapping.CodeMappingExtID = In_CodeMappingExtID) then
    delete from InterfaceCodeMapping where
      InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeMapping.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeMapping.CodeTableID = In_CodeTableID and
      InterfaceCodeMapping.CodeMappingExtID = In_CodeMappingExtID;
    commit work
  end if
end
;

create procedure dba.DeleteInterfaceCodeTable(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20))
begin
  if exists(select* from InterfaceCodeTable where
      InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeTable.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeTable.CodeTableID = In_CodeTableID) then
    delete from InterfaceCodeTable where
      InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeTable.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeTable.CodeTableID = In_CodeTableID;
    commit work
  end if
end
;

create procedure dba.DeleteInterfaceProcess(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20))
begin
  if exists(select* from InterfaceProcess where
      InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceProcess.InterfaceProcessID = In_InterfaceProcessID) then
    delete from InterfaceProcess where
      InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceProcess.InterfaceProcessID = In_InterfaceProcessID;
    commit work
  end if
end
;

create procedure dba.DeleteInterfaceProject(
in In_InterfaceProjectID char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) and DeleteDefault('InterfaceProject',In_InterfaceProjectID) = 1 then
    if not exists(select* from CustomIntConfigItem where CustomIntConfigItemId = 'InterfaceId' and ConfigItemShortString = In_InterfaceProjectID) then
      delete from InterfaceCodeMapping where
        InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID;
      delete from InterfaceCodeTable where
        InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID;
      delete from InterfaceProcess where
        InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID;
      delete from InterfaceAttribute where
        InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID;
      delete from InterfaceProject where
        InterfaceProject.InterfaceProjectID = In_InterfaceProjectID;
      commit work;
      if exists(select* from InterfaceProject where InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteScreenDesigner(
in In_ScreenDesignerId char(20))
begin
  if exists(select* from ScreenProperty where
      ScreenProperty.ScreenDesignerId = In_ScreenDesignerId) then
    delete from ScreenProperty where
      ScreenProperty.ScreenDesignerId = In_ScreenDesignerId;
    commit work
  end if;
  if exists(select* from ScreenItem where
      ScreenItem.ScreenDesignerId = In_ScreenDesignerId) then
    delete from ScreenItem where
      ScreenItem.ScreenDesignerId = In_ScreenDesignerId;
    commit work
  end if;
  if exists(select* from ScreenLayout where
      ScreenLayout.ScreenDesignerId = In_ScreenDesignerId) then
    delete from ScreenLayout where
      ScreenLayout.ScreenDesignerId = In_ScreenDesignerId;
    commit work
  end if;
  if exists(select* from ScreenDesigner where
      ScreenDesigner.ScreenDesignerId = In_ScreenDesignerId) then
    delete from ScreenDesigner where
      ScreenDesigner.ScreenDesignerId = In_ScreenDesignerId;
    commit work
  end if
end
;

create procedure dba.DeleteScreenProject(
in In_ScreenProjectId char(20))
begin
  if exists(select* from ScreenProjectMember where
      ScreenProjectMember.ScreenProjectId = In_ScreenProjectId) then
    delete from ScreenProjectMember where
      ScreenProjectMember.ScreenProjectId = In_ScreenProjectId;
    commit work
  end if;
  if exists(select* from ScreenProject where
      ScreenProject.ScreenProjectId = In_ScreenProjectId) then
    delete from ScreenProject where
      ScreenProject.ScreenProjectId = In_ScreenProjectId;
    commit work
  end if
end
;

create procedure dba.InsertNewInterfaceAttribute(
in In_InterfaceProjectID char(20),
in In_InterfaceAttributeID char(20),
in In_InterfaceAttrTableID char(20),
in In_InterfaceAttrUse smallint,
in In_InterfacePhysicalAttr char(100))
begin
  if not exists(select* from InterfaceAttribute where
      InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceAttribute.InterfaceAttributeID = In_InterfaceAttributeID and
      InterfaceAttribute.InterfaceAttrTableID = In_InterfaceAttrTableID) then
    insert into InterfaceAttribute(InterfaceProjectID,
      InterfaceAttributeID,
      InterfaceAttrTableID,
      InterfaceAttrUse,
      InterfacePhysicalAttr) values(
      In_InterfaceProjectID,
      In_InterfaceAttributeID,
      In_InterfaceAttrTableID,
      In_InterfaceAttrUse,
      In_InterfacePhysicalAttr);
    commit work
  end if
end
;

create procedure dba.InsertNewInterfaceCodeMapping(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20),
in In_CodeMappingExtID char(50),
in In_CodeMappingEPEID char(20))
begin
  if not exists(select* from InterfaceCodeMapping where
      InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeMapping.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeMapping.CodeTableID = In_CodeTableID and
      InterfaceCodeMapping.CodeMappingExtID = In_CodeMappingExtID) then
    insert into InterfaceCodeMapping(InterfaceProjectID,
      InterfaceProcessID,
      CodeTableID,
      CodeMappingExtID,
      CodeMappingEPEID) values(
      In_InterfaceProjectID,
      In_InterfaceProcessID,
      In_CodeTableID,
      In_CodeMappingExtID,
      In_CodeMappingEPEID);
    commit work
  end if
end
;

create procedure dba.InsertNewInterfaceCodeTable(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20),
in In_CodeSQLStatement char(200),
in In_CodeSkipMapping smallint,
in In_CodeUseExternal smallint,
in In_CodeExternalSQL char(200))
begin
  if not exists(select* from InterfaceCodeTable where
      InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeTable.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeTable.CodeTableID = In_CodeTableID) then
    insert into InterfaceCodeTable(InterfaceProjectID,
      InterfaceProcessID,
      CodeTableID,
      CodeSQLStatement,
      CodeSkipMapping,
      CodeUseExternal,
      CodeExternalSQL) values(
      In_InterfaceProjectID,
      In_InterfaceProcessID,
      In_CodeTableID,
      In_CodeSQLStatement,
      In_CodeSkipMapping,
      In_CodeUseExternal,
      In_CodeExternalSQL);
    commit work
  end if
end
;

create procedure dba.InsertNewInterfaceProcess(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_InterfaceConnectionID char(20),
in In_IntProcExtConnection smallint,
in In_IntProcActivate smallint,
in In_IntProcRemarks char(100))
begin
  if not exists(select* from InterfaceProcess where
      InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceProcess.InterfaceProcessID = In_InterfaceProcessID) then
    insert into InterfaceProcess(InterfaceProjectID,
      InterfaceProcessID,
      InterfaceConnectionID,
      IntProcExtConnection,
      IntProcActivate,
      IntProcRemarks) values(
      In_InterfaceProjectID,
      In_InterfaceProcessID,
      In_InterfaceConnectionID,
      In_IntProcExtConnection,
      In_IntProcActivate,
      In_IntProcRemarks);
    // Inserts the   CodeTableID one by one
    CodeTableLoop: for CodeTableForLoop as Cur_CodeTable dynamic scroll cursor for
      select SubRegistryID as New_CodeTableID from
        Subregistry where
        RegistryID = 'InterfaceCodeTable' and
        RegProperty1 = In_InterfaceProcessID do
      call InsertNewInterfaceCodeTable(
      In_InterfaceProjectID,
      In_InterfaceProcessID,
      New_CodeTableID,'',
      1,
      0,'') end for;
    // Inserts the   CodeTableID one by one
    InterfaceAttributeLoop: for InterfaceAttributeForLoop as Cur_InterfaceAttribute dynamic scroll cursor for
      select SubRegistryID as New_InterfaceAttributeID,
        RegProperty7 as New_InterfacePhysicalAttr,
        RegProperty1 as New_InterfaceAttrTableID from
        Subregistry where
        RegistryID = 'InterfaceAttribute' and
        RegProperty8 <> '' do
      call InsertNewInterfaceAttribute(
      In_InterfaceProjectID,
      New_InterfaceAttributeID,
      New_InterfaceAttrTableID,1,
      New_InterfacePhysicalAttr) end for;
    commit work
  end if
end
;

create procedure dba.InsertNewInterfaceProject(
in In_InterfaceProjectID char(20),
in In_InterfaceProjRemarks char(100))
begin
  if not exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    insert into InterfaceProject(InterfaceProjectID,InterfaceProjRemarks) values(In_InterfaceProjectID,In_InterfaceProjRemarks);
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'OT Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Shift Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Employment Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Pay Element Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Leave Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Lve Summary Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'HR Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Daily Hourly Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Income Tax Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Casual Pay Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'YTD Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Time Sheet Detail',null,0,0,'');
    commit work
  end if
end
;

create procedure dba.InsertNewScreenDesign(
in In_ScreenDesignerId char(20),
in In_ScreenDesignTemplateId char(20),
in In_ScreenDesignLastChange timestamp)
begin
  if not exists(select* from ScreenDesigner where ScreenDesigner.ScreenDesignerId = In_ScreenDesignerId) then
    insert into ScreenDesigner(ScreenDesignerId,
      ScreenDesignTemplateId,
      ScreenDesignLastChange) values(
      In_ScreenDesignerId,
      In_ScreenDesignTemplateId,
      In_ScreenDesignLastChange);
    commit work
  end if;
  ScreenItemLoop: for InsertScreenItem as ProcessInsertScreenItem dynamic scroll cursor for
    select ScnTmpUserItemId,
      ScnTmpObjectName,
      HasItem as ScnTmpHasItem from
      ScnTmpItem where ScnTmpId = In_ScreenDesignTemplateId order by ScnTmpId asc,ScnTmpUserItemId asc do
    insert into ScreenItem(ScreenDesignerId,
      ScreenUserItemId,
      ScreenObjectName,
      HasItem) values(
      In_ScreenDesignerId,
      ScnTmpUserItemId,
      ScnTmpObjectName,
      ScnTmpHasItem) end for;
  commit work;
  ScreenPropertyLoop: for InsertScreenProperty as ProcessInsertScreenProperty dynamic scroll cursor for
    select scntmpUserItemId,
      scntmpUserPropertyId,
      scntmpOrder,
      DateValue as scntmpDateValue,
      BooleanValue as scntmpBooleanValue,
      IntegerValue as scntmpIntegerValue,
      NumericValue as scntmpNumericValue,
      StringValue as scntmpStringValue from
      scntmpProperty where ScnTmpId = In_ScreenDesignTemplateId order by
      ScnTmpId asc,ScnTmpUserItemId asc,ScnTmpUserPropertyId asc,ScnTmpOrder asc do
    insert into ScreenProperty(ScreenDesignerId,
      ScreenUserItemId,
      ScreenUserPropertyId,
      ScreenUserOrder,
      DateValue,
      BooleanValue,
      IntegerValue,
      NumericValue,
      StringValue) values(In_ScreenDesignerId,
      scntmpUserItemId,
      scntmpUserPropertyId,
      scntmpOrder,
      scntmpDateValue,
      scntmpBooleanValue,
      scntmpIntegerValue,
      scntmpNumericValue,
      scntmpStringValue) end for;
  commit work;
  ScreenLayoutLoop: for InsertScreenLayout as ProcessInsertScreenLayout dynamic scroll cursor for
    select ScnTmpLayoutObjectName as LayoutName from ScnTmpLayout where ScnTmpId = In_ScreenDesignTemplateId order by ScnTmpLayoutObjectName asc do
    insert into ScreenLayout(ScreenDesignerId,
      LayoutObjectName) values(In_ScreenDesignerId,
      LayoutName) end for;
  commit work
end
;

create procedure dba.UpdateInterfaceAttribute(
in In_InterfaceProjectID char(20),
in In_InterfaceAttributeID char(20),
in In_InterfaceAttrTableID char(20),
in In_InterfaceAttrUse smallint,
in In_InterfacePhysicalAttr char(100))
begin
  if exists(select* from InterfaceAttribute where
      InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceAttribute.InterfaceAttributeID = In_InterfaceAttributeID and
      InterfaceAttribute.InterfaceAttrTableID = In_InterfaceAttrTableID) then
    update InterfaceAttribute set
      InterfaceAttrUse = In_InterfaceAttrUse,
      InterfacePhysicalAttr = In_InterfacePhysicalAttr where
      InterfaceAttribute.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceAttribute.InterfaceAttributeID = In_InterfaceAttributeID and
      InterfaceAttribute.InterfaceAttrTableID = In_InterfaceAttrTableID;
    commit work
  end if
end
;

create procedure dba.UpdateInterfaceCodeMapping(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20),
in In_CodeMappingExtID char(50),
in In_CodeMappingEPEID char(20))
begin
  if exists(select* from InterfaceCodeMapping where
      InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeMapping.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeMapping.CodeTableID = In_CodeTableID and
      InterfaceCodeMapping.CodeMappingExtID = In_CodeMappingExtID) then
    update InterfaceCodeMapping set
      CodeMappingEPEID = In_CodeMappingEPEID where
      InterfaceCodeMapping.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeMapping.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeMapping.CodeTableID = In_CodeTableID and
      InterfaceCodeMapping.CodeMappingExtID = In_CodeMappingExtID;
    commit work
  end if
end
;

create procedure dba.UpdateInterfaceCodeTable(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_CodeTableID char(20),
in In_CodeSQLStatement char(200),
in In_CodeSkipMapping smallint,
in In_CodeUseExternal smallint,
in In_CodeExternalSQL char(200))
begin
  if exists(select* from InterfaceCodeTable where
      InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeTable.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeTable.CodeTableID = In_CodeTableID) then
    update InterfaceCodeTable set
      CodeSQLStatement = In_CodeSQLStatement,
      CodeSkipMapping = In_CodeSkipMapping,
      CodeUseExternal = In_CodeUseExternal,
      CodeExternalSQL = In_CodeExternalSQL where
      InterfaceCodeTable.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceCodeTable.InterfaceProcessID = In_InterfaceProcessID and
      InterfaceCodeTable.CodeTableID = In_CodeTableID;
    commit work
  end if
end
;

create procedure dba.UpdateInterfaceProcess(
in In_InterfaceProjectID char(20),
in In_InterfaceProcessID char(20),
in In_InterfaceConnectionID char(20),
in In_IntProcExtConnection smallint,
in In_IntProcActivate smallint,
in In_IntProcRemarks char(100))
begin
  if exists(select* from InterfaceProcess where
      InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceProcess.InterfaceProcessID = In_InterfaceProcessID) then
    update InterfaceProcess set
      InterfaceConnectionID = In_InterfaceConnectionID,
      IntProcActivate = In_IntProcActivate,
      IntProcExtConnection = In_IntProcExtConnection,
      IntProcRemarks = In_IntProcRemarks where
      InterfaceProcess.InterfaceProjectID = In_InterfaceProjectID and
      InterfaceProcess.InterfaceProcessID = In_InterfaceProcessID;
    commit work
  end if
end
;

create procedure dba.UpdateInterfaceProject(
in In_InterfaceProjectID char(20),
in In_InterfaceProjRemarks char(100))
begin
  if exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    update InterfaceProject set
      InterfaceProject.InterfaceProjRemarks = In_InterfaceProjRemarks where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID;
    commit work
  end if
end
;

create procedure dba.UpdateScreenDesignItemsOrder(
in In_ScreenDesignerId char(20),
in In_ScreenUserItemId char(50))
begin
  declare ItemOrder integer;
  set ItemOrder=0;
  ItemOrderLoop: for SortItemOrder as ProcessSortItemOrder dynamic scroll cursor for
    select* from ScreenProperty where ScreenDesignerId = In_ScreenDesignerId and
      ScreenUserItemId = In_ScreenUserItemId and ScreenUserPropertyId = 'Items' order by ScreenUserOrder asc do
    set ItemOrder=ItemOrder+1;
    update ScreenProperty set
      ScreenUserOrder = ItemOrder where current of ProcessSortItemOrder end for;
  commit work
end
;

create procedure dba.UpdateScrProjMemberSequence(
in In_ScreenProjectId char(20))
begin
  declare ProjectSequence integer;
  set ProjectSequence=0;
  ProjectSequenceLoop: for SortProjectSequence as ProcessSortProjectSequence dynamic scroll cursor for
    select* from ScreenProjectMember where ScreenProjectId = In_ScreenProjectId order by ProcessSequence asc do
    set ProjectSequence=ProjectSequence+1;
    update ScreenProjectMember set
      ProcessSequence = ProjectSequence where current of ProcessSortProjectSequence end for;
  commit work
end
;

create procedure DBA.DeleteCustomIntConfig(
in In_CustomIntConfigId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CustomIntConfig where CustomIntConfig.CustomIntConfigId = In_CustomIntConfigId) then
    if exists(select* from CustomIntConfigItem where CustomIntConfigItem.CustomIntConfigId = In_CustomIntConfigId) then
      delete from CustomIntConfigItem where CustomIntConfigItem.CustomIntConfigId = In_CustomIntConfigId;
      commit work
    end if;
    delete from CustomIntConfig where CustomIntConfigId = In_CustomIntConfigId;
    commit work;
    if exists(select* from CustomIntConfig where CustomIntConfigId = In_CustomIntConfigId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.DeleteCustomIntConfigItem(
in In_CustomIntConfigId char(20),
in In_CustomIntConfigItemId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from CustomIntConfigItem where CustomIntConfigId = In_CustomIntConfigId and
      CustomIntConfigItemId = In_CustomIntConfigItemId) then
    delete from CustomIntConfigItem where
      CustomIntConfigId = In_CustomIntConfigId and
      CustomIntConfigItemId = In_CustomIntConfigItemId;
    commit work;
    if exists(select* from CustomIntConfigItem where CustomIntConfigId = In_CustomIntConfigId and
        CustomIntConfigItemId = In_CustomIntConfigItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewCustomIntConfig(
in In_CustomIntConfigId char(20),
in In_CustomIntConfigDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from CustomIntConfig where CustomIntConfigId = In_CustomIntConfigId) then
    insert into CustomIntConfig(CustomIntConfigId,CustomIntConfigDesc) values(In_CustomIntConfigId,In_CustomIntConfigDesc);
    commit work;
    if not exists(select* from CustomIntConfig where CustomIntConfigId = In_CustomIntConfigId) then
      set Out_ErrorCode=0
    else
      CustomIntConfigItemLoop: for CustomIntConfigItemFor as curs dynamic scroll cursor for
        select SubRegistryId as In_CustomIntConfigItemId,
          RegProperty1 as In_ConfigItemType,
          RegProperty2 as In_ConfigItemLabel,
          RegProperty3 as In_ConfigItemDataType,
          RegProperty4 as In_ConfigItemMandatory,
          RegProperty5 as In_ConfigItemOrder,
          RegProperty6 as In_ConfigItemField,
          RegProperty7 as In_ConfigItemSQL,
          RegProperty8 as In_ConfigItemSelected1,
          RegProperty9 as In_ConfigItemSelected2,
          DoubleAttr as In_ConfigItemDouble,
          IntegerAttr as In_ConfigItemInteger,
          BooleanAttr as In_ConfigItemBoolean,
          ShortStringAttr as In_ConfigItemShortString,
          StringAttr as In_ConfigItemString,
          DateAttr as In_ConfigItemDate from
          SubRegistry where RegistryId = 'CustomIntConfigItem' do
        call InsertNewCustomIntConfigItem(
        In_CustomIntConfigId,
        In_CustomIntConfigItemId,
        In_ConfigItemType,
        In_ConfigItemLabel,
        In_ConfigItemDataType,
        In_ConfigItemMandatory,
        In_ConfigItemOrder,
        In_ConfigItemField,
        In_ConfigItemSQL,
        In_ConfigItemSelected1,
        In_ConfigItemSelected2,
        In_ConfigItemDouble,
        In_ConfigItemInteger,
        In_ConfigItemBoolean,
        In_ConfigItemShortString,
        In_ConfigItemString,
        In_ConfigItemDate) end for;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.InsertNewCustomIntConfigItem(
in In_CustomIntConfigId char(20),
in In_CustomIntConfigItemId char(20),
in In_ConfigItemType char(100),
in In_ConfigItemLabel char(100),
in In_ConfigItemDataType char(100),
in In_ConfigItemMandatory char(100),
in In_ConfigItemOrder char(100),
in In_ConfigItemField char(200),
in In_ConfigItemSQL char(200),
in In_ConfigItemSelected1 char(200),
in In_ConfigItemSelected2 char(200),
in In_ConfigItemDouble double,
in In_ConfigItemInteger integer,
in In_ConfigItemBoolean smallint,
in In_ConfigItemShortString char(20),
in In_ConfigItemString char(255),
in In_ConfigItemDate date,
out Out_ErrorCode integer)
begin
  if not exists(select* from CustomIntConfigItem where CustomIntConfigId = In_CustomIntConfigId and
      CustomIntConfigItemId = In_CustomIntConfigItemId) then
    insert into CustomIntConfigItem(CustomIntConfigId,
      CustomIntConfigItemId,
      ConfigItemType,
      ConfigItemLabel,
      ConfigItemDataType,
      ConfigItemMandatory,
      ConfigItemOrder,
      ConfigItemField,
      ConfigItemSQL,
      ConfigItemSelected1,
      ConfigItemSelected2,
      ConfigItemDouble,
      ConfigItemInteger,
      ConfigItemBoolean,
      ConfigItemShortString,
      ConfigItemString,
      ConfigItemDate) values(
      In_CustomIntConfigId,
      In_CustomIntConfigItemId,
      In_ConfigItemType,
      In_ConfigItemLabel,
      In_ConfigItemDataType,
      In_ConfigItemMandatory,
      In_ConfigItemOrder,
      In_ConfigItemField,
      In_ConfigItemSQL,
      In_ConfigItemSelected1,
      In_ConfigItemSelected2,
      In_ConfigItemDouble,
      In_ConfigItemInteger,
      In_ConfigItemBoolean,
      In_ConfigItemShortString,
      In_ConfigItemString,
      In_ConfigItemDate);
    commit work;
    if not exists(select* from CustomIntConfigItem where CustomIntConfigId = In_CustomIntConfigId and
        CustomIntConfigItemId = In_CustomIntConfigItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateCustomIntConfig(
in In_CustomIntConfigId char(20),
in In_CustomIntConfigDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from CustomIntConfig where CustomIntConfigId = In_CustomIntConfigId) then
    update CustomIntConfig set
      CustomIntConfigDesc = In_CustomIntConfigDesc where
      CustomIntConfigId = In_CustomIntConfigId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.UpdateCustomIntConfigItem(
in In_CustomIntConfigId char(20),
in In_CustomIntConfigItemId char(20),
in In_ConfigItemType char(100),
in In_ConfigItemLabel char(100),
in In_ConfigItemDataType char(100),
in In_ConfigItemMandatory char(100),
in In_ConfigItemOrder char(100),
in In_ConfigItemField char(200),
in In_ConfigItemSQL char(200),
in In_ConfigItemSelected1 char(200),
in In_ConfigItemSelected2 char(200),
in In_ConfigItemDouble double,
in In_ConfigItemInteger integer,
in In_ConfigItemBoolean smallint,
in In_ConfigItemShortString char(20),
in In_ConfigItemString char(255),
in In_ConfigItemDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from CustomIntConfigItem where CustomIntConfigId = In_CustomIntConfigId and
      CustomIntConfigItemId = In_CustomIntConfigItemId) then
    update CustomIntConfigItem set
      ConfigItemType = In_ConfigItemType,
      ConfigItemLabel = In_ConfigItemLabel,
      ConfigItemDataType = In_ConfigItemDataType,
      ConfigItemMandatory = In_ConfigItemMandatory,
      ConfigItemOrder = In_ConfigItemOrder,
      ConfigItemField = In_ConfigItemField,
      ConfigItemSQL = In_ConfigItemSQL,
      ConfigItemSelected1 = In_ConfigItemSelected1,
      ConfigItemSelected2 = In_ConfigItemSelected2,
      ConfigItemDouble = In_ConfigItemDouble,
      ConfigItemInteger = In_ConfigItemInteger,
      ConfigItemBoolean = In_ConfigItemBoolean,
      ConfigItemShortString = In_ConfigItemShortString,
      ConfigItemString = In_ConfigItemString,
      ConfigItemDate = In_ConfigItemDate where
      CustomIntConfigId = In_CustomIntConfigId and
      CustomIntConfigItemId = In_CustomIntConfigItemId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;