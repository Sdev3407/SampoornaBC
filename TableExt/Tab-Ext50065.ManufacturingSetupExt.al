tableextension 50065 ManufacturingSetupExt extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "Consumption Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Output Batch Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Capacity Batch Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Crate Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Hatch Capacity Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Hatch Consumption Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Hatch Output Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "CBF Capacity Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "CBF Consumption Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CBF Output Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Breeder Capacity Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Breeder Consumption Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Breeder Output Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}