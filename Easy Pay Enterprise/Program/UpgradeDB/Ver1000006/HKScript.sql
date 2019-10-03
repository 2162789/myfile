if not exists (select * from "DBA"."MPFSubmitFormat" where MPFSubmitForId = 'MPF' and MPFFormatName = 'Sun Life Trustee') then
insert into MPFSubmitFormat (
MPFSubmitForId, MPFFormatName, DllName, FormatterInvoke, 
BooleanField1Desc, BooleanField2Desc, BooleanField3Desc, BooleanField4Desc, BooleanField5Desc, 
IntegerField1Desc, IntegerField2Desc, IntegerField3Desc, IntegerField4Desc, IntegerField5Desc, 
NumericField1Desc, NumericField2Desc, NumericField3Desc, NumericField4Desc, NumericField5Desc,
DateField1Desc, DateField2Desc, DateField3Desc, DateField4Desc, DateField5Desc,
StringField1Desc, StringField2Desc, StringField3Desc, StringField4Desc, StringField5Desc,
StringField6Desc, StringField7Desc, StringField8Desc, StringField9Desc, StringField10Desc,
StringField11Desc, StringField12Desc, StringField13Desc, StringField14Desc, StringField15Desc,
StringField16Desc, StringField17Desc, StringField18Desc, StringField19Desc, StringField20Desc,
SQLNewDet, SQLNewSum, SQLExisting, SQLTerminate, SQLTermBackPay)
values ('MPF','Sun Life Trustee','RMPFFormatSunLife.dll','InvokeGenericFormatter','','','','','','','','','','','','','','','','','','','','','Contact Person Title','Contact Person Name','Employer Code','Reporting Center No.','','','','','','','','','','','','','','','','',1,0,1,1,1);
end if;
commit work;