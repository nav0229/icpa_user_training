trigger GSA_FCIC_LiveChatTranscriptTrigger on LiveChatTranscript(before insert, before update, after insert, after update) {

        TriggerControls__c liveChatTranscriptTriggers = TriggerControls__c.getValues('LiveChatTranscript');
        boolean liveChatTranscriptTriggersAreOn = liveChatTranscriptTriggers.On__c;
        
        if(liveChatTranscriptTriggersAreOn ){
        
            if(trigger.isAfter && trigger.isInsert){
                GSA_FCIC_TriggerHelper_LiveChatTrans.afterInsert(trigger.new);
            }
        }

}