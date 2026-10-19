tableextension 50049 ReservationEntryExt extends "Reservation Entry"
{
    fields
    {
        field(50000; Fertility; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50001; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50002; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
            TableRelation = "Breed Master";
        }
        field(50003; "Lay Day Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50006; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }
    }
}