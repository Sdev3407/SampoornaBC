table 50000 "Breed Master"
{
    Caption = 'Breed Master';
    DrillDownPageID = 50000;
    LookupPageID = 50000;
    DataClassification = ToBeClassified;
    fields
    
    {
        field(1; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                companyinfo.Get;
                IF "Breed Code" <> xRec."Breed Code" THEN BEGIN
                    //GeneralLedgerSetup.GET;
                    UserSetup.GET(USERID);
                    If companyinfo.SFPLCompany = companyinfo.SFPLCompany::Sampoorna then
                        UserSetup.TESTFIELD("Responsibility Center");
                    GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
                    NoSeriesMgt.TestManual(GeneralLedgerSetup."Breed Code");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Is This Sub Breed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Parent Breed"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Breed Master"."Breed Code" WHERE("Is This Sub Breed" = CONST(false));

            trigger OnValidate()
            begin
                BreedMasterRec.RESET;
                BreedMasterRec.SETRANGE("Breed Code", "Parent Breed");
                IF BreedMasterRec.FINDFIRST THEN
                    "Template No." := BreedMasterRec."Template No.";
            end;
        }
        field(5; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                ItemRec.RESET;
                ItemRec.SETRANGE("No.", "Item Code");
                IF ItemRec.FINDFIRST THEN
                    Description := ItemRec.Description;
            end;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Template No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Template Master Header";

            trigger OnValidate()
            begin
                IF "Parent Breed" <> '' THEN
                    ERROR(Text50001);
            end;
        }
        field(8; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
    }

    keys
    {
        key(Key1; "Breed Code")
        {
            Clustered = true;
        }
    }

    var
        GeneralLedgerSetup: Record "Responsibility Center";
        BreedMasterRec: Record 50000;
        Text50001: Label 'Can not change Template No. in sub breed.';
        ItemRec: Record Item;
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        companyinfo: Record "Company Information";

    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not Create Breed Master');
        //PRU_DD 1.10


        IF "Breed Code" = '' THEN BEGIN
            //GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Breed Code");
            NoSeriesMgt.InitSeries(GeneralLedgerSetup."Breed Code", xRec."No. Series", 0D, "Breed Code", "No. Series");
        END;
        IF "Breed Code" <> '' THEN BEGIN
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            Rec.VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        END;
    end;


    procedure AssistEdit(OldBreedMaster: Record 50000): Boolean
    var
        Breedmaster: Record 50000;
    begin
        if Breedmaster.FindFirst() then BEGIN
            Breedmaster := Rec;
            // GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            GeneralLedgerSetup.TESTFIELD("Parameter No");
            IF NoSeriesMgt.SelectSeries(GeneralLedgerSetup."Breed Code", OldBreedMaster."Breed Code", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Breed Code");
                Rec := Breedmaster;
                EXIT(TRUE);
            END;
        END;
    end;

}

