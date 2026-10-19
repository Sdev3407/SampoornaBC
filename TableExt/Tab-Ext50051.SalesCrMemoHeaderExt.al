tableextension 50051 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "P.A.N. No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "No. of Birds"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Farmer Grade"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50007; "Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Terms and Conditions";
        }
        field(50008; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50010; "Against Original Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Against Original Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "DC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Tier Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Total Birds"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Amt. to Customer"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line".Amount WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50021; "Driver Mobile No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            Numeric = true;
        }
        field(50022; "Broker Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Category Code';
            Description = 'Pru171220#P0272';
            //               TableRelation = "Item Category".Code WHERE("Def. Inventory Posting Group" = CONST("FG"));
        }
        field(50026; "Product Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Product Group Code';
            Description = 'Pru171220#P0272';
            //   TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(50027; "Entry Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50028; "Saels Person Name"; Code[50])
        {

            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Salesperson Code")));
            FieldClass = FlowField;
        }
        field(50029; "Branch Name"; Code[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('BRANCH'),
                                                               Code = FIELD("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }

        field(50030; "Line Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50034; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Shiiping From"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50044; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(60000; "E-Invoice Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Generated,Cancelled';
            OptionMembers = Open,Generated,Cancelled;
        }
        field(60001; "E-Invoice No."; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "E-Invoice Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "E-Invoice QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "E-Invoice Cancel Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
}