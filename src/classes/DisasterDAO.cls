/****************************************************************
 Name: DisasterDAO
===========n=================================================
Author: 
Purpose: Data Access Object for Disaster__c
============================================================

****************************************************************/

public interface DisasterDAO {
	Disaster__c getDisasterById(Id disasterId);
}