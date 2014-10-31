@isTest
private class SObjectFactoryTest
{
    private class SObjectFactoryMock extends SObjectFactory
    {
        private List<SObject> buildRecords( Integer numRecords )
        {
            List<Account> testAccounts = new List<Account>();
            for( Integer i = 0; i < numRecords; i++ )
            {
                testAccounts.add( new Account( Name = 'Account ' +i ) );
            }
            return testAccounts;
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