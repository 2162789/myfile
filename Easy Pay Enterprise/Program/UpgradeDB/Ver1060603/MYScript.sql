/* Table Keyword */
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_MYPayLPayslip';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_MYPayPPayslip';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_MYPayPaySum';