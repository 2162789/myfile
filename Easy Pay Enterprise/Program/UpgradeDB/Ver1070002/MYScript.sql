/* Update the Start Day/End Day */
Update SubPeriodTemplate Set StartDay = '1' Where StartDay = 'B - New Join';
Update SubPeriodTemplate Set EndDay = '1' Where EndDay = 'B - New Join';
Update LeaveCutOffDate Set CutOffFromDay = '1' Where CutOffFromDay = 'B - New Join';
Update LeaveCutOffDate Set CutOffEndDay = '1' Where CutOffEndDay = 'B - New Join';

commit work;