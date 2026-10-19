pageextension 50169 PostedSalesCreditLinesExt extends "Posted Sales Credit Memo Lines"
{

    layout
    {
        addafter(Amount)
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = all;
            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
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
            field(StateCode; StateCode)
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
    }

    procedure GSTUpdate(documentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer)
    var

        myInt: Integer;
        CustRec: Record Customer;
    begin
        Clear(StateCode);
        CLEAR(CGST11);
        CLEAR(SGST11);
        CLEAR(IGST11);
        Clear(TotalGSTAMt);
        Clear(GSTBaseAmt);
        Clear(GSTPer);

        Clear(CustomerName);
        Clear(CustomerGSTNo);

        if CustRec.get(rec."Sell-to Customer No.") then begin
            CustomerName := CustRec.Name;
            CustomerGSTNo := CustRec."GST Registration No.";
            CustomerStateCode := CustRec."State Code";
        end;
        if CustomerRec.get(Rec."Sell-to Customer No.") then
            StateCode := CustomerRec."State Code";
        RecDetaileGSTLedgerEntry.RESET;
        RecDetaileGSTLedgerEntry.SETRANGE("Document No.", documentNo);
        // RecDetaileGSTLedgerEntry.SETRANGE("No.", ItemNo);
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
        StateCode: Code[20];
        CustomerRec: Record Customer;
        CustomerGSTNo: Code[20];
        CustomerName: Text[100];
        CustomerStateCode: Code[20];
}