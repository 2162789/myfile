/* IR8A Remission / Exempt / Non-Taxable Indicator */
Update YEKeyWord Set YEKeyWordDefaultName = 'Tax Remission on Overseas Cost of Living Allowance (OCLA)', YEKeyWorduserDefinedName = 'Tax Remission on Overseas Cost of Living Allowance (OCLA)' Where YEKeyWordId = 'IncomeTypeOCLA';
Update YEKeyWord Set YEKeyWordDefaultName = 'Overseas Pension Fund with Tax Concession', YEKeyWorduserDefinedName = 'Overseas Pension Fund with Tax Concession' Where YEKeyWordId = 'IncomeTypeOPFTC';
Update YEKeyWord Set YEKeyWordDefaultName = 'Income from Overseas Employment', YEKeyWorduserDefinedName = 'Income from Overseas Employment' Where YEKeyWordId = 'IncomeTypeOE';
Update YEKeyWord Set YEKeyWordDefaultName = 'Income from Overseas Employment and Overseas Pension Fund with Tax Concession', YEKeyWorduserDefinedName = 'Income from Overseas Employment and Overseas Pension Fund with Tax Concession' Where YEKeyWordId = 'IncomeTypeOEOPFTC';

commit work;