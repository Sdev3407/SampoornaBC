tableextension 50004 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Parameter No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "No. Series";
        }
        field(50001; "Parameter Template No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "No. Series";
        }
        field(50002; "Breed Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "No. Series";
        }
        field(50003; "Data Sheet Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "No. Series";
        }
        field(50004; "Hatchery Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "No. Series";
        }
        field(50005; "Liquidation Date Formula"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50006; "Company Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,SampoornaFeeds,Vetadd,StarFood';
            OptionMembers = " ",SampoornaFeeds,Vetadd,StarFood;
        }
        field(50007; "Run SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Location Agr. Exp Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Stop Blocked Dupl. PAN No."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Before Expiry Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Tax Invoice Mail"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50012; "St Dt"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50013; "FTx ID"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50014; "FTx Password"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50015; "Certificate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            TableRelation = "Isolated Certificate".Code;
        }
    }
}