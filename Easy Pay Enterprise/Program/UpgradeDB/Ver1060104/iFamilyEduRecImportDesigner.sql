if not exists (select * from ImportFieldTable where TableNamePhysical = 'iFamilyEduRec') then
  insert into ImportFieldTable values ('iFamilyEduRec','Family Education')
end if;

if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'FamilyIdentityNo') then
  insert into ImportFieldName values ('iFamilyEduRec','FamilyIdentityNo','Identity No','String',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'PersonName') then
  insert into ImportFieldName values ('iFamilyEduRec','PersonName','Family Member Name','String',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EducationId') then
  insert into ImportFieldName values ('iFamilyEduRec','EducationId','Education ID','String',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduInstitution') then
  insert into ImportFieldName values ('iFamilyEduRec','EduInstitution','Institution','String',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduStartDate') then
  insert into ImportFieldName values ('iFamilyEduRec','EduStartDate','Start Date','Date',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduEndDate') then
  insert into ImportFieldName values ('iFamilyEduRec','EduEndDate','End Date','Date',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduHighest') then
  insert into ImportFieldName values ('iFamilyEduRec','EduHighest','Highest Education','Numeric',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduResult') then
  insert into ImportFieldName values ('iFamilyEduRec','EduResult','Result','Numeric',0)
end if;
if not exists (select * from ImportFieldName where TableNamePhysical = 'iFamilyEduRec' and FieldNamePhysical = 'EduLocal') then
  insert into ImportFieldName values ('iFamilyEduRec','EduLocal','Is Local','Numeric',0)
end if;

commit work;