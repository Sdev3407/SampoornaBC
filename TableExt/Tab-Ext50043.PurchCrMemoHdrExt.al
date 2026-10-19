tableextension 50043 PurchCrMemoHdrExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "Brokerage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG1.0';
            TableRelation = Vendor."No." WHERE(Broker = FILTER(true));
        }
        field(50001; "Rate Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG1.0';
            OptionCaption = ' ,EX,FOR,CIF,FOB,N/A';
            OptionMembers = " ",EX,"FOR",CIF,FOB,"N/A";
        }
        field(50002; "Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Terms and Conditions";
        }
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50004; "Against Original Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Against Original Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Creditors Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PruRaj';
            OptionCaption = ' ,SOYA CREDITORS,OTHER GRAIN CREDITORS,MEDICINE CREDITORS,CAPEX CREDITORS,SERVICE CREDITORS,IMPORT CREDITORS,MISCELLANEOUS CREDITORS,Maize Creditors,BAJRA Creditors,Wheat Creditors,Mustard DOC Creditors,D.D.G.S Creditors,DEOILED RICE BRAN Creditors,Birds Creditor,Chicks Creditor,Gen Item,Hatching Egg Outside,Premix,Rice Bran Oil,Rice Bran Polish,Rice Kanni,Lime Stone Power,Gaur Meal,Chicken Waste Meal,P.P Bags,Other,ANIMAL FEED SUPLEMENT';
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other,"ANIMAL FEED SUPLEMENT";
        }
        field(50007; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_Neelesh';
        }
        field(50008; "Mandi Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_GK MND_0.1';
            Editable = false;
        }
        field(50009; "File No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk MDN_0.1';
            Editable = false;
        }
        field(50011; "Brokerage Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "P.A.N No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Brokerage Calculation Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Suman';
            OptionCaption = ' ,Quantity Basis,Value Basis';
            OptionMembers = " ","Quantity Basis","Value Basis";
        }
        //SIM-----------Code Added-------------
        field(50050; "Transporter Code"; Code[20])
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
        field(50051; "LR/RR No."; code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50052; "LR/RR Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50053; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Transporter Code", '');
            end;
        }
        //SIM
        field(50054; "E-Way Cancelled Date"; DateTime)
        {
            Caption = 'E-Way Cancelled Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50055; "Eway Cancel Remarks"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50056; "Eway Cancel Reason"; Enum "Eway Cancel Reason")
        {
            DataClassification = CustomerContent;
        }
        field(50057; "E-Way Generated Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        //SIM-----------Code Added-------------
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