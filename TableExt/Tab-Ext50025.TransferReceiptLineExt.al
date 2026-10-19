tableextension 50025 TransferReceiptLineExt extends "Transfer Receipt Line"
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
        field(50012; "New LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New LOB';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateCustomShortcutDimCode(1,"New LOB");
            end;
        }
        field(50013; "New Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Branch';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateCustomShortcutDimCode(2,"New Branch");
            end;
        }
        field(50014; "New Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Dimension Set ID';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin

                //ShowDocDim;
            end;
        }
        field(50015; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU_RPG NDF 0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
            end;
        }
        field(50016; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Transfer Receipt Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
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