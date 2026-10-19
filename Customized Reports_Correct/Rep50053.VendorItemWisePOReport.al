report 50053 "Vendor Item Wise PO Report"
{
    ProcessingOnly = true;
    Caption = 'Vendor Item Wise PO Report';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "Posting Date";
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''));

                trigger OnAfterGetRecord()
                begin
                    // calculate gst amount
                    Clear(IgstAmount);
                    Clear(CgstAmount);
                    Clear(SgstAmount);
                    GSTSetup1.Get();//PT
                    TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                    TaxTransValue1.SetRange("Tax Record ID", "Purchase Line".RecordId());
                    TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                    TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                    if TaxTransValue1.FindSet() then
                        repeat
                            TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                            case TaxComponentName1 of
                                'IGST':
                                    begin
                                        IgstPer := TaxTransValue1.Percent;
                                        evaluate(IGST_Amt2, TaxTransValue1."Column Value");
                                        IgstAmount += IGST_Amt2;

                                    end;
                                'CGST':
                                    begin
                                        evaluate(CGST_Amt2, TaxTransValue1."Column Value");
                                        CgstPer += TaxTransValue1.Percent;
                                        CgstAmount += CGST_Amt2;
                                    end;
                                'SGST':
                                    begin
                                        evaluate(SGST_Amt2, TaxTransValue1."Column Value");
                                        SgstPer += TaxTransValue1.Percent;
                                        SgstAmount += SGST_Amt2;
                                    end;
                            end;
                        until TaxTransValue1.Next() = 0;

                    IF IgstAmount <> 0 THEN BEGIN

                        GSTBOOL := TRUE;
                    END;

                    IF CgstAmount <> 0 THEN BEGIN

                        GSTBOOL := FALSE;
                    END;


                    TotalGstAmt := IgstAmount + CgstAmount + SgstAmount;
                    TotalGstBaseAmt := "Purchase Header".Amount + TotalGstAmt;
                    // calculate gst amount

                    CurRowNo += 1;
                    CLEAR(Brokagedesc);
                    CLEAR(OrderDate);
                    CLEAR(VendorName);
                    CLEAR(PayTermsCode);
                    CLEAR(RateBasis);
                    CLEAR(BrokageCode);
                    CLEAR(PeningQty);
                    PurchaseHeaderRec.RESET;
                    PurchaseHeaderRec.SETRANGE("No.", "Purchase Line"."Document No.");
                    IF PurchaseHeaderRec.FINDFIRST THEN BEGIN

                        OrderDate := PurchaseHeaderRec."Order Date";
                        VendorName := PurchaseHeaderRec."Buy-from Vendor Name";
                        PayTermsCode := PurchaseHeaderRec."Payment Terms Code";
                        RateBasis := FORMAT(PurchaseHeaderRec."Rate Basis");
                        BrokageCode := PurchaseHeaderRec."Brokerage Code";
                    END;

                    IF "Purchase Line"."Outstanding Quantity" > 0 THEN
                        PeningQty := "Purchase Line"."Outstanding Quantity";

                    VendorRec.RESET;
                    VendorRec.SETRANGE("No.", BrokageCode);
                    IF VendorRec.FINDFIRST THEN
                        Brokagedesc := VendorRec.Name;
                    IF ExportToExcel THEN BEGIN
                        EnterCell(CurRowNo, 1, FORMAT(OrderDate), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        EnterCell(CurRowNo, 2, "Purchase Header"."No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 3, VendorName, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 4, "Purchase Line"."No.", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 5, "Purchase Line".Description, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 6, "Purchase Line"."Unit of Measure", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 7, FORMAT("Purchase Line".Quantity), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 8, FORMAT("Purchase Line"."Direct Unit Cost"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 9, FORMAT("Purchase Line"."Line Amount"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 10, FORMAT("Purchase Line"."Quantity Received"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 11, FORMAT(PeningQty), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 12, FORMAT("Purchase Line"."Line Amount"), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                        EnterCell(CurRowNo, 13, "Purchase Line"."GST Group Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 14, format(TotalGstAmt), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //PRU SH 01082022
                        EnterCell(CurRowNo, 15, FORMAT("Purchase Line".Amount + TotalGstAmt), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 16, PayTermsCode, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 17, FORMAT(RateBasis), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 18, Brokagedesc, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        EnterCell(CurRowNo, 19, "Purchase Line"."Location Code", FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 20, FORMAT("Purchase Header".Status), FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        EnterCell(CurRowNo, 21, PurComments, FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Comments.RESET;
                Comments.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                Comments.SETRANGE("No.", "Purchase Header"."No.");
                IF Comments.FINDFIRST THEN
                    PurComments := Comments.Comment;
            end;

            trigger OnPreDataItem()
            begin
                recComp.GET;


                IF ExportToExcel THEN BEGIN
                    EnterCell(2, 8, recComp.Name, TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //EnterCell(3,8,'EXPORT INVOICE UNDER LUT',TRUE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 1, 'ORDER DATE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 2, 'DOC NUMBER', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 3, 'VENDOR NAME', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 4, 'Item No.', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 5, 'ITEM NAME', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 6, 'UOM', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 7, 'QUANTITY', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 8, 'DIRECT UNIT COST', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 9, 'LINE AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 10, 'QTY Receive', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 11, 'Pending Qty', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 12, 'GST BASE AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 13, 'GST GROUP CODE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 14, 'TOTAL GST AMOUNT', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 15, 'NET TOTAL', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 16, 'PAYMENT TERMS CODE', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 17, 'RATE BASIS', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 18, 'BROKERAGE CODE(DESCRIPTION)', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 19, 'Location', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 20, 'Status', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    EnterCell(4, 21, 'Short Close Comments', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
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
            ExcelBuffer.CreateNewBook('Vendor Item Wise PO Report');
        ExcelBuffer.WriteSheet('Vendor Item Wise PO Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Vendor Item Wise PO Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //  ExcelBuffer.CreateBookAndOpenExcel('', 'Vendor Item Wise PO Report', ' ', COMPANYNAME, USERID);
        //ExcelBuffer.MergeCell(2,1,2,9);
        //ExcelBuffer.GiveUserControl();
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        GSTLineAMt: Decimal;
        LineAmt1: Decimal;
        GSTBOOL: Boolean;
        SgstAmount: Decimal;
        CgstAmount: Decimal;
        IgstAmount: Decimal;
        SgstPer: Decimal;
        CgstPer: Decimal;
        IgstPer: Decimal;
        ExportToExcel: Boolean;
        ExcelBuffer: Record 370;
        CurRowNo: Integer;
        CurColumnNo: Integer;
        PurchaseLine: Record 39;
        recComp: Record 79;
        PurchaseHeaderRec: Record 38;
        OrderDate: Date;
        VendorName: Text;
        PayTermsCode: Code[20];
        RateBasis: Text;
        BrokageCode: Code[20];
        Brokagedesc: Text;
        VendorRec: Record 23;
        PeningQty: Decimal;
        Comments: Record 43;
        PurComments: Text;
        IGST_perc: Decimal;
        IGST_Amt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
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
        GstBaseAmtigst: Decimal;
        GstBaseAmtCgst: Decimal;
        GstBaseAmtSgst: Decimal;
        TotalGstBaseAmt: Decimal;

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

