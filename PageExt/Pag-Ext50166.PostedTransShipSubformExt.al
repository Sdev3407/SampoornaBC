pageextension 50166 PostedTransShipSubformExt extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = All;
            }
            field("Location State code"; Rec."Location State code")
            {
                ApplicationArea = All;
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
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        FILTERGROUP(2);
        SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        //IF NOT UserSetup."User Permission" THEN BEGIN
        SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            SETFILTER("Transfer-from Code", UserSetup."Shortcut Dimension 3 Code");
        //END;
        FILTERGROUP(0);
    end;


    trigger OnAfterGetRecord()
    begin
        GSTUpdate(rec."Document No.", Rec."Item No.", rec."Line No.");
    end;

    procedure GSTUpdate(documentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer)
    var

        myInt: Integer;
    begin
        CLEAR(CGST11);
        CLEAR(SGST11);
        CLEAR(IGST11);
        Clear(TotalGSTAMt);
        Clear(GSTBaseAmt);
        Clear(GSTPer);
        RecDetaileGSTLedgerEntry.RESET;
        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", documentNo);
        RecDetaileGSTLedgerEntry.SETRANGE("No.", ItemNo);
        RecDetaileGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                GSTBaseAmt := RecDetaileGSTLedgerEntry."GST Base Amount";
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
        TotalGSTAMt := CGST11 + SGST11 + IGST11;
    end;


    var
        UserSetup: Record 91;
        GSTBaseAmt: Decimal;
        TotalGSTAMt: Decimal;
        GSTPer: Decimal;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGST11: Decimal;
        SGST11: Decimal;
        IGST11: Decimal;


}