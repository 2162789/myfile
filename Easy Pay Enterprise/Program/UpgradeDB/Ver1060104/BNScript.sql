READ UpgradeDB\Ver1060104\BN_SCP2010.sql;

If not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PaySCPSubmissRpt') then
   insert into ModuleScreenGroup Values ('PaySCPSubmissRpt','PayReports','SCP Submission Report','Pay',0,0,0,'')
end if;

commit work;