report 50058 "Sales Invoice Register"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './SalesInvoiceRegister.rdlc';
    Caption = 'Sales Invoice Register';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date";
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Description = FILTER(<> ''),
                                          "No." = FILTER(<> 301850));

                trigger OnAfterGetRecord()
                begin
                    CurRowNo += 1;
                    CLEAR(CGST11);
                    CLEAR(SGST11);
                    CLEAR(IGST11);
                    CLEAR(igst);
                    CLEAR(Cgst);
                    CLEAR(sgst);
                    CLEAR(ShipToName);
                    CLEAR(LR);
                    CLEAR("VehicleNo.");

                    RecDetaileGSTLedgerEntry.RESET;
                    RecDetaileGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    RecDetaileGSTLedgerEntry.SETRANGE("No.", "No.");
                    RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Posting Date", "Sales Invoice Line"."Posting Date");
                    RecDetaileGSTLedgerEntry.SETRANGE(RecDetaileGSTLedgerEntry."Document Line No.", "Sales Invoice Line"."Line No.");
                    IF RecDetaileGSTLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF RecDetaileGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                Cgst := CGST11;
                                //CGSTText := STRSUBSTNO('CGST %1 %',ROUND(RecDetaileGSTLedgerEntry."GST %",0.01,'='))
                            END;
                            IF RecDetaileGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                sgst := SGST11;
                                //SGSTText := STRSUBSTNO('SGST %1 %',ROUND(RecDetaileGSTLedgerEntry."GST %",0.01,'='))
                            END;
                            IF RecDetaileGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGST11 := ABS(RecDetaileGSTLedgerEntry."GST Amount");
                                igst := IGST11;
                                //IGSTText := STRSUBSTNO('IGST %1 %',ROUND(RecDetaileGSTLedgerEntry."GST %",0.01,'='))
                            END;

                        UNTIL RecDetaileGSTLedgerEntry.NEXT = 0;

                    RecSalesInvoice.RESET;
                    RecSalesInvoice.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                    IF RecSalesInvoice.FINDFIRST THEN BEGIN

                        ShipToName := RecSalesInvoice."Ship-to Name";
                        "VehicleNo." := RecSalesInvoice."Vehicle No.";
                        LR := RecSalesInvoice."LR/RR No.";
                    END;


                    IF ExportToExcel THEN BEGIN
                        EnterCell(CurRowNo, 1, FORMAT("Sales Invoice Line"."Posting Date"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        EnterCell(CurRowNo, 2, "Sales Invoice Header"."External Document No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 3, "Sales Invoice Line"."Document No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 4, ShipToName, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 5, LR, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 6, "Sales Invoice Line"."Shortcut Dimension 1 Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 7, "VehicleNo.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 8, "Sales Invoice Line"."No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 9, "Sales Invoice Line".Description, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 10, "Sales Invoice Line"."HSN/SAC Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 11, FORMAT("Sales Invoice Line".Quantity), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 12, FORMAT("Sales Invoice Line"."Unit Price"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 13, FORMAT("Sales Invoice Line"."Line Amount"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 14, FORMAT(Cgst), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 15, FORMAT(sgst), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 16, FORMAT(igst), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 17, FORMAT("Sales Invoice Line"."Amt. to Customer" + igst + sgst + Cgst), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 18, "Sales Invoice Header"."Transporter Name", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                recComp.GET;
                IF ExportToExcel THEN BEGIN
                    EnterCell(2, 1, recComp.Name, TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(3, 1, 'Sales Invoice Register', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 1, 'Posting Date', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 2, 'Po No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 3, 'SIL Doc No', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 4, 'Ship-to Name', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 5, 'LR_RR No_', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 6, 'Branch', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 7, 'Vehicle No_', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 8, 'ItemCode', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 9, 'Description', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 10, 'HSN_SAC Code', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 11, 'Qty', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 12, 'Unit Price', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 13, 'Amount', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 14, 'CGST', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 15, 'SGST', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 16, 'IGST', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 17, 'Total Amount', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(6, 18, 'Transporter Name', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                END;
                CurRowNo := 6;
                CurColumnNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(ExportToExcel; ExportToExcel)
                    {
                        Caption = 'ExportToExcel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ExportToExcel := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF ExportToExcel THEN
            ExcelBuffer.CreateBookAndOpenExcel('', 'Sales Invoice Register', ' ', COMPANYNAME, USERID);
        //ExcelBuffer.MergeCell(2,1,2,9);
        //ExcelBuffer.GiveUserControl();
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        ExportToExcel: Boolean;
        ExcelBuffer: Record "370";
        CurRowNo: Integer;
        CurColumnNo: Integer;
        recComp: Record "79";
        RecDetaileGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        igst: Decimal;
        Cgst: Decimal;
        sgst: Decimal;
        CGST11: Decimal;
        SGST11: Decimal;
        IGST11: Decimal;
        RecSalesInvoice: Record "112";
        ShipToName: Text;
        "VehicleNo.": Text;
        LR: Text;


    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[50]; CellType: Option)
    begin
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.", RowNo);
        ExcelBuffer.VALIDATE("Column No.", ColumnNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Formula := '';
        ExcelBuffer.Bold := Bold;
        ExcelBuffer.Italic := Italic;
        ExcelBuffer.Underline := UnderLine;
        ExcelBuffer.NumberFormat := Format;
        ExcelBuffer."Cell Type" := CellType;
        //IF (RowNo = 2) AND (ColumnNo = 1) THEN
        //ExcelBuffer.MergeCell(2,1,2,9);
        ExcelBuffer.INSERT;
    end;
}

