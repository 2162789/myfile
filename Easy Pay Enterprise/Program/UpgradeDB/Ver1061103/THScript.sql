--YTD Interface Viewer
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDAllowRecViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDAllowRecViewer','YTD Pay Element Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDGeneralViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDGeneralViewer','YTD General Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDLveDedRecViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDLveDedRecViewer','YTD Leave Deduction Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDOTRecordViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDOTRecordViewer','YTD OT Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDTHPolicyViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDTHPolicyViewer','YTD Policy Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'YTDShiftRecordViewer') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('Viewer','YTDShiftRecordViewer','YTD Shift Record','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

--YTD Import Setup Tables
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDGeneral') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDGeneral','YTD General');
end if;
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDTHPolicy') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDTHPolicy','YTD Policy');
end if;
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDAllowanceRecord') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDAllowanceRecord','YTD Pay Element Record');
end if;
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDOTRecord') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDOTRecord','YTD OT Record');
end if;
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDShiftRecord') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDShiftRecord','YTD Shift Record');
end if;
if not exists (select 1 from ImportFieldTable where TableNamePhysical = 'iYTDLeaveDeductionRecord') then
  insert into ImportFieldTable (TableNamePhysical, TableNameUserDefined) values ('iYTDLeaveDeductionRecord','YTD Leave Deduction Record');
end if;

--YTD Import Setup Fields
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'YTDEmployeeId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','YTDEmployeeId','Employee ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'YTDYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','YTDYear','Year','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'YTDStartPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','YTDStartPeriod','Start Period','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'YTDEndPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','YTDEndPeriod','End Period','Integer',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'BasicRateType') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','BasicRateType','Basic Rate Type','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'AllocatedBasicRate') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','AllocatedBasicRate','Basic Rate','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'AllocatedMVC') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','AllocatedMVC','MVC','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'AllocatedNWC') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','AllocatedNWC','NWC','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'BackPay') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','BackPay','Back Pay','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'CurrentHrDay') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','CurrentHrDay','Current Hours/Days','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'BefAdjHrDay') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','BefAdjHrDay','Before Adjustment Hours/Days','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'BackPayHrDay') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','BackPayHrDay','Back Pay Hours/Days','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'SickLeaveTaken') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','SickLeaveTaken','Sick Leave Taken','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'AnnualLeaveTaken') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','AnnualLeaveTaken','Annual Leave Taken','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'OTAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','OTAmount','OT Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'OTBackPayAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','OTBackPayAmount','OT Back Pay Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'ShiftAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','ShiftAmount','Shift Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'LeaveDeductionAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','LeaveDeductionAmount','Leave Deduction Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeNumeric1') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeNumeric1','Free Numeric 1','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeNumeric2') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeNumeric2','Free Numeric 2','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeNumeric3') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeNumeric3','Free Numeric 3','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeNumeric4') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeNumeric4','Free Numeric 4','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeNumeric5') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeNumeric5','Free Numeric 5','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeString1') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeString1','Free String 1','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeString2') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeString2','Free String 2','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeString3') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeString3','Free String 3','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeString4') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeString4','Free String 4','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDGeneral' and FieldNamePhysical = 'FreeString5') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDGeneral','FreeString5','Free String 5','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceEmployeeID') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceEmployeeID','Employee ID','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'PayRecYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','PayRecYear','Year','Integer',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'PayRecPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','PayRecPeriod','Period','Integer',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceID') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceID','Pay Element ID','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceAmount','Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceRemarks') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceRemarks','Remarks','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceDeclaredDate') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceDeclaredDate','Declared Date','Date',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDAllowanceRecord' and FieldNamePhysical = 'AllowanceRecurFormulaId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDAllowanceRecord','AllowanceRecurFormulaId','Recurring Formula ID','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'YTDOTEmployeeId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','YTDOTEmployeeId','Employee ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'YTDOTYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','YTDOTYear','Year','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'YTDOTPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','YTDOTPeriod','Period','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'YTDOTId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','YTDOTId','OT Rate ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'CurrentOTFreq') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','CurrentOTFreq','Current Frequency','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'LastOTFreq') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','LastOTFreq','Last Frequency','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'BackPayOTFreq') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','BackPayOTFreq','Back Pay Frequency','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'CurrentOTAmt') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','CurrentOTAmt','Current Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'LastOTAmt') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','LastOTAmt','Last Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDOTRecord' and FieldNamePhysical = 'BackPayOTAmt') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDOTRecord','BackPayOTAmt','Back Pay Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'YTDShiftEmployeeId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','YTDShiftEmployeeId','Employee ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'YTDShiftYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','YTDShiftYear','Year','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'YTDShiftPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','YTDShiftPeriod','Period','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'YTDShiftId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','YTDShiftId','Shift Rate ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'ShiftFrequency') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','ShiftFrequency','Frequency','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDShiftRecord' and FieldNamePhysical = 'ShiftAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDShiftRecord','ShiftAmount','Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'YTDLveDedEmployeeId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','YTDLveDedEmployeeId','Employee ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'YTDLveDedYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','YTDLveDedYear','Year','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'YTDLveDedPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','YTDLveDedPeriod','Period','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'YTDLveTypeFunctCode') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','YTDLveTypeFunctCode','Leave Type Function Code','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'CurrentLveDays') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','CurrentLveDays','Current Days','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'CurrentLveHours') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','CurrentLveHours','Current Hours','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'PreviousLveIncDays') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','PreviousLveIncDays','Last Days','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'PreviousLveIncHours') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','PreviousLveIncHours','Last Hours','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDLeaveDeductionRecord' and FieldNamePhysical = 'LveAmount') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDLeaveDeductionRecord','LveAmount','Amount','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'YTDTHPolicyEmployeeId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','YTDTHPolicyEmployeeId','Employee ID','String',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'YTDTHPolicyYear') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','YTDTHPolicyYear','Year','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'YTDTHPolicyPeriod') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','YTDTHPolicyPeriod','Period','Integer',1);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'SSEE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','SSEE','Employee Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'SSER') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','SSER','Employer Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF1EE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF1EE','PF1 Employee Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF1ERNormal') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF1ERNormal','PF1 Employer Normal Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF1ERSpecial') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF1ERSpecial','PF1 Employer Special Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF2EE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF2EE','PF2 Employee Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF2ERNormal') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF2ERNormal','PF2 Employer Normal Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF2ERSpecial') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF2ERSpecial','PF2 Employer Special Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF3EE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF3EE','PF3 Employee Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF3ERNormal') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF3ERNormal','PF3 Employer Normal Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF3ERSpecial') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF3ERSpecial','PF3 Employer Special Contribution','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF4EE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF4EE','PF4 Employee Contribution','String',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF4ERNormal') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF4ERNormal','PF4 Employer Normal Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF4ERSpecial') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF4ERSpecial','PF4 Employer Special Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF5EE') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF5EE','PF5 Employee Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF5ERNormal') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF5ERNormal','PF5 Employer Normal Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PF5ERSpecial') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PF5ERSpecial','PF5 Employer Special Contribution','Numeric',0);
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iYTDTHPolicy' and FieldNamePhysical = 'PaidTaxAmt') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey) values ('iYTDTHPolicy','PaidTaxAmt','Paid Tax Amt','Numeric',0);
end if;

