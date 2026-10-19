pageextension 50168 PostedPurchaseInviceLinesExt extends "Posted Purchase Invoice Lines"
{
    layout
    {

        addafter(Amount)
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = ALL;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = ALL;
            }
            field("TDS Section Code"; Rec."TDS Section Code")
            { ApplicationArea = All; }
            field("GST Group Type"; Rec."GST Group Type")
            { ApplicationArea = All; }

            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Receipt No."; Rec."Receipt No.")
            {
                ApplicationArea = all;
            }
            field("Receipt Line No."; Rec."Receipt Line No.")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("GST Group Code"; "GST Group Code")
            {
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; "HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field("GST Reverse Charge"; "GST Reverse Charge")
            {
                ApplicationArea = all;
            }
            field(VenName; VenName)
            {
                ApplicationArea = all;
                Caption = 'Vendor Name';
            }
            field(VendGstNo; VendGstNo)
            {
                Caption = 'Vendor Gst Registration No.';
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

        Clear(VenName);
        Clear(VendGstNo);
        Clear(vENDORsTATE);
        if Vendrec.get(Rec."Buy-from Vendor No.") then begin
            VenName := Vendrec.Name;
            VendGstNo := Vendrec."GST Registration No.";
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
        VenName: text[100];
        VendGstNo: Code[20];
        Vendrec: Record Vendor;
        vENDORsTATE: Code[20];
}