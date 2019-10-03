if not exists(select 1 from sys.syscolumns where tname='OutboxMessageAttachment' and cname='OutboxMsgFileSize') then
    alter table DBA.OutboxMessageAttachment Add OutboxMsgFileSize integer;
end if;

if not exists(select 1 from sys.syscolumns where tname='OutboxMessageAttachment' and cname='OutboxMsgFilePageCount') then
    alter table DBA.OutboxMessageAttachment Add OutboxMsgFilePageCount integer;
end if;

commit work;