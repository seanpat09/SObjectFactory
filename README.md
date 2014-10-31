SObjectFactory
==============

Typically I created one GIANT SObjectFactory class, and that's just sloppy. Basically it would follow this format:

```
public static Account buildAccount()
{
    return buildAccounts(1)[0];
}

public static Account buildAndInsertAccount()
{
    return buildAndInsertAccounts(1)[0];
}

public static List<Account> buildAccounts( Integer numOfAccounts )
{
    List<Account> testAccounts = new List<Account>();
    for( Integer i = 0; i < numOfAccounts; i++ )
    {
        testAccounts.add( new Account( Name = 'Account ' + i ) );
    }
    return testAccounts;
}

public static List<Account> buildAndInsertAccounts( Integer numOfAccounts )
{
    List<Account> testAccounts = buildAccounts( numOfAccounts );
    insert testAccounts;
    return testAccounts;
}
```

And I would create these methods for EVERY sObject I was creating in test classes. I abstracted out the common logic
and now you only have to created one class and implement one method:

```
@isTest
public class AccountFactory extends SObjectFactory
{
    public List<SObject> buildRecords( Integer numRecords )
    {
        List<Account> testAccounts = new List<Account>();
        for( Integer i = 0; i < numRecords; i++ )
        {
            testAccounts.add( new Account( Name = 'Test Account ' + i ) );
        }
        return testAccounts;
    }
}
```
