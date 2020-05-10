public with sharing class TestObjectService {

    private final TestObjectRepository repository;

    public TestObjectService() {
        this.repository = new TestObjectRepository();
    }

    public TestCustomObjectWrapper getTestObject(String id) {
        return new TestObjectToWrapperConverter().convert(repository.getRecord(id));
    }

}