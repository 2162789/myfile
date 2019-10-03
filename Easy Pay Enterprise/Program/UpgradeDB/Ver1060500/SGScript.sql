/* YEKeyword */
Update YEKeyword set YEProperty1 = 'A' where yekeywordid = 'IR21Self';
Update YEKeyword set YEProperty1 = 'D' where yekeywordid = 'IR21Children8-20';
Update YEKeyword set YEProperty1 = 'C' where yekeywordid = 'IR21Children3-7';
Update YEKeyword set YEProperty1 = 'B' where yekeywordid = 'IR21Children<3';
Update YEKeyword set YEProperty1 = 'E' where yekeywordid = 'IR21plus2%';
update yekeyword set YEKeywordDefaultName = 'PUB',YEKeyWordUserDefinedName = 'PUB' where YEKeywordId = 'IR21PublicUtilities';
update yekeyword set YEKeywordDefaultName = 'Gardener',YEKeyWordUserDefinedName = 'Gardener' where YEKeywordId = 'IR21Gardener';
update YeKeyWord set YEKeyWordUserDefinedName = 'Refrigerator' where YEKeyWordId = 'IR21Refrigerator';
update YeKeyWord set YEKeyWordUserDefinedName = 'Refrigerator' where YEKeyWordId = 'Refrigerator';
update yekeyword set YEKeywordDefaultName = 'Self / Spouse / Children >20 years old',YEKeyWordUserDefinedName = 'Self / Spouse / Children >20 years old' where YEKeywordId = 'Self';
update yekeyword set YEKeywordDefaultName = 'Children < 3 yrs old',YEKeyWordUserDefinedName = 'Children < 3 yrs old',YEProperty1 = 'B' where YEKeywordId = 'Children<3';
update yekeyword set YEKeywordDefaultName = 'Children 3-7 years old',YEKeyWordUserDefinedName = 'Children 3-7 years old' where YEKeywordId = 'Children3-7';
update yekeyword set YEKeywordDefaultName = 'Children 8-20 years old',YEKeyWordUserDefinedName = 'Children 8-20 years old',YEProperty1 = 'D' where YEKeywordId = 'Children8-20';

/* 2013 Jan FWL */
if not exists(select * from Formula where Locate(FormulaId,'1/13') <> 0 and FormulaCategory='FWL') then
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 10% 1/13',1,0,0,'FWL','FWLCalDay','','','SPass (1/13) 10%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('SPass 20% 1/13',1,0,0,'FWL','FWLCalDay','','','SPass (1/13) 20%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 25% Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Man (1/13) 25% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 25% UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Man (1/13) 25% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Man (1/13) 50% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 50% UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Man (1/13) 50% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Man 60% 1/13',1,0,0,'FWL','FWLCalDay','','','Man (1/13) 60%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 15% Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Svc (1/13) 15% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 15% UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Svc (1/13) 15% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 25% Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Svc (1/13) 25% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 25% UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Svc (1/13) 25% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Svc 45% 1/13',1,0,0,'FWL','FWLCalDay','','','Svc (1/13) 45%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Mar 1/13 Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Mar UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Mar 1/13 Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Process 1/13 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Process 1/13 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Process Waiver 1/13',1,0,0,'FWL','FWLCalDay','','','Process 1/13 MYE Waiver','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con B Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Con 1/13 MYE B.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con H Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Con 1/13 MYE H.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con W Skill 1/13',1,0,0,'FWL','FWLCalDay','','','Con 1/13 MYE Waiver Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Con W UnSkill 1/13',1,0,0,'FWL','FWLCalDay','','','Con 1/13 MYE Waiver Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Harbour (C) 1/13',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (1/13)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
('Habour (N) 1/13',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (1/13)','',0,0);
end if;

if not exists(select * from FormulaRange where Locate(FormulaId,'1/13') <> 0) then
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('SPass 10% 1/13',1,0,0,'@MAX(C1 * U1, C2);',8.22,250,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('SPass 20% 1/13',1,0,0,'@MAX(C1 * U1, C2);',12.83,390,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 25% Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',7.57,230,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 25% UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',10.85,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 50% Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',10.85,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 50% UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',14.14,430,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Man 60% 1/13',1,0,0,'@MAX(C1 * U1, C2);',16.44,500,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 15% Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',8.88,270,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 15% UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',12.17,370,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 25% Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',12.5,380,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 25% UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',15.79,480,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Svc 45% 1/13',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Mar Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',7.57,230,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Mar UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',10.85,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',7.57,230,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',10.85,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Process Waiver 1/13',1,0,0,'@MAX(C1 * U1, C2);',16.44,500,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con B Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',13.16,400,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con H Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',9.21,280,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con W Skill 1/13',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Con W UnSkill 1/13',1,0,0,'@MAX(C1 * U1, C2);',21.37,650,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Harbour (C) 1/13',1,0,0,'@MAX(C1 * U1, C2);',8.88,270,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
('Habour (N) 1/13',1,0,0,'@MAX(C1 * U1, C2);',12.17,370,0,0,0,'','','','','','','','','','','','','','','');
end if;

commit work;