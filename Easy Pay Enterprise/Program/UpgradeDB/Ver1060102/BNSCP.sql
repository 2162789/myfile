Insert into Keyword Values ('SCPWage','SCP Wage','SCP Wage','System',0,1,1,'',0,0,30,'');
Insert into Keyword Values ('SubjSCP','Subject to SCP','Subject to SCP','System',1,0,0,'Only available if not Donation Code',0,0,30,'N');
Insert into Keyword Values ('SCPScheme','SCP','SCP','CPFScheme',0,0,0,'',0,0,0,'');
Insert into WageProperty Values('SubjSCP','SCPWage',1);
Insert into WageProperty Values('TotalWage','SCPWage',1);
Insert into WageProperty Values('LeaveDeductAmt','SCPWage',0);
Insert into WageProperty Values('BackPay','SCPWage',1);

Insert into SubRegistry Values('PayRecordPolicy','SCP','Local','','SCP','','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayRecordPolicy','SCPWage','Local','SCP','SCP Wage','CurrEEManWage','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayRecordPolicy','SCPEE','Local','SCP','Employee SCP','CurrEEManContri','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayRecordPolicy','SCPER','Local','SCP','Employer SCP','CurrERManContri','','','','','','',0,3,'',0,'','','1899-12-30','1899-12-30 00:00:00');

Insert into SubRegistry Values('PayPeriodPolicy','SCP','Local','','SCP','','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayPeriodPolicy','SCPWage','Local','SCP','SCP Wage','PrevOrdinaryWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayPeriodPolicy','SCPEE','Local','SCP','Employee SCP','ActualOrdEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PayPeriodPolicy','SCPER','Local','SCP','Employer SCP','ActualOrdERCPF','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
Insert into SubRegistry Values('PaySetupData','SCPProgPolicyId','Combo','SCP Policy','ShortStringAttr','Y','CPFPolicy','CPFPolicyId','Select * from CPFPolicy where SubString(CPFPolicyId,1,3)=''SCP'';','CPFPolicyId	20	SCP Policy	F','CPFPolicyDesc	80	Description	F','',0,0,'',0,'SCPYr2010Jan','','1899-12-30','1899-12-30 00:00:00');

Update SubRegistry Set RegProperty7='Select * from KeyWord where KeyWordCategory=''CPFScheme'' And SubString(KeyWordId,1,3) = ''TAP'';',
                       RegProperty8='KeyWordId	20	TAP Scheme	F'
                Where RegistryId = 'PaySetupData' And SubRegistryId = 'CPFProgSchemeId';

Update SubRegistry Set RegProperty7='Select * from CPFPolicy where SubString(CPFPolicyId,1,3)!=''SCP'';',
                       RegProperty8='CPFPolicyId	20	TAP Policy	F'
                Where RegistryId = 'PaySetupData' And SubRegistryId = 'CPFProgPolicyId';

Insert into CompanyGov Values('001',5,1,NULL,'EmployerSCP1','Employer SCP A/C','SCP');

Insert into SubRegistry Values('EmpeeOtherInfo','SCPNo','SCP No','String','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');

Insert into EmpeeOtherInfo(EmployeesysId,EmpeeOtherInfoId,EmpeeOtherInfoCaption,EmpeeOtherInfoType,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble)
Select EmployeesysId,'SCPNo','SCP No','String',NULL,'',0,0 From Employee;

COMMIT WORK;