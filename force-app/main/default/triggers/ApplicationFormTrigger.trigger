trigger ApplicationFormTrigger on ApplicationForm__c (before insert, after insert, before update, after update) {
    ApplicationFormTriggerHandler handler = new ApplicationFormTriggerHandler();
    handler.run();
}