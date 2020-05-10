public with sharing class TestCustomObjectWrapper {

    @AuraEnabled public String id {get; set;}
    @AuraEnabled public String name {get; set;}
    @AuraEnabled public Decimal numberValue {get; set;}
    @AuraEnabled public Boolean checkboxValue {get; set;}
    @AuraEnabled public String picklistValue {get; set;}

    public static TestCustomObjectWrapperBuilder builder() {
        return new TestCustomObjectWrapperBuilder();
    }

    public class TestCustomObjectWrapperBuilder {

        private TestCustomObjectWrapper record;

        private TestCustomObjectWrapperBuilder() {
            this.record = new TestCustomObjectWrapper();
        }

        public TestCustomObjectWrapperBuilder withId(String id) {
            this.record.id = id;
            return this;
        }

        public TestCustomObjectWrapperBuilder withName(String name) {
            this.record.name = name;
            return this;
        }

        public TestCustomObjectWrapperBuilder withNumberValue(Decimal numberValue) {
            this.record.numberValue = numberValue;
            return this;
        }

        public TestCustomObjectWrapperBuilder withCheckboxValue(Boolean checkboxValue) {
            this.record.checkboxValue = checkboxValue;
            return this;
        }

        public TestCustomObjectWrapperBuilder withPicklistValue(String picklistValue) {
            this.record.picklistValue = picklistValue;
            return this;
        }

        public TestCustomObjectWrapper build() {
            return this.record.clone();
        }
    }
}