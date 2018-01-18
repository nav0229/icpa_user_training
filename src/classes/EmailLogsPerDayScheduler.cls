global with sharing class EmailLogsPerDayScheduler implements Schedulable
{
    global void execute(SchedulableContext SC)
    {
        EmailLogsPerDayBatch batch = new EmailLogsPerDayBatch();
        Database.executeBatch(batch);
    }
    
    //Calling this method will set up the Scheduler to run by default at 3 PM EST Mon-Fri
    public static void turnOnSchedule(String scheduleName)
    {
        EmailLogsPerDayScheduler schedule = new EmailLogsPerDayScheduler();
        
        //time- Second minute hour nochange nochange daysofweek
        String theTime = '0 0 15 ? * MON-FRI';
        //System.schedule('Send Update Emails', theTime, schedule);
        System.schedule(scheduleName, theTime, schedule);
    }
}