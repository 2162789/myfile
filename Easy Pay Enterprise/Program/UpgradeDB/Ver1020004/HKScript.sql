IF EXISTS(SELECT * FROM MPFSubmitFormat WHERE MPFSubmitForId = 'MPF' AND MPFFormatName = 'HSBC INB2') THEN 
UPDATE MPFSubmitFormat SET 
   BooleanField1Desc = '',
   IntegerField1Desc = 'Employee Class No',
   DateField1Desc = 'Issue Date',
   DateField2Desc = 'Receipt Date',
   DateField3Desc = 'Payment Due Date',
   DateField4Desc = 'Signature Date',
   StringField1Desc = 'Employer Participation No',
   StringField2Desc = 'Scheme Registration No',
   StringField3Desc = 'Scheme Name',
   StringField4Desc = 'Employer ID',
   StringField5Desc = 'Employer Name',
   StringField6Desc = 'Pay Centre ID',
   StringField7Desc = 'Pay Centre Name',
   StringField8Desc = 'Bill Number',
   StringField9Desc = 'Authorised Full Name',
   StringField10Desc = 'Job Position'
WHERE MPFSubmitForId = 'MPF' AND MPFFormatName = 'HSBC INB2';
ELSE
   INSERT INTO MPFSubmitFormat
   (
      MPFSubmitForId, MPFFormatName, DllName, FormatterInvoke, 
      BooleanField1Desc, BooleanField2Desc, BooleanField3Desc, BooleanField4Desc, BooleanField5Desc, 
      IntegerField1Desc, IntegerField2Desc, IntegerField3Desc, IntegerField4Desc, IntegerField5Desc, 
      NumericField1Desc, NumericField2Desc, NumericField3Desc, NumericField4Desc, NumericField5Desc,
      DateField1Desc, DateField2Desc, DateField3Desc, DateField4Desc, DateField5Desc, 
      StringField1Desc, StringField2Desc, StringField3Desc, StringField4Desc, StringField5Desc,
      StringField6Desc, StringField7Desc, StringField8Desc, StringField9Desc, StringField10Desc, 
      StringField11Desc, StringField12Desc, StringField13Desc, StringField14Desc, StringField15Desc, 
      StringField16Desc, StringField17Desc, StringField18Desc, StringField19Desc, StringField20Desc, 
      SQLNewDet, SQLNewSum, SQLExisting, SQLTerminate, SQLTermBackPay
   )
   VALUES
    (
        'MPF','HSBC INB2','RMPFFormatINB2.dll','InvokeGenericFormatter','','','','','','Employee Class No',
	'','','','','','','','','','Issue Date','Receipt Date','Payment Due Date','Signature Date','',
	'Employer Participation No','Scheme Registration No','Scheme Name','Employer ID','Employer Name',
	'Pay Centre ID','Pay Centre Name','Bill Number','Authorised Full Name','Job Position','','','','','','','','','','',
	1,0,1,1,1
    );
end if;

IF EXISTS(SELECT * FROM MPFSubmitScheme WHERE MPFSubmitForId = 'MPF' AND MPFFormatName = 'HSBC INB2') THEN 
    DELETE FROM MPFSubmitScheme WHERE MPFSubmitForId = 'MPF' AND MPFFormatName = 'HSBC INB2';
END IF;

IF NOT EXISTS(SELECT * FROM MPFSubmitScheme WHERE MPFSubmitForId = 'MPF' AND MPFFormatName = 'HSBC INB2') THEN 
INSERT INTO MPFSubmitScheme
(
   MPFSubmitForId, MPFFormatName, 
   BooleanField1, BooleanField2, BooleanField3, BooleanField4, BooleanField5, 
   IntegerField1, IntegerField2, IntegerField3, IntegerField4, IntegerField5, 
   NumericField1, NumericField2, NumericField3, NumericField4, NumericField5, 
   DateField1, DateField2, DateField3, DateField4, DateField5, 
   StringField1, StringField2, StringField3, StringField4, StringField5, 
   StringField6, StringField7, StringField8, StringField9, StringField10, 
   StringField11, StringField12, StringField13, StringField14, StringField15, 
   StringField16, StringField17, StringField18, StringField19, StringField20
)
VALUES
(
   'MPF','HSBC INB2',
   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
   '1899-12-30','1899-12-30','1899-12-30','1899-12-30','1899-12-30',
   '','MT00245','HSBC MPF SuperTrust Plus','','',
   '','','','','','','','','','','','','','',''
);
END IF;

COMMIT WORK;