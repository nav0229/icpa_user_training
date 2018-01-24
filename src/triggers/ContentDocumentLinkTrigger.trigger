/****************************************************************
 Name: ContentDocumentLinkTrigger
============================================================
Author: Lenny
Purpose: Trigger for ContentDocumentLink
============================================================

****************************************************************/
trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert) {
    ContentDocumentLinkTriggerHelper contentDocumentLinkHelper = new ContentDocumentLinkTriggerHelper();

	if(trigger.isBefore){
		if(trigger.isInsert){
			contentDocumentLinkHelper.beforeInsert(trigger.new);
		}
	}
}