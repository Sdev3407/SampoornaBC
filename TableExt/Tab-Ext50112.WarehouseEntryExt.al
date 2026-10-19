tableextension 50112 "Warehouse Entry Ext" extends "Warehouse Entry"
{
    fields
    {
        field(50201; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
        }

        //iWMS--
    }
}