begin

if (not exists(select * from Formula Where Locate(FormulaId,'1/11',1) > 0)) then

Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Harbour (C) 7/10',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (7/10)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Habour (N) 7/10',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (7/10)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('SPass 20% 1/11',1,0,0,'FWL','FWLCalDay','','','SPass (1/11) 20%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('SPass 25% 1/11',1,0,0,'FWL','FWLCalDay','','','SPass (1/11) 25%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 35% Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Man (1/11) 35% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 35% UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Man (1/11) 35% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 55% Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Man (1/11) 55% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 55% UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Man (1/11) 55% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 65% 1/11',1,0,0,'FWL','FWLCalDay','','','Man (1/11) 65%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 25% Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Svc (1/11) 25% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 25% UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Svc (1/11) 25% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 40% 1/11',1,0,0,'FWL','FWLCalDay','','','Svc (1/11) 40%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 50% 1/11',1,0,0,'FWL','FWLCalDay','','','Svc (1/11) 50%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Mar Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Mar 1/11 Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Mar UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Mar 1/11 Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Process 1/11 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Process 1/11 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process Waiver 1/11',1,0,0,'FWL','FWLCalDay','','','Process 1/11 MYE Waiver','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con Skill 1/11',1,0,0,'FWL','FWLCalDay','','','Con 1/11 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con UnSkill 1/11',1,0,0,'FWL','FWLCalDay','','','Con 1/11 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con Waiver 1/11',1,0,0,'FWL','FWLCalDay','','','Con 1/11 MYE Wavier','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Harbour (C) 1/11',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (1/11)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Habour (N) 1/11',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (1/11)','',0,0);

Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Harbour (C) 7/10',1,0,0,'@MAX(C1 * U1, C2);',6,160,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Habour (N) 7/10',1,0,0,'@MAX(C1 * U1, C2);',9,260,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'SPass 20% 1/11',1,0,0,'@MAX(C1 * U1, C2);',4,110,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'SPass 25% 1/11',1,0,0,'@MAX(C1 * U1, C2);',5,150,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 35% Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,170,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 35% UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',9,270,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 55% Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',7,210,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 55% UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',11,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 65% 1/11',1,0,0,'@MAX(C1 * U1, C2);',15,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 25% Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,170,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 25% UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',9,270,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 40% 1/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 50% 1/11',1,0,0,'@MAX(C1 * U1, C2);',15,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Mar Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,170,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Mar UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,160,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process Waiver 1/11',1,0,0,'@MAX(C1 * U1, C2);',11,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con Skill 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,160,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con UnSkill 1/11',1,0,0,'@MAX(C1 * U1, C2);',16,470,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con Waiver 1/11',1,0,0,'@MAX(C1 * U1, C2);',11,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Harbour (C) 1/11',1,0,0,'@MAX(C1 * U1, C2);',6,170,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Habour (N) 1/11',1,0,0,'@MAX(C1 * U1, C2);',9,270,0,0,0,'','','','','','','','','','','','','','','');

end if

end;

