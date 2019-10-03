INPUT INTO SystemRpt
FROM UpgradeDB\Ver1030106\PH_SystemRpt.dat
FORMAT ASCII
BY ORDER;

INPUT INTO SystemRptComp
FROM UpgradeDB\Ver1030106\PH_SystemRptComp.dat
FORMAT ASCII
BY ORDER;

INPUT INTO RptConfig
FROM UpgradeDB\Ver1030106\PH_RptConfig.dat
FORMAT ASCII
(RptConfigId, UserId, SysRptId, RptConfigDesc, IsDefaultConfig, RptQueryId, RptFileType, DelBefIns, RptSummaryLevel, IsIndividualRpt, RptOutputTo, RptFilePath, CompressFileExt);

INPUT INTO RptCompConfig
FROM UpgradeDB\Ver1030106\PH_RptCompConfig.dat
FORMAT ASCII
BY ORDER;

INPUT INTO RptCompItemConfig
FROM UpgradeDB\Ver1030106\PH_RptCompItemConfig.dat
FORMAT ASCII
BY ORDER;