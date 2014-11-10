@isTest
private class SObjectFactoryTest
{
    private class SObjectFactoryMock extends SObjectFactory
    {
        public SObject buildRecordWithData()
        {
            return new Account( Name = 'Account ' + counter );
        }
    }

    static testMethod void buildRecords()
    {
        final Integer NUM_RECORDS = 10;
        Test.startTest();
            List<Account> testAccounts = new SObjectFactoryMock().buildRecords(NUM_RECORDS);
        Test.stopTest();
        System.assertEquals( NUM_RECORDS, testAccounts.size(),
            'The correct number of records should have been built');
        for( Account testAccount : testAccounts )
        {
            System.assertNotEquals( NULL, testAccount, 'Null should never be returned' );
        }
    }
    
    static testMethod void buildRecords_hasFieldTovalueMap()
    {
        final Integer NUM_RECORDS = 10;
        final String EXPECTED_FIELD_VALUE = 'www.example.com';
        Map<Schema.SObjectField, Object> fieldtoValue = new Map<Schema.SObjectField, Object>{ Account.Website => EXPECTED_FIELD_VALUE }; 
        SObjectFactoryMock factoryMock = new SObjectFactoryMock();
        factoryMock.setFieldToValueMapping(fieldToValue);
        Test.startTest();
            List<Account> testAccounts = factoryMock.buildRecords(NUM_RECORDS);
        Test.stopTest();
        System.assertEquals( NUM_RECORDS, testAccounts.size(),
            'The correct number of records should have been built');
        for( Account testAccount : testAccounts )
        {
            System.assertNotEquals( NULL, testAccount, 'Null should never be returned' );
            System.assertequals( EXPECTED_FIELD_VALUE, testAccount.Website, 'The factory should set the fields correctly' );
        }
    }

    static testMethod void buildAndInsertRecords()
    {
        final Integer NUM_RECORDS = 10;
        Test.startTest();
            List<Account> testAccounts = new SObjectFactoryMock().buildAndInsertRecords(NUM_RECORDS);
        Test.stopTest();
        System.assertEquals( NUM_RECORDS, testAccounts.size(),
            'The correct number of records should have been built');
        for( Account testAccount : testAccounts )
        {
            System.assertNotEquals( NULL, testAccount.Id, 'All of the accounts should have been inserted' );
        }
    }

    static testMethod void buildRecord()
    {
        Test.startTest();
            SObject record = new SObjectFactoryMock().buildRecord();
        Test.stopTest();

        System.assertNotEquals( NULL, record, 'Null should never be returned' );
    }

    static testMethod void buildAndInsertRecord()
    {
        Test.startTest();
            SObject record = new SObjectFactoryMock().buildAndInsertRecord();
        Test.stopTest();

        System.assertNotEquals( NULL, record, 'Null should never be returned' );
        System.assertNotEquals( NULL, record.Id, 'The record should have been inserted' );
    }
}