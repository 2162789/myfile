begin

if (not exists(select * from Formula Where Locate(FormulaId,'7/11',1) > 0)) then

Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('SPass 20% 7/11',1,0,0,'FWL','FWLCalDay','','','SPass (7/11) 20%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('SPass 25% 7/11',1,0,0,'FWL','FWLCalDay','','','SPass (7/11) 25%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 30% Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Man (7/11) 30% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 30% UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Man (7/11) 30% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 50% Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Man (7/11) 50% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 50% UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Man (7/11) 50% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Man 65% 7/11',1,0,0,'FWL','FWLCalDay','','','Man (7/11) 65%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 20% Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Svc (7/11) 20% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 20% UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Svc (7/11) 20% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 35% Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Svc (7/11) 35% Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 35% UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Svc (7/11) 35% Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Svc 50% 7/11',1,0,0,'FWL','FWLCalDay','','','Svc (7/11) 50%','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Mar Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Mar 7/11 Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Mar UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Mar 7/11 Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Process 7/11 MYE Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process UnSkill 7/11',1,0,0,'FWL','FWLCalDay','','','Process 7/11 MYE Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process W Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Process 7/11 MYE Waiver Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Process W Un 7/11',1,0,0,'FWL','FWLCalDay','','','Process 7/11 MYE Waiver Unskilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con B Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Con 7/11 MYE B. Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con H Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Con 7/11 MYE H.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con W B Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Con 7/11 MYE Wavier B. Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Con W H Skill 7/11',1,0,0,'FWL','FWLCalDay','','','Con 7/11 MYE Wavier H.Skilled','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Harbour (C) 7/11',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (7/11)','',0,0);
Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values ('Habour (N) 7/11',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (7/11)','',0,0);

Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'SPass 20% 7/11',1,0,0,'@MAX(C1 * U1, C2);',4,120,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'SPass 25% 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 30% Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 30% UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,280,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 50% Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',8,240,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 50% UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',12,340,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Man 65% 7/11',1,0,0,'@MAX(C1 * U1, C2);',15,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 20% Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 20% UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,280,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 35% Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 35% UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',14,400,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Svc 50% 7/11',1,0,0,'@MAX(C1 * U1, C2);',15,450,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Mar Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Mar UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process UnSkill 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,300,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process W Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',11,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Process W Un 7/11',1,0,0,'@MAX(C1 * U1, C2);',13,380,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con B Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',8,230,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con H Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con W B Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',13,380,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Con W H Skill 7/11',1,0,0,'@MAX(C1 * U1, C2);',11,330,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Harbour (C) 7/11',1,0,0,'@MAX(C1 * U1, C2);',6,180,0,0,0,'','','','','','','','','','','','','','','');
Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,
Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values (
'Habour (N) 7/11',1,0,0,'@MAX(C1 * U1, C2);',10,280,0,0,0,'','','','','','','','','','','','','','','');

end if

end;