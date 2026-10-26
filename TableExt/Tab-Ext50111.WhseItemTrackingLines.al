tableextension 50111 "WhseItemTrackingLines" extends "Whse. Item Tracking Line"
{
    fields
    {
        field(50201; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;

        }
        field(50204; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }

    }
}
