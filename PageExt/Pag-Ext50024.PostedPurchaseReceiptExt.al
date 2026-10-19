pageextension 50024 PostedPurchaseReceiptExt extends "Posted Purchase Receipt"
{
    layout
    {
        //general
        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactEmail)
        {
            Visible = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = false;
        }
        moveafter("No."; "Buy-from Contact No.")
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
        addafter("Responsibility Center")
        {
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
            field("Brokerage Calculation Basis"; Rec."Brokerage Calculation Basis")
            {
                ApplicationArea = all;

            }
            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;

            }
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
              field("Brokerage Rate"; Rec."Brokerage Rate")
              {
                  ApplicationArea = All;

              }
          }*/
    }
    actions
    {
        addlast("&Receipt")
        {
            action("Posted Applied Delivery Challan")
            {
                Caption = 'Posted Applied Delivery Challan';

                Applicationarea = All;
                trigger OnAction()
                var
                    PurchRcptLine: Record 121;
                    PostedAppliedDeliveryChallan: Record "Posted Applied DeliveryChallan";
                // Posted Applied DeliveryChallan: Page 16635;
                begin
                    PurchRcptLine.SETRANGE("Document No.", Rec."No.");
                    PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
                    IF PurchRcptLine.FINDFIRST THEN
                        PurchRcptLine.TESTFIELD("Prod. Order No.");
                    PostedAppliedDeliveryChallan.SETRANGE("Posted Receipt No.", Rec."No.");
                    //                   IF PostedAppliedDeliveryChallan.FINDFIRST THEN;
                    //                 PAGE.RUNMODAL(PAGE::"Posted Applied DeliveryChallan", PostedAppliedDeliveryChallan);
                end;
            }
        }
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
        UserSetup: Record 91;
}