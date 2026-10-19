pageextension 50028 PostedPurchaseCreditMemosExt extends "Posted Purchase Credit Memos"
{
    layout
    {
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify(Paid)
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
            field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
            }
            field("Brokerage Code"; Rec."Brokerage Code")
            {
                ApplicationArea = All;

            }
        }

        /*  addafter("No.")
          {
             
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
              field("E-Invoice Status"; Rec."E-Invoice Status")
              {
                  ApplicationArea = All;

              }

              field("E-Invoice No."; Rec."E-Invoice No.")
              {
                  ApplicationArea = All;

              }
              field("E-Invoice Date"; Rec."E-Invoice Date")
              {
                  ApplicationArea = All;

              }
              field("E-Invoice QR Code"; Rec."E-Invoice QR Code")
              {
                  ApplicationArea = All;

              }
              field("E-Invoice Cancel Date"; Rec."E-Invoice Cancel Date")
              {
                  ApplicationArea = All;

              }
          }*/

    }
    actions
    {
        addafter(Dimensions)
        {
            action("Generate E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;

                Applicationarea = All;

            }
            action("Cancel E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;

                Applicationarea = All;

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