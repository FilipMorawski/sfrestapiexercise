@IsTest
private class TestObjectControllerTest {

    private static final String TEST_NAME = 'TestName';
    private static final Decimal TEST_NUMBER_NUMBER = 10;
    private static final String TEST_PICKLIST_VALUE = 'FirstOption';
    private static final Boolean TEST_CHECKBOX_VALUE = true;

    @IsTest
    static void shouldReturnRecordWhenCorrectIdIsGiven() {
        TestCustomObject__c obj = new TestCustomObject__c(
                Name = TEST_NAME,
                NumberValue__c = TEST_NUMBER_NUMBER,
                TestPicklistValue__c = TEST_PICKLIST_VALUE,
                TestCheckboxValue__c = TEST_CHECKBOX_VALUE
        );
        insert obj;

        Test.startTest();
        TestCustomObjectWrapper result = TestObjectController.getTestObject(obj.Id);
        Test.stopTest();

        System.assert(result != null, 'Should return object');
        System.assertEquals(TEST_NAME, result.Name, 'Should return object with specified Name');
        System.assertEquals(TEST_NUMBER_NUMBER, result.numberValue, 'Should return object with specified Decimal');
        System.assertEquals(TEST_PICKLIST_VALUE, result.picklistValue, 'Should return object with specified Picklist value');
        System.assertEquals(TEST_CHECKBOX_VALUE, result.checkboxValue, 'Should return object with specified checkbox value');
    }

    @IsTest
    static void shouldReturnAuraException() {

        Exception ex;
        Test.startTest();
        try{
            TestObjectController.getTestObject(null);
        } catch (Exception e) {
            ex = e;
        }
        Test.stopTest();
        System.assert(ex != null, 'Should catch Exception');
        System.assert(ex.getCause() instanceof QueryException,
                'Should catch exception with specific type, throwed : ' + ex.getCause().getTypeName());
    }
}