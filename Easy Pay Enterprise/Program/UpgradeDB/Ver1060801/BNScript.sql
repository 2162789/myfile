if exists(SELECT * FROM "DBA"."SubRegistry" where registryid='cashdenomination' and Subregistryid='Denomination14') then
   Update SubRegistry Set RegProperty1='',DoubleAttr=0 Where registryid='cashdenomination' and Subregistryid='Denomination14';
end if;


Commit work;