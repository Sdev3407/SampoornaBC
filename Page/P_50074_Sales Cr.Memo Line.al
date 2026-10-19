page 50074 "Sales Cr.Memo Line"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 115;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
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
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
                {
                    ApplicationArea = All;
                }

                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ApplicationArea = All;
                }
                field("GST Place of Supply"; Rec."GST Place of Supply")
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
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
                field("Location State Code"; Rec."Location State Code")
                {
                    ApplicationArea = All;
                    Editable = false;
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

