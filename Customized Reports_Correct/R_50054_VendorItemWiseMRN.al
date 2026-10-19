report 50054 "Vendor Item Wise MRN Report"
{
    ProcessingOnly = true;
    Caption = 'Vendor Item Wise MRN Report';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "Posting Date";
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''));

                trigger OnAfterGetRecord()
                var
                    GSTBaseAmt: Decimal;
                begin
                    // calculate gst amount
                    IGST_perc := 0;
                    IGST_Amt := 0;
                    CGST_perc := 0;
                    CGST_Amt := 0;
                    SGST_perc := 0;
                    SGST_Amt := 0;
                    GSTBaseAmt := 0;
                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Purch. Rcpt. Line"."Line No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Purch. Rcpt. Line"."Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "Purch. Rcpt. Line"."No.");
                    IF DetailedGSTLedgerEntry.FINDSET THEN
                        REPEAT
                            GSTBaseAmt += DetailedGSTLedgerEntry."GST Base Amount";
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IGST_perc := DetailedGSTLedgerEntry."GST %";
                                IGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");

                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SGST_perc := DetailedGSTLedgerEntry."GST %";
                                SGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CGST_perc := DetailedGSTLedgerEntry."GST %";
                                CGST_Amt += ABS(DetailedGSTLedgerEntry."GST Amount");
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;



                    TotalGstAmt := IGST_Amt + CGST_Amt + SGST_Amt;
                    //TotalGstBaseAmt := 
                    // calculate gst amount

                    CurRowNo += 1;
                    CLEAR(brokagedesc);
                    CLEAR(OrderDate);
                    CLEAR(VendorName);
                    CLEAR(PayTermsCode);
                    CLEAR(RateBasis);
                    CLEAR(BrokageCode);
                    CLEAR(Date1);
                    CLEAR(GE);
                    PurchaseHeaderRec.RESET;
                    PurchaseHeaderRec.SETRANGE("No.", "Purch. Rcpt. Line"."Document No.");
                    IF PurchaseHeaderRec.FINDFIRST THEN BEGIN
                        Date1 := PurchaseHeaderRec."Posting Date";
                        OrderDate := PurchaseHeaderRec."Order Date";
                        VendorName := PurchaseHeaderRec."Buy-from Vendor Name";
                        PayTermsCode := PurchaseHeaderRec."Payment Terms Code";
                        RateBasis := FORMAT(PurchaseHeaderRec."Rate Basis");
                        BrokageCode := PurchaseHeaderRec."Brokerage Code";
                    END;
                    VendorRec.RESET;
                    VendorRec.SETRANGE("No.", BrokageCode);
                    IF VendorRec.FINDFIRST THEN
                        brokagedesc := VendorRec.Name;

                    GateEntry.RESET;
                    GateEntry.SETRANGE("Receipt No.", "Purch. Rcpt. Header"."No.");
                    GateEntry.SETRANGE("Entry Type", GateEntry."Entry Type"::Inward);
                    IF GateEntry.FINDFIRST THEN
                        GE := GateEntry."Gate Entry No.";


                    IF ExportToExcel THEN BEGIN
                        EnterCell(CurRowNo, 1, FORMAT(Date1), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        EnterCell(CurRowNo, 2, FORMAT("Purch. Rcpt. Header"."Document Date"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        EnterCell(CurRowNo, 3, "Purch. Rcpt. Line"."Document No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 4, VendorName, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 5, "Purch. Rcpt. Line".Description, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 6, "Purch. Rcpt. Line"."Unit of Measure", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 7, FORMAT("Purch. Rcpt. Line".Quantity), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 8, FORMAT("Purch. Rcpt. Line"."Challan Qty"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 9, FORMAT("Purch. Rcpt. Line"."Weight Qty"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 10, FORMAT("Purch. Rcpt. Line"."Excess Qty"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 11, FORMAT(OrderDate), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        //EnterCell(CurRowNo, 10, "Purch. Rcpt. Line"."Document No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 12, FORMAT("Purch. Rcpt. Header"."Order No."), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 13, FORMAT("Purch. Rcpt. Line"."Direct Unit Cost"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 14, FORMAT("Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line".Quantity), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                                                                                                                                                                                           //    EnterCell(CurRowNo, 15, FORMAT(TotalGstAmt), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                                                                                                                                                                                           //  EnterCell(CurRowNo, 16, "Purch. Rcpt. Line"."GST Group Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                                                                                                                                                                                           //  EnterCell(CurRowNo, 17, FORMAT(TotalGstAmt), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                        EnterCell(CurRowNo, 15, FORMAT("Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line".Quantity), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                        EnterCell(CurRowNo, 16, PayTermsCode, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 17, FORMAT(RateBasis), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 18, brokagedesc, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 19, GE, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                recComp.GET;
                IF ExportToExcel THEN BEGIN
                    EnterCell(2, 8, recComp.Name, TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(3, 8, 'Vendor Item Wise MRN Report', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 1, 'DATE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 2, 'BILL DATE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 3, 'MRN NO', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 4, 'VENDOR NAME', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 5, 'ITEM NAME', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 6, 'UOM', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 7, 'RECEIVED QTY', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 8, 'CHALLAN  QTY', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 9, 'WEIGHT QTY', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 10, 'SHORT/ EXCESS', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 11, 'ORDER DATE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 12, 'DOC NUMBER', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 13, 'DIRECT UNIT COST', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 14, 'LINE AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //      EnterCell(4, 15, 'GST BASE AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //    EnterCell(4, 16, 'GST GROUP CODE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //  EnterCell(4, 17, 'TOTAL GST AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 15, 'NET TOTAL', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 16, 'PAYMENT TERMS CODE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 17, 'RATE BASIS', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 18, 'BROKERAGE CODE(DESCRIPTION)', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 19, 'Gate Entry No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                END;
                CurRowNo := 4;
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
                group("Export To Excel")
                {
                    field(ExportToExcel; ExportToExcel)
                    {
                        Caption = 'Export To Excel';
                        ApplicationArea = All;
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
            ExcelBuffer.CreateNewBook('Vendor Item Wise MRN Report');
        ExcelBuffer.WriteSheet('Vendor Item Wise MRN Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Vendor Item Wise MRN Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        // ExcelBuffer.CreateBookAndOpenExcel('', 'Vendor Item Wise MRN Report', ' ', COMPANYNAME, USERID);
        //ExcelBuffer.MergeCell(2,1,2,9);
        //ExcelBuffer.GiveUserControl();
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        ExportToExcel: Boolean;
        ExcelBuffer: Record 370;
        CurRowNo: Integer;
        CurColumnNo: Integer;
        recComp: Record 79;
        PurchaseHeaderRec: Record 120;
        OrderDate: Date;
        VendorName: Text;
        PayTermsCode: Code[20];
        RateBasis: Text;
        BrokageCode: Code[20];
        Date1: Date;
        VendorRec: Record 23;
        brokagedesc: Text;
        GateEntry: Record "Posted Gate Entry Attachment";
        GE: Text;
        TotalGstAmt: Decimal;
        SGST_perc1: Decimal;
        SGST_Amt2: Decimal;
        IGST_Amt2: Decimal;
        TaxComponentName1: Text;
        CGST_Amt1: Decimal;
        CGST_perc1: Decimal;
        IGST_Amt1: Decimal;
        CGST_Amt2: Decimal;
        IGST_perc1: Decimal;
        TaxTransValue1: Record "Tax Transaction Value";
        GSTSetup1: Record "GST Setup";
        GSTLineAMt: Decimal;
        LineAmt1: Decimal;
        GSTBOOL: Boolean;
        SgstAmount: Decimal;
        CgstAmount: Decimal;
        IgstAmount: Decimal;
        SgstPer: Decimal;
        CgstPer: Decimal;
        IgstPer: Decimal;
        TotalGstBaseAmt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        CGST_perc: Decimal;
        CGST_Amt: Decimal;
        SGST_perc: Decimal;
        SGST_Amt: Decimal;
        TCS_perc: Decimal;
        TCS_Amt: Decimal;
        TaxTransValue: Record "Tax Transaction Value";

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
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

