if exists (select 1 from sys.syscolumns where tname='ExpiredLeaveRecord') then
   drop table ExpiredLeaveRecord;
end if;

commit work;