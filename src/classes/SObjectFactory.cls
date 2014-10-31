public abstract class SObjectFactory
{
    public SObject buildRecord()
    {
        return buildRecords(1)[0];
    }

    public SObject buildAndInsertRecord()
    {
        return buildAndInsertRecords(1)[0];
    }

    public List<SObject> buildAndInsertRecords( Integer numRecords )
    {
        List<SObject> records = buildRecords( numRecords );
        insert records;
        return records;
    }
    abstract List<SObject> buildRecords( Integer numRecords );
}