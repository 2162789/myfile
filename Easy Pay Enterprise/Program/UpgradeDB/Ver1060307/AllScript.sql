READ UpgradeDB\Ver1060307\AlchemexView.sql;

if not exists(Select * from KeyWord Where  KeyWordCategory='SysReminder' and KeyWordId='6MonthBefore') then 
 Insert Into KeyWord values ('6MonthBefore','6 Month Before','6 Month Before','SysReminder',0,0,0,'MonthBefore',0,0,6,'')
end if;
 
if not exists(Select * from KeyWord Where  KeyWordCategory='SysReminder' and KeyWordId='6MonthAfter') then 
 Insert Into KeyWord values ('6MonthAfter','6 Month After','6 Month After','SysReminder',0,0,0,'MonthAfter',0,0,6,'');
end if;

if not exists(Select * from KeyWord Where  KeyWordCategory='SysReminder' and KeyWordId='9MonthAfter') then 
 Insert Into KeyWord values ('9MonthAfter','9 Month After','9 Month After','SysReminder',0,0,0,'MonthAfter',0,0,9,'');
end if;

if not exists(Select * from KeyWord Where  KeyWordCategory='SysReminder' and KeyWordId='9Monthbefore') then 
Insert Into KeyWord values ('9MonthBefore','9 Month Before','9 Month Before','SysReminder',0,0,0,'MonthBefore',0,0,9,'');
end if;

commit work;