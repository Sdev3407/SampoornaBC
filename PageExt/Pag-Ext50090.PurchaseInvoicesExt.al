pageextension 50090 PurchaseInvoicesExt extends "Purchase Invoices"
{
    layout
    {
        moveafter("No."; "Buy-from Vendor No.")
        moveafter("Buy-from Vendor No."; "Buy-from Vendor Name")
        moveafter("Buy-from Vendor Name"; "Vendor Authorization No.")
        moveafter("Vendor Authorization No."; "Location Code")
        addafter("Assigned User ID")
        {
            field("Line Narration1"; rec."Line Narration1")
            {
                ApplicationArea = all;
            }

        }
        addafter("Buy-from Vendor Name")
        {
            field("P.A.N No."; rec."P.A.N No.")
            {
                ApplicationArea = All;
                Editable = false;

            }
        }
        modify(Amount)
        {
            Visible = false;
        }
        /*  addafter("No.")
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
          }*/
    }

    actions
    {
        // Add changes to page actions here
        modify("P&osting")
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            trigger OnAfterAction()
            begin
                CompanyInfo.Get;
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Invoice');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Purchase Invoice');
                //PRU_DD 1.10
                if (rec."Shortcut Dimension 1 Code" = 'FEED') and (rec."Shortcut Dimension 1 Code" = 'CATTLE') then
                    Rec.TestField("Brokerage Code");// suman 09-04-2024
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                    IF "Creditors Type" = 0 THEN
                        ERROR('Please enter the creditor type');
                //IF ((Rec."Responsibility Center" <> 'FEED') AND (Rec."Responsibility Center" <> 'CATTLE')) THEN
                //  Rec.TESTFIELD("Incoming Document Entry No.");
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record 312;
    begin
        //SetSecurityFilterOnRespCenter;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to view Purchase Invoices');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10



        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
        //>>RPU_RC
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        CompanyInfo: Record "Company Information";
}