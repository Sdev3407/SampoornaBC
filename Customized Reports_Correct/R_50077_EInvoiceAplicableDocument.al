report 50077 "E-Invoice Aplicable Document"
{
    UsageCategory = Administration;
    Caption = 'EInvoice Aplicable Document Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\EInvoiceAplicableDocument.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("E-Invoice Status" = FILTER(<> Generated),
                                      "Nature of Supply" = FILTER(B2B));
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(EInvoiceStatus_SalesInvoiceHeader; "Sales Invoice Header"."E-Invoice Status")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(LocationCode_SalesInvoiceHeader; "Sales Invoice Header"."Location Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NonGSTApplicable("Sales Invoice Header") THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                "Sales Invoice Header".SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = WHERE("E-Invoice Status" = FILTER(<> Generated));  //PRU SH
                                                                                   //"Structure" = FILTER(GST));  //PRU SH
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(EInvoiceStatus_TransferShipmentHeader; "Transfer Shipment Header"."E-Invoice Status")
            {
            }
            column(TransferfromName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NonGSTApplicableTransfer("Transfer Shipment Header") THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                "Transfer Shipment Header".SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StartDate: Date;
        EndDate: Date;
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

    local procedure NonGSTApplicable(SalesInvoiceHeader: Record 112): Boolean
    var
        SalesInvoiceLine: Record 113;
        TotalGSTAmt: Decimal;
    begin
        /*
        TotalGSTAmt := 0;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
        IF SalesInvoiceLine.FINDSET THEN
            REPEAT
                TotalGSTAmt += SalesInvoiceLine."Total GST Amount";  //PRU SH
            UNTIL SalesInvoiceLine.NEXT = 0;
            */
        // calculate gst amount
        IGST_perc := 0;
        IGST_Amt := 0;
        CGST_perc := 0;
        CGST_Amt := 0;
        SGST_perc := 0;
        SGST_Amt := 0;
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
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
        TotalGSTAmt := IGST_Amt + CGST_Amt + SGST_Amt;
        IF TotalGSTAmt <> 0 THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    local procedure NonGSTApplicableTransfer(TransferShipmentHeader: Record 5744): Boolean
    var
        TransferShipmentLine: Record 5745;
        TotalGSTAmtTransfer: Decimal;
    begin
        /*
        TotalGSTAmtTransfer := 0;
        TransferShipmentLine.RESET;
        TransferShipmentLine.SETRANGE(TransferShipmentLine."Document No.", TransferShipmentHeader."No.");
        IF TransferShipmentLine.FINDSET THEN
            REPEAT
            //  TotalGSTAmtTransfer += TransferShipmentLine."Total GST Amount";  //PRU SH
            UNTIL TransferShipmentLine.NEXT = 0;
            */
        // calculate gst amount
        IGST_perc := 0;
        IGST_Amt := 0;
        CGST_perc := 0;
        CGST_Amt := 0;
        SGST_perc := 0;
        SGST_Amt := 0;
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document No.", TransferShipmentHeader."No.");
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
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
        TotalGSTAmtTransfer := IGST_Amt + CGST_Amt + SGST_Amt;

        IF TotalGSTAmtTransfer <> 0 THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;
}

