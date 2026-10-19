page 50071 "Transfer Receipt Line"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 5747;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("Total Taxable Value"; Rec."Total Taxable Value")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("Location State code"; Rec."Location State code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Postingdate; Postingdate)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
                field("<ExternalNo>"; ExternalNo)
                {
                    ApplicationArea = All;
                    Caption = 'External Doc';
                }
                field(transferFromState; transferFromState)
                {
                    ApplicationArea = all;
                    Caption = 'Transfer From State Code';
                }
                field(transfertoState; transfertoState)
                {
                    ApplicationArea = all;
                    Caption = 'Transfer To State Code';
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
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    procedure GSTUpdate(documentNo: Code[20]; ItemNo: Code[20]; LineNo: Integer)
    var

        myInt: Integer;
        LocationFrom: Record Location;
        LocationTo: Record Location;
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
    var
        LocationFrom: Record Location;
        LocationTo: Record Location;
    begin
        GSTUpdate(Rec."Document No.", Rec."Item No.", Rec."Line No.");
        CLEAR(Postingdate);

        Transferreceipt.RESET;
        Transferreceipt.SETRANGE("No.", Rec."Document No.");
        IF Transferreceipt.FINDFIRST THEN BEGIN
            Postingdate := Transferreceipt."Posting Date";
            ExternalNo := Transferreceipt."External Document No.";
        END;
        GSTUpdate(rec."Document No.", Rec."Item No.", rec."Line No.");

        Clear(transferFromState);
        Clear(transfertoState);

        if LocationFrom.get(Rec."Transfer-from Code") then
            transferFromState := LocationFrom."State Code";

        if LocationTo.Get(Rec."Transfer-to Code") then
            transfertoState := LocationTo."State Code";
    end;

    var
        Postingdate: Date;
        Transferreceipt: Record 5746;
        ExternalNo: Text;
        GSTBaseAmt: Decimal;
        TotalGSTAMt: Decimal;
        GSTPer: Decimal;
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGST11: Decimal;
        SGST11: Decimal;
        IGST11: Decimal;
        transferFromState: Code[20];
        transfertoState: Code[20];
}

