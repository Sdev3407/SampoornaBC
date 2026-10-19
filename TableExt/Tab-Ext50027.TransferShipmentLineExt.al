tableextension 50027 TransferShipmentLineExt extends "Transfer Shipment Line"
{
    fields
    {
        field(50000; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Breed Master";
        }
        field(50001; "RPO Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50002; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50003; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50004; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50005; "Weak Bird Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50006; "Transit Mortality Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50007; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(50008; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50009; "Flock Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            Editable = false;
        }
        field(50010; "Location State code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            FieldClass = Normal;
        }
        field(50011; "Total Taxable Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
        }
        field(50012; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Transfer Shipment Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50017; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; MRP; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }

    }
}