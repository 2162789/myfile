/* FWL */
if not exists(select * from Formula where Locate(FormulaId,'7/12') <> 0 and FormulaCategory='FWL') then
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 10% 7/12',1,0,0,'FWL','FWLCalDay','','','SPass (7/12) 10%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 20% 7/12',1,0,0,'FWL','FWLCalDay','','','SPass (7/12) 20%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 25% Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Man (7/12) 25% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 25% UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Man (7/12) 25% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Man (7/12) 50% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Man (7/12) 50% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 60% 7/12',1,0,0,'FWL','FWLCalDay','','','Man (7/12) 60%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 15% Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Svc (7/12) 15% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 15% UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Svc (7/12) 15% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 25% Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Svc (7/12) 25% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 25% UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Svc (7/12) 25% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 45% 7/12',1,0,0,'FWL','FWLCalDay','','','Svc (7/12) 45%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Mar 7/12 Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Mar 7/12 Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Process 7/12 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process UnSkill 7/12',1,0,0,'FWL','FWLCalDay','','','Process 7/12 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Waiver 7/12',1,0,0,'FWL','FWLCalDay','','','Process 7/12 MYE Waiver','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con B Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Con 7/12 MYE B.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con H Skill 7/12',1,0,0,'FWL','FWLCalDay','','','Con 7/12 MYE H.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con Waiver 7/12',1,0,0,'FWL','FWLCalDay','','','Con 7/12 MYE Wavier','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Harbour (C) 7/12',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (7/12)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Habour (N) 7/12',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (7/12)','',0,0);
end if;

if not exists(select * from FormulaRange where Locate(FormulaId,'7/12') <> 0) then
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('SPass 10% 7/12',1,0,0,'@MAX(C1 * U1, C2);',6.58,200,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('SPass 20% 7/12',1,0,0,'@MAX(C1 * U1, C2);',10.53,320,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 25% Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',6.91,210,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 25% UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',10.2,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 50% Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 50% UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',13.16,400,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 60% 7/12',1,0,0,'@MAX(C1 * U1, C2);',15.46,470,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 15% Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',7.9,240,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 15% UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',11.18,340,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 25% Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',11.84,360,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 25% UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',15.13,460,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 45% 7/12',1,0,0,'@MAX(C1 * U1, C2);',16.44,500,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Mar Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',6.91,210,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Mar UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',10.2,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',6.91,210,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process UnSkill 7/12',1,0,0,'@MAX(C1 * U1, C2);',10.2,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process Waiver 7/12',1,0,0,'@MAX(C1 * U1, C2);',15.46,470,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con B Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',11.51,350,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con H Skill 7/12',1,0,0,'@MAX(C1 * U1, C2);',8.22,250,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con Waiver 7/12',1,0,0,'@MAX(C1 * U1, C2);',16.44,500,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Harbour (C) 7/12',1,0,0,'@MAX(C1 * U1, C2);',7.9,240,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Habour (N) 7/12',1,0,0,'@MAX(C1 * U1, C2);',11.18,340,0,0,0,'','','','','','','','','','','','','','','');
end if;

commit work;