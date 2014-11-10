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
    
    protected Map<Schema.SObjectField, Object> fieldToValue;

    public SObjectFactory()
    {
        fieldToValue = new Map<Schema.SObjectField, Object>();
    }
    
    public void setFieldToValueMapping( Map<Schema.SObjectField, Object> fieldToValue )
    {
        this.fieldToValue = fieldToValue;
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
            Sobject record = buildRecordWithData();
            mergeFields( record );
            records.add( record );
        }
        return records;
    }
    
    private void mergeFields(SObject record)
    {
        if( fieldToValue == NULL ) return;
        for( Schema.SObjectField field : fieldToValue.keySet() )
        {
            record.put( field, fieldToValue.get( field ) );
        }
    }

    abstract SObject buildRecordWithData();
}