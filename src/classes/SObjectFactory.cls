public abstract class SObjectFactory
{
    protected Integer counter
    {
        get
        {
            if (counter == null)
            {
                counter = 0;
            }
            counter++;
            return counter;
        }
        private set;
    }

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
    public List<SObject> buildRecords( Integer numRecords )
    {
        List<SObject> records = new List<SObject>();
        for( Integer i = 0; i < numRecords; i++ )
        {
            records.add( buildRecordWithData() );
        }
        return records;
    }

    abstract SObject buildRecordWithData();
}