--YTD Process Interface
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceSelection' and SubRegistryId = 'iYTDGeneral') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceSelection','iYTDGeneral','YTD Process','','','','','','YTD Entry','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceProcess' and SubRegistryId = 'YTD Process') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceProcess','YTD Process','YTDProcess.rtf','','','','','','','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDBasicRateType') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDBasicRateType','YTD Process','','','','','','SELECT KEYWORDID AS EPEID, KeyWordUserDefinedName AS EPEIDDesc FROM Keyword WHERE KeywordCategory = ''Basic Rate Type''','Basic Rate Type','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDAllowanceId') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDAllowanceId','YTD Process','','','','','','SELECT FormulaId AS EPEID, FormulaDesc AS EPEIDDesc FROM Formula WHERE FormulaCategory = ''PayElement''','Pay Element ID','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDOTId') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDOTId','YTD Process','','','','','','SELECT FormulaId AS EPEID, FormulaDesc AS EPEIDDesc FROM Formula WHERE FormulaCategory = ''OT''','OT ID','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDShiftId') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDShiftId','YTD Process','','','','','','SELECT FormulaId AS EPEID, FormulaDesc AS EPEIDDesc FROM Formula WHERE FormulaCategory = ''Shift''','Shift ID','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDLveTypeFunctCode') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDLveTypeFunctCode','YTD Process','','','','','','SELECT KeyWordId AS EPEID, KeyWordUserDefinedName AS EPEIDDesc FROM KeyWord WHERE KeyWordCategory = ''Leave'' AND KeyWordID NOT IN (''Annual'',''Sick'')','Leave Type Function Code','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDAllowanceRecurFor') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceCodeTable','YTDAllowanceRecurFor','YTD Process','','','','','','SELECT FormulaId AS EPEID, FormulaDesc as EPEIDDesc FROM Formula WHERE FormulaCategory = ''PayElement'' AND FormulaRecurring = 1','Pay Element Recurring Formula ID','','','','','','','','','1899-12-30','1899-12-30 00:00:00');
end if;

--YTD Module Screen
if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'EC_YTDAllowRecViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDAllowRecViewer','EC_InterfaceViewer','YTD Pay Element Record Viewer','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_YTDGeneralViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDGeneralViewer','EC_InterfaceViewer','YTD General Viewer','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_YTDLveDedRecView') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDLveDedRecView','EC_InterfaceViewer','YTD Leave Deduction Record Viewer','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_YTDOTRecordViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDOTRecordViewer','EC_InterfaceViewer','YTD OT Record Viewer','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_YTDTHPolicyViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDTHPolicyViewer','EC_InterfaceViewer','YTD Policy Viewer','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_YTDShiftRecViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('EC_YTDShiftRecViewer','EC_InterfaceViewer','YTD Shift Record','InterfaceViewer',0,0,1,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDAllowRecViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDAllowRecViewer','InterfaceViewer','YTD Pay Element Record Viewer','InterfaceViewer',0,0,0,'EC_YTDAllowRecViewer');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDGeneralViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDGeneralViewer','InterfaceViewer','YTD General Viewer','InterfaceViewer',0,0,0,'EC_YTDGeneralViewer');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDLveDedRecViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDLveDedRecViewer','InterfaceViewer','YTD Leave Deduction Record Viewer','InterfaceViewer',0,0,0,'EC_YTDLveDedRecView');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDOTRecordViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDOTRecordViewer','InterfaceViewer','YTD OT Record Viewer','InterfaceViewer',0,0,0,'EC_YTDOTRecordViewer');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDTHPolicyViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDTHPolicyViewer','InterfaceViewer','YTD Policy Viewer','InterfaceViewer',0,0,0,'EC_YTDTHPolicyViewer');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'YTDShiftRecordViewer') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('YTDShiftRecordViewer','InterfaceViewer','YTD Shift Record','InterfaceViewer',0,0,0,'EC_YTDShiftRecViewer');
end if;

commit work;