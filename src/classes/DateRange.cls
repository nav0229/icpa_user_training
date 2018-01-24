/****************************************************************
 Name: DateRange
============================================================
Author: Sahil Grover
Purpose: Hold parameters for a date range
============================================================

****************************************************************/
public with sharing class DateRange {
	public Date FromDate {get; set;}	// >= date
	public Date ToDate {get; set;}		// <= date

	public DateRange() {
		FromDate = null;
		ToDate = null;
	}
}