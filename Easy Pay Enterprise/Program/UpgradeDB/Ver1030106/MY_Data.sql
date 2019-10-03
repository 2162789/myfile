INPUT INTO SystemRpt
FROM UpgradeDB\Ver1030106\MY_SystemRpt.dat
FORMAT ASCII
BY ORDER;

INPUT INTO SystemRptComp
FROM UpgradeDB\Ver1030106\MY_SystemRptComp.dat
FORMAT ASCII
BY ORDER;

INPUT INTO RptConfig
FROM UpgradeDB\Ver1030106\MY_RptConfig.dat
FORMAT ASCII
(RptConfigId, UserId, SysRptId, RptConfigDesc, IsDefaultConfig, RptQueryId, RptFileType, DelBefIns, RptSummaryLevel, IsIndividualRpt, RptOutputTo, RptFilePath, CompressFileExt);

INPUT INTO RptCompConfig
FROM UpgradeDB\Ver1030106\MY_RptCompConfig.dat
FORMAT ASCII
BY ORDER;

INPUT INTO RptCompItemConfig
FROM UpgradeDB\Ver1030106\MY_RptCompItemConfig.dat
FORMAT ASCII
BY ORDER;