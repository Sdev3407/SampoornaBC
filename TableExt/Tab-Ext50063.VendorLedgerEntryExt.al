tableextension 50063 VendorLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "VendorName"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Shortcut Dimension 3Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50003; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.005';
        }
        field(50004; "Creditors Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PruRaj';
            OptionCaption = ' ,SOYA CREDITORS,OTHER GRAIN CREDITORS,MEDICINE CREDITORS,CAPEX CREDITORS,SERVICE CREDITORS,IMPORT CREDITORS,MISCELLANEOUS CREDITORS,Maize Creditors,BAJRA Creditors,Wheat Creditors,Mustard DOC Creditors,D.D.G.S Creditors,DEOILED RICE BRAN Creditors,Birds Creditor,Chicks Creditor,Gen Item,Hatching Egg Outside,Premix,Rice Bran Oil,Rice Bran Polish,Rice Kanni,Lime Stone Power,Gaur Meal,Chicken Waste Meal,P.P Bags,Other,ANIMAL FEED SUPLEMENT';
            OptionMembers = " ","SOYA CREDITORS","OTHER GRAIN CREDITORS","MEDICINE CREDITORS","CAPEX CREDITORS","SERVICE CREDITORS","IMPORT CREDITORS","MISCELLANEOUS CREDITORS","Maize Creditors","BAJRA Creditors","Wheat Creditors","Mustard DOC Creditors","D.D.G.S Creditors","DEOILED RICE BRAN Creditors","Birds Creditor","Chicks Creditor","Gen Item","Hatching Egg Outside",Premix,"Rice Bran Oil","Rice Bran Polish","Rice Kanni","Lime Stone Power","Gaur Meal","Chicken Waste Meal","P.P Bags",Other,"ANIMAL FEED SUPLEMENT";
        }
        field(50005; "Vendor P.A.N No"; Code[20])
        {
            CalcFormula = Lookup(Vendor."P.A.N. No." WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50006; "Applied PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Security Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SFPL_Security Group";
        }
        field(50008; "Mandi Name"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50009; "SFPL User ID"; text[20])
        {
            DataClassification = ToBeClassified;
        }

    }
}