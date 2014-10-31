@isTest
public class ContactFactory extends SObjectFactory
{
    public SObject buildRecordWithData()
    {
        return new Contact( LastName = 'Test Contact ' + counter );
    }
}