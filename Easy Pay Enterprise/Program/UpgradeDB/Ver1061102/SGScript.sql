Read UpgradeDB\Ver1061102\CPF_2016Jan.sql;

if exists (select * from sys.sysprocedure where proc_name = 'DeleteA8AByPersonalSysId') then
  drop Procedure DeleteA8AByPersonalSysId
end if;
create procedure dba.DeleteA8AByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId;
    delete from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId;
    delete from A8AS2S3 where
      A8AS2S3.PersonalSysId = In_PersonalSysId;
    delete from IR21A1S4S5 where
      IR21A1S4S5.PersonalSysId = In_PersonalSysId;
    delete from A8A where
      A8A.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

if not exists (select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Standard Chartered (WEB G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Standard Chartered (WEB G3)', 'RSingBankFormatStandardCharteredG3.dll', 'InvokeSalaryFormatter', 0);
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Maybank RCMS (G3)') then
  if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Maybank (G3)') then
    insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
    values ('Salary', 'Maybank RCMS (G3)', 'RSingBankFormatMaybankG3.dll', 'InvokeSalaryFormatter', 0);
  else
    update BankSubmitFormat set FormatName = 'Maybank RCMS (G3)' where BankSubmitSubmitForId = 'Salary' and FormatName = 'Maybank (G3)';
  end if;
end if;

/* Import Designer -> A8A Section 1, 2 & 3 */
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection1') and ImportFieldPhysical = 'ResidenceValue';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection1') and ImportFieldPhysical = 'ERPaidRent';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection1') and ImportFieldPhysical = 'EEPaidRent';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection2') and ImportFieldPhysical = 'Sec2ItemsNo';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection2') and ImportFieldPhysical = 'Sec2Selection';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection2') and ImportFieldPhysical = 'Sec2Unit';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection2') and ImportFieldPhysical = 'Sec2Days';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection2') and ImportFieldPhysical = 'Sec2Value';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection3') and ImportFieldPhysical = 'Sec3No';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection3') and ImportFieldPhysical = 'Sec3NoOfPersons';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection3') and ImportFieldPhysical = 'Sec3Period';
Delete from ImportField Where WorkSheetID in (Select WorkSheetID From ImportWorkSheet Where PhysicalTableName = 'iA8ASection3') and ImportFieldPhysical = 'Sec3Value';

Delete from ImportFieldName where TableNamePhysical = 'iA8ASection1' and FieldNamePhysical = 'ResidenceValue';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection1' and FieldNamePhysical = 'ERPaidRent';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection1' and FieldNamePhysical = 'EEPaidRent';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Sec2ItemsNo';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Sec2Selection';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Sec2Unit';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Sec2Days';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Sec2Value';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'Sec3No';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'Sec3NoOfPersons';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'Sec3Period';
Delete from ImportFieldName where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'Sec3Value';

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'AnnualValue') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','AnnualValue','Annual Value','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'FurnishedStatus') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','FurnishedStatus','Fully/Partially Furnished','String',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'FurnitureFittingsValue') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','FurnitureFittingsValue','Value of Furniture & Fittings','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'RentPaidToLandlord') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','RentPaidToLandlord','Rent Paid to Landlord','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'ResidenceValue') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','ResidenceValue','Taxable Value of Place of Residence','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'RentPaidByEmployee') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','RentPaidByEmployee','Total Rent Paid by Employee','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'TotalTaxableResidenceValue') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','TotalTaxableResidenceValue','Total Taxable Value of Place of Residence','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'UtilityTelPagerValue') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','UtilityTelPagerValue','Utilities/Telephone','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'Driver') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','Driver','Driver','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'ServantGardener') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','ServantGardener','Servant/Gardener','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection2' and FieldNamePhysical = 'TotalValueofUtilities') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection2','TotalValueofUtilities','Taxable Value of Utilities and Housekeeping','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'HotelAccommodation') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection3','HotelAccommodation','Actual Hotel Accommodation','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'HotelAmtPaidByEmployee') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection3','HotelAmtPaidByEmployee','Amount Paid by Employee','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iA8ASection3' and FieldNamePhysical = 'TotalHotelAccommodation') then
   insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   values('iA8ASection3','TotalHotelAccommodation','Taxable Value of Hotel Accommodation','Numeric',0);
end if;

commit work;