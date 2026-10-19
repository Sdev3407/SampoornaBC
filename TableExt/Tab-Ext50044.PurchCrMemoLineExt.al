tableextension 50044 PurchCrMemoLineExt extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "QC Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50001; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-RK';
        }
        field(50002; "Challan Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-003';

            trigger OnValidate()
            begin

            end;
        }
        field(50003; "Weight Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-003';

            trigger OnValidate()
            begin
            end;
        }
        field(50004; "Excess Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-003';
        }
        field(50005; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
            Editable = false;
            TableRelation = "Indent Line"."Document No.";
        }
        field(50006; "Indent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
            Editable = false;
            TableRelation = "Indent Line"."Line No." WHERE("Document No." = FIELD("Indent No."));
        }
        field(50007; "Bag Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
            TableRelation = Item;

            trigger OnValidate()
            begin
            end;
        }
        field(50008; "Bag Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            Description = 'PRU-FE-001';

            trigger OnValidate()
            begin


            end;
        }
        field(50009; "Parent Bag Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
        }
        field(50010; "Quantity With Bag"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
        }
        field(50011; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50012; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50013; "Week Bird Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50014; "Transit Mortality Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50015; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(50016; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50017; "Extra Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50018; "Short Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50019; "Actual Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50020; "Location State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            FieldClass = Normal;
        }
        field(50021; "Tax Free"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH 1.1';
        }
        field(50022; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "TDS Section Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}