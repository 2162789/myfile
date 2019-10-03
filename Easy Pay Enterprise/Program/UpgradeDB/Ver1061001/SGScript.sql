if not exists(select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'BOT Mitsubishi (G3 Bulk Payment)') then
   insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised )
   values('Salary','BOT Mitsubishi (G3 Bulk Payment)','RSingBankFormatBOTMitsubishiG3BulkPayment.dll','InvokeSalaryFormatter',0);
end if;

/* Update default Donation Code ********/
/* Basis 1 is Race */
DonationLoop1: FOR Donation1 AS Donation1Cus DYNAMIC SCROLL CURSOR FOR    
  SELECT DonationBasis1 as OUT_DonationBasis,MapDonation_mmSysId as OUT_MapDonation_mmSysId,
    	 MDMM.FormulaId as OUT_FormulaId, KeywordId as OUT_KeywordId
    FROM MapDonation as MD JOIN MapDonation_mm as MDMM on MD.MapDonationSysId = MDMM.MapDonationSysId
    JOIN formulaproperty as fp on MDMM.FormulaId = fp.FormulaId
    WHERE MD.DonationBasis1 in ('Chinese','Indian','Eurasian') AND KeywordId in ('CDACCode','SINDACode','EUCFCode')
DO 
  if OUT_DonationBasis = 'Chinese' and OUT_KeywordId = 'CDACCode' then
	   Update MapDonation_mm Set FormulaId = 'CDAC2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Indian' and OUT_KeywordId = 'SINDACode' then
       Update MapDonation_mm Set FormulaId = 'SIND2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Eurasian' and OUT_KeywordId = 'EUCFCode' then
       Update MapDonation_mm Set FormulaId = 'EUCF2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	
      end if;	    
 END FOR;
 
/* Basis 2 is Race */
 DonationLoop2: FOR Donation2 AS Donation2Cus DYNAMIC SCROLL CURSOR FOR    
  SELECT DonationBasis2 as OUT_DonationBasis,MapDonation_mmSysId as OUT_MapDonation_mmSysId,
    	 MDMM.FormulaId as OUT_FormulaId, KeywordId as OUT_KeywordId
    FROM MapDonation as MD JOIN MapDonation_mm as MDMM on MD.MapDonationSysId = MDMM.MapDonationSysId
    JOIN formulaproperty as fp on MDMM.FormulaId = fp.FormulaId
    WHERE MD.DonationBasis2 in ('Chinese','Indian','Eurasian') AND KeywordId in ('CDACCode','SINDACode','EUCFCode')
DO 
  if OUT_DonationBasis = 'Chinese' and OUT_KeywordId = 'CDACCode' then
	   Update MapDonation_mm Set FormulaId = 'CDAC2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Indian' and OUT_KeywordId = 'SINDACode' then
       Update MapDonation_mm Set FormulaId = 'SIND2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Eurasian' and OUT_KeywordId = 'EUCFCode' then
       Update MapDonation_mm Set FormulaId = 'EUCF2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	
      end if;	    
 END FOR;
 
 /* Basis 3 is Race */
 DonationLoop3: FOR Donation3 AS Donation3Cus DYNAMIC SCROLL CURSOR FOR    
  SELECT DonationBasis3 as OUT_DonationBasis,MapDonation_mmSysId as OUT_MapDonation_mmSysId,
    	 MDMM.FormulaId as OUT_FormulaId, KeywordId as OUT_KeywordId
    FROM MapDonation as MD JOIN MapDonation_mm as MDMM on MD.MapDonationSysId = MDMM.MapDonationSysId
    JOIN formulaproperty as fp on MDMM.FormulaId = fp.FormulaId
    WHERE MD.DonationBasis3 in ('Chinese','Indian','Eurasian') AND KeywordId in ('CDACCode','SINDACode','EUCFCode')
DO 
  if OUT_DonationBasis = 'Chinese' and OUT_KeywordId = 'CDACCode' then
	   Update MapDonation_mm Set FormulaId = 'CDAC2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Indian' and OUT_KeywordId = 'SINDACode' then
       Update MapDonation_mm Set FormulaId = 'SIND2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	  
  elseif OUT_DonationBasis = 'Eurasian' and OUT_KeywordId = 'EUCFCode' then
       Update MapDonation_mm Set FormulaId = 'EUCF2015' where MapDonation_mmSysId = OUT_MapDonation_mmSysId;	
      end if;	    
 END FOR;

commit work;