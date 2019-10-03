begin

if (not exists(select * from Formula Where Locate(FormulaId,'1/12',1) > 0)) then

Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 15% 1/12',1,0,0,'FWL','FWLCalDay','','','SPass (1/12) 15%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 25% 1/12',1,0,0,'FWL','FWLCalDay','','','SPass (1/12) 25%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 30% Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Man (1/12) 30% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 30% UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Man (1/12) 30% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Man (1/12) 50% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Man (1/12) 50% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 65% 1/12',1,0,0,'FWL','FWLCalDay','','','Man (1/12) 65%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 20% Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Svc (1/12) 20% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 20% UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Svc (1/12) 20% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 30% Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Svc (1/12) 30% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 30% UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Svc (1/12) 30% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 50% 1/12',1,0,0,'FWL','FWLCalDay','','','Svc (1/12) 50%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Mar 1/12 Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Mar 1/12 Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Process 1/12 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process UnSkill 1/12',1,0,0,'FWL','FWLCalDay','','','Process 1/12 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Waiver 1/12',1,0,0,'FWL','FWLCalDay','','','Process 1/12 MYE Waiver','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con B Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Con 1/12 MYE B.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con H Skill 1/12',1,0,0,'FWL','FWLCalDay','','','Con 1/12 MYE H.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con Waiver 1/12',1,0,0,'FWL','FWLCalDay','','','Con 1/12 MYE Wavier','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Harbour (C) 1/12',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (1/12)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Habour (N) 1/12',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (1/12)','',0,0);

Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('SPass 15% 1/12',1,0,0,'@MAX(C1 * U1, C2);',5.27,160,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('SPass 25% 1/12',1,0,0,'@MAX(C1 * U1, C2);',8.22,250,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Man 30% Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',6.25,190,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Man 30% UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',9.54,290,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Man 50% Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',8.88,270,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Man 50% UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',12.17,370,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Man 65% 1/12',1,0,0,'@MAX(C1 * U1, C2);',14.8,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Svc 20% Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',6.91,210,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Svc 20% UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',10.2,310,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Svc 30% Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',10.85,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Svc 30% UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',14.14,430,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Svc 50% 1/12',1,0,0,'@MAX(C1 * U1, C2);',15.46,470,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Mar Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',6.25,190,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Mar UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Process Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',5.92,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Process UnSkill 1/12',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Process Waiver 1/12',1,0,0,'@MAX(C1 * U1, C2);',12.5,380,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Con B Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Con H Skill 1/12',1,0,0,'@MAX(C1 * U1, C2);',6.58,200,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Con Waiver 1/12',1,0,0,'@MAX(C1 * U1, C2);',14.8,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Harbour (C) 1/12',1,0,0,'@MAX(C1 * U1, C2);',6.25,190,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values ('Habour (N) 1/12',1,0,0,'@MAX(C1 * U1, C2);',9.53,290,0,0,0,'','','','','','','','','','','','','','','');

end if

end;