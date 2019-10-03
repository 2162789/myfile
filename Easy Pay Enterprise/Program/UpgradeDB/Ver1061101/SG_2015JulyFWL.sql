/* 2015 July FWL */
if not exists(select * from Formula where FormulaId = 'SPass 10% 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('SPass 10% 7/15',1,0,0,'FWL','FWLCalDay','','','SPass (7/15) 10%','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
 ('SPass 10% 7/15',1,0,0,'@MAX(C1 * U1, C2);',10.36,315,0,0,0,'','','','','','','','','','','','','','',''); 
end if;

if not exists(select * from Formula where FormulaId = 'SPass 20% 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('SPass 20% 7/15',1,0,0,'FWL','FWLCalDay','','','SPass (7/15) 20%','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('SPass 20% 7/15',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Spass (Svc) 10% 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Spass (Svc) 10% 7/15',1,0,0,'FWL','FWLCalDay','','','Spass (Svc) (7/15) 10%','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Spass (Svc) 10% 7/15',1,0,0,'@MAX(C1 * U1, C2);',10.36,315,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Spass (Svc) 15% 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Spass (Svc) 15% 7/15',1,0,0,'FWL','FWLCalDay','','','Spass (Svc) (7/15) 15%','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Spass (Svc) 15% 7/15',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Man 25% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 25% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 25% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Man 25% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',8.22,250,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Man 25% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 25% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 25% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Man 25% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',12.17,370,0,0,0,'','','','','','','','','','','','','','','');  
end if;

if not exists(select * from Formula where FormulaId = 'Man 50% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 50% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 50% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Man 50% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',11.51,350,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Man 50% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 50% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 50% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
 ('Man 50% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',15.46,470,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Man 60% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 60% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 60% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Man 60% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Man 60% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Man 60% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Man (7/15) 60% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Man 60% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',21.37,650,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Svc 10% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 10% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 10% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Svc 10% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Svc 10% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 10% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 10% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
 ('Svc 10% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',13.81,420,0,0,0,'','','','','','','','','','','','','','','');
end if;  

if not exists(select * from Formula where FormulaId = 'Svc 25% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 25% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 25% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Svc 25% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',13.16,400,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Svc 25% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 25% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 25% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Svc 25% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Svc 40% Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 40% Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 40% Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Svc 40% Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',19.73,600,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Svc 40% UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Svc 40% UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Svc (7/15) 40% Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Svc 40% UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',23.02,700,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Mar Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Mar Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Mar 7/15 Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Mar Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Mar UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Mar UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Mar 7/15 Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Mar UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',13.16,400,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Process Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Process Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Process 7/15 MYE Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Process Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;
 
if not exists(select * from Formula where FormulaId = 'Process UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Process UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Process 7/15 MYE Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Process UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',14.8,450,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Proc W Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Proc W Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Process 7/15 MYE Waiver Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Proc W Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',19.73,600,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Proc W Unskill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Proc W Unskill 7/15',1,0,0,'FWL','FWLCalDay','','','Process 7/15 MYE Waiver Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Proc W Unskill 7/15',1,0,0,'@MAX(C1 * U1, C2);',24.66,750,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Con B Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Con B Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Con 7/15 MYE B.Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Con B Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',18.09,550,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Con H Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Con H Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Con 7/15 MYE H.Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Con H Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Con W Skill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Con W Skill 7/15',1,0,0,'FWL','FWLCalDay','','','Con 7/15 MYE Waiver Skilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Con W Skill 7/15',1,0,0,'@MAX(C1 * U1, C2);',19.73,600,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Con W UnSkill 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Con W UnSkill 7/15',1,0,0,'FWL','FWLCalDay','','','Con 7/15 MYE Waiver Unskilled','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Con W UnSkill 7/15',1,0,0,'@MAX(C1 * U1, C2);',31.24,950,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Harbour (C) 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Harbour (C) 7/15',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Certified Crew (7/15)','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Harbour (C) 7/15',1,0,0,'@MAX(C1 * U1, C2);',9.87,300,0,0,0,'','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where FormulaId = 'Habour (N) 7/15') then
  Insert into Formula(FormulaId,FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank) values 
  ('Habour (N) 7/15',1,0,0,'FWL','FWLCalDay','','','Harbour Craft Non-Certified Crew (7/15)','',0,0);
  Insert FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values 
  ('Habour (N) 7/15',1,0,0,'@MAX(C1 * U1, C2);',13.81,420,0,0,0,'','','','','','','','','','','','','','','');
end if;

commit work;