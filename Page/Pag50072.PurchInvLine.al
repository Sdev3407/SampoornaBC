page 50072 "Purch. Inv. Line"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 123;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }

                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }


                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("TDS Section Code"; Rec."TDS Section Code")
                { ApplicationArea = All; }

                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }

                field("GST Reverse Charge"; Rec."GST Reverse Charge")
                {
                    ApplicationArea = All;
                }
                field("GST Assessable Value"; Rec."GST Assessable Value")
                {
                    ApplicationArea = All;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor State Code"; Rec."Vendor State Code")
                {
                    ApplicationArea = all;
                    Editable = false;
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

