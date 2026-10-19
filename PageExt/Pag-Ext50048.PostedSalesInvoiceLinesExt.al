pageextension 50048 PostedSalesInvoiceLinesExt extends "Posted Sales Invoice Lines"
{
    layout
    {
        modify("Line Discount %")
        {
            Visible = true;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        addafter("No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = all;
            }

            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Customer Disc. Group"; "Customer Disc. Group")
            {
                ApplicationArea = all;
            }
            field("Customer Price Group"; "Customer Price Group")
            {
                ApplicationArea = all;
            }

            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;

            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;

            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("Bird Type"; Rec."Bird Type")
            {
                ApplicationArea = All;

            }
            field("Male Brid Qty."; Rec."Male Brid Qty.")
            {
                ApplicationArea = All;

            }
            field("Female Bird Qty."; Rec."Female Bird Qty.")
            {
                ApplicationArea = All;

            }
            field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
            {
                ApplicationArea = All;

            }
            field("Amt. to Customer"; Rec."Amt. to Customer")
            {
                ApplicationArea = All;

            }
            field("Shipment Amount"; Rec."Shipment Amount")
            {
                ApplicationArea = All;

            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;

            }
            field("Price Discount"; Rec."Price Discount")
            {
                ApplicationArea = All;

            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }

            field("Total MRP"; Rec."Total MRP")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = all;
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = all;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = all;
            }
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = all;
            }
            field("GST Group Type"; "GST Group Type")
            {
                ApplicationArea = all;
            }
            field(CustomerName; CustomerName)
            {
                ApplicationArea = all;
                Caption = 'Customer Name';
            }
            field(CustomerGSTNo; CustomerGSTNo)
            {
                ApplicationArea = all;
                Caption = 'Customer GST Registration No.';
            }
            field(CustomerStateCode; CustomerStateCode)
            {
                ApplicationArea = all;
                Caption = 'Customer State Code';
            }


            field(GSTBaseAmt; GSTBaseAmt)
            {
                Caption = 'GST Base Amount';
                ApplicationArea = all;
            }
            field(TotalGSTAMt; TotalGSTAMt)
            {
                Caption = 'Total GST Amount';
                ApplicationArea = all;
            }
            field(GSTPer; GSTPer)
            {
                Caption = 'GST %';
                ApplicationArea = all;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }

            field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
            {
                ApplicationArea = All;
            }
            field("Unit Volume"; Rec."Unit Volume")
            {
                ApplicationArea = All;
            }
            field("Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = All;
            }

            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = All;
            }

            field("Allow Line Disc."; Rec."Allow Line Disc.")
            {
                ApplicationArea = All;
            }

            field("GST Assessable Value (LCY)"; Rec."GST Assessable Value (LCY)")
            {
                ApplicationArea = All;
            }
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
            }
            field("Total UPIT Amount"; Rec."Total UPIT Amount")
            {
                ApplicationArea = All;
            }

            field("Pmt. Discount Amount"; Rec."Pmt. Discount Amount")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    procedure GSTUpdate(documentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer)
    var

        myInt: Integer;
        RecDetaileGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        CustRec: Record Customer;
    begin
        Clear(CustomerName);
        Clear(CustomerGSTNo);

        if CustRec.get(rec."Sell-to Customer No.") then begin
            CustomerName := CustRec.Name;
            CustomerGSTNo := CustRec."GST Registration No.";
            CustomerStateCode := CustRec."State Code";
        end;


        CLEAR(CGST11);
        CLEAR(SGST11);
        CLEAR(IGST11);
        Clear(TotalGSTAMt);
        Clear(GSTBaseAmt);
        Clear(GSTPer);
        RecDetaileGSTLedgerEntry.RESET;
        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", documentNo);
        //  RecDetaileGSTLedgerEntry.SETRANGE("No.", ItemNo);
        RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                GSTBaseAmt := ABS(RecDetaileGSTLedgerEntry."GST Base Amount");
                IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                    CGST11 += RecDetaileGSTLedgerEntry."GST Amount";
                    GSTPer += RecDetaileGSTLedgerEntry."GST %";
                end else
                    if RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                        SGST11 += RecDetaileGSTLedgerEntry."GST Amount";
                        GSTPer += RecDetaileGSTLedgerEntry."GST %";
                    END ELSE
                        IF RecDetaileGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IGST11 += RecDetaileGSTLedgerEntry."GST Amount";
                            GSTPer += RecDetaileGSTLedgerEntry."GST %";
                        END;
            until RecDetaileGSTLedgerEntry.next = 0;
        TotalGSTAMt := ABS(CGST11 + SGST11 + IGST11);
    end;


    trigger OnAfterGetRecord()
    begin
        GSTUpdate(rec."Document No.", Rec."No.", rec."Line No.");
    end;

    var
        GSTBaseAmt: Decimal;
        TotalGSTAMt: Decimal;
        GSTPer: Decimal;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGST11: Decimal;
        SGST11: Decimal;
        IGST11: Decimal;
        CustomerGSTNo: Code[20];
        CustomerName: Text[100];
        CustomerStateCode: Code[20];

}