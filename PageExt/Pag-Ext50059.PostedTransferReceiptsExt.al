pageextension 50059 PostedTransferReceiptsExt extends "Posted Transfer Receipts"
{
    layout
    {
        addafter("No.")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("New Shortcut Dimension 1 Code"; Rec."New Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("New Shortcut Dimension 2 Code"; Rec."New Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;

            }
            field("Debit Note Type"; Rec."Debit Note Type")
            {
                ApplicationArea = All;

            }
            field("New LOB"; Rec."New LOB")
            {
                ApplicationArea = All;

            }
            field("New Branch"; Rec."New Branch")
            {
                ApplicationArea = All;

            }
            field("New Dimension Set ID"; Rec."New Dimension Set ID")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        TransshipmHeader: Record 5744;
}