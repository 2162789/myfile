/* Table Keyword */
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_SGPayLPayslip';
UPDATE Keyword SET KeywordStage = 0 WHERE KeywordId = 'CR_SGPayPPayslip';
UPDATE Keyword SET KeywordStage = 1 WHERE KeywordId = 'CR_SGPayPaySum';