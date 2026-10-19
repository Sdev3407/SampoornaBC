table 50025 "Hatchery Name"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Hatchery No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Hatchery No." <> xRec."Hatchery No." THEN BEGIN
                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("Responsibility Center");
                    RC.GET(UserSetup."Responsibility Center");
                    //IF "Document Type"="Document Type"::RGP THEN
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                END;
            end;
        }
        field(2; "Hatchery Name"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Hatchery No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Hatchery No.", "Hatchery Name")
        {
        }
    }

    var
        RespCntr: Record "Responsibility Center";
        userset: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        RC: Record "Responsibility Center";


    procedure GetNoSeriesCode(): Code[10]
    var
        userset: Record "User Setup";
    begin
        /*
        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Indent Nos.");
        EXIT(GeneralLedgerSetup."Indent Nos.");
        */
        //PRU-RC >>
        userset.GET(USERID);

        RespCntr.GET(userset."Responsibility Center");     //PRU-VG
        RespCntr.TESTFIELD("Hatchery Code");           //PRU-VG
        EXIT(RespCntr."Hatchery Code");

        //S.M               //PRU-VG
        //PRU-RC >>

    end;


    procedure TestNoSeries(): Boolean
    begin
        //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Indent Nos.");

        RespCntr.GET(userset."Responsibility Center");
        RespCntr.TESTFIELD("Hatchery Code");//PRU-VG

    end;


    procedure AssistEdit(OldIndentHeader: Record "Hatchery Name"): Boolean
    begin
        userset.GET(USERID);
        //RespCntr.GET(userset."Responsibility Center");

        GeneralLedgerSetup.GET;
        userset.GET(USERID);
        userset.TESTFIELD("Responsibility Center");  //S.m

        //GeneralLedgerSetup.GET(userset."Responsibility Center");


        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldIndentHeader."No. Series", "No. Series") THEN BEGIN
            // GeneralLedgerSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("Hatchery No.");
            EXIT(TRUE);
        END;
    end;
}

