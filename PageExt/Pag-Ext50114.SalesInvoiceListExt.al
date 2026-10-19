pageextension 50114 SalesInvoiceListExt extends "Sales Invoice List"
{
    layout
    {
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        /* addafter("No.")
         {
             field("P.A.N. No."; Rec."P.A.N. No.")
             {
                 ApplicationArea = All;

             }
             field("No. of Birds"; Rec."No. of Birds")
             {
                 ApplicationArea = All;

             }
             field(Weight; Rec.Weight)
             {
                 ApplicationArea = All;

             }
             field("Farmer Grade"; Rec."Farmer Grade")
             {
                 ApplicationArea = All;

             }
             field("Bank Account No."; Rec."Bank Account No.")
             {
                 ApplicationArea = All;

             }
             field("Transporter Code"; Rec."Transporter Code")
             {
                 ApplicationArea = All;

             }
             field(Freight; Rec.Freight)
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
             field("Freight Value"; Rec."Freight Value")
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
             field("DC No."; Rec."DC No.")
             {
                 ApplicationArea = All;

             }
             field("Gross Weight"; Rec."Gross Weight")
             {
                 ApplicationArea = All;

             }
             field("Net Weight"; Rec."Net Weight")
             {
                 ApplicationArea = All;

             }
             field("Tier Weight"; Rec."Tier Weight")
             {
                 ApplicationArea = All;

             }

             field(Average; Rec.Average)
             {
                 ApplicationArea = All;

             }
             field(Statistics; Rec.Statistics)
             {
                 ApplicationArea = All;

             }

             field("Driver Mobile No."; Rec."Driver Mobile No.")
             {
                 ApplicationArea = All;

             }
             field("Broker Code"; Rec."Broker Code")
             {
                 ApplicationArea = All;

             }
             field("Item Category Code"; Rec."Item Category Code")
             {
                 ApplicationArea = All;

             }

             field("Product Group Code"; Rec."Product Group Code")
             {
                 ApplicationArea = All;

             }
             field("Entry Date"; Rec."Entry Date")
             {
                 ApplicationArea = All;

             }

             field("Line Narration"; Rec."Line Narration")
             {
                 ApplicationArea = All;

             }

         }*/
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnAfterAction()
            begin
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Invoice');

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Invoice');
                Rec.TESTFIELD("Bank Account No.");
            end;
        }
    }
    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Invoice');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10



        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."HO Users" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

        //>>RPU_RC
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}