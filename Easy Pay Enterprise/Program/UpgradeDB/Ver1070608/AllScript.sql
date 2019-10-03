Read UpgradeDB\Ver1070608\Entity.sql;

/* Report Option : ESS */
if not exists(select * from CoreKeyWord where CoreKeyWordId = 'RptOpToESS') then
   insert into CoreKeyWord(CoreKeyWordId,CoreKeyWordCategory,CoreKeyWordDefaultName,CoreUserDefinedName,CoreKeyWordDesc)
   values('RptOpToESS','RptOutputTo','ESS','ESS','');
end if;

commit work;