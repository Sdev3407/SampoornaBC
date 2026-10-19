tableextension 50011 ItemLedgerEntryExt extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Data Entry Sheet No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_NewFieldCreted';
        }
        field(50001; "Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Rejected For Item Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50003; Fertility; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50004; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50005; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
            TableRelation = "Breed Master";
        }
        field(50006; "Lay Day Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50007; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50008; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50009; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50010; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50011; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Supplement,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Supplement",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50017; "Weak Mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50018; "Transit Mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50019; "Exclude Quantity of Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50020; "Shortcut Dimension3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU-VG';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ///ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
            end;
        }
        field(50021; "Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50022; "Debit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            OptionCaption = ' ,Debit Note';
            OptionMembers = " ","Debit Note";
        }
        field(50023; "In-transit Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50024; "Data Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Mortality - Bird,Mortality - Chicks,Culls - Bird,Culls - Chicks,Sexing Error,Bird - Sale,Infertile Egg-Hatch,Culls-Hatch,Baby Chicks-Hatch,Settable Egg-Hatch,Cracked Egg-Hatch,Waste Egg-Hatch,Commercial Eggs';
            OptionMembers = " ","Mortality - Bird","Mortality - Chicks","Culls - Bird","Culls - Chicks","Sexing Error","Bird - Sale","Infertile Egg-Hatch","Culls-Hatch","Baby Chicks-Hatch","Settable Egg-Hatch","Cracked Egg-Hatch","Waste Egg-Hatch","Commercial Eggs";
        }
        field(50025; "Laying Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Hatching Egg,Pullet Egg,Jumbo Egg,Crack Egg,Waste Egg,Misshapes Egg';
            OptionMembers = " ","Hatching Egg","Pullet Egg","Jumbo Egg","Crack Egg","Waste Egg","Misshapes Egg";
        }
        field(50026; "Hatching Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Culls,Mortality,Dead in Shell,Egg Blast,Settable Egg, Salable Eggs,Hatchable Egg,Reject/Unhatched Egg,Infertile/Commercial Egg';
            OptionMembers = " ",Culls,Mortality,"Dead in Shell","Egg Blast","Settable Egg"," Salable Eggs","Hatchable Egg","Reject/Unhatched Egg","Infertile/Commercial Egg";
        }
        field(50027; "Descriptive Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Weight Neuter,Weight Male,Weight Female,Temperature,CV,Water,Humidity,Lighting';
            OptionMembers = " ","Weight Neuter","Weight Male","Weight Female",Temperature,CV,Water,Humidity,Lighting;
        }
        field(50028; "DMR Item Type"; Option)
        {
            OptionCaption = ' ,LLP,Commercial Feed,CBF,CATTLE,SWINE';
            OptionMembers = " ",LLP,"Commercial Feed",CBF,CATTLE,SWINE;
        }
        field(50029; "Invoice No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Value Entry"."Document No." where("Item Ledger Entry Type" = field("Entry Type"),
                        "Item Ledger Entry No." = field("Entry No."),
                         "Document Type" = filter("Sales Credit Memo" | "Sales Invoice" | "Purchase INvoice" | "Purchase Credit Memo")));
        }
        field(50030; Consumption; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Consumption';
        }
        field(50031; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Region Code';
            TableRelation = Region;
        }
        field(50032; "Salesperson/Purchaser"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SalesPeople/Purchaser';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50033; "Apply Entry"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50034; "Reject"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Bardana Generation Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Manufacturing Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
        }
        field(50037; "SFPL User ID"; Text[20])
        {

            DataClassification = CustomerContent;
        }

        field(60000; "MRP Price"; Decimal)
        {
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Line"."MRP Price" WHERE("Document No." = FIELD("Document No."), "No." = FIELD("Item No.")));
        }
        field(60001; "Cust. Posting Group"; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Customer Posting Group" where("No." = field("Source No.")));
        }

    }
}