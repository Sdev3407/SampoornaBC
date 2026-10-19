tableextension 50054 SalesInvoiceHeaderExt extends "Sales Invoice Header"
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
            // TableRelation = Vendor."No." where(Transporter = filter(True));
            trigger OnValidate()
            var
                Transporter: Record Vendor;
            begin
                if Transporter.get("Transporter Code") then
                    "Transporter Name" := Transporter.Name;
            end;
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
        field(50033; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Transporter Code", '');
            end;
        }
        field(50035; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        //SIM
        field(50059; "E-Way Cancelled Date"; DateTime)
        {
            Caption = 'E-Way Cancelled Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50061; "Eway Cancel Remarks"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50060; "Eway Cancel Reason"; Enum "Eway Cancel Reason")
        {
            DataClassification = CustomerContent;
        }
        field(50062; "E-Way Generated Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50063; "Shiiping From"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }

        //SIM
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
        field(60005; "Payment QR Code"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(60006; "Pay QR Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "Payment QR Code1"; Media)
        {
            DataClassification = ToBeClassified;
            //  SubType = Bitmap;
        }
        field(60008; "Sms Sent"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }
}