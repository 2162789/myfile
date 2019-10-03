Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Confirmation Letter','Company','Company',0,0,'Company','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Confirmation Letter','ConfirmedEmp','Confirmed Employee',0,0,'Employee','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Confirmation Letter','PersonalQuery','Basic Personal Details',0,0,'Personal','ConfirmedEmp');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Confirmation Letter','EmployeeQuery','Personal Employment Details',1,0,'Employee','ConfirmedEmp');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Acceptance of Resign','Company','Company',0,0,'Company','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Acceptance of Resign','ResignedEmp','Resigned Employee',0,0,'Employee','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Acceptance of Resign','EmployeeQuery','Personal Employment Details',1,0,'Employee','ResignedEmp');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Increment Letter','Company','Company',0,0,'Company','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Increment Letter','IncrementEmp','Increment Employee',0,0,'BasicRateProgression Natural join Employee','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Increment Letter','BasicRateProgression','Basic Rate Progression Details',0,0,'BasicRateProgression','IncrementEmp');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Letter of Promotion','Company','Company',0,0,'Company','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Letter of Promotion','PromotedEmp','Promotion Employee',0,0,'CareerProgression Natural join Employee','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Letter of Promotion','BasicRateProgression','Basic Rate Progression Details',0,0,'BasicRateProgression','PromotedEmp');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Employment Letter','Company','Company',0,0,'Company','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Employment Letter','EmploymentEmp','Offer of Employment Emplo',0,0,'Employee','');
Insert Into DBA.CustomQuery (QueryFolderID, CustomQueryID, QueryDesc,DistinctOption, GroupByOption, TableString, MasterQueryID) Values ('Employment Letter','EmployeeQuery','Personal Employment Details',1,0,'Employee','EmploymentEmp');