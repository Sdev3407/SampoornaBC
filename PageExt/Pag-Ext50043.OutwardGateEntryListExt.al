pageextension 50043 OutwardGateEntryListExt extends "Outward Gate Entry List"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
        }
        addafter("Entry Type")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Tier Weight"; Rec."Tier Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Per Bag Freight Charges"; Rec."Per Bag Freight Charges")
            {
                ApplicationArea = All;
            }
            field("Total Freight Amount"; Rec."Total Freight Amount")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("No. of Bags"; Rec."No. of Bags")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        
        // Add changes to page actions here
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not insert new record');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Inward Gate Entry List');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Gate In & Gate Out", '%1', UserSetup."Access Gate In & Gate Out"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Location Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var
        UserSetup: Record 91;
}