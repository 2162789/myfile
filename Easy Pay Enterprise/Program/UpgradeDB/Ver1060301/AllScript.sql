READ UpgradeDB\Ver1060301\Entity.sql;
READ UpgradeDB\Ver1060301\StoredProc.sql;
READ UpgradeDB\Ver1060301\Keyword_Export.sql;
READ UpgradeDB\Ver1060301\TaskData.sql;

if not exists(select * from LeaveReason where LeaveReasonId = 'BF Adjustment') then
   Insert into LeaveReason Values('BF Adjustment','BF Adjustment');
end if;

commit work;