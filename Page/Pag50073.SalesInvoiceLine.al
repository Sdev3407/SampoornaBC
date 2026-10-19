page 50073 "Sales Invoice Line"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 113;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Sales Invoice Line" = m;

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
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternate Quantity"; Rec."Alternate Quantity")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Price Discount"; Rec."Price Discount")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }



                field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Price Incl. of Tax"; Rec."Unit Price Incl. of Tax")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Place of Supply"; Rec."GST Place of Supply")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Editable = Editable;
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                    Editable = false;
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
    trigger OnAfterGetRecord()
    begin
        GSTUpdate(rec."Document No.", Rec."No.", rec."Line No.");
    end;


    trigger OnInit()
    begin
        Editable := FALSE;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Edit Flock No. ILE", TRUE);
        IF UserSetup.FINDFIRST THEN
            Editable := TRUE
        ELSE
            Editable := FALSE;
    end;

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

    var
        Editable: Boolean;
        UserSetup: Record 91;
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

