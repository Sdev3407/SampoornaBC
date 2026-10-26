tableextension 50072 GateENtryExt extends "Gate Entry Header"
{
    fields
    {
        field(50000; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50001; "Tier Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';

            trigger OnValidate()
            begin
                TESTFIELD("Gross Weight");
                "Net Weight" := "Gross Weight" - "Tier Weight";
            end;
        }
        field(50002; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            Editable = false;
        }
        field(50003; "Per Bag Freight Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50004; "Total Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50005; "Transporter Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50006; "No. of Bags"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to enter Gate Entry Details');

    end;

    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
        InventSetup1: Record "Responsibility Center";
        NoSeriesManagement: Codeunit 396;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("HO Users", FALSE);
        IF UserSetup.FINDFIRST THEN
            "Location Code" := UserSetup."Shortcut Dimension 3 Code";
    end;

    trigger OnAfterRename()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to enter Gate Entry Details');


    end;
}