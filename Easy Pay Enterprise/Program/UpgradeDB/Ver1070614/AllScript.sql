Update CoreKeyWord Set CoreKeyWordDefaultName = 'ESS Cloud', CoreUserDefinedName = 'ESS Cloud' Where CoreKeyWordId = 'RptOpToESS';

if not exists(select * from sys.syscolumns where tname = 'iLeaveApplication' and cname = 'LveAppRefId') then
	ALTER TABLE iLeaveApplication ADD LveAppRefId char(20);
end if;

if not exists(select * from sys.syscolumns where tname = 'LeaveApplication' and cname = 'LveAppRefId') then
	ALTER TABLE LeaveApplication ADD LveAppRefId char(20);
end if;

commit work;