pageextension 50026 PostedPurchaseInvoiceExt extends "Posted Purchase Invoice"
{
    layout
    {
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
        modify("VAT Reporting Date")
        {
            Visible = false;
        }

        modify("No. Printed")
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
        moveafter("No."; "Buy-from Contact No.")
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
        moveafter("Order No."; "Pre-Assigned No.")
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
            field("Brokerage Rate"; Rec."Brokerage Rate")
            {
                ApplicationArea = All;

            }
        }
        ////invoice
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }

        movefirst("Invoice Details"; "Pay-to")
        addbefore("Pay-to Name")
        {
            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Shortcut Dimension 1 Code"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Due Date")
        moveafter("Pmt. Discount Date"; "Payment Method Code")
        ///shipping
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Remit-to")
        {
            Visible = false;
        }
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Contact"; "Location Code")
        moveafter("Location Code"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Expected Receipt Date")
        ///foreign trade
        addbefore("Tax Information")
        {
            group("Foreign Trade")
            {

            }
        }
        movefirst("Foreign Trade"; "Currency Code")
        ///tax info
        modify("Without Bill Of Entry")
        {
            Visible = false;
        }
        modify("GST Invoice")
        {
            Visible = false;
        }
        modify("Location State Code")
        {
            Visible = false;
        }
        modify("Location GST Reg. No.")
        {
            Visible = false;
        }
        modify("Nature of Supply")
        {
            Visible = false;
        }
        moveafter("Invoice Type"; "Associated Enterprises")
        moveafter("Associated Enterprises"; "Bill of Entry No.")
        moveafter("Bill of Entry No."; "Bill of Entry Date")
        moveafter("Bill of Entry Date"; "Bill of Entry Value")
        moveafter("Bill of Entry Value"; "Vehicle No.")
        moveafter("Vehicle No."; "Vehicle Type")
        moveafter("Vehicle Type"; "Shipping Agent Code")
        moveafter("Distance (Km)"; "E-Way Bill No.")
        moveafter("Supply Finish Date"; "POS as Vendor State")
        moveafter("POS as Vendor State"; "POS Out Of India")

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

          }*/
    }
}