public with sharing class TestObjectController {

    private static TestObjectService service;

    static {
        service = new TestObjectService();
    }

    @AuraEnabled(cacheable = true)
    public static TestCustomObjectWrapper getTestObject(String id) {
        try {
            return service.getTestObject(id);
        }catch(Exception e) {
            throw AuraExceptionHandler.builder()
                    .withException(e)
                    .build()
                    .getAuraException();
        }
    }

}