tableextension 50094 PostedGateEntryH extends "Posted Gate Entry Header"
{
    fields
    {
        field(50000; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50001; "Tier Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';

            trigger OnValidate()
            begin
                TESTFIELD("Gross Weight");
                "Net Weight" := "Gross Weight" - "Tier Weight";
            end;
        }
        field(50002; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            Editable = false;
        }
        field(50003; "Per Bag Freight Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50004; "Total Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50005; "Transporter Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50006; "No. of Bags"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}