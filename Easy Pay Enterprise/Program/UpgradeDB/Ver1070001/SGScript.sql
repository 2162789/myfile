/* 2016 July FWL */

if  not exists(select * from Formula where FormulaId = 'Mar Skill 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Mar Skill 7/16',1,0,0,'FWL','FWLCalDay','','','Mar 7/16 Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Mar Skill 7/16',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
else
    Update FormulaRange set  Constant1=9.87,Constant2=300 where FormulaId = 'Mar Skill 7/16';
end if;

if not exists(select * from Formula where FormulaId = 'Mar UnSkill 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Mar UnSkill 7/16',1,0,0,'FWL','FWLCalDay','','','Mar 7/16 Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Mar UnSkill 7/16',1,0,0,'@MAX(C1 * U1, C2);',13.16,400,0,0,0,'','','','','','','','','','','','','','','');
else
       Update FormulaRange set  Constant1=13.16,Constant2=400 where FormulaId = 'Mar UnSkill 7/16';
end if;

if not exists(select * from Formula where FormulaId = 'Process UnSkill 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Process UnSkill 7/16',1,0,0,'FWL','FWLCalDay','','','Process 7/16 MYE Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Process UnSkill 7/16',1,0,0,'@MAX(C1 * U1, C2);',14.8,450,0,0,0,'','','','','','','','','','','','','','','');
else
       Update FormulaRange set  Constant1=14.8,Constant2=450 where FormulaId = 'Process UnSkill 7/16';
end if;

if not exists(select * from Formula where FormulaId = 'Proc W Unskill 7/16') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Proc W Unskill 7/16',1,0,0,'FWL','FWLCalDay','','','Process 7/16 MYE Waiver Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Proc W Unskill 7/16',1,0,0,'@MAX(C1 * U1, C2);',24.66,750,0,0,0,'','','','','','','','','','','','','','','');
else
     Update FormulaRange set  Constant1=24.66,Constant2=750 where FormulaId = 'Proc W Unskill 7/16';
end if;

/* Add new wage property LastOTPay to compute the last OT Pay as Additional wage */

If not exists (select * from keyword where keywordid='LastOTPay') then
Insert into Keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
Values('LastOTPay','Last OT Pay','Last OT Pay','System',0,0,0,'',0,0,0,'');
End If;

If not exists (select * from wageproperty where keywordid='LastOTPay' and wageid='AddWage') then
Insert into WageProperty(keywordid,wageid,wagepropertyused)Values('LastOTPay','AddWage',1);
End if;

If not exists (select * from wageproperty where keywordid='LastOTPay' and wageid='OrdWage') then
Insert into WageProperty(keywordid,wageid,wagepropertyused)Values('LastOTPay','OrdWage',0);
End if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'OCBC (All Giro with Invoice)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'OCBC (All Giro with Invoice)', 'RSingBankFormatOCBCAllGiroWithInvoice.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;