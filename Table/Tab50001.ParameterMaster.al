table 50001 "Parameter Master"
{
    DataClassification = ToBeClassified;
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     01-08-14   Table Designer               New Table Created.

    Caption = 'Parameter Master';
    DrillDownPageID = 50001;
    LookupPageID = 50001;
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type of Parameter"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Consumption,Output,Direct/Indirect Cost,Descriptive';
            OptionMembers = " ",Consumption,Output,"Direct/Indirect Cost",Descriptive;
        }
        field(4; "Period Length"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Period UOM"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Yearly';
            OptionMembers = " ",Daily,Weekly,Monthly,Yearly;
        }
        field(6; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Parameter For"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,GP,PS,CB';
            OptionMembers = " ",GP,PS,CB;
        }
        field(8; "Std Calculation Base"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","None",Flock,Piece;
        }
        field(9; "Std UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(10; "Data Entry UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(11; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Hatchery Parameter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Include With Cost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            TableRelation = "Machine Center";

            trigger OnValidate()
            begin
                ///>>PRU_RPG MNF_0.1
                IF ("Type of Parameter" <> "Type of Parameter"::"Direct/Indirect Cost") THEN
                    ERROR('Type of Parameter must have value "Direct/Indirect Cost"');
                //<<PRU_RPG MNF_0.1
            end;
        }
        field(15; "Production Order Qty."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(17; "Mortality Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female,Neuter';
            OptionMembers = " ",Male,Female,Neuter;
        }
        field(18; "Make Mandatory In a Week"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Exclude Quantity of Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Data Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Mortality - Bird,Mortality - Chicks,Culls - Bird,Culls - Chicks,Sexing Error,Bird - Sale,Infertile Egg-Hatch,Culls-Hatch,Baby Chicks-Hatch,Settable Egg-Hatch,Cracked Egg-Hatch,Waste Egg-Hatch,Commercial Eggs';
            OptionMembers = " ","Mortality - Bird","Mortality - Chicks","Culls - Bird","Culls - Chicks","Sexing Error","Bird - Sale","Infertile Egg-Hatch","Culls-Hatch","Baby Chicks-Hatch","Settable Egg-Hatch","Cracked Egg-Hatch","Waste Egg-Hatch","Commercial Eggs";
        }
        field(21; "In-transit Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Type of Parameter" = "Type of Parameter"::Descriptive THEN
                    TESTFIELD("In-transit Mortality", FALSE);
                IF "Type of Parameter" = "Type of Parameter"::Output THEN
                    TESTFIELD("In-transit Mortality", FALSE);
            end;
        }
        field(22; "Reversal Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG RSE_0.1';

            trigger OnValidate()
            begin
                IF ("Type of Parameter" = "Type of Parameter"::" ") THEN
                    ERROR('Type of parameter must be consumption');
            end;
        }
        field(23; "Laying Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Hatching Egg,Pullet Egg,Jumbo Egg,Crack Egg,Waste Egg,Misshapes Egg';
            OptionMembers = " ","Hatching Egg","Pullet Egg","Jumbo Egg","Crack Egg","Waste Egg","Misshapes Egg";
        }
        field(24; "Hatching Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Culls,Mortality,Dead in Shell,Egg Blast,Settable Egg, Salable Eggs,Hatchable Egg,Reject/Unhatched Egg,Infertile/Commercial Egg';
            OptionMembers = " ",Culls,Mortality,"Dead in Shell","Egg Blast","Settable Egg"," Salable Eggs","Hatchable Egg","Reject/Unhatched Egg","Infertile/Commercial Egg";
        }
        field(25; "Descriptive Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Weight Neuter,Weight Male,Weight Female,Temperature,CV,Water,Humidity,Lighting';
            OptionMembers = " ","Weight Neuter","Weight Male","Weight Female",Temperature,CV,Water,Humidity,Lighting;
        }
        field(26; "Make Mandatory In Daily"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Suman';
            OptionCaption = ' ,Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG';
            OptionMembers = " ",Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not Create Parameter Master');
        //PRU_DD 1.10




        IF "No." = '' THEN BEGIN
            //UserSetup.GET(USERID);
            /*
             UserSetup.TESTFIELD("Responsibility Center");
             IF UserSetup."Responsibility Center" <> '' THEN BEGIN
               RCSetup.GET(UserSetup."Responsibility Center");
               NoSeriesMgt.InitSeries(RCSetup."Parameter Nos.",xRec."No. Series",0D,"No.","No. Series");
             END ELSE BEGIN
             */
            //GeneralLedgerSetup.GET;
            Companyinfo.get;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            if Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            GeneralLedgerSetup.TESTFIELD("Parameter No");
            NoSeriesMgt.InitSeries(GeneralLedgerSetup."Parameter No", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        IF "No." <> '' THEN BEGIN
            UserSetup.GET(USERID);
            if Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then begin
                UserSetup.TESTFIELD("Responsibility Center");
                Rec.VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
            end;
        END;

    end;

    var
        GeneralLedgerSetup: Record 5714;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RCSetup: Record 5714;
        UserSetup: Record 91;
        Companyinfo: Record "Company Information";

    procedure AssistEdit(OldParameter: Record 50001): Boolean
    var
        Parameter: Record 50001;
    begin
        WITH Parameter DO BEGIN
            Parameter := Rec;
            UserSetup.GET(USERID);
            /*
            UserSetup.TESTFIELD("Responsibility Center");
            IF UserSetup."Responsibility Center" <> '' THEN BEGIN
              RCSetup.GET(UserSetup."Responsibility Center");
              IF NoSeriesMgt.SelectSeries(RCSetup."Parameter Nos.",OldParameter."No. Series","No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := Parameter;
                EXIT(TRUE);
              END;
            END ELSE BEGIN
            */
            //GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            IF NoSeriesMgt.SelectSeries(GeneralLedgerSetup."Parameter No", OldParameter."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := Parameter;
                EXIT(TRUE);
            END;
        END;
        //END;
    end;
}

