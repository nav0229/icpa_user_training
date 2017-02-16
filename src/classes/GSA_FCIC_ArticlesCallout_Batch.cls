global with sharing class GSA_FCIC_ArticlesCallout_Batch implements Database.Batchable<Object>, Database.AllowsCallouts {
    
    String query;
    Integer pages;

    global GSA_FCIC_ArticlesCallout_Batch(Integer p) {
        this.pages = p;
    }
    
    global List<Object> start(Database.BatchableContext BC) {
        //return Database.getQueryLocator(query);
        List<Integer> pageList = new List<Integer>();
        for(Integer i = 1; i <= pages; i++) {
            pageList.add(i);
        }

        return pageList;
    }

    global void execute(Database.BatchableContext BC, List<Object> scope) {
        if(scope.size() == 1) {

            DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
            system.debug('running '+scope[0]);
            GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,(Integer)scope[0]);
            GSA_FCIC_KDBArticles_Service.processNarratives(resp);
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}