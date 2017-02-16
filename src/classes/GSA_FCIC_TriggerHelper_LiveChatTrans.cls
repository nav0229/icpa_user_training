public class GSA_FCIC_TriggerHelper_LiveChatTrans{


		public static void afterInsert(List<LiveChatTranscript> newLiveChatTranscripts){
		
			Map<Id, LiveChatTranscript> caseIdMap = new Map<Id, LiveChatTranscript>();
			List<LiveChatTranscript> missedTranscripts = new List<LiveChatTranscript>();
			Map<Id, Id> skillIdMap = new Map<Id, Id>();
			Map<Id, Id> chatIdMap = new Map<Id, Id>();
			Map<Id, String> skillNamMap = new Map<Id, String>();
			Map<Id, String> chatNamMap = new Map<Id, String>();
			
			
			for(LiveChatTranscript liveChat : newLiveChatTranscripts) {
				if(liveChat.CaseId !=null){
					caseIdMap.put(liveChat.CaseId,liveChat);
					skillIdMap.put(liveChat.SkillId,liveChat.CaseId);
					chatIdMap.put(liveChat.LiveChatButtonId,liveChat.CaseId);
				}
				// Addition author: Christian Coleman
				if(liveChat.Status != null && liveChat.Status.equals('Missed')){
					missedTranscripts.add(liveChat);
				}
				// ----------------------------------
			}

			List<Skill> skillRec = [SELECT Id, MasterLabel, DeveloperName FROM Skill WHERE Id = :skillIdMap.keySet()];
			if(skillRec != null && skillRec.size() > 0){
				for(Skill ski:skillRec){
					skillNamMap.put(skillIdMap.get(ski.Id), ski.DeveloperName);
				}
			}

			List<LiveChatButton> chatRec = [SELECT Id, MasterLabel,DeveloperName FROM LiveChatButton WHERE Id = :chatIdMap.keySet()];
			if(chatRec != null && chatRec.size() > 0){
				for(LiveChatButton chat:chatRec ){
					chatNamMap.put(chatIdMap.get(chat.Id),chat.DeveloperName);
				}
			}
			
			List<Case> casRec = [SELECT Id, Live_Chat_Body__c, Live_Chat_Primary_Skill__c, Live_Chat_Button__c, Live_Chat_Start_Time__c, Live_Chat_WaitTime__c, Live_Chat_End_Time__c FROM Case WHERE Id = :caseIdMap.keySet()];
			if(casRec != null && casRec.size() > 0){  
				for(Case cas:casRec){
					cas.Live_Chat_Body__c = caseIdMap.get(cas.Id).Body;
					cas.Live_Chat_Start_Time__c = caseIdMap.get(cas.Id).StartTime;
					cas.Live_Chat_End_Time__c = caseIdMap.get(cas.Id).EndTime;
					cas.Live_Chat_WaitTime__c = caseIdMap.get(cas.Id).WaitTime;
					cas.Live_Chat_Primary_Skill__c = skillNamMap.get(cas.Id);
					cas.Live_Chat_Button__c = chatNamMap.get(cas.Id);
				}
			}
			update casRec;

			// Addition author: Christian Coleman
			// if livechat transcript has status of missed we need to create an exception object that can be used for reporting
			if(!missedTranscripts.isEmpty()){
				Set<Id> skillIds = new Set<Id>();
				Set<Id> chatButtonIds = new Set<Id>();
				for(LiveChatTranscript missedTranscript : missedTranscripts){
					skillIds.add(missedTranscript.SkillId);
					chatButtonIds.add(missedTranscript.LiveChatButtonID);
				}

				Map<Id, Skill> skillMap = new Map<Id, Skill>([SELECT Id, MasterLabel, DeveloperName FROM Skill WHERE Id = :skillIds]);
				Map<Id, LiveChatButton> chatButtonMap = new Map<Id, LiveChatButton>([SELECT Id, MasterLabel, DeveloperName FROM LiveChatButton WHERE Id = :chatButtonIds]);

				RecordType rt = getExceptionTypeAbandoned();
				List<Exception__c> exceptionObjsToCreate = new List<Exception__c>();
				for(LiveChatTranscript missedTranscript : missedTranscripts){
					Exception__c xception = new Exception__c();
					if(rt != null) {
						xception.RecordTypeId = rt.Id;
					}
					xception.Transcript_Name__c = missedTranscript.Name;
					xception.Request_Time__c = missedTranscript.RequestTime;
					xception.End_Time__c = missedTranscript.EndTime;
					xception.Primary_Skill__c = skillMap.get(missedTranscript.SkillId).MasterLabel;
					xception.Chat_Button__c = chatButtonMap.get(missedTranscript.LiveChatButtonID).MasterLabel;
					exceptionObjsToCreate.add(xception);
				}
				insert exceptionObjsToCreate;
			}
			// ----------------------------------
		}

		private static RecordType getExceptionTypeAbandoned(){
			List<RecordType> recordTypeList = [SELECT Id, SobjectType, Name 
						FROM RecordType 
						WHERE Name = 'Abandoned Chat'
						AND SobjectType = 'Exception__c' 
						LIMIT 1];
			if(!recordTypeList.isEmpty()){
				return recordTypeList.get(0);
			} else {
				return null;
			}
		}

}