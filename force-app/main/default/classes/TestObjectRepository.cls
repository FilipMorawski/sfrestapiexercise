
public with sharing class TestObjectRepository {

    public TestCustomObject__c getRecord(String id) {
        return
        [
            SELECT Id, Name, NumberValue__c, TestPicklistValue__c, TestCheckboxValue__c
            FROM TestCustomObject__c
            WHERE Id = :id
            LIMIT 1
        ];
    }

}