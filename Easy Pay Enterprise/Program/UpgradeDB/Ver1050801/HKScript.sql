Update MPFSubmitFormat Set StringField7Desc = 'Type of Scheme' Where MPFSubmitForId = 'MPF' and MPFFormatName = 'ING';

Insert Into MPFSubmitScheme(MPFSubmitForId,MPFFormatName,BooleanField1,BooleanField2,BooleanField3,BooleanField4,BooleanField5,IntegerField1,IntegerField2,IntegerField3,IntegerField4,IntegerField5,
NumericField1,NumericField2,NumericField3,NumericField4,NumericField5,DateField1,DateField2,DateField3,DateField4,DateField5,StringField1,StringField2,StringField3,
StringField4,StringField5,StringField6,StringField7,StringField8,StringField9,StringField10,StringField11,StringField12,StringField13,StringField14,StringField15,StringField16,
StringField17,StringField18,StringField19,StringField20)
Values('MPF','ING',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'1899-12-30','1899-12-30','1899-12-30','1899-12-30','1899-12-30','','','','','','','Basic','','','','','','','','','','','','','');

commit work;
