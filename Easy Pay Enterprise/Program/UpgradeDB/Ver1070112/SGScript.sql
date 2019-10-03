
if exists(select * from formula where formulaid='Process Skill 7/17') then
Update formula set FormulaDesc='Process 7/17 Basic tier Skilled' where FormulaId ='Process Skill 7/17';
end if;


if exists(select * from formula where formulaid='Process UnSkill 7/17') then
Update formula set FormulaDesc='Process 7/17 Basic tier Unskilled' where FormulaId ='Process UnSkill 7/17';
end if;

if exists(select * from formula where formulaid='Con H Skill 7/17') then
Update formula set FormulaDesc='Con 7/17 Basic tier H.Skilled' where FormulaId ='Con H Skill 7/17';
end if;

if exists(select * from formula where formulaid='Con B Skill 7/17') then
Update formula set FormulaDesc='Con 7/17 Basic tier B.Skilled' where FormulaId ='Con B Skill 7/17';
end if;

if exists(select * from FormulaRange where FormulaId = 'Mar Skill 7/17') then
Update FormulaRange set Maximum=0,Minimum=0,Constant1=9.87,Constant2=300 where FormulaId = 'Mar Skill 7/17';
end if;

if exists(select * from FormulaRange where FormulaId = 'Mar UnSkill 7/17') then
Update FormulaRange set Maximum=0,Minimum=0,Constant1=13.16,Constant2=400 where FormulaId = 'Mar UnSkill 7/17';
end if;

if exists(select * from FormulaRange where FormulaId = 'Process UnSkill 7/17') then
Update FormulaRange set Maximum=0,Minimum=0,Constant1=14.80,Constant2=450 where FormulaId = 'Process UnSkill 7/17';
end if;

if exists(select * from FormulaRange where FormulaId = 'Proc W Unskill 7/17') then
Update FormulaRange set Maximum=0,Minimum=0,Constant1=24.66,Constant2=750 where FormulaId = 'Proc W Unskill 7/17';
end if;

if exists(select * from FormulaRange where FormulaId = 'Habour (N) 7/17') then
Update FormulaRange set Maximum=0,Minimum=0,Constant1=14.80,Constant2=450 where FormulaId = 'Habour (N) 7/17';
end if;




commit work;