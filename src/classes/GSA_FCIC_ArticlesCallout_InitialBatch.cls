global with sharing class GSA_FCIC_ArticlesCallout_InitialBatch implements Database.Batchable<Object>, Database.AllowsCallouts, Database.Stateful {
	
	String query;
	Integer pages;
	
	global GSA_FCIC_ArticlesCallout_InitialBatch() {
		
	}
	
	global List<Object> start(Database.BatchableContext BC) {
		List<Integer> pageList = new List<Integer>();
		pageList.add(0);
		return pageList;
	}

   	global void execute(Database.BatchableContext BC, List<Object> scope) {
		DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
        pages = 0;
        GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,(Integer)scope[0]);

        pages = resp.metadata.pages;
        system.debug('CHECKING NEW PAGES '+pages);
        GSA_FCIC_KDBArticles_Service.processNarratives(resp);
	}
	
	global void finish(Database.BatchableContext BC) {
		system.debug('CHECKING PAGES '+pages);
		 if(pages > 1) {
            Database.executeBatch(new GSA_FCIC_ArticlesCallout_Batch(pages), 1);
        }
	}
	
}