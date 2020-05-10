public with sharing class TestObjectToWrapperConverter {

    public TestCustomObjectWrapper convert(TestCustomObject__c obj) {
        return TestCustomObjectWrapper.builder()
                .withName(obj.Name)
                .withId(obj.Id)
                .withNumberValue(obj.NumberValue__c)
                .withCheckboxValue(obj.TestCheckboxValue__c)
                .withPicklistValue(obj.TestPicklistValue__c)
                .build();
    }

}