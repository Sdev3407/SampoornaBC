report 50084 "Import Sales Line Discount"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Import Sales Line Discount';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("integer"; 2000000026)
        {
            MaxIteration = 1;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF ServerFileName = '' THEN
            EXIT;
        MESSAGE('Import Completed.');
    end;

    trigger OnPreReport()
    begin

        Selection := STRMENU(Text000, 3);
        IF Selection = 1 THEN BEGIN
            ServerFileName := FileMgt.UploadFile(Text002, ExcelExtensionTok);
            IF ServerFileName = '' THEN
                EXIT;
            SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
            IF SheetName = '' THEN
                EXIT;
            ExcelBufferDialogMgt.Open(Text003);
            ExcelBuf.LOCKTABLE;
            ExcelBuf.OpenBook(ServerFileName, SheetName);
            ExcelBuf.ReadSheet;
            GetLastRowandColumn;
            FOR x := 2 TO TotalRows DO BEGIN
                InsertDataHeader(x);
            END;
            ExcelBuf.DELETEALL;
            ExcelBufferDialogMgt.Close;
        END ELSE BEGIN
            ExcelBuffer.AddColumn('Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Sales Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Currency Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Starting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Line Discount %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Sales Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Minimum Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Ending Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Unit of Measure Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Variant Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow;
            SalesLineDiscount.RESET;
            IF SalesLineDiscount.FINDSET THEN
                REPEAT
                    ExcelBuffer.AddColumn(SalesLineDiscount.Code, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Sales Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Currency Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Starting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Line Discount %", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Sales Type", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Minimum Quantity", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Ending Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount.Type, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Unit of Measure Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Variant Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(SalesLineDiscount."Line Discount Amount", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.NewRow;
                UNTIL SalesLineDiscount.NEXT = 0;
            // ExcelBuffer.CreateBookAndOpenExcel('', 'Sales Line Discount', ' ', COMPANYNAME, USERID);
            ExcelBuffer.CreateNewBook('Sales Line Discount');
            ExcelBuffer.WriteSheet('Sales Line Discount', CompanyName, UserId);
            ExcelBuffer.CloseBook();
            ExcelBuffer.SetFriendlyFilename(StrSubstNo('Sales Line Discount', CurrentDateTime, UserId));
            ExcelBuffer.OpenExcel();

        END;

    end;

    var
        ImportOption: Option;
        ServerFileName: Text[250];
        SheetName: Text[250];
        FileMgt: Codeunit 419;
        ExcelBuf: Record 370;
        Window: Dialog;
        TotalColumns: Integer;
        TotalRows: Integer;
        Text001: Label 'Import From Excel';
        Text002: Label 'Import Excel File';
        x: Integer;
        PH: Record 38;
        PL: Record 39;
        "Purch&Paysetup": Record 312;
        NoSeriesManagement: Codeunit 396;
        no: Code[20];
        Qty: Decimal;
        ExtDocNo: Code[20];
        check: Code[20];
        ShortcutDimCode: array[8] of Code[20];
        Lineno: Integer;
        ExcelBufferDialogMgt: Codeunit 5370;
        Text003: Label 'Importing File From Path';
        LineNo1: Integer;
        AssemblyLine: Record 901;
        AssemblyNo: Code[20];
        PreviousLineNo: Integer;
        ExcelExtensionTok: Label '.csv', Locked = true;
        SalesLineDiscount: Record 7004;
        Text000: Label '&Import,&Export';
        Selection: Integer;
        ExcelBuffer: Record 370 temporary;
        SalesLineDiscount1: Record 7004;
        NewEndingDate: Date;


    procedure GetLastRowandColumn()
    begin
        ExcelBuf.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuf.COUNT;
        ExcelBuf.RESET;
        IF ExcelBuf.FINDLAST THEN
            TotalRows := ExcelBuf."Row No.";
    end;


    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        ExcelBuf1: Record 370;
    begin
        IF ExcelBuf1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuf1."Cell Value as Text")
        ELSE
            ExcelBuf1."Cell Value as Text" := '';
    end;


    procedure InsertDataHeader(RowNo: Integer)
    var
        PD: Date;
        DD: Date;
        Line_NO: Integer;
        QtyPer: Decimal;
    begin
        NewEndingDate := 0D;
        if GetValueAtCell(RowNo, 7) <> '' then
            EVALUATE(QtyPer, GetValueAtCell(RowNo, 7));
        SalesLineDiscount.INIT;
        EVALUATE(SalesLineDiscount.Code, GetValueAtCell(RowNo, 1));
        EVALUATE(SalesLineDiscount."Sales Code", GetValueAtCell(RowNo, 2));
        EVALUATE(SalesLineDiscount."Currency Code", GetValueAtCell(RowNo, 3));
        EVALUATE(SalesLineDiscount."Starting Date", GetValueAtCell(RowNo, 4));
        if GetValueAtCell(RowNo, 5) <> '' then
            EVALUATE(SalesLineDiscount."Line Discount %", GetValueAtCell(RowNo, 5));
        EVALUATE(SalesLineDiscount."Sales Type", GetValueAtCell(RowNo, 6));
        if GetValueAtCell(RowNo, 7) <> '' then
            EVALUATE(SalesLineDiscount."Minimum Quantity", GetValueAtCell(RowNo, 7));
        EVALUATE(SalesLineDiscount."Ending Date", GetValueAtCell(RowNo, 8));
        EVALUATE(SalesLineDiscount.Type, GetValueAtCell(RowNo, 9));
        EVALUATE(SalesLineDiscount."Unit of Measure Code", GetValueAtCell(RowNo, 10));
        EVALUATE(SalesLineDiscount."Variant Code", GetValueAtCell(RowNo, 11));
        if GetValueAtCell(RowNo, 12) <> '' then
            EVALUATE(SalesLineDiscount."Line Discount Amount", GetValueAtCell(RowNo, 12));
        NewEndingDate := ((SalesLineDiscount."Starting Date") - 1);
        SalesLineDiscount1.RESET;
        SalesLineDiscount1.SETRANGE(SalesLineDiscount1.Code, GetValueAtCell(RowNo, 1));
        SalesLineDiscount1.SETRANGE(SalesLineDiscount1."Sales Code", GetValueAtCell(RowNo, 2));
        SalesLineDiscount1.SETRANGE(SalesLineDiscount1."Unit of Measure Code", GetValueAtCell(RowNo, 10));
        SalesLineDiscount1.SETFILTER(SalesLineDiscount1."Starting Date", '<>%1', 0D);
        IF SalesLineDiscount1.FINDLAST THEN BEGIN
            SalesLineDiscount1."Ending Date" := NewEndingDate;
            SalesLineDiscount1.MODIFY;
        END;
        SalesLineDiscount.INSERT;
    end;
}

