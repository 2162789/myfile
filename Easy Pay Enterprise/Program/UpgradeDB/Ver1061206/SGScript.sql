Read UpgradeDB\Ver1061206\CPF_20152016JanPR3Full.sql;

/*Report Export Data*/

delete from reportaccess where ReportExportID='key employment terms';
delete from reportexport where ReportExportID in('key employment terms','0x545046300954707052');
Read UpgradeDB\Ver1061206\ReportExport.sql;

if not exists(select * from ReportAccess where ReportExportID='Key Employment Terms') then
   insert into ReportAccess(ReportExportID,UserGroupId) values('Key Employment Terms','MAG');
end if;

commit work;