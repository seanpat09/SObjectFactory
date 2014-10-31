@isTest
public class ContactFactory extends SObjectFactory
{
    public List<SObject> buildRecords( Integer numRecords )
    {
        List<Contact> testContacts = new List<Contact>();
        for( Integer i = 0; i < numRecords; i++ )
        {
            testContacts.add( new Contact( LastName = 'Test Contact ' + i ) );
        }
        return testContacts;
    }
}