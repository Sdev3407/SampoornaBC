table 50041 "PO Import Buffer"
{
    //SIM
    Caption = 'PO Import Buffer';
    DrillDownPageId = "PO Import Worksheet";
    LookupPageId = "PO Import Worksheet";
    fields
    {
        field(1; "Batch Name"; Code[10])
        {
            Caption = 'Batch Name';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            // Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "File Name"; Text[50])
        {
            Caption = 'File Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Sheet Name"; Text[30])
        {
            Caption = 'Sheet Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Imported Date"; Date)
        {
            Caption = 'Imported Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; "Imported Time"; Time)
        {
            Caption = 'Imported Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Vendor Name"; Text[1024])
        {
            Caption = 'Vendor Name';
            TableRelation = Vendor.Name;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset();
                Vendor.SetRange(Name, "Vendor Name");
                if Vendor.FindFirst() then
                    "Vendor No." := Vendor."No."
                else begin
                    Vendor.SetFilter(Name, '%1', '@*' + "Vendor Name" + '*');
                    if Vendor.FindFirst() then
                        "Vendor No." := Vendor."No.";
                end;
            end;
        }

        field(8; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Brokerage Code"; Code[50])
        {
            Caption = 'Brokerage Code';
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name where(Broker = filter(true));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset();
                Vendor.SetRange(Name, "Brokerage Code");
                if Vendor.FindFirst() then
                    "Brokerage Vendor No." := Vendor."No."
                else begin
                    Vendor.SETFILTER(Name, '%1', '@*' + "Brokerage Code" + '*');
                    if Vendor.FindFirst() then
                        "Brokerage Vendor No." := Vendor."No."
                end;
                if Vendor.FindFirst() then
                    if "Brokerage Code" <> Vendor.Name then
                        "Brokerage Code" := Vendor.Name;
            end;
        }
        field(10; "Brokerage Rate"; Decimal)
        {
            Caption = 'Brokerage Rate';
            DataClassification = ToBeClassified;
        }
        field(11; "Rate Basis"; Option)
        {
            Caption = 'Rate Basis';
            DataClassification = ToBeClassified;
            OptionMembers = " ",EX,"FOR",CIF,FOB,"N/A";
        }
        field(12; "Terms Code"; Text[200])
        {
            Caption = 'Terms Code';
            DataClassification = ToBeClassified;
            TableRelation = "Terms and Conditions1";
        }

        field(13; "Mandi Name"; Text[100])
        {
            Caption = 'Mandi Name';
            DataClassification = ToBeClassified;
            TableRelation = "Mandi master" WHERE(Blocked = FILTER(false));
        }
        field(14; "Payment Method"; Text[100])
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(15; "Payment Terms Code"; Text[200])
        {
            Caption = 'Payment Terms Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";

        }
        field(16; "Location Code"; Code[35])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
            trigger OnValidate()
            var
                RecLoc: Record Location;
            begin
                RecLoc.Reset();
                RecLoc.SetRange(Code, "Location Code");
                if RecLoc.FindFirst() then begin
                    Validate("Shortcut Dimension 1 Code", RecLoc."Shortcut Dimension 1 Code");
                    Validate("Shortcut Dimension 2 Code", RecLoc."Shortcut Dimension 2 Code");
                end;
            end;
        }

        field(17; "Creditors Type"; Option)
        {
            Caption = 'Creditors Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other,"ANIMAL FEED SUPLEMENT";
        }
        field(18; "Loc Code"; Code[20])
        {
            // Caption = 'Loc Code';
            // DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                          Blocked = const(false));
        }
        field(19; "Item Name"; Text[200])
        {
            Caption = 'Item Name';
            TableRelation = Item.Description;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Reset();
                Item.SetRange(Description, "Item Name");
                if Item.FindFirst() then
                    "No." := Item."No."
                else begin
                    Item.SetFilter(Description, '%1', '@*' + "Item Name" + '*');
                    if Item.FindFirst() then
                        "No." := Item."No."
                end;
            end;
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
        }
        field(21; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            AutoFormatExpression = '';
            DataClassification = ToBeClassified;
        }
        field(22; "Vendor No."; Code[50])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
        }
        field(23; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(24; "Brokerage Vendor No."; Code[50])
        {
            Caption = 'Brokerage Vendor No.';
            DataClassification = ToBeClassified;
        }
        Field(25; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Vendor Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(26; "Order Created"; Boolean)
        {
            Caption = 'Order Created';
            DataClassification = ToBeClassified;
        }
        field(27; "Order No."; Code[30])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        field(28; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
    }
    keys
    {
        key(Key1; "Batch Name", "Line No.")
        {
        }
        key(key2; "Line No.")
        { }
    }
    //SIM
}