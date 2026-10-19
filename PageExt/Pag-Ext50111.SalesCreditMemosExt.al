pageextension 50111 SalesCreditMemosExt extends "Sales Credit Memos"
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
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Credit Memo');

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Credit Memo');
                //PRU_DD 1.10

            end;
        }
        modify(PostAndSend)
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post the record');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post the record');
                //PRU_DD 1.10
            end;
        }

    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //  Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Credit Memo');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}