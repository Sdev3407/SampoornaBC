pageextension 50029 PostedPurchaseCreditMemoExt extends "Posted Purchase Credit Memo"
{
    layout
    {
        modify("Vehicle No.")
        {
            Editable = true;
        }
        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify("E-Way Bill No.")
        {
            ApplicationArea = All;
            Editable = false;
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
        modify("Distance (Km)")
        {
            Editable = True;
        }
        moveafter("No."; "Buy-from Contact No.")
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
        moveafter("Document Date"; "Pre-Assigned No.")
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
        addbefore("Pay-to Name")
        {
            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        ///shipping
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }

        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Contact"; "Location Code")
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
        addlast(General)
        {
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Code field.', Comment = '%';
                trigger OnLookup(var Text: Text): Boolean
                var
                    Cust: Record Vendor;
                    CustList: Page "Vendor List";
                    UserSetupRec: Record "User Setup";
                begin
                    Cust.Reset();
                    Cust.SetFilter(Cust.Transporter, '%1', true);
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Transporter Code", Cust."No.");
                    END;
                END;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Name field.', Comment = '%';
            }

        }
        addafter("E-Way Bill No.")
        {
            field("E-Way Generated Date"; Rec."E-Way Generated Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Generated Date field.', Comment = '%';
            }
            field("E-Way Cancelled Date"; Rec."E-Way Cancelled Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Cancelled Date field.', Comment = '%';
            }
            field("Eway Cancel Reason"; Rec."Eway Cancel Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Eway Cancel Reason field.', Comment = '%';
            }
            field("Eway Cancel Remarks"; Rec."Eway Cancel Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Eway Cancel Remarks field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast("&Cr. Memo")
        {
            action("Posted Reference Invoice No.")
            {
                Caption = 'Posted Reference Invoice No.';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    PostedReferenceInvoiceNo: Page "Posted Reference Invoice No";
                begin
                    ReferenceInvoiceNo.SETCURRENTKEY("Document No.", "Document Type", "Source No.", "Reference Invoice Nos.");
                    ReferenceInvoiceNo.SETRANGE("Document No.", Rec."No.");
                    IF ReferenceInvoiceNo.FINDFIRST THEN BEGIN
                        PostedReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                        PostedReferenceInvoiceNo.SETRECORD(ReferenceInvoiceNo);
                        PostedReferenceInvoiceNo.LOOKUPMODE(TRUE);
                        IF PostedReferenceInvoiceNo.RUNMODAL = ACTION::LookupOK THEN
                            PostedReferenceInvoiceNo.GETRECORD(ReferenceInvoiceNo)
                    END;
                end;
            }
        }
        addlast("&Cr. Memo")
        {
            action("Generate EWayBill")
            {
                AccessByPermission = tableData "Transfer Shipment Header" = RIMD;
                Caption = 'Generate E-way Bill';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    EwayBillDate: DateTime;
                    ValidUpto: DateTime;

                begin
                    if rec."E-Way Bill No." = '' then begin
                        Cu50061.GenerateEwayBill(Rec, Rec."E-Way Bill No.", Rec."E-Way Generated Date", ValidUpto);
                        //Rec.Modify();
                    end Else
                        Error('E-way bill already Generated');
                end;
            }

            action("Cancel EWayBill")
            {
                AccessByPermission = tableData "Transfer Shipment Header" = RIMD;
                Caption = 'Cancel E-way Bill';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    Loc: Record Location;
                begin

                    TestField("E-Way Bill No.");
                    if Rec."Eway Cancel Reason" = Rec."Eway Cancel Reason"::" " then
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Reason"));
                    if Rec."Eway Cancel Remarks" = '' then
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Remarks"));

                    Cu50061.CancelEwayBill(Rec, Rec."E-Way Bill No.", rec."Eway Cancel Reason", Rec."Eway Cancel Remarks",
                    Rec."Location GST Reg. No.", Rec."E-Way Cancelled Date");
                    // if Rec."E-Way Cancelled Date" <> 0DT then
                    //     Rec.Modify();
                end;
            }
        }
    }

    var
        UserSetup: Record 91;
}