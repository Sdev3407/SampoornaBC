table 50004 "Breed Variation"
{
    DataClassification = ToBeClassified;
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     06-08-14   Table Designer               New Table Created.


    fields
    {
        field(1; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Type of Line"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,A,B,C,D,Default';
            OptionMembers = " ",A,B,C,D,Default;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                ItemRec.RESET;
                ItemRec.SETRANGE("No.", "Item No.");
                IF ItemRec.FINDFIRST THEN
                    "Item Description" := ItemRec.Description;
            end;
        }
        field(4; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(5; "Template No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Template Master Header";

            trigger OnValidate()
            var
                TemMasHdrRec: Record "Template Master Header";
            begin

                TemMasHdrRec.RESET;
                TemMasHdrRec.SETRANGE("Template No.", "Template No.");
                IF TemMasHdrRec.FINDFIRST THEN
                    "Hatchery Template" := TemMasHdrRec."Hatchery Template"

            end;
        }
        field(6; "Hatchery Template"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Consumption Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
    }

    keys
    {
        key(Key1; "Breed Code", "Type of Line")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID); //S.M
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to edit breed master');
        //PRU_DD 1.10
    end;

    var
        ItemRec: Record Item;
        // TemMasHdrRec: Record "50002";
        UserSetup: Record "User Setup";
        CompanyInfo: Record "Company Information";
}

