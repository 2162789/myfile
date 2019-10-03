if not exists(select * from Formula where FormulaId = 'Harbour (C) 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Harbour (C) 7/16',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (7/16)','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Harbour (C) 7/16',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Habour (N) 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Habour (N) 7/16',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (7/16)','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Habour (N) 7/16',1,0,0,'@MAX(C1 * U1, C2);',14.8,450,0,0,0,'','','','','','','','','','','','','','','');
else
  Update FormulaRange set Constant1=14.8,Constant2=450 where FormulaId = 'Habour (N) 7/16' and FormularangeID=1;
end if;

/* OCBC (Giro/Fast with Inv) */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'OCBC (Giro/Fast with Inv)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'OCBC (Giro/Fast with Inv)', 'RSingBankFormatOCBCGiroFastWithInv.dll', 'InvokeSalaryFormatter', 0);
end if;

/* MBMF Revision Range Fix */
delete from FormulaRange where FormulaId in ('MOSQ2016', 'YMF2016');
if exists(select 1 from Formula where FormulaId = 'MOSQ2016') then
   Insert into FormulaRange Values('MOSQ2016',1,1000.01,0.1,'C1;',-1.75,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',2,2000.01,1000.01,'C1;',-3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',3,3000.01,2000.01,'C1;',-5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',4,4000.01,3000.01,'C1;',-11,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',5,6000.01,4000.01,'C1;',-13.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',6,8000.01,6000.01,'C1;',-14.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',7,10000.01,8000.01,'C1;',-16,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('MOSQ2016',8,99999999,10000.01,'C1;',-17.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;
if exists(select 1 from Formula where FormulaId = 'YMF2016') then
   Insert into FormulaRange Values('YMF2016',1,1000.01,0.1,'C1;',-1.25,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',2,3000.01,1000.01,'C1;',-1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',3,4000.01,3000.01,'C1;',-4,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',4,6000.01,4000.01,'C1;',-6,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',5,8000.01,6000.01,'C1;',-7.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',6,10000.01,8000.01,'C1;',-8,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('YMF2016',7,99999999,10000.01,'C1;',-8.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

/* Insert the Excess/Adjust (Additional) CPF information for the Pay Record & Pay Period */
if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'CPFAdditionalExcess') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','CPFAdditionalExcess','Local','CPF','Excess/Adjustment (Additonal)','','','','','','','',0,5,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'CurrentTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','CurrentTaxWage','Local','CPFAdditionalExcess','Current Additional Wage','CurrentTaxWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'CurrentAddTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','CurrentAddTaxWage','Local','CPFAdditionalExcess','Employee Additional CPF','CurrentAddTaxWage','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'PreviousAddTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','PreviousAddTaxWage','Local','CPFAdditionalExcess','Employer Additional CPF','PreviousAddTaxWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'CurrentTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','CurrentTaxWage','Local','CPFWageBreakdown','Excess/Adjustment (Additional) Wage','CurrentTaxWage','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'CPFAdditionalExcess') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','CPFAdditionalExcess','Local','CPF','Excess/Adjustment - Company Policy','','','','','','','',0,5,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'CurrentAddTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','CurrentAddTaxWage','Local','CPFAdditionalExcess','Employee Additional CPF','CurrentAddTaxWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'PreviousAddTaxWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','PreviousAddTaxWage','Local','CPFAdditionalExcess','Employer Additional CPF','PreviousAddTaxWage','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Update SubRegistry Set IntegerAttr = 6 where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'Medisave'; 
Update SubRegistry Set IntegerAttr = 6 where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'OverseasCPF';
Update SubRegistry Set IntegerAttr = 7 where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'Medisave';

commit work;