pageextension 50170 PostedPurchaseCreditLinesExt extends "Posted Purchase Cr. Memo Lines"
{
    layout
    {

        addafter(Amount)
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }

            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = ALL;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = all;
            }
            field(LocationStateCode; LocationStateCode)
            {
                Caption = 'Location State Code';
                ApplicationArea = all;
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


            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = all;
            }
            field("GST Group Code"; Rec."GST Group Code")
            { ApplicationArea = all; }
            field("GST Group Type"; Rec."GST Group Type")
            {
                ApplicationArea = all;
            }
            field(VenName; vendorName)
            {
                ApplicationArea = all;
                Caption = 'Vendor Name';
            }
            field(VendGstNo; VenGstreg)
            {
                Caption = 'Vendor Gst Registration No.';
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = all;
            }

            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = all;
            }
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                ApplicationArea = all;
            }
            field(vendorName; vendorName)
            {
                ApplicationArea = all;
                Caption = 'Vendor Name';
            }
            field("Buy-From GST Registration No"; Rec."Buy-From GST Registration No")
            {
                ApplicationArea = all;
            }
        }
    }
    procedure GSTUpdate(documentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer; GSTGroupCode: Code[20])
    var
        GSTGroup: Record "GST Group";
        myInt: Integer;
    begin
        CLEAR(CGST11);
        CLEAR(SGST11);
        CLEAR(IGST11);
        Clear(TotalGSTAMt);
        Clear(GSTBaseAmt);
        Clear(GSTPer);
        GSTGroup.Reset();
        GSTGroup.SetRange(Code, GSTGroupCode);
        GSTGroup.SetRange("Reverse Charge", true);
        if GSTGroup.FindFirst() then begin
            RecDetaileGSTLedgerEntry.RESET;
            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", documentNo);
            RecDetaileGSTLedgerEntry.SetRange("Entry Type", RecDetaileGSTLedgerEntry."Entry Type"::"Initial Entry");
            //RecDetaileGSTLedgerEntry.SETRANGE("No.", ItemNo);
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
        END else begin
            RecDetaileGSTLedgerEntry.RESET;
            RecDetaileGSTLedgerEntry.SETRANGE("Document No.", documentNo);
            //RecDetaileGSTLedgerEntry.SETRANGE("No.", ItemNo);
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
        end;
        TotalGSTAMt := ABS(CGST11 + SGST11 + IGST11);
    end;



    trigger OnAfterGetRecord()
    var
        Locationrec: Record Location;
    begin
        Clear(LocationStateCode);
        GSTUpdate(rec."Document No.", Rec."No.", rec."Line No.", Rec."GST Group Code");
        if Locationrec.Get(rec."Location Code") then
            LocationStateCode := Locationrec."State Code";

        Clear(VenGstreg);
        Clear(vendorName);
        Clear(vENDORsTATE);
        if Vendrec.get(rec."Buy-from Vendor No.") then begin
            vendorName := Vendrec.Name;
            VenGstreg := Vendrec."GST Registration No.";
            vENDORsTATE := Vendrec."State Code";
        end;
    end;

    var
        GSTBaseAmt: Decimal;
        TotalGSTAMt: Decimal;
        GSTPer: Decimal;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGST11: Decimal;
        SGST11: Decimal;
        IGST11: Decimal;
        LocationStateCode: Code[20];
        vendorName: Text[100];
        Vendrec: Record Vendor;
        VenGstreg: Code[20];
        vENDORsTATE: Code[20];
}