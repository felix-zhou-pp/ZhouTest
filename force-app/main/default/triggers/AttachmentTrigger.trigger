trigger AttachmentTrigger on Attachment(before insert, after insert, after undelete, before delete, after delete, before update, after update) {
    if (System.Label.SkipTrigger != 'TRUE' || System.Test.isRunningTest()) {
        AttachmentTriggerHandler handler = new AttachmentTriggerHandler();
        handler.run();
    }
}