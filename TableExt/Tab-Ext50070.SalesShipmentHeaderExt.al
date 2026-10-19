tableextension 50070 SalesShipmentHeaderExt extends "Sales Shipment Header"
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
        field(50004; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50005; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Freight; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOR,EX';
            OptionMembers = " ","FOR",EX;
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
        field(50009; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
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
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Document No." = FIELD("No.")));
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
        field(50030; "Line Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Team Code"; Code[20])
        {
            Caption = 'Team Code';
            DataClassification = ToBeClassified;
        }
        field(50032; "Expected Dispatch Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "OTP Varified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "OTP Varified by"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "OTP Varified at"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "SMS"; Text[160])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "OTP"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Phone No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Shiiping From"; Code[10])
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
        field(60005; "Payment QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(60006; "Pay QR Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}