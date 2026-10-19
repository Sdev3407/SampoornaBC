report 50085 "Import Freight Discount"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Import Freight Discount';
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
            ExcelBuffer.AddColumn('Customer Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Item Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('UOM', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Starting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('Ending Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow;
            FreightDiscount.RESET;
            IF FreightDiscount.FINDSET THEN
                REPEAT
                    ExcelBuffer.AddColumn(FreightDiscount."Customer Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(FreightDiscount."Item No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(FreightDiscount.Amount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(FreightDiscount.UOM, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(FreightDiscount."Starting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(FreightDiscount."Ending Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.NewRow;
                UNTIL FreightDiscount.NEXT = 0;
            ExcelBuffer.CreateNewBook('GC Statement');
            ExcelBuffer.WriteSheet('GC Statement', CompanyName, UserId);
            ExcelBuffer.CloseBook();
            ExcelBuffer.SetFriendlyFilename(StrSubstNo('GC Statement', CurrentDateTime, UserId));
            ExcelBuffer.OpenExcel();
            ////  ExcelBuffer.CreateNewBook('GC Statement');
            ////  ExcelBuffer.WriteSheet('GC Statement', CompanyName, UserId);
            ////  ExcelBuffer.OpenExcel();
            //ExcelBuffer.CreateBookAndOpenExcel('', 'GC Statement', ' ', COMPANYNAME, USERID);
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
        FreightDiscount: Record 50037;
        Text000: Label '&Import,&Export';
        Selection: Integer;
        ExcelBuffer: Record 370 temporary;
        FreightDiscount1: Record 50037;
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
        FreightDiscount.RESET;
        FreightDiscount.INIT;
        EVALUATE(FreightDiscount."Customer Code", GetValueAtCell(RowNo, 1));
        EVALUATE(FreightDiscount."Item No.", GetValueAtCell(RowNo, 2));
        IF GetValueAtCell(RowNo, 3) <> '' THEN
            EVALUATE(FreightDiscount.Amount, GetValueAtCell(RowNo, 3));
        EVALUATE(FreightDiscount.UOM, GetValueAtCell(RowNo, 4));
        EVALUATE(FreightDiscount."Starting Date", GetValueAtCell(RowNo, 5));
        EVALUATE(FreightDiscount."Ending Date", GetValueAtCell(RowNo, 6));
        NewEndingDate := FreightDiscount."Starting Date";
        FreightDiscount1.RESET;
        FreightDiscount1.SETRANGE(FreightDiscount1."Customer Code", GetValueAtCell(RowNo, 1));
        FreightDiscount1.SETRANGE(FreightDiscount1."Item No.", GetValueAtCell(RowNo, 2));
        FreightDiscount1.SETRANGE(FreightDiscount1.UOM, GetValueAtCell(RowNo, 4));
        FreightDiscount1.SETFILTER(FreightDiscount1."Starting Date", '<>%1', 0D);
        IF FreightDiscount1.FINDLAST THEN BEGIN
            //FreightDiscount1."Ending Date" := (NewEndingDate - 1);
            // FreightDiscount1.MODIFY;
        END;
        FreightDiscount.INSERT;
    end;
}

