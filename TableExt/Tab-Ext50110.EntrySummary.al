tableextension 50110 "EntrySummary" extends "Entry Summary"
{
    fields
    {
        field(50201; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50202; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }


    }
}