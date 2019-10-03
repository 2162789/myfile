//
// clean up Report Designer tables
//
delete from DBA.ReportAccess where ReportExportID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.ReportExport where ReportExportID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomSearch where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomAttribute where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomTable where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomRelation where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomQuery where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.CustomVariables where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')
delete from DBA.QueryFolder where QueryFolderID in ('Confirmation Letter','Acceptance of Resign','Increment Letter','Letter of Promotion','Employment Letter')

delete from DBA.TmplVariables
delete from DBA.TmplRelation where TmplFolderID in ('ConfirmationLetter','ResignationLetter','IncrementLetter','PromotedLetter','EmploymentLetter')
delete from DBA.TmplAttribute where TmplQueryID in ('ConfirmedEmp','ResignedEmp','IncrementEmp','PromotedEmp','EmploymentEmp')
delete from DBA.TmplAttribute where TmplQueryID = 'Company' and TmplTableID = 'Company' and TmplAttributeID in ('NameOfSign','PostionOfSign','CompanyAddress')
delete from DBA.TmplTable where TmplQueryID in ('ConfirmedEmp','ResignedEmp','IncrementEmp','PromotedEmp','EmploymentEmp')
delete from DBA.TmplSearch where TmplQueryID in ('ConfirmedEmp','ResignedEmp','IncrementEmp','PromotedEmp','EmploymentEmp')
delete from DBA.TmplMember where TmplFolderID in ('ConfirmationLetter','ResignationLetter','IncrementLetter','PromotedLetter','EmploymentLetter')
delete from DBA.TmplQuery where TmplQueryID in ('ConfirmedEmp','ResignedEmp','IncrementEmp','PromotedEmp','EmploymentEmp')
delete from DBA.TmplFolderSample where TmplFolderID in ('ConfirmationLetter','ResignationLetter','IncrementLetter','PromotedLetter','EmploymentLetter')
delete from DBA.TmplFolder where TmplFolderID in ('ConfirmationLetter','ResignationLetter','IncrementLetter','PromotedLetter','EmploymentLetter')
delete from DBA.SystemFunction where SysFuncId in ('FGetBREffectiveDateDuringPeriod','FGetLatestBasicRateByPeriod','FGetCareerProEffectiveDateDuringPeriod')

Commit work;