IF (NOT EXISTS(SELECT * FROM MPFSubmitFormat WHERE MPFSubmitForId='MPF' AND MPFFormatName = 'Bank Consortium')) THEN
   INSERT INTO MPFSubmitFormat (
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
   VALUES (
      'MPF', 'Bank Consortium', 'RMPFFormatBankConsortium.dll', 'InvokeGenericFormatter',
      '','','','','',
      '','','','','',
      'Surcharge for Contributions','','','','',
      'Contribution Pay Date','','','','',
      'Scheme Registration No','Participating Plan No.','Name of Contact Person','Telephone No.','',
      '','','','','',
      '','','','','',
      '','','','','',
      1,0,1,1,1);
END IF;
