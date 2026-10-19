table 50006 "Template Master Line"
{
    DataClassification = ToBeClassified;
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     05-08-14   Table Designer               New Table Created.


    fields
    {
        field(1; "Template No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Frequency; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Enabled = true;
            OptionCaption = ' ,Daily,Weekly,Monthly,Yearly';
            OptionMembers = " ",Daily,Weekly,Monthly,Yearly;
        }
        field(4; Occurence; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' , Daily,Weekly,Monthly,Yearly';
            OptionMembers = " "," Daily",Weekly,Monthly,Yearly;
        }
        field(6; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                IF T27.GET("Item No.") THEN
                    "Item Description" := T27.Description;
            end;
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Parameter No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Parameter Master"."No.";

            trigger OnValidate()
            begin
                recParameterMaster.RESET;
                recParameterMaster.SETRANGE("No.", "Parameter No.");
                IF recParameterMaster.FINDFIRST THEN BEGIN
                    "Parameter Description" := recParameterMaster.Description;
                    Frequency := recParameterMaster."Period UOM";
                    Remarks := recParameterMaster.Remarks;
                    //>>//PRU_RPG MNF_0.1
                    "Std. UOM" := recParameterMaster."Std UOM";
                    "Data Entry UOM" := recParameterMaster."Data Entry UOM";
                    "Data Entry Type" := recParameterMaster."Data Entry Type";
                    "Laying Entry Type" := recParameterMaster."Laying Entry Type";
                    "Hatching Entry Type" := recParameterMaster."Hatching Entry Type";
                    "Descriptive Entry Type" := recParameterMaster."Descriptive Entry Type";
                    //<<//PRU_RPG MNF_0.1
                END;

                TemplateMasterHeaderRec.RESET;
                TemplateMasterHeaderRec.SETRANGE("Template No.", "Template No.");
                IF TemplateMasterHeaderRec.FINDFIRST THEN
                    "Template For" := TemplateMasterHeaderRec."Template For";
            end;
        }
        field(12; "Parameter Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Template For"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,GP,PS,CB';
            OptionMembers = " ",GP,PS,CB;
        }
        field(14; "Frequency Start"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Frequency End"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Std. UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(17; "Data Entry UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(18; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Brooding,Growing,Developer,Pre Laying,Laying';
            OptionMembers = " ",Brooding,Growing,Developer,"Pre Laying",Laying;
        }
        field(19; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Setter,Hatcher,Production';
            OptionMembers = " ",Hatcher,Setter,Production;
        }
        field(21; "Machine Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Output Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item_Rec: Record 27;
            begin
                //>>PRU_RPG MNF_0.1

                IF Item_Rec.GET("Output Item No.") THEN
                    "Output Item Description" := Item_Rec.Description
                ELSE
                    "Output Item Description" := '';

                //<<PRU_RPG MNF_0.1
            end;
        }
        field(24; "Output Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(25; "Data Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Mortality - Bird,Mortality - Chicks,Culls - Bird,Culls - Chicks,Sexing Error,Bird - Sale,Infertile Egg-Hatch,Culls-Hatch,Baby Chicks-Hatch,Settable Egg-Hatch,Cracked Egg-Hatch,Waste Egg-Hatch,Commercial Eggs';
            OptionMembers = " ","Mortality - Bird","Mortality - Chicks","Culls - Bird","Culls - Chicks","Sexing Error","Bird - Sale","Infertile Egg-Hatch","Culls-Hatch","Baby Chicks-Hatch","Settable Egg-Hatch","Cracked Egg-Hatch","Waste Egg-Hatch","Commercial Eggs";
        }
        field(26; "Laying Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Hatching Egg,Pullet Egg,Jumbo Egg,Crack Egg,Waste Egg,Misshapes Egg';
            OptionMembers = " ","Hatching Egg","Pullet Egg","Jumbo Egg","Crack Egg","Waste Egg","Misshapes Egg";
        }
        field(27; "Hatching Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Culls,Mortality,Dead in Shell,Egg Blast,Settable Egg, Salable Eggs,Hatchable Egg,Reject/Unhatched Egg,Infertile/Commercial Egg';
            OptionMembers = " ",Culls,Mortality,"Dead in Shell","Egg Blast","Settable Egg"," Salable Eggs","Hatchable Egg","Reject/Unhatched Egg","Infertile/Commercial Egg";
        }
        field(28; "Descriptive Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Weight Neuter,Weight Male,Weight Female,Temperature,CV,Water,Humidity,Lighting';
            OptionMembers = " ","Weight Neuter","Weight Male","Weight Female",Temperature,CV,Water,Humidity,Lighting;
        }
    }

    keys
    {
        key(Key1; "Template No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TemplateMasterHdr.RESET;
        TemplateMasterHdr.SETRANGE("Template No.", "Template No.");
        IF TemplateMasterHdr.FINDFIRST THEN BEGIN
            //  Frequency := TemplateMasterHdr.Frequency;
            //  Occurence := TemplateMasterHdr.Occurence;
        END;
    end;

    var
        TemplateMasterHdr: Record 50002;
        recItem: Record 27;
        recParameterMaster: Record 50001;
        ParameterMasterRec: Record 50001;
        TemplateMasterHeaderRec: Record 50002;
        TemplateFor: Code[10];
        T27: Record 27;
}

