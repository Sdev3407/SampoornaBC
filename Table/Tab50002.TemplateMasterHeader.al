table 50002 "Template Master Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Template Master Header';
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     04-08-14   Table Designer               New Table Created.

    DrillDownPageID = 50002;
    LookupPageID = 50002;

    fields
    {
        field(1; "Template No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Template No." <> xRec."Template No." THEN BEGIN

                    UserSetup.GET(USERID);
                    /*
                    UserSetup.TESTFIELD("Responsibility Center");
                    IF UserSetup."Responsibility Center" <> '' THEN BEGIN
                      RCSetup.GET(UserSetup."Responsibility Center");
                      NoSeriesMgt.InitSeries(RCSetup."Invoice Nos.",xRec."No. Series",0D,"Template No.","No. Series");
                    END ELSE BEGIN
                    */
                    //GeneralLedgerSetup.GET;

                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("Responsibility Center");
                    GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
                    NoSeriesMgt.TestManual(GeneralLedgerSetup."Parameter Template No");
                    "No. Series" := '';
                    //END;
                END;

            end;
        }
        field(3; "Type of Line"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,A,B,C,D,Default';
            OptionMembers = " ",A,B,C,D,Default;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Template For"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,GP,PS,CB';
            OptionMembers = " ",GP,PS,CB;
        }
        field(11; "Hatchery Template"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
    }

    keys
    {
        key(Key1; "Template No.", "Template For")
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
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not Create Template Master');
        //PRU_DD 1.10


        IF "Template No." = '' THEN BEGIN
            //GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            companyinfo.Get;
            if companyinfo.SFPLCompany = companyinfo.SFPLCompany::Sampoorna Then
                UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Parameter Template No");
            NoSeriesMgt.InitSeries(GeneralLedgerSetup."Parameter Template No", xRec."No. Series", 0D, "Template No.", "No. Series");
        END;
        IF "Template No." <> '' THEN BEGIN
            UserSetup.GET(USERID);
            if companyinfo.SFPLCompany = companyinfo.SFPLCompany::Sampoorna Then Begin
                UserSetup.TESTFIELD("Responsibility Center");
                Rec.VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
            End;
        END;
    end;

    var
        GeneralLedgerSetup: Record 5714;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recParameterMaster: Record 50001;
        UserSetup: Record 91;
        RCSetup: Record 5714;
        companyinfo: Record "Company Information";


    procedure AssistEdit(OldParameter: Record 50002): Boolean
    var
        Parameter: Record 50002;
    begin
        WITH Parameter DO BEGIN
            Parameter := Rec;
            UserSetup.GET(USERID);
            /*
            UserSetup.TESTFIELD("Responsibility Center");
            IF UserSetup."Responsibility Center" <> '' THEN BEGIN
              RCSetup.GET(UserSetup."Responsibility Center");
              IF NoSeriesMgt.SelectSeries(RCSetup."Invoice Nos.",OldParameter."No. Series","No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Template No.");
                Rec := Parameter;
                EXIT(TRUE);
              END;
            END ELSE BEGIN
            */
            //GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
            IF NoSeriesMgt.SelectSeries(GeneralLedgerSetup."Parameter Template No", OldParameter."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Template No.");
                Rec := Parameter;
                EXIT(TRUE);
            END;
            // END;
        END;

    end;
}

