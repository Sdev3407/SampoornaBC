pageextension 50033 PostedPurchaseInvoicesExt extends "Posted Purchase Invoices"
{
    layout
    {
        modify("Vendor Invoice No.")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        addafter("Amount Including VAT")
        {
            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;

            }
        }
        addafter("Location Code")
        {
            field("Pre-Assigned No."; rec."Pre-Assigned No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("No. Printed")
        {
            field("Rate Basis"; Rec."Rate Basis")
            {
                ApplicationArea = All;
            }
            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;
            }
        }
        /*addafter("No.")
        {
            
           
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
           
        }*/
    }
    actions
    {
        addafter(Navigate)
        {
            action("Self Invoice")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50032;
            }
        }
    }
    trigger OnOpenPage()
    begin

        //<<PRU_RC
        UserSetup.GET(USERID);
        //FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        //FILTERGROUP(0);
    end;

    var
        UserSetup: Record 91;
}