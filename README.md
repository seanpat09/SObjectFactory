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

And I would create these methods for EVERY sObject I was creating in test classes.

I abstracted out the common logic and now you only have to create one class and implement one method:

```
@isTest
public class AccountFactory extends SObjectFactory
{
    public SObject buildRecordWithData()
    {
        return new Account( Name = 'Test Account ' + counter );
    }
}
```

Then you can call all of the abstracted methods:
```
AccountFactory factory = new AccountFactory();
List<Account> accountInstances = factory.buildRecords(10); 

List<Account> insertedAccounts = factory.buildAndInsertRecords(10);

Account accountInstance = (Account)factory.buildRecord();

Account insertedAccount = (Account)factory.buildAndInsertRecord();
```

You can also pass in a map of fields to values:
```
final String EXPECTED_FIELD_VALUE = 'www.example.com';

Map<Schema.SObjectField, Object> fieldtoValue
    = new Map<Schema.SObjectField, Object>{ Account.Website => EXPECTED_FIELD_VALUE }; 

AccountFactory factory = new AccountFactory();
factory.setFieldToValueMapping( fieldtoValue );
Account accountInstance = factory.buildRecord();
System.assertEquals( EXPECTED_FIELD_VALUE, accountInstance.Website );
```

**But aren't you worried about class explosion?**

Not at all! I'd much rather have a bunch of classes that do one thing than one giant class 
that tries to do everything. Each factory only know what it needs to produce its ouput and can 
be customized to handle any unique logic to pertains to a particular SObject.

