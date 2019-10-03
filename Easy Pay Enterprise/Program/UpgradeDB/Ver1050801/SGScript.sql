if not exists(select 1 from UsageItem where UsageGrpID='StatSubmit' and UsageItemID='CPFSubmitCount') then
insert into UsageItem values('CPFSubmitCount','StatSubmit','CPF Report Generation  Count','Caption CPF Report','','','IntegerValue','SELECT ItemRefKey1 AS Key1, ItemRefKey2 AS Key2, ItemRefKey3 AS Key3, ModifyDateTime AS ModDateTime, IntegerValue AS RetValue FROM UsageItemRecord ','WHERE UsageItemID=''CPFSubmitCount'' AND IntegerValue>0;');
end if;

commit work;
