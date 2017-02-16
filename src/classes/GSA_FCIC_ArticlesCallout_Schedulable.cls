global with sharing class GSA_FCIC_ArticlesCallout_Schedulable implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new GSA_FCIC_ArticlesCallout_InitialBatch(), 1);
        
       /* DateTime todayDate = DateTime.newInstance(System.Date.today(), System.Time.newInstance(0, 0, 0, 0));
        Integer pages =0;
    if (!Test.isRunningTest()){
        GSA_FCIC_KDBArticles_WSParser.narrativeResponse resp = GSA_FCIC_KDBArticles_Service.getNarritive(todayDate,0);

        pages = resp.metadata.pages;

        GSA_FCIC_KDBArticles_Service.processNarratives(resp);
    }
        if(pages >= 1) {
            Database.executeBatch(new GSA_FCIC_ArticlesCallout_Batch(pages), 1);
        }
    */
    }
}