pageextension 50070 BlanketPurchaseOrdersExt extends "Blanket Purchase Orders"
{
    layout
    {
        addafter("No.")
        {
            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;

            }
            field("Rate Basis"; Rec."Rate Basis")
            {
                ApplicationArea = All;

            }
            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Against Original Invoice Date"; Rec."Against Original Invoice Date")
            {
                ApplicationArea = All;

            }
            field("Against Original Invoice No."; Rec."Against Original Invoice No.")
            {
                ApplicationArea = All;

            }
            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;

            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;

            }
            field("File No."; Rec."File No.")
            {
                ApplicationArea = All;

            }
            field("Due Date calculation"; Rec."Due Date calculation")
            {
                ApplicationArea = All;

            }
            field("Brokerage Rate"; Rec."Brokerage Rate")
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
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
        //>>RPU_RC
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}