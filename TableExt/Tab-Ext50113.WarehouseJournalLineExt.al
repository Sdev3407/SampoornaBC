tableextension 50113 "WarehouseJournalLineExt" extends "Warehouse Journal Line"
{
    // version Wisnpire

    fields
    {


        field(50201; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
        }
        field(50202; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }


    }
}